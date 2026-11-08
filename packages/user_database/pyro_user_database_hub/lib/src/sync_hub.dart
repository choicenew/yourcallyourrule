import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';

/// 统一的同步数据适配器与 Provider 实体注册中心（单例模式）。
class SyncHub {
  SyncHub._();

  /// 获取全局单例实例。
  static final SyncHub instance = SyncHub._();

  final Map<String, SyncDataAdapter<dynamic>> _adapters = {};
  final Map<Type, SyncProviderEntity> _providers = {};

  /// 注册同步数据适配器
  void registerAdapter(SyncDataAdapter<dynamic> adapter) {
    _adapters[adapter.moduleId] = adapter;
  }

  /// 注册 Provider 实体 (自注册入口，Key 为强类型 Class Token，0 字符串)
  void registerProvider(SyncProviderEntity provider) {
    _providers[provider.entityToken] = provider;
  }

  /// 向前兼容别名：注册适配器
  void register(SyncDataAdapter<dynamic> adapter, {dynamic uiConfig}) {
    registerAdapter(adapter);
    if (uiConfig is SyncProviderEntity) {
      registerProvider(uiConfig);
    }
  }

  /// 向前兼容别名：注册 UI 实体
  void registerUIConfig(String providerId, dynamic uiConfig) {
    if (uiConfig is SyncProviderEntity) {
      registerProvider(uiConfig);
    }
  }

  /// 根据 Class Token 获取已注册的 Provider 实体
  T? getProvider<T extends SyncProviderEntity>() {
    return _providers[T] as T?;
  }

  /// 获取所有已注册的 Provider 实体列表
  List<SyncProviderEntity> get registeredProviders => _providers.values.toList();

  /// 移除特定模块的同步数据适配器。
  void unregisterAdapter(String moduleId) {
    _adapters.remove(moduleId);
  }

  /// 向前兼容别名：取消注册
  void unregister(String moduleId) {
    unregisterAdapter(moduleId);
  }

  /// 清空所有注册状态
  void clear() {
    _adapters.clear();
    _providers.clear();
  }

  /// 获取当前所有已注册的数据模块 ID 列表。
  List<String> get registeredModuleIds => _adapters.keys.toList();

  /// 检查特定模块是否已经注册。
  bool isRegistered(String moduleId) => _adapters.containsKey(moduleId);

  /// 获取特定模块的同步数据适配器。
  SyncDataAdapter<T>? getAdapter<T>(String moduleId) {
    return _adapters[moduleId] as SyncDataAdapter<T>?;
  }
}
