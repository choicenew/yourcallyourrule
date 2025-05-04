import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:yourcallyourrule/cloud_sync/sync_progress_tracker.dart';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import '../enhanced_cloud_sync_service.dart';
import '../sync_conflict_resolver.dart';
import '../cloud_sync_service.dart';
import '../../core/entities/rule/rule_base.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

/// WebDAV同步服务实现
/// 提供与WebDAV服务器的云同步功能
class WebDAVSyncService extends EnhancedCloudSyncService {
  webdav.Client? _webdavClient;
  bool _isInitialized = false;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // WebDAV配置
  String? _serverUrl;
  String? _username;
  String? _password;
  
  // WebDAV文件夹配置
  static const String _defaultAppFolderName = 'YourCallYourRule';
  String _appFolderName = _defaultAppFolderName;
  late String _rulesFolderName;
  late String _settingsFolderName;
  late String _historyFolderName;
  late String _devicesFolderName;
  
  void _updateFolderPaths() {
    _rulesFolderName = '$_appFolderName/Rules';
    _settingsFolderName = '$_appFolderName/Settings';
    _historyFolderName = '$_appFolderName/History';
    _devicesFolderName = '$_appFolderName/Devices';
  }
  
  @override
  String get serviceType => 'WebDAV';
  
  @override
  String get serviceName => 'WebDAV';
  
  /// 构造函数
  WebDAVSyncService({
    super.defaultStrategy,
  });
  
  @override
  Future<void> doInitialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;
    
    // 设置自定义应用文件夹名称
    if (config['app_folder_name'] != null) {
      _appFolderName = config['app_folder_name'] as String;
    }
    
    _updateFolderPaths();
    
    // 尝试从安全存储中读取凭据
    _serverUrl = await _secureStorage.read(key: 'webdav_server_url');
    _username = await _secureStorage.read(key: 'webdav_username');
    _password = await _secureStorage.read(key: 'webdav_password');
    
    // 如果有凭据，尝试连接
    if (_serverUrl != null && _username != null && _password != null) {
      await _initWebDAVClient();
    }
    
