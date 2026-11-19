---
name: pigeon-over-methodchannel-standard
description: 现代 Flutter/Android 原生通信架构标准：全面禁止使用动态弱类型 MethodChannel，强制推行官方 Pigeon 强类型代码生成、子包自闭环 consumerProguardFiles 防混淆体系及双端（Dart + Kotlin JVM）单元测试门禁协议。
---

# Pigeon 原生通信与自闭环驱动规范 (Pigeon Over MethodChannel Standard)

在现代跨平台应用架构中，Flutter 与 Android/iOS 宿主原生之间的通信通道是保障系统稳定性与数据安全性的核心基础设施。传统的 `MethodChannel` 采用弱类型字符串匹配与动态 Map 字典传递，在复杂的底层系统通信（如 Telephony、SMS、SIM、Tile、STIR/SHAKEN 等）中存在严重的类型擦除、运行时崩溃、R8/ProGuard 混淆阻断及难以实施单元测试等致命缺陷。

本规范**全面禁止在新模块中使用原始 `MethodChannel`**，并强制推行**基于官方 Pigeon 的强类型契约化生成、子包自闭环 `consumerProguardFiles` 精准防混淆规则及双端（Dart + Kotlin JVM）单元测试门禁体系**。

---

## 一、 为什么全面封禁原始 `MethodChannel`？

### 1. 动态字符串魔数与弱类型地狱
- **无编译期检查**：通道名、方法名（如 `"net.pyro.telephony/sim"`、`"getActiveSimCards"`）均为硬编码字符串。任何拼写错误、大小写偏差或方法未实现均只能在运行时抛出 `MissingPluginException` 或 `notImplemented`。
- **字典解构脆弱**：参数全部为 `Map<dynamic, dynamic>`，字段依赖 `call.argument<String>("key")` 取值。一旦跨语言两端字段拼写不一致，返回值为 `null`，导致静默失效或空指针闪退。

### 2. 生产环境 R8/ProGuard 混淆深坑
- 开启代码混淆和压缩后，Kotlin 端普通的实体类属性名常被优化重命名为 `a`, `b`, `c`。动态反射或字典映射机制将瞬间瘫痪，导致开发环境下完全正常、一旦打 Release 生产包就大面积 Crash。

### 3. 测试脱节与“黑盒调试”恶性循环
- 传统的 `MethodChannel` 强耦合 `BinaryMessenger` 与 Flutter 引擎底座，脱机环境下难以 Mock。在 Kotlin 端写单元测试需要 mock 大量 channel 回调，导致大部分插件原生端测试处于“真空”状态，所有验证被推迟到最后开模拟器/真机调试，排查成本被放大数十倍。

---

## 二、 核心三大工程铁律 (Three Golden Rules)

### 铁律一：单一真相源（Single Source of Truth, SSOT）
所有跨平台通信的数据载荷（Payload）、枚举（Enum）、宿主接口（HostApi，Dart 调 Native）与事件接口（FlutterApi，Native 调 Dart），**必须 100% 统一定义在对应驱动子包的 `pigeons/<module>_api.dart` 中**。
严禁手写任何跨语言通信通道胶水代码，严禁跨包私自篡改生成物。

### 铁律二：子模块自闭环混淆规则（Scoped consumerProguardFiles）
- 严禁在主 App 的 `proguard-rules.pro` 中为子模块盲目堆砌全局泛通配符（如 `-keep class com.pyro.** { *; }`），避免阻碍 R8 对无关代码的无用代码消除（Tree Shaking）；
- 每个独立的 Android 原生子模块，必须在自身根目录下创建 `consumer-rules.pro`，并在 `build.gradle` 中声明：
  ```groovy
  android {
      defaultConfig {
          consumerProguardFiles 'consumer-rules.pro'
      }
  }
  ```
- 混淆规则必须做到**精准外科手术式保留**，只 keep Pigeon 自动生成的实体、接口与 FlutterError：
  ```proguard
  -keep class com.pyro.<module>.Pigeon* { *; }
  -keep class com.pyro.<module>.*HostApi* { *; }
  -keep class com.pyro.<module>.*FlutterApi* { *; }
  -keep class com.pyro.<module>.FlutterError { *; }
  ```

