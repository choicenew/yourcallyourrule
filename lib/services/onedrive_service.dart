import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msal_auth/msal_auth.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../utils/get_default_external_dir.dart';
import '../views/sync/file_selection_dialog.dart';
import 'backup_restore_database_service.dart';

// OneDriveFile 类
class OneDriveFile {
  final String name;
  final DateTime lastModifiedDateTime;

  OneDriveFile({required this.name, required this.lastModifiedDateTime});
}

class OneDriveService extends ChangeNotifier {
  late Future<MsalAuth> _msalAuthFuture;
  late BackupRestoreService _backupRestoreService;
  late MsalAuth _msalAuth;
  bool _msalAuthInitialized = false;
 // String? _clientId;
//  String? _tenantId;
  // 设置默认的 clientId 和 tenantId
  String? _clientId = 'b08dc19f-e5f4-4203-bf20-2fd4cf2a4206';
  String? _tenantId = '8be70234-1fae-4944-831e-7e2d42f1b556';


  final _scopes = <String>[
    // 'https://graph.microsoft.com/user.read',
    'Files.ReadWrite.All', // OneDrive scope
    'Sites.ReadWrite.All',
    'Directory.ReadWrite.All',
    // 'offline_access', // Optional: For long-lived tokens
    // Add other scopes here if required
  ];
  String? _authority;
  MsalUser? _user;

  OneDriveService() {
    _backupRestoreService = BackupRestoreService();
  }

  Future<bool> signInWithCredentials(String? clientId, String? tenantId) async {
    // 使用提供的 clientId 和 tenantId，或者使用默认值
    _clientId = clientId ?? _clientId;
    _tenantId = tenantId ?? _tenantId;

    _authority =
        'https://login.microsoftonline.com/$_tenantId/oauth2/v2.0/authorize';
    // Initialize _msalAuthFuture here
    await _initMsalAuth();
    return await signIn();
  }

  Future<void> _initMsalAuth() async {
    _msalAuthFuture = MsalAuth.createPublicClientApplication(
      clientId: _clientId!,
      scopes: _scopes,
      androidConfig: AndroidConfig(
        configFilePath: 'assets/msal_config.json',
        tenantId: _tenantId,
      ),
      //  iosConfig: IosConfig(authority: _authority),
    );
  }

  Future<void> _ensureInitialized() async {
    if (!_msalAuthInitialized) {
      await _msalAuthFuture.then((msalAuth) {
        _msalAuth = msalAuth;
        _msalAuthInitialized = true;
      });
    }
  }

  Future<MsalAuth> _getMsalAuth() async {


    return MsalAuth.createPublicClientApplication(
      clientId: _clientId!,
      scopes: _scopes,
      androidConfig: AndroidConfig(
        configFilePath: 'assets/msal_config.json',
        tenantId: _tenantId,
      ),
      //  iosConfig: IosConfig(authority: _authority),
    );
  }

  Future<bool> signIn() async {
    try {
      final msalAuth = await _getMsalAuth(); // Get MsalAuth instance
      _user = await msalAuth.acquireToken(); // Acquire token

      if (_user != null) {
        notifyListeners();
      } else {
        throw Exception('Failed to acquire access token');
      }

      return _user != null;
    } catch (error) {
      //print('Error signing in to OneDrive: $error');
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      final msalAuth = await _getMsalAuth();
      await msalAuth.logout();
      _user = null;
      notifyListeners();
    } catch (error) {
     // print('Error signing out of OneDrive: $error');
    }
  }

