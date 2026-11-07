import 'ad_enums.dart';

/// 广告渠道 Provider 标识 Token
class AdProviderToken {
  static const String admob = 'admob';
  static const String applovin = 'applovin';
  static const String unity = 'unity';
  static const String startio = 'startio';
  static const String liftoff = 'liftoff';
  static const String houseAds = 'house_ads';
}

/// 全平台生产/测试广告位 ID 集中配置契约基类 (AdsConfig Base)
class AdsConfig {
  // --- Initialization App Keys ---
  final String? admobAppId;
  final String? appLovinSdkKey;
  final String? unityGameIdAndroid;
  final String? unityGameIdIos;
  final String? startIoAppId;
  final String? liftoffAppId;

  // --- AdMob IDs ---
  final String? admobBannerId;
  final String? admobAdaptiveBannerId;
  final String? admobInterstitialId;
  final String? admobRewardedId;
  final String? admobRewardedInterstitialId;
  final String? admobNativeId;
  final String? admobAppOpenId;

  // --- AppLovin IDs ---
  final String? appLovinBannerId;
  final String? appLovinMrecId;
  final String? appLovinInterstitialId;
  final String? appLovinRewardedId;
  final String? appLovinNativeId;
  final String? appLovinAppOpenId;

  // --- Unity IDs ---
  final String? unityBannerId;
  final String? unityInterstitialId;
  final String? unityRewardedId;

  // --- Start.io Tags ---
  final String? startIoBannerTag;
  final String? startIoInterstitialTag;
  final String? startIoRewardedTag;
  final String? startIoNativeTag;

  // --- Liftoff Placement IDs ---
  final String? liftoffBannerId;
  final String? liftoffMrecId;
  final String? liftoffInterstitialId;
  final String? liftoffRewardedId;
  final String? liftoffNativeId;
  final String? liftoffAppOpenId;

  // --- Native Factory Options ---
  final String? nativeFactoryId;

  /// 全局测试模式开关
  final bool testMode;

  const AdsConfig({
    // Init Keys
    this.admobAppId,
    this.appLovinSdkKey,
    this.unityGameIdAndroid,
    this.unityGameIdIos,
    this.startIoAppId,
    this.liftoffAppId,

    // AdMob
    this.admobBannerId,
    this.admobAdaptiveBannerId,
    this.admobInterstitialId,
    this.admobRewardedId,
    this.admobRewardedInterstitialId,
    this.admobNativeId,
    this.admobAppOpenId,

    // AppLovin
    this.appLovinBannerId,
    this.appLovinMrecId,
    this.appLovinInterstitialId,
    this.appLovinRewardedId,
    this.appLovinNativeId,
    this.appLovinAppOpenId,

    // Unity
    this.unityBannerId,
    this.unityInterstitialId,
    this.unityRewardedId,

    // Start.io
    this.startIoBannerTag,
    this.startIoInterstitialTag,
    this.startIoRewardedTag,
    this.startIoNativeTag,

    // Liftoff
    this.liftoffBannerId,
    this.liftoffMrecId,
    this.liftoffInterstitialId,
    this.liftoffRewardedId,
    this.liftoffNativeId,
    this.liftoffAppOpenId,

    // Native Options
    this.nativeFactoryId,
    this.testMode = false,
  });

  /// 官方标准 Google & Liftoff 测试广告 ID 配置
  const AdsConfig.test()
      : admobAppId = 'ca-app-pub-3940256099942544~3347511713',
        appLovinSdkKey = null,
        unityGameIdAndroid = null,
        unityGameIdIos = null,
        startIoAppId = null,
        liftoffAppId = '6adcc13158e014823b7cea39',

        // AdMob Test AdUnit IDs
        admobBannerId = 'ca-app-pub-3940256099942544/6300978111',
        admobAdaptiveBannerId = 'ca-app-pub-3940256099942544/9214589741',
        admobInterstitialId = 'ca-app-pub-3940256099942544/1033173712',
        admobRewardedId = 'ca-app-pub-3940256099942544/5224354917',
        admobRewardedInterstitialId = 'ca-app-pub-3940256099942544/5354046379',
        admobNativeId = 'ca-app-pub-3940256099942544/2247696110',
        admobAppOpenId = 'ca-app-pub-3940256099942544/9257395921',

