//独立的广告
import 'package:flutter/material.dart';

import '../../utils/ad_manager.dart';
import '../google_ad.dart';

Widget nativeAdWidgetSmall({required double adWidth, required double adHeight}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: adWidth,
      minHeight: adHeight, // Use adHeight here
    ),
    child: GoogleAdWidget(
      adInfo: AdManager.nativeAdvancedAd,
      width: adWidth,
      height: adHeight, // Use adHeight here
      nativeAdConfig: const NativeAdConfig(
        template: NativeAdTemplate.small,
        // 其他配置...
      ),
    ),
  );
}

Widget nativeAdWidgetMedium({required double adWidth, required double adHeight}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: adWidth,
      minHeight: adHeight, // Use adHeight here
    ),
    child: GoogleAdWidget(
      adInfo: AdManager.nativeAdvancedAd,
      width: adWidth,
      height: adHeight, // Use adHeight here
      nativeAdConfig: const NativeAdConfig(
        template: NativeAdTemplate.medium,
        // 其他配置...
      ),
    ),
  );
}