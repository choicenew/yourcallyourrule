import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';

typedef CloudDriveAdapterBuilder = CloudDriveAdapter Function();

/// 全局云盘驱动注册中心与宿主上下文合成中枢 (Service Locator & Host Context Dispatcher)
class CloudDriveHub {
  CloudDriveHub._();
  static final CloudDriveHub instance = CloudDriveHub._();

  final Map<Type, CloudDriveAdapter> _drivers = {};
  final Map<Type, CloudDriveAdapterBuilder> _builders = {};
  final Map<Type, CloudServiceUIConfig> _uiConfigs = {};
  Type? _activeDriverToken;

  // 宿主 App 上下文（由宿主主 App 在启动时动态注入，公共 Package 绝不硬编码）
  String? _appName;
  String? _activeAccountId;

  /// 由宿主 App 统一配置应用元数据（如当前 App 名称、初始影子账户）
  void configureHostContext({
    required String appName,
    String? activeAccountId,
  }) {
    _appName = appName.trim();
    _activeAccountId = activeAccountId?.trim();
  }

  /// 动态更新当前活跃的影子账户 ID (Shadow Account Context)
  void updateActiveAccount(String? accountId) {
    _activeAccountId = accountId?.trim();
  }

  /// 获取当前宿主 App 名称（若宿主尚未配置则返回空字符串）
  String get appName => _appName ?? '';

  /// 获取当前活跃的影子账户 ID
  String? get activeAccountId => _activeAccountId;

  /// 智能合成云端物理隔离工作路径 (格式: /{appName}/{accountId} 或 /{appName})
  String computeRootPath({String? overrideAppName, String? overrideAccountId}) {
    final effectiveApp = (overrideAppName != null && overrideAppName.trim().isNotEmpty)
        ? overrideAppName.trim()
        : (_appName != null && _appName!.isNotEmpty ? _appName! : 'App');
    final effectiveAccount = (overrideAccountId != null && overrideAccountId.trim().isNotEmpty)
        ? overrideAccountId.trim()
        : _activeAccountId;

    if (effectiveAccount != null && effectiveAccount.isNotEmpty) {
      return '/$effectiveApp/$effectiveAccount';
    }
    return '/$effectiveApp';
  }

  /// 注册驱动实例 (100% 使用强类型 Class Token 作为 Key)
  void register(CloudDriveAdapter adapter, {CloudServiceUIConfig? uiConfig}) {
    final token = adapter.driverToken;
    _drivers[token] = adapter;
    if (uiConfig != null) {
      _uiConfigs[token] = uiConfig;
    }
    _activeDriverToken ??= token;
  }

  /// 注册驱动工厂构造器
  void registerBuilder(
    Type driverToken,
    CloudDriveAdapterBuilder builder, {
    CloudServiceUIConfig? uiConfig,
  }) {
    _builders[driverToken] = builder;
    if (uiConfig != null) {
      _uiConfigs[driverToken] = uiConfig;
    }
    _activeDriverToken ??= driverToken;
  }

  /// 泛型与强类型安全获取驱动实例 (支持 Type Token、泛型、以及 JSON/元数据 动态字符串匹配)
  T? getDriver<T extends CloudDriveAdapter>([dynamic providerToken]) {
    final token = providerToken ?? T;
    if (token is Type && token != CloudDriveAdapter) {
      if (_drivers.containsKey(token)) return _drivers[token] as T?;
      if (_builders.containsKey(token)) {
        final adapter = _builders[token]!();
        _drivers[token] = adapter;
        return adapter as T?;
      }
    }
    if (token != null) {
      final search = token.toString().toLowerCase().replaceAll('_', '').replaceAll('adapter', '');
      for (final entry in _drivers.entries) {
        if (entry.key.toString().toLowerCase().replaceAll('_', '').contains(search)) {
          return entry.value as T?;
        }
      }
      for (final entry in _builders.entries) {
        if (entry.key.toString().toLowerCase().replaceAll('_', '').contains(search)) {
          final adapter = entry.value();
          _drivers[entry.key] = adapter;
          return adapter as T?;
        }
      }
    }
    return currentDriver as T?;
  }

  /// 获取驱动的 UI 配置元数据 (纯强类型 Type 入参或动态平滑匹配)
  CloudServiceUIConfig? getUIConfig(dynamic driverToken) {
    if (driverToken is Type && _uiConfigs.containsKey(driverToken)) {
      return _uiConfigs[driverToken];
    }
    if (driverToken != null) {
      final search = driverToken.toString().toLowerCase().replaceAll('_', '').replaceAll('adapter', '');
      for (final entry in _uiConfigs.entries) {
        if (entry.key.toString().toLowerCase().replaceAll('_', '').contains(search)) {
          return entry.value;
        }
      }
    }
    return null;
  }

  /// 获取所有已注册的 UI 配置
  Map<Type, CloudServiceUIConfig> get allUIConfigs => Map.unmodifiable(_uiConfigs);

  /// 强类型安全设置当前全局激活/首选的网盘驱动 Token
  void setActiveProvider(dynamic providerToken) {
    if (providerToken is Type) {
      _activeDriverToken = providerToken;
    } else if (providerToken != null) {
      final driver = getDriver(providerToken);
      if (driver != null) {
        _activeDriverToken = driver.driverToken;
      }
    }
  }

  /// 获取当前激活的网盘驱动实例
  CloudDriveAdapter? get currentDriver =>
      _activeDriverToken != null ? getDriver(_activeDriverToken!) : _drivers.values.firstOrNull;

  /// 获取当前所有可用且已注册的提供商 Token 列表
  List<Type> get availableProviders {
    final keys = <Type>{..._drivers.keys, ..._builders.keys};
    return keys.toList();
  }

  /// 清理所有注册状态（主要用于测试隔离）
  void clear() {
    _drivers.clear();
    _builders.clear();
    _uiConfigs.clear();
    _activeDriverToken = null;
    _appName = null;
    _activeAccountId = null;
  }
}
