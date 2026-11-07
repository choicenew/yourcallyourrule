import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 高层激励视频广告静态 Helper (Ads Rewarded)
class AdsRewarded {
  /// 预加载激励视频广告
  static Future<void> load(
    AdTrafficTier tier, {
    String? placementId,
  }) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      final id = placementId ??
          AdsHub.instance.getPlacementId(adapter.providerId, AdSlotType.rewarded) ??
          adapter.getTestRewardedId() ??
          'default_rewarded_placement';
      await adapter.loadRewarded(id);
    }
  }

  /// 展示激励视频广告并触发奖励回调
  static Future<void> show(
    AdTrafficTier tier, {
    required void Function(MagmaRewardItem reward) onUserEarnedReward,
  }) async {
    final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tier);
    if (adapter != null) {
      await adapter.showRewarded(onUserEarnedReward);
    }
  }
}
