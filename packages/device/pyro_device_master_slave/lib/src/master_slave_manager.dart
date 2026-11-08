import 'dart:async';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';

/// 主从设备管理驱动类 (MasterSlaveManager)
class MasterSlaveManager implements MasterSlaveAdapter {
  DeviceNode _localNode;
  final Map<String, DeviceNode> _clusterNodes = {};
  final StreamController<List<DeviceNode>> _clusterStreamController = StreamController.broadcast();

  MasterSlaveManager({
    required DeviceNode localNode,
  }) : _localNode = localNode {
    _clusterNodes[localNode.deviceId] = localNode;
  }

  Stream<List<DeviceNode>> get clusterStream => _clusterStreamController.stream;

  @override
  String get moduleId => 'default_master_slave_driver';

  @override
  Future<bool> initialize() async => true;

  @override
  Future<DeviceNode> getLocalNode() async => _localNode;

  @override
  Future<List<DeviceNode>> getActiveClusterNodes() async => _clusterNodes.values.toList();

  @override
  Future<bool> setDeviceRole(String deviceId, DeviceRole role) async {
    if (_clusterNodes.containsKey(deviceId)) {
      final updated = _clusterNodes[deviceId]!.copyWith(role: role);
      _clusterNodes[deviceId] = updated;
      if (deviceId == _localNode.deviceId) {
        _localNode = updated;
      }
      _clusterStreamController.add(_clusterNodes.values.toList());
      return true;
    }
    return false;
  }

  /// 物理管制：只有主设备 (Master) 允许进行数据库初始化；从设备 (Slave) 严禁重复初始化
  @override
  Future<bool> isDatabaseInitializationAllowed() async {
    return _localNode.canInitializeDatabase;
  }

  /// 发现/更新集群中的某个节点
  void updateClusterNode(DeviceNode node) {
    _clusterNodes[node.deviceId] = node;
    _clusterStreamController.add(_clusterNodes.values.toList());
  }

  void dispose() {
    _clusterStreamController.close();
  }
}
