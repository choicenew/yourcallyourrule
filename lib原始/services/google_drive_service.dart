import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../utils/get_default_external_dir.dart';
import '../views/sync/file_selection_dialog.dart';
import 'backup_restore_database_service.dart';

class GoogleDriveService {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: [drive.DriveApi.driveFileScope]);
  drive.DriveApi? _driveApi;

  late BackupRestoreService _backupRestoreService;
  bool get isEnabled => _driveApi != null;

  Future<bool> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return false;
      final authHeaders = await account.authHeaders;
      final authenticatedClient = GoogleAuthClient(authHeaders);
      _driveApi = drive.DriveApi(authenticatedClient);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _driveApi = null;
  }

  // 获取或创建文件夹并返回文件夹的 ID
  Future<String> createOrGetFolderId(String folderName) async {
    if (_driveApi == null) throw Exception('Not signed in to Google Drive');

    try {
      // 1. 尝试查找现有文件夹
      final response = await _driveApi!.files.list(
        q: "mimeType='application/vnd.google-apps.folder' and name='$folderName'",
      );

      if (response.files != null && response.files!.isNotEmpty) {
        // 文件夹已存在，返回其 ID
        return response.files!.first.id!;
      } else {
        // 2. 文件夹不存在，创建新文件夹
        final folder = drive.File()
          ..name = folderName
          ..mimeType = 'application/vnd.google-apps.folder';

        final folderInfo = await _driveApi!.files.create(folder);
        return folderInfo.id!;
      }
    } catch (e) {
      rethrow; // 重新抛出异常以供调用者处理
    }
  }

  Future<void> backup({String? backupDirName}) async {
    if (_driveApi == null) throw Exception('Not signed in to Google Drive');

    // 创建文件夹并获取文件夹的 ID
    // Default backup directory name
    const defaultBackupDirName = 'ycyr';

    // Use provided backup name or default
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;
    final folderId = await createOrGetFolderId(actualBackupDirName);

    final defaultDirectory = await getDefaultExternalStorageDirectory();
    final backupDirectoryPath = path.join(defaultDirectory, 'backup');
    final backupDirectory = Directory(backupDirectoryPath);

    if (!await backupDirectory.exists()) {
      throw Exception('Backup directory does not exist');
    }

    final backupFiles = await backupDirectory
        .list()
        .where((entity) => entity is File && entity.path.endsWith('.zip'))
        .map((entity) => File(entity.path))
        .toList();

    if (backupFiles.isEmpty) {
      throw Exception('No backup files found');
    }

    backupFiles
        .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    final latestBackupFile = backupFiles.first;

    //  final media = drive.Media(latestBackupFile.openRead(), latestBackupFile.lengthSync());

    // 3. 创建 GoogleAuthClient
    //  final authHeaders = await _googleSignIn.currentUser!.authHeaders;
    //  final authenticatedClient = GoogleAuthClient(authHeaders);

    // 4. 将 authenticatedClient 传递给 DriveApi
    //  _driveApi = drive.DriveApi(authenticatedClient);

    // 5. 使用 _driveApi 上传文件
    final media = drive.Media(
      latestBackupFile.openRead(),
      latestBackupFile.lengthSync(),
      contentType: 'application/zip',
    );

    final driveFile = drive.File()
      ..name = latestBackupFile.path.split('/').last
      ..mimeType = 'application/zip'
      ..parents = [folderId]; // 使用获取的目标文件夹 ID

    await _driveApi!.files.create(driveFile, uploadMedia: media);
  }

// 查询目标文件夹并返回其 ID
  Future<String?> getFolderId(String folderName) async {
    try {
      final response = await _driveApi!.files.list(
        q: "mimeType='application/vnd.google-apps.folder' and name='$folderName'",
      );

      if (response.files != null && response.files!.isNotEmpty) {
        return response.files!.first.id;
      } else {
        return null; // 如果未找到匹配的文件夹，返回 null 或者抛出异常
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> restore(
      {String? backupDirName, required BuildContext context}) async {
    if (_driveApi == null) throw Exception('Not signed in to Google Drive');

    // Default backup directory name
    const defaultBackupDirName = 'ycyr';
    // Step 0: Get actual backup directory name
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;
    // Step 1: Get folder ID for the backup directory
    final folderId = await createOrGetFolderId(actualBackupDirName);

    // Step 2: List backup files inside the specified folder
    final files = await _driveApi!.files.list(
      q: "parents='$folderId' and mimeType = 'application/zip'",
      orderBy: 'modifiedTime desc',
    );

    if (files.files == null || files.files!.isEmpty) {
      throw Exception(
          'No backup files found in the specified folder on Google Drive');
    }

    // Display file selection dialog and get user selection
    final selectedFile = await FileSelectionDialog.showFileSelectionDialog(
      files.files!,
      'Select Backup File',
      context,
    );

    if (selectedFile == null) {
      // User canceled or no file selected
      return;
    }

    // Step 3: Download the selected backup file
    final tempDir = await getTemporaryDirectory();
    final tempFile =
        File(path.join(tempDir.path, selectedFile.name ?? 'backup.zip'));

    final response = await _driveApi!.files.get(
      selectedFile.id!,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;

    final List<int> dataStore = [];
    await for (final data in response.stream) {
      dataStore.addAll(data);
    }
    await tempFile.writeAsBytes(dataStore);

    // Use BackupRestoreService to handle the restore process
    await _backupRestoreService.handleZipFile(tempFile);
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> headers;

  final http.Client _inner = http.Client();

  GoogleAuthClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request..headers.addAll(headers));
  }

  @override
  void close() {
    _inner.close();
  }
}
