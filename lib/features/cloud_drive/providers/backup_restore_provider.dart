import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

part 'backup_restore_provider.g.dart';

/// 100% 绑定包内 pyro_cloud_drive_database 标准 BackupRestoreService 引擎
@Riverpod(keepAlive: true)
BackupRestoreService backupRestoreService(Ref ref) {
  return BackupRestoreService();
}
