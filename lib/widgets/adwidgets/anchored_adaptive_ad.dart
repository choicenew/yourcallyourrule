
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/ad_manager.dart';

class AnchoredAdaptiveBannerAdWidget extends StatefulWidget {
  final AdInfo adInfo;

  const AnchoredAdaptiveBannerAdWidget({super.key, required this.adInfo});

  @override
  AnchoredAdaptiveBannerAdWidgetState createState() => AnchoredAdaptiveBannerAdWidgetState();
}

class AnchoredAdaptiveBannerAdWidgetState extends State<AnchoredAdaptiveBannerAdWidget> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize
   
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());
 /*
    final int screenWidth = MediaQuery.of(context).size.width.truncate();
final int scaledScreenWidth = (screenWidth * 0.97).toInt(); 

final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        scaledScreenWidth);
*/
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