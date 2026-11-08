import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

/// 主从设备管理中枢 (DeviceMasterSlaveHub 单例)
class DeviceMasterSlaveHub {
  DeviceMasterSlaveHub._();

  static final DeviceMasterSlaveHub instance = DeviceMasterSlaveHub._();

  final Map<String, MasterSlaveAdapter> _adapters = {};

  void register(MasterSlaveAdapter adapter) {
    _adapters[adapter.moduleId] = adapter;
  }

  void unregister(String moduleId) {
    _adapters.remove(moduleId);
  }

  MasterSlaveAdapter? getAdapter(String moduleId) {
    return _adapters[moduleId];
  }

  List<MasterSlaveAdapter> get allAdapters => _adapters.values.toList();

  void clear() {
    _adapters.clear();
  }
}
