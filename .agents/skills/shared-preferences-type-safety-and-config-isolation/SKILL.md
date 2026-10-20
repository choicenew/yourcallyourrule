---
name: shared-preferences-type-safety-and-config-isolation
description: SharedPreferences 键名类型安全与 config_ 通配符前缀隔离避坑指南。深入分析 Android 原生 SharedPreferencesImpl ClassCastException 强转崩溃成因、Flutter 跨语言 MethodChannel 异常传导机制、ConfigCloudConverter 键名扫描冲突以及基于强类型 JSON 对象 (saveConfig) 与 Key 隔离避坑最佳实践。
---

# SharedPreferences 键名类型安全与 config_ 通配符前缀隔离避坑指南

> **核心摘要**：本 SKILL 总结了 Flutter 应用在 Android 原生平台使用 `shared_preferences` 时，由于原生底层存储类型（Boolean vs String）与全局配置转换器（`ConfigCloudConverter`）通配符扫描碰撞引发的死循环复现问题、底层原理解析以及标准工程架构避坑规范。

---

## 一、 真实事故现象与诊断复盘 (Incident Post-Mortem)

### 事故现象
用户在应用中完成 Onboarding（引导页）和 Initial Setup（初始规则设置）后，将 App 划掉（杀掉后台进程）并重新打开。即使在等待数据刷盘后重启，应用依然**反复死循环弹出 Onboarding 和 Initial Setup 界面**，导致引导状态永久无法保持。

### 根因全链路解析 (Full-Chain Failure Analysis)

```
┌─────────────────────────────────────────────────────────────────────────┐
│ 1. 用户点击“完成引导”                                                    │
│    -> OnboardingService 调用 prefs.setBool('config_has_completed...', true) │
│    -> Android 原生 mMap 写入 java.lang.Boolean 对象                         │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 2. 用户划掉杀进程，重新打开 App (冷启动)                                  │
│    -> main.dart 初始化 DatabaseService / DeviceIdService / Sync           │
│    -> 激活 ConfigCloudConverter.getAllConfigKeys()                        │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 3. 键名前缀扫描碰撞                                                      │
│    -> ConfigCloudConverter 扫描 key.startsWith('config_')                │
│    -> 匹配到 'config_has_completed_onboarding'                            │
│    -> 调用 SharedPreferencesConfigRepository.getConfig(key)             │
│    -> 底层执行 prefs.getString('config_has_completed_onboarding')         │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 4. Android 原生 JVM 强转崩溃                                             │
│    -> SharedPreferencesImpl.java 执行 (String) mMap.get(key)             │
│    -> 抛出 java.lang.ClassCastException: Boolean cannot be cast to String│
│    -> 跨 MethodChannel 传导为 Dart 的 PlatformException                  │
└────────────────────────────────────┬────────────────────────────────────┘
                                     │
                                     ▼
┌─────────────────────────────────────────────────────────────────────────┐
│ 5. SplashScreen 归零重置                                                │
│    -> SplashScreen._checkOnboardingAndSetupStatus 捕获异常               │
│    -> 掉入 catch (e) 兜底：重置 _isOnboardingCompleted = false            │
│    -> 路由强行将用户重定向到 Onboarding 页面                                 │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 二、 关键技术原理解析 (Underlying Technical Mechanics)

### 1. Android 原生 SharedPreferencesImpl 的强转机制
Android SDK 的原生 `SharedPreferencesImpl.java` 在内存中使用 `HashMap<String, Object> mMap` 存放所有的 Key-Value 对。

在 `getString` 的原生实现中：
```java
// Android AOSP 源码：android.app.SharedPreferencesImpl
public String getString(String key, @Nullable String defValue) {
    synchronized (mLock) {
        awaitLoadedLocked();
        String v = (String) mMap.get(key); // 🚨 强行无保护强转！
        return (v != null) ? v : defValue;
    }
}
```
* 当使用 `setBool` 保存时，`mMap` 中存入的是 `java.lang.Boolean`。
* 当调用 `getString` 读取时，Java 字节码指令 `checkcast` 执行 `(String) Boolean.TRUE`，**JVM 100% 抛出 `java.lang.ClassCastException`**。

### 2. 对比：为什么 `PurchaseState` 可以正常工作？
在项目中，`PurchaseState` 的保存代码如下：
```dart
// purchase_state.dart
await _configRepository.saveConfig(_isPurchasesEnabledKey, {'value': isPurchased});
```
`saveConfig` 底层处理：
```dart
// config_repository.dart
final jsonString = jsonEncode(config); // {'value': true} -> '{"value":true}'
await prefs.setString(key, jsonString); // 存入的是真实的 String 字符串！
```
* **结论**：`PurchaseState` 存入 SharedPreferences 的是 **JSON String**，因此 `ConfigCloudConverter` 用 `getString()` 去读取时返回 `'{"value":true}'`，可以完美解析为 Map，**绝不引发崩溃**。

---

## 三、 工程架构避坑与最佳实践规范 (Engineering Best Practices)

### 规范 1：配置型 Key 与状态型 Key 命名绝对隔离 (Key Prefix Isolation)

定义持久化键名时，**严禁混用前缀**：

| 前缀类型 | 推荐命名格式 | 适用存储接口 | 适用场景 |
| :--- | :--- | :--- | :--- |
| **云端/Repository 配置 Key** | `config_xxx` | `ConfigRepository.saveConfig` / `SharedPreferencesAsync` | VIP 状态、拦截过滤规则、自动化更新设置（内部为 JSON Map 对象） |
| **应用独立偏好 Key** | `app_xxx` 或 `user_xxx` | `prefs.setBool` / `prefs.setInt` / `prefs.setString` | Onboarding 引导完成标志、首次启动标志、冷启动计数器 |

**正例**：
```dart
class AppPrefsKeys {
  AppPrefsKeys._();

