import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:notification_manager/data/services/cloud/enhanced_cloud_sync_service.dart';
import 'package:notification_manager/data/services/cloud/sync_conflict_resolver.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Enhanced WebDAV implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class EnhancedWebDAVSyncService extends EnhancedCloudSyncService {
  webdav.Client? _client;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Configuration keys
  static const String _serverUrlKey = 'webdav_server_url';
  static const String _usernameKey = 'webdav_username';
  static const String _passwordKey = 'webdav_password';
  
  // File paths in WebDAV
  static const String _defaultAppFolderName = 'NotificationManager';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _notificationsFolderName;
  
  void _updateFolderPaths() {
    _rulesFolderName = '$_appFolderName/Rules';
    _settingsFolderName = '$_appFolderName/Settings';
    _notificationsFolderName = '$_appFolderName/Notifications';
  }
  
  String? _serverUrl;
  String? _username;
  String? _password;
  
  @override
  String get serviceType => 'WebDAV';
  
  @override
  String get serviceName => 'WebDAV';
  
  /// Constructor with optional conflict resolution strategy
  EnhancedWebDAVSyncService({
    ConflictResolutionStrategy defaultStrategy = ConflictResolutionStrategy.merge,
  }) : super(defaultStrategy: defaultStrategy);
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    _serverUrl = config['server_url'] as String?;
    _username = config['username'] as String?;
    _password = config['password'] as String?;
    
    // Load saved credentials if available
    _serverUrl ??= await _secureStorage.read(key: _serverUrlKey);
    _username ??= await _secureStorage.read(key: _usernameKey);
    _password ??= await _secureStorage.read(key: _passwordKey);
    
    // Set custom app folder name if provided
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    if (_serverUrl != null && _username != null && _password != null) {
      _initClient();
    }
    
    _isInitialized = true;
  }
  
  void _initClient() {
    if (_serverUrl == null || _username == null || _password == null) return;
    
    final dio = webdav.WdDio();
    final auth = webdav.Auth(user: _username!, pwd: _password!);
    
    _client = webdav.Client(
      uri: _serverUrl!,
      c: dio,
      auth: auth,
      debug: kDebugMode,
    );
  }
  
  @override
  Future<bool> isConfigured() async {
    return _serverUrl != null && _username != null && _password != null;
  }
  
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      _serverUrl = credentials['server_url'] as String?;
      _username = credentials['username'] as String?;
      _password = credentials['password'] as String?;
      
      if (_serverUrl == null || _username == null || _password == null) {
        return false;
      }
      
      // Initialize client
      _initClient();
      
      // Test connection
      try {
        await _client?.ping();
        
        // Save credentials securely only if ping is successful
        await _secureStorage.write(key: _serverUrlKey, value: _serverUrl!);
        await _secureStorage.write(key: _usernameKey, value: _username!);
        await _secureStorage.write(key: _passwordKey, value: _password!);
        
        // Create necessary folders
        await _createAppFolders();
        
        return true;
      } catch (e) {
        debugPrint('WebDAV ping error: $e');
        return false;
      }
    } catch (e) {
      debugPrint('WebDAV connection error: $e');
      return false;
    }
  }
  
  Future<void> _createAppFolders() async {
    if (_client == null) return;
    
    try {
      // Create app root folder
      try {
        await _client!.readProps(_appFolderName);
      } catch (e) {
        await _client!.mkdir(_appFolderName);
      }
      
      // Create subfolders
      try {
        await _client!.readProps(_rulesFolderName);
      } catch (e) {
        await _client!.mkdir(_rulesFolderName);
      }
      
      try {
        await _client!.readProps(_settingsFolderName);
      } catch (e) {
        await _client!.mkdir(_settingsFolderName);
      }
      
      try {
        await _client!.readProps(_notificationsFolderName);
      } catch (e) {
        await _client!.mkdir(_notificationsFolderName);
      }
    } catch (e) {
      debugPrint('Error creating WebDAV folders: $e');
    }
  }
  
  @override
  Future<bool> doDisconnect() async {
    try {
      // Clear stored credentials
      await _secureStorage.delete(key: _serverUrlKey);
      await _secureStorage.delete(key: _usernameKey);
      await _secureStorage.delete(key: _passwordKey);
      
      // Reset instance variables
      _serverUrl = null;
      _username = null;
      _password = null;
      _client = null;
      
      return true;
    } catch (e) {
      debugPrint('Error disconnecting from WebDAV: $e');
      return false;
    }
  }
  
  @override
  Future<bool> doSyncRules(List<RuleEntity> rules) async {
    if (_client == null) return false;
    
    try {
      // Convert rules to JSON
      final rulesJson = jsonEncode(rules.map((rule) => rule.toJson()).toList());
      
      // Upload rules file
      final filePath = '$_rulesFolderName/rules.json';
      await _client!.write(
        filePath,
        utf8.encode(rulesJson),
      );
      
      return true;
    } catch (e) {
      debugPrint('Error syncing rules to WebDAV: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleEntity>> getRulesFromCloud() async {
    if (_client == null || !await isConfigured()) return [];
    
    try {
      final filePath = '$_rulesFolderName/rules.json';
      
      // Check if file exists
      try {
        await _client!.readProps(filePath);
      } catch (e) {
        return [];
      }
      
      // Download rules file
      final response = await _client!.read(filePath);
      final rulesJson = utf8.decode(response);
      
      final List<dynamic> rulesList = jsonDecode(rulesJson);
      return rulesList
          .map((json) => RuleEntity.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting rules from WebDAV: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doSyncSettings(Map<String, dynamic> settings) async {
    if (_client == null) return false;
    
    try {
      // Convert settings to JSON
      final settingsJson = jsonEncode(settings);
      
      // Upload settings file
      final filePath = '$_settingsFolderName/app_settings.json';
      await _client!.write(
        filePath,
        utf8.encode(settingsJson),
      );
      
      return true;
    } catch (e) {
      debugPrint('Error syncing settings to WebDAV: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    if (_client == null || !await isConfigured()) return null;
    
    try {
      final filePath = '$_settingsFolderName/app_settings.json';
      
      // Check if file exists
      try {
        await _client!.readProps(filePath);
      } catch (e) {
        return null;
      }
      
      // Download settings file
      final response = await _client!.read(filePath);
      final settingsJson = utf8.decode(response);
      
      return jsonDecode(settingsJson) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error getting settings from WebDAV: $e');
      return null;
    }
  }
  
  @override
  Future<bool> doSyncNotificationHistory(List<Map<String, dynamic>> notifications) async {
    if (_client == null) return false;
    
    try {
      // Convert notifications to JSON
      final notificationsJson = jsonEncode(notifications);
      
      // Upload notifications file
      final filePath = '$_notificationsFolderName/notification_history.json';
      await _client!.write(
        filePath,
        utf8.encode(notificationsJson),
      );
      
      return true;
    } catch (e) {
      debugPrint('Error syncing notification history to WebDAV: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud() async {
    if (_client == null || !await isConfigured()) return [];
    
    try {
      final filePath = '$_notificationsFolderName/notification_history.json';
      
      // Check if file exists
      try {
        await _client!.readProps(filePath);
      } catch (e) {
        return [];
      }
      
      // Download notifications file
      final response = await _client!.read(filePath);
      final notificationsJson = utf8.decode(response);
      
      final List<dynamic> notificationsList = jsonDecode(notificationsJson);
      return notificationsList
          .map((json) => json as Map<String, dynamic>)
          .toList();
    } catch (e) {
      debugPrint('Error getting notification history from WebDAV: $e');
      return [];
    }
  }
}