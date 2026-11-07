import 'package:material_ui/material_ui.dart';
import 'package:startapp_sdk/startapp.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 纯底层 Start.io 驱动 Adapter (仅依赖 pyro_ads_protocol)
class StartIoAdapter implements NetworkAdapter {
  StartAppInterstitialAd? _interstitialAd;
  StartAppRewardedVideoAd? _rewardedAd;

  final StartAppSdk _sdk = StartAppSdk();

  @override
  String get providerId => 'startio';

  @override
  String get providerName => 'Start.io';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {
    bool testMode = config['testMode'] ?? false;
    _sdk.setTestAdsEnabled(testMode);
  }

  @override
  Widget buildBanner(String placementId) {
    return _StartIoBannerLoader(adTag: placementId, sdk: _sdk);
  }

  @override
  Widget buildNative(String placementId, NativeStyle style) {
    return _StartIoNativeLoader(adTag: placementId, sdk: _sdk, style: style);
  }

  @override
  Future<void> loadInterstitial(String placementId) async {
    var prefs = StartAppAdPreferences(adTag: placementId);
    await _sdk
        .loadInterstitialAd(
      prefs: prefs,
      onAdDisplayed: () {},
      onAdNotDisplayed: () {
        _interstitialAd = null;
      },
    )
        .then((ad) {
      _interstitialAd = ad;
    }).catchError((e) {
      debugPrint('StartIo Interstitial Error: $e');
    });
  }

  @override
  Future<void> showInterstitial() async {
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  @override
  Future<void> loadRewarded(String placementId) async {
    var prefs = StartAppAdPreferences(adTag: placementId);
    await _sdk
        .loadRewardedVideoAd(
      prefs: prefs,
      onAdDisplayed: () {},
      onAdNotDisplayed: () {
        _rewardedAd = null;
      },
      onVideoCompleted: () {},
    )
        .then((ad) {
      _rewardedAd = ad;
    }).catchError((e) {
      debugPrint('StartIo Rewarded Error: $e');
    });
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    if (_rewardedAd != null) {
      await _rewardedAd!.show();
      onReward(const MagmaRewardItem(1, 'StartAppReward'));
      _rewardedAd = null;
    }
  }

  @override
  Future<void> loadAppOpen(String placementId) async {}

  @override
  Future<void> showAppOpen() async {}

  @override
  String? getTestBannerId() => 'test_startio_banner';

  @override
  String? getTestNativeId() => 'test_startio_native';

  @override
  String? getTestInterstitialId() => 'test_startio_interstitial';

  @override
  String? getTestRewardedId() => 'test_startio_rewarded';
}

class _StartIoBannerLoader extends StatefulWidget {
  final String adTag;
  final StartAppSdk sdk;
  const _StartIoBannerLoader({required this.adTag, required this.sdk});
  @override
  State<_StartIoBannerLoader> createState() => _StartIoBannerLoaderState();
}

class _StartIoBannerLoaderState extends State<_StartIoBannerLoader> {
  StartAppBannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    widget.sdk
        .loadBannerAd(
      StartAppBannerType.BANNER,
      prefs: StartAppAdPreferences(adTag: widget.adTag),
    )
        .then((ad) {
      if (mounted) setState(() => _bannerAd = ad);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerAd != null) return StartAppBanner(_bannerAd!);
    return const SizedBox.shrink();
  }
}

class _StartIoNativeLoader extends StatefulWidget {
  final String adTag;
  final StartAppSdk sdk;
  final NativeStyle style;
  const _StartIoNativeLoader({
    required this.adTag,
    required this.sdk,
    required this.style,
  });
  @override
  State<_StartIoNativeLoader> createState() => _StartIoNativeLoaderState();
}

class _StartIoNativeLoaderState extends State<_StartIoNativeLoader> {
  StartAppNativeAd? _nativeAd;
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    widget.sdk
        .loadNativeAd(prefs: StartAppAdPreferences(adTag: widget.adTag))
        .then((ad) {
      if (mounted) setState(() => _nativeAd = ad);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_nativeAd != null) {
      return SizedBox(
        height: widget.style == NativeStyle.small ? 100 : 300,
        child: Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _nativeAd!.title ?? 'Start.io Ad',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_nativeAd!.description ?? 'Native Ad Body'),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
