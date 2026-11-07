import 'package:flutter/widgets.dart';
import 'render_ad_interface.dart';
import 'render_ad_placement.dart';
import 'render_ad_style.dart';

/// 极简短巧的抽象 Widget 入口 (用于在 Render 页面与 Feed 容器中清爽调用)
class RenderAdSlot extends StatelessWidget {
  final RenderAdPlacement placement;
  final RenderAdStyleSpec spec;

  const RenderAdSlot({
    super.key,
    required this.placement,
    required this.spec,
  });

  /// 1. 最常用的底部 Banner (极简一行，清爽赏心悦目!)
  const RenderAdSlot.bottomBanner({super.key})
      : placement = RenderAdPlacement.bottomAnchor,
        spec = RenderAdStyleSpec.bannerStandard;

  /// 2. 页面顶部吸顶 Banner (如 Portal 页头)
  const RenderAdSlot.topBanner({super.key})
      : placement = RenderAdPlacement.topAnchor,
        spec = RenderAdStyleSpec.bannerStandard;

  /// 3. 列表中间中等自适应卡片 (如 Webtoon 瀑布流、Google News 列表项)
  const RenderAdSlot.inlineMedium({super.key})
      : placement = RenderAdPlacement.contentInline,
        spec = RenderAdStyleSpec.mediumCard;

  /// 4. 列表中间大号矩形卡片 (如 300x250 / YouTube 播放器下方大卡)
  const RenderAdSlot.inlineLarge({super.key})
      : placement = RenderAdPlacement.contentInline,
        spec = RenderAdStyleSpec.largeCard;

  /// 5. 列表中间迷你 Chip 小标签 (如 Spotify 横向歌单小圆圈)
  const RenderAdSlot.inlineChip({super.key})
      : placement = RenderAdPlacement.contentInline,
        spec = RenderAdStyleSpec.smallChip;

  /// 6. 全屏沉浸翻页卡片 (如 TikTok 翻页流)
  const RenderAdSlot.fullScreen({super.key})
      : placement = RenderAdPlacement.fullScreenModal,
        spec = RenderAdStyleSpec.fullScreen;

  @override
  Widget build(BuildContext context) {
    return RenderAdInterface.buildAd(
      context,
      placement: placement,
      styleSpec: spec,
    );
  }
}
