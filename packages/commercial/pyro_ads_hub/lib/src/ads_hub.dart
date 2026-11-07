import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'arbitrator/waterfall_strategy_arbitrator.dart';

typedef NetworkAdapterBuilder = NetworkAdapter Function();

/// 全局广告驱动注册中心与瀑布流调度中枢 (Ads Hub Service Locator)
/// 彻底去除硬编码 100% 依赖动态注册与 Policy 策略映射
class AdsHub {
  AdsHub._() {
    _arbitrator = WaterfallStrategyArbitrator(this);
  }

  static final AdsHub instance = AdsHub._();

  final Map<String, NetworkAdapter> _drivers = {};
  final Map<int, NetworkAdapter> _driversByLevel = {};
  final Map<String, NetworkAdapterBuilder> _builders = {};
  final Map<String, AdServiceUIConfig> _uiConfigs = {};
  
  // 零硬编码： Tier -> Provider 映射由 AdPolicyManager 或外部配置动态调用 mapTierProvider 注入
  final Map<AdTrafficTier, String> _tierProviderMap = {};

  AdsConfig? _adsConfig;
  late final WaterfallStrategyArbitrator _arbitrator;

  WaterfallStrategyArbitrator get arbitrator => _arbitrator;

  /// 注入集中式全平台生产广告 ID 配置大本营
  void setProductionConfig(AdsConfig config) {
    _adsConfig = config;
    debugPrint('[AdsHub] Production AdsConfig injected.');
  }

  /// 获取全平台生产广告位 ID 配置
  AdsConfig? get adsConfig => _adsConfig;

  /// 根据 Provider ID 与 槽位形态从全局生产 AdsConfig 提取真实的 Placement ID
  String? getPlacementId(String providerId, AdSlotType slotType) {
    return _adsConfig?.getPlacementId(providerId, slotType);
  }

  /// 注册驱动实例并按 Level 映射 (0 switch/case，查表 Map 存储)
  void registerDriver({required int level, required NetworkAdapter adapter, AdServiceUIConfig? uiConfig}) {
    _driversByLevel[level] = adapter;
    register(adapter, uiConfig: uiConfig);
  }

  /// 依据数字标量 Level 动态查表索取已注册驱动 (0 switch/case，O(1) Map 查表)
  NetworkAdapter? resolveAdapterByLevel(int level) {
    if (_driversByLevel.containsKey(level)) {
      return _driversByLevel[level];
    }
    final tier = AdTrafficTier.fromLevel(level);
    return getDriverByTier(tier) ?? _driversByLevel.values.firstOrNull;
  }

  /// 注册驱动实例
  void register(NetworkAdapter adapter, {AdServiceUIConfig? uiConfig}) {
    final key = adapter.providerId.toLowerCase();
    _drivers[key] = adapter;
    if (uiConfig != null) {
      _uiConfigs[key] = uiConfig;
    }
    debugPrint('[AdsHub] Registered driver: ${adapter.providerName} ($key)');
  }

  /// 注册驱动构造器
  void registerBuilder(
    String providerId,
    NetworkAdapterBuilder builder, {
    AdServiceUIConfig? uiConfig,
  }) {
    final key = providerId.toLowerCase();
    _builders[key] = builder;
    if (uiConfig != null) {
      _uiConfigs[key] = uiConfig;
    }
    debugPrint('[AdsHub] Registered builder for: $key');
  }

  /// 动态绑定/重映射 Tier 对应的驱动 Provider ID (由 AdPolicyManager 策略决策动态映射)
  void mapTierProvider(AdTrafficTier tier, String providerId) {
    _tierProviderMap[tier] = providerId.toLowerCase();
    debugPrint('[AdsHub] Dynamic Tier mapped: ${tier.name} -> $providerId');
  }

  /// 根据 Provider ID 获取已注册的驱动实例
  NetworkAdapter? getDriver(String providerId) {
    final key = providerId.toLowerCase();
    if (_drivers.containsKey(key)) {
      return _drivers[key];
    }
    if (_builders.containsKey(key)) {
      final adapter = _builders[key]!();
      _drivers[key] = adapter;
      return adapter;
    }
    return null;
  }

  /// 根据 Tier 获取挂载在该梯队的驱动
  NetworkAdapter? getDriverByTier(AdTrafficTier tier) {
    final providerId = _tierProviderMap[tier];
    if (providerId != null) {
      final driver = getDriver(providerId);
      if (driver != null) return driver;
    }
    // 动态回退：若未映射或该 Tier 驱动未注册，回退获取第一个已注册驱动
    return _drivers.values.firstOrNull;
  }

  /// 初始化当前所有已注册的适配器微包
  Future<void> initializeRegisteredAdapters(Map<String, dynamic> config) async {
    final registeredKeys = {..._drivers.keys, ..._builders.keys};
    for (final key in registeredKeys) {
      final driver = getDriver(key);
      if (driver != null) {
        try {
          await driver.initialize(config);
          debugPrint('[AdsHub] Initialized driver: ${driver.providerName}');
        } catch (e) {
          debugPrint('[AdsHub] Failed to initialize driver $key: $e');
        }
      }
    }
  }

  /// 获取驱动的 UI 配置元数据
  AdServiceUIConfig? getUIConfig(String providerId) {
    return _uiConfigs[providerId.toLowerCase()];
  }

  /// 获取所有可用驱动 ID 列表
  List<String> get availableProviders {
    final keys = <String>{..._drivers.keys, ..._builders.keys};
    return keys.toList();
  }

  /// 清理状态 (测试用)
  void clear() {
    _drivers.clear();
    _driversByLevel.clear();
    _builders.clear();
    _uiConfigs.clear();
    _tierProviderMap.clear();
    _adsConfig = null;
  }
}
