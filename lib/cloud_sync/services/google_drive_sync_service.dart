import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

import 'enhanced_cloud_sync_service.dart';

/// Google Drive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class GoogleDriveSyncService extends EnhancedCloudSyncService {
  /// Reference to the Riverpod container
  final Ref? ref;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static const List<String> _driveScopes = [drive.DriveApi.driveFileScope];

  drive.DriveApi? _driveApi;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Google Drive folder configuration
  static const String _defaultAppFolderName = 'YourCallYourRule';
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

    if (config['config_app_folder_name'] != null) {
      _appFolderName = config['config_app_folder_name'] as String;
    }
    _updateFolderPaths();

    await _googleSignIn.initialize();

    try {
      final GoogleSignInAccount? result =
          await _googleSignIn.attemptLightweightAuthentication();

      // FIX 1: The result is the GoogleSignInAccount itself, not a wrapper.
      _currentUser = result;

      if (_currentUser != null) {
        debugPrint('Silently signed in as: ${_currentUser!.email}');
        await _initDriveApi();
      } else {
        debugPrint('No user was previously signed in.');
      }
    } catch (e) {
      debugPrint('Error during lightweight authentication: $e');
      await doDisconnect();
    }

    _isInitialized = true;
  }

  Future<void> _initDriveApi() async {
    if (_currentUser == null) {
      debugPrint('Cannot init Drive API: current user is null.');
      return;
    }

    try {
      final authClient = _currentUser!.authorizationClient;
      final authorization = await authClient.authorizeScopes(_driveScopes);

      if (authorization == null) {
        throw Exception(
          'User did not grant necessary permissions for Google Drive.',
        );
      }

      // FIX 2: Restore the original pattern using the _AuthenticatedClient helper class.
      // This is the simplest and most reliable way without adding new dependencies.
      final authHeaders = {
        'Authorization': 'Bearer ${authorization.accessToken}',
        'X-Goog-AuthUser': '0',
      };

      final httpClient = _AuthenticatedClient(http.Client(), authHeaders);
      _driveApi = drive.DriveApi(httpClient);

      debugPrint('Google Drive API initialized successfully.');
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
    try {
      final GoogleSignInAccount? result = await _googleSignIn.authenticate();

      // FIX 3: Same as FIX 1. The result is the GoogleSignInAccount.
      _currentUser = result;

      if (_currentUser == null) {
        debugPrint('User cancelled the sign-in flow.');
        return false;
      }

      await _initDriveApi();

      if (_driveApi == null) {
        debugPrint(
          'Connection failed because Drive API could not be initialized.',
        );
        return false;
      }

      await _createAppFolders();

      return true;
    } catch (e) {
      debugPrint('Google Drive connection error: $e');
      return false;
    }
  }

  Future<void> _createAppFolders() async {
    if (_driveApi == null) return;

    try {
      _appFolderId = await _getOrCreateFolder(_appFolderName, null);
      _rulesFolderId = await _getOrCreateFolder(_rulesFolderName, _appFolderId);
      _settingsFolderId = await _getOrCreateFolder(
        _settingsFolderName,
        _appFolderId,
      );
      _devicesFolderId = await _getOrCreateFolder(
        _devicesFolderName,
        _appFolderId,
      );
    } catch (e) {
      debugPrint('Error creating Google Drive folders: $e');
    }
  }

  Future<String?> _getOrCreateFolder(
    String folderName,
    String? parentId,
  ) async {
    if (_driveApi == null) return null;

    try {
      String query =
          "mimeType='application/vnd.google-apps.folder' and name='$folderName' and trashed=false";
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
      await _googleSignIn.signOut();
      debugPrint('User signed out.');

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

  // ... NO CHANGES NEEDED IN THE FOLLOWING METHODS ...

  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_driveApi == null || _rulesFolderId == null) {
      debugPrint(
        'Cannot sync rules: Drive API not ready or folder ID is null.',
      );
      return false;
    }

    try {
      final rulesJson = jsonEncode(
        rules.map((rule) => CloudDataConverter.serialize(rule)).toList(),
      );
      final existingFileId = await _findFile('rules.json', _rulesFolderId!);
      final media = drive.Media(
        Stream.value(utf8.encode(rulesJson)),
        rulesJson.length,
        contentType: 'application/json',
      );

      if (existingFileId != null) {
        await _driveApi!.files.update(
          drive.File(),
          existingFileId,
          uploadMedia: media,
        );
      } else {
        final file =
            drive.File()
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

      final media =
          await _driveApi!.files.get(
                fileId,
                downloadOptions: drive.DownloadOptions.fullMedia,
              )
              as drive.Media;
      final bytes = await _readMediaBytes(media);
      final rulesJson = utf8.decode(bytes);

      final List<dynamic> rulesList = jsonDecode(rulesJson);
      return rulesList
          .map(
            (json) => CloudDataConverter.deserialize<RuleBase>(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('Error getting rules from Google Drive: $e');
      return [];
    }
  }

  @override
  Future<bool> doSyncSettings(Map<String, dynamic> settings) async {
    if (_driveApi == null || _settingsFolderId == null) {
      debugPrint(
        'Cannot sync settings: Drive API not ready or folder ID is null.',
      );
      return false;
    }

    try {
      final settingsJson = jsonEncode(settings);
      final existingFileId = await _findFile(
        'app_settings.json',
        _settingsFolderId!,
      );
      final media = drive.Media(
        Stream.value(utf8.encode(settingsJson)),
        settingsJson.length,
        contentType: 'application/json',
      );

      if (existingFileId != null) {
        await _driveApi!.files.update(
          drive.File(),
          existingFileId,
          uploadMedia: media,
        );
      } else {
        final file =
            drive.File()
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
    if (_driveApi == null ||
        _settingsFolderId == null ||
        !await isConfigured()) {
      return null;
    }

    try {
      final fileId = await _findFile('app_settings.json', _settingsFolderId!);
      if (fileId == null) return null;

      final media =
          await _driveApi!.files.get(
                fileId,
                downloadOptions: drive.DownloadOptions.fullMedia,
              )
              as drive.Media;
      final bytes = await _readMediaBytes(media);
      final settingsJson = utf8.decode(bytes);

      return jsonDecode(settingsJson) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error getting settings from Google Drive: $e');
      return null;
    }
  }

  @override
  Future<bool> doSyncNotificationHistory(
    List<Map<String, dynamic>> notifications,
  ) async {
    if (_driveApi == null || _notificationsFolderId == null) {
      debugPrint(
        'Cannot sync notifications: Drive API not ready or folder ID is null.',
      );
      return false;
    }

    try {
      final notificationsJson = jsonEncode(notifications);
      final existingFileId = await _findFile(
        'notification_history.json',
        _notificationsFolderId!,
      );
      final media = drive.Media(
        Stream.value(utf8.encode(notificationsJson)),
        notificationsJson.length,
        contentType: 'application/json',
      );

      if (existingFileId != null) {
        await _driveApi!.files.update(
          drive.File(),
          existingFileId,
          uploadMedia: media,
        );
      } else {
        final file =
            drive.File()
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

  @override
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    if (_driveApi == null ||
        _notificationsFolderId == null ||
        !await isConfigured()) {
      return [];
    }

    try {
      final fileId = await _findFile(
        'notification_history.json',
        _notificationsFolderId!,
      );
      if (fileId == null) return [];

      final media =
          await _driveApi!.files.get(
                fileId,
                downloadOptions: drive.DownloadOptions.fullMedia,
              )
              as drive.Media;
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
      final query =
          "name='$fileName' and '$folderId' in parents and trashed=false";
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

  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (_driveApi == null || _devicesFolderId == null) {
      debugPrint(
        'Cannot register device: Drive API not ready or folder ID is null.',
      );
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

      final devicesJson = jsonEncode(
        devices.map((device) => device.toJson()).toList(),
      );
      final existingFileId = await _findFile(
        'registered_devices.json',
        _devicesFolderId!,
      );
      final media = drive.Media(
        Stream.value(utf8.encode(devicesJson)),
        devicesJson.length,
        contentType: 'application/json',
      );

      if (existingFileId != null) {
        await _driveApi!.files.update(
          drive.File(),
          existingFileId,
          uploadMedia: media,
        );
      } else {
        final file =
            drive.File()
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
    if (_driveApi == null ||
        _devicesFolderId == null ||
        !await isConfigured()) {
      return [];
    }

    try {
      final fileId = await _findFile(
        'registered_devices.json',
        _devicesFolderId!,
      );
      if (fileId == null) return [];

      final media =
          await _driveApi!.files.get(
                fileId,
                downloadOptions: drive.DownloadOptions.fullMedia,
              )
              as drive.Media;
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
      debugPrint(
        'Cannot sync device info: Drive API not ready or folder ID is null.',
      );
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

      final devicesJson = jsonEncode(
        devices.map((device) => device.toJson()).toList(),
      );
      final existingFileId = await _findFile(
        'registered_devices.json',
        _devicesFolderId!,
      );
      final media = drive.Media(
        Stream.value(utf8.encode(devicesJson)),
        devicesJson.length,
        contentType: 'application/json',
      );

      if (existingFileId != null) {
        await _driveApi!.files.update(
          drive.File(),
          existingFileId,
          uploadMedia: media,
        );
      } else {
        final file =
            drive.File()
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

      final deviceManagementService = ref?.read(
        deviceManagementServiceProvider,
      );

      if (deviceManagementService != null) {
        for (final device in cloudDevices) {
          await deviceManagementService.registerDevice(device);
        }
      } else {
        debugPrint(
          'Warning: DeviceManagementService not available for device sync',
        );
      }

      return true;
    } catch (e) {
      debugPrint('Error syncing devices from cloud: $e');
      return false;
    }
  }

  @override
  Future<bool> doCheckOnlineStatus() async {
    if (_driveApi == null) return false;
    try {
      // A lightweight request to check if the API is responsive
      await _driveApi!.about.get($fields: 'kind');
      return true;
    } catch (e) {
      debugPrint('Google Drive online check failed: $e');
      return false;
    }
  }
}

// FIX 2 (cont.): Restore this helper class, as it's needed by _initDriveApi.
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
