import 'package:shared_preferences/shared_preferences.dart';

import '../utils/update_interval.dart';

class AutoBackupService {
  //final BackupRestoreService _backupRestoreService;
  final SharedPreferencesAsync _asyncPrefs =
      SharedPreferencesAsync(); // Changed to SharedPreferencesAsync and initialized

  AutoBackupService(
      //this._backupRestoreService
      );

  /// 开启自动备份
  // Future<void> startAutoBackup(Future<void> Function() backup, String? backupDirName) async {
  Future<void> startAutoBackup(
      Future<void> Function({String? backupDirName}) backupFunction,
      {String? backupDirName}) async {
    // 获取自动备份开关
    final autoBackupEnabled =
        await _asyncPrefs.getBool('autoBackupEnabled') ?? true; // Use await

    // 如果自动备份开关关闭，则返回
    if (!autoBackupEnabled) {
      return;
    }

    // 获取上次备份时间
    final lastBackupTime = await getLastBackupTime();
    // 获取订阅对象的名称
    const objectName = 'AutoBackup';
    // 检查是否需要备份
    final shouldBackup = await lastBackupTime.shouldUpdate(objectName);

    if (shouldBackup) {
      try {
        // 执行备份操作 // 执行备份操作，传递 backupDirName
        //  await _backupRestoreService.backup();
        // 执行备份操作，传递 backupDirName 给 backupFunction
        await backupFunction(backupDirName: backupDirName);
      } catch (error) {
        // Handle backup error
        // print('Error backing up data: $error');
      }

      // 更新上次备份时间
      await setLastBackupTime(DateTime.now().millisecondsSinceEpoch);
      //final sharedPreferences = await SharedPreferences.getInstance();

      // await sharedPreferences.setInt('lastUpdated_$objectName', DateTime.now().millisecondsSinceEpoch);
    }
  }

  /// 停止自动备份
  Future<void> stopAutoBackup() async {
    // Cancel any scheduled backups
    // This is just an example, you'd need to implement the actual cancellation logic
    // based on how you've scheduled the backups

    // Optionally, you might want to update a flag in SharedPreferences
    await _asyncPrefs.setBool('autoBackupEnabled', false);
  }

  /// 设置自动备份开关
  Future<void> setAutoBackupEnabled(bool enabled) async {
    await _asyncPrefs.setBool('autoBackupEnabled', enabled);
  }

  /// 获取自动备份开关状态
  Future<bool> isAutoBackupEnabled() async {
    return await _asyncPrefs.getBool('autoBackupEnabled') ?? true;
  }

  Future<int> getLastBackupTime() async {
    return await _asyncPrefs.getInt('lastBackupTime') ?? 0;
  }

  Future<void> setLastBackupTime(int lastBackupTime) async {
    await _asyncPrefs.setInt('lastBackupTime', lastBackupTime);
  }
}
