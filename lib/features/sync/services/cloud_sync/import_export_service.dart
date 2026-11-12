import 'dart:io';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/backup_restore_service.dart';

class ImportExportService {
  final BackupRestoreService _backupRestore;

  ImportExportService(this._backupRestore);

  Future<File> exportDatabaseJson({
    required String filePath,
    List<String>? includeTables,
    List<String>? excludeTables,
  }) async {
    final outPath = await _backupRestore.backupDatabaseJson(
      filePath,
      includeTables: includeTables,
      excludeTables: excludeTables,
    );
    return File(outPath);
  }

  Future<void> importDatabaseJson(
    File file, {
    List<String>? includeTables,
    List<String>? excludeTables,
    bool clearBeforeInsert = true,
  }) async {
    await _backupRestore.restoreDatabaseJson(
      file.path,
      includeTables: includeTables,
      excludeTables: excludeTables,
      clearBeforeInsert: clearBeforeInsert,
    );
  }
}