### 铁律三：双端单元测试门禁协议（Dual-End Unit Test Protocol）
- **Dart 端**：必须在 `test/<module>_driver_test.dart` 中实现 Mock 的 `HostApi`，对接口调用、数据结构转换、枚举映射与异常捕获（`PlatformException`）进行 100% 覆盖。
- **Kotlin 原生端**：每个 Driver 必须配置纯 JVM 单元测试环境：
  ```groovy
  android {
      testOptions {
          unitTests.returnDefaultValues = true // 防止未 mock 的 Android 原生方法抛出 RuntimeException
      }
  }
  dependencies {
      testImplementation 'junit:junit:4.13.2'
  }
  ```
  在 `src/test/kotlin/` 编写脱机纯 JVM 测试，验证数据实体的 `toList()`/`fromList()` 序列化双向一致性以及关键数据转换逻辑。

---

## 三、 标准工程目录结构

每一个包含 Native 原生通信的 Driver 子包，必须严格遵循以下结构布局：

```text
packages/<domain>/pyro_<domain>_driver/
├── pigeons/
│   └── <domain>_api.dart                 # Pigeon 契约唯一定义源
├── lib/
│   ├── pyro_<domain>_driver.dart         # 统一导出库文件
│   └── src/
│       ├── <domain>_api.g.dart           # Pigeon 自动生成的 Dart 端通信代码
│       └── <domain>_driver.dart          # Driver 实现类，组装 Hub 接口与 HostApi
├── test/
│   └── <domain>_driver_test.dart         # Dart 端单元测试 (Mock HostApi)
├── pubspec.yaml                          # 声明依赖与 dev_dependencies (pigeon)
└── android/
    ├── build.gradle                      # 配置 consumerProguardFiles, testOptions, junit
    ├── consumer-rules.pro                # 模块精准防混淆规则
    └── src/
        ├── main/kotlin/com/pyro/<domain>/
        │   ├── <Domain>Api.g.kt          # Pigeon 自动生成的 Kotlin 接口与编解码器
        │   └── <Domain>DriverPlugin.kt   # 原生插件入口，实现 <Domain>HostApi
        └── test/kotlin/com/pyro/<domain>/
            └── <Domain>DriverTest.kt     # Kotlin 纯 JVM 单元测试
```

---

## 四、 实施标准操作流程 (SOP)

### 步骤 1：编写 Pigeon Schema 定义 (`pigeons/<domain>_api.dart`)
```dart
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/<domain>_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/pyro/<domain>/<Domain>Api.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.pyro.<domain>',
  ),
))
// 数据载荷：统一加 Pigeon 前缀规避与业务 Protocol 类重名
class Pigeon<Domain>Payload {
  String? id;
  int? timestampMs;
  bool? isSuccess;
}

// Dart 调 Native
@HostApi()
abstract class <Domain>HostApi {
  Pigeon<Domain>Payload executeAction(String actionKey);
  bool isServiceReady();
}

// Native 调 Dart (反向通知/广播)
@FlutterApi()
abstract class <Domain>FlutterApi {
  void onNativeEvent(Pigeon<Domain>Payload event);
}
```

### 步骤 2：生成双端代码
使用项目指定的统一 Dart 工具链执行生成：
```bash
dart run pigeon --input pigeons/<domain>_api.dart
```

### 步骤 3：Kotlin 原生插件实现
在 `android/src/main/kotlin/.../<Domain>DriverPlugin.kt` 中实现 `FlutterPlugin` 与生成的 `<Domain>HostApi`：
```kotlin
package com.pyro.<domain>

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class <Domain>DriverPlugin : FlutterPlugin, <Domain>HostApi {
    private var context: Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        <Domain>HostApi.setUp(binding.binaryMessenger, this)
    }

    override fun executeAction(actionKey: String): Pigeon<Domain>Payload {
        // 强类型处理，绝无动态 Map 转型崩溃
        return Pigeon<Domain>Payload(
            id = actionKey,
            timestampMs = System.currentTimeMillis(),
            isSuccess = true
        )
    }

    override fun isServiceReady(): Boolean {
        return context != null
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        <Domain>HostApi.setUp(binding.binaryMessenger, null)
        context = null
    }
}
```

