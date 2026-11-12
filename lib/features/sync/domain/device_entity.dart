class DeviceEntity {
  final String id;
  final String name;
  final String model;
  final String osVersion;
  final DateTime lastSyncTime;

  const DeviceEntity({
    required this.id,
    required this.name,
    required this.model,
    required this.osVersion,
    required this.lastSyncTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': model,
      'osVersion': osVersion,
      'lastSyncTime': lastSyncTime.toIso8601String(),
    };
  }

  factory DeviceEntity.fromJson(Map<String, dynamic> json) {
    return DeviceEntity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      model: json['model'] as String? ?? '',
      osVersion: json['osVersion'] as String? ?? '',
      lastSyncTime: json['lastSyncTime'] != null
          ? DateTime.parse(json['lastSyncTime'] as String)
          : DateTime.now(),
    );
  }
}
