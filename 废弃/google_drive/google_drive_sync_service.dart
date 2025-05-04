import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/cloud_sync/sync_progress_tracker.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import '../enhanced_cloud_sync_service.dart';
import '../sync_conflict_resolver.dart';
import '../cloud_sync_service.dart';
import '../../core/entities/rule/rule_base.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

/// Google Drive同步服务实现
/// 提供与Google Drive的云同步功能
class GoogleDriveSyncService extends EnhancedCloudSyncService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );
  
  drive.DriveApi? _driveApi;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Google Drive文件夹配置
  static const String _defaultAppFolderName = 'YourCallYourRule';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _historyFolderName;
  late String _devicesFolderName;
  
  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _historyFolderName = 'History';
    _devicesFolderName = 'Devices';
  }
  
  GoogleSignInAccount? _currentUser;
  
  // 文件夹ID缓存
  String? _appFolderId;
  String? _rulesFolderId;
  String? _settingsFolderId;
  String? _historyFolderId;
  String? _devicesFolderId;
  
  @override
  String get serviceType => 'GoogleDrive';
  
  @override
  String get serviceName => 'Google Drive';
  
  /// 构造函数
  GoogleDriveSyncService({
    super.defaultStrategy,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    // 设置自定义应用文件夹名称
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    // 尝试静默登录
    try {
      _currentUser = await _googleSignIn.signInSilently();
      if (_currentUser != null) {
        await _initDriveApi();
      }
    } catch (e) {
      debugPrint('静默登录错误: $e');
    }
    
    _isInitialized = true;
  }
  
  /// 初始化Drive API
  Future<void> _initDriveApi() async {
    if (_currentUser == null) return;
    
    final authHeaders = await _currentUser!.authHeaders;
    final authenticatedClient = _AuthenticatedClient(
      http.Client(),
      authHeaders,
    );
    
    _driveApi = drive.DriveApi(authenticatedClient);
  }
  
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在连接到Google Drive...',
    );
    
    try {
      // 尝试登录
      _currentUser = await _googleSignIn.signIn();
      
      if (_currentUser != null) {
        await _initDriveApi();
        
        // 创建必要的文件夹
        await _createFolders();
        
        progressTracker.updateProgress(
          operationType: SyncOperationType.initialization,
          progress: 100,
          message: '已连接到Google Drive',
        );
        
        return true;
      } else {
        progressTracker.reportError(
          errorMessage: '连接到Google Drive失败: 用户取消登录',
        );
        return false;
      }
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '连接到Google Drive失败: $e',
      );
      return false;
    }
  }
  
  @override
  Future<bool> disconnect() async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在断开Google Drive连接...',
    );
    
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
      _driveApi = null;
      
      // 清除文件夹ID缓存
      _appFolderId = null;
      _rulesFolderId = null;
      _settingsFolderId = null;
      _historyFolderId = null;
      _devicesFolderId = null;
      
      progressTracker.updateProgress(
        operationType: SyncOperationType.initialization,
        progress: 100,
        message: '已断开Google Drive连接',
      );
      
      return true;
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '断开Google Drive连接失败: $e',
      );
      return false;
    }
  }
  
  @override
  Future<bool> isConfigured() async {
    return _currentUser != null && _driveApi != null;
  }
  
  /// 创建必要的文件夹
  Future<void> _createFolders() async {
    if (_driveApi == null) return;
    
    // 创建应用文件夹
    _appFolderId = await _findOrCreateFolder(_appFolderName, null);
    
    // 创建子文件夹
    _rulesFolderId = await _findOrCreateFolder(_rulesFolderName, _appFolderId);
    _settingsFolderId = await _findOrCreateFolder(_settingsFolderName, _appFolderId);
    _historyFolderId = await _findOrCreateFolder(_historyFolderName, _appFolderId);
    _devicesFolderId = await _findOrCreateFolder(_devicesFolderName, _appFolderId);
  }
  
  /// 查找或创建文件夹
  Future<String?> _findOrCreateFolder(String folderName, String? parentId) async {
    if (_driveApi == null) return null;
    
    // 构建查询
    String query = "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
    if (parentId != null) {
      query += " and '$parentId' in parents";
    }
    
    // 查找文件夹
    final response = await _driveApi!.files.list(
      q: query,
      $fields: 'files(id, name)',
    );
    
    final files = response.files;
    if (files != null && files.isNotEmpty) {
      // 文件夹已存在
      return files.first.id;
    } else {
      // 创建文件夹
      final folder = drive.File()
        ..name = folderName
        ..mimeType = 'application/vnd.google-apps.folder';
      
      if (parentId != null) {
        folder.parents = [parentId];
      }
      
      final createdFolder = await _driveApi!.files.create(folder);
      return createdFolder.id;
    }
  }
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (_driveApi == null || _devicesFolderId == null) return false;
    
    try {
      // 将设备信息转换为JSON
      final deviceJson = CloudDataConverter.serialize(device);
      final deviceJsonStr = jsonEncode(deviceJson);
      
      // 查找设备文件
      final deviceFileName = 'device_${device.id}.json';
      final existingFile = await _findFile(deviceFileName, _devicesFolderId!);
      
      if (existingFile != null) {
        // 更新设备文件
        await _updateFile(existingFile, deviceJsonStr);
      } else {
        // 创建设备文件
        await _createFile(deviceFileName, deviceJsonStr, _devicesFolderId!);
      }
      
      return true;
    } catch (e) {
      debugPrint('注册设备失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<DeviceEntity>> getRegisteredDevicesFromCloud() async {
    if (_driveApi == null || _devicesFolderId == null) return [];
    
    try {
      // 查询设备文件夹中的所有文件
      final response = await _driveApi!.files.list(
        q: "'$_devicesFolderId' in parents and trashed=false",
        $fields: 'files(id, name)',
      );
      
      final files = response.files;
      if (files == null || files.isEmpty) return [];
      
      final devices = <DeviceEntity>[];
      
      for (final file in files) {
        if (file.id == null) continue;
        
        // 下载设备文件内容
        final content = await _downloadFile(file.id!);
        if (content != null) {
          try {
            final deviceJson = jsonDecode(content) as Map<String, dynamic>;
            final device = DeviceEntity.fromJson(deviceJson);
            devices.add(device);
          } catch (e) {
            debugPrint('解析设备文件失败: $e');
          }
        }
      }
      
      return devices;
    } catch (e) {
      debugPrint('获取注册设备失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncDeviceInfo(DeviceEntity device) async {
    return await doRegisterDeviceForSync(device);
  }
  
  @override
  Future<bool> syncDevicesFromCloud() async {
    // 这个方法在实际应用中应该将云端设备信息同步到本地设备注册表
    // 这里简单返回true，实际实现应该更复杂
    return true;
  }
  
  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_driveApi == null || _rulesFolderId == null) return false;
    
    try {
      // 将规则列表转换为JSON
      final rulesData = rules.map((rule) => CloudDataConverter.serialize(rule)).toList();
      final rulesJsonStr = jsonEncode(rulesData);
      
      // 查找规则文件
      const rulesFileName = 'rules.json';
      final existingFile = await _findFile(rulesFileName, _rulesFolderId!);
      
      if (existingFile != null) {
        // 更新规则文件
        await _updateFile(existingFile, rulesJsonStr);
      } else {
        // 创建规则文件
        await _createFile(rulesFileName, rulesJsonStr, _rulesFolderId!);
      }
      
      return true;
    } catch (e) {
      debugPrint('同步规则失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleBase>> doGetRulesFromCloud() async {
    if (_driveApi == null || _rulesFolderId == null) return [];
    
    try {
      // 查找规则文件
      const rulesFileName = 'rules.json';
      final existingFile = await _findFile(rulesFileName, _rulesFolderId!);
      
      if (existingFile != null && existingFile.id != null) {
        // 下载规则文件内容
        final content = await _downloadFile(existingFile.id!);
        if (content != null) {
          try {
            final rulesJsonList = jsonDecode(content) as List<dynamic>;
            final rules = rulesJsonList.map((ruleJson) {
              // 这里需要根据规则类型创建不同的规则对象
              // 实际实现应该更复杂，这里简化处理
              return CloudDataConverter.deserialize<RuleBase>(ruleJson as Map<String, dynamic>);
            }).toList();
            return rules;
          } catch (e) {
            debugPrint('解析规则文件失败: $e');
          }
        }
      }
      
      return [];
    } catch (e) {
      debugPrint('获取规则失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncSettings(Map<String, dynamic> settings) async {
    if (_driveApi == null || _settingsFolderId == null) return false;
    
    try {
      // 将设置转换为JSON字符串
      final settingsJsonStr = jsonEncode(settings);
      
      // 查找设置文件
      const settingsFileName = 'settings.json';
      final existingFile = await _findFile(settingsFileName, _settingsFolderId!);
      
      if (existingFile != null) {
        // 更新设置文件
        await _updateFile(existingFile, settingsJsonStr);
      } else {
        // 创建设置文件
        await _createFile(settingsFileName, settingsJsonStr, _settingsFolderId!);
      }
      
      return true;
    } catch (e) {
      debugPrint('同步设置失败: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    if (_driveApi == null || _settingsFolderId == null) return null;
    
    try {
      // 查找设置文件
      const settingsFileName = 'settings.json';
      final existingFile = await _findFile(settingsFileName, _settingsFolderId!);
      
      if (existingFile != null && existingFile.id != null) {
        // 下载设置文件内容
        final content = await _downloadFile(existingFile.id!);
        if (content != null) {
          try {
            return jsonDecode(content) as Map<String, dynamic>;
          } catch (e) {
            debugPrint('解析设置文件失败: $e');
          }
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('获取设置失败: $e');
      return null;
    }
  }
  
  @override
  Future<bool> syncHistory(List<Map<String, dynamic>> history) async {
    if (_driveApi == null || _historyFolderId == null) return false;
    
    try {
      // 将历史记录转换为JSON字符串
      final historyJsonStr = jsonEncode(history);
      
      // 查找历史记录文件
      const historyFileName = 'history.json';
      final existingFile = await _findFile(historyFileName, _historyFolderId!);
      
      if (existingFile != null) {
        // 更新历史记录文件
        await _updateFile(existingFile, historyJsonStr);
      } else {
        // 创建历史记录文件
        await _createFile(historyFileName, historyJsonStr, _historyFolderId!);
      }
      
      return true;
    } catch (e) {
      debugPrint('同步历史记录失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getHistoryFromCloud() async {
    if (_driveApi == null || _historyFolderId == null) return [];
    
    try {
      // 查找历史记录文件
      const historyFileName = 'history.json';
      final existingFile = await _findFile(historyFileName, _historyFolderId!);
      
      if (existingFile != null && existingFile.id != null) {
        // 下载历史记录文件内容
        final content = await _downloadFile(existingFile.id!);
        if (content != null) {
          try {
            final historyJsonList = jsonDecode(content) as List<dynamic>;
            return historyJsonList.cast<Map<String, dynamic>>();
          } catch (e) {
            debugPrint('解析历史记录文件失败: $e');
          }
        }
      }
      
      return [];
    } catch (e) {
      debugPrint('获取历史记录失败: $e');
      return [];
    }
  }
  
  /// 查找文件
  Future<drive.File?> _findFile(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    
    try {
      final response = await _driveApi!.files.list(
        q: "name='$fileName' and '$folderId' in parents and trashed=false",
        $fields: 'files(id, name, modifiedTime)',
      );
      
      final files = response.files;
      if (files != null && files.isNotEmpty) {
        return files.first;
      }
    } catch (e) {
      debugPrint('查找文件失败: $e');
    }
    
    return null;
  }
  
  /// 创建文件
  Future<drive.File?> _createFile(String fileName, String content, String folderId) async {
    if (_driveApi == null) return null;
    
    try {
      final contentBytes = utf8.encode(content);
      final mediaStream = http.ByteStream.fromBytes(contentBytes);
      final media = drive.Media(mediaStream, contentBytes.length);
      
      final driveFile = drive.File()
        ..name = fileName
        ..parents = [folderId];
      
      return await _driveApi!.files.create(
        driveFile,
        uploadMedia: media,
      );
    } catch (e) {
      debugPrint('创建文件失败: $e');
      return null;
    }
  }
  
  /// 更新文件
  Future<drive.File?> _updateFile(drive.File file, String content) async {
    if (_driveApi == null || file.id == null) return null;
    
    try {
      final contentBytes = utf8.encode(content);
      final mediaStream = http.ByteStream.fromBytes(contentBytes);
      final media = drive.Media(mediaStream, contentBytes.length);
      
      return await _driveApi!.files.update(
        drive.File(),
        file.id!,
        uploadMedia: media,
      );
    } catch (e) {
      debugPrint('更新文件失败: $e');
      return null;
    }
  }
  
  /// 下载文件
  Future<String?> _downloadFile(String fileId) async {
    if (_driveApi == null) return null;
    
    try {
      final response = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as http.Response;
      
      if (response.statusCode == 200) {
        return utf8.decode(response.bodyBytes);
      }
    } catch (e) {
      debugPrint('下载文件失败: $e');
    }
    
    return null;
  }
  
  @override
  Future<Map<String, dynamic>> getSyncStatus() async {
    final isConnected = await isConfigured();
    final lastSyncTime = DateTime.now(); // 这里应该从持久化存储中获取上次同步时间
    
    return {
      'isConnected': isConnected,
      'lastSyncTime': lastSyncTime.toIso8601String(),
      'serviceType': serviceType,
      'serviceName': serviceName,
      'pendingSyncOperations': 0, // 这里应该返回待同步的操作数量
    };
  }
}

/// 认证客户端
class _AuthenticatedClient extends http.BaseClient {
  final http.Client _client;
  final Map<String, String> _headers;
  
  _AuthenticatedClient(this._client, this._headers);
  
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

/// 创建规则对象的工厂方法
/// 根据规则类型创建不同的规则对象
RuleBase createRuleFromJson(Map<String, dynamic> json) {
  // 这里应该根据规则类型创建不同的规则对象
  // 例如：
  // final ruleType = json['type'] as String;
  // switch (ruleType) {
  //   case 'keyword':
  //     return KeywordRule.fromJson(json);
  //   case 'regex':
  //     return RegexRule.fromJson(json);
  //   default:
  //     throw Exception('未知的规则类型: $ruleType');
  // }
  
  // 由于我们没有具体的规则类实现，这里抛出异常
  throw UnimplementedError('需要实现具体的规则类型创建逻辑');
}