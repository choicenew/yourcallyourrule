/// 设备拓扑角色
enum DeviceRole {
  master, // 主节点 (Primary)
  slave,  // 从节点 (Secondary)
  unknown,
}

/// 物理设备节点数据结构
class DeviceNode {
  final String deviceId;
  final String deviceName;
  final DeviceRole role;
  final String? ipAddress;
  final int priority;
  final DateTime lastHeartbeatTime;

  const DeviceNode({
    required this.deviceId,
    required this.deviceName,
    this.role = DeviceRole.unknown,
    this.ipAddress,
    this.priority = 0,
    required this.lastHeartbeatTime,
  });

  bool get isMaster => role == DeviceRole.master;

  DeviceNode copyWith({
    String? deviceId,
    String? deviceName,
    DeviceRole? role,
    String? ipAddress,
    int? priority,
    DateTime? lastHeartbeatTime,
  }) {
    return DeviceNode(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      role: role ?? this.role,
      ipAddress: ipAddress ?? this.ipAddress,
      priority: priority ?? this.priority,
      lastHeartbeatTime: lastHeartbeatTime ?? this.lastHeartbeatTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'deviceName': deviceName,
        'role': role.name,
        'ipAddress': ipAddress,
        'priority': priority,
        'lastHeartbeatTime': lastHeartbeatTime.toIso8601String(),
      };

  factory DeviceNode.fromJson(Map<String, dynamic> json) {
    return DeviceNode(
      deviceId: json['deviceId'] as String? ?? '',
      deviceName: json['deviceName'] as String? ?? '',
      role: DeviceRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => DeviceRole.unknown,
      ),
      ipAddress: json['ipAddress'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      lastHeartbeatTime: DateTime.tryParse(json['lastHeartbeatTime'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
