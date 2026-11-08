import 'package:pyro_central_database_protocol/pyro_central_database_protocol.dart';

/// 系统中央数据库定位与注册中枢 (CentralDatabaseHub 单例)
class CentralDatabaseHub {
  CentralDatabaseHub._();

  static final CentralDatabaseHub instance = CentralDatabaseHub._();

  final Map<String, CentralDatabaseAdapter> _adapters = {};

  /// 注册中央数据库适配器驱动
  void register(CentralDatabaseAdapter adapter) {
    _adapters[adapter.moduleId] = adapter;
  }

  /// 移除注册
  void unregister(String moduleId) {
    _adapters.remove(moduleId);
  }

  /// 获取特定模块标识的适配器
  CentralDatabaseAdapter? getAdapter(String moduleId) {
    return _adapters[moduleId];
  }

  /// 获取所有已注册的适配器列表
  List<CentralDatabaseAdapter> get allAdapters => _adapters.values.toList();

  /// 清空注册表 (常用于测试重置)
  void clear() {
    _adapters.clear();
  }
}
