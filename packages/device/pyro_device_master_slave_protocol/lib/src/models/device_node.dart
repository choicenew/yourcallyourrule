/// 设备拓扑角色
enum DeviceRole {
  master, // 主设备 (Primary: 允许执行初始化数据库)
  slave,  // 从设备 (Secondary: 拥有完整密钥，但禁止重复初始化数据库)
  unknown,
}

/// 本地主设备节点预设 Token (强类型 0 字符串魔数)
abstract final class DeviceNodeToken {
  static const String localPrimaryId = 'local_primary_device';
  static const String localPrimaryName = 'PyroMagma Phone Node';
}

/// 设备节点元数据
class DeviceNode {
  final String deviceId;
  final String deviceName;
  final DeviceRole role;
  final Map<String, String> keysConfig; // 保留完整的云端 Key (Cloudflare/Supabase Key)
  final String? ipAddress;
  final int priority;
  final DateTime lastHeartbeatTime;

  const DeviceNode({
    required this.deviceId,
    required this.deviceName,
    this.role = DeviceRole.unknown,
    this.keysConfig = const {},
    this.ipAddress,
    this.priority = 0,
    required this.lastHeartbeatTime,
  });

  bool get isMaster => role == DeviceRole.master;

  /// 只有主设备 (Master) 允许进行数据库初始化；从设备 (Slave) 严禁重复初始化
  bool get canInitializeDatabase => role == DeviceRole.master;

  DeviceNode copyWith({
    String? deviceId,
    String? deviceName,
    DeviceRole? role,
    Map<String, String>? keysConfig,
    String? ipAddress,
    int? priority,
    DateTime? lastHeartbeatTime,
  }) {
    return DeviceNode(
      deviceId: deviceId ?? this.deviceId,
      deviceName: deviceName ?? this.deviceName,
      role: role ?? this.role,
      keysConfig: keysConfig ?? this.keysConfig,
      ipAddress: ipAddress ?? this.ipAddress,
      priority: priority ?? this.priority,
      lastHeartbeatTime: lastHeartbeatTime ?? this.lastHeartbeatTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'deviceName': deviceName,
        'role': role.name,
        'keysConfig': keysConfig,
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
      keysConfig: (json['keysConfig'] as Map<String, dynamic>?)?.cast<String, String>() ?? {},
      ipAddress: json['ipAddress'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      lastHeartbeatTime: DateTime.tryParse(json['lastHeartbeatTime'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
