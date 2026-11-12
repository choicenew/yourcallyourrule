import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_database/pyro_cloud_drive_database.dart';

/// 100% 绑定包内 pyro_cloud_drive_database 标准 BackupRestoreService 引擎
final backupRestoreServiceProvider = Provider<BackupRestoreService>((ref) {
  return BackupRestoreService();
});
