import 'package:material_ui/material_ui.dart';
import 'package:hx_liftoff_ads/hx_liftoff_ads.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 纯底层 Liftoff (hx_liftoff_ads) 广告驱动 Adapter (仅依赖 pyro_ads_protocol)
class LiftoffAdapter implements NetworkAdapter {
  static const String defaultAppId = '6adcc13158e014823b7cea39';

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  Function(MagmaRewardItem item)? _pendingRewardCallback;
  bool _isInitialized = false;

  @override
  String get providerId => 'liftoff';

  @override
  String get providerName => 'Liftoff (Vungle)';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    if (_isInitialized) return;

    final appId = config['appId']?.toString() ??
        config['liftoffAppId']?.toString() ??
        defaultAppId;

    try {
      await LiftoffAds.instance.initialize(
        appId: appId,
      );
      _isInitialized = true;
      debugPrint('[LiftoffAdapter] Initialized with App ID: $appId');
    } catch (e) {
      debugPrint('[LiftoffAdapter] Failed to initialize: $e');
    }
  }

  @override
  Widget buildBanner(String placementId) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestBannerId() ?? '');
    return LiftoffBannerAd(
      size: BannerSize.banner,
      placementId: effectivePlacementId,
      onLoaded: () {
        debugPrint('[LiftoffAdapter] Banner loaded: $effectivePlacementId');
      },
      onFailedToLoad: (error) {
        debugPrint('[LiftoffAdapter] Banner failed to load: $error');
      },
    );
  }

  @override
  Widget buildNative(String placementId, NativeStyle style) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestNativeId() ?? '');
    final height = style == NativeStyle.small ? 120.0 : 320.0;

    return LiftoffNativeAd(
      height: height,
      placementId: effectivePlacementId,
      onFailedToLoad: (error) {
        debugPrint('[LiftoffAdapter] Native ad failed to load: $error');
      },
    );
  }

  @override
  Future<void> loadInterstitial(String placementId) async {
    final effectivePlacementId = placementId.isNotEmpty
        ? placementId
        : (getTestInterstitialId() ?? '');
    try {
      _interstitialAd = await InterstitialAd.load(
        placementId: effectivePlacementId,
        listener: FullscreenAdListener(
          onShown: () => debugPrint('[LiftoffAdapter] Interstitial shown'),
          onClicked: () => debugPrint('[LiftoffAdapter] Interstitial clicked'),
          onClosed: () {
            debugPrint('[LiftoffAdapter] Interstitial closed');
            _interstitialAd = null;
          },
          onFailedToShow: (error) {
            debugPrint('[LiftoffAdapter] Interstitial show failed: $error');
            _interstitialAd = null;
          },
        ),
      );
      debugPrint('[LiftoffAdapter] Interstitial loaded successfully.');
    } catch (e) {
      _interstitialAd = null;
      debugPrint('[LiftoffAdapter] Interstitial load error: $e');
    }
  }

  @override
  Future<void> showInterstitial() async {
    if (_interstitialAd == null) {
      debugPrint('[LiftoffAdapter] Interstitial is not ready yet.');
      return;
    }

    try {
      await _interstitialAd!.show();
    } catch (e) {
      debugPrint('[LiftoffAdapter] Error showing Interstitial: $e');
    } finally {
      _interstitialAd = null;
    }
  }

  @override
  Future<void> loadRewarded(String placementId) async {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestRewardedId() ?? '');
    try {
      _rewardedAd = await RewardedAd.load(
        placementId: effectivePlacementId,
        listener: FullscreenAdListener(
          onShown: () => debugPrint('[LiftoffAdapter] Rewarded shown'),
          onClicked: () => debugPrint('[LiftoffAdapter] Rewarded clicked'),
          onRewarded: () {
            debugPrint('[LiftoffAdapter] Rewarded earned');
            final callback = _pendingRewardCallback;
            if (callback != null) {
              callback(const MagmaRewardItem(1, 'LiftoffReward'));
              _pendingRewardCallback = null;
            }
          },
          onClosed: () {
            debugPrint('[LiftoffAdapter] Rewarded closed');
            _rewardedAd = null;
          },
          onFailedToShow: (error) {
            debugPrint('[LiftoffAdapter] Rewarded show failed: $error');
            _rewardedAd = null;
            _pendingRewardCallback = null;
          },
        ),
      );
      debugPrint('[LiftoffAdapter] Rewarded loaded successfully.');
    } catch (e) {
      _rewardedAd = null;
      debugPrint('[LiftoffAdapter] Rewarded load error: $e');
    }
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    if (_rewardedAd == null) {
      debugPrint('[LiftoffAdapter] Rewarded ad is not ready yet.');
      return;
    }

    _pendingRewardCallback = onReward;
    try {
      await _rewardedAd!.show();
    } catch (e) {
      debugPrint('[LiftoffAdapter] Error showing Rewarded ad: $e');
      _pendingRewardCallback = null;
    } finally {
      _rewardedAd = null;
    }
  }

  @override
  Future<void> loadAppOpen(String placementId) async {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestAppOpenId() ?? '');
    try {
      _appOpenAd = await AppOpenAd.load(
        placementId: effectivePlacementId,
      );
      debugPrint('[LiftoffAdapter] AppOpenAd loaded successfully.');
    } catch (e) {
      _appOpenAd = null;
      debugPrint('[LiftoffAdapter] AppOpenAd load error: $e');
    }
  }

  @override
  Future<void> showAppOpen() async {
    if (_appOpenAd == null) {
      debugPrint('[LiftoffAdapter] AppOpenAd is not ready yet.');
      return;
    }

    try {
      await _appOpenAd!.show();
    } catch (e) {
      debugPrint('[LiftoffAdapter] Error showing AppOpenAd: $e');
    } finally {
      _appOpenAd = null;
    }
  }

  @override
  String? getTestBannerId() => 'BANNER_ADS-DEFAULT';

  @override
  String? getTestNativeId() => 'NATIVE_ADS-DEFAULT';

  @override
  String? getTestInterstitialId() => 'INTERSTITIAL_ADS-DEFAULT';

  @override
  String? getTestRewardedId() => 'REWARDED_ADS-DEFAULT';

  String? getTestAppOpenId() => 'APP_OPEN_ADS-DEFAULT';
}
