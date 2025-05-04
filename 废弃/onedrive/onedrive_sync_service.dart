import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import '../enhanced_cloud_sync_service.dart';
import '../sync_conflict_resolver.dart';
import '../cloud_sync_service.dart';
import '../sync_progress_tracker.dart';
import '../../core/entities/rule/rule_base.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

/// OneDrive同步服务实现
/// 提供与Microsoft OneDrive的云同步功能
class OneDriveSyncService extends EnhancedCloudSyncService {
  final Dio _dio = Dio();
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // 配置键
  static const String _clientIdKey = 'onedrive_client_id';
  static const String _clientSecretKey = 'onedrive_client_secret';
  static const String _accessTokenKey = 'onedrive_access_token';
  static const String _refreshTokenKey = 'onedrive_refresh_token';
  static const String _tokenExpiryKey = 'onedrive_token_expiry';
  
  // OneDrive API端点
  static const String _authUrl = 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize';
  static const String _tokenUrl = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
  static const String _driveUrl = 'https://graph.microsoft.com/v1.0/me/drive';
  static const String _redirectUri = 'https://login.microsoftonline.com/common/oauth2/nativeclient';
  
  // OneDrive文件夹配置
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
  
  String? _clientId;
  String? _clientSecret;
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  
  @override
  String get serviceType => 'OneDrive';
  
  @override
  String get serviceName => 'Microsoft OneDrive';
  
  /// 构造函数
  OneDriveSyncService({
    super.defaultStrategy,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    _clientId = config['client_id'] as String?;
    _clientSecret = config['client_secret'] as String?;
    
    // 加载保存的令牌（如果有）
    _accessToken = await _secureStorage.read(key: _accessTokenKey);
    _refreshToken = await _secureStorage.read(key: _refreshTokenKey);
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      _tokenExpiry = DateTime.parse(expiryString);
    }
    
    // 设置自定义应用文件夹名称（如果提供）
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
  Future<bool> connect(Map<String, dynamic> credentials) async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在连接到OneDrive...',
    );
    
    try {
      _clientId = credentials['client_id'] as String?;
      _clientSecret = credentials['client_secret'] as String?;
      
      if (_clientId == null || _clientSecret == null) {
        progressTracker.reportError(
          errorMessage: '连接到OneDrive失败: 缺少客户端ID或密钥',
        );
        return false;
      }
      
      // 保存凭据
      await _secureStorage.write(key: _clientIdKey, value: _clientId!);
      await _secureStorage.write(key: _clientSecretKey, value: _clientSecret!);
      
      // 启动OAuth流程
      final authCode = await _getAuthorizationCode();
      if (authCode == null) {
        progressTracker.reportError(
          errorMessage: '连接到OneDrive失败: 未能获取授权码',
        );
        return false;
      }
      
      // 交换授权码获取令牌
      final tokenResponse = await _exchangeCodeForTokens(authCode);
      if (tokenResponse == null) {
        progressTracker.reportError(
          errorMessage: '连接到OneDrive失败: 未能获取访问令牌',
        );
        return false;
      }
      
      // 创建必要的文件夹
      await _createFolders();
      
      progressTracker.updateProgress(
        operationType: SyncOperationType.initialization,
        progress: 100,
        message: '已连接到OneDrive',
      );
      
      return true;
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '连接到OneDrive失败: $e',
      );
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
    
