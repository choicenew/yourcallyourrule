// -----------------------------------------------------------------------------
// 文件: inline_adaptive_ad.dart
// 描述: 高性能、可复用、防塌陷、自带 KeepAlive 缓存的行内自适应广告组件。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_cache_provider.dart';

class InlineAdaptiveBannerAdWidget extends ConsumerStatefulWidget {
  final AdInfo adInfo;
  final double? width;
  final double? height;

  const InlineAdaptiveBannerAdWidget({
    super.key,
    required this.adInfo,
    this.width,
    this.height,
  });

  @override
  ConsumerState<InlineAdaptiveBannerAdWidget> createState() =>
      _InlineAdaptiveBannerAdWidgetState();
}

class _InlineAdaptiveBannerAdWidgetState
    extends ConsumerState<InlineAdaptiveBannerAdWidget>
    with AutomaticKeepAliveClientMixin {
  /// 实例级的 AdInfo 副本，保证在列表中各个位置生成独立的 Provider 实例，避免 AdMob 挂载冲突
  late final AdInfo _scopedAdInfo;

  @override
  bool get wantKeepAlive => true; // 保活：滑出屏幕时不销毁广告，滑回来立即呈现

  @override
  void initState() {
    super.initState();

    // 1. 克隆配置，生成唯一 Key
    _scopedAdInfo = AdInfo(
      adUnitId: widget.adInfo.adUnitId,
      type: widget.adInfo.type,
      size: widget.adInfo.size,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // 2. 立即启动加载
        ref
            .read(adCacheProvider(_scopedAdInfo).notifier)
            .loadAd(
              context,
              AdaptiveBannerType.inline,
              explicitWidth: widget.width,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final adEnabled = ref.watch(adStateProvider);
    if (!adEnabled) {
      return const SizedBox.shrink();
    }

    // 3. 监听当前独立 Key 的广告状态
    final adState = ref.watch(adCacheProvider(_scopedAdInfo));

    // A. 广告加载成功：直接呈现 AdWidget
    if (adState.isLoaded &&
        adState.bannerAd != null &&
        adState.adSize != null) {
      return Container(
        width: adState.adSize!.width.toDouble(),
        height: adState.adSize!.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: adState.bannerAd!),
      );
    }

    // B. 广告彻底加载失败：静默折叠高度，避免占用空白区域
    if (adState.isFailed) {
      return const SizedBox.shrink();
    }

    // C. 正在加载中：提供固定高度骨架/占位屏，消除 0 高度塌陷与剧烈弹跳
    final targetHeight = widget.height ?? 60.0;
    return Container(
      width: widget.width ?? double.infinity,
      height: targetHeight,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.grey.withAlpha(120),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "AD",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withAlpha(120),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
