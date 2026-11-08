import 'package:meta/meta.dart';
import 'package:pyro_user_database_protocol/pyro_user_database_protocol.dart';

/// 个人用户数据库服务定位与驱动注册中心 (User Database Hub)
class UserDatabaseHub {
  static UserDatabaseHub? _instance;
  final Map<String, SyncDataAdapter> _adapters = {};
  final Map<String, SyncServiceUIConfig> _uiConfigs = {};

  UserDatabaseHub._();

  /// 全局唯一单例入口
  static UserDatabaseHub get instance => _instance ??= UserDatabaseHub._();

  /// 测试与自定义覆盖用的重置接口
  @visibleForTesting
  static void reset() {
    _instance = null;
  }

  /// 注册特定的用户数据库驱动适配器
  void registerAdapter(SyncDataAdapter adapter) {
    _adapters[adapter.providerId] = adapter;
  }

  /// 移除驱动
  void unregisterAdapter(String providerId) {
    _adapters.remove(providerId);
  }

  /// 获取指定的驱动适配器
  SyncDataAdapter? getAdapter(String providerId) => _adapters[providerId];

  /// 获取当前所有可用的驱动 ID 列表
  List<String> get availableProviders => _adapters.keys.toList();

  /// 注册 UI 配置
  void registerUIConfig(String providerId, SyncServiceUIConfig config) {
    _uiConfigs[providerId] = config;
  }

  /// 获取 UI 配置
  SyncServiceUIConfig? getUIConfig(String providerId) => _uiConfigs[providerId];
}
