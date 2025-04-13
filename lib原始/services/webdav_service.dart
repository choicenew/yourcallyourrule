import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

import '../utils/get_default_external_dir.dart';
import '../utils/secure_storage.dart';
import '../views/sync/file_selection_dialog.dart';
import 'backup_restore_database_service.dart';

class WebDavService {
  final SecureStorage secureStorage;
  late String url;
  late String username;
  late String password;

  WebDavService(this.secureStorage) {
    _initCredentials();
  }
  late webdav.Client client;
  late BackupRestoreService _backupRestoreService;

  Future<void> _initCredentials() async {
    url = await secureStorage.read(SecureStorage.urlKey) ?? '';
    username = await secureStorage.read(SecureStorage.usernameKey) ?? '';
    password = await secureStorage.read(SecureStorage.passwordKey) ?? '';
    client = webdav.newClient(
      url,
      user: username,
      password: password,
    );
  }

  Future<bool> isConnected() async {
    try {
      // Test whether the service can connect
      await client.ping();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> saveCredentials(
      String newUrl, String newUsername, String newPassword) async {
    await secureStorage.write(SecureStorage.urlKey, newUrl);
    await secureStorage.write(SecureStorage.usernameKey, newUsername);
    await secureStorage.write(SecureStorage.passwordKey, newPassword);

    url = newUrl;
    username = newUsername;
    password = newPassword;

    client = webdav.newClient(
      url,
      user: username,
      password: password,
    );
  }

  // 独立的测试连接方法
  Future<bool> testConnection(
      String url, String username, String password) async {
    try {
      final client = webdav.newClient(
        url,
        user: username,
        password: password,
      );
      await client.ping();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> backup({String? backupDirName}) async {
    // 无论 isConnected() 返回 true 还是 false，都调用 _initCredentials()
    await _initCredentials();

    if (!await isConnected()) {
      return;
    }

    // Default backup directory name
    final defaultBackupDirName = 'ycyr';

    // Use provided backup name or default
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;

    // Step 1: Create backup directory on WebDAV server
    await client.mkdir(actualBackupDirName);

    // Step 2: Search local backup directory
    final defaultDirectory = await getDefaultExternalStorageDirectory();
    // Construct path to "backup" subdirectory
    final backupDirectoryPath = join(defaultDirectory, 'backup');
    // Check if "backup" directory exists
    final backupDirectory = Directory(backupDirectoryPath);

    if (!await backupDirectory.exists()) {
      // Inform user if directory doesn't exist
      return;
    }

    // Step 3: Get the latest ZIP file
// Get list of ZIP files in "backup" directory
    final backupFiles = await backupDirectory
        .list()
        .where((entity) => entity is File && entity.path.endsWith('.zip'))
        .map((entity) => File(entity.path)) // 将 FileSystemEntity 转换为 File
        .toList();

    if (backupFiles.isEmpty) {
      // If no ZIP files exist, inform the user
      return;
    }

    // Sort ZIP files by last modified time (newest first)
    backupFiles
        .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

// Get the latest ZIP file
    final latestBackupFile = backupFiles.first;

    // Step 4: Construct full backup path
    final fullBackupPath =
        join(actualBackupDirName, latestBackupFile.path.split('/').last);

    // Step 5: Upload the latest ZIP file to WebDAV server
    await client.writeFromFile(latestBackupFile.path, fullBackupPath,
        onProgress: (count, total) {
      // 不打印上传进度到控制台
      // print(count / total);
    });
  }

  Future<void> restore(
      {String? backupDirName, required BuildContext context}) async {
    if (!await isConnected()) {
      // If not connected, return
      return;
    }
    // Default backup directory name
    const defaultBackupDirName = 'ycyr';
    // Step 1: Get actual backup directory name
    final actualBackupDirName =
        backupDirName ?? defaultBackupDirName; // Default backup directory name

    // Step 2: Check if backup directory exists on WebDAV server
    final backupDirectory = await client.readDir('/');
    final backupDirExists =
        backupDirectory.any((file) => file.name == actualBackupDirName);
    if (!backupDirExists) {
      // Inform user about missing backup directory
      // print('Backup directory does not exist');
      return;
    }

    // Step 3: List files in backup directory
    final backupFiles = await client.readDir(actualBackupDirName);
    if (backupFiles.isEmpty) {
      return;
    }

    // Display file selection dialog and get user selection

    final selectedFile = await FileSelectionDialog.showFileSelectionDialog(
      backupFiles,
      'Select Backup File',
      context,
    );
    if (selectedFile == null) {
      // User canceled or no file selected
      return;
    }
    final selectedFilePath = join(actualBackupDirName, selectedFile.name);

// Step 4: Create temporary directory
    final tempDirectory = await Directory.systemTemp.createTemp('temp');

    try {
      // Step 5: Download selected ZIP file
      final tempFilePath = File('${tempDirectory.path}/${selectedFile.name}');
      await client.read2File(selectedFilePath, tempFilePath.path);

      // Step 6: Handle downloaded ZIP file (e.g., extract files)
      await _backupRestoreService.handleZipFile(tempFilePath);
    } catch (error) {
      // Handle download error
      //print('Error downloading file: $error');
    } finally {
      // Step 7: Clean up temporary directory
      //await tempDirectory.delete(recursive: true);
    }
    // 显示还原成功的 Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Database restored successfully!'),
      ),
    );
  }
}