        // AppLovin Test Unit IDs
        appLovinBannerId = 'test_applovin_banner',
        appLovinMrecId = 'test_applovin_mrec',
        appLovinInterstitialId = 'test_applovin_interstitial',
        appLovinRewardedId = 'test_applovin_rewarded',
        appLovinNativeId = 'test_applovin_native',
        appLovinAppOpenId = 'test_applovin_app_open',

        // Unity Test Unit IDs
        unityBannerId = 'test_unity_banner',
        unityInterstitialId = 'test_unity_interstitial',
        unityRewardedId = 'test_unity_rewarded',

        // Start.io Test Tags
        startIoBannerTag = 'test_startio_banner',
        startIoInterstitialTag = 'test_startio_interstitial',
        startIoRewardedTag = 'test_startio_rewarded',
        startIoNativeTag = 'test_startio_native',

        // Liftoff Test Placement IDs
        liftoffBannerId = 'BANNER_ADS-DEFAULT',
        liftoffMrecId = 'MREC_ADS-DEFAULT',
        liftoffInterstitialId = 'INTERSTITIAL_ADS-DEFAULT',
        liftoffRewardedId = 'REWARDED_ADS-DEFAULT',
        liftoffNativeId = 'NATIVE_ADS-DEFAULT',
        liftoffAppOpenId = 'APP_OPEN_ADS-DEFAULT',

        nativeFactoryId = null,
        testMode = true;

  /// 多态通用查表提取方法：根据 Provider 标识 Token 与广告槽位类型获取具体的 Placement ID
  String? getPlacementId(String providerId, AdSlotType slotType) {
    final key = providerId.toLowerCase();

    switch (key) {
      case AdProviderToken.admob:
        switch (slotType) {
          case AdSlotType.anchoredBanner:
            return admobAdaptiveBannerId ?? admobBannerId;
          case AdSlotType.mrec:
            return admobBannerId;
          case AdSlotType.nativeSmall:
          case AdSlotType.nativeMedium:
          case AdSlotType.nativeLarge:
            return admobNativeId;
          case AdSlotType.interstitial:
            return admobInterstitialId;
          case AdSlotType.rewarded:
            return admobRewardedId;
          case AdSlotType.appOpen:
            return admobAppOpenId;
        }

      case AdProviderToken.applovin:
        switch (slotType) {
          case AdSlotType.anchoredBanner:
            return appLovinBannerId;
          case AdSlotType.mrec:
            return appLovinMrecId ?? appLovinBannerId;
          case AdSlotType.nativeSmall:
          case AdSlotType.nativeMedium:
          case AdSlotType.nativeLarge:
            return appLovinNativeId;
          case AdSlotType.interstitial:
            return appLovinInterstitialId;
          case AdSlotType.rewarded:
            return appLovinRewardedId;
          case AdSlotType.appOpen:
            return appLovinAppOpenId;
        }

      case AdProviderToken.unity:
        switch (slotType) {
          case AdSlotType.anchoredBanner:
          case AdSlotType.mrec:
            return unityBannerId;
          case AdSlotType.nativeSmall:
          case AdSlotType.nativeMedium:
          case AdSlotType.nativeLarge:
            return unityBannerId;
          case AdSlotType.interstitial:
            return unityInterstitialId;
          case AdSlotType.rewarded:
            return unityRewardedId;
          case AdSlotType.appOpen:
            return unityInterstitialId;
        }

      case AdProviderToken.startio:
        switch (slotType) {
          case AdSlotType.anchoredBanner:
          case AdSlotType.mrec:
            return startIoBannerTag;
          case AdSlotType.nativeSmall:
          case AdSlotType.nativeMedium:
          case AdSlotType.nativeLarge:
            return startIoNativeTag;
          case AdSlotType.interstitial:
            return startIoInterstitialTag;
          case AdSlotType.rewarded:
            return startIoRewardedTag;
          case AdSlotType.appOpen:
            return startIoInterstitialTag;
        }

      case AdProviderToken.liftoff:
        switch (slotType) {
          case AdSlotType.anchoredBanner:
            return liftoffBannerId;
          case AdSlotType.mrec:
            return liftoffMrecId ?? liftoffBannerId;
          case AdSlotType.nativeSmall:
          case AdSlotType.nativeMedium:
          case AdSlotType.nativeLarge:
            return liftoffNativeId;
          case AdSlotType.interstitial:
            return liftoffInterstitialId;
          case AdSlotType.rewarded:
            return liftoffRewardedId;
          case AdSlotType.appOpen:
            return liftoffAppOpenId;
        }

      default:
        return null;
    }
  }
}
