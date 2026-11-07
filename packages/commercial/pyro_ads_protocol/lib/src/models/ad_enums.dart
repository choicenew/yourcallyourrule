/// 流量/广告位梯队分级枚举 (Ad Traffic Tier)
enum AdTrafficTier {
  /// Tier 1: 顶级 eCPM 渠道 (如 AdMob)
  tier1,

  /// Tier 2: 次级高填充渠道 (如 AppLovin)
  tier2,

  /// Tier 3: 游戏/视频专注渠道 (如 Unity LevelPlay)
  tier3,

  /// Tier 4: 流量补充渠道 (如 Start.io)
  tier4,

  /// Tier 5: 自家矩阵与 VIP 促销 (House Ads)
  tier5,

  /// 无分级 / 未配置
  none;

  /// 根据算法传出的数字标量 1, 2, 5 转换 (0 字符串匹配)
  factory AdTrafficTier.fromLevel(int level) {
    switch (level) {
      case 1:
        return AdTrafficTier.tier1;
      case 2:
        return AdTrafficTier.tier2;
      case 3:
        return AdTrafficTier.tier3;
      case 4:
        return AdTrafficTier.tier4;
      case 5:
        return AdTrafficTier.tier5;
      default:
        return AdTrafficTier.tier1;
    }
  }
}

/// 广告插槽形态枚举
enum AdSlotType {
  anchoredBanner,
  mrec,
  nativeSmall,
  nativeMedium,
  nativeLarge,
  interstitial,
  rewarded,
  appOpen,
}

/// 原生广告样式形态
enum NativeStyle {
  small,
  medium,
  large,
}
