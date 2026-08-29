// 文件路径: lib/ads/ad_manager.dart (或您存放的位置)
// 这是实现了“后台导航”功能的最终正确版本。

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart'; // 确保这个路径是正确的

/// 开屏广告管理类 (最终版)
/// 实现了后台导航，以确保App流程在广告展示后自动继续。
class AppOpenAdManager {
  AppOpenAdManager._();
  static final AppOpenAdManager instance = AppOpenAdManager._();
  
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  
  bool get isAdLoaded => _appOpenAd != null;
  bool get isShowingAd => _isShowingAd;

  // 这个包装器确保 onAdDismissed 只被调用一次
  VoidCallback? _onAdDismissedCallback;
  bool _hasDismissed = false;

  Future<void> loadAd() async {
    if (isAdLoaded || _isShowingAd) {
      debugPrint('已有广告已加载或正在显示，跳过本次加载');
      return;
    }
    final completer = Completer<void>();
    try {
      await AppOpenAd.load(
        adUnitId: AdManager.appOpenAd.adUnitId,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('✅ 开屏广告加载成功');
            _appOpenAd = ad;
            if (!completer.isCompleted) completer.complete();
          },
          onAdFailedToLoad: (error) {
            debugPrint('❌ 开屏广告加载失败: ${error.message}');
            _appOpenAd = null;
            if (!completer.isCompleted) completer.complete();
          },
        ),
      ).timeout(const Duration(milliseconds: 2000), onTimeout: () {
        debugPrint('⏱️ 开屏广告加载超时');
        if (!completer.isCompleted) completer.complete();
      });
    } catch (e) {
      debugPrint('❌ 广告加载异常: $e');
      if (!completer.isCompleted) completer.complete();
    }
    return completer.future;
  }
  
  void _cleanupAd() {
    _appOpenAd?.dispose();
    _appOpenAd = null;
  }
  
  /// 在广告流程结束后安全地调用一次导航回调。
  void _safelyInvokeDismissCallback() {
    if (!_hasDismissed) {
      _hasDismissed = true;
      _onAdDismissedCallback?.call();
    }
  }
  
  /// 显示开屏广告
  void showAdIfAvailable({required VoidCallback onAdDismissed}) {
    // 重置状态，为本次显示做准备
    _onAdDismissedCallback = onAdDismissed;
    _hasDismissed = false;

    if (!isAdLoaded) {
      debugPrint('广告未就绪，立即执行导航');
      _safelyInvokeDismissCallback();
      return;
    }
    if (_isShowingAd) {
      debugPrint('另一个广告正在显示，直接放行导航');
      _safelyInvokeDismissCallback();
      return;
    }
    
    Timer? autoNavigateTimer;
    
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('🟢 开屏广告开始显示');
        
        // *** 核心逻辑: 启动3秒计时器，用于在后台触发导航 ***
        autoNavigateTimer = Timer(const Duration(seconds: 3), () {
          debugPrint('⏰ 3秒计时器触发，执行后台导航');
          _safelyInvokeDismissCallback();
        });
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        debugPrint('🟡 开屏广告被用户手动关闭');
        autoNavigateTimer?.cancel(); // 用户已操作，取消自动导航
        
        _safelyInvokeDismissCallback(); // 确保导航被调用
        _cleanupAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        debugPrint('🔴 开屏广告显示失败: ${error.message}');
        autoNavigateTimer?.cancel(); // 显示失败，取消计时器
        
        _safelyInvokeDismissCallback(); // 确保导航被调用
        _cleanupAd();
      },
    );
    
    try {
      _appOpenAd!.show();
    } catch (e) {
      debugPrint('🔴 开屏广告展示异常: $e');
      _safelyInvokeDismissCallback();
      _cleanupAd();
    }
  }
}