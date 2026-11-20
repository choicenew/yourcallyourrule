import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_render_ad_protocol/pyro_render_ad_protocol.dart';

/// 商业化最外层单向装配与 1:1 映射连接器 (Commercial Ad Connectors)
class CommercialAdConnectors {
  /// 启动时全项目唯一一次婚礼挂载：将 AdsHub / AdsNative 注入给 RenderAdInterface
  static void ensureAdConnectorsMounted() {
    RenderAdInterface.setAdBuilder((context, placement, styleSpec) {
      // 1:1 零修改 AdsHub 源码映射
      switch (styleSpec) {
        case RenderAdStyleSpec.bannerStandard:
          return const AdsInlineBanner(height: 60.0);
        case RenderAdStyleSpec.smallChip:
          return const AdsNative(style: NativeStyle.small);
        case RenderAdStyleSpec.mediumCard:
          return const AdsNative(style: NativeStyle.medium);
        case RenderAdStyleSpec.largeCard:
        case RenderAdStyleSpec.fullScreen:
          return const AdsNative(style: NativeStyle.large);
      }
    });
  }
}
