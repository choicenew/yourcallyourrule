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
  static const AdInfo bannerAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/7861430370',// formal
    //adUnitId: 'ca-app-pub-3940256099942544/9214589741', //demo
    type: AdType.banner,
    size: AdSize.banner,
  );

  static const AdInfo adaptiveBannerAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/2198040152',
    //adUnitId: 'ca-app-pub-3940256099942544/9214589741', //demo
    type: AdType.banner,
    //size: AdSize.banner,
  );

  static const AdInfo interstitialAd = AdInfo(
    adUnitId: '<YOUR_INTERSTITIAL_AD_UNIT_ID>',
    type: AdType.interstitial,
  );

  static const AdInfo rewardedInterstitialAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/1982417737',
    //adUnitId: 'ca-app-pub-3940256099942544/5354046379', //demo
    type: AdType.rewardedInterstitial,
  );

  static const AdInfo rewardedAd = AdInfo(
    adUnitId: '<YOUR_REWARDED_AD_UNIT_ID>',
    type: AdType.rewarded,
  );

  static const AdInfo nativeAdvancedAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/2757981774',
    //adUnitId: 'ca-app-pub-3940256099942544/2247696110', //demo
    type: AdType.nativeAdvanced,
  );

  static const AdInfo appOpenAd = AdInfo(
    adUnitId: 'ca-app-pub-7500321599129263/3319550135',
    //adUnitId: 'ca-app-pub-3940256099942544/9257395921', //demo
    type: AdType.appOpen,
  );
}
