import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 主 App 生产与测试环境 AdMob 集中广告配置
class AppAdsConfig extends AdsConfig {
  const AppAdsConfig({
    super.admobAppId,
    super.admobBannerId,
    super.admobAdaptiveBannerId,
    super.admobInterstitialId,
    super.admobRewardedId,
    super.admobRewardedInterstitialId,
    super.admobNativeId,
    super.admobAppOpenId,
  });

  /// 正式上线/生产环境 AdMob 广告位配置
  static const AppAdsConfig production = AppAdsConfig(
    admobAppId: 'ca-app-pub-7500321599129263~3347511713',
    admobBannerId: 'ca-app-pub-7500321599129263/7861430370',
    admobAdaptiveBannerId: 'ca-app-pub-7500321599129263/2198040152',
    admobInterstitialId: 'ca-app-pub-7500321599129263/1982417737',
    admobRewardedInterstitialId: 'ca-app-pub-7500321599129263/1982417737',
    admobRewardedId: 'ca-app-pub-7500321599129263/1982417737',
    admobNativeId: 'ca-app-pub-7500321599129263/2757981774',
    admobAppOpenId: 'ca-app-pub-7500321599129263/3319550135',
  );
}
