// 文件路径: .../providers/call_log_recorder_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_recorder.dart';

// 【最终修复】导入 PredefinedLabelService 的 Provider
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

/// CallLogRecorder 的 Riverpod Provider
/// 用于获取 CallLogRecorder 实例
/// 使用 core/provider/providers/call_log_service_provider.dart 中的 callLogServiceProvider
final callLogRecorderProvider = Provider<CallLogRecorder>((ref) {
  // 1. 获取 CallLogService
  final callLogService = ref.watch(callLogServiceProvider);
  
  // 2. 【核心修改】获取 PredefinedLabelService
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);

  // 3. 【核心修改】将两个服务一起注入到 CallLogRecorder 的构造函数中
  return CallLogRecorder(callLogService, predefinedLabelService);
});