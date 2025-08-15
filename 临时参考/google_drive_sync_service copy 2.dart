import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import '../lib/cloud_sync/services/enhanced_cloud_sync_service.dart';
import '../lib/cloud_sync/services/sync_conflict_resolver.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

/// Google Drive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities.
///
/// **This version is strictly aligned with the google_sign_in v7.1.1 API.**
class GoogleDriveSyncService extends EnhancedCloudSyncService {
  /// Reference to the Riverpod container.
  final Ref? ref;

  /// The single instance of the GoogleSignIn plugin.
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  drive.DriveApi? _driveApi;
  GoogleSignInAccount? _currentUser;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Google Drive folder configuration
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _devicesFolderName;
  
  /// The scopes required by the application.
  static const List<String> _scopes = <String>[
    drive.DriveApi.driveFileScope,
  ];

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
  
  /// Constructor with required config repository and optional conflict resolution strategy.
  GoogleDriveSyncService({
    required super.configRepository,
    super.defaultStrategy,
    required this.ref,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    _updateFolderPaths();
    
    // Must be called once before any other method.
    await _googleSignIn.initialize();

    // Listen to authentication events to update the UI and API client.
    _googleSignIn.authenticationEvents.listen(_handleAuthenticationEvent, 
        onError: (error) {
            debugPrint('Authentication Error: $error');
            _clearState();
        });

    // Attempt to sign in silently. This will trigger the stream if successful.
    _googleSignIn.attemptLightweightAuthentication();
    
    _isInitialized = true;
  }

  /// Handles events from the authenticationEvents stream.
  void _handleAuthenticationEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
        case GoogleSignInAuthenticationEventSignIn():
            _handleUserChanged(event.user);
            break;
        case GoogleSignInAuthenticationEventSignOut():
            _handleUserChanged(null);
            break;
    }
  }

  /// Central handler for user state changes (sign-in/sign-out).
  Future<void> _handleUserChanged(GoogleSignInAccount? account) async {
    _currentUser = account;
    if (account != null) {
        // User is signed in, initialize the Drive API.
        await _initDriveApi(account);
    } else {
        // User is signed out, clear all API and state.
        _clearState();
    }
  }

  /// Initializes the DriveApi using headers from the authorizationClient.
  Future<void> _initDriveApi(GoogleSignInAccount account) async {
    // First, check if the user has already granted the necessary permissions.
    // If not, authorizationHeaders will return null.
    final authHeaders = await account.authorizationClient.authorizationHeaders(_scopes);

    if (authHeaders == null) {
        // Permissions have not been granted yet. The user will need to authorize.
        debugPrint('Permissions not granted yet. Waiting for user to authorize.');
        _driveApi = null;
        return;
    }
    
    final authenticatedClient = _AuthenticatedClient(http.Client(), authHeaders);
    _driveApi = drive.DriveApi(authenticatedClient);
    
    // Once the API is ready, create the necessary folders.
    await _createAppFolders();
  }
  
  /// Clears the internal state upon sign-out or error.
  void _clearState() {
    _driveApi = null;
    _currentUser = null;
    _appFolderId = null;
    _rulesFolderId = null;
    _settingsFolderId = null;
    _notificationsFolderId = null;
    _devicesFolderId = null;
  }

  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _devicesFolderName = 'Devices';
  }

  @override
  Future<bool> isConfigured() async {
    return _driveApi != null && _currentUser != null;
  }
  
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      // Trigger the interactive sign-in process.
      // The authenticationEvents listener will handle the result.
      await _googleSignIn.authenticate();
      // The state is managed by the listener, we just check if it succeeded.
      return await isConfigured();
    } catch (e) {
      debugPrint('Google Drive connection error: $e');
      _clearState();
      return false;
    }
  }

  /// Ensures necessary folders exist in Google Drive.
  Future<void> _createAppFolders() async {
    if (_driveApi == null) return;
    try {
      _appFolderId = await _getOrCreateFolder(_appFolderName, null);
      if (_appFolderId == null) {
          debugPrint('Failed to create or find the main app folder.');
          return;
      }
      _rulesFolderId = await _getOrCreateFolder(_rulesFolderName, _appFolderId);
      _settingsFolderId = await _getOrCreateFolder(_settingsFolderName, _appFolderId);
      _devicesFolderId = await _getOrCreateFolder(_devicesFolderName, _appFolderId);
    } catch (e) {
      debugPrint('Error creating Google Drive folders: $e');
    }
  }

  /// Disconnects the user and revokes permissions.
  @override
  Future<bool> doDisconnect() async {
    try {
      await _googleSignIn.disconnect();
      // The listener will call _clearState().
      return true;
    } catch (e) {
      debugPrint('Error disconnecting from Google Drive: $e');
      return false;
    }
  }

  /// All subsequent methods (doSync, getFromCloud, etc.) remain unchanged
  /// as they correctly depend on the `_driveApi` instance being valid.

  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (!await _ensureApiReady()) return false;
    
    try {
      final rulesJson = jsonEncode(rules.map((rule) => CloudDataConverter.serialize(rule)).toList());
      final fileId = await _findFile('rules.json', _rulesFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(rulesJson)), rulesJson.length, contentType: 'application/json');
      
      if (fileId != null) {
        await _driveApi!.files.update(drive.File(), fileId, uploadMedia: media);
      } else {
        final file = drive.File()..name = 'rules.json'..parents = [_rulesFolderId!];
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
    if (!await _ensureApiReady()) return [];
    
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
    if (!await _ensureApiReady()) return false;
    
    try {
      final settingsJson = jsonEncode(settings);
      final fileId = await _findFile('app_settings.json', _settingsFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(settingsJson)), settingsJson.length, contentType: 'application/json');
      
      if (fileId != null) {
        await _driveApi!.files.update(drive.File(), fileId, uploadMedia: media);
      } else {
        final file = drive.File()..name = 'app_settings.json'..parents = [_settingsFolderId!];
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
    if (!await _ensureApiReady()) return null;
    
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
  Future<bool> doSyncNotificationHistory(List<Map<String, dynamic>> notifications) async {
    if (!await _ensureApiReady()) return false;
    
    try {
      final notificationsJson = jsonEncode(notifications);
      final fileId = await _findFile('notification_history.json', _notificationsFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(notificationsJson)), notificationsJson.length, contentType: 'application/json');
      
      if (fileId != null) {
        await _driveApi!.files.update(drive.File(), fileId, uploadMedia: media);
      } else {
        final file = drive.File()..name = 'notification_history.json'..parents = [_notificationsFolderId!];
        await _driveApi!.files.create(file, uploadMedia: media);
      }
      return true;
    } catch (e) {
      debugPrint('Error syncing notification history to Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    if (!await _ensureApiReady()) return [];
    
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
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (!await _ensureApiReady()) return false;
    
    try {
      final devices = await doGetRegisteredDevicesFromCloud();
      final existingDeviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (existingDeviceIndex >= 0) {
        devices[existingDeviceIndex] = device;
      } else {
        devices.add(device);
      }
      
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      final fileId = await _findFile('registered_devices.json', _devicesFolderId!);
      final media = drive.Media(Stream.value(utf8.encode(devicesJson)), devicesJson.length, contentType: 'application/json');

      if (fileId != null) {
        await _driveApi!.files.update(drive.File(), fileId, uploadMedia: media);
      } else {
        final file = drive.File()..name = 'registered_devices.json'..parents = [_devicesFolderId!];
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
    if (!await _ensureApiReady()) return [];
    
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
    return doRegisterDeviceForSync(device);
  }
  
  @override
  Future<bool> syncDevicesFromCloud() async {
    if (!await _ensureApiReady()) return false;
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

  Future<String?> _getOrCreateFolder(String folderName, String? parentId) async {
    if (_driveApi == null) return null;
    try {
      String query = "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
      query += parentId != null ? " and '$parentId' in parents" : " and 'root' in parents";
      
      final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id, name)');
      final files = fileList.files;
      if (files != null && files.isNotEmpty) {
        return files.first.id;
      }
      
      final folder = drive.File()..name = folderName..mimeType = 'application/vnd.google-apps.folder';
      if (parentId != null) folder.parents = [parentId];
      
      final createdFolder = await _driveApi!.files.create(folder);
      return createdFolder.id;
    } catch (e) {
      debugPrint('Error getting or creating folder "$folderName": $e');
      return null;
    }
  }
  
  Future<String?> _findFile(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    try {
      final query = "name='$fileName' and '$folderId' in parents and trashed=false";
      final fileList = await _driveApi!.files.list(q: query, $fields: 'files(id, name)');
      final files = fileList.files;
      return (files != null && files.isNotEmpty) ? files.first.id : null;
    } catch (e) {
      debugPrint('Error finding file: $e');
      return null;
    }
  }
  
  Future<List<int>> _readMediaBytes(drive.Media media) async {
    final completer = Completer<List<int>>();
    final bytesBuilder = BytesBuilder();
    media.stream.listen(bytesBuilder.add, onError: completer.completeError, onDone: () => completer.complete(bytesBuilder.toBytes()), cancelOnError: true);
    return completer.future;
  }
  
  /// Helper to ensure the API is ready and permissions are granted before an operation.
  Future<bool> _ensureApiReady() async {
    if (_driveApi != null) {
      return true;
    }

    if (_currentUser == null) {
      debugPrint('Cannot perform operation: User is not signed in.');
      return false;
    }
    
    // If API is null but user exists, it means permissions were not granted.
    debugPrint('Attempting to request required permissions...');
    try {
      await _currentUser!.authorizationClient.authorizeScopes(_scopes);
      // Re-initialize the API after getting permissions.
      await _initDriveApi(_currentUser!);
      return _driveApi != null;
    } catch (e) {
      debugPrint('Failed to authorize scopes: $e');
      return false;
    }
  }
}

/// A client that adds authentication headers to outgoing requests.
/// This is necessary again because we are not using the extension package.
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