# pyro_worker_protocol

零业务耦合的通用工作线程任务调度与长驻 Actor 底层协议契约包。

## 🏛️ 架构定位
本包是整个 Pyro 微包生态与主 App（`pyro_magma`）副线程调度的基石抽象契约（Hub-and-Spoke 体系最底层）：
1. **任务契约化**：提供 `WorkerTask<Input, Output>`，将一过性重计算（如加解密、XML解析、向量计算）抽象为无状态可序列化纯函数。
2. **重型长驻引擎 Actor 化**：提供 `DedicatedActorWorker<Req, Resp>`，将重量级模型（ONNX Runtime / 河图虚拟机）封闭在专属副线程中，对外提供 `ActorHandle` 管道。
3. **分层优先级管控**：支持 `TaskPriority.immediate`（交互插队）、`userInteractive`（界面计算）与 `background`（静默后台）。
4. **自适应中枢与主 App 深度接管**：
   - 默认自带 `DefaultAdaptiveWorkerDispatcher`，开箱即用，免配置通过 `Isolate.run` 与 `Isolate.spawn` 执行；
   - 允许主 App 在初始化时通过 `WorkerDispatcher.setInstance(...)` 注入全局唯一的设备感知线程池（`MagmaDeviceAwareWorkerPool`）。

## 📦 核心导出
```dart
import 'package:pyro_worker_protocol/pyro_worker_protocol.dart';

// 1. 提交一过性纯任务
final output = await WorkerDispatcher.instance.execute(myPureTask, myInput);

// 2. 挂载长驻 Actor 引擎
final handle = await WorkerDispatcher.instance.spawnActor(myDedicatedActor);
final resp = await handle.send(request);
await handle.dispose();
```

## ✅ 测试与构建状态
- 单测验证：`test/worker_protocol_test.dart` (All tests passed)
- 依赖属性：100% 零业务依赖，仅依赖 Flutter/Dart SDK 运行时。
