import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_encryption_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// Provider for the main backup and restore service.
///
/// This provider combines multiple underlying services (encryption, rule import/export,
/// and config backup) to create the primary service responsible for handling
/// backup and restore operations.

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return SharedPreferencesConfigRepository();
});

final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  final encryptionService = BackupEncryptionService();
  final configRepository = ref.watch(configRepositoryProvider);
  final configBackupService = ConfigBackupService(configRepository);
  
  // Get rule repository and create rule import/export service
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final rulesImportExportService = RuleImportExportService(ruleRepository);

  final service = BackupRestoreService(
    encryptionService,
    configBackupService,
    rulesImportExportService: rulesImportExportService,
  );
  // Initialize the service
  service.initialize({});
  return service;
});