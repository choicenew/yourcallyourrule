import 'package:flutter/material.dart';

/// App 全局主题控制配置（封闭于 lib/theme/ 内部，使用纯粹原生 ThemeData）
class AppTheme {
  AppTheme._();

  static const Color _lightCanvasBackground = Color(0xFFFBF9F5);
  static const Color _darkCanvasBackground = Color(0xFF0F172A);

  static const Color _lightCardSurface = Colors.white;
  static const Color _darkCardSurface = Color(0xFF1E293B);

  static const Color _lightPrimaryText = Color(0xFF0F172A);
  static const Color _darkPrimaryText = Color(0xFFF8FAFC);

  /// 构建亮色主题
  static ThemeData buildLightTheme({Color? seedColor}) {
    final primarySeed = seedColor ?? const Color(0xFFFF9100);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightCanvasBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeed,
        brightness: Brightness.light,
        surface: _lightCardSurface,
        onSurface: _lightPrimaryText,
        surfaceContainerHighest: const Color(0xFFF1F5F9),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightCanvasBackground,
        foregroundColor: _lightPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: _lightCardSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      cardTheme: CardThemeData(
        color: _lightCardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// 构建暗色主题
  static ThemeData buildDarkTheme({Color? seedColor}) {
    final primarySeed = seedColor ?? const Color(0xFFFF9100);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkCanvasBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeed,
        brightness: Brightness.dark,
        surface: _darkCardSurface,
        onSurface: _darkPrimaryText,
        surfaceContainerHighest: const Color(0xFF334155),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkCanvasBackground,
        foregroundColor: _darkPrimaryText,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: _darkCardSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      cardTheme: CardThemeData(
        color: _darkCardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// 向后兼容静态属性
  static final ThemeData lightTheme = buildLightTheme();
  static final ThemeData darkTheme = buildDarkTheme();
}
