import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层插屏广告静态 Helper (Ads Interstitial)
class AdsInterstitial {
  /// 预加载插屏广告
  static Future<void> load(
    AdTrafficTier tier, {
    String? placementId,
  }) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      final id = placementId ??
          AdsHub.instance.getPlacementId(adapter.providerId, AdSlotType.interstitial) ??
          adapter.getTestInterstitialId() ??
          'default_interstitial_placement';
      await adapter.loadInterstitial(id);
    }
  }

  /// 展示插屏广告
  static Future<void> show(AdTrafficTier tier) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      await adapter.showInterstitial();
    }
  }
}
