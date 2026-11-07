import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

/// 1:1 结合 Flutter 原生 [ThemeData] 与 [FlexColorScheme]、[DynamicColor] 的高级设计令牌
/// 全量支持零侵入组件主题化 (CardTheme / DialogTheme / BottomSheetTheme 全局广播)
abstract final class PaletteTokens {
  // 核心品牌多巴胺蜜桃粉点缀色
  static const Color dopaminePeach = Color(0xFFFF7B6B);

  // 全量 FlexScheme 顶级 preset 清单
  static const List<FlexScheme> allPresets = FlexScheme.values;

  // 默认预设
  static const FlexScheme defaultScheme = FlexScheme.sakura;
  static const FlexScheme darkScheme = FlexScheme.mandyRed;

  /// 1. 基于 [FlexColorScheme.light] 构建亮色主题
  /// 优先级排序：自定义 Seed/Colors > 动态壁纸取色 (useDynamicColor == true) > FlexScheme 预设
  static ThemeData getSunlightTheme({
    FlexScheme scheme = defaultScheme,
    FlexSchemeColor? customColors,
    Color? seedColor,
    ColorScheme? dynamicLightScheme,
    bool useDynamicColor = true,
    bool swapColors = false,
    bool isHighContrast = false,
    double glassBlur = 20.0,
    double glassOpacity = 0.15,
    FlexSubThemesData? subThemesData,
    FlexKeyColors? keyColors,
    String? fontFamily,
  }) {
    final effectiveSubThemes = subThemesData ??
        const FlexSubThemesData(
          blendOnLevel: 10,
          useMaterial3Typography: true,
          alignedDropdown: true,
          inputDecoratorRadius: 14.0,
          cardRadius: 16.0,
          dialogRadius: 20.0,
        );

    final effectiveKeyColors = keyColors ??
        const FlexKeyColors(
          useKeyColors: true,
          useTertiary: true,
        );

    final glassExtension = GlassmorphicThemeExtension(
      blur: glassBlur,
      opacity: glassOpacity,
      borderColor: const Color(0x33FFFFFF),
      borderRadius: 16.0,
    );

    final designExtension = DesignTokensThemeExtension.light.copyWith(
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
    );

    ThemeData rawTheme;

    // 1. 优先使用用户明确选定的自定义 Seed/Colors 品牌调色板
    if (customColors != null) {
      rawTheme = (FlexColorScheme.light(
        colors: customColors,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (seedColor != null) {
      rawTheme = (FlexColorScheme.light(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ) as dynamic,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (useDynamicColor && dynamicLightScheme != null) {
      // 2. 其次使用 Android 12+ 原生壁纸 Dynamic Color 调色板
      rawTheme = (FlexColorScheme.light(
        colorScheme: dynamicLightScheme as dynamic,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (isHighContrast) {
      // 3. 高对比度模式支持
      rawTheme = (FlexColorScheme.light(
        scheme: scheme,
        swapColors: swapColors,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 0,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes.copyWith(blendOnLevel: 0),
      ).toTheme) as dynamic;
    } else {
      // 4. 默认美学预设 FlexScheme
      rawTheme = (FlexColorScheme.light(
        scheme: scheme,
        swapColors: swapColors,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    }

    final themedWithExtensions = rawTheme.copyWith(
      extensions: [glassExtension, designExtension],
    );

    return _applyGlassmorphicComponentThemes(
      themedWithExtensions,
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
      isDark: false,
    );
  }

  /// 2. 基于 [FlexColorScheme.dark] 构建暗色主题
  static ThemeData getMidnightTheme({
    FlexScheme scheme = darkScheme,
    FlexSchemeColor? customColors,
    Color? seedColor,
    ColorScheme? dynamicDarkScheme,
    bool useDynamicColor = true,
    bool swapColors = false,
    bool isHighContrast = false,
    double glassBlur = 25.0,
    double glassOpacity = 0.25,
    FlexSubThemesData? subThemesData,
    FlexKeyColors? keyColors,
    String? fontFamily,
  }) {
    final effectiveSubThemes = subThemesData ??
        const FlexSubThemesData(
          blendOnLevel: 20,
          useMaterial3Typography: true,
          alignedDropdown: true,
          inputDecoratorRadius: 14.0,
          cardRadius: 16.0,
          dialogRadius: 20.0,
        );

    final effectiveKeyColors = keyColors ??
        const FlexKeyColors(
          useKeyColors: true,
          useTertiary: true,
        );

    final glassExtension = GlassmorphicThemeExtension(
      blur: glassBlur,
      opacity: glassOpacity,
      borderColor: const Color(0x22FFFFFF),
      borderRadius: 16.0,
    );

    final designExtension = DesignTokensThemeExtension.dark.copyWith(
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
    );

    ThemeData rawTheme;

    if (customColors != null) {
      rawTheme = (FlexColorScheme.dark(
        colors: customColors,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (seedColor != null) {
      rawTheme = (FlexColorScheme.dark(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ) as dynamic,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (useDynamicColor && dynamicDarkScheme != null) {
      rawTheme = (FlexColorScheme.dark(
        colorScheme: dynamicDarkScheme as dynamic,
        swapColors: swapColors,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    } else if (isHighContrast) {
      rawTheme = (FlexColorScheme.dark(
        scheme: scheme,
        swapColors: swapColors,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 0,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes.copyWith(blendOnLevel: 0),
      ).toTheme) as dynamic;
    } else {
      rawTheme = (FlexColorScheme.dark(
        scheme: scheme,
        swapColors: swapColors,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        fontFamily: fontFamily,
        keyColors: effectiveKeyColors,
        subThemesData: effectiveSubThemes,
      ).toTheme) as dynamic;
    }

    final themedWithExtensions = rawTheme.copyWith(
      extensions: [glassExtension, designExtension],
    );

    return _applyGlassmorphicComponentThemes(
      themedWithExtensions,
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
      isDark: true,
    );
  }

  /// 3. 硬核纯黑 [True Black OLED] 暗黑模式 (#000000)
  static ThemeData getOledTrueBlackTheme({
    FlexScheme scheme = darkScheme,
    FlexSchemeColor? customColors,
    Color? seedColor,
    ColorScheme? dynamicDarkScheme,
    bool useDynamicColor = true,
    bool isHighContrast = false,
    double glassBlur = 25.0,
    double glassOpacity = 0.25,
    FlexSubThemesData? subThemesData,
    FlexKeyColors? keyColors,
    String? fontFamily,
  }) {
    final theme = getMidnightTheme(
      scheme: scheme,
      customColors: customColors,
      seedColor: seedColor,
      dynamicDarkScheme: dynamicDarkScheme,
      useDynamicColor: useDynamicColor,
      isHighContrast: isHighContrast,
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
      subThemesData: subThemesData,
      keyColors: keyColors,
      fontFamily: fontFamily,
    );
    return theme.copyWith(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: theme.colorScheme.copyWith(
        surface: Colors.black,
        surfaceContainerLow: const Color(0xFF09090B),
      ),
    );
  }

  /// TODO(pyro_theme): 全局液态高斯玻璃 (Liquid Glassmorphism) 主题劫持后续完善规划
  /// 1. [视觉阻尼微调]: 优化不同 FlexScheme 预设下亮暗模式的透明度阻尼 (0.75 ~ 0.85)，进一步提升复杂背景下的文字可读性。
  /// 2. [硬件离屏保护]: 对老旧/低配 Android 设备增加 Shader 采样降级防抖，确保百页大列表滚动保持 60fps。
  /// 4. 零侵入式 Component Themeing（CardTheme / DialogTheme / BottomSheetTheme 全局强控制）
  static ThemeData _applyGlassmorphicComponentThemes(
    ThemeData baseTheme, {
    required double glassBlur,
    required double glassOpacity,
    required bool isDark,
  }) {
    final colorScheme = baseTheme.colorScheme;

    final glassFillColor = isDark
        ? Colors.black.withValues(alpha: (glassOpacity * 0.95).clamp(0.55, 0.90))
        : Colors.white.withValues(alpha: (glassOpacity * 1.05).clamp(0.65, 0.95));

    final glassBorderColor = Colors.white.withValues(
      alpha: isDark ? 0.25 : 0.50,
    );

    return baseTheme.copyWith(
      cardTheme: baseTheme.cardTheme.copyWith(
        color: glassFillColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: glassBorderColor, width: 1.0),
        ),
      ),
      dialogTheme: baseTheme.dialogTheme.copyWith(
        backgroundColor: isDark
            ? Colors.black.withValues(alpha: (glassOpacity * 1.1).clamp(0.75, 0.95))
            : Colors.white.withValues(alpha: (glassOpacity * 1.15).clamp(0.80, 0.96)),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: glassBorderColor, width: 1.0),
        ),
      ),
      bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
        backgroundColor: isDark
            ? Colors.black.withValues(alpha: (glassOpacity * 1.15).clamp(0.80, 0.95))
            : Colors.white.withValues(alpha: (glassOpacity * 1.2).clamp(0.85, 0.98)),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          side: BorderSide(color: glassBorderColor, width: 1.0),
        ),
      ),
      navigationBarTheme: baseTheme.navigationBarTheme.copyWith(
        backgroundColor: colorScheme.surface.withValues(alpha: isDark ? 0.72 : 0.82),
        elevation: 0,
      ),
    );
  }

  /// 5. 原生沉浸式状态栏与导航栏 Overlay 样式推导
  static SystemUiOverlayStyle getSystemOverlayStyle(Brightness brightness) {
    return brightness == Brightness.dark
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
          );
  }
}

/// 标准原生 [ThemeExtension] 实现玻璃拟态 (Glassmorphism) 主题扩展
class GlassmorphicThemeExtension
    extends ThemeExtension<GlassmorphicThemeExtension> {
  final double blur;
  final double opacity;
  final Color borderColor;
  final double borderRadius;

  const GlassmorphicThemeExtension({
    required this.blur,
    required this.opacity,
    required this.borderColor,
    required this.borderRadius,
  });

  static const GlassmorphicThemeExtension light = GlassmorphicThemeExtension(
    blur: 20.0,
    opacity: 0.15,
    borderColor: Color(0x33FFFFFF),
    borderRadius: 16.0,
  );

  static const GlassmorphicThemeExtension dark = GlassmorphicThemeExtension(
    blur: 25.0,
    opacity: 0.25,
    borderColor: Color(0x22FFFFFF),
    borderRadius: 16.0,
  );

  @override
  GlassmorphicThemeExtension copyWith({
    double? blur,
    double? opacity,
    Color? borderColor,
    double? borderRadius,
  }) {
    return GlassmorphicThemeExtension(
      blur: blur ?? this.blur,
      opacity: opacity ?? this.opacity,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  GlassmorphicThemeExtension lerp(
    ThemeExtension<GlassmorphicThemeExtension>? other,
    double t,
  ) {
    if (other is! GlassmorphicThemeExtension) return this;
    return GlassmorphicThemeExtension(
      blur: lerpDouble(blur, other.blur, t) ?? blur,
      opacity: lerpDouble(opacity, other.opacity, t) ?? opacity,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
    );
  }

  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}

/// 全量硬核设计令牌 (Design Tokens) 主题扩展
class DesignTokensThemeExtension
    extends ThemeExtension<DesignTokensThemeExtension> {
  final double spacingXs;
  final double spacingSm;
  final double spacingMd;
  final double spacingLg;
  final double spacingXl;
  final double spacingXxl;

  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;

  final Duration durationFast;
  final Duration durationNormal;
  final Duration durationSlow;

  final Curve curveDefault;

  final double glassBlur;
  final double glassOpacity;
  final Color glassBorderColor;

  const DesignTokensThemeExtension({
    this.spacingXs = 4.0,
    this.spacingSm = 8.0,
    this.spacingMd = 16.0,
    this.spacingLg = 24.0,
    this.spacingXl = 32.0,
    this.spacingXxl = 48.0,
    this.radiusSm = 8.0,
    this.radiusMd = 14.0,
    this.radiusLg = 20.0,
    this.radiusXl = 28.0,
    this.durationFast = const Duration(milliseconds: 150),
    this.durationNormal = const Duration(milliseconds: 300),
    this.durationSlow = const Duration(milliseconds: 500),
    this.curveDefault = Curves.fastOutSlowIn,
    this.glassBlur = 20.0,
    this.glassOpacity = 0.15,
    this.glassBorderColor = const Color(0x33FFFFFF),
  });

  static const DesignTokensThemeExtension light = DesignTokensThemeExtension(
    glassBlur: 20.0,
    glassOpacity: 0.15,
    glassBorderColor: Color(0x33FFFFFF),
  );

  static const DesignTokensThemeExtension dark = DesignTokensThemeExtension(
    glassBlur: 25.0,
    glassOpacity: 0.25,
    glassBorderColor: Color(0x22FFFFFF),
  );

  @override
  DesignTokensThemeExtension copyWith({
    double? spacingXs,
    double? spacingSm,
    double? spacingMd,
    double? spacingLg,
    double? spacingXl,
    double? spacingXxl,
    radiusSm,
    double? radiusMd,
    double? radiusLg,
    double? radiusXl,
    Duration? durationFast,
    Duration? durationNormal,
    Duration? durationSlow,
    Curve? curveDefault,
    double? glassBlur,
    double? glassOpacity,
    Color? glassBorderColor,
  }) {
    return DesignTokensThemeExtension(
      spacingXs: spacingXs ?? this.spacingXs,
      spacingSm: spacingSm ?? this.spacingSm,
      spacingMd: spacingMd ?? this.spacingMd,
      spacingLg: spacingLg ?? this.spacingLg,
      spacingXl: spacingXl ?? this.spacingXl,
      spacingXxl: spacingXxl ?? this.spacingXxl,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
      radiusXl: radiusXl ?? this.radiusXl,
      durationFast: durationFast ?? this.durationFast,
      durationNormal: durationNormal ?? this.durationNormal,
      durationSlow: durationSlow ?? this.durationSlow,
      curveDefault: curveDefault ?? this.curveDefault,
      glassBlur: glassBlur ?? this.glassBlur,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      glassBorderColor: glassBorderColor ?? this.glassBorderColor,
    );
  }

  @override
  DesignTokensThemeExtension lerp(
    ThemeExtension<DesignTokensThemeExtension>? other,
    double t,
  ) {
    if (other is! DesignTokensThemeExtension) return this;
    return DesignTokensThemeExtension(
      spacingXs: _lerpDouble(spacingXs, other.spacingXs, t),
      spacingSm: _lerpDouble(spacingSm, other.spacingSm, t),
      spacingMd: _lerpDouble(spacingMd, other.spacingMd, t),
      spacingLg: _lerpDouble(spacingLg, other.spacingLg, t),
      spacingXl: _lerpDouble(spacingXl, other.spacingXl, t),
      spacingXxl: _lerpDouble(spacingXxl, other.spacingXxl, t),
      radiusSm: _lerpDouble(radiusSm, other.radiusSm, t),
      radiusMd: _lerpDouble(radiusMd, other.radiusMd, t),
      radiusLg: _lerpDouble(radiusLg, other.radiusLg, t),
      radiusXl: _lerpDouble(radiusXl, other.radiusXl, t),
      durationFast: t < 0.5 ? durationFast : other.durationFast,
      durationNormal: t < 0.5 ? durationNormal : other.durationNormal,
      durationSlow: t < 0.5 ? durationSlow : other.durationSlow,
      curveDefault: t < 0.5 ? curveDefault : other.curveDefault,
      glassBlur: _lerpDouble(glassBlur, other.glassBlur, t),
      glassOpacity: _lerpDouble(glassOpacity, other.glassOpacity, t),
      glassBorderColor:
          Color.lerp(glassBorderColor, other.glassBorderColor, t) ??
              glassBorderColor,
    );
  }

  static double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}