  // 创建文件夹并返回文件夹的 ID
// 获取文件夹 ID，如果不存在则创建
  Future<String> _createFolderAndGetId(String folderName) async {
    if (_user == null) throw Exception('Not signed in to OneDrive');

    // 1. 尝试创建文件夹，设置冲突行为为 "fail"
    final folder = {
      "name": folderName,
      "folder": {},
      "@microsoft.graph.conflictBehavior": "fail",
    };

    try {
      final createResponse = await http.post(
        Uri.parse('https://graph.microsoft.com/v1.0/me/drive/root/children'),
        headers: {
          'Authorization': 'Bearer ${_user!.accessToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(folder),
      );

      if (createResponse.statusCode == 201) {
        // 文件夹创建成功
        return jsonDecode(createResponse.body)['id'];
      } else {
        // 处理其他错误
        throw Exception(
            'Failed to create folder on OneDrive: ${createResponse.body}');
      }
    } catch (e) {
      // 2. 如果文件夹已存在，获取其 ID
      if (e.toString().contains('nameAlreadyExists')) {
        // 获取根目录下的所有子文件夹
        final response = await http.get(
          Uri.parse('https://graph.microsoft.com/v1.0/me/drive/root/children'),
          headers: {
            'Authorization': 'Bearer ${_user!.accessToken}',
          },
        );

        if (response.statusCode == 200) {
          final items = jsonDecode(response.body)['value'] as List;
          // 遍历子文件夹，查找匹配名称的文件夹
          for (final item in items) {
            if (item['name'] == folderName && item['folder'] != null) {
              return item['id'];
            }
          }

          // 如果没有找到匹配的文件夹，抛出异常
          throw Exception('Failed to find existing folder on OneDrive.');
        } else {
          throw Exception(
              'Failed to get children of root folder on OneDrive: ${response.body}');
        }
      } else {
        // 其他错误
        rethrow;
      }
    }
  }

  Future<void> backup({String? backupDirName}) async {
    if (_user == null) throw Exception('Not signed in to OneDrive');

    // Default backup directory name
    const defaultBackupDirName = 'ycyr';

    // Use provided backup name or default
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;

    // 创建或获取 OneDrive 上备份文件夹的 ID
    final folderId = await _createFolderAndGetId(actualBackupDirName);

    // 查找本地备份文件
    final defaultDirectory =
        await getDefaultExternalStorageDirectory(); // 使用您的方法获取外部存储路径
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

    final fileName = latestBackupFile.path.split('/').last;
    final fileContent = await latestBackupFile.readAsBytes();

    // 上传备份文件到 OneDrive 文件夹
    final uploadUrl =
        'https://graph.microsoft.com/v1.0/me/drive/items/$folderId:/$fileName:/content';

    final response = await http.put(
      Uri.parse(uploadUrl),
      headers: {
        'Authorization': 'Bearer ${_user!.accessToken}',
        'Content-Type': 'application/zip',
      },
      body: fileContent,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to upload file to OneDrive: ${response.body}');
      
    } else {
    //  print('Backup successful!');
    }
  }

  Future<void> restore(
      {String? backupDirName, required BuildContext context}) async {
    if (_user == null) throw Exception('Not signed in to OneDrive');

    // Default backup directory name
    final defaultBackupDirName = 'ycyr';
    final actualBackupDirName = backupDirName ?? defaultBackupDirName;

    // Fetch files from OneDrive in specified directory
    final listUrl =
        'https://graph.microsoft.com/v1.0/me/drive/root:/$actualBackupDirName:/children';

    final listResponse = await http.get(
      Uri.parse(listUrl),
      headers: {'Authorization': 'Bearer ${_user!.accessToken}'},
    );

    if (listResponse.statusCode != 200) {
      throw Exception('Failed to list files on OneDrive: ${listResponse.body}');
    }

    final files = json.decode(listResponse.body)['value'] as List;

    // 将 OneDrive 文件列表转换为 List<OneDriveFile>
    final onedriveFiles = files
        .map((file) => OneDriveFile(
              name: file['name'],
              lastModifiedDateTime:
                  DateTime.parse(file['lastModifiedDateTime']),
            ))
        .toList();

    // 使用 FileSelectionDialog 让用户选择文件
    final selectedFile = await FileSelectionDialog.showFileSelectionDialog(
      onedriveFiles,
      'Select Backup File',
      context,
    ) as OneDriveFile?;

    if (selectedFile == null) {
      // 用户取消或未选择文件
      return;
    }

    // final downloadUrl = selectedFile['@microsoft.graph.downloadUrl'];
    // 获取下载链接，使用 selectedFile.name
    final downloadUrl =
        'https://graph.microsoft.com/v1.0/me/drive/root:/$actualBackupDirName/${selectedFile.name}:/content';


    final tempDir = await getTemporaryDirectory();
    final tempFile = File(path.join(tempDir.path, selectedFile.name));

    final downloadResponse = await http.get(Uri.parse(downloadUrl), headers: {
      'Authorization': 'Bearer ${_user!.accessToken}',
    });
    await tempFile.writeAsBytes(downloadResponse.bodyBytes);

    // Simulating restore process (replace with your actual restore logic)
    await _backupRestoreService.handleZipFile(tempFile);
    // 显示还原成功的 Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Database restored successfully!'),
      ),
    );
  }
}
