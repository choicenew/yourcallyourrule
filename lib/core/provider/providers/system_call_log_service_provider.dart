import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/system_call_log_service.dart';

/// 系统通话记录服务提供者
/// 提供SystemCallLogService实例
final systemCallLogServiceProvider = Provider<SystemCallLogService>(
  (ref) {
    // 获取CallLogService实例
    final callLogService = ref.watch(callLogServiceProvider);
    
    // 创建并返回SystemCallLogService实例
    return SystemCallLogService(callLogService);
  },
);