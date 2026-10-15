import 'package:flutter/material.dart';

/// Flutter 官方标准 `ThemeExtension` 实现的多巴胺主题配置
/// 
/// 封闭定义于 `lib/theme/` 内部。全工程通过 `context.dopamineTheme` 或静态 Token 快捷访问。
/// 彻底解决底层库与全工程 UI 组件对多巴胺色彩 Token 的无缝支持，0 编译错误。
class DopamineThemeExtension extends ThemeExtension<DopamineThemeExtension> {
  // --- 核心多巴胺色彩 Token 静态定义 ---
  static const Color warmSunAmberValue = Color(0xFFFFB300);
  static const Color vibrantCoralValue = Color(0xFFFF6E6A);
  static const Color freshMintValue = Color(0xFF00E676);
  static const Color sunsetTangerineValue = Color(0xFFFF9100);
  static const Color softLilacValue = Color(0xFFBA68C8);
  static const Color skyAzureValue = Color(0xFF29B6F6);

  static const Color textPrimaryValue = Color(0xFF0F172A);
  static const Color textSecondaryValue = Color(0xFF64748B);
  static const Color textMutedValue = Color(0xFF94A3B8);
  static const Color textBodyValue = Color(0xFF334155);

  static const Color warmCanvasBackgroundValue = Color(0xFFFBF9F5);
  static const Color cardSurfaceValue = Colors.white;
  static const Color slateSurfaceValue = Color(0xFFF8FAFC);
  static const Color slateSubtleValue = Color(0xFFF1F5F9);
  static const Color slateBorderValue = Color(0xFFE2E8F0);
  static const Color slateMediumBorderValue = Color(0xFFCBD5E1);

  static const Color redBadgeBgValue = Color(0xFFFEF2F2);
  static const Color redIconValue = Color(0xFFEF4444);
  static const Color amberBadgeBgValue = Color(0xFFFFFBEB);
  static const Color amberIconValue = Color(0xFFD97706);
  static const Color amberBorderValue = Color(0xFFF59E0B);

  // --- 静态常量别名 ---
  static const Color warmSunAmber = warmSunAmberValue;
  static const Color vibrantCoral = vibrantCoralValue;
  static const Color freshMint = freshMintValue;
  static const Color sunsetTangerine = sunsetTangerineValue;
  static const Color softLilac = softLilacValue;
  static const Color skyAzure = skyAzureValue;

  static const Color textPrimary = textPrimaryValue;
  static const Color textSecondary = textSecondaryValue;
  static const Color textMuted = textMutedValue;
  static const Color textBody = textBodyValue;

  static const Color warmCanvasBackground = warmCanvasBackgroundValue;
  static const Color cardSurface = cardSurfaceValue;
  static const Color slateSurface = slateSurfaceValue;
  static const Color slateSubtle = slateSubtleValue;
  static const Color slateBorder = slateBorderValue;
  static const Color slateMediumBorder = slateMediumBorderValue;

  static const Color redBadgeBg = redBadgeBgValue;
  static const Color redIcon = redIconValue;
  static const Color amberBadgeBg = amberBadgeBgValue;
  static const Color amberIcon = amberIconValue;
  static const Color amberBorder = amberBorderValue;

  static const LinearGradient heroWarmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9100), Color(0xFFFFB300), Color(0xFFFFE082)],
  );

  static const LinearGradient shieldMintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2DD4BF), Color(0xFF10B981)],
  );

  static const LinearGradient coralSunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF5252), Color(0xFFFF7043), Color(0xFFFFB74D)],
  );

  static const LinearGradient lilacAzureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFAB47BC), Color(0xFF7E57C2), Color(0xFF42A5F5)],
  );

  static const LinearGradient orangeActionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF97316), Color(0xFFEA580C)],
  );

  // --- 实例属性 ---
  final Color warmSunAmberColor;
  final Color vibrantCoralColor;
  final Color freshMintColor;
  final Color sunsetTangerineColor;
  final Color softLilacColor;
  final Color skyAzureColor;

  final Color textPrimaryColor;
  final Color textSecondaryColor;
  final Color textMutedColor;
  final Color textBodyColor;

  final Color warmCanvasBackgroundColor;
  final Color cardSurfaceColor;
  final Color slateSurfaceColor;
  final Color slateSubtleColor;
  final Color slateBorderColor;
  final Color slateMediumBorderColor;

  final Color redBadgeBgColor;
  final Color redIconColor;
  final Color amberBadgeBgColor;
  final Color amberIconColor;
  final Color amberBorderColor;

  final LinearGradient heroWarmGradientStyle;
  final LinearGradient shieldMintGradientStyle;
  final LinearGradient coralSunsetGradientStyle;
  final LinearGradient lilacAzureGradientStyle;
  final LinearGradient orangeActionGradientStyle;

  const DopamineThemeExtension({
    required this.warmSunAmberColor,
    required this.vibrantCoralColor,
    required this.freshMintColor,
    required this.sunsetTangerineColor,
    required this.softLilacColor,
    required this.skyAzureColor,
    required this.textPrimaryColor,
    required this.textSecondaryColor,
    required this.textMutedColor,
    required this.textBodyColor,
    required this.warmCanvasBackgroundColor,
    required this.cardSurfaceColor,
    required this.slateSurfaceColor,
    required this.slateSubtleColor,
    required this.slateBorderColor,
    required this.slateMediumBorderColor,
    required this.redBadgeBgColor,
    required this.redIconColor,
    required this.amberBadgeBgColor,
    required this.amberIconColor,
    required this.amberBorderColor,
    required this.heroWarmGradientStyle,
    required this.shieldMintGradientStyle,
    required this.coralSunsetGradientStyle,
    required this.lilacAzureGradientStyle,
    required this.orangeActionGradientStyle,
  });

  /// 亮色默认多巴胺 ThemeExtension
  static const light = DopamineThemeExtension(
    warmSunAmberColor: warmSunAmberValue,
    vibrantCoralColor: vibrantCoralValue,
    freshMintColor: freshMintValue,
    sunsetTangerineColor: sunsetTangerineValue,
    softLilacColor: softLilacValue,
    skyAzureColor: skyAzureValue,
    textPrimaryColor: textPrimaryValue,
    textSecondaryColor: textSecondaryValue,
    textMutedColor: textMutedValue,
    textBodyColor: textBodyValue,
    warmCanvasBackgroundColor: warmCanvasBackgroundValue,
    cardSurfaceColor: cardSurfaceValue,
    slateSurfaceColor: slateSurfaceValue,
    slateSubtleColor: slateSubtleValue,
    slateBorderColor: slateBorderValue,
    slateMediumBorderColor: slateMediumBorderValue,
    redBadgeBgColor: redBadgeBgValue,
    redIconColor: redIconValue,
    amberBadgeBgColor: amberBadgeBgValue,
    amberIconColor: amberIconValue,
    amberBorderColor: amberBorderValue,
    heroWarmGradientStyle: heroWarmGradient,
    shieldMintGradientStyle: shieldMintGradient,
    coralSunsetGradientStyle: coralSunsetGradient,
    lilacAzureGradientStyle: lilacAzureGradient,
    orangeActionGradientStyle: orangeActionGradient,
  );

  /// 暗色默认多巴胺 ThemeExtension
  static const dark = DopamineThemeExtension(
    warmSunAmberColor: Color(0xFFFFC107),
    vibrantCoralColor: Color(0xFFFF8A80),
    freshMintColor: Color(0xFF69F0AE),
    sunsetTangerineColor: Color(0xFFFFAB40),
    softLilacColor: Color(0xFFE040FB),
    skyAzureColor: Color(0xFF40C4FF),
    textPrimaryColor: Color(0xFFF8FAFC),
    textSecondaryColor: Color(0xFF94A3B8),
    textMutedColor: Color(0xFF64748B),
    textBodyColor: Color(0xFFE2E8F0),
    warmCanvasBackgroundColor: Color(0xFF0F172A),
    cardSurfaceColor: Color(0xFF1E293B),
    slateSurfaceColor: Color(0xFF334155),
    slateSubtleColor: Color(0xFF475569),
    slateBorderColor: Color(0xFF334155),
    slateMediumBorderColor: Color(0xFF475569),
    redBadgeBgColor: Color(0xFF450A0A),
    redIconColor: Color(0xFFF87171),
    amberBadgeBgColor: Color(0xFF451A03),
    amberIconColor: Color(0xFFFBBF24),
    amberBorderColor: Color(0xFFF59E0B),
    heroWarmGradientStyle: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFEA580C), Color(0xFFD97706), Color(0xFFB45309)],
    ),
    shieldMintGradientStyle: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0F766E), Color(0xFF047857)],
    ),
    coralSunsetGradientStyle: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFDC2626), Color(0xFFC2410C), Color(0xFFB45309)],
    ),
    lilacAzureGradientStyle: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF7E22CE), Color(0xFF6D28D9), Color(0xFF1D4ED8)],
    ),
    orangeActionGradientStyle: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFC2410C), Color(0xFF9A3412)],
    ),
  );

  @override
  DopamineThemeExtension copyWith({
    Color? warmSunAmberColor,
    Color? vibrantCoralColor,
    Color? freshMintColor,
    Color? sunsetTangerineColor,
    Color? softLilacColor,
    Color? skyAzureColor,
    Color? textPrimaryColor,
    Color? textSecondaryColor,
    Color? textMutedColor,
    Color? textBodyColor,
    Color? warmCanvasBackgroundColor,
    Color? cardSurfaceColor,
    Color? slateSurfaceColor,
    Color? slateSubtleColor,
    Color? slateBorderColor,
    Color? slateMediumBorderColor,
    Color? redBadgeBgColor,
    Color? redIconColor,
    Color? amberBadgeBgColor,
    Color? amberIconColor,
    Color? amberBorderColor,
    LinearGradient? heroWarmGradientStyle,
    LinearGradient? shieldMintGradientStyle,
    LinearGradient? coralSunsetGradientStyle,
    LinearGradient? lilacAzureGradientStyle,
    LinearGradient? orangeActionGradientStyle,
  }) {
    return DopamineThemeExtension(
      warmSunAmberColor: warmSunAmberColor ?? this.warmSunAmberColor,
      vibrantCoralColor: vibrantCoralColor ?? this.vibrantCoralColor,
      freshMintColor: freshMintColor ?? this.freshMintColor,
      sunsetTangerineColor: sunsetTangerineColor ?? this.sunsetTangerineColor,
      softLilacColor: softLilacColor ?? this.softLilacColor,
      skyAzureColor: skyAzureColor ?? this.skyAzureColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      textSecondaryColor: textSecondaryColor ?? this.textSecondaryColor,
      textMutedColor: textMutedColor ?? this.textMutedColor,
      textBodyColor: textBodyColor ?? this.textBodyColor,
      warmCanvasBackgroundColor: warmCanvasBackgroundColor ?? this.warmCanvasBackgroundColor,
      cardSurfaceColor: cardSurfaceColor ?? this.cardSurfaceColor,
      slateSurfaceColor: slateSurfaceColor ?? this.slateSurfaceColor,
      slateSubtleColor: slateSubtleColor ?? this.slateSubtleColor,
      slateBorderColor: slateBorderColor ?? this.slateBorderColor,
      slateMediumBorderColor: slateMediumBorderColor ?? this.slateMediumBorderColor,
      redBadgeBgColor: redBadgeBgColor ?? this.redBadgeBgColor,
      redIconColor: redIconColor ?? this.redIconColor,
      amberBadgeBgColor: amberBadgeBgColor ?? this.amberBadgeBgColor,
      amberIconColor: amberIconColor ?? this.amberIconColor,
      amberBorderColor: amberBorderColor ?? this.amberBorderColor,
      heroWarmGradientStyle: heroWarmGradientStyle ?? this.heroWarmGradientStyle,
      shieldMintGradientStyle: shieldMintGradientStyle ?? this.shieldMintGradientStyle,
      coralSunsetGradientStyle: coralSunsetGradientStyle ?? this.coralSunsetGradientStyle,
      lilacAzureGradientStyle: lilacAzureGradientStyle ?? this.lilacAzureGradientStyle,
      orangeActionGradientStyle: orangeActionGradientStyle ?? this.orangeActionGradientStyle,
    );
  }

  @override
  DopamineThemeExtension lerp(
    ThemeExtension<DopamineThemeExtension>? other,
    double t,
  ) {
    if (other is! DopamineThemeExtension) return this;
    return DopamineThemeExtension(
      warmSunAmberColor: Color.lerp(warmSunAmberColor, other.warmSunAmberColor, t)!,
      vibrantCoralColor: Color.lerp(vibrantCoralColor, other.vibrantCoralColor, t)!,
      freshMintColor: Color.lerp(freshMintColor, other.freshMintColor, t)!,
      sunsetTangerineColor: Color.lerp(sunsetTangerineColor, other.sunsetTangerineColor, t)!,
      softLilacColor: Color.lerp(softLilacColor, other.softLilacColor, t)!,
      skyAzureColor: Color.lerp(skyAzureColor, other.skyAzureColor, t)!,
      textPrimaryColor: Color.lerp(textPrimaryColor, other.textPrimaryColor, t)!,
      textSecondaryColor: Color.lerp(textSecondaryColor, other.textSecondaryColor, t)!,
      textMutedColor: Color.lerp(textMutedColor, other.textMutedColor, t)!,
      textBodyColor: Color.lerp(textBodyColor, other.textBodyColor, t)!,
      warmCanvasBackgroundColor: Color.lerp(warmCanvasBackgroundColor, other.warmCanvasBackgroundColor, t)!,
      cardSurfaceColor: Color.lerp(cardSurfaceColor, other.cardSurfaceColor, t)!,
      slateSurfaceColor: Color.lerp(slateSurfaceColor, other.slateSurfaceColor, t)!,
      slateSubtleColor: Color.lerp(slateSubtleColor, other.slateSubtleColor, t)!,
      slateBorderColor: Color.lerp(slateBorderColor, other.slateBorderColor, t)!,
      slateMediumBorderColor: Color.lerp(slateMediumBorderColor, other.slateMediumBorderColor, t)!,
      redBadgeBgColor: Color.lerp(redBadgeBgColor, other.redBadgeBgColor, t)!,
      redIconColor: Color.lerp(redIconColor, other.redIconColor, t)!,
      amberBadgeBgColor: Color.lerp(amberBadgeBgColor, other.amberBadgeBgColor, t)!,
      amberIconColor: Color.lerp(amberIconColor, other.amberIconColor, t)!,
      amberBorderColor: Color.lerp(amberBorderColor, other.amberBorderColor, t)!,
      heroWarmGradientStyle: LinearGradient.lerp(heroWarmGradientStyle, other.heroWarmGradientStyle, t)!,
      shieldMintGradientStyle: LinearGradient.lerp(shieldMintGradientStyle, other.shieldMintGradientStyle, t)!,
      coralSunsetGradientStyle: LinearGradient.lerp(coralSunsetGradientStyle, other.coralSunsetGradientStyle, t)!,
      lilacAzureGradientStyle: LinearGradient.lerp(lilacAzureGradientStyle, other.lilacAzureGradientStyle, t)!,
      orangeActionGradientStyle: LinearGradient.lerp(orangeActionGradientStyle, other.orangeActionGradientStyle, t)!,
    );
  }

  // --- 辅助静态修饰器方法 ---

  static BoxDecoration cleanCardDecoration({
    required BuildContext context,
    BorderRadius? borderRadius,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: borderColor ?? Theme.of(context).colorScheme.outlineVariant,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration insetConsoleDecoration({
    required BuildContext context,
    BorderRadius? borderRadius,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: borderRadius ?? BorderRadius.circular(18),
      border: Border.all(
        color: borderColor ?? Theme.of(context).colorScheme.outlineVariant,
        width: 1.0,
      ),
    );
  }

  static BoxDecoration amberSearchBoxDecoration({
    required BuildContext context,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: amberBorder,
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: amberBorder.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration warmCardDecoration({
    required BuildContext context,
    Color? baseColor,
    Gradient? gradient,
    BorderRadius? borderRadius,
    Color? glowColor,
  }) {
    final defaultRadius = borderRadius ?? BorderRadius.circular(24);
    final accentGlow = glowColor ?? warmSunAmber;
    final surfaceColor = baseColor ?? Theme.of(context).colorScheme.surface;

    return BoxDecoration(
      color: gradient == null ? surfaceColor : null,
      gradient: gradient,
      borderRadius: defaultRadius,
      border: Border.all(
        color: accentGlow.withValues(alpha: 0.15),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accentGlow.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 6),
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

/// 官方 BuildContext 扩展方法
extension DopamineThemeX on BuildContext {
  DopamineThemeExtension get dopamineTheme =>
      Theme.of(this).extension<DopamineThemeExtension>() ??
      DopamineThemeExtension.light;
}