> [!IMPORTANT]
> 如果有原生系统回调或广播（如 `NotificationListenerService`、`BroadcastReceiver`），触发 `FlutterApi` 时**必须切换到主线程 Looper**：
> ```kotlin
> android.os.Handler(android.os.Looper.getMainLooper()).post {
>     <Domain>FlutterApi(messenger).onNativeEvent(payload) { result ->
>         if (result.isFailure) {
>             Log.w(TAG, "Failed to deliver event: ${result.exceptionOrNull()?.message}")
>         }
>     }
> }
> ```

### 步骤 4：Dart 侧驱动与适配器组装
在 `lib/src/<domain>_driver.dart` 中，使用内部私有适配器隔离 Pigeon 监听方法，保持对外暴露的 Domain Adapter 接口纯洁：
```dart
import 'package:flutter/services.dart';
import '<domain>_api.g.dart';

class <Domain>Driver implements I<Domain>Adapter {
  final <Domain>HostApi _hostApi;
  _<Domain>FlutterApiHandler? _flutterApiHandler;

  <Domain>Driver({<Domain>HostApi? hostApi})
      : _hostApi = hostApi ?? <Domain>HostApi() {
    _flutterApiHandler = _<Domain>FlutterApiHandler(this);
    <Domain>FlutterApi.setUp(_flutterApiHandler);
  }

  void dispose() {
    <Domain>FlutterApi.setUp(null);
    _flutterApiHandler = null;
  }

  void _onReceivedEvent(Pigeon<Domain>Payload event) {
    // 转换为领域实体模型并通知 Hub
  }
}

class _<Domain>FlutterApiHandler implements <Domain>FlutterApi {
  final <Domain>Driver _driver;
  _<Domain>FlutterApiHandler(this._driver);

  @override
  void onNativeEvent(Pigeon<Domain>Payload event) {
    _driver._onReceivedEvent(event);
  }
}
```

### 步骤 5：双端单元测试编写与验证
1. **Dart 侧测试**：通过构造 `Mock<Domain>HostApi`，在几百毫秒内验证输入、输出契约与错误捕获。
2. **Kotlin 侧测试**：在 `src/test/kotlin/` 针对 Payload 的 `toList()` / `fromList()` 建立序列化一致性测试，确保基本类型映射与空安全逻辑正确。
3. **门禁校验**：运行 `dart analyze packages/<domain>/pyro_<domain>_driver`，确保 **0 Errors** 后方可提交。

---

## 五、 典型避坑指南 (Traps & Solutions)

| 陷阱场景 | 致命后果 | 标准避坑解法 |
| :--- | :--- | :--- |
| **实体类名称冲突** | Dart 不支持包内同名类，Pigeon 生成物与 Protocol 层的 Domain Entity 重名冲突导致编译失败。 | Pigeon 契约定义的所有数据类一律强制使用 `Pigeon` 前缀（如 `PigeonSimCard`、`PigeonSmsEvidence`）。 |
| **回调方法签名冲突** | 驱动所实现的 Adapter 接口带有 `onEvent(Function callback)`，与 Pigeon 的 `onEvent(PigeonPayload payload)` 重名。 | 驱动类不直接 `implements FlutterApi`，改用内部私有代理类 `_FlutterApiHandler` 接收原生回调，再中转到 Driver。 |
| **原生跨线程崩溃** | Android 系统通信常发生在 Binder 线程池，直接调用 Flutter 通信引发非主线程异常。 | 必须使用 `Handler(Looper.getMainLooper()).post { ... }` 包裹 `FlutterApi` 的调用。 |
| **过度依赖单测或过度迷信真机** | 认为“有单测就可以不测真机”，或“反正要测真机就不写单测”。 | 树立正确认知：**单测保内部计算与协议不出错，真机验 Android OS 权限/时序/Binder 是否打通**。漏斗式过滤，二者结合。 |
