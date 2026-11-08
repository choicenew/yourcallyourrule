import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/backup_encryption_service.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/backup_restore_service.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_backup_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

/// Provider for the main backup and restore service.
///
/// This provider combines multiple underlying services (encryption, rule import/export,
/// and config backup) to create the primary service responsible for handling
/// backup and restore operations.

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