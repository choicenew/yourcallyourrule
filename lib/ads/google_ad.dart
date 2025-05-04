import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';





class GoogleAdWidget extends StatefulWidget {
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

class GoogleAdWidgetState extends State<GoogleAdWidget> {
  dynamic _ad; // 存储不同类型的广告
  bool _isAdLoaded = false; // 广告是否加载完成


  @override
  void initState() {
    super.initState();
    _createAd(); // 初始化时创建广告
  }

  @override
  void didUpdateWidget(covariant GoogleAdWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果广告单元ID发生变化，重新创建广告
    if (oldWidget.adInfo.adUnitId != widget.adInfo.adUnitId) {
      _disposeAd();
      _createAd();
    }
  }

  // 根据广告类型创建相应的广告
  void _createAd() {
    final adState = Provider.of<AdState>(context, listen: false);

    if (!adState.isAdEnabled) return; // 如果广告被禁用，不创建广告

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
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
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
          setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
         // print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

/*
  // 创建奖励插页式广告
  void _createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: widget.adInfo.adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          _ad = ad;
          _isAdLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }
*/

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
          },
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            _ad = null; // 清空广告
            _createRewardedInterstitialAd(); // 重新加载广告
          },
          onAdClicked: (ad) {},
        );
        _ad = ad;
        _isAdLoaded = true;
        setState(() {});
      },
      onAdFailedToLoad: (LoadAdError error) {
        debugPrint('RewardedInterstitialAd failed to load: $error');
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
          setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
          //print('RewardedAd failed to load: $error');
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
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          //print('NativeAd failed to load: $error');
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
          setState(() {});
        },
        onAdFailedToLoad: (LoadAdError error) {
        //  print('AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  // 显示广告
  void _showAd() {
    final adState = Provider.of<AdState>(context, listen: false);

    if (!adState.isAdEnabled) return; // 如果广告被禁用，不显示广告

    if (_ad is InterstitialAd) {
      _ad.show();
      _createInterstitialAd(); // 显示后重新加载
    } else if (_ad is RewardedInterstitialAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {
        // 处理奖励
      });
      _createRewardedInterstitialAd(); // 显示后重新加载
    } else if (_ad is RewardedAd) {
      _ad.show(onUserEarnedReward: (ad, reward) {
        // 处理奖励
      });
      _createRewardedAd(); // 显示后重新加载
    } else if (_ad is AppOpenAd) {
      _ad.show();
      _createAppOpenAd(); // 显示后重新加载
    }
  }
/*
  @override
  Widget build(BuildContext context) {
    return Consumer<AdState>(
      builder: (context, adState, child) {
        // 根据广告状态决定是否显示广告
        return Visibility(
          visible: adState.isAdEnabled && _isAdLoaded,
          child: _buildAdWidget(width: widget.width, height: widget.height),
        );
      },
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Consumer<AdState>(
      builder: (context, adState, child) {
        // 根据广告状态决定是否显示广告
        if (adState.isAdEnabled && _isAdLoaded) {
          return _buildAdWidget(width: widget.width, height: widget.height);
        } else {
          return const SizedBox(); // 不显示广告时返回一个空的 SizedBox
        }
      },
    );
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