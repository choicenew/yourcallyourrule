import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';

part 'ad_control_service.g.dart';

@Riverpod(keepAlive: true)
AdControlService adControlService(Ref ref) {
  return AdControlService.instance;
}

/// 主 App 广告控制 Riverpod 服务 (AdControlService)
class AdControlService {
  static final AdControlService instance = AdControlService._();

  AdControlService._();

  bool _isAdEnabled = true;
  bool get isAdEnabled => _isAdEnabled;

  /// 开启或关闭广告
  void setAdEnabled(bool enabled) {
    _isAdEnabled = enabled;
    debugPrint('[AdControlService] 广告显示开关变更: $enabled');
  }

  /// 获取 AdsHub 实例
  AdsHub get adsHub => AdsHub.instance;
}
