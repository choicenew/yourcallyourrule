import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AdType {
  banner,
  interstitial,
  rewardedInterstitial,
  rewarded,
  nativeAdvanced,
  appOpen,
}

class AdInfo {
  final String adUnitId;
  final AdType type;
  final AdSize? size;

  const AdInfo({required this.adUnitId, required this.type, this.size});
}

enum NativeAdTemplate {
  small,
  medium,
}

class NativeAdConfig {
  final NativeAdTemplate template;
  final Color? mainBackgroundColor;
  final double? cornerRadius;
  final NativeTemplateTextStyle? callToActionTextStyle;
  final NativeTemplateTextStyle? primaryTextStyle;
  final NativeTemplateTextStyle? secondaryTextStyle;
  final NativeTemplateTextStyle? tertiaryTextStyle;

  const NativeAdConfig({
    required this.template,
    this.mainBackgroundColor,
    this.cornerRadius,
    this.callToActionTextStyle,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.tertiaryTextStyle,
  });

  NativeTemplateStyle get style => NativeTemplateStyle(
        templateType: template == NativeAdTemplate.small
            ? TemplateType.small
            : TemplateType.medium,
        mainBackgroundColor: mainBackgroundColor,
        cornerRadius: cornerRadius,
        callToActionTextStyle: callToActionTextStyle,
        primaryTextStyle: primaryTextStyle,
        secondaryTextStyle: secondaryTextStyle,
        tertiaryTextStyle: tertiaryTextStyle,
      );
}

class AdManager {
  // ===========================================================================
  // 正式环境广告 ID (Formal Production Ad Unit IDs)
  // ===========================================================================
  static const AdInfo bannerAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/7861430370', // formal
    type: AdType.banner,
    size: AdSize.banner,
  );

  static const AdInfo adaptiveBannerAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/2198040152',
    type: AdType.banner,
  );

  static const AdInfo interstitialAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/1982417737',
    type: AdType.interstitial,
  );

  static const AdInfo rewardedInterstitialAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/1982417737',
    type: AdType.rewardedInterstitial,
  );

  static const AdInfo rewardedAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/1982417737',
    type: AdType.rewarded,
  );

  static const AdInfo nativeAdvancedAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/2757981774',
    type: AdType.nativeAdvanced,
  );

  static const AdInfo appOpenAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/3319550135',
    type: AdType.appOpen,
  );

  // ===========================================================================
  // 谷歌官方公开通用测试 ID (Google Official Sample Ad Unit IDs)
  // 用于单元测试与开发调试，保证 100% 官方匹配与测试数据充填
  // ===========================================================================
  static const AdInfo testBannerAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    type: AdType.banner,
    size: AdSize.banner,
  );

  static const AdInfo testAdaptiveBannerAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/9214589741',
    type: AdType.banner,
  );

  static const AdInfo testNativeAdvancedAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110',
    type: AdType.nativeAdvanced,
  );

  static const AdInfo testInterstitialAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712',
    type: AdType.interstitial,
  );

  static const AdInfo testRewardedAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/5224354917',
    type: AdType.rewarded,
  );

  static const AdInfo testAppOpenAd = AdInfo(
    adUnitId: 'ca-app-pub-3940256099942544/9257395921',
    type: AdType.appOpen,
  );
}
