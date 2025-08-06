import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/cloud_sync/environment.dart';
import 'enhanced_cloud_sync_service.dart';
import 'sync_conflict_resolver.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;


/// Google Drive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class GoogleDriveSyncService extends EnhancedCloudSyncService {  
  /// Reference to the Riverpod container
  final Ref? ref;
  late final GoogleSignIn _googleSignIn;
  
  // 初始化 GoogleSignIn 实例
  void _initGoogleSignIn() {
    _googleSignIn = GoogleSignIn.instance;
    // 根据 google_sign_in_android 文档，如果项目中使用 google-services.json，
    // 则无需在 Dart 代码中传递客户端 ID。插件会自动进行配置。
    _googleSignIn.initialize();
  }
  
  drive.DriveApi? _driveApi;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Google Drive folder configuration
  
  // File paths in Google Drive
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _devicesFolderName;
  
  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _devicesFolderName = 'Devices';
  }
  GoogleSignInAccount? _currentUser;
  
  // Folder IDs cache
  String? _appFolderId;
  String? _rulesFolderId;
  String? _settingsFolderId;
  String? _notificationsFolderId;
  String? _devicesFolderId;
  
  @override
  String get serviceType => 'GoogleDrive';
  
  @override
  String get serviceName => 'Google Drive';
  
  /// Constructor with required config repository and optional conflict resolution strategy
  GoogleDriveSyncService({
    required super.configRepository,
    super.defaultStrategy,
    required this.ref,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    // Set custom app folder name if provided
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    // 初始化 GoogleSignIn 实例
    _initGoogleSignIn();
    
    // 监听认证事件
    _googleSignIn.authenticationEvents.listen((event) {
      debugPrint('Google认证事件: $event');
      if (event is GoogleSignInAuthenticationEventSignIn) {
        _currentUser = event.user;
        if (_currentUser != null) {
          _initDriveApi();
        }
      } else if (event is GoogleSignInAuthenticationEventSignOut) {
        _currentUser = null;
        _driveApi = null;
      }
    }, onError: (error) {
      debugPrint('Google认证事件错误: $error');
      _currentUser = null;
      _driveApi = null;
    });
    
    // Try to sign in silently if user was previously signed in
    try {
      // 尝试轻量级认证
      final future = _googleSignIn.attemptLightweightAuthentication();
      if (future != null) {
        _currentUser = await future;
        if (_currentUser != null) {
          await _initDriveApi();
        }
      }
    } catch (e) {
      debugPrint('Error signing in silently: $e');
    }
    
    _isInitialized = true;
  }
  
  Future<void> _initDriveApi() async {
    if (_currentUser == null) return;

    try {
      // 获取认证头
      final authHeaders = await _currentUser!.authorizationClient.authorizationHeaders(
        const ['https://www.googleapis.com/auth/drive.file'],
      );

      if (authHeaders == null) {
        debugPrint('获取授权头失败，可能需要重新授权。');
        _driveApi = null; // 确保API客户端状态一致
        return;
      }

      final authenticatedClient = _AuthenticatedClient(
        http.Client(),
        authHeaders,
      );

      _driveApi = drive.DriveApi(authenticatedClient);
      debugPrint('Drive API初始化成功');
    } catch (e) {
      debugPrint('初始化Drive API失败: $e');
      _driveApi = null; // 确保API客户端状态一致
    }
  }
  
  @override
  Future<bool> isConfigured() async {
    return _currentUser != null && _driveApi != null;
  }
  
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      if (!_isInitialized) {
        await doInitialize({});
      }

      // 步骤 1: 认证用户
      // 这将触发 Google 登录界面
      final GoogleSignInAccount? account = await _googleSignIn.authenticate();
      if (account == null) {
        debugPrint('Google Sign-In was cancelled by the user.');
        return false;
      }
      _currentUser = account;
      debugPrint('Authentication successful for ${_currentUser!.email}');

      // 步骤 2: 请求授权
      // 检查是否已经拥有所需的权限
      final isAuthorized = await _currentUser!.authorizationClient.authorizationForScopes(
        const ['https://www.googleapis.com/auth/drive.file'],
      );

      if (isAuthorized == null) {
        // 如果没有，则请求权限
        debugPrint('Requesting authorization for Google Drive...');
        final requestedAuth = await _currentUser!.authorizationClient.authorizeScopes(
          const ['https://www.googleapis.com/auth/drive.file'],
        );
        if (requestedAuth == null) {
          debugPrint('Authorization for Google Drive was denied.');
          await doDisconnect(); // 清理状态
          return false;
        }
      }
      debugPrint('Authorization for Google Drive granted.');

      // 初始化 Drive API
      await _initDriveApi();
      if (_driveApi == null) {
        debugPrint('Failed to initialize Drive API after authorization.');
        return false;
      }

      // 创建云端文件夹
      await _createAppFolders();

      return true;
    } catch (e) {
      debugPrint('An error occurred during Google Drive connection: $e');
      if (e is PlatformException && e.message != null && e.message!.contains('28444')) {
        debugPrint('Error [28444]: Developer console is not set up correctly. This is a configuration issue. Please verify the following in your Google Cloud/Firebase console:');
        debugPrint('1. The package name in google-services.json matches your app\'s package name.');
        debugPrint('2. The SHA-1 fingerprint for your signing key is correctly added to the Firebase project settings.');
        debugPrint('3. The Google Drive API is enabled for your project.');
      }
      await doDisconnect();
      return false;
    }
  }
  
  Future<void> _createAppFolders() async {
    if (_driveApi == null) return;
    
    try {
      // Create app root folder
      _appFolderId = await _getOrCreateFolder(_appFolderName, null);
      
      // Create subfolders
      _rulesFolderId = await _getOrCreateFolder(_rulesFolderName, _appFolderId);
      _settingsFolderId = await _getOrCreateFolder(_settingsFolderName, _appFolderId);
      _devicesFolderId = await _getOrCreateFolder(_devicesFolderName, _appFolderId);
    } catch (e) {
      debugPrint('Error creating Google Drive folders: $e');
    }
  }
  
  Future<String?> _getOrCreateFolder(String folderName, String? parentId) async {
    if (_driveApi == null) return null;
    
    try {
      // Search for existing folder
      String query = "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
      if (parentId != null) {
        query += " and '$parentId' in parents";
      }
      
      final fileList = await _driveApi!.files.list(
        q: query,
        $fields: 'files(id, name)',
      );
      
      final files = fileList.files;
      if (files != null && files.isNotEmpty) {
        return files.first.id;
      }
      
      // Create folder if it doesn't exist
      final folder = drive.File();
      folder.name = folderName;
      folder.mimeType = 'application/vnd.google-apps.folder';
      
      if (parentId != null) {
        folder.parents = [parentId];
      }
      
      final createdFolder = await _driveApi!.files.create(folder);
      return createdFolder.id;
    } catch (e) {
      debugPrint('Error getting or creating folder: $e');
      return null;
    }
  }
  
  @override
  Future<bool> doDisconnect() async {
    try {
      // disconnect 会撤销授权并登出，比 signOut 更彻底
      await _googleSignIn.disconnect();

      // 重置实例变量
      _currentUser = null;
      _driveApi = null;
      _appFolderId = null;
      _rulesFolderId = null;
      _settingsFolderId = null;
      _notificationsFolderId = null;
      _devicesFolderId = null;

      return true;
    } catch (e) {
      debugPrint('Error disconnecting from Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_driveApi == null || _rulesFolderId == null) {
      return false;
    }
    
    try {
      // Convert rules to JSON using CloudDataConverter
      final rulesJson = jsonEncode(rules.map((rule) => CloudDataConverter.serialize(rule)).toList());
      
      // Check if rules file already exists
      final existingFile = await _findFile('rules.json', _rulesFolderId!);
      
      if (existingFile != null) {
        // Update existing file
        final media = drive.Media(
          Stream.value(utf8.encode(rulesJson)),
          rulesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.update(
          drive.File(),
          existingFile,
          uploadMedia: media,
        );
      } else {
        // Create new file
        final file = drive.File();
        file.name = 'rules.json';
        file.parents = [_rulesFolderId!];
        
        final media = drive.Media(
          Stream.value(utf8.encode(rulesJson)),
          rulesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.create(
          file,
          uploadMedia: media,
        );
      }
      
      return true;
    } catch (e) {
      debugPrint('Error syncing rules to Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleBase>> getRulesFromCloud() async {
    if (_driveApi == null || _rulesFolderId == null || !await isConfigured()) {
      return [];
    }
    
    try {
      // Find rules file
      final fileId = await _findFile('rules.json', _rulesFolderId!);
      if (fileId == null) return [];
      
      // Download file content
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;
      
      final bytes = await _readMediaBytes(media);
      final rulesJson = utf8.decode(bytes);
      
      final List<dynamic> rulesList = jsonDecode(rulesJson);
      return rulesList
          .map((json) => CloudDataConverter.deserialize<RuleBase>(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting rules from Google Drive: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doSyncSettings(Map<String, dynamic> settings) async {
    if (_driveApi == null || _settingsFolderId == null) {
      return false;
    }
    
    try {
      // Convert settings to JSON
      final settingsJson = jsonEncode(settings);
      
      // Check if settings file already exists
      final existingFile = await _findFile('app_settings.json', _settingsFolderId!);
      
      if (existingFile != null) {
        // Update existing file
        final media = drive.Media(
          Stream.value(utf8.encode(settingsJson)),
          settingsJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.update(
          drive.File(),
          existingFile,
          uploadMedia: media,
        );
      } else {
        // Create new file
        final file = drive.File();
        file.name = 'app_settings.json';
        file.parents = [_settingsFolderId!];
        
        final media = drive.Media(
          Stream.value(utf8.encode(settingsJson)),
          settingsJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.create(
          file,
          uploadMedia: media,
        );
      }
      
      return true;
    } catch (e) {
      debugPrint('Error syncing settings to Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    if (_driveApi == null || _settingsFolderId == null || !await isConfigured()) {
      return null;
    }
    
    try {
      // Find settings file
      final fileId = await _findFile('app_settings.json', _settingsFolderId!);
      if (fileId == null) return null;
      
      // Download file content
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;
      
      final bytes = await _readMediaBytes(media);
      final settingsJson = utf8.decode(bytes);
      
      return jsonDecode(settingsJson) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error getting settings from Google Drive: $e');
      return null;
    }
  }
  
  @override
  Future<bool> doSyncNotificationHistory(List<Map<String, dynamic>> notifications) async {
    if (_driveApi == null || _notificationsFolderId == null) {
      return false;
    }
    
    try {
      // Convert notifications to JSON
      final notificationsJson = jsonEncode(notifications);
      
      // Check if notifications file already exists
      final existingFile = await _findFile('notification_history.json', _notificationsFolderId!);
      
      if (existingFile != null) {
        // Update existing file
        final media = drive.Media(
          Stream.value(utf8.encode(notificationsJson)),
          notificationsJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.update(
          drive.File(),
          existingFile,
          uploadMedia: media,
        );
      } else {
        // Create new file
        final file = drive.File();
        file.name = 'notification_history.json';
        file.parents = [_notificationsFolderId!];
        
        final media = drive.Media(
          Stream.value(utf8.encode(notificationsJson)),
          notificationsJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.create(
          file,
          uploadMedia: media,
        );
      }
      
      return true;
    } catch (e) {
      debugPrint('Error syncing notification history to Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    if (_driveApi == null || _notificationsFolderId == null || !await isConfigured()) {
      return [];
    }
    
    try {
      // Find notifications file
      final fileId = await _findFile('notification_history.json', _notificationsFolderId!);
      if (fileId == null) return [];
      
      // Download file content
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;
      
      final bytes = await _readMediaBytes(media);
      final notificationsJson = utf8.decode(bytes);
      
      final List<dynamic> notificationsList = jsonDecode(notificationsJson);
      return notificationsList
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } catch (e) {
      debugPrint('Error getting notification history from Google Drive: $e');
      return [];
    }
  }
  
  Future<String?> _findFile(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    
    try {
      final query = "name='$fileName' and '$folderId' in parents and trashed=false";
      final fileList = await _driveApi!.files.list(
        q: query,
        $fields: 'files(id, name)',
      );
      
      final files = fileList.files;
      if (files != null && files.isNotEmpty) {
        return files.first.id;
      }
      return null;
    } catch (e) {
      debugPrint('Error finding file: $e');
      return null;
    }
  }
  
  Future<List<int>> _readMediaBytes(drive.Media media) async {
    final completer = Completer<List<int>>();
    final bytesBuilder = BytesBuilder();
    
    media.stream.listen(
      (data) {
        bytesBuilder.add(data);
      },
      onDone: () {
        completer.complete(bytesBuilder.toBytes());
      },
      onError: (error) {
        completer.completeError(error);
      },
      cancelOnError: true,
    );
    
    return completer.future;
  }
  
  // These methods are now implemented in the EnhancedCloudSyncService base class:
  // - scheduleAutomaticSync
  // - cancelAutomaticSync
  // - resolveSyncConflicts
  // - getSyncStatus
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (_driveApi == null || _devicesFolderId == null) {
      return false;
    }
    
    try {
      // Get existing devices first to avoid duplicates
      final devices = await doGetRegisteredDevicesFromCloud();
      
      // Check if device already exists
      final existingDeviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (existingDeviceIndex >= 0) {
        // Update existing device
        devices[existingDeviceIndex] = device;
      } else {
        // Add new device
        devices.add(device);
      }
      
      // Convert devices to JSON
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      
      // Check if devices file already exists
      final existingFile = await _findFile('registered_devices.json', _devicesFolderId!);
      
      if (existingFile != null) {
        // Update existing file
        final media = drive.Media(
          Stream.value(utf8.encode(devicesJson)),
          devicesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.update(
          drive.File(),
          existingFile,
          uploadMedia: media,
        );
      } else {
        // Create new file
        final file = drive.File();
        file.name = 'registered_devices.json';
        file.parents = [_devicesFolderId!];
        
        final media = drive.Media(
          Stream.value(utf8.encode(devicesJson)),
          devicesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.create(
          file,
          uploadMedia: media,
        );
      }
      
      return true;
    } catch (e) {
      debugPrint('Error registering device for sync: $e');
      return false;
    }
  }
  
  @override
  Future<List<DeviceEntity>> doGetRegisteredDevicesFromCloud() async {
    if (_driveApi == null || _devicesFolderId == null || !await isConfigured()) {
      return [];
    }
    
    try {
      // Find devices file
      final fileId = await _findFile('registered_devices.json', _devicesFolderId!);
      if (fileId == null) return [];
      
      // Download file content
      final media = await _driveApi!.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;
      
      final bytes = await _readMediaBytes(media);
      final devicesJson = utf8.decode(bytes);
      
      final List<dynamic> devicesList = jsonDecode(devicesJson);
      return devicesList
          .map((json) => DeviceEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting registered devices from Google Drive: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doSyncDeviceInfo(DeviceEntity device) async {
    if (_driveApi == null || _devicesFolderId == null) {
      return false;
    }
    
    try {
      // Get existing devices
      final devices = await doGetRegisteredDevicesFromCloud();
      
      // Update device info
      final deviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (deviceIndex >= 0) {
        // Update existing device
        devices[deviceIndex] = device;
      } else {
        // Add new device if not found
        devices.add(device);
      }
      
      // Convert devices to JSON
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      
      // Check if devices file already exists
      final existingFile = await _findFile('registered_devices.json', _devicesFolderId!);
      
      if (existingFile != null) {
        // Update existing file
        final media = drive.Media(
          Stream.value(utf8.encode(devicesJson)),
          devicesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.update(
          drive.File(),
          existingFile,
          uploadMedia: media,
        );
      } else {
        // Create new file
        final file = drive.File();
        file.name = 'registered_devices.json';
        file.parents = [_devicesFolderId!];
        
        final media = drive.Media(
          Stream.value(utf8.encode(devicesJson)),
          devicesJson.length,
          contentType: 'application/json',
        );
        
        await _driveApi!.files.create(
          file,
          uploadMedia: media,
        );
      }
      
      return true;
    } catch (e) {
      debugPrint('Error syncing device info: $e');
      return false;
    }
  }
  
  @override
  Future<bool> syncDevicesFromCloud() async {
    try {
      // Get devices from cloud
      final cloudDevices = await getRegisteredDevicesFromCloud();
      if (cloudDevices.isEmpty) return true;
      
      // Use DeviceManagementService to update local device registry
      final deviceManagementService = ref?.read(deviceManagementServiceProvider);
      
      if (deviceManagementService != null) {
        // Register each cloud device in the local registry
        for (final device in cloudDevices) {
          await deviceManagementService.registerDevice(device);
        }
      } else {
        debugPrint('Warning: DeviceManagementService not available for device sync');
      }
      
      return true;
    } catch (e) {
      debugPrint('Error syncing devices from cloud: $e');
      return false;
    }
  }
}

/// A client that adds authentication headers to outgoing requests
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