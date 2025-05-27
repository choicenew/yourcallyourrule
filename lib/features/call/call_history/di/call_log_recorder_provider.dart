import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/call_log_repository_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';

/// CallLogService 的 Riverpod Provider
/// 使用项目中已有的 CallLogRepository Provider 创建 CallLogService 实例
final callLogServiceProvider = riverpod.Provider<CallLogService>((ref) {
  final callLogRepository = ref.watch(callLogRepositoryProvider);
  return CallLogService(callLogRepository);
});

/// CallLogRecorder 的 Riverpod Provider
/// 用于在使用 Riverpod 的地方获取 CallLogRecorder 实例
final callLogRecorderProvider = riverpod.Provider<CallLogRecorder>((ref) {
  final callLogService = ref.watch(callLogServiceProvider);
  return CallLogRecorder(callLogService);
});

/// 创建 Provider 列表，用于在 Provider 包中注册 CallLogRecorder
/// 这个方法用于在使用 Provider 包的地方注册 CallLogRecorder
List<SingleChildStatelessWidget> getCallLogRecorderProviders(CallLogService callLogService) {
  return [
    Provider<CallLogRecorder>.value(
      value: CallLogRecorder(callLogService),
    ),
  ];
}