  // 1. 独立应用标志（用 app_ 前缀，隔离 config_ 通配符扫描）
  static const String firstLaunch = 'app_first_launch';
  static const String hasCompletedOnboarding = 'app_has_completed_onboarding';
  static const String hasCompletedInitialSetup = 'app_has_completed_initial_setup';

  // 2. Repository 级全局配置（用 config_ 前缀，供 ConfigCloudConverter 管理）
  static const String supabaseSettings = 'config_supabase_settings';
  static const String callerIdConfig = 'config_caller_id_settings';
}
```

---

### 规范 2：统一存储协议，禁绝“同一 Key 混合覆写” (No Conflicting Double-Writes)

**严禁**对同一个 Key 既调用 `saveConfig` 又调用 `prefs.setBool`：

```dart
// ❌ 错误示范：二重覆写会导致在 SharedPreferences 中原生类型被后者直接冲刷掉
await _configRepository.saveConfig(key, {'value': true}); 
await prefs.setBool(key, true); // 🚨 覆盖掉了上面的 JSON String，重新变回原生的 bool！
```

**正确示范**（方案二选一，保持全模块统一）：

#### 选项 A：使用标准 JSON Map 对象（与 PurchaseState 保持一致）
```dart
// 写入
await _configRepository.saveConfig(AppPrefsKeys.hasCompletedOnboarding, {'value': true});

// 读取
final config = await _configRepository.getConfig(AppPrefsKeys.hasCompletedOnboarding);
final isCompleted = config?['value'] as bool? ?? false;
```

#### 选项 B：使用独立前缀 + 原生 bool 读写
```dart
// 写入
final prefs = await SharedPreferences.getInstance();
await prefs.setBool(AppPrefsKeys.hasCompletedOnboarding, true);

// 读取（万能容错）
final prefs = await SharedPreferences.getInstance();
final val = prefs.get(AppPrefsKeys.hasCompletedOnboarding);
if (val is bool) return val;
if (val is String) return val.toLowerCase().trim() == 'true';
return false;
```

---

### 规范 3：SplashScreen 开屏页路由跳转单向收敛断言

开屏页（`SplashScreen`）的最终路由判断，应收敛为**无干扰依赖的判定树**：

```dart
Future<void> _navigateToNextScreen() async {
  if (!mounted || _hasNavigated) return;
  _hasNavigated = true;

  try {
    if (!_isOnboardingCompleted) {
      GoRouter.of(context).goNamed(AppRouter.onboarding);
    } else if (!_isInitialSetupCompleted) {
      GoRouter.of(context).goNamed(AppRouter.initialSetup);
    } else {
      GoRouter.of(context).goNamed(AppRouter.home); // 只要前置均完成，100% 直达主页
    }
  } catch (e) {
    debugPrint('导航失败: $e');
  }
}
```

---

## 四、 自动化校验与回归测试协议 (Regression Testing SOP)

在修改任何状态持久化或 SharedPreferences Key 之后，必须运行以下集成测试确保零回归：

```powershell
# 在命令行使用 Flutter CLI 运行 E2E 视图集成与路由状态机测试
flutter test test/integration/full_onboarding_and_setup_e2e_test.dart test/unit/splash_routing_decision_test.dart
```

**断言通过标准**：
1. 全全新环境：Splash $\rightarrow$ Onboarding $\rightarrow$ InitialSetup $\rightarrow$ Home 链条通畅。
2. 重启模拟环境（杀进程重新进入）：Splash 读取状态 $\rightarrow$ 直达 Home 主页，不弹出引导或设置页。
3. 检查控制台绝对无 `ClassCastException` 或 `type 'bool' is not a subtype of type 'String?'` 的异常日志。
