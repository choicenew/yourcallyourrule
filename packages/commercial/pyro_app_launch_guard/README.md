# Pyro App Launch Guard (`pyro_app_launch_guard`)

[![Pub Workspace](https://img.shields.io/badge/Pyro-Workspace-blue.svg)](https://github.com/haygcao)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

`pyro_app_launch_guard` 是 Pyro Workspace 架构下彻底解耦的**应用冷启动管线与开屏广告门禁微包**。

它遵从 **终极零侵入横插模式**，对主 App (`MyApp` / `MaterialApp`) 的编写方式 **零影响、零侵入**，直接在 `main()` 函数中间横插一句，即可自动接管冷启动/Splash/隐私引导与开屏广告 Waterfall。

---

## 🌟 零侵入横插设计 (Zero-Impact Design)

- **横插一句，前面无前缀，后面无后缀**：对 AI 或人类生成的 `MyApp`、`MaterialApp`、`routes` 毫无改动，任何 AI 都能 100% 顺畅维护。
- **100% 零循环依赖 (DAG)**：采用控制反转 (IoC) 与依赖倒置设计，微包绝对不反向依赖宿主 `pyro_magma` 或任何上层 UI 包。
- **5 步状态管线引擎**：
  1. **System Native Splash**：由 `flutter_adaptive_studio` 系统层原生呈图秒开。
  2. **Async Initializers**：异步任务并行跑（带 2.5s 硬超时保护，卡死自动放行）。
  3. **Onboarding & Legal Guard**：合规与引导页自动门禁，支持动态跳过或完成推送。
  4. **App Open Ad Waterfall**：开屏广告瀑布流自动加载展示（带 2.5s 超时兜底与 VIP 免广告联动）。
  5. **Seamless Handover**：开屏完毕后 Overlay 自动解挂，无缝暴露底层底层主 App。

---

## 🚀 接入方式 (One-Line Hook)

### 终极接入：横插一句 `PyroAppLaunchGuard.attach()`（推荐）

直接在 `main()` 函数中间横插一行代码，**对后面的 `runApp(const MyApp())` 零修改、零侵入**：

```dart
import 'package:flutter/material.dart';
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 就横插这一句！前面无前缀，后面无后缀，直接接管启动与开屏！
  PyroAppLaunchGuard.attach();

  // 后面的 MyApp / MaterialApp 完全按照 100% 标准习惯写，零改动：
  runApp(const MyApp());
}
```

---

## 🧪 单元测试

运行单元测试：

```bash
flutter test packages/commercial/pyro_app_launch_guard/test/pyro_app_launch_guard_test.dart
```

---

## 📄 架构协议合规

本微包严格遵循以下 Pyro 架构规范：
- `commercial_architecture_protocol` (商业化解耦层级)
- `package_architecture_protocol` (Protocol-Hub-Driver 拓扑规范)
- `decoupled_architecture_protocol` (宿主零逻辑空架子规范)
