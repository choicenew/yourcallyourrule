//独立的广告
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';

// 使用Riverpod的Consumer Widget
Widget nativeAdWidgetSmall({required double adWidth, required double adHeight}) {
  return Consumer(
    builder: (context, ref, child) {
      final adState = ref.watch(adStateProvider);
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: adState ? adWidth : 0,
          minHeight: adState ? adHeight : 0,
        ),
        child: adState
            ? GoogleAdWidget(
                adInfo: AdManager.nativeAdvancedAd,
                width: adWidth,
                height: adHeight,
                nativeAdConfig: const NativeAdConfig(
                  template: NativeAdTemplate.small,
                  // 其他配置...
                ),
              )
            : const SizedBox.shrink(),
      );
    },
  );
}

Widget nativeAdWidgetMedium({required double adWidth, required double adHeight}) {
  return Consumer(
    builder: (context, ref, child) {
      final adState = ref.watch(adStateProvider);
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: adState ? adWidth : 0,
          minHeight: adState ? adHeight : 0,
        ),
        child: adState
            ? GoogleAdWidget(
                adInfo: AdManager.nativeAdvancedAd,
                width: adWidth,
                height: adHeight,
                nativeAdConfig: const NativeAdConfig(
                  template: NativeAdTemplate.medium,
                  // 其他配置...
                ),
              )
            : const SizedBox.shrink(),
      );
    },
  );
}