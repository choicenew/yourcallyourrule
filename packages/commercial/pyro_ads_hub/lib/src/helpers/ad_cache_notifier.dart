import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

/// 广告状态锁与重试控制器 (防死循环 Rebuild 重试风暴)
class AdCacheNotifier extends ChangeNotifier {
  final String providerId;
  final AdSlotType slotType;
  final String placementId;

  bool _isStarted = false;
  bool _isLoaded = false;
  bool _isFailed = false;
  bool _hasRetried = false;

  AdCacheNotifier({
    required this.providerId,
    required this.slotType,
    required this.placementId,
  });

  bool get isStarted => _isStarted;
  bool get isLoaded => _isLoaded;
  bool get isFailed => _isFailed;

  /// 标记已启动加载
  void startLoading() {
    if (_isStarted) return;
    _isStarted = true;
    _isFailed = false;
    notifyListeners();
  }

  /// 标记成功加载
  void markSuccess() {
    _isLoaded = true;
    _isFailed = false;
    notifyListeners();
  }

  /// 错误处理：包含 4s 延迟单次重试 & 锁死重试防止 ANR
  void handleFailure(dynamic error, VoidCallback retryCallback) {
    debugPrint('❌ [AdCacheNotifier] 广告加载失败 ($providerId/$slotType): $error');
    _isLoaded = false;

    if (!_hasRetried) {
      _hasRetried = true;
      debugPrint('⚡ [AdCacheNotifier] 4秒后自动重试 1 次...');
      Future.delayed(const Duration(seconds: 4), () {
        _isStarted = false;
        retryCallback();
      });
    } else {
      // 保持 isStarted = true，锁定失败状态，彻底斩断死循环重试风暴！
      _isFailed = true;
      notifyListeners();
    }
  }

  void reset() {
    _isStarted = false;
    _isLoaded = false;
    _isFailed = false;
    _hasRetried = false;
    notifyListeners();
  }
}
