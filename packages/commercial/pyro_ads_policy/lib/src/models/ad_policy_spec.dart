import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 本地与动态遥测广告策略规范模型 (Ad Policy Spec)
class AdPolicySpec {
  /// 默认策略基准流量梯队
  final AdTrafficTier defaultTier;

  /// 新用户 (New User) 策略流量梯队
  final AdTrafficTier newUserTier;

  /// 活跃用户 (Active User) 策略流量梯队
  final AdTrafficTier activeUserTier;

  /// 流失风险用户 (Churn Risk User) 策略流量梯队
  final AdTrafficTier churnRiskUserTier;

  /// VIP 特权用户策略流量梯队 (默认 none 完全禁用广告)
  final AdTrafficTier vipTier;

  /// 全局插屏/全屏广告最小冷却时间 (秒)
  final int interstitialMinIntervalSeconds;

  /// 全局每日可看激励视频上限次数
  final int maxRewardedPerDay;

  /// 云端/地域重定向映射表 (例如: {'JP': 'tier2', 'US': 'tier1'})
  final Map<String, String> regionTierOverrides;

  const AdPolicySpec({
    this.defaultTier = AdTrafficTier.tier1,
    this.newUserTier = AdTrafficTier.tier1,
    this.activeUserTier = AdTrafficTier.tier2,
    this.churnRiskUserTier = AdTrafficTier.tier4,
    this.vipTier = AdTrafficTier.none,
    this.interstitialMinIntervalSeconds = 180,
    this.maxRewardedPerDay = 5,
    this.regionTierOverrides = const {},
  });

  /// 从 AuraRemoteConfig 传入的 JSON 转换重建
  factory AdPolicySpec.fromJson(Map<String, dynamic> json) {
    return AdPolicySpec(
      defaultTier: _parseTier(json['default_tier']) ?? AdTrafficTier.tier1,
      newUserTier: _parseTier(json['new_user_tier']) ?? AdTrafficTier.tier1,
      activeUserTier: _parseTier(json['active_user_tier']) ?? AdTrafficTier.tier2,
      churnRiskUserTier: _parseTier(json['churn_risk_tier']) ?? AdTrafficTier.tier4,
      vipTier: _parseTier(json['vip_tier']) ?? AdTrafficTier.none,
      interstitialMinIntervalSeconds:
          (json['interstitial_min_interval_seconds'] as num?)?.toInt() ?? 180,
      maxRewardedPerDay: (json['max_rewarded_per_day'] as num?)?.toInt() ?? 5,
      regionTierOverrides:
          (json['region_tier_overrides'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())) ??
              const {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default_tier': defaultTier.name,
      'new_user_tier': newUserTier.name,
      'active_user_tier': activeUserTier.name,
      'churn_risk_tier': churnRiskUserTier.name,
      'vip_tier': vipTier.name,
      'interstitial_min_interval_seconds': interstitialMinIntervalSeconds,
      'max_rewarded_per_day': maxRewardedPerDay,
      'region_tier_overrides': regionTierOverrides,
    };
  }

  static AdTrafficTier? _parseTier(dynamic value) {
    if (value == null) return null;
    final str = value.toString().toLowerCase();
    for (final tier in AdTrafficTier.values) {
      if (tier.name.toLowerCase() == str) {
        return tier;
      }
    }
    return null;
  }
}
