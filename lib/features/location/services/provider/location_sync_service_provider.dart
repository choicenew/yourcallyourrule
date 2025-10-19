// 文件路径: lib/core/provider/providers/location_sync_service_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/location_service_provider.dart';
import 'package:yourcallyourrule/features/location/services/location_sync_service.dart';

/// LocationSyncService 的 Provider
/// 这个 Provider 负责创建 LocationSyncService 实例，并启动它。
final locationSyncServiceProvider = Provider<LocationSyncService>((ref) {
  // 依赖 CallerIdService 和 LocationService
  final callerIdService = ref.watch(callerIdServiceProvider);
  final locationService = ref.watch(locationServiceProvider);

  // 创建实例
  final syncService = LocationSyncService(callerIdService, locationService);

  // 【重要】: 立即启动监听服务
  syncService.start();

  // 当 Provider 被销毁时，自动调用 dispose 方法停止监听
  ref.onDispose(() => syncService.dispose());

  return syncService;
});