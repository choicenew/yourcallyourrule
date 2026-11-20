import 'package:material_ui/material_ui.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

import 'manager/house_ads_manager.dart';
import 'models/house_ad_slot.dart';
import 'widgets/house_ad_widget.dart';

/// 完整实现 [NetworkAdapter] 的自家广告与交叉推广纯底层驱动 (House Ads Driver)
class PyroHouseAdsAdapter implements NetworkAdapter {
  final HouseAdsManager manager;

  PyroHouseAdsAdapter([HouseAdsManager? manager])
      : manager = manager ?? HouseAdsManager.instance;

  @override
  String get providerId => AdProviderToken.houseAds;

  @override
  String get providerName => 'Pyro House Ads';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {}

  @override
  Widget buildBanner(String placementId) {
    return const HouseAdWidget(slot: HouseAdSlotType.anchoredBanner);
  }

  @override
  Widget buildNative(String placementId, NativeStyle style) {
    final slot = style == NativeStyle.small
        ? HouseAdSlotType.nativeSmall
        : HouseAdSlotType.nativeMedium;
    return HouseAdWidget(slot: slot);
  }

  @override
  Future<void> loadInterstitial(String placementId) async {}

  @override
  Future<void> showInterstitial() async {
    manager.showInterstitialModal();
  }

  @override
  Future<void> loadRewarded(String placementId) async {}

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    onReward(const MagmaRewardItem(1, 'vip_trial_hours'));
  }

  @override
  Future<void> loadAppOpen(String placementId) async {}

  @override
  Future<void> showAppOpen() async {}

  @override
  String? getTestBannerId() => 'test_house_banner';

  @override
  String? getTestNativeId() => 'test_house_native';

  @override
  String? getTestInterstitialId() => 'test_house_interstitial';

  @override
  String? getTestRewardedId() => 'test_house_rewarded';
}
