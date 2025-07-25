import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/system_call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_sync_service.dart';

/// 通话记录同步服务提供者
/// 提供CallLogSyncService实例
final callLogSyncServiceProvider = Provider<CallLogSyncService>(
  (ref) {
    // 获取SystemCallLogService实例
    final systemCallLogService = ref.watch(systemCallLogServiceProvider);
    
    // 创建CallLogSyncService实例
    final syncService = CallLogSyncService(systemCallLogService);
    
    // 在ref被释放时释放资源
    ref.onDispose(() {
      syncService.dispose();
    });
    
    return syncService;
  },
);

/// 通话记录同步初始化提供者
/// 用于在应用启动时初始化同步服务
final callLogSyncInitProvider = FutureProvider<void>(
  (ref) async {
    // 获取CallLogSyncService实例
    final syncService = ref.watch(callLogSyncServiceProvider);
    
    // 初始化同步服务
    await syncService.initialize();
  },
);