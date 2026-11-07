import 'dart:ui';
import 'package:material_ui/material_ui.dart';
import 'package:pyro_theme/pyro_theme.dart';

/// 1:1 对齐 pub.dev 顶级开源库 [glass] 规范的无缝液态高斯玻璃 Widget 链式扩展 (.asGlass())
extension GlassWidgetExtension on Widget {
  Widget asGlass({
    double? blur,
    double? opacity,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final glassExt = theme.extension<GlassmorphicThemeExtension>() ?? GlassmorphicThemeExtension.light;
        final effectiveBlur = blur ?? glassExt.blur;
        final effectiveOpacity = opacity ?? glassExt.opacity;
        final effectiveRadius = borderRadius ?? BorderRadius.circular(16.0);

        return Container(
          margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
          child: ClipRRect(
            borderRadius: effectiveRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
              child: Container(
                padding: padding ?? const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: (effectiveOpacity * 0.95).clamp(0.55, 0.90))
                      : Colors.white.withValues(alpha: (effectiveOpacity * 1.05).clamp(0.65, 0.95)),
                  borderRadius: effectiveRadius,
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: isDark ? 0.22 : 0.45,
                    ),
                    width: 1.0,
                  ),
                ),
                child: this,
              ),
            ),
          ),
        );
      },
    );
  }
}
