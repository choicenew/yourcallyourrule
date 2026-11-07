import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_config_remote/pyro_config_remote.dart';

import 'models/ad_policy_spec.dart';

/// 动态 AdTrafficTier 策略决议委托函数（由主 App 在初始化时传入，物理上 0 依赖风控/算法包）
typedef AdPolicyTierResolver = AdTrafficTier? Function();

/// 商业化广告策略控制器 (Ad Policy Manager)
/// 复刻并演进 pyro_ads_magma 的 Tier 1~5 路由与策略调度体系，
/// 融合本地基准策略、主 App 函数委托与 AuraRemoteConfig 云端 JSON 动态热更新。
class AdPolicyManager extends ValueNotifier<AdTrafficTier> {
  static AdPolicyManager? _instance;

  AdPolicySpec _currentPolicy;
  AuraRemoteConfig? _remoteConfig;
  StreamSubscription? _remoteSubscription;
  AdPolicyTierResolver? _customTierResolver;

  bool _isVipUser = false;
  String _currentRegion = 'US';

  AdPolicyManager._({
    AdPolicySpec initialPolicy = const AdPolicySpec(),
    AdPolicyTierResolver? customTierResolver,
  })  : _currentPolicy = initialPolicy,
        _customTierResolver = customTierResolver,
        super(initialPolicy.defaultTier);

  /// 获取策略控制器单例
  static AdPolicyManager get instance {
    _instance ??= AdPolicyManager._();
    return _instance!;
  }

  /// 当前生效的策略描述符
  AdPolicySpec get currentPolicy => _currentPolicy;

  /// 是否是 VIP 用户 (VIP 自动分配 AdTrafficTier.none)
  bool get isVipUser => _isVipUser;

  /// 由主 App 动态注入或更新自定义策略函数委托 (例如主 App 将风控/算法逻辑的运算结果传递进来)
  void setCustomTierResolver(AdPolicyTierResolver? resolver) {
    _customTierResolver = resolver;
    _reevaluateTier();
  }

  /// 绑定并监听云端 AuraRemoteConfig 双云下发引擎
  void attachRemoteConfig(AuraRemoteConfig remoteConfig) {
    _remoteConfig = remoteConfig;
    _remoteSubscription?.cancel();

    // 1. 尝试从既有配置读取
    _applyRemoteConfigSection(remoteConfig.getSection('commercial_policy'));

    // 2. 监听云端热重载下发流 (Hot Reload Stream)
    _remoteSubscription = remoteConfig.onConfigUpdated.listen((configMap) {
      if (configMap.containsKey('commercial_policy')) {
        final policyMap = configMap['commercial_policy'];
        if (policyMap is Map<String, dynamic>) {
          _applyRemoteConfigSection(policyMap);
        }
      }
    });
  }

  /// 转换解析云端 JSON 并热更新当前策略
  void _applyRemoteConfigSection(Map<String, dynamic> policyJson) {
    if (policyJson.isEmpty) return;
    try {
      _currentPolicy = AdPolicySpec.fromJson(policyJson);
      _reevaluateTier();
      debugPrint('[AdPolicyManager] Remote commercial_policy applied successfully. Active Tier: ${value.name}');
    } catch (e) {
      debugPrint('[AdPolicyManager] Failed to apply remote commercial_policy: $e');
    }
  }

  /// 更新本地用户 VIP 状态
  void updateVipStatus(bool isVip) {
    if (_isVipUser != isVip) {
      _isVipUser = isVip;
      _reevaluateTier();
    }
  }

  /// 更新当前地区代码 (用于云端地域策略重定向)
  void updateRegion(String regionCode) {
    if (_currentRegion != regionCode) {
      _currentRegion = regionCode.toUpperCase();
      _reevaluateTier();
    }
  }

  /// 依据综合规则重新计算并广播当前全局最高效的 AdTrafficTier
  void _reevaluateTier() {
    if (_isVipUser) {
      value = _currentPolicy.vipTier;
      return;
    }

    // 1. 优先尝试执行主 App 动态注入的自定义策略函数委托
    if (_customTierResolver != null) {
      final customTier = _customTierResolver!();
      if (customTier != null) {
        value = customTier;
        return;
      }
    }

    // 2. 检查是否有云端/地域覆盖策略
    final regionOverrideStr = _currentPolicy.regionTierOverrides[_currentRegion];
    if (regionOverrideStr != null) {
      final overrideTier = _parseTierStr(regionOverrideStr);
      if (overrideTier != null) {
        value = overrideTier;
        return;
      }
    }

    value = _currentPolicy.defaultTier;
  }

  /// 强制手动设定 AdTrafficTier (主要用于测试或调试)
  void setOverrideTier(AdTrafficTier tier) {
    value = tier;
    debugPrint('[AdPolicyManager] Manual override Tier set to: ${tier.name}');
  }

  /// 获取当前有效的广告驱动适配器 (向后兼容零缝衔接 AdsHub 降级仲裁)
  NetworkAdapter? getActiveAdapter() {
    return AdsHub.instance.arbitrator.resolveAvailableAdapter(value);
  }

  static AdTrafficTier? _parseTierStr(String value) {
    final str = value.toLowerCase();
    for (final tier in AdTrafficTier.values) {
      if (tier.name.toLowerCase() == str) {
        return tier;
      }
    }
    return null;
  }

  @override
  void dispose() {
    _remoteSubscription?.cancel();
    super.dispose();
  }
}
