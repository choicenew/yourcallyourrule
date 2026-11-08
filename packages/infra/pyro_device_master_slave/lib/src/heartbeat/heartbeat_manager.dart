import 'dart:async';
import '../models/device_node.dart';

/// 心跳感知与超时漂移监听器
class HeartbeatManager {
  final String localDeviceId;
  final Duration timeoutThreshold;
  final Map<String, DeviceNode> _nodes = {};
  final StreamController<List<DeviceNode>> _topologyController = StreamController.broadcast();

  HeartbeatManager({
    required this.localDeviceId,
    this.timeoutThreshold = const Duration(seconds: 30),
  });

  /// 订阅集群拓扑变动流
  Stream<List<DeviceNode>> get topologyStream => _topologyController.stream;

  /// 接收/更新集群内某节点的心跳 Ping
  void receiveHeartbeat(DeviceNode node) {
    _nodes[node.deviceId] = node.copyWith(lastHeartbeatTime: DateTime.now());
    _topologyController.add(_nodes.values.toList());
  }

  /// 检查集群内是否有节点（特别是主节点）心跳超时
  List<DeviceNode> getTimedOutNodes() {
    final now = DateTime.now();
    return _nodes.values.where((node) {
      return now.difference(node.lastHeartbeatTime) > timeoutThreshold;
    }).toList();
  }

  /// 获取当前存活的节点列表
  List<DeviceNode> getActiveNodes() {
    final timedOut = getTimedOutNodes().map((e) => e.deviceId).toSet();
    return _nodes.values.where((n) => !timedOut.contains(n.deviceId)).toList();
  }

  void dispose() {
    _topologyController.close();
  }
}
