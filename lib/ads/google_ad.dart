import 'dart:async';
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

    // 【生产环境优化】：如果首次请求失败（如偶发 No-Fill 或网络抖动），延迟 4 秒自动重试 1 次
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

  // 根据广告类型创建相应的广告
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

  // 创建横幅广告
  Future<void> _createBannerAd() async {
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

  // 创建原生高级广告
  void _createNativeAdvancedAd() {
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

  // 创建插页式广告
  void _createInterstitialAd() {
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

  // 创建奖励广告
  void _createRewardedAd() {
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

  // 创建应用打开广告
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

  // 显示广告
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

    // A. 广告加载成功，呈现广告
    if (_isAdLoaded && _ad != null) {
      return _buildAdWidget(width: widget.width, height: widget.height);
    }

    // B. 广告彻底加载失败（重试后依然失败），收缩占位
    if (_isFailed) {
      return const SizedBox.shrink();
    }

    // C. 正在加载或正在等待自动重试：提供优雅的固定高度骨架屏，消除 0 高度塌陷
    final isNative = widget.adInfo.type == AdType.nativeAdvanced;
    final targetHeight = widget.height ?? (isNative ? 200.0 : 60.0);
    return Container(
      width: widget.width ?? double.infinity,
      height: targetHeight,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(8.0),
      ),
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
                  Colors.grey.withAlpha(120),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "AD",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withAlpha(120),
              ),
            ),
          ],
        ),
      ),
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
