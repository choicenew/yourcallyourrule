import 'package:material_ui/material_ui.dart';
import 'package:pyro_theme/pyro_theme.dart';

/// 全 App 通用的液态玻璃拟态 (Liquid Glassmorphic Card) 包装卡片
/// 去除多重 BackdropFilter GPU 渲染管线死锁，确保 ListView 极速顺滑
class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glassExt = theme.extension<GlassmorphicThemeExtension>() ?? GlassmorphicThemeExtension.light;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: isDark
              ? Colors.black.withValues(alpha: (glassExt.opacity * 0.95).clamp(0.55, 0.90))
              : Colors.white.withValues(alpha: (glassExt.opacity * 1.05).clamp(0.65, 0.95)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: Colors.white.withValues(
                alpha: isDark ? 0.22 : 0.50,
              ),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(4),
            child: child,
          ),
        ),
      ),
    );
  }
}