    // 启动浏览器进行授权
    if (await canLaunchUrl(authUri)) {
      await launchUrl(authUri, mode: LaunchMode.externalApplication);
      // 在实际应用中，你需要处理重定向并提取代码
      // 这是一个简化版本，需要手动输入代码或使用自定义URL方案捕获重定向
      return null; // 实际实现的占位符
    } else {
      throw Exception('无法启动授权URL');
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
        
        // 安全保存令牌
        await _secureStorage.write(key: _accessTokenKey, value: _accessToken!);
        await _secureStorage.write(key: _refreshTokenKey, value: _refreshToken!);
        await _secureStorage.write(key: _tokenExpiryKey, value: _tokenExpiry!.toIso8601String());
        
        return data;
      }
      return null;
    } catch (e) {
      debugPrint('交换代码获取令牌时出错: $e');
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
        debugPrint('刷新令牌时出错: $e');
        return false;
      }
    }
    return true; // 令牌仍然有效
  }
  
  Future<void> _createFolders() async {
    if (!await _refreshTokenIfNeeded()) return;
    
    // 创建应用根文件夹
    await _createFolder(_appFolderName);
    
    // 创建子文件夹
    await _createFolder('$_appFolderName/$_rulesFolderName');
    await _createFolder('$_appFolderName/$_settingsFolderName');
    await _createFolder('$_appFolderName/$_historyFolderName');
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
        
        // 检查文件夹是否存在
        final existingFolder = await _getFolderByPath(currentPath);
        if (existingFolder != null) {
          result = existingFolder;
          continue;
        }
        
        // 获取父文件夹ID
        String? parentId;
        if (parentPath.isEmpty) {
          parentId = 'root';
        } else {
          final parent = await _getFolderByPath(parentPath);
          parentId = parent?['id'] as String?;
          if (parentId == null) return null;
        }
        
        // 创建文件夹
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
      debugPrint('创建文件夹时出错: $e');
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
      // 项目未找到或其他错误
      return null;
    }
  }
  
  @override
  Future<bool> disconnect() async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在断开OneDrive连接...',
    );
    
    try {
      // 清除存储的令牌
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
      await _secureStorage.delete(key: _tokenExpiryKey);
      
      // 重置实例变量
      _accessToken = null;
      _refreshToken = null;
      _tokenExpiry = null;
      
      progressTracker.updateProgress(
        operationType: SyncOperationType.initialization,
        progress: 100,
        message: '已断开OneDrive连接',
      );
      
      return true;
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '断开OneDrive连接失败: $e',
      );
      return false;
    }
  }
  
  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // 获取或创建规则文件夹
      final rulesFolder = await _getFolderByPath('$_appFolderName/$_rulesFolderName');
      if (rulesFolder == null) return false;
      
      final folderId = rulesFolder['id'] as String;
      
      // 将规则转换为JSON
      final rulesData = rules.map((rule) => CloudDataConverter.serialize(rule)).toList();
      final rulesJson = jsonEncode(rulesData);
      
      // 上传规则文件
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
      debugPrint('同步规则到OneDrive失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleBase>> doGetRulesFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      // 获取规则文件夹
      final rulesFolder = await _getFolderByPath('$_appFolderName/$_rulesFolderName');
      if (rulesFolder == null) return [];
      
      final folderId = rulesFolder['id'] as String;
      
      // 下载规则文件
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
        return rulesData.map((data) => CloudDataConverter.deserialize<RuleBase>(data as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('从OneDrive获取规则失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncSettings(Map<String, dynamic> settings) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // 获取或创建设置文件夹
      final settingsFolder = await _getFolderByPath('$_appFolderName/$_settingsFolderName');
      if (settingsFolder == null) return false;
      
      final folderId = settingsFolder['id'] as String;
      
      // 将设置转换为JSON
      final settingsJson = jsonEncode(settings);
      
      // 上传设置文件
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
      debugPrint('同步设置到OneDrive失败: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return null;
      
      // 获取设置文件夹
      final settingsFolder = await _getFolderByPath('$_appFolderName/$_settingsFolderName');
      if (settingsFolder == null) return null;
      
      final folderId = settingsFolder['id'] as String;
      
      // 下载设置文件
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
      return null;
    } catch (e) {
      debugPrint('从OneDrive获取设置失败: $e');
      return null;
    }
  }

  Future<bool> syncPlugins(List<PluginEntry> plugins) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      final pluginsFolder = await _getFolderByPath('$_appFolderName/Plugins');
      if (pluginsFolder == null) return false;
      
      final folderId = pluginsFolder['id'] as String;
      final pluginsJson = jsonEncode(plugins.map((plugin) => plugin.toMap()).toList());
      
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/plugins.json:/content',
        data: pluginsJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('同步插件到OneDrive失败: $e');
      return false;
    }
  }

  Future<List<PluginEntry>> getPluginsFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      final pluginsFolder = await _getFolderByPath('$_appFolderName/Plugins');
      if (pluginsFolder == null) return [];
      
      final folderId = pluginsFolder['id'] as String;
      
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/plugins.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        final List<dynamic> pluginsData = jsonDecode(jsonData) as List<dynamic>;
        return pluginsData
            .map((data) => PluginEntry.fromMap(data as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('从OneDrive获取插件失败: $e');
      return [];
    }
  }

  Future<bool> syncSubscriptions(List<SmsSubscription> subscriptions) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      final subscriptionsFolder = await _getFolderByPath('$_appFolderName/Subscriptions');
      if (subscriptionsFolder == null) return false;
      
      final folderId = subscriptionsFolder['id'] as String;
      final subscriptionsJson = jsonEncode(subscriptions.map((sub) => sub.toMap()).toList());
      
      final response = await _dio.put(
        '$_driveUrl/items/$folderId:/subscriptions.json:/content',
        data: subscriptionsJson,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('同步订阅到OneDrive失败: $e');
      return false;
    }
  }

  Future<List<SmsSubscription>> getSubscriptionsFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      final subscriptionsFolder = await _getFolderByPath('$_appFolderName/Subscriptions');
      if (subscriptionsFolder == null) return [];
      
      final folderId = subscriptionsFolder['id'] as String;
      
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/subscriptions.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        final List<dynamic> subscriptionsData = jsonDecode(jsonData) as List<dynamic>;
        return subscriptionsData
            .map((data) => SmsSubscription.fromMap(data as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('从OneDrive获取订阅失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncHistory(List<Map<String, dynamic>> history) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // 获取或创建历史记录文件夹
      final historyFolder = await _getFolderByPath('$_appFolderName/$_historyFolderName');
      if (historyFolder == null) return false;
      
      final folderId = historyFolder['id'] as String;
      
      // 将历史记录转换为JSON
      final historyJson = jsonEncode(history);
      
      // 上传历史记录文件
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
      debugPrint('同步历史记录到OneDrive失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getHistoryFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      // 获取历史记录文件夹
      final historyFolder = await _getFolderByPath('$_appFolderName/$_historyFolderName');
      if (historyFolder == null) return [];
      
      final folderId = historyFolder['id'] as String;
      
      // 下载历史记录文件
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
      debugPrint('从OneDrive获取历史记录失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    try {
      if (!await _refreshTokenIfNeeded()) return false;
      
      // 获取现有设备以避免重复
      final devices = await getRegisteredDevicesFromCloud();
      
      // 检查设备是否已存在
      final existingDeviceIndex = devices.indexWhere((d) => d.id == device.id);
      if (existingDeviceIndex >= 0) {
        // 更新现有设备
        devices[existingDeviceIndex] = device;
      } else {
        // 添加新设备
        devices.add(device);
      }
      
      // 获取或创建设备文件夹
      final devicesFolder = await _getFolderByPath('$_appFolderName/$_devicesFolderName');
      if (devicesFolder == null) return false;
      
      final folderId = devicesFolder['id'] as String;
      
      // 将设备转换为JSON
      final devicesJson = jsonEncode(devices.map((device) => device.toJson()).toList());
      
      // 上传设备文件
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
      debugPrint('注册设备进行同步失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<DeviceEntity>> getRegisteredDevicesFromCloud() async {
    try {
      if (!await _refreshTokenIfNeeded()) return [];
      
      // 获取设备文件夹
      final devicesFolder = await _getFolderByPath('$_appFolderName/$_devicesFolderName');
      if (devicesFolder == null) return [];
      
      final folderId = devicesFolder['id'] as String;
      
      // 下载设备文件
      final response = await _dio.get(
        '$_driveUrl/items/$folderId:/registered_devices.json:/content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final jsonData = response.data as String;
        final List<dynamic> devicesData = jsonDecode(jsonData) as List<dynamic>;
        return devicesData
            .map((data) => DeviceEntity.fromJson(data as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('从OneDrive获取已注册设备失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncDeviceInfo(DeviceEntity device) async {
    return await doRegisterDeviceForSync(device);
  }
  
  @override
  Future<bool> syncDevicesFromCloud() async {
    try {
      // 从云端获取设备
      final cloudDevices = await getRegisteredDevicesFromCloud();
      
      if (cloudDevices.isEmpty) {
        return true; // 没有设备需要同步
      }
      
      // 在实际应用中，你通常会更新本地设备注册表
      // 这个实现取决于你的应用如何在本地管理设备
      
      // 现在，我们只返回true表示成功检索
      // 在实际实现中，你会将这些设备保存到本地存储
      
      return true;
    } catch (e) {
      debugPrint('从云端同步设备失败: $e');
      return false;
    }
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
  
  /// 创建规则对象的工厂方法
  /// 根据规则类型创建不同的规则对象
  RuleBase createRuleFromJson(Map<String, dynamic> json) {
    final ruleType = data['_type']?.toString() ?? '';
      switch (ruleType) {
        case 'BlacklistRule':
          return BlacklistRule.fromMap(data);
        case 'WhitelistRule':
          return WhitelistRule.fromMap(data);
        case 'RegexRule':
          return RegexRule.fromMap(data);
        default:
          throw FormatException('未知的规则类型: $ruleType');
      }
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
}