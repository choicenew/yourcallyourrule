import 'package:notification_manager/domain/entities/backup_config_entity.dart';
import 'package:notification_manager/domain/entities/backup_version_entity.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';

/// Interface for backup and restore services
abstract class BackupRestoreService {
  /// Initialize the backup service with necessary configurations
  Future<void> initialize(Map<String, dynamic> config);
  
  /// Check if the service is properly configured
  Future<bool> isConfigured();
  
  /// Get backup configuration
  Future<BackupConfigEntity> getBackupConfig();
  
  /// Update backup configuration
  Future<void> updateBackupConfig(BackupConfigEntity config);
  
  /// Get backup version history
  Future<List<BackupVersionEntity>> getBackupVersions();
  
  /// Check if backup encryption is enabled
  Future<bool> isEncryptionEnabled();
  
  /// Enable or disable backup encryption
  Future<void> setEncryptionEnabled(bool enabled);
  
  /// Set encryption password
  Future<void> setEncryptionPassword(String password);
  
  /// Validate encryption password
  Future<bool> validateEncryptionPassword(String password);
  
  /// Clear encryption settings
  Future<void> clearEncryptionSettings();
  
  /// Backup rules to a file
  Future<String> backupRules(List<RuleEntity> rules, String destination);
  
  /// Restore rules from a file
  Future<List<RuleEntity>> restoreRules(String source);
  
  /// Backup application settings
  Future<String> backupSettings(String destination);
  
  /// Restore application settings
  Future<bool> restoreSettings(String source);
  
  /// Backup notification history
  Future<String> backupNotificationHistory(String destination, {DateTime? startDate, DateTime? endDate});
  
  /// Restore notification history
  Future<bool> restoreNotificationHistory(String source);
  
  /// Schedule automatic backups
  Future<bool> scheduleAutomaticBackup(Duration interval, String destination);
  
  /// Cancel scheduled automatic backups
  Future<bool> cancelAutomaticBackup();
  
  /// Get a list of available backup files
  Future<List<String>> getAvailableBackups();
  
  /// Select a backup file using system file picker
  Future<String> selectBackupFile();
  
  /// Select a destination for backup using system file picker
  Future<String> selectBackupDestination();
  
  /// Get the service type identifier
  String get serviceType;
  
  /// Get a user-friendly name for this service
  String get serviceName;
}