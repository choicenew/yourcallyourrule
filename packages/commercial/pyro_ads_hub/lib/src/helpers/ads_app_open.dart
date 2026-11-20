import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层开屏/应用打开广告静态 Helper (Ads App Open)
class AdsAppOpen {
  /// 预加载开屏广告
  static Future<void> load(
    AdTrafficTier tier, {
    String? placementId,
  }) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      final id = placementId ??
          AdsHub.instance.getPlacementId(adapter.providerId, AdSlotType.appOpen) ??
          'default_app_open_placement';
      await adapter.loadAppOpen(id);
    }
  }

  /// 展示开屏广告
  static Future<void> show(AdTrafficTier tier) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      await adapter.showAppOpen();
    }
  }
}
