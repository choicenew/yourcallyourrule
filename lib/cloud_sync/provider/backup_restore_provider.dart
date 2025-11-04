import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_encryption_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_backup_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_provider.dart';

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
  final localStorage = ref.watch(localStorageServiceProvider);
  final ruleImportExportService = RuleImportExportService(
    localStorage,
    configRepository: configRepository,
  );
  final configBackupService = ConfigBackupService(configRepository);
  final service = BackupRestoreService(
    encryptionService,
    ruleImportExportService,
    configBackupService,
  );
  // Initialize the service
  service.initialize({});
  return service;
});