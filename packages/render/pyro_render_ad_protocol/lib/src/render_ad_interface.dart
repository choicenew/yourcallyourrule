import 'package:flutter/widgets.dart';
import 'render_ad_placement.dart';
import 'render_ad_style.dart';

/// 100% 编译期类型安全的广告构建函数签名
typedef RenderAdWidgetBuilder = Widget Function(
  BuildContext context, 
  RenderAdPlacement placement, 
  RenderAdStyleSpec styleSpec,
);

/// 全局广告接口句柄入口 (0 依赖任何广告 SDK)
class RenderAdInterface {
  static RenderAdWidgetBuilder? _builder;

  /// 最外层 (商业化装配层) 启动时单向注入构建能力
  static void setAdBuilder(RenderAdWidgetBuilder builder) {
    _builder = builder;
  }

  /// Render 页面或 Feed 容器直接调用该静态入口生成 Widget
  static Widget buildAd(
    BuildContext context, {
    required RenderAdPlacement placement,
    required RenderAdStyleSpec styleSpec,
  }) {
    if (_builder == null) {
      return const SizedBox.shrink(); // 未注入或 VIP 免广告时，100% 自动 0 像素隐形坍缩
    }
    return _builder!(context, placement, styleSpec);
  }
}
