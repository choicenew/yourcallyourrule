# Pyro Hetu Script Engine (`pyro_hetu_script_engine`)

Pyro 针对 Aura 动态插件与沙盒执行设计的轻量脚本引擎。基于官方现代河图（[hetu_script](https://github.com/hetu-script/hetu-script)）核心构建，采用 **0-eval 纯预编译二进制字节码 (Bytecode Precompilation)** 与 **Extension 模块化架构模式** 维护，脱离一切 `rootBundle` 与物理磁盘依赖，在全平台与后台 `Isolate` 副线程中实现 0 毫秒极速加载。

---

## 一、 核心架构设计 (0-eval Bytecode & Pure Memory Architecture)

为了实现移动端（Android / iOS）及后台子线程 (`Isolate`) 中的绝对稳定性与秒级冷启动，本引擎彻底消灭了运行期的 `eval`、`rootBundle` 和 `File` 物理磁盘读取，采用**静态编译期字节码预生成**架构：

```
┌─────────────────────────────────────────────────────────────┐
│                 0-eval 静态字节码构建流程 (Build Time)          │
├─────────────────────────────────────────────────────────────┤
│ 1. 自动扫描: lib/src/std/ 及 lib/src/sdk/ 下全部 .ht 脚本     │
│ 2. 工具编译: dart run tool/generate_builtin_modules.dart    │
│ 3. 产物生成: pyro_sdk_precompiled_modules.dart (Uint8List)   │
└──────────────────────────────┬──────────────────────────────┘
                               │ 纯内存直达
┌──────────────────────────────▼──────────────────────────────┐
│                 运行时秒级加载流程 (Runtime - 0ms)             │
├─────────────────────────────────────────────────────────────┤
│ 1. 0 词法分析 / 0 语法分析 / 0 毫秒开销                         │
│ 2. loadBytecode(bytes: Uint8List, module: 'module:xxx')     │
│ 3. 后台 Isolate 副线程完全兼容，零 Flutter ServicesBinding 依赖 │
└─────────────────────────────────────────────────────────────┘
```

---

## 二、 自动化预编译工具使用指南 (Developer SOP)

每当修改或新增 `lib/src/std/` 或 `lib/src/sdk/` 下的 `.ht` 内置标准库与 SDK 声明文件时，**必须运行自动生成工具**以更新预编译字节码字典：

```bash
# 在 packages/core/pyro_hetu_script_engine 目录下运行：
dart run tool/generate_builtin_modules.dart
```

### 工具自动化处理项：
1. **自动递归扫描** `std/` 与 `sdk/` 目录下全部 `.ht` 脚本源码。
2. **在构建期启动 Hetu 编译器**将脚本直接压成二进制字节码数组（`Uint8List`）。
3. **自动绑定全量系统别名 URI**（例如 `module:host_webview` -> `module:webview`，`module:location` -> `module:device`）。
4. **生成 `pyro_sdk_precompiled_modules.dart`** 纯内存字典。

---

## 三、 扩展模块说明

| 扩展名 | 作用目标 | 核心功能 |
| :--- | :--- | :--- |
| `PyroHetuConfigExtension` | `HetuConfig` | 工厂化构建生产/调试模式配置，禁用原生 print，接入自定义 `PyroHetuLogger` |
| `PyroHetuBindingExtension` | `Hetu` | 解耦注册 Base32, Crypto, Regex, Webview, User, Storage 等全部 Std 与 SDK 类 |
| `PyroHetuModuleLoaderExtension` | `Hetu` | 0-eval 纯预编译二进制字节码加载，脱离 `rootBundle` / `File` 依赖，完全兼容 Isolate |
| `PyroHetuInvocationExtension` | `Hetu` | 透传河图机制，提供异步 `invokeAsync`、`defineValue`、`fetchValue` |
| `PyroHetuStructExtension` | `HTStruct` | 现代化操作河图结构体，支持 `toDartMap()`、`getField<T>()`、`assignFromMap()` |

---

## 四、 使用示例

### 1. 使用标准 Facade 门面 (`PyroHetuEngine`)

```dart
import 'package:pyro_hetu_script_engine/pyro_hetu_script_engine.dart';

final engine = PyroHetuEngine(
  webViewDelegate: myWebViewDelegate,
  userDelegate: myUserDelegate,
  configDelegate: myConfigDelegate,
  storageDelegate: myStorageDelegate,
  translationDelegate: myTranslationDelegate,
);

// 1. 初始化绑定与 0-eval 预编译字节码标准库 (0 毫秒装载)
await engine.init();

// 2. 评估执行插件脚本
engine.eval('''
  import 'module:http' as http;
  import 'module:host_webview' as webview;
  // 字节码模块零开销精准引用
''');

// 3. 异步 Hook 安全调用
final result = await engine.invokeAsync('search', positionalArgs: ['naruto', 1]);
```

---

## 五、 后续交接与维护规约 (Handover & Maintenance SOP)

当后续开发者接手本引擎模块时，请严格遵守以下规则：

1. **修改 `.ht` 标准库/SDK 后**：切记在终端执行 `dart run tool/generate_builtin_modules.dart` 重新刷新字节码字典，严禁手抄或硬编码字节码。
2. **严禁引入 `rootBundle` / `File`**：`PyroHetuModuleLoaderExtension` 必须保持纯内存（`PyroSdkPrecompiledModules.bytecodes`）加载，防止安卓/iOS/Isolate 环境下因缺失 UI Binding 抛出 `Binding has not yet been initialized` 导致挂掉。
3. **第三方库源码不动原则**：严禁随意修改外部依赖库（如 `hetu_script`）的原始绑定代码。遇到问题优先在宿主引擎绑定逻辑中做安全判空与降级包装。
