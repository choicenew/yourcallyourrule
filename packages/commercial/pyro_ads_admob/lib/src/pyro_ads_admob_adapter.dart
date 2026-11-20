import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

const String kFullScreenAdFactoryId = 'fullScreenAdFactory';
const String kAdaptiveCardAdFactoryId = 'adaptiveCardAdFactory';

/// 完整实现 [NetworkAdapter] 的纯底层 AdMob 哑驱动 (1:1 严格对齐原版 admob_adapter.dart 零 Hub / 零 Manager 纯哑架构)
class PyroAdsAdmobAdapter implements NetworkAdapter {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;
  String? _nativeFactoryId;
  bool _isAppOpenShowing = false;

  @override
  String get providerId => AdProviderToken.admob;

  @override
  String get providerName => 'Google Mobile Ads (AdMob)';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    _nativeFactoryId = config['nativeFactoryId']?.toString();
    await MobileAds.instance.initialize();
    await _registerNativeAdFactories();
  }

  Future<void> _registerNativeAdFactories() async {
    const platform = MethodChannel('ads_package');
    try {
      await platform.invokeMethod('registerNativeAdFactories');
    } on PlatformException catch (e) {
      debugPrint('[PyroAdsAdmobAdapter] Failed to register NativeAdFactories: ${e.message}');
    }
  }

  // --- Banner ---
  @override
  Widget buildBanner(String placementId) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestBannerId() ?? '');
    return _AdMobBanner(adUnitId: effectivePlacementId);
  }

  // --- Native ---
  @override
  Widget buildNative(String placementId, NativeStyle style) {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestNativeId() ?? '');

    String? targetFactoryId;
    if (_nativeFactoryId == null) {
      targetFactoryId = style == NativeStyle.medium
          ? kFullScreenAdFactoryId
          : kAdaptiveCardAdFactoryId;
    } else {
      targetFactoryId = _nativeFactoryId;
    }

    return _AdMobNative(
      adUnitId: effectivePlacementId,
      style: style,
      factoryId: targetFactoryId,
    );
  }

  // --- Interstitial ---
  @override
  Future<void> loadInterstitial(String placementId) async {
    final effectivePlacementId = placementId.isNotEmpty
        ? placementId
        : (getTestInterstitialId() ?? '');

    await InterstitialAd.load(
      adUnitId: effectivePlacementId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[PyroAdsAdmobAdapter] Interstitial loaded: $effectivePlacementId');
          _interstitialAd = ad;
          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('[PyroAdsAdmobAdapter] Interstitial failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  @override
  Future<void> showInterstitial() async {
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  // --- Rewarded ---
  @override
  Future<void> loadRewarded(String placementId) async {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestRewardedId() ?? '');

    await RewardedAd.load(
      adUnitId: effectivePlacementId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[PyroAdsAdmobAdapter] Rewarded Loaded: $effectivePlacementId');
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('[PyroAdsAdmobAdapter] Rewarded Failed to load: $error');
          _rewardedAd = null;
        },
      ),
    );
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    if (_rewardedAd == null) return;

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        onReward(MagmaRewardItem(reward.amount, reward.type));
      },
    );
    _rewardedAd = null;
  }

  // --- App Open ---
  @override
  Future<void> loadAppOpen(String placementId) async {
    final effectivePlacementId =
        placementId.isNotEmpty ? placementId : (getTestBannerId() ?? '');

    await AppOpenAd.load(
      adUnitId: effectivePlacementId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[PyroAdsAdmobAdapter] AppOpen Loaded: $effectivePlacementId');
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('[PyroAdsAdmobAdapter] AppOpen Failed to load: $error');
          _appOpenAd = null;
        },
      ),
    );
  }

  @override
  Future<void> showAppOpen() async {
    if (_appOpenAd == null || _isAppOpenShowing) return;

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => _isAppOpenShowing = true,
      onAdDismissedFullScreenContent: (ad) {
        _isAppOpenShowing = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isAppOpenShowing = false;
        ad.dispose();
        _appOpenAd = null;
      },
    );

    await _appOpenAd!.show();
    _appOpenAd = null;
  }

  @override
  String? getTestBannerId() => 'ca-app-pub-3940256099942544/6300978111';

  @override
  String? getTestNativeId() => 'ca-app-pub-3940256099942544/2247696110';

  @override
  String? getTestInterstitialId() => 'ca-app-pub-3940256099942544/1033173712';

  @override
  String? getTestRewardedId() => 'ca-app-pub-3940256099942544/5224354917';
}

// --- 纯哑巴内部 AdMob 控件 ---

class _AdMobBanner extends StatefulWidget {
  final String adUnitId;
  const _AdMobBanner({required this.adUnitId});

  @override
  State<_AdMobBanner> createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<_AdMobBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded && _bannerAd != null) {
      return SizedBox(
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }
    return const SizedBox.shrink();
  }
}

class _AdMobNative extends StatefulWidget {
  final String adUnitId;
  final NativeStyle style;
  final String? factoryId;

  const _AdMobNative({
    required this.adUnitId,
    required this.style,
    this.factoryId,
  });

  @override
  State<_AdMobNative> createState() => _AdMobNativeState();
}

class _AdMobNativeState extends State<_AdMobNative> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final templateType = widget.style == NativeStyle.small
        ? TemplateType.small
        : TemplateType.medium;

    NativeTemplateStyle? nativeTemplateStyle;
    if (widget.factoryId == null) {
      nativeTemplateStyle = NativeTemplateStyle(templateType: templateType);
    }

    _nativeAd = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: widget.factoryId,
      nativeTemplateStyle: nativeTemplateStyle,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded && _nativeAd != null) {
      return SizedBox(
        width: double.infinity,
        height: widget.style == NativeStyle.small ? 120 : 360,
        child: AdWidget(ad: _nativeAd!),
      );
    }
    return const SizedBox.shrink();
  }
}
