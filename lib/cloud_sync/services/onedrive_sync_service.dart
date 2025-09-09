import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/environment.dart';
import 'package:yourcallyourrule/cloud_sync/provider/device_management_provider.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
//import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'enhanced_cloud_sync_service.dart';
//import 'sync_conflict_resolver.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:msal_auth/msal_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';



/// OneDrive implementation of the CloudSyncService with conflict resolution,
/// incremental sync, and progress tracking capabilities
class OneDriveSyncService extends EnhancedCloudSyncService {
  /// Reference to the Riverpod container
  final Ref? ref;
  final Dio _dio = Dio();
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // MSAL Authentication
  MultipleAccountPca? _multipleAccountPca;
  AuthenticationResult? _authenticationResult;
  Account? _user;
  
  // MSAL Configuration
  final String _clientId = Environment.msalClientId;
  final List<String> _scopes = [
    'Files.ReadWrite.All',
    'Sites.ReadWrite.All',
    'Directory.ReadWrite.All',
  ];
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  
  // Configuration keys
  static const String _accessTokenKey = 'config_onedrive_access_token';
  static const String _refreshTokenKey = 'config_onedrive_refresh_token';
  static const String _tokenExpiryKey = 'config_onedrive_token_expiry';
  static const String _appFolderNameKey = 'config_onedrive_app_folder_name';
  
  // OneDrive API endpoints
  static const String _driveUrl = 'https://graph.microsoft.com/v1.0/me/drive';
  
  // File paths in OneDrive
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
  

  @override
  String get serviceType => 'OneDrive';
  
  @override
  String get serviceName => 'Microsoft OneDrive';
  
  /// Constructor with required config repository and optional conflict resolution strategy
  OneDriveSyncService({
    required super.configRepository,
    super.defaultStrategy,
    required this.ref,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    // Load saved tokens if available
    _accessToken = await _secureStorage.read(key: _accessTokenKey);
    _refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      _tokenExpiry = DateTime.parse(expiryString);
    }
    
    // Set custom app folder name if provided in config or from secure storage
    final savedFolderName = await _secureStorage.read(key: _appFolderNameKey);
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
      // Save the custom folder name for future use
      await _secureStorage.write(key: _appFolderNameKey, value: _appFolderName);
    } else if (savedFolderName != null) {
      _appFolderName = savedFolderName;
    }
    
    _updateFolderPaths();
    
