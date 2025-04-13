import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/get_default_external_dir.dart';
import 'auto_backup_service.dart';
import 'backup_restore_database_service.dart';
import 'google_drive_service.dart';
import 'onedrive_service.dart';
import 'webdav_service.dart';

class OnlineBackupService {
  final AutoBackupService autoBackupService;
  final WebDavService webDAVService;
  final GoogleDriveService googleDriveService;
  final OneDriveService oneDriveService;
  final BackupRestoreService backupRestoreService;
  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  OnlineBackupService(
    this.autoBackupService,
    this.webDAVService,
    this.googleDriveService,
    this.oneDriveService,
    this.backupRestoreService,
  );

  // WebDAV methods开始自动 WebDAV 备份Start automatic WebDAV backup
  Future<void> startAutoWebDAVBackup(String? backupDirName) async {
    await autoBackupService.startAutoBackup(webDAVService.backup,  backupDirName: backupDirName);
  }

// 停止自动 WebDAV 备份Stop automatic WebDAV backup
  Future<void> stopAutoWebDAVBackup() async {
    await autoBackupService.stopAutoBackup();
  }



// 设置自动 WebDAV 备份开关Set automatic WebDAV backup switch
Future<void> setAutoWebDAVBackupEnabled(bool enabled, String? backupDirName) async {
  await _asyncPrefs.setBool('autoWebDAVBackupEnabled', enabled);
  if (enabled) {
    await startAutoWebDAVBackup(backupDirName); // 在这里启动 WebDAV 备份
  } else {
    await stopAutoWebDAVBackup(); // 在这里停止 WebDAV 备份
  }
}



// 获取自动 WebDAV 备份开关状态
Future<bool> isAutoWebDAVBackupEnabled() async {
  // 只从 SharedPreferences 中获取 WebDAV 备份的启用状态
  return await _asyncPrefs.getBool('autoWebDAVBackupEnabled') ?? false; 
}



  // Google Drive methods
  Future<void> startAutoGoogleDriveBackup(String? backupDirName) async {
    autoBackupService.startAutoBackup(googleDriveService.backup,  backupDirName: backupDirName);
  }

  Future<void> stopAutoGoogleDriveBackup() async {
    autoBackupService.stopAutoBackup();
  }

  Future<void> setAutoGoogleDriveBackupEnabled(bool enabled, String? backupDirName) async {
    await _asyncPrefs.setBool('autoGoogleDriveBackupEnabled', enabled);
    if (enabled) {
      await startAutoGoogleDriveBackup(backupDirName);
    } else {
      await stopAutoGoogleDriveBackup();
    }
  }

  Future<bool> isAutoGoogleDriveBackupEnabled() async {
    return await _asyncPrefs.getBool('autoGoogleDriveBackupEnabled') ?? false;
  }

  // OneDrive methods
  Future<void> startAutoOneDriveBackup(String? backupDirName) async {
    autoBackupService.startAutoBackup(oneDriveService.backup,  backupDirName: backupDirName);
  }

  Future<void> stopAutoOneDriveBackup() async {
    autoBackupService.stopAutoBackup();
  }

  Future<void> setAutoOneDriveBackupEnabled(bool enabled, String? backupDirName) async {
    await _asyncPrefs.setBool('autoOneDriveBackupEnabled', enabled);
    if (enabled) {
      await startAutoOneDriveBackup(backupDirName);
    } else {
      await stopAutoOneDriveBackup();
    }
  }

  Future<bool> isAutoOneDriveBackupEnabled() async {
    return await _asyncPrefs.getBool('autoOneDriveBackupEnabled') ?? false;
  }

  // Local backup methods,Start automatic local backup
  Future<void> startAutoLocalBackup() async {
    //autoBackupService.startAutoBackup(backupRestoreService.backup);
    await autoBackupService.startAutoBackup(({String? backupDirName}) => backupRestoreService.backup()); // 使用匿名函数包装 backupRestoreService.backup
  }

// 停止自动本地备份Stop automatic local backup
  Future<void> stopAutoLocalBackup() async {
    autoBackupService.stopAutoBackup();
  }

