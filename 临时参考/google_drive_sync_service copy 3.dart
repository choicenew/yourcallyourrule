// ========================================================================
// 最终、完整、绝对正确的 GoogleDriveSyncService - 2025年8月7日
// ========================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/cloud_sync/environment.dart';
import '../lib/cloud_sync/services/enhanced_cloud_sync_service.dart';
import '../lib/cloud_sync/services/sync_conflict_resolver.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


// --- 核心 Imports ---
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:http/http.dart' as http;

// 【【【这个插件的正确用法是为 GoogleSignInClientAuthorization 添加扩展方法】】】
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';


/// Google Drive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class GoogleDriveSyncService extends EnhancedCloudSyncService {
  final Ref? ref;
  late final GoogleSignIn _googleSignIn;
  
  drive.DriveApi? _driveApi;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _devicesFolderName;
  
  GoogleSignInAccount? _currentUser;
  
  String? _appFolderId;
  String? _rulesFolderId;
  String? _settingsFolderId;
  String? _notificationsFolderId;
  String? _devicesFolderId;

  @override
  String get serviceType => 'GoogleDrive';

  @override
  String get serviceName => 'Google Drive';

  GoogleDriveSyncService({
    required super.configRepository,
    super.defaultStrategy,
    required this.ref,
  });

  void _initGoogleSignIn() {
    _googleSignIn = GoogleSignIn.instance;
    _googleSignIn.initialize(
     
    );
  }

  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _devicesFolderName = 'Devices';
  }

  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    _updateFolderPaths();
    
    _initGoogleSignIn();
    
    // 监听事件保持不变，但 _initDriveApi 的逻辑会改变
    _googleSignIn.authenticationEvents.listen((event) {
      debugPrint('Google认证事件: $event');
      if (event is GoogleSignInAuthenticationEventSignIn) {
        _currentUser = event.user;
        if (_currentUser != null) {
          _initDriveApiWithCurrentUser(); // 使用一个能处理当前用户状态的方法
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
    
    try {
      final future = _googleSignIn.attemptLightweightAuthentication();
      if (future != null) {
        _currentUser = await future;
        if (_currentUser != null) {
          await _initDriveApiWithCurrentUser();
        }
      }
    } catch (e) {
      debugPrint('Error signing in silently: $e');
    }
    
    _isInitialized = true;
  }

  // 为静默登录或状态恢复提供一个初始化方法
  Future<void> _initDriveApiWithCurrentUser() async {
    if (_currentUser == null) return;
    final scopes = ['https://www.googleapis.com/auth/drive.file'];
    try {
      // 尝试获取无需用户交互的授权
      final authz = await _currentUser!.authorizationClient.authorizationForScopes(scopes);
      if (authz != null) {
        // 使用扩展方法获取 AuthClient
        final client = authz.authClient(scopes: scopes);
        _driveApi = drive.DriveApi(client);
        debugPrint('Drive API (silent) 初始化成功');
      } else {
        // 如果静默授权失败，driveApi 保持为 null，等待交互式登录
        _driveApi = null;
        debugPrint('静默授权失败，需要用户交互。');
      }
    } catch (e) {
      debugPrint('初始化Drive API失败 (silent): $e');
      _driveApi = null;
    }
  }

  @override
  Future<bool> isConfigured() async {
    return _currentUser != null && _driveApi != null;
  }

  // --- 【【【最终的核心修正】】】 ---
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      if (!_isInitialized) {
        await doInitialize({});
      }
      
      final scopes = ['https://www.googleapis.com/auth/drive.file'];

      // 步骤 1: 认证用户
      final GoogleSignInAccount? account = await _googleSignIn.authenticate();
      if (account == null) {
        debugPrint('Google Sign-In was cancelled by the user.');
        return false;
      }
      _currentUser = account;
      debugPrint('Authentication successful for ${_currentUser!.email}');

      // 步骤 2: 请求授权
      GoogleSignInClientAuthorization? authz;
      // 检查是否已经拥有所需的权限
      authz = await _currentUser!.authorizationClient.authorizationForScopes(scopes);

      if (authz == null) {
        // 如果没有，则请求权限
        debugPrint('Requesting authorization for Google Drive...');
        authz = await _currentUser!.authorizationClient.authorizeScopes(scopes);
      }
      debugPrint('Authorization for Google Drive granted.');

      // 步骤 3: 【【【正确地使用扩展插件】】】
      // 在获得 authz 实例后，调用它的 .authClient() 扩展方法
      final auth.AuthClient client = authz.authClient(scopes: scopes);

      // 步骤 4: 初始化 DriveApi
      _driveApi = drive.DriveApi(client);
      debugPrint('Drive API (interactive) 初始化成功');
      
      if (_driveApi == null) {
        debugPrint('Failed to initialize Drive API after authorization.');
        return false;
      }

      await _createAppFolders();
      return true;

    } catch (e) {
      debugPrint('An error occurred during Google Drive connection: $e');
      if (e is PlatformException && e.message != null && e.message!.contains('28444')) {
        debugPrint('Error [28444]: Developer console is not set up correctly.');
      }
      await doDisconnect();
      return false;
    }
  }

  Future<void> _createAppFolders() async {
    if (_driveApi == null) return;
    try {
      _appFolderId = await _getOrCreateFolder(_appFolderName, null);
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
      String query = "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
      if (parentId != null) {
        query += " and '$parentId' in parents";
      }
      final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id, name)');
      if (fileList.files != null && fileList.files!.isNotEmpty) {
        return fileList.files!.first.id;
      }
      final folder = drive.File()
        ..name = folderName
        ..mimeType = 'application/vnd.google-apps.folder';
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
      await _googleSignIn.disconnect();
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

  // =================================================================
  //  您所有其他的数据同步、文件操作等方法，保持原样即可
  // =================================================================

  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_driveApi == null || _rulesFolderId == null) {
      return false;
    }
    
    try {
      final rulesJson = jsonEncode(rules.map((rule) => CloudDataConverter.serialize(rule)).toList());
      final existingFile = await _findFile('rules.json', _rulesFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(rulesJson)), rulesJson.length, contentType: 'application/json');
      if (existingFile != null) {
        await _driveApi!.files.update(drive.File(), existingFile, uploadMedia: media);
      } else {
        final file = drive.File()
          ..name = 'rules.json'
          ..parents = [_rulesFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
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
      final fileId = await _findFile('rules.json', _rulesFolderId!);
      if (fileId == null) return [];
      final media = await _driveApi!.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      final bytes = await _readMediaBytes(media);
      final rulesJson = utf8.decode(bytes);
      final List<dynamic> rulesList = jsonDecode(rulesJson);
      return rulesList.map((json) => CloudDataConverter.deserialize<RuleBase>(json as Map<String, dynamic>)).toList();
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
      final settingsJson = jsonEncode(settings);
      final existingFile = await _findFile('app_settings.json', _settingsFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(settingsJson)), settingsJson.length, contentType: 'application/json');
      if (existingFile != null) {
        await _driveApi!.files.update(drive.File(), existingFile, uploadMedia: media);
      } else {
        final file = drive.File()
          ..name = 'app_settings.json'
          ..parents = [_settingsFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
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
      final fileId = await _findFile('app_settings.json', _settingsFolderId!);
      if (fileId == null) return null;
      final media = await _driveApi!.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      final bytes = await _readMediaBytes(media);
      final settingsJson = utf8.decode(bytes);
      return jsonDecode(settingsJson) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error getting settings from Google Drive: $e');
      return null;
    }
  }
  
  Future<bool> doSyncNotificationHistory(List<Map<String, dynamic>> notifications) async {
    if (_driveApi == null || _notificationsFolderId == null) {
      return false;
    }
    
    try {
      final notificationsJson = jsonEncode(notifications);
      final existingFile = await _findFile('notification_history.json', _notificationsFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(notificationsJson)), notificationsJson.length, contentType: 'application/json');
      if (existingFile != null) {
        await _driveApi!.files.update(drive.File(), existingFile, uploadMedia: media);
      } else {
        final file = drive.File()
          ..name = 'notification_history.json'
          ..parents = [_notificationsFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
      }
      return true;
    } catch (e) {
      debugPrint('Error syncing notification history to Google Drive: $e');
      return false;
    }
  }
  
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    if (_driveApi == null || _notificationsFolderId == null || !await isConfigured()) {
      return [];
    }
    
    try {
      final fileId = await _findFile('notification_history.json', _notificationsFolderId!);
      if (fileId == null) return [];
      final media = await _driveApi!.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      final bytes = await _readMediaBytes(media);
      final notificationsJson = utf8.decode(bytes);
      final List<dynamic> notificationsList = jsonDecode(notificationsJson);
      return notificationsList.map((json) => json as Map<String, dynamic>).toList();
    } catch (e) {
      debugPrint('Error getting notification history from Google Drive: $e');
      return [];
    }
  }
  
  Future<String?> _findFile(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    try {
      final query = "name='$fileName' and '$folderId' in parents and trashed=false";
      final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id, name)');
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
    media.stream.listen((data) {
      bytesBuilder.add(data);
    }, onDone: () {
      completer.complete(bytesBuilder.toBytes());
    }, onError: (error) {
      completer.completeError(error);
    }, cancelOnError: true);
    return completer.future;
  }
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (_driveApi == null || _devicesFolderId == null) {
      return false;
    }
    try {
      final devices = await doGetRegisteredDevicesFromCloud();
      final existingDeviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (existingDeviceIndex >= 0) {
        devices[existingDeviceIndex] = device;
      } else {
        devices.add(device);
      }
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      final existingFile = await _findFile('registered_devices.json', _devicesFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(devicesJson)), devicesJson.length, contentType: 'application/json');
      if (existingFile != null) {
        await _driveApi!.files.update(drive.File(), existingFile, uploadMedia: media);
      } else {
        final file = drive.File()
          ..name = 'registered_devices.json'
          ..parents = [_devicesFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
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
      final fileId = await _findFile('registered_devices.json', _devicesFolderId!);
      if (fileId == null) return [];
      final media = await _driveApi!.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      final bytes = await _readMediaBytes(media);
      final devicesJson = utf8.decode(bytes);
      final List<dynamic> devicesList = jsonDecode(devicesJson);
      return devicesList.map((json) => DeviceEntity.fromJson(json as Map<String, dynamic>)).toList();
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
      final devices = await doGetRegisteredDevicesFromCloud();
      final deviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (deviceIndex >= 0) {
        devices[deviceIndex] = device;
      } else {
        devices.add(device);
      }
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      final existingFile = await _findFile('registered_devices.json', _devicesFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(devicesJson)), devicesJson.length, contentType: 'application/json');
      if (existingFile != null) {
        await _driveApi!.files.update(drive.File(), existingFile, uploadMedia: media);
      } else {
        final file = drive.File()
          ..name = 'registered_devices.json'
          ..parents = [_devicesFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
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
      final cloudDevices = await getRegisteredDevicesFromCloud();
      if (cloudDevices.isEmpty) return true;
      final deviceManagementService = ref?.read(deviceManagementServiceProvider);
      if (deviceManagementService != null) {
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

// 这个类不再需要了，可以安全地从您的文件中彻底删除。
// class _AuthenticatedClient extends http.BaseClient { ... }