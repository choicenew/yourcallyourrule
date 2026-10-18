import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_preload_service.dart';

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
  bool _isFailed = false;
  bool _hasRetried = false; // 是否已经自动重试过1次

  @override
  bool get wantKeepAlive => true; // 保活：滑动时不释放广告，滑回来立刻呈现

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
    if (oldWidget.adInfo.adUnitId != widget.adInfo.adUnitId) {
      _disposeAd();
      _loadAttempted = false;
      _isFailed = false;
      _hasRetried = false;
      _createAd();
    }
  }

  void _handleAdFailure(String adType, dynamic error) {
    debugPrint('$adType failed to load: $error');
    _isAdLoaded = false;

    if (!_hasRetried && mounted) {
      _hasRetried = true;
      debugPrint('$adType 首次加载失败，4秒后自动重试...');
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          _loadAttempted = false;
          _createAd();
        }
      });
    } else {
      _isFailed = true;
      if (mounted) setState(() {});
    }
  }

  void _createAd() {
    if (_loadAttempted) return;
    _loadAttempted = true;

    final adState = ref.read(adStateProvider);
    if (!adState) return;

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

  Future<void> _createBannerAd() async {
    final preloaded = AdPreloadManager.instance.consumeBannerAd(widget.adInfo.adUnitId);
    if (preloaded != null && preloaded.ad is BannerAd) {
      _ad = preloaded.ad as BannerAd;
      _isAdLoaded = true;
      _isFailed = false;
      if (mounted) setState(() {});
      updateKeepAlive();
      AdPreloadManager.instance.preloadBannerAd(widget.adInfo);
      return;
    }

    AdSize? size = widget.adInfo.size;
    if (size == null) {
      final double width = widget.width ?? (mounted ? MediaQuery.of(context).size.width : 320.0);
      size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        width > 0 ? width.truncate() : 320,
      ) ?? AdSize.banner;
    }
    if (!mounted) return;

    _ad = BannerAd(
      adUnitId: widget.adInfo.adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isAdLoaded = true;
              _isFailed = false;
            });
            updateKeepAlive();
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _ad = null;
          _handleAdFailure('BannerAd', error);
        },
      ),
    );
    _ad.load();
  }

  void _createNativeAdvancedAd() {
    final preloaded = AdPreloadManager.instance.consumeNativeAd(widget.adInfo.adUnitId);
    if (preloaded != null && preloaded.ad is NativeAd) {
      _ad = preloaded.ad as NativeAd;
      _isAdLoaded = true;
      _isFailed = false;
      if (mounted) setState(() {});
      updateKeepAlive();
      AdPreloadManager.instance.preloadNativeAd(widget.adInfo, config: widget.nativeAdConfig);
      return;
    }

    _ad = NativeAd(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isAdLoaded = true;
              _isFailed = false;
            });
            updateKeepAlive();
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _ad = null;
          _handleAdFailure('NativeAd', error);
        },
      ),
      nativeTemplateStyle: widget.nativeAdConfig?.style,
    );
    _ad.load();
  }

  void _createInterstitialAd() {
    final preloaded = AdPreloadManager.instance.consumeInterstitialAd(widget.adInfo.adUnitId);
    if (preloaded != null && preloaded.ad is InterstitialAd) {
      _ad = preloaded.ad as InterstitialAd;
      _isAdLoaded = true;
      _isFailed = false;
      if (mounted) setState(() {});
      AdPreloadManager.instance.preloadInterstitialAd(widget.adInfo);
      return;
    }

    InterstitialAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          _isFailed = false;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          _ad = null;
          _handleAdFailure('InterstitialAd', error);
        },
      ),
    );
  }

  void _createRewardedInterstitialAd() {
    final preloaded = AdPreloadManager.instance.consumeRewardedAd(widget.adInfo.adUnitId);
    if (preloaded != null && preloaded.ad is RewardedInterstitialAd) {
      _ad = preloaded.ad as RewardedInterstitialAd;
      _isAdLoaded = true;
      _isFailed = false;
      if (mounted) setState(() {});
      AdPreloadManager.instance.preloadRewardedAd(widget.adInfo);
      return;
    }

    RewardedInterstitialAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              _ad = null;
              _isAdLoaded = false;
              _isFailed = true;
              if (mounted) setState(() {});
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _ad = null;
              _isAdLoaded = false;
              if (mounted) setState(() {});
            },
          );
          _ad = ad;
          _isAdLoaded = true;
          _isFailed = false;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          _ad = null;
          _handleAdFailure('RewardedInterstitialAd', error);
        },
      ),
    );
  }

  void _createRewardedAd() {
    final preloaded = AdPreloadManager.instance.consumeRewardedAd(widget.adInfo.adUnitId);
    if (preloaded != null && preloaded.ad is RewardedAd) {
      _ad = preloaded.ad as RewardedAd;
      _isAdLoaded = true;
      _isFailed = false;
      if (mounted) setState(() {});
      AdPreloadManager.instance.preloadRewardedAd(widget.adInfo);
      return;
    }

    RewardedAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          _isFailed = false;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          _ad = null;
          _handleAdFailure('RewardedAd', error);
        },
      ),
    );
  }

  void _createAppOpenAd() {
    AppOpenAd.load(
      adUnitId: widget.adInfo.adUnitId, 
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          _isFailed = false;
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          _ad = null;
          _handleAdFailure('AppOpenAd', error);
        },
      ),
    );
  }

  void _showAd() {
    final adState = ref.read(adStateProvider);
    if (!adState) return;

    if (_ad is InterstitialAd) {
      _ad.show();
    } else if (_ad is RewardedInterstitialAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {});
    } else if (_ad is RewardedAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {});
    } else if (_ad is AppOpenAd) {
      _ad.show();
    }
  }

  /// 构建统一精美赞助卡片包覆外框 (纯外包布局，100% 零遮挡 Google 原生广告)
  Widget _buildSponsoredCard(BuildContext context, Widget child, {double? width}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = theme.colorScheme.surfaceContainerHighest.withOpacity(isDark ? 0.45 : 0.65);
    final borderColor = theme.colorScheme.outlineVariant.withOpacity(0.35);

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Center(child: child),
    );
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
      return const SizedBox.shrink();
    }

    if (adState && !_isAdLoaded && _ad == null && !_loadAttempted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _createAd());
    }

    // A. 广告加载成功，呈现卡片包裹广告
    if (_isAdLoaded && _ad != null) {
      final isInlineType = widget.adInfo.type == AdType.banner || widget.adInfo.type == AdType.nativeAdvanced;
      if (isInlineType) {
        return _buildSponsoredCard(
          context,
          _buildAdWidget(width: widget.width, height: widget.height),
          width: widget.width,
        );
      }
      return _buildAdWidget(width: widget.width, height: widget.height);
    }

    // B. 广告彻底加载失败（重试后依然失败），收缩占位
    if (_isFailed) {
      return const SizedBox.shrink();
    }

    // C. 正在加载中：优雅骨架屏卡片，保持卡片容器外观一致，消除 0 高度塌陷
    final isNative = widget.adInfo.type == AdType.nativeAdvanced;
    final targetHeight = widget.height ?? (isNative ? 180.0 : 50.0);
    return _buildSponsoredCard(
      context,
      SizedBox(
        height: targetHeight,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "AD",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
      width: widget.width,
    );
  }

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
        return SizedBox(
          width: width,
          height: height ?? 200,
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
