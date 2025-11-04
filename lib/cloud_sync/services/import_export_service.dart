import 'dart:io';
import 'package:yourcallyourrule/cloud_sync/services/backup_restore_service.dart';

class ImportExportService {
  final BackupRestoreService _backupRestore;

  ImportExportService(this._backupRestore);

  /// 导出数据库为通用全表 JSON（tables）
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

  /// 从通用全表 JSON（tables）还原
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