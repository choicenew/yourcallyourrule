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
    try {
      // 安全地释放之前的广告
      if (_inlineAdaptiveAd != null) {
        await _inlineAdaptiveAd!.dispose();
        if (mounted) {
          setState(() {
            _inlineAdaptiveAd = null;
            _isLoaded = false;
            _adSize = null; // 重置广告尺寸
          });
        }
      }

      // 如果组件已经被销毁，不要继续加载
      if (!mounted) return;

      // 使用提供的宽度或屏幕宽度
      double width = widget.width ?? MediaQuery.of(context).size.width;

      // 获取当前方向和宽度的内联自适应大小
      AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
          width.truncate());

      // 创建新的广告
      final bannerAd = BannerAd(
        adUnitId: widget.adInfo.adUnitId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) async {
            // 检查 Widget 是否已销毁
            if (!mounted) {
              ad.dispose();
              return;
            }

            try {
              BannerAd bannerAd = (ad as BannerAd);
              final AdSize? size = await bannerAd.getPlatformAdSize();
              
              if (size == null || !mounted) {
                ad.dispose();
                return;
              }

              setState(() {
                _inlineAdaptiveAd = bannerAd;
                _isLoaded = true;
                _adSize = size;
              });
            } catch (e) {
              // 处理获取广告尺寸时的错误
              ad.dispose();
            }
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            // 记录错误并释放广告资源
            print('广告加载失败: ${error.message}');
            ad.dispose();
            
            // 确保状态正确更新
            if (mounted) {
              setState(() {
                _inlineAdaptiveAd = null;
                _isLoaded = false;
              });
            }
          },
        ),
      );
      
      // 设置当前广告并加载
      _inlineAdaptiveAd = bannerAd;
      await bannerAd.load();
    } catch (e) {
      // 捕获并处理任何加载过程中的异常
      print('加载广告时发生错误: $e');
      if (mounted) {
        setState(() {
          _inlineAdaptiveAd = null;
          _isLoaded = false;
        });
      }
    }
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
    // 安全地释放广告资源
    try {
      if (_inlineAdaptiveAd != null) {
        _inlineAdaptiveAd!.dispose();
        _inlineAdaptiveAd = null;
      }
    } catch (e) {
      print('释放广告资源时发生错误: $e');
    } finally {
      super.dispose();
    }
  }

}