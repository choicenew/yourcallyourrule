import 'package:material_ui/material_ui.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层自适应内嵌响应式 Banner 广告组件 (Ads Inline Banner)
class AdsInlineBanner extends StatelessWidget {
  final AdTrafficTier tier;
  final String? placementId;
  final double height;

  const AdsInlineBanner({
    super.key,
    this.tier = AdTrafficTier.tier1,
    this.placementId,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter == null) {
      return const SizedBox.shrink();
    }

    final id = placementId ??
        AdsHub.instance.getPlacementId(adapter.providerId, AdSlotType.anchoredBanner) ??
        adapter.getTestBannerId() ??
        'default_inline_banner_placement';

    return SizedBox(
      height: height,
      width: double.infinity,
      child: adapter.buildBanner(id),
    );
  }
}
