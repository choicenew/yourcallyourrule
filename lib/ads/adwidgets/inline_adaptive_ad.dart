// -----------------------------------------------------------------------------
// 文件: inline_adaptive_ad.dart
// 描述: 高性能、100%系统主题适配、精美多巴胺卡片包覆的自适应广告组件。
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
  /// 实例级的 AdInfo 副本，保证在列表中各个位置生成独立的 Provider 实例
  late final AdInfo _scopedAdInfo;

  @override
  bool get wantKeepAlive => true; // 保活：滑出屏幕时不销毁广告，滑回来立即呈现

  @override
  void initState() {
    super.initState();

    _scopedAdInfo = AdInfo(
      adUnitId: widget.adInfo.adUnitId,
      type: widget.adInfo.type,
      size: widget.adInfo.size,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
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

  /// 构建统一精美赞助卡片包覆外框
  Widget _buildSponsoredCard(BuildContext context, Widget child, {double? width}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = theme.colorScheme.surfaceContainerHighest.withOpacity(isDark ? 0.45 : 0.65);
    final borderColor = theme.colorScheme.outlineVariant.withOpacity(0.35);

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部精美“广告”标识徽章
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, left: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "广告",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final adEnabled = ref.watch(adStateProvider);
    if (!adEnabled) {
      return const SizedBox.shrink();
    }

    final adState = ref.watch(adCacheProvider(_scopedAdInfo));

    // A. 广告加载成功：放置在精美赞助卡片容器中呈现
    if (adState.isLoaded &&
        adState.bannerAd != null &&
        adState.adSize != null) {
      final adWidget = Container(
        width: adState.adSize!.width.toDouble(),
        height: adState.adSize!.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: adState.bannerAd!),
      );
      return _buildSponsoredCard(context, adWidget, width: widget.width);
    }

    // B. 广告彻底加载失败：静默折叠高度
    if (adState.isFailed) {
      return const SizedBox.shrink();
    }

    // C. 正在加载中：优雅骨架卡片屏，保持与正式广告相同的卡片外廓，防止高度塌陷
    final targetHeight = widget.height ?? 50.0;
    return _buildSponsoredCard(
      context,
      SizedBox(
        height: targetHeight,
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
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "AD",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
      width: widget.width,
    );
  }
}
