import 'package:material_ui/material_ui.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层 Native 原生广告卡片组件 (Ads Native)
class AdsNative extends StatelessWidget {
  final AdTrafficTier tier;
  final NativeStyle style;
  final String? placementId;

  const AdsNative({
    super.key,
    this.tier = AdTrafficTier.tier1,
    this.style = NativeStyle.medium,
    this.placementId,
  });

  @override
  Widget build(BuildContext context) {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter == null) {
      return const SizedBox.shrink();
    }

    final slotType = style == NativeStyle.small
        ? AdSlotType.nativeSmall
        : style == NativeStyle.large
            ? AdSlotType.nativeLarge
            : AdSlotType.nativeMedium;

    final id = placementId ??
        AdsHub.instance.getPlacementId(adapter.providerId, slotType) ??
        adapter.getTestNativeId() ??
        'default_native_placement';

    return adapter.buildNative(id, style);
  }
}
