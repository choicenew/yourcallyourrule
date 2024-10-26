//独立的广告
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../google_ad.dart';





// Modified widgets using Provider
Widget nativeAdWidgetSmall({required double adWidth, required double adHeight}) {
  return Consumer<AdState>(
    builder: (context, adState, child) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: adState.isAdEnabled ? adWidth : 0,
          minHeight: adState.isAdEnabled ? adHeight : 0,
        ),
        child: adState.isAdEnabled
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
  return Consumer<AdState>(
    builder: (context, adState, child) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: adState.isAdEnabled ? adWidth : 0,
          minHeight: adState.isAdEnabled ? adHeight : 0,
        ),
        child: adState.isAdEnabled
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