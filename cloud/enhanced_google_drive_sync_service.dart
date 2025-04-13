import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:notification_manager/data/services/cloud/enhanced_cloud_sync_service.dart';
import 'package:notification_manager/data/services/cloud/sync_conflict_resolver.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;

/// Enhanced Google Drive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class EnhancedGoogleDriveSyncService extends EnhancedCloudSyncService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );
  
  drive.DriveApi? _driveApi;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Configuration keys
  static const String _clientIdKey = 'google_drive_client_id';
  static const String _clientSecretKey = 'google_drive_client_secret';
  
  // File paths in Google Drive
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _notificationsFolderName;
  
  void _updateFolderPaths() {
    _rulesFolderName = 'Rules';
    _settingsFolderName = 'Settings';
    _notificationsFolderName = 'Notifications';
  }
  String? _clientId;
  String? _clientSecret;
  GoogleSignInAccount? _currentUser;
  
  // Folder IDs cache
  String? _appFolderId;
  String? _rulesFolderId;
  String? _settingsFolderId;
  String? _notificationsFolderId;
  
  @override
  String get serviceType => 'GoogleDrive';
  
  @override
  String get serviceName => 'Google Drive';
  
  /// Constructor with optional conflict resolution strategy
  EnhancedGoogleDriveSyncService({
    ConflictResolutionStrategy defaultStrategy = ConflictResolutionStrategy.merge,
  }) : super(defaultStrategy: defaultStrategy);
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    _clientId = config['client_id'] as String?;
    _clientSecret = config['client_secret'] as String?;
    
    // Load saved credentials if available
    _clientId ??= await _secureStorage.read(key: _clientIdKey);
    _clientSecret ??= await _secureStorage.read(key: _clientSecretKey);
    
    // Set custom app folder name if provided
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    // Try to sign in silently if user was previously signed in
    if (_clientId != null) {
      try {
        _currentUser = await _googleSignIn.signInSilently();
        if (_currentUser != null) {
          await _initDriveApi();
        }
      } catch (e) {
        debugPrint('Error signing in silently: $e');
      }
    }
    
    _isInitialized = true;
  }
  
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
  Future<bool> isConfigured() async {
    return _clientId != null && _currentUser != null && _driveApi != null;
  }
  
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      _clientId = credentials['client_id'] as String?;
      _clientSecret = credentials['client_secret'] as String?;
      
      if (_clientId == null || _clientSecret == null) {
        return false;
      }
      
      // Save credentials securely
      await _secureStorage.write(key: _clientIdKey, value: _clientId!);
      await _secureStorage.write(key: _clientSecretKey, value: _clientSecret!);
      
      // Sign in with Google
      _currentUser = await _googleSignIn.signIn();
      if (_currentUser == null) return false;
      
      // Initialize Drive API
      await _initDriveApi();
      
      // Create necessary folders
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
      // Create app root folder
      _appFolderId = await _getOrCreateFolder(_appFolderName, null);
      
      // Create subfolders
      _rulesFolderId = await _getOrCreateFolder(_rulesFolderName, _appFolderId);
      _settingsFolderId = await _getOrCreateFolder(_settingsFolderName, _appFolderId);
      _notificationsFolderId = await _getOrCreateFolder(_notificationsFolderName, _appFolderId);
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
      // Sign out from Google
      await _googleSignIn.signOut();
      
      // Clear stored credentials
      await _secureStorage.delete(key: _clientIdKey);
      await _secureStorage.delete(key: _clientSecretKey);
      
      // Reset instance variables
      _currentUser = null;
      _driveApi = null;
      _appFolderId = null;
      _rulesFolderId = null;
      _settingsFolderId = null;
      _notificationsFolderId = null;
      
      return true;
    } catch (e) {
      debugPrint('Error disconnecting from Google Drive: $e');
      return false;
    }
  }
  
  @override
  Future<bool> doSyncRules(List<RuleEntity> rules) async {
    if (_driveApi == null || _rulesFolderId == null) return false;
    
    try {
      // Convert rules to JSON
      final rulesJson = jsonEncode(rules.map((rule) => rule.toJson()).toList());
      
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
  Future<List<RuleEntity>> getRulesFromCloud() async {
    if (_driveApi == null || _rulesFolderId == null) return [];
    
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
          .map((json) => RuleEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting rules from Google Drive: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doSyncSettings(Map<String, dynamic> settings) async {
    if (_driveApi == null || _settingsFolderId == null) return false;
    
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
    if (_driveApi == null || _settingsFolderId == null) return null;
    
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
    if (_driveApi == null || _notificationsFolderId == null) return false;
    
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
    if (_driveApi == null || _notificationsFolderId == null) return [];
    
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