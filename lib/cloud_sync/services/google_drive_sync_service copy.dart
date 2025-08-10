import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/cloud_sync/environment.dart';
import 'enhanced_cloud_sync_service.dart';
import 'sync_conflict_resolver.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

// 定义服务需要的权限范围
const List<String> _googleDriveScopes = <String>[
  drive.DriveApi.driveFileScope,
];

/// Google Drive implementation of the CloudSyncService using the latest google_sign_in v7+ API.
class GoogleDriveSyncService extends EnhancedCloudSyncService {
  final Ref? ref;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  
  drive.DriveApi? _driveApi;
  GoogleSignInAccount? _currentUser;
  bool _isGoogleSignInInitialized = false;

  // Folder configuration
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _devicesFolderName;
  // 注意: 你的代码中有 _notificationsFolderId，但没有在 _updateFolderPaths 中初始化
  // 这里暂时注释掉，如果需要请在 _updateFolderPaths 中添加
  // String? _notificationsFolderId; 

  @override
  String get serviceType => 'GoogleDrive';
  @override
  String get serviceName => 'Google Drive';

  GoogleDriveSyncService({
    required super.configRepository,
    super.defaultStrategy,
    required this.ref,
  });

  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _devicesFolderName = 'Devices';
  }

  // --- Core Authentication and Initialization Logic (v7+ Style) ---

  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isGoogleSignInInitialized) return;

    debugPrint('GoogleDriveSyncService: Initializing...');
    
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    _updateFolderPaths();

    try {
      await _googleSignIn.initialize(
        serverClientId: Environment.googleServerClientId,
      );
      _isGoogleSignInInitialized = true;
      debugPrint('GoogleSignIn initialized successfully.');

      _googleSignIn.authenticationEvents.listen(_handleAuthEvent, onError: (e) {
        debugPrint('GoogleSignIn Authentication Error: $e');
        _resetState();
      });
      
      debugPrint('Ready for user-initiated connection.');

    } catch (e) {
      debugPrint('Failed to initialize GoogleSignIn: $e');
      _isGoogleSignInInitialized = false;
    }
  }
  
  Future<void> _handleAuthEvent(GoogleSignInAuthenticationEvent event) async {
    debugPrint('GoogleDriveSyncService: Auth event received: ${event.runtimeType}');
    
    GoogleSignInAccount? user;
    if (event is GoogleSignInAuthenticationEventSignIn) {
      user = event.user;
    } else {
      user = null;
    }

    if (user == null) {
      _resetState();
      return;
    }

    _currentUser = user;
    
    final authorization = await user.authorizationClient.authorizationForScopes(_googleDriveScopes);
    if (authorization != null) {
      debugPrint('Existing authorization found. Initializing Drive API...');
      await _initDriveApi(user);
    } else {
      debugPrint('No existing authorization found for Drive scopes. Waiting for user to connect.');
    }
  }

  Future<void> _initDriveApi(GoogleSignInAccount user) async {
    try {
      final authHeaders = await user.authorizationClient.authorizationHeaders(_googleDriveScopes);
      if (authHeaders == null) {
        throw Exception('Failed to get authorization headers.');
      }
      final authenticatedClient = _AuthenticatedClient(http.Client(), authHeaders);
      _driveApi = drive.DriveApi(authenticatedClient);
      debugPrint('Drive API initialized successfully.');
    } catch (e) {
      debugPrint('Failed to initialize Drive API: $e');
      _driveApi = null;
    }
  }

  @override
  Future<bool> isConfigured() async {
    return _currentUser != null && _driveApi != null;
  }

  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    if (!_isGoogleSignInInitialized) {
      debugPrint('GoogleSignIn is not initialized. Cannot connect.');
      return false;
    }

    try {
      GoogleSignInAccount? account = _googleSignIn.currentUser;
      if (account == null) {
        debugPrint('User not signed in. Starting interactive authentication...');
        account = await _googleSignIn.authenticate();
        if (account == null) {
          debugPrint('Authentication cancelled by user.');
          return false;
        }
        _currentUser = account;
      }
      debugPrint('Authentication successful for: ${account.email}');

      debugPrint('Requesting Drive authorization...');
      await account.authorizationClient.authorizeScopes(_googleDriveScopes);
      debugPrint('Authorization successful.');

      await _initDriveApi(account);
      if (_driveApi == null) {
        throw Exception('Drive API initialization failed after authorization.');
      }

      await _createAppFolders();

      return true;
    } catch (e) {
      debugPrint('An error occurred during Google Drive connection: $e');
      await doDisconnect();
      return false;
    }
  }

  @override
  Future<bool> doDisconnect() async {
    debugPrint('Disconnecting from Google Drive...');
    try {
      await _googleSignIn.disconnect();
      _resetState();
      return true;
    } catch (e) {
      debugPrint('Error disconnecting: $e');
      _resetState();
      return false;
    }
  }
  
  void _resetState() {
    _currentUser = null;
    _driveApi = null;
    _appFolderId = null;
    _rulesFolderId = null;
    _settingsFolderId = null;
    _devicesFolderId = null;
  }
  
  // --- Data Syncing Logic ---
  
  Future<void> _createAppFolders() async {
    if (_driveApi == null) throw Exception("Drive API not initialized.");
    _appFolderId = await _getOrCreateFolder(_appFolderName, null);
    _rulesFolderId = await _getOrCreateFolder(_rulesFolderName, _appFolderId);
    _settingsFolderId = await _getOrCreateFolder(_settingsFolderName, _appFolderId);
    _devicesFolderId = await _getOrCreateFolder(_devicesFolderName, _appFolderId);
    debugPrint("Cloud folders are ready.");
  }

  Future<String?> _getOrCreateFolder(String folderName, String? parentId) async {
    if (_driveApi == null) return null;
    String query = "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
    if (parentId != null) {
      query += " and '$parentId' in parents";
    }
    final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id)');
    if (fileList.files != null && fileList.files!.isNotEmpty) {
      return fileList.files!.first.id;
    }
    final folder = drive.File()
      ..name = folderName
      ..mimeType = 'application/vnd.google-apps.folder'
      ..parents = parentId != null ? [parentId] : null;
    final createdFolder = await _driveApi!.files.create(folder);
    return createdFolder.id;
  }
  
  Future<String?> _findFile(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    final query = "name='$fileName' and '$folderId' in parents and trashed=false";
    final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id)');
    return fileList.files?.firstOrNull?.id;
  }

  Future<Uint8List> _readMediaBytes(drive.Media media) async {
    final completer = Completer<Uint8List>();
    final bytesBuilder = BytesBuilder();
    media.stream.listen(
      bytesBuilder.add,
      onDone: () => completer.complete(bytesBuilder.toBytes()),
      onError: completer.completeError,
      cancelOnError: true,
    );
    return completer.future;
  }

  // ***************************************************************
  // *** 以下是补全的、您原始代码中正确的同步方法实现 ***
  // ***************************************************************

  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_driveApi == null || _rulesFolderId == null) {
      debugPrint("Sync failed: Drive API not ready.");
      return false;
    }
    
    try {
      final rulesJson = jsonEncode(rules.map((rule) => CloudDataConverter.serialize(rule)).toList());
      final media = drive.Media(Stream.value(utf8.encode(rulesJson)), utf8.encode(rulesJson).length, contentType: 'application/json');
      
      final existingFileId = await _findFile('rules.json', _rulesFolderId!);
      
      if (existingFileId != null) {
        await _driveApi!.files.update(drive.File(), existingFileId, uploadMedia: media);
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
    if (!await isConfigured() || _rulesFolderId == null) {
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
    if (!await isConfigured() || _settingsFolderId == null) {
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
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    return doSyncDeviceInfo(device); // 注册和同步设备信息的逻辑是相同的
  }

  @override
  Future<List<DeviceEntity>> doGetRegisteredDevicesFromCloud() async {
    if (!await isConfigured() || _devicesFolderId == null) {
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
      
      final devicesJson = jsonEncode(devices.map((d) => d.toJson()).toList());
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
      final cloudDevices = await doGetRegisteredDevicesFromCloud();
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