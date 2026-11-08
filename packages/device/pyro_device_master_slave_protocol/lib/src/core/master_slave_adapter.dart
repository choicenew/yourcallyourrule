import '../models/device_node.dart';

/// 主从设备管理抽象适配器接口 (MasterSlaveAdapter)
abstract class MasterSlaveAdapter {
  String get moduleId;

  /// 获取当前本机设备节点
  Future<DeviceNode> getLocalNode();

  /// 获取集群全量活跃设备节点列表
  Future<List<DeviceNode>> getActiveClusterNodes();

  /// 手动将指定设备设置为 Master (主设备) 或 Slave (从设备)
  Future<bool> setDeviceRole(String deviceId, DeviceRole role);

  /// 检查当前设备是否被允许执行数据库初始化操作
  Future<bool> isDatabaseInitializationAllowed();

  /// 初始化节点管理
  Future<bool> initialize();
}
