// -----------------------------------------------------------------------------
// 文件: inline_adaptive_ad.dart
// 描述: 独立的、可复用的、由缓存驱动的行内自适应广告组件。
//
// 【核心修正】
// 1.  恢复了 `final double? width;` 属性及其构造函数参数。
// 2.  在 `initState` 中调用 `loadAd` 时，将 `widget.width` 传递给缓存中心。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_cache_provider.dart';

class InlineAdaptiveBannerAdWidget extends ConsumerStatefulWidget {
  final AdInfo adInfo;
  // 【恢复】: 允许外部传入一个可选的自定义宽度。
  final double? width;

  const InlineAdaptiveBannerAdWidget({
    super.key,
    required this.adInfo,
    this.width,
  });

  @override
  ConsumerState<InlineAdaptiveBannerAdWidget> createState() =>
      _InlineAdaptiveBannerAdWidgetState();
}

class _InlineAdaptiveBannerAdWidgetState
    extends ConsumerState<InlineAdaptiveBannerAdWidget> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // 【核心修正】: 调用 loadAd 时，将 widget.width 传递过去。
        ref.read(adCacheProvider(widget.adInfo).notifier)
           .loadAd(context, AdaptiveBannerType.inline, explicitWidth: widget.width);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final adEnabled = ref.watch(adStateProvider);
    if (!adEnabled) {
      return const SizedBox.shrink();
    }

    final adState = ref.watch(adCacheProvider(widget.adInfo));

    if (adState.isLoaded && adState.bannerAd != null && adState.adSize != null) {
      return Container(
        // 最终的容器尺寸由广告平台返回的真实尺寸决定，这是正确的做法。
        width: adState.adSize!.width.toDouble(),
        height: adState.adSize!.height.toDouble(),
        child: AdWidget(ad: adState.bannerAd!),
      );
    } else {
      // 显示加载占位符
      return Container(
        height: 60,
        // 占位符的宽度可以响应外部传入的 width，也可以是全宽。
        width: widget.width ?? MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
        ),
      );
    }
  }
}