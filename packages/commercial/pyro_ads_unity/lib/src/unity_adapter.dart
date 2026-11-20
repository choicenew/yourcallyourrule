import 'package:material_ui/material_ui.dart';
import 'package:unity_levelplay_mediation/unity_levelplay_mediation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 纯底层 Unity LevelPlay 驱动 Adapter (仅依赖 pyro_ads_protocol)
class UnityAdapter implements NetworkAdapter {
  LevelPlayInterstitialAd? _interstitialAd;
  LevelPlayRewardedAd? _rewardedAd;
  Function(MagmaRewardItem item)? _pendingRewardCallback;

  @override
  String get providerId => AdProviderToken.unity;

  @override
  String get providerName => 'Unity LevelPlay';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    final gameIdAndroid = config['unityGameIdAndroid']?.toString();
    final gameIdIos = config['unityGameIdIos']?.toString();
    final gameId = (gameIdAndroid != null && gameIdAndroid.isNotEmpty)
        ? gameIdAndroid
        : gameIdIos;

    if (gameId != null && gameId.isNotEmpty) {
      final req = LevelPlayInitRequest(appKey: gameId);
      await LevelPlay.init(initRequest: req, initListener: _InitListener());
    }
  }

  @override
  Widget buildBanner(String placementId) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestBannerId() ?? '');
    return _UnityBannerWidget(adUnitId: effectivePlacementId);
  }

  @override
  Widget buildNative(String placementId, NativeStyle style) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestNativeId() ?? '');
    return _UnityBannerWidget(adUnitId: effectivePlacementId);
  }

  @override
  Future<void> loadInterstitial(String placementId) async {
    final effectivePlacementId = placementId.isNotEmpty
        ? placementId
        : (getTestInterstitialId() ?? '');
    _interstitialAd = LevelPlayInterstitialAd(adUnitId: effectivePlacementId);
    _interstitialAd?.loadAd();
  }

  @override
  Future<void> showInterstitial() async {
    final isReady = await _interstitialAd?.isAdReady() ?? false;
    if (isReady) {
      await _interstitialAd?.showAd();
    }
  }

  @override
  Future<void> loadRewarded(String placementId) async {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestRewardedId() ?? '');
    _rewardedAd = LevelPlayRewardedAd(adUnitId: effectivePlacementId);

    _rewardedAd?.setListener(_UnityRewardedListener((reward) {
      _pendingRewardCallback?.call(reward);
      _pendingRewardCallback = null;
    }));

    _rewardedAd?.loadAd();
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    _pendingRewardCallback = onReward;
    final isReady = await _rewardedAd?.isAdReady() ?? false;
    if (isReady) {
      await _rewardedAd?.showAd();
    } else {
      _pendingRewardCallback = null;
    }
  }

  @override
  Future<void> loadAppOpen(String placementId) async {}

  @override
  Future<void> showAppOpen() async {}

  @override
  String? getTestBannerId() => 'test_unity_banner';

  @override
  String? getTestNativeId() => 'test_unity_native';

  @override
  String? getTestInterstitialId() => 'test_unity_interstitial';

  @override
  String? getTestRewardedId() => 'test_unity_rewarded';
}

class _InitListener implements LevelPlayInitListener {
  @override
  void onInitFailed(LevelPlayInitError error) {}

  @override
  void onInitSuccess(LevelPlayConfiguration configuration) {}
}

class _UnityRewardedListener implements LevelPlayRewardedAdListener {
  final void Function(MagmaRewardItem item) onReward;

  _UnityRewardedListener(this.onReward);

  @override
  void onAdRewarded(LevelPlayReward reward, LevelPlayAdInfo adInfo) {
    onReward(MagmaRewardItem(reward.amount, reward.name));
  }

  @override
  void onAdClicked(LevelPlayAdInfo adInfo) {}

  @override
  void onAdClosed(LevelPlayAdInfo adInfo) {}

  @override
  void onAdDisplayFailed(LevelPlayAdError error, LevelPlayAdInfo adInfo) {}

  @override
  void onAdDisplayed(LevelPlayAdInfo adInfo) {}

  @override
  void onAdInfoChanged(LevelPlayAdInfo adInfo) {}

  @override
  void onAdLoadFailed(LevelPlayAdError error) {}

  @override
  void onAdLoaded(LevelPlayAdInfo adInfo) {}
}

class _UnityBannerWidget extends StatefulWidget {
  final String adUnitId;
  const _UnityBannerWidget({required this.adUnitId});

  @override
  State<_UnityBannerWidget> createState() => _UnityBannerWidgetState();
}

class _UnityBannerWidgetState extends State<_UnityBannerWidget> implements LevelPlayBannerAdViewListener {
  final GlobalKey<LevelPlayBannerAdViewState> _bannerKey = GlobalKey<LevelPlayBannerAdViewState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: LevelPlayBannerAdView(
        key: _bannerKey,
        adUnitId: widget.adUnitId,
        adSize: LevelPlayAdSize.BANNER,
        listener: this,
        onPlatformViewCreated: () {
          _bannerKey.currentState?.loadAd();
        },
      ),
    );
  }

  @override
  void onAdLoaded(LevelPlayAdInfo adInfo) {}

  @override
  void onAdLoadFailed(LevelPlayAdError error) {}

  @override
  void onAdClicked(LevelPlayAdInfo adInfo) {}

  @override
  void onAdCollapsed(LevelPlayAdInfo adInfo) {}

  @override
  void onAdDisplayFailed(LevelPlayAdInfo adInfo, LevelPlayAdError error) {}

  @override
  void onAdDisplayed(LevelPlayAdInfo adInfo) {}

  @override
  void onAdExpanded(LevelPlayAdInfo adInfo) {}

  @override
  void onAdLeftApplication(LevelPlayAdInfo adInfo) {}
}
