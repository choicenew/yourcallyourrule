import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:notification_manager/data/services/cloud/enhanced_cloud_sync_service.dart';
import 'package:notification_manager/data/services/cloud/sync_conflict_resolver.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

/// Enhanced OneDrive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class EnhancedOneDriveSyncService extends EnhancedCloudSyncService {
  final Dio _dio = Dio();
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Configuration keys
  static const String _clientIdKey = 'onedrive_client_id';
  static const String _clientSecretKey = 'onedrive_client_secret';
  static const String _accessTokenKey = 'onedrive_access_token';
  static const String _refreshTokenKey = 'onedrive_refresh_token';
  static const String _tokenExpiryKey = 'onedrive_token_expiry';
  
  // OneDrive API endpoints
  static const String _authUrl = 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  static const String _tokenUrl = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
  static const String _driveUrl = 'https://graph.microsoft.com/v1.0/me/drive';
  static const String _redirectUri = 'https://login.microsoftonline.com/common/oauth2/nativeclient';
  
  // File paths in OneDrive
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
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  
  @override
  String get serviceType => 'OneDrive';
  
  @override
  String get serviceName => 'Microsoft OneDrive';
  
  /// Constructor with optional conflict resolution strategy
  EnhancedOneDriveSyncService({
    ConflictResolutionStrategy defaultStrategy = ConflictResolutionStrategy.merge,
  }) : super(defaultStrategy: defaultStrategy);
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    _clientId = config['client_id'] as String?;
    _clientSecret = config['client_secret'] as String?;
    
    // Load saved tokens if available
    _accessToken = await _secureStorage.read(key: _accessTokenKey);
    _refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      _tokenExpiry = DateTime.parse(expiryString);
    }
    
    // Set custom app folder name if provided
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    _isInitialized = true;
  }
  
  @override
  Future<bool> isConfigured() async {
    return _clientId != null && 
           _clientSecret != null && 
           _accessToken != null && 
           _refreshToken != null;
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
      
      // Initiate OAuth flow
      final authCode = await _getAuthorizationCode();
      if (authCode == null) return false;
      
      // Exchange auth code for tokens
      final tokenResponse = await _exchangeCodeForTokens(authCode);
      if (tokenResponse == null) return false;
      
      // Create necessary folders
      await _createAppFolders();
      
      return true;
    } catch (e) {
      debugPrint('OneDrive connection error: $e');
      return false;
    }
  }
  
  Future<String?> _getAuthorizationCode() async {
    final authUri = Uri.parse(_authUrl).replace(queryParameters: {
      'client_id': _clientId!,
      'response_type': 'code',
      'redirect_uri': _redirectUri,
      'scope': 'offline_access Files.ReadWrite.All',
    });
    
    // Launch browser for authorization
    if (await canLaunchUrl(authUri)) {
      await launchUrl(authUri, mode: LaunchMode.externalApplication);
      // In a real app, you would need to handle the redirect and extract the code
      // This is a simplified version that would require manual input of the code
      // or a custom URL scheme to capture the redirect
      return null; // Placeholder for the actual implementation
    } else {
      throw Exception('Could not launch authorization URL');
    }
  }
  
  Future<Map<String, dynamic>?> _exchangeCodeForTokens(String authCode) async {
    try {
      final response = await _dio.post(
        _tokenUrl,
        data: FormData.fromMap({
          'client_id': _clientId!,
          'client_secret': _clientSecret!,
          'code': authCode,
          'redirect_uri': _redirectUri,
          'grant_type': 'authorization_code',
        }),
      );
      
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        _accessToken = data['access_token'] as String;
        _refreshToken = data['refresh_token'] as String;
        final expiresIn = data['expires_in'] as int;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
        
        // Save tokens securely
        await _secureStorage.write(key: _accessTokenKey, value: _accessToken!);
        await _secureStorage.write(key: _refreshTokenKey, value: _refreshToken!);
        await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
        
        return data;
      }
      return null;
    } catch (e) {
      debugPrint('Error exchanging code for tokens: $e');
      return null;
    }
  }
  
  Future<bool> _refreshTokenIfNeeded() async {
    if (_tokenExpiry == null || _refreshToken == null || 
        _tokenExpiry!.isBefore(DateTime.now())) {
      try {
        final response = await _dio.post(
          _tokenUrl,
          data: FormData.fromMap({
            'client_id': _clientId!,
            'client_secret': _clientSecret!,
            'refresh_token': _refreshToken!,
            'grant_type': 'refresh_token',
          }),
        );
        
        if (response.statusCode == 200) {
          final data = response.data as Map<String, dynamic>;
          _accessToken = data['access_token'] as String;
          if (data.containsKey('refresh_token')) {
            _refreshToken = data['refresh_token'] as String;
            await _secureStorage.write(key: _refreshTokenKey, value: _refreshToken!);
          }
          
          final expiresIn = data['expires_in'] as int;
          _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
          await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
          
          return true;
        }
        return false;
      } catch (e) {
        debugPrint('Error refreshing token: $e');
        return false;
      }
    }
    return true; // Token is still valid
  }
  
  Future<void> _createAppFolders() async {
    if (!await _refreshTokenIfNeeded()) return;
    
    // Create app root folder
    await _createFolder(_appFolderName);
    
    // Create subfolders
    await _createFolder('$_appFolderName/$_rulesFolderName');
    await _createFolder('$_appFolderName/$_settingsFolderName');
    await _createFolder('$_appFolderName/$_notificationsFolderName');
  }
  
  Future<Map<String, dynamic>?> _createFolder(String folderPath) async {
    try {
      final segments = folderPath.split('/');
      String currentPath = '';
      Map<String, dynamic>? result;
      
      for (final segment in segments) {
        final parentPath = currentPath;
        currentPath = currentPath.isEmpty ? segment : '$currentPath/$segment';
        
        // Check if folder exists
        final existingFolder = await _getFolderByPath(currentPath);
        if (existingFolder != null) {
          result = existingFolder;
          continue;
        }
        
        // Get parent folder ID
        String? parentId;
        if (parentPath.isEmpty) {
          parentId = 'root';
        } else {
          final parent = await _getFolderByPath(parentPath);
          parentId = parent?['id'] as String?;
          if (parentId == null) return null;
        }
        
        // Create folder
        final response = await _dio.post(
          '$_driveUrl/items/$parentId/children',
          data: {
            'name': segment,
            'folder': {},
            '@microsoft.graph.conflictBehavior': 'fail'
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $_accessToken',
              'Content-Type': 'application/json',
            },
          ),
        );
        
        if (response.statusCode == 201) {
          result = response.data as Map<String, dynamic>;
        } else {
          return null;
        }
      }
      
      return result;
    } catch (e) {
      debugPrint('Error creating folder: $e');
      return null;
    }
  }
  
  Future<Map<String, dynamic>?> _getFolderByPath(String path) async {
    try {
      if (!await _refreshTokenIfNeeded()) return null;
      
      final encodedPath = path.split('/').map(Uri.encodeComponent).join('/');
      final response = await _dio.get(
        '$_driveUrl/root:/$encodedPath',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      // Item not found or other error
      return null;
    }
  }
  
  @override
  Future<bool> doDisconnect() async {
    try {
      // Clear stored tokens
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _tokenExpiryKey);
      
      // Reset instance variables
      _accessToken = null;
      _refreshToken = null;
      _tokenExpiry = null;
      
      return true;
    } catch (e) {
      debugPrint('Error disconnecting from OneDrive: $e');
      return false;
    }
  }
  
  @override
  Future<bool> doSyncRules(List<RuleEntity> rules) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // Get or create rules folder
      final rulesFolder = await _getFolderByPath('$_appFolderName/$_rulesFolderName');
      if (rulesFolder == null) return false;
      
      final folderId = rulesFolder['id'] as String;
      
      // Convert rules to JSON
      final rulesJson = jsonEncode(rules.map((rule) => rule.toJson()).toList());
      
      // Upload rules file
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/rules.json:/content',
        data: rulesJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error syncing rules to OneDrive: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleEntity>> getRulesFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      // Get rules folder
      final rulesFolder = await _getFolderByPath('$_appFolderName/$_rulesFolderName');
      if (rulesFolder == null) return [];
      
      final folderId = rulesFolder['id'] as String;
      
      // Download rules file
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/rules.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        final List<dynamic> rulesData = jsonDecode(jsonData) as List<dynamic>;
        return rulesData.map((data) => RuleEntity.fromJson(data as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting rules from OneDrive: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doSyncSettings(Map<String, dynamic> settings) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // Get or create settings folder
      final settingsFolder = await _getFolderByPath('$_appFolderName/$_settingsFolderName');
      if (settingsFolder == null) return false;
      
      final folderId = settingsFolder['id'] as String;
      
      // Convert settings to JSON
      final settingsJson = jsonEncode(settings);
      
      // Upload settings file
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/settings.json:/content',
        data: settingsJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error syncing settings to OneDrive: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>> getSettingsFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return {};
      
      // Get settings folder
      final settingsFolder = await _getFolderByPath('$_appFolderName/$_settingsFolderName');
      if (settingsFolder == null) return {};
      
      final folderId = settingsFolder['id'] as String;
      
      // Download settings file
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/settings.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        return jsonDecode(jsonData) as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      debugPrint('Error getting settings from OneDrive: $e');
      return {};
    }
  }
  
  @override
  Future<bool> doSyncNotificationHistory(List<Map<String, dynamic>> history) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // Get or create notifications folder
      final notificationsFolder = await _getFolderByPath('$_appFolderName/$_notificationsFolderName');
      if (notificationsFolder == null) return false;
      
      final folderId = notificationsFolder['id'] as String;
      
      // Convert history to JSON
      final historyJson = jsonEncode(history);
      
      // Upload history file
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/history.json:/content',
        data: historyJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error syncing notification history to OneDrive: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      // Get notifications folder
      final notificationsFolder = await _getFolderByPath('$_appFolderName/$_notificationsFolderName');
      if (notificationsFolder == null) return [];
      
      final folderId = notificationsFolder['id'] as String;
      
      // Download history file
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/history.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        final List<dynamic> historyData = jsonDecode(jsonData) as List<dynamic>;
        return historyData.map((data) => data as Map<String, dynamic>).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting notification history from OneDrive: $e');
      return [];
    }
  }
}