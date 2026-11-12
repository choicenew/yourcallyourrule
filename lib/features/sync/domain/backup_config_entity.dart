class BackupConfigEntity {
  final bool backupRules;
  final bool backupHistory;
  final bool backupLabels;
  final bool backupContacts;
  final bool isEncrypted;
  final String? password;
  final bool keepAllVersions;
  final String deviceName;
  final bool encryptionEnabled;

  const BackupConfigEntity({
    this.backupRules = true,
    this.backupHistory = true,
    this.backupLabels = true,
    this.backupContacts = true,
    this.isEncrypted = false,
    this.password,
    this.keepAllVersions = true,
    this.deviceName = 'Device',
    this.encryptionEnabled = false,
  });

  BackupConfigEntity copyWith({
    bool? backupRules,
    bool? backupHistory,
    bool? backupLabels,
    bool? backupContacts,
    bool? isEncrypted,
    String? password,
    bool? keepAllVersions,
    String? deviceName,
    bool? encryptionEnabled,
  }) {
    return BackupConfigEntity(
      backupRules: backupRules ?? this.backupRules,
      backupHistory: backupHistory ?? this.backupHistory,
      backupLabels: backupLabels ?? this.backupLabels,
      backupContacts: backupContacts ?? this.backupContacts,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      password: password ?? this.password,
      keepAllVersions: keepAllVersions ?? this.keepAllVersions,
      deviceName: deviceName ?? this.deviceName,
      encryptionEnabled: encryptionEnabled ?? this.encryptionEnabled,
    );
  }
}
