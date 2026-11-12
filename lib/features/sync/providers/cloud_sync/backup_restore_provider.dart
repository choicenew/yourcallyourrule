import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/backup_encryption_service.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/backup_restore_service.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_backup_service.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  final encryptionService = BackupEncryptionService();
  final configRepository = ref.watch(configRepositoryProvider);
  final configBackupService = ConfigBackupService(configRepository);
  
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final rulesImportExportService = RuleImportExportService(ruleRepository);

  final service = BackupRestoreService(
    encryptionService,
    configBackupService,
    rulesImportExportService: rulesImportExportService,
  );
  service.initialize({});
  return service;
});
