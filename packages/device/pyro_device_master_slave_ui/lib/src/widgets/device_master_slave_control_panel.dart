import 'package:material_ui/material_ui.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:pyro_device_master_slave/pyro_device_master_slave.dart';

/// 主从设备拓扑控制面板 UI 组件
class DeviceMasterSlaveControlPanel extends StatefulWidget {
  final MasterSlaveManager manager;

  const DeviceMasterSlaveControlPanel({
    super.key,
    required this.manager,
  });

  @override
  State<DeviceMasterSlaveControlPanel> createState() => _DeviceMasterSlaveControlPanelState();
}

class _DeviceMasterSlaveControlPanelState extends State<DeviceMasterSlaveControlPanel> {
  late Future<List<DeviceNode>> _nodesFuture;
  DeviceNode? _localNode;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _nodesFuture = widget.manager.getActiveClusterNodes();
    });
    widget.manager.getLocalNode().then((node) {
      if (mounted) {
        setState(() {
          _localNode = node;
        });
      }
    });
  }

  Future<void> _toggleRole(DeviceNode node, DeviceRole newRole) async {
    await widget.manager.setDeviceRole(node.deviceId, newRole);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Icon(Icons.devices, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  '主从设备集群与初始化权限控制面板',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_localNode != null)
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _localNode!.isMaster ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: _localNode!.isMaster ? Colors.green : Colors.orange,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _localNode!.isMaster ? Icons.star : Icons.phonelink_setup,
                      color: _localNode!.isMaster ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '本机状态: ${_localNode!.deviceName} (${_localNode!.role.name.toUpperCase()})',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _localNode!.isMaster
                                ? '权限: 主设备 (Master) 允许进行全局数据库初始化'
                                : '权限: 从设备 (Slave) 已拥有全部云端 Key，但被严格禁止重复初始化数据库 (免去重新下载初始化之痛)',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              '集群已接入设备节点列表:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<DeviceNode>>(
              future: _nodesFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final nodes = snapshot.data!;
                if (nodes.isEmpty) {
                  return const Text('暂无发现其他设备节点');
                }
                return Column(
                  children: nodes.map((node) {
                    final isLocal = _localNode != null && node.deviceId == _localNode!.deviceId;
                    return ListTile(
                      leading: Icon(
                        node.isMaster ? Icons.dns : Icons.phone_android,
                        color: node.isMaster ? Colors.green : Colors.blueGrey,
                      ),
                      title: Text('${node.deviceName} ${isLocal ? "(本机)" : ""}'),
                      subtitle: Text('ID: ${node.deviceId} | Key已就绪 (${node.keysConfig.length} 个)'),
                      trailing: SegmentedButton<DeviceRole>(
                        segments: const [
                          ButtonSegment(
                            value: DeviceRole.master,
                            label: Text('Master'),
                            icon: Icon(Icons.star_border, size: 16),
                          ),
                          ButtonSegment(
                            value: DeviceRole.slave,
                            label: Text('Slave'),
                            icon: Icon(Icons.lock_clock, size: 16),
                          ),
                        ],
                        selected: {node.role},
                        onSelectionChanged: (selected) {
                          _toggleRole(node, selected.first);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
