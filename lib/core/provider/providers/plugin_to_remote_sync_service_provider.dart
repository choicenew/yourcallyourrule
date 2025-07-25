import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/services/plugin_to_remote_sync_service.dart';
import 'caller_id_service_provider.dart';
import 'remote_number_service_provider.dart';

/// PluginToRemoteSyncService的Provider
final pluginToRemoteSyncServiceProvider = Provider<PluginToRemoteSyncService>((ref) {
  final remoteNumberService = ref.watch(remoteNumberServiceProvider);
  final callerIdService = ref.watch(callerIdServiceProvider);
  
  // 创建服务实例
  final service = PluginToRemoteSyncService(remoteNumberService);
  
  // 启动同步服务，监听插件数据流和标签电话条目流
  service.startSync(
    callerIdService.pluginDataStream,
    callerIdService.labelPhoneEntryStream,
  );
  
  // 在Provider被释放时释放资源
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});

/// PluginToRemoteSyncService初始化Provider
final pluginToRemoteSyncInitProvider = Provider<void>((ref) {
  // 触发服务初始化
  ref.watch(pluginToRemoteSyncServiceProvider);
  return null;
});