  // 设置自动本地备份开关Set automatic local backup switch
  Future<void> setAutoLocalBackupEnabled(bool enabled) async {
    await autoBackupService.setAutoBackupEnabled(enabled);
    await _asyncPrefs.setBool('autoLocalBackupEnabled', enabled);
  }

  /// 获取自动本地备份开关状态Get automatic local backup switch status
  Future<bool> isAutoLocalBackupEnabled() async {
    final bool autoBackupEnabledFromService =
        await autoBackupService.isAutoBackupEnabled();
    return autoBackupEnabledFromService;
    }

// 获取自动本地备份仅保留最新备份开关状态
  Future<bool> isAutoLocalBackupKeepOnlyLatest() async {
    return await _asyncPrefs.getBool('autoLocalBackupKeepOnlyLatest') ?? false;
  }

// 设置自动本地备份仅保留最新备份开关Set automatic local backup keep only latest backup switch
  Future<void> setAutoLocalBackupKeepOnlyLatest(bool keepOnlyLatest) async {
    await _asyncPrefs.setBool('autoLocalBackupKeepOnlyLatest', keepOnlyLatest);
    if (keepOnlyLatest) {
      await _deleteOldBackups();
    }
  }

  Future<void> _deleteOldBackups() async {
    // Retrieve the last backup time
    final lastBackupTimeInMillis = await autoBackupService.getLastBackupTime();
    final lastBackupTime =
        DateTime.fromMillisecondsSinceEpoch(lastBackupTimeInMillis);

    const waitDuration = Duration(minutes: 5);
    final waitUntil = lastBackupTime.add(waitDuration);

    // Check if the current time is past the wait time
    if (DateTime.now().isAfter(waitUntil)) {
      // Get the default external storage directory
      final defaultDirectory = await getDefaultExternalStorageDirectory();
      final backupDirectoryPath = join(defaultDirectory,
          'backup'); // Construct the path to the "backup" subdirectory

      // List all backup files
      final backupFiles = await Directory(backupDirectoryPath)
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.zip'))
          .map((entity) => File(entity.path))
          .toList();

      backupFiles
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

  if (backupFiles.length > 1) { // 检查 backupFiles 是否至少包含两个元素
    for (final backupFile in backupFiles.sublist(1)) {
      await backupFile.delete();
    }
  }
    }
  }

  Future<void> backup() async {
    if (await isAutoWebDAVBackupEnabled()) await webDAVService.backup();
    if (await isAutoGoogleDriveBackupEnabled()) {
      await googleDriveService.backup();
    }
    if (await isAutoOneDriveBackupEnabled()) await oneDriveService.backup();
    //if (isAutoLocalBackupEnabled()) {
    //  await backupRestoreService.backup();
    //}
  }

  Future<void> restore(
      {String? backupDirName, required BuildContext context}) async {
    const defaultBackupDirName = 'ycyr';
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;

    if (await isAutoWebDAVBackupEnabled()) {
      await webDAVService.restore(
        backupDirName: actualBackupDirName, // 替换为实际的备份目录名称
        context: context, // 传递当前的 BuildContext
      );
    }
    if (await isAutoGoogleDriveBackupEnabled()) {
      await googleDriveService.restore(
        backupDirName: actualBackupDirName, // 替换为实际的备份目录名称
        context: context, // 传递当前的 BuildContext
      );
    }
    if (await isAutoOneDriveBackupEnabled()) {
      await oneDriveService.restore(
        backupDirName: actualBackupDirName, // 替换为实际的备份目录名称
        context: context, // 传递当前的 BuildContext
      );
    }
    // For local restore, you might want to use backupRestoreService.restore()
    // 调用本地备份恢复
    await backupRestoreService.restore();
  }
}
