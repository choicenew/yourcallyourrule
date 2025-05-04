import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';




class InlineAdaptiveBannerAdWidget extends StatefulWidget {
  final AdInfo adInfo;
  final double? width;

  const InlineAdaptiveBannerAdWidget({
    super.key,
    required this.adInfo,
    this.width,
  });

  @override
  InlineAdaptiveBannerAdWidgetState createState() => InlineAdaptiveBannerAdWidgetState();
}

class InlineAdaptiveBannerAdWidgetState extends State<InlineAdaptiveBannerAdWidget> {
  BannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  void _loadAd() async {
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    // Use the provided width or the screen width
    double width = widget.width ?? MediaQuery.of(context).size.width;

    // Get an inline adaptive size for the current orientation and width
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        width.truncate());

    _inlineAdaptiveAd = BannerAd(
      adUnitId: widget.adInfo.adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) async {
         
          if (!mounted) return; // 检查 Widget 是否已销毁

          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            
            return;
          }
/*
          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
*/

          if (mounted) { // 再次检查 Widget 是否已销毁
            setState(() {
              _inlineAdaptiveAd = bannerAd;
              _isLoaded = true;
              _adSize = size;
            });
          }

        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
        
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _inlineAdaptiveAd != null &&
            _isLoaded &&
            _adSize != null) {
          return Container(
            width: widget.width ?? _adSize!.width.toDouble(),
            height: _adSize!.height.toDouble(),
            child: AdWidget(ad: _inlineAdaptiveAd!),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return Container();
      },
    );
  }

/*
  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }
*/

  @override
  void dispose() {
    _inlineAdaptiveAd?.dispose();
    _inlineAdaptiveAd = null; // 释放广告对象
    super.dispose();
  }

}