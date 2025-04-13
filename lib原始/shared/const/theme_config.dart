// theme_config.dart

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
// 如果需要使用 Google Fonts，请取消注释以下行并导入 google_fonts 包
// import 'package:google_fonts/google_fonts.dart';

// 亮色主题配置
ThemeData lightTheme = FlexThemeData.light(
  colors: const FlexSchemeColor(
    primary: Color(0xff0bd774),
    primaryContainer: Color(0xffff8da8),
    secondary: Color(0xff4facea),
    secondaryContainer: Color(0xff56e251),
    tertiary: Color(0xff39656d),
    tertiaryContainer: Color(0xffbeeaf5),
    appBarColor: Color(0xff56e251),
    error: Color(0xffb00020),
  ),
  colorScheme: flexSchemeLight, // 直接使用 flexSchemeLight 
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    blendOnColors: false,
    useTextTheme: true,
    switchSchemeColor: SchemeColor.primary,
    inputDecoratorRadius: 36.0,
    inputCursorSchemeColor: SchemeColor.secondaryContainer,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    useInputDecoratorThemeInDialogs: true,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
    keepPrimary: true,
    keepSecondary: true,
    keepPrimaryContainer: true,
    keepSecondaryContainer: true,
  ),
  tones: FlexTones.material(Brightness.light).onSurfacesUseBW(),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);

// Light and dark ColorSchemes made by FlexColorScheme v7.3.1.
// These ColorScheme objects require Flutter 3.7 or later.
// Light and dark ColorSchemes made by FlexColorScheme v7.3.1.
// These ColorScheme objects require Flutter 3.7 or later.
const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff0bd774),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xffff8da8),
  onPrimaryContainer: Color(0xff000000),
  secondary: Color(0xff4facea),
  onSecondary: Color(0xff000000),
  secondaryContainer: Color(0xff56e251),
  onSecondaryContainer: Color(0xff000000),
  tertiary: Color(0xff39656d),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffbdeaf3),
  onTertiaryContainer: Color(0xff001f24),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfffbfdf7),
  onSurface: Color(0xff000000),
  surfaceContainerHighest: Color(0xffdde5da),
  onSurfaceVariant: Color(0xff000000),
  outline: Color(0xff717971),
  outlineVariant: Color(0xffc1c9bf),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2e312e),
  onInverseSurface: Color(0xffffffff),
  inversePrimary: Color(0xff2ae37e),
  surfaceTint: Color(0xff006d37),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffa1c9ff),
  onPrimary: Color(0xff00325a),
  primaryContainer: Color(0xff00487f),
  onPrimaryContainer: Color(0xffd2e4ff),
  secondary: Color(0xffe7bdb0),
  onSecondary: Color(0xff442a21),
  secondaryContainer: Color(0xff5d4036),
  onSecondaryContainer: Color(0xffffdbd0),
  tertiary: Color(0xffa1ced7),
  onTertiary: Color(0xff00363e),
  tertiaryContainer: Color(0xff204d55),
  onTertiaryContainer: Color(0xffbdeaf4),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffb4ab),
  background: Color(0xff1a1c1e),
  onBackground: Color(0xffe3e2e6),
  surface: Color(0xff1a1c1e),
  onSurface: Color(0xffe3e2e6),
  surfaceVariant: Color(0xff43474e),
  onSurfaceVariant: Color(0xffc3c6cf),
  outline: Color(0xff8d9199),
  outlineVariant: Color(0xff43474e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe3e2e6),
  onInverseSurface: Color(0xff2f3033),
  inversePrimary: Color(0xff0e61a4),
  surfaceTint: Color(0xffa1c9ff),
);



// 暗色主题配置
ThemeData darkTheme = FlexThemeData.dark(
  colors: const FlexSchemeColor(
    primary: Color(0xff9fc9ff),
    primaryContainer: Color(0xff00325b),
    secondary: Color(0xffffb59d),
    secondaryContainer: Color(0xff872100),
    tertiary: Color(0xff86d2e1),
    tertiaryContainer: Color(0xff004e59),
    appBarColor: Color(0xff872100),
    error: Color(0xffcf6679),
  ),
  colorScheme: flexSchemeDark, // 直接使用 flexSchemeDark
  subThemesData: const FlexSubThemesData(
    interactionEffects: false,
    tintedDisabledControls: false,
    useTextTheme: true,
    switchSchemeColor: SchemeColor.primary,
    inputDecoratorRadius: 36.0,
    tooltipRadius: 4,
    tooltipSchemeColor: SchemeColor.inverseSurface,
    tooltipOpacity: 0.9,
    useInputDecoratorThemeInDialogs: true,
    snackBarElevation: 6,
    snackBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedLabel: false,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationBarMutedUnselectedIcon: false,
    navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationBarIndicatorOpacity: 1.00,
    navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedLabel: false,
    navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
    navigationRailMutedUnselectedIcon: false,
    navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.none,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);


// 根据 ThemeMode 返回相应的主题
ThemeData getTheme(ThemeMode themeMode) {
  if (themeMode == ThemeMode.light) {
    return lightTheme;
  } else if (themeMode == ThemeMode.dark) {
    return darkTheme;
  } else {
    // 使用系统主题时，默认为亮色主题
    return lightTheme; 
  }
}