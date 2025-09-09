import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';

/// CallLogRecorder 的 Riverpod Provider
/// 用于获取 CallLogRecorder 实例
/// 使用 core/provider/providers/call_log_service_provider.dart 中的 callLogServiceProvider
final callLogRecorderProvider = Provider<CallLogRecorder>((ref) {
  final callLogService = ref.watch(callLogServiceProvider);
  return CallLogRecorder(callLogService);
});