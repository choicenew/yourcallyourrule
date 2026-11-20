import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 开屏广告调度器 (AppOpenAdScheduler)
/// 包含 4 秒加载超时防护与 3 秒后台提前导航计时器，确保 Splash 闪屏不挂死。
class AppOpenAdScheduler {
  AppOpenAdScheduler._();
  static final AppOpenAdScheduler instance = AppOpenAdScheduler._();

  bool _isShowing = false;
  bool _hasDismissed = false;
  VoidCallback? _onDismissedCallback;

  bool get isShowing => _isShowing;

  /// 带有 4000ms 硬超时保护的开屏广告加载
  Future<void> loadAppOpenAd(
    NetworkAdapter adapter,
    String placementId, {
    Duration timeout = const Duration(milliseconds: 4000),
  }) async {
    final completer = Completer<void>();

    try {
      adapter.loadAppOpen(placementId).timeout(timeout, onTimeout: () {
        debugPrint('⏱️ [AppOpenAdScheduler] 开屏广告加载超时 (${timeout.inMilliseconds}ms)，放行');
        if (!completer.isCompleted) completer.complete();
      }).then((_) {
        if (!completer.isCompleted) completer.complete();
      });
    } catch (e) {
      debugPrint('❌ [AppOpenAdScheduler] 开屏广告加载异常: $e');
      if (!completer.isCompleted) completer.complete();
    }

    return completer.future;
  }

  void _safelyInvokeDismissCallback() {
    if (!_hasDismissed) {
      _hasDismissed = true;
      _onDismissedCallback?.call();
    }
  }

  /// 展示开屏广告并挂载 3 秒后台提速导航定时器
  Future<void> showAppOpenAdWithGuard(
    NetworkAdapter adapter, {
    required VoidCallback onDismissed,
  }) async {
    _onDismissedCallback = onDismissed;
    _hasDismissed = false;

    if (_isShowing) {
      debugPrint('[AppOpenAdScheduler] 已有开屏广告在展示，放行导航');
      _safelyInvokeDismissCallback();
      return;
    }

    _isShowing = true;
    Timer? autoNavigateTimer;

    // 启动 3 秒后台提前导航计时器，加速主界面渲染
    autoNavigateTimer = Timer(const Duration(seconds: 3), () {
      debugPrint('⏰ [AppOpenAdScheduler] 3s 计时器触发，后台放行主页导航');
      _safelyInvokeDismissCallback();
    });

    try {
      await adapter.showAppOpen();
    } catch (e) {
      debugPrint('🔴 [AppOpenAdScheduler] 展示开屏广告异常: $e');
    } finally {
      autoNavigateTimer.cancel();
      _isShowing = false;
      _safelyInvokeDismissCallback();
    }
  }
}
