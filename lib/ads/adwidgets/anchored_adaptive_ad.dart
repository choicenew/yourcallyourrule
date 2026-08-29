import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
// 导入我们修正后的缓存 Provider
import 'package:yourcallyourrule/ads/ad_cache_provider.dart';

class AnchoredAdaptiveBannerAdWidget extends ConsumerStatefulWidget {
  final AdInfo adInfo;

  const AnchoredAdaptiveBannerAdWidget({super.key, required this.adInfo});

  @override
  ConsumerState<AnchoredAdaptiveBannerAdWidget> createState() =>
      _AnchoredAdaptiveBannerAdWidgetState();
}

class _AnchoredAdaptiveBannerAdWidgetState
    extends ConsumerState<AnchoredAdaptiveBannerAdWidget> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // 【核心修正】: 调用 loadAd 时，传递正确的、无冲突的 AdaptiveBannerType.anchored
        ref.read(adCacheProvider(widget.adInfo).notifier)
           .loadAd(context, AdaptiveBannerType.anchored);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ... build 方法的其余部分完全不变 ...
    final adEnabled = ref.watch(adStateProvider);
    if (!adEnabled) {
      return const SizedBox.shrink();
    }

    final adState = ref.watch(adCacheProvider(widget.adInfo));

    if (adState.isLoaded && adState.bannerAd != null && adState.adSize != null) {
      return Container(
        color: Colors.transparent, 
        width: adState.adSize!.width.toDouble(),
        height: adState.adSize!.height.toDouble(),
        child: AdWidget(ad: adState.bannerAd!),
      );
    }

    return const SizedBox.shrink();
  }
}