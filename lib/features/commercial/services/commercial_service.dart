import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_commercial_hub/pyro_commercial_hub.dart';
import '../config/app_ads_config.dart';

part 'commercial_service.g.dart';

@Riverpod(keepAlive: true)
CommercialService commercialService(Ref ref) {
  return CommercialService.instance;
}

/// 主 App 商业化中枢 Riverpod 适配服务 (CommercialService)
/// 调配 AdMob 广告与 VIP 内购状态，无缝对接 pyro_commercial_hub 与 pyro_ads_hub
class CommercialService {
  static final CommercialService instance = CommercialService._();

  CommercialService._();

  bool _isVipActive = true;
  bool get isVipActive => _isVipActive;

  /// 初始化商业化服务与广告连接器
  Future<void> initialize() async {
    // 1. 根据环境自动选择 官方测试 ID 或 线上生产 ID，物理防止 AdMob 封号
    if (kDebugMode) {
      AdsHub.instance.setProductionConfig(const AdsConfig.test());
      debugPrint('[CommercialService] Debug 模式: 已注入 AdMob 官方测试 ID 隔离配置');
    } else {
      AdsHub.instance.setProductionConfig(AppAdsConfig.production);
      debugPrint('[CommercialService] Production 模式: 已注入 AdMob 生产环境广告 ID');
    }

    // 2. 婚礼挂载商业广告连接器
    CommercialAdConnectors.ensureAdConnectorsMounted();

    debugPrint('[CommercialService] 主 App 商业化中枢服务挂载初始化完成');
  }

  /// 激活/取消 VIP 状态
  void setVipActive(bool active) {
    _isVipActive = active;
    debugPrint('[CommercialService] VIP 状态变更: $active');
  }
}