    _isInitialized = true;
  }
  
  /// 初始化WebDAV客户端
  Future<void> _initWebDAVClient() async {
    if (_serverUrl == null || _username == null || _password == null) return;
    
    try {
      final dio = webdav.WdDio();
      final auth = webdav.Auth(user: _username!, pwd: _password!);
      
      _webdavClient = webdav.Client(
        uri: _serverUrl!,
        c: dio,
        auth: auth,
        debug: kDebugMode,
      );
      
      // 测试连接
      await _webdavClient!.ping();
    } catch (e) {
      debugPrint('初始化WebDAV客户端失败: $e');
      _webdavClient = null;
    }
  }
  
  @override
  Future<bool> connect(Map<String, dynamic> credentials) async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在连接到WebDAV服务器...',
    );
    
    try {
      // 从凭据中获取连接信息
      final serverUrl = credentials['server_url'] as String?;
      final username = credentials['username'] as String?;
      final password = credentials['password'] as String?;
      
      if (serverUrl == null || username == null || password == null) {
        progressTracker.reportError(
          errorMessage: '连接到WebDAV服务器失败: 缺少必要的凭据',
        );
        return false;
      }
      
      // 保存凭据
      _serverUrl = serverUrl;
      _username = username;
      _password = password;
      
      await _secureStorage.write(key: 'webdav_server_url', value: serverUrl);
      await _secureStorage.write(key: 'webdav_username', value: username);
      await _secureStorage.write(key: 'webdav_password', value: password);
      
      // 初始化客户端
      await _initWebDAVClient();
      
      if (_webdavClient == null) {
        progressTracker.reportError(
          errorMessage: '连接到WebDAV服务器失败: 无法初始化客户端',
        );
        return false;
      }
      
      // 创建必要的文件夹
      await _createFolders();
      
      progressTracker.updateProgress(
        operationType: SyncOperationType.initialization,
        progress: 100,
        message: '已连接到WebDAV服务器',
      );
      
      return true;
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '连接到WebDAV服务器失败: $e',
      );
      return false;
    }
  }
  
  @override
  Future<bool> disconnect() async {
    progressTracker.updateProgress(
      operationType: SyncOperationType.initialization,
      progress: 0,
      message: '正在断开WebDAV服务器连接...',
    );
    
    try {
      // 清除凭据
      _serverUrl = null;
      _username = null;
      _password = null;
      _webdavClient = null;
      
      await _secureStorage.delete(key: 'webdav_server_url');
      await _secureStorage.delete(key: 'webdav_username');
      await _secureStorage.delete(key: 'webdav_password');
      
      progressTracker.updateProgress(
        operationType: SyncOperationType.initialization,
        progress: 100,
        message: '已断开WebDAV服务器连接',
      );
      
      return true;
    } catch (e) {
      progressTracker.reportError(
        errorMessage: '断开WebDAV服务器连接失败: $e',
      );
      return false;
    }
  }
  
  @override
  Future<bool> isConfigured() async {
    return _webdavClient != null && _serverUrl != null && _username != null && _password != null;
  }
  
  /// 创建必要的文件夹
  Future<void> _createFolders() async {
    if (_webdavClient == null) return;
    
    try {
      // 创建应用文件夹
      try {
        await _webdavClient!.readProps(_appFolderName);
      } catch (e) {
        await _webdavClient!.mkdir(_appFolderName);
      }
      
      // 创建子文件夹
      final folders = [
        _rulesFolderName,
        _settingsFolderName,
        _historyFolderName,
        _devicesFolderName,
      ];
      
      for (final folder in folders) {
        try {
          await _webdavClient!.readProps(folder);
        } catch (e) {
          await _webdavClient!.mkdir(folder);
        }
      }
    } catch (e) {
      debugPrint('创建WebDAV文件夹失败: $e');
    }
  }
  
  @override
  Future<bool> doRegisterDeviceForSync(DeviceEntity device) async {
    if (_webdavClient == null) return false;
    
    try {
      // 将设备信息转换为JSON
      final deviceJson = CloudDataConverter.serialize(device);
      final deviceJsonStr = jsonEncode(deviceJson);
      
      // 设备文件路径
      final deviceFilePath = '$_devicesFolderName/device_${device.id}.json';
      
      // 上传设备文件
      await _uploadFile(deviceFilePath, deviceJsonStr);
      
      return true;
    } catch (e) {
      debugPrint('注册设备失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<DeviceEntity>> getRegisteredDevicesFromCloud() async {
    if (_webdavClient == null) return [];
    
    try {
      // 获取设备文件夹中的所有文件
      final files = await _webdavClient!.readDir(_devicesFolderName);
      
      if (files.isEmpty) return [];
      
      final devices = <DeviceEntity>[];
      
      for (final file in files) {
        if (file.isDir || !file.name.endsWith('.json')) continue;
        
        // 下载设备文件内容
        final content = await _downloadFile('$_devicesFolderName/${file.name}');
        if (content != null) {
          try {
            final deviceJson = jsonDecode(content) as Map<String, dynamic>;
            final device = CloudDataConverter.deserialize<DeviceEntity>(deviceJson);
            devices.add(device);
          } catch (e) {
            debugPrint('解析设备文件失败: $e');
          }
        }
      }
      
      return devices;
    } catch (e) {
      debugPrint('获取注册设备失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncDeviceInfo(DeviceEntity device) async {
    return await doRegisterDeviceForSync(device);
  }
  
  @override
  Future<bool> syncDevicesFromCloud() async {
    // 这个方法在实际应用中应该将云端设备信息同步到本地设备注册表
    // 这里简单返回true，实际实现应该更复杂
    return true;
  }
  
  @override
  Future<bool> doSyncRules(List<RuleBase> rules) async {
    if (_webdavClient == null) return false;
    
    try {
      // 将规则列表转换为JSON
      final rulesJsonList = rules.map((rule) => CloudDataConverter.serialize(rule)).toList();
      final rulesJsonStr = jsonEncode(rulesJsonList);
      
      // 规则文件路径
      const rulesFileName = 'rules.json';
      final rulesFilePath = '$_rulesFolderName/$rulesFileName';
      
      // 上传规则文件
      await _uploadFile(rulesFilePath, rulesJsonStr);
      
      return true;
    } catch (e) {
      debugPrint('同步规则失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<RuleBase>> doGetRulesFromCloud() async {
    if (_webdavClient == null) return [];
    
    try {
      // 规则文件路径
      const rulesFileName = 'rules.json';
      final rulesFilePath = '$_rulesFolderName/$rulesFileName';
      
      // 检查文件是否存在
      try {
        await _webdavClient!.readProps(rulesFilePath);
      } catch (e) {
        return [];
      }
      
      // 下载规则文件内容
      final content = await _downloadFile(rulesFilePath);
      if (content != null) {
        try {
          final rulesJsonList = jsonDecode(content) as List<dynamic>;
          final rules = rulesJsonList.map((ruleJson) {
            // 这里需要根据规则类型创建不同的规则对象
            // 实际实现应该更复杂，这里简化处理
            return CloudDataConverter.deserialize<RuleBase>(ruleJson as Map<String, dynamic>);
          }).toList();
          return rules;
        } catch (e) {
          debugPrint('解析规则文件失败: $e');
        }
      }
      
      return [];
    } catch (e) {
      debugPrint('获取规则失败: $e');
      return [];
    }
  }
  
  @override
  Future<bool> syncSettings(Map<String, dynamic> settings) async {
    if (_webdavClient == null) return false;
    
    try {
      // 将设置转换为JSON字符串
      final settingsJsonStr = jsonEncode(settings);
      
      // 设置文件路径
      const settingsFileName = 'settings.json';
      final settingsFilePath = '$_settingsFolderName/$settingsFileName';
      
      // 上传设置文件
      await _uploadFile(settingsFilePath, settingsJsonStr);
      
      return true;
    } catch (e) {
      debugPrint('同步设置失败: $e');
      return false;
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getSettingsFromCloud() async {
    if (_webdavClient == null) return null;
    
    try {
      // 设置文件路径
      const settingsFileName = 'settings.json';
      final settingsFilePath = '$_settingsFolderName/$settingsFileName';
      
      // 检查文件是否存在
      if (!await _webdavClient!.exists(settingsFilePath)) {
        return null;
      }
      
      // 下载设置文件内容
      final content = await _downloadFile(settingsFilePath);
      if (content != null) {
        try {
          return jsonDecode(content) as Map<String, dynamic>;
        } catch (e) {
          debugPrint('解析设置文件失败: $e');
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('获取设置失败: $e');
      return null;
    }
  }
  
  @override
  Future<bool> syncHistory(List<Map<String, dynamic>> history) async {
    if (_webdavClient == null) return false;
    
    try {
      // 将历史记录转换为JSON字符串
      final historyJsonStr = jsonEncode(history);
      
      // 历史记录文件路径
      const historyFileName = 'history.json';
      final historyFilePath = '$_historyFolderName/$historyFileName';
      
      // 上传历史记录文件
      await _uploadFile(historyFilePath, historyJsonStr);
      
      return true;
    } catch (e) {
      debugPrint('同步历史记录失败: $e');
      return false;
    }
  }
  
  @override
  Future<List<Map<String, dynamic>>> getHistoryFromCloud() async {
    if (_webdavClient == null) return [];
    
    try {
      // 历史记录文件路径
      const historyFileName = 'history.json';
      final historyFilePath = '$_historyFolderName/$historyFileName';
      
      // 检查文件是否存在
      if (!await _webdavClient!.exists(historyFilePath)) {
        return [];
      }
      
      // 下载历史记录文件内容
      final content = await _downloadFile(historyFilePath);
      if (content != null) {
        try {
          final historyJsonList = jsonDecode(content) as List<dynamic>;
          return historyJsonList.cast<Map<String, dynamic>>();
        } catch (e) {
          debugPrint('解析历史记录文件失败: $e');
        }
      }
      
      return [];
    } catch (e) {
      debugPrint('获取历史记录失败: $e');
      return [];
    }
  }
  
  /// 上传文件
  Future<void> _uploadFile(String filePath, String content) async {
    if (_webdavClient == null) return;
    
    try {
      final contentBytes = utf8.encode(content);
      await _webdavClient!.write(
        filePath,
        Uint8List.fromList(contentBytes),
      );
    } catch (e) {
      debugPrint('上传文件失败: $e');
      rethrow;
    }
  }
  
  /// 下载文件
  Future<String?> _downloadFile(String filePath) async {
    if (_webdavClient == null) return null;
    
    try {
      final bytes = await _webdavClient!.read(filePath);
      return utf8.decode(bytes);
    } catch (e) {
      debugPrint('下载文件失败: $e');
      return null;
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
}