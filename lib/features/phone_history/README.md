# 通话记录集成指南

本文档提供了如何将 `CallLogRecorder` 集成到现有系统中的详细说明，以实现通话记录的本地保存功能。

## 概述

`CallLogRecorder` 是一个桥接类，负责将通话处理系统（`CallHandler`）与通话日志服务（`CallLogService`）连接起来。它将通话数据转换为通话记录并保存到本地数据库，支持记录来电、去电、拒接和拦截通话。

## 文件结构

- `call_log_recorder.dart` - 核心记录器类，负责将通话数据转换为通话记录并保存
- `call_log_recorder_provider.dart` - 依赖注入提供者，用于注册和获取 CallLogRecorder 实例
- `caller_id_handler_extension.dart` - 扩展现有通话处理类，添加通话记录功能
- `call_log_integration_example.dart` - 集成示例，展示如何在现有代码中使用 CallLogRecorder


## 集成步骤

### 1. 注册 CallLogRecorder

在 `provider_config.dart` 中添加 CallLogRecorder 的初始化和注册：

```dart
// 初始化 CallLogRecorder
final callLogRecorder = CallLogRecorder(callLogService);

// 在提供者列表中添加 CallLogRecorder
Provider<CallLogRecorder>.value(value: callLogRecorder),
```

### 2. 在通话处理类中使用 CallLogRecorder

在 `IncomingCallHandler`、`OutgoingCallHandler` 和 `EndCallHandler` 中使用 CallLogRecorder 记录通话：

```dart
// 获取 CallLogRecorder 实例
final callLogRecorder = Provider.of<CallLogRecorder>(context, listen: false);

// 记录来电
await callLogRecorder.recordIncomingCall(phoneNumber, callData, accepted);

// 记录去电
await callLogRecorder.recordOutgoingCall(phoneNumber, callData);

// 记录拒接来电
await callLogRecorder.recordRejectedCall(phoneNumber, callData);

// 记录拦截来电
await callLogRecorder.recordBlockedCall(phoneNumber, callData);
```

### 3. 使用扩展方法简化集成

可以使用 `caller_id_handler_extension.dart` 中定义的扩展方法简化集成：

```dart
// 记录来电
await incomingCallHandler.recordIncomingCall(phoneNumber, callData, true, callLogRecorder);

// 记录去电
await outgoingCallHandler.recordOutgoingCall(phoneNumber, callData, callLogRecorder);

// 记录拒接来电
await incomingCallHandler.recordRejectedCall(phoneNumber, callData, callLogRecorder);

// 记录拦截来电
await incomingCallHandler.recordBlockedCall(phoneNumber, callData, callLogRecorder);
```

## 注意事项

1. 所有通话记录处理都在本地进行，不涉及网络请求，避免敏感权限问题。
2. 通话记录使用 `CallLog` 类存储，包含电话号码、时间戳、SIM卡信息和标签等信息。
3. 标签信息从 `CallData` 的 `callerIdData.labels` 中提取，使用标签的 `label` 属性作为标识符。
4. 通话记录通过 `CallLogService` 的 `addLog` 方法保存到本地数据库。

## 示例代码

请参考 `call_log_integration_example.dart` 文件，了解如何在现有代码中集成 CallLogRecorder。

## 数据流

1. 通话处理系统（`CallHandler`）处理通话并生成 `CallData`
2. `CallLogRecorder` 将 `CallData` 转换为 `CallLog`
3. `CallLogService` 将 `CallLog` 保存到本地数据库
4. 应用可以通过 `CallLogService` 的 `logsStream` 监听通话记录的变化