import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_commercial_hub/pyro_commercial_hub.dart';

part 'commercial_service.g.dart';

@Riverpod(keepAlive: true)
CommercialService commercialService(Ref ref) {
  return CommercialService.instance;
}

/// 主 App 商业化中枢 Riverpod 适配服务 (CommercialService)
/// 调配广告与 VIP 内购状态，无缝对接 package:pyro_commercial_hub
class CommercialService {
  static final CommercialService instance = CommercialService._();

  CommercialService._();

  bool _isVipActive = false;
  bool get isVipActive => _isVipActive;

  /// 初始化商业化服务与广告连接器
  Future<void> initialize() async {
    CommercialAdConnectors.ensureAdConnectorsMounted();
    debugPrint('[CommercialService] 主 App 商业化中枢服务挂载初始化完成');
  }

  /// 激活/取消 VIP 状态
  void setVipActive(bool active) {
    _isVipActive = active;
    debugPrint('[CommercialService] VIP 状态变更: $active');
  }
}
