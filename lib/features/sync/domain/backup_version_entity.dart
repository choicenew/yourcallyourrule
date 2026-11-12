class BackupVersionEntity {
  final String version;
  final DateTime backupTime;
  final String deviceName;
  final String filePath;
  final String backupType;

  const BackupVersionEntity({
    required this.version,
    required this.backupTime,
    required this.deviceName,
    required this.filePath,
    required this.backupType,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'backupTime': backupTime.toIso8601String(),
      'deviceName': deviceName,
      'filePath': filePath,
      'backupType': backupType,
    };
  }

  factory BackupVersionEntity.fromJson(Map<String, dynamic> json) {
    return BackupVersionEntity(
      version: json['version'] as String? ?? '',
      backupTime: json['backupTime'] != null
          ? DateTime.parse(json['backupTime'] as String)
          : DateTime.now(),
      deviceName: json['deviceName'] as String? ?? '',
      filePath: json['filePath'] as String? ?? '',
      backupType: json['backupType'] as String? ?? '',
    );
  }
}
