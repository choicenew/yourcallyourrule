import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/services/background_sync_service.dart';

/// 后台同步服务提供者
/// 提供BackgroundSyncService实例
final backgroundSyncServiceProvider = Provider<BackgroundSyncService>(
  (ref) {
    // 创建BackgroundSyncService实例
    final syncService = BackgroundSyncService();
    
    // 在ref被释放时释放资源
    ref.onDispose(() {
      // 目前BackgroundSyncService没有需要释放的资源
      // 但保留此处以便将来扩展
    });
    
    return syncService;
  },
);

/// 后台同步初始化提供者
/// 用于在应用启动时初始化后台同步服务
final backgroundSyncInitProvider = FutureProvider<void>(
  (ref) async {
    // 获取BackgroundSyncService实例
    final syncService = ref.watch(backgroundSyncServiceProvider);
    
    // 初始化同步服务
    await syncService.initialize();
  },
);