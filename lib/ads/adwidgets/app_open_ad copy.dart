import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 开屏广告管理类
/// 负责加载、显示和管理开屏广告的生命周期
class AppOpenAdManager {
  AppOpenAdManager._();
  
  /// 单例实例
  static final AppOpenAdManager instance = AppOpenAdManager._();
  
  AppOpenAd? _appOpenAd;
  bool _isAdLoaded = false;
  bool _isShowingAd = false;
  
  /// 广告是否已加载完成
  bool get isAdLoaded => _isAdLoaded;
  
  /// 是否正在显示广告
  bool get isShowingAd => _isShowingAd;
  
  /// 获取当前加载的AppOpenAd实例
  AppOpenAd? get appOpenAd => _appOpenAd;
  
  /// 加载开屏广告
  /// 返回一个Future，表示广告加载是否成功
  Future<bool> loadAd() async {
    if (_isAdLoaded) return true;
    
    final completer = Completer<bool>();
    
    try {
      await AppOpenAd.load(
        adUnitId: AdManager.appOpenAd.adUnitId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('开屏广告加载成功');
            _appOpenAd = ad;
            _isAdLoaded = true;
            
            // 设置广告回调
            _setupAdCallbacks(ad);
            completer.complete(true);
          },
          onAdFailedToLoad: (error) {
            debugPrint('开屏广告加载失败: ${error.message} (代码: ${error.code})');
            _isAdLoaded = false;
            completer.complete(false);
          },
        ),
      );
    } catch (e) {
      debugPrint('广告加载异常: $e');
      _isAdLoaded = false;
      completer.complete(false);
    }
    
    return completer.future;
  }
  
  /// 设置广告回调
  void _setupAdCallbacks(AppOpenAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('开屏广告被关闭');
        _isShowingAd = false;
        _cleanupAd(); // 清理旧的广告
              // *** 核心改动：立即开始加载下一个广告以备下次使用 ***
      debugPrint('开始预加载下一个开屏广告...');
      loadAd(); 
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('开屏广告显示失败: ${error.message}');
        _isShowingAd = false;
        _cleanupAd(); // 清理失败的广告
              // *** 同样，显示失败后也尝试重新加载 ***
      debugPrint('显示失败，尝试重新预加载下一个开屏广告...');
      loadAd();
      },
      onAdShowedFullScreenContent: (ad) {
        debugPrint('开屏广告开始显示');
        _isShowingAd = true;
      },
      onAdImpression: (ad) {
        debugPrint('开屏广告产生展示');
      },
    );
  }
  
  /// 清理广告资源
  void _cleanupAd() {
    try {
      _appOpenAd?.dispose();
      _appOpenAd = null;
      _isAdLoaded = false;
    } catch (e) {
      debugPrint('清理广告资源失败: $e');
    }
  }
  
  /// 显示开屏广告
  /// 返回一个布尔值，表示广告是否成功显示
  bool showAdIfAvailable() {
    if (!_isAdLoaded || _appOpenAd == null || _isShowingAd) {
      return false;
    }
    
    try {
      _appOpenAd!.show();
      return true;
    } catch (e) {
      debugPrint('显示开屏广告异常: $e');
      _cleanupAd();
      return false;
    }
  }
  
  /// 预加载开屏广告
  /// 用于提前加载广告，以便在需要时立即显示
  void preloadAd() {
    if (!_isAdLoaded && _appOpenAd == null) {
      loadAd();
    }
  }
  
  /// 释放资源
  void dispose() {
    _cleanupAd();
  }
}