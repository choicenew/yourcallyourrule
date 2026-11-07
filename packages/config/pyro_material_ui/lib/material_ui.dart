library material_ui;

import 'dart:ui';
import 'package:material_ui/material_ui.dart' as m3;
import 'package:material_ui/material_ui.dart' hide Card;
import 'package:pyro_theme/pyro_theme.dart';

export 'package:flutter/material.dart' hide Card;

/// 无感替换官方 [Card]，底层使用 [m3.Card] 组合液态高斯玻璃拟态 (Liquid Glassmorphism)
class Card extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final bool borderOnForeground;
  final EdgeInsetsGeometry? margin;
  final Clip? clipBehavior;
  final bool semanticContainer;
  final bool enableGlass;

  const Card({
    super.key,
    this.child,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
    this.enableGlass = true,
  });

  const Card.filled({
    super.key,
    this.child,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
    this.enableGlass = true,
  });

  const Card.outlined({
    super.key,
    this.child,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.semanticContainer = true,
    this.enableGlass = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final glassExt = theme.extension<GlassmorphicThemeExtension>() ?? GlassmorphicThemeExtension.light;

    final effectiveRadius = shape is RoundedRectangleBorder
        ? (shape as RoundedRectangleBorder).borderRadius
        : BorderRadius.circular(16.0);

    final m3Card = m3.Card(
      color: color ?? Colors.transparent,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation ?? 0,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: effectiveRadius,
            side: BorderSide(
              color: Colors.white.withValues(alpha: isDark ? 0.22 : 0.45),
              width: 1.0,
            ),
          ),
      borderOnForeground: borderOnForeground,
      margin: EdgeInsets.zero,
      clipBehavior: clipBehavior ?? Clip.antiAlias,
      semanticContainer: semanticContainer,
      child: child,
    );

    if (!enableGlass) {
      return Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
        child: m3Card,
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: effectiveRadius.resolve(Directionality.maybeOf(context)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glassExt.blur, sigmaY: glassExt.blur),
          child: Material(
            color: isDark
                ? Colors.black.withValues(alpha: (glassExt.opacity * 1.1).clamp(0.08, 0.45))
                : Colors.white.withValues(alpha: (glassExt.opacity * 1.4).clamp(0.12, 0.65)),
            shape: RoundedRectangleBorder(
              borderRadius: effectiveRadius,
              side: BorderSide(
                color: Colors.white.withValues(alpha: isDark ? 0.22 : 0.45),
                width: 1.0,
              ),
            ),
            child: m3Card,
          ),
        ),
      ),
    );
  }
}
