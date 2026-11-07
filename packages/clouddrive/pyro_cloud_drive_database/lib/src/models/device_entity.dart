class DeviceEntity {
  final String deviceId;
  final String deviceName;
  final String platform;
  final DateTime lastActiveAt;
  final String appVersion;
  final bool isCurrentDevice;

  const DeviceEntity({
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.lastActiveAt,
    required this.appVersion,
    this.isCurrentDevice = false,
  });

  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'deviceName': deviceName,
    'platform': platform,
    'lastActiveAt': lastActiveAt.toIso8601String(),
    'appVersion': appVersion,
    'isCurrentDevice': isCurrentDevice,
  };

  factory DeviceEntity.fromJson(Map<String, dynamic> json) => DeviceEntity(
    deviceId: json['deviceId'] as String,
    deviceName: json['deviceName'] as String? ?? 'Unknown Device',
    platform: json['platform'] as String? ?? 'unknown',
    lastActiveAt: json['lastActiveAt'] != null ? DateTime.parse(json['lastActiveAt'] as String) : DateTime.now(),
    appVersion: json['appVersion'] as String? ?? '1.0.0',
    isCurrentDevice: json['isCurrentDevice'] as bool? ?? false,
  );
}
