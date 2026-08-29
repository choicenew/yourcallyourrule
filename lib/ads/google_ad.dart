import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';

class GoogleAdWidget extends ConsumerStatefulWidget {
  final AdInfo adInfo;
  final double? width;  // 添加 width 参数
  final double? height; // 添加 height 参数
  final NativeAdConfig? nativeAdConfig;
  
   const GoogleAdWidget({
    super.key,
    required this.adInfo,
    this.width,
    this.height,
    this.nativeAdConfig,
  });

  @override
  GoogleAdWidgetState createState() => GoogleAdWidgetState();
}

class GoogleAdWidgetState extends ConsumerState<GoogleAdWidget> with AutomaticKeepAliveClientMixin {
  dynamic _ad; // 存储不同类型的广告
  bool _isAdLoaded = false; // 广告是否加载完成
  bool _loadAttempted = false;

  @override
  bool get wantKeepAlive {
    if (widget.adInfo.type == AdType.banner ||
        widget.adInfo.type == AdType.nativeAdvanced) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (ref.read(adStateProvider)) {
      _createAd();
    }
  }

  @override
  void didUpdateWidget(covariant GoogleAdWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果广告单元ID发生变化，重新创建广告
    if (oldWidget.adInfo.adUnitId != widget.adInfo.adUnitId) {
      _disposeAd();
      _loadAttempted = false;
      _createAd();
    }
  }

  // 根据广告类型创建相应的广告
  void _createAd() {
    if (_loadAttempted) return;
    _loadAttempted = true;

    final adState = ref.read(adStateProvider);

    if (!adState) return; // 如果广告被禁用，不创建广告

    switch (widget.adInfo.type) {
      case AdType.banner:
        _createBannerAd();
        break;
      case AdType.interstitial:
        _createInterstitialAd();
        break;
      case AdType.rewardedInterstitial:
        _createRewardedInterstitialAd();
        break;
      case AdType.rewarded:
        _createRewardedAd();
        break;
      case AdType.nativeAdvanced:
        _createNativeAdvancedAd();
        break;
      case AdType.appOpen:
        _createAppOpenAd();
        break;
    }
  }

  // 创建横幅广告
  void _createBannerAd() {
    _ad = BannerAd(
      adUnitId: widget.adInfo.adUnitId,
      size: widget.adInfo.size ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isAdLoaded = true;
            });
            updateKeepAlive();
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _ad = null;
          _isAdLoaded = false;
          if (mounted) setState(() {});
        },
      ),
    );
    _ad.load();
  }

  // 创建插页式广告
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          _ad = null;
          _isAdLoaded = false;
          if (mounted) setState(() {});
        },
      ),
    );
  }

// 在 GoogleAdWidgetState 中修改 _createRewardedInterstitialAd() 方法
void _createRewardedInterstitialAd() {
  RewardedInterstitialAd.load(
    adUnitId: widget.adInfo.adUnitId,
    request: const AdRequest(),
    rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
      onAdLoaded: (RewardedInterstitialAd ad) {
        debugPrint('$ad loaded.');
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {},
          onAdImpression: (ad) {},
          onAdFailedToShowFullScreenContent: (ad, err) {
            ad.dispose();
            _ad = null;
            _isAdLoaded = false;
            if (mounted) setState(() {});
          },
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _ad = null; // 清空广告
            _isAdLoaded = false;
            if (mounted) setState(() {});
          },
          onAdClicked: (ad) {},
        );
        _ad = ad;
        _isAdLoaded = true;
        if (mounted) setState(() {});
      },
      onAdFailedToLoad: (LoadAdError error) {
        debugPrint('RewardedInterstitialAd failed to load: $error');
        _ad = null;
        _isAdLoaded = false;
        if (mounted) setState(() {});
      },
    ),
  );
}

  // 创建奖励广告
  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          _ad = null;
          _isAdLoaded = false;
          if (mounted) setState(() {});
        },
      ),
    );
  }

  // 创建原生高级广告
  void _createNativeAdvancedAd() {
    _ad = NativeAd(
      adUnitId: widget.adInfo.adUnitId,
      //factoryId: 'adFactoryExample',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isAdLoaded = true;
            });
            updateKeepAlive(); // 通知保活
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _ad = null;
          _isAdLoaded = false;
          if (mounted) setState(() {});
          debugPrint('NativeAd failed to load: $error');
        },
      ),
            nativeTemplateStyle: widget.nativeAdConfig!.style,
    );
    _ad.load();
  }

  // 创建应用打开广告
  void _createAppOpenAd() {
    AppOpenAd.load(
      adUnitId: widget.adInfo.adUnitId, 
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('AppOpenAd failed to load: $error');
          _ad = null;
          _isAdLoaded = false;
          if (mounted) setState(() {});
        },
      ),
    );
  }

  // 显示广告
  void _showAd() {
    final adState = ref.read(adStateProvider);

    if (!adState) return; // 如果广告被禁用，不显示广告

    if (_ad is InterstitialAd) {
      _ad.show();
    } else if (_ad is RewardedInterstitialAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {
        // 处理奖励
      });
    } else if (_ad is RewardedAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {
        // 处理奖励
      });
    } else if (_ad is AppOpenAd) {
      _ad.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final adState = ref.watch(adStateProvider);

    if (!adState) {
      if (_isAdLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _disposeAd();
        });
      }
      return const SizedBox();
    }

    if (adState && !_isAdLoaded && _ad == null && !_loadAttempted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _createAd());
    }

    // 根据广告状态决定是否显示广告
    if (_isAdLoaded && _ad != null) {
      return _buildAdWidget(width: widget.width, height: widget.height);
    }

    return const SizedBox(); // 不显示广告时返回一个空的 SizedBox
  }

  // 根据广告类型构建相应的广告 Widget
  Widget _buildAdWidget({double? width, double? height}) {
    switch (widget.adInfo.type) {
      case AdType.banner:
        return Container(
          alignment: Alignment.center,
          width: _ad.size.width.toDouble(),
          height: _ad.size.height.toDouble(),
          child: AdWidget(ad: _ad),
        );
      case AdType.nativeAdvanced:
        return SizedBox( // 使用 SizedBox 限制 AdWidget 的高度
          width: width,
          height: height,
            child: AdWidget(ad: _ad),
        );
      case AdType.interstitial:
      case AdType.rewardedInterstitial:
      case AdType.rewarded:
      case AdType.appOpen:
        return ElevatedButton(
          onPressed: _showAd,
          child: Text('Show ${widget.adInfo.type.toString().split('.').last} Ad'),
        );
    }
  }

  // 销毁广告
  void _disposeAd() {
    _ad?.dispose();
    _isAdLoaded = false;
  }

  @override
  void dispose() {
    _disposeAd();
    super.dispose();
  }
}