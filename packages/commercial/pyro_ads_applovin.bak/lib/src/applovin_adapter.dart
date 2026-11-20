import 'package:material_ui/material_ui.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 纯底层 AppLovin MAX 驱动 Adapter (仅依赖 pyro_ads_protocol)
class AppLovinAdapter implements NetworkAdapter {
  String? _lastLoadedInterstitialId;
  String? _lastLoadedRewardedId;
  String? _lastLoadedAppOpenId;

  @override
  String get providerId => AdProviderToken.applovin;

  @override
  String get providerName => 'AppLovin MAX';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    final sdkKey = config['appLovinSdkKey']?.toString();
    if (sdkKey != null && sdkKey.isNotEmpty) {
      await AppLovinMAX.initialize(sdkKey);
    }
  }

  @override
  Widget buildBanner(String placementId) {
    return MaxAdView(
      adUnitId: placementId,
      adFormat: AdFormat.banner,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdClickedCallback: (ad) {},
        onAdExpandedCallback: (ad) {},
        onAdCollapsedCallback: (ad) {},
      ),
    );
  }

  @override
  Widget buildNative(String placementId, NativeStyle style) {
    return MaxNativeAdView(
      adUnitId: placementId,
      width: double.infinity,
      height: style == NativeStyle.small ? 120 : 250,
      listener: NativeAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdClickedCallback: (ad) {},
      ),
      child: Container(
        color: Colors.grey.shade900,
        child: const Center(
          child: Text('AppLovin Native Ad', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Future<void> loadInterstitial(String placementId) async {
    _lastLoadedInterstitialId = placementId;
    AppLovinMAX.loadInterstitial(placementId);
  }

  @override
  Future<void> showInterstitial() async {
    final id = _lastLoadedInterstitialId ?? getTestInterstitialId();
    if (id != null) {
      final isReady = await AppLovinMAX.isInterstitialReady(id) ?? false;
      if (isReady) {
        AppLovinMAX.showInterstitial(id);
      }
    }
  }

  @override
  Future<void> loadRewarded(String placementId) async {
    _lastLoadedRewardedId = placementId;
    AppLovinMAX.loadRewardedAd(placementId);
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    final id = _lastLoadedRewardedId ?? getTestRewardedId();
    if (id != null) {
      AppLovinMAX.setRewardedAdListener(RewardedAdListener(
        onAdReceivedRewardCallback: (ad, reward) {
          onReward(MagmaRewardItem(reward.amount, reward.label));
        },
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdDisplayedCallback: (ad) {},
        onAdDisplayFailedCallback: (ad, error) {},
        onAdClickedCallback: (ad) {},
        onAdHiddenCallback: (ad) {},
      ));

      final isReady = await AppLovinMAX.isRewardedAdReady(id) ?? false;
      if (isReady) {
        AppLovinMAX.showRewardedAd(id);
      }
    }
  }

  @override
  Future<void> loadAppOpen(String placementId) async {
    _lastLoadedAppOpenId = placementId;
    AppLovinMAX.loadAppOpenAd(placementId);
  }

  @override
  Future<void> showAppOpen() async {
    final id = _lastLoadedAppOpenId ?? getTestAppOpenId();
    if (id != null) {
      final isReady = await AppLovinMAX.isAppOpenAdReady(id) ?? false;
      if (isReady) {
        AppLovinMAX.showAppOpenAd(id);
      }
    }
  }

  @override
  String? getTestBannerId() => 'test_applovin_banner';

  @override
  String? getTestNativeId() => 'test_applovin_native';

  @override
  String? getTestInterstitialId() => 'test_applovin_interstitial';

  @override
  String? getTestRewardedId() => 'test_applovin_rewarded';

  String? getTestAppOpenId() => 'test_applovin_app_open';
}
