import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/caller_id/services/plugin_to_remote_sync_service.dart';
import 'caller_id_service_provider.dart';
import 'remote_number_service_provider.dart';

/// PluginToRemoteSyncService工厂Provider
/// 这个Provider不会立即创建服务实例，而是返回一个工厂函数
/// 当CallerIdService被使用时，可以通过这个工厂函数创建PluginToRemoteSyncService实例
final pluginToRemoteSyncServiceFactoryProvider = Provider<PluginToRemoteSyncServiceFactory>((ref) {
  return PluginToRemoteSyncServiceFactory(ref);
});

/// PluginToRemoteSyncService工厂类
/// 负责创建和管理PluginToRemoteSyncService实例
class PluginToRemoteSyncServiceFactory {
  final ProviderRef _ref;
  PluginToRemoteSyncService? _serviceInstance;
  
  PluginToRemoteSyncServiceFactory(this._ref);
  
  /// 获取或创建PluginToRemoteSyncService实例
  /// 如果实例已存在，则返回现有实例
  /// 如果实例不存在，则创建新实例并启动同步服务
  PluginToRemoteSyncService getOrCreateService() {
    if (_serviceInstance != null) {
      return _serviceInstance!;
    }
    
    final remoteNumberService = _ref.read(remoteNumberServiceProvider);
    final callerIdService = _ref.read(callerIdServiceProvider);
    
    // 创建服务实例
    final service = PluginToRemoteSyncService(remoteNumberService);
    
    // 启动同步服务，监听插件数据流和标签电话条目流
    service.startSync(
      callerIdService.pluginDataStream,
      callerIdService.labelPhoneEntryStream,
    );
    
    // 在Provider被释放时释放资源
    _ref.onDispose(() {
      service.dispose();
      _serviceInstance = null;
    });
    
    _serviceInstance = service;
    return service;
  }
}