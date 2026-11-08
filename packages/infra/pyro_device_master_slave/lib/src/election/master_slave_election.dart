import '../models/device_node.dart';

/// 纯物理节点主从角色选举器
class MasterSlaveElection {
  /// 根据集群节点优先权重与心跳最新时间判定主节点 (Master Node)
  static DeviceNode? electMaster(List<DeviceNode> nodes, {Duration heartbeatTimeout = const Duration(seconds: 30)}) {
    if (nodes.isEmpty) return null;

    final now = DateTime.now();
    // 过滤出未超时的存活节点
    final activeNodes = nodes.where((node) {
      return now.difference(node.lastHeartbeatTime) <= heartbeatTimeout;
    }).toList();

    if (activeNodes.isEmpty) return null;

    // 按优先级 (Priority) 降序排序，优先级相同时按最后心跳时间排序
    activeNodes.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority.compareTo(a.priority);
      }
      return b.lastHeartbeatTime.compareTo(a.lastHeartbeatTime);
    });

    final winner = activeNodes.first;
    return winner.copyWith(role: DeviceRole.master);
  }
}
