import 'package:flutter/material.dart';
import 'package:yourcallyourrule/theme/dopamine_theme_extension.dart';

/// App 全局主题控制配置（主题包内部闭环整合，单一事实源：DopamineThemeExtension）
class AppTheme {
  AppTheme._();

  /// 构建亮色主题
  static ThemeData buildLightTheme({Color? seedColor}) {
    const dopamine = DopamineThemeExtension.light;
    final primarySeed = seedColor ?? dopamine.sunsetTangerineColor;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: dopamine.warmCanvasBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeed,
        brightness: Brightness.light,
        primary: primarySeed,
        secondary: dopamine.softLilacColor,
        tertiary: dopamine.freshMintColor,
        error: dopamine.redIconColor,
        surface: dopamine.cardSurfaceColor,
        onSurface: dopamine.textPrimaryColor,
        onSurfaceVariant: dopamine.textSecondaryColor,
        outline: dopamine.slateBorderColor,
        outlineVariant: dopamine.slateMediumBorderColor,
        surfaceContainerHighest: dopamine.slateSubtleColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: dopamine.warmCanvasBackgroundColor,
        foregroundColor: dopamine.textPrimaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dopamine.cardSurfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      cardTheme: CardThemeData(
        color: dopamine.cardSurfaceColor,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: dopamine.slateBorderColor, width: 1.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const [dopamine],
    );
  }

  /// 构建暗色主题
  static ThemeData buildDarkTheme({Color? seedColor}) {
    const dopamine = DopamineThemeExtension.dark;
    final primarySeed = seedColor ?? dopamine.sunsetTangerineColor;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dopamine.warmCanvasBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeed,
        brightness: Brightness.dark,
        primary: primarySeed,
        secondary: dopamine.softLilacColor,
        tertiary: dopamine.freshMintColor,
        error: dopamine.redIconColor,
        surface: dopamine.cardSurfaceColor,
        onSurface: dopamine.textPrimaryColor,
        onSurfaceVariant: dopamine.textSecondaryColor,
        outline: dopamine.slateBorderColor,
        outlineVariant: dopamine.slateMediumBorderColor,
        surfaceContainerHighest: dopamine.slateSubtleColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: dopamine.warmCanvasBackgroundColor,
        foregroundColor: dopamine.textPrimaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dopamine.cardSurfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      cardTheme: CardThemeData(
        color: dopamine.cardSurfaceColor,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: dopamine.slateBorderColor, width: 1.0),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      extensions: const [dopamine],
    );
  }

  /// 向后兼容静态属性
  static final ThemeData lightTheme = buildLightTheme();
  static final ThemeData darkTheme = buildDarkTheme();
}
