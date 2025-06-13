
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';

class AnchoredAdaptiveBannerAdWidget extends ConsumerStatefulWidget {
  final AdInfo adInfo;

  const AnchoredAdaptiveBannerAdWidget({super.key, required this.adInfo});

  @override
  AnchoredAdaptiveBannerAdWidgetState createState() => AnchoredAdaptiveBannerAdWidgetState();
}

class AnchoredAdaptiveBannerAdWidgetState extends ConsumerState<AnchoredAdaptiveBannerAdWidget> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    // 检查广告状态
    final adState = ref.read(adStateProvider);
    if (!adState) return;
    
    // Get an AnchoredAdaptiveBannerAdSize
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: widget.adInfo.adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    final adState = ref.watch(adStateProvider);
    
    if (!adState) return Container(); // 如果广告被禁用，返回空容器
    
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_anchoredAdaptiveAd != null && _isLoaded) {
          return Container(
            color: Colors.transparent,
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          );
        }
        // Return an empty container if the ad is not loaded yet
        return Container();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}