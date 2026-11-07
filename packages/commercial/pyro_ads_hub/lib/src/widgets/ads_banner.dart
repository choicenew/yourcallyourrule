import 'package:material_ui/material_ui.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层自适应 Banner 横幅广告组件 (Ads Banner)
class AdsBanner extends StatelessWidget {
  final AdTrafficTier tier;
  final String? placementId;

  const AdsBanner({
    super.key,
    this.tier = AdTrafficTier.tier1,
    this.placementId,
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
        'default_banner_placement';

    return adapter.buildBanner(id);
  }
}