    _isInitialized = true;
  }
  
  @override
  Future<bool> isConfigured() async {
    return _accessToken != null && _refreshToken != null;
  }
  
  @override
  Future<bool> doConnect(Map<String, dynamic> credentials) async {
    try {
      // Initialize MSAL
      await _initMsalAuth();
      
      // Sign in and get token
      final signInResult = await _signIn();
      if (!signInResult) return false;
      
      // Save tokens
      if (_authenticationResult != null) {
        _accessToken = _authenticationResult!.accessToken;
        await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
        
        // Set expiry time
        _tokenExpiry = _authenticationResult!.expiresOn;
        if (_tokenExpiry != null) {
          await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
        }
      }
      
      // Create necessary folders
      await _createAppFolders();
      
      return true;
    } catch (e) {
      debugPrint('OneDrive connection error: $e');
      return false;
    }
  }
  
  Future<void> _initMsalAuth() async {
    final androidConfig = AndroidConfig(
      configFilePath: 'assets/msal_config.json',
      redirectUri: Environment.msalAndroidRedirectUri,
    );

    final appleConfig = AppleConfig(
      authority: Environment.msalIosAuthority,
      authorityType: AuthorityType.aad,
      broker: Broker.msAuthenticator,
    );

    try {
      _multipleAccountPca = await MultipleAccountPca.create(
        clientId: _clientId,
        androidConfig: androidConfig,
        appleConfig: appleConfig,
      );
    } on MsalException catch (e) {
      debugPrint('MSAL initialization error: $e');
    }
  }
  
  Future<bool> _signIn() async {
    try {
      if (_multipleAccountPca == null) {
        await _initMsalAuth();
      }

      // Try to get existing account first
      final accounts = await _multipleAccountPca?.getAccounts();
      if (accounts != null && accounts.isNotEmpty) {
        // Use existing account
        _user = accounts.first;
        try {
          // Try to silently acquire token with existing account
          final silentResult = await _multipleAccountPca?.acquireTokenSilent(
            scopes: _scopes,
            identifier: _user!.toJson()['id'] as String,
          );
          
          if (silentResult != null) {
            _authenticationResult = silentResult;
            _accessToken = silentResult.accessToken;
            _tokenExpiry = silentResult.expiresOn;
            
            // Save tokens
            await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
            if (_tokenExpiry != null) {
              await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
            }
            
            return true;
          }
        } catch (e) {
          // Silent token acquisition failed, will fall back to interactive
          debugPrint('Silent token acquisition failed: $e');
        }
      }
      
      // Interactive sign in if silent acquisition failed or no accounts exist
      final result = await _multipleAccountPca?.acquireToken(scopes: _scopes);
      _authenticationResult = result;
      _user = result?.account;
      _accessToken = result?.accessToken;
      _tokenExpiry = result?.expiresOn;

      if (_user != null) {
        // Save tokens
        await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
        if (_tokenExpiry != null) {
          await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
        }
        return true;
      } else {
        throw Exception('Failed to acquire access token');
      }
    } catch (error) {
      debugPrint('Error signing in to OneDrive: $error');
      return false;
    }
  }
  

  
  Future<bool> _refreshTokenIfNeeded() async {
    try {
      // Check if token is expired or about to expire (within 5 minutes)
      final now = DateTime.now();
      final isExpired = _tokenExpiry == null || 
                       _tokenExpiry!.isBefore(now) || 
                       _tokenExpiry!.difference(now).inMinutes < 5;
      
      if (isExpired) {
        // Try silent token refresh first if we have a user account
        if (_user != null && _multipleAccountPca != null) {
          try {
            final silentResult = await _multipleAccountPca!.acquireTokenSilent(
              scopes: _scopes,
              identifier: _user!.toJson()['id'] as String,
            );
            
            _authenticationResult = silentResult;
            _accessToken = silentResult.accessToken;
            _tokenExpiry = silentResult.expiresOn;
            
            // Save refreshed tokens
            await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
            if (_tokenExpiry != null) {
              await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
            }
            
            return true;
                    } catch (e) {
            debugPrint('Silent token refresh failed: $e');
            // Fall back to interactive refresh
          }
        }
        
        // Interactive refresh as fallback
        final result = await _multipleAccountPca?.acquireToken(scopes: _scopes);
        if (result != null) {
          _authenticationResult = result;
          _accessToken = result.accessToken;
          _tokenExpiry = result.expiresOn;
          _user = result.account;
          
          // Save refreshed tokens
          await _secureStorage.write(key: _accessTokenKey, value: _accessToken);
          if (_tokenExpiry != null) {
            await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
          }
          
          return true;
        }
        return false;
      }
      return true; // Token is still valid
    } catch (e) {
      debugPrint('Error refreshing token: $e');
      return false;
    }
  }
  
  Future<void> _createAppFolders() async {
    if (!await _refreshTokenIfNeeded()) return;
    
    // Create app root folder
    await _createFolder(_appFolderName);
    
    // Create subfolders
    await _createFolder('$_appFolderName/$_rulesFolderName');
    await _createFolder('$_appFolderName/$_settingsFolderName');
    await _createFolder('$_appFolderName/$_devicesFolderName');
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
              'Authorization': 'Bearer ${_authenticationResult?.accessToken}',
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
            'Authorization': 'Bearer ${_authenticationResult?.accessToken}',
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
      // Sign out from MSAL
      final accounts = await _multipleAccountPca?.getAccounts();
      if (accounts != null) {
        for (final account in accounts) {
          final identifier = account.toJson()['id'] as String;
          await _multipleAccountPca?.removeAccount(identifier: identifier);
        }
      }
      
      // Clear saved tokens from secure storage
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _tokenExpiryKey);
      
      // Reset instance variables
      _user = null;
      _authenticationResult = null;
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
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // Get or create rules folder
      final rulesFolder = await _getFolderByPath('$_appFolderName/$_rulesFolderName');
      if (rulesFolder == null) return false;
      
      final folderId = rulesFolder['id'] as String;
      
      // Convert rules to JSON using CloudDataConverter
      final rulesJson = jsonEncode(rules.map((rule) => CloudDataConverter.serialize(rule)).toList());
      
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
  Future<List<RuleBase>> getRulesFromCloud() async {
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
        final List<dynamic> rulesJson = jsonDecode(response.data as String);
        return rulesJson
            .map((json) => CloudDataConverter.deserialize<RuleBase>(json as Map<String, dynamic>))
            .toList();
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
        '$_driveUrl/items/$folderId:/app_settings.json:/content',
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
        '$_driveUrl/items/$folderId:/app_settings.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_authenticationResult?.accessToken}',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.data as String) as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      debugPrint('Error getting settings from OneDrive: $e');
      return {};
    }
  }
  
  @override

  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (!await _refreshTokenIfNeeded()) return false;
    
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
      
      // Get or create devices folder
      final devicesFolder = await _getFolderByPath('$_appFolderName/$_devicesFolderName');
      if (devicesFolder == null) return false;
      
      final folderId = devicesFolder['id'] as String;
      
      // Convert devices to JSON
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      
      // Upload devices file
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/registered_devices.json:/content',
        data: devicesJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Error registering device for sync: $e');
      return false;
    }
  }
  
  @override
  Future<List<DeviceEntity>> doGetRegisteredDevicesFromCloud() async {
    if (!await _refreshTokenIfNeeded()) return [];
    
    try {
      // Get devices folder
      final devicesFolder = await _getFolderByPath('$_appFolderName/$_devicesFolderName');
      if (devicesFolder == null) return [];
      
      final folderId = devicesFolder['id'] as String;
      
      try {
        // Download devices file
        final response = await _dio.get(
          '$_driveUrl/items/$folderId:/registered_devices.json:/content',
          options: Options(
            headers: {
              'Authorization': 'Bearer $_accessToken',
            },
          ),
        );
        
        if (response.statusCode == 200) {
          final List<dynamic> devicesList = jsonDecode(response.data as String);
          return devicesList
              .map((json) => DeviceEntity.fromJson(json as Map<String, dynamic>))
              .toList();
        }
        return [];
      } catch (e) {
        // File might not exist yet
        debugPrint('Devices file not found or error: $e');
        return [];
      }
    } catch (e) {
      debugPrint('Error getting registered devices from OneDrive: $e');
      return [];
    }
  }

  @override
  Future<bool> doCheckOnlineStatus() async {
    if (!await _refreshTokenIfNeeded()) return false;
    try {
      final response = await _dio.get(
        'https://graph.microsoft.com/v1.0/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('OneDrive online check failed: $e');
      return false;
    }
  }
  
  @override
  Future<bool> doSyncDeviceInfo(DeviceEntity device) async {
    if (!await _refreshTokenIfNeeded()) return false;
    
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
      
      // Get or create devices folder
      final devicesFolder = await _getFolderByPath('$_appFolderName/$_devicesFolderName');
      if (devicesFolder == null) return false;
      
      final folderId = devicesFolder['id'] as String;
      
      // Convert devices to JSON
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      
      // Upload devices file
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/registered_devices.json:/content',
        data: devicesJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
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
      if (cloudDevices.isEmpty) return true; // No devices to sync
      
      // Use DeviceManagementService to update local device registry
      final deviceManagementService = ref!.read(deviceManagementServiceProvider);
      
      if (deviceManagementService != null) {
        // Get current device
        final currentDevice = await deviceManagementService.getCurrentDevice();
        
        // Register each cloud device in the local registry
        for (final cloudDevice in cloudDevices) {
          // Skip current device as it's managed locally
          if (cloudDevice.id == currentDevice.id) continue;
          
          // Register or update the device
          await deviceManagementService.registerDevice(cloudDevice);
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