class BackupVersionEntity {
  final String id;
  final String driveType;
  final String remotePath;
  final DateTime createdAt;
  final int sizeBytes;
  final String deviceId;
  final String deviceName;
  final bool isEncrypted;
  final String checksum;
  final Map<String, dynamic>? metadata;

  const BackupVersionEntity({
    required this.id,
    required this.driveType,
    required this.remotePath,
    required this.createdAt,
    required this.sizeBytes,
    required this.deviceId,
    required this.deviceName,
    this.isEncrypted = false,
    required this.checksum,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'driveType': driveType,
    'remotePath': remotePath,
    'createdAt': createdAt.toIso8601String(),
    'sizeBytes': sizeBytes,
    'deviceId': deviceId,
    'deviceName': deviceName,
    'isEncrypted': isEncrypted,
    'checksum': checksum,
    if (metadata != null) 'metadata': metadata,
  };

  factory BackupVersionEntity.fromJson(Map<String, dynamic> json) => BackupVersionEntity(
    id: json['id'] as String,
    driveType: json['driveType'] as String,
    remotePath: json['remotePath'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    sizeBytes: json['sizeBytes'] as int,
    deviceId: json['deviceId'] as String? ?? 'unknown',
    deviceName: json['deviceName'] as String? ?? 'Unknown Device',
    isEncrypted: json['isEncrypted'] as bool? ?? false,
    checksum: json['checksum'] as String? ?? '',
    metadata: json['metadata'] as Map<String, dynamic>?,
  );
}
