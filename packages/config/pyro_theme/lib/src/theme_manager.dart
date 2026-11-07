import 'package:dynamic_color/dynamic_color.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_config_protocol/pyro_config_protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'palette_tokens.dart';

// --- 持久化 Key 常量与自注册 ---
abstract final class PyroThemeStorageKeys {
  static const String prefix = 'pyro_theme_';

  // 静态闭包在类首次加载时自动向 PyroConfigRegistry 注册前缀
  static final bool _autoRegistered = () {
    PyroConfigRegistry.registerPrefix(prefix);
    return true;
  }();

  static void ensureRegistered() => _autoRegistered;

  static const String themeMode = '${prefix}mode';
  static const String flexScheme = '${prefix}flex_scheme';
  static const String seedColor = '${prefix}seed_color';
  static const String isTrueBlack = '${prefix}is_true_black';
  static const String isPrimarySwapped = '${prefix}is_primary_swapped';
  static const String useDynamicColor = '${prefix}use_dynamic_color';
  static const String isHighContrast = '${prefix}is_high_contrast';
  static const String fontFamily = '${prefix}font_family';
  static const String textScaleFactor = '${prefix}text_scale_factor';
  static const String glassBlur = '${prefix}glass_blur';
  static const String glassOpacity = '${prefix}glass_opacity';
}

/// 同步加载/依赖注入 SharedPreferences 实例，消除冷启动闪烁
final sharedPreferencesProvider = Provider<SharedPreferences?>((ref) {
  return null;
});

/// 1. ThemePreference 控制器 (持久化 ThemeMode)
class ThemePreferenceNotifier extends Notifier<ThemeMode> {
  SharedPreferences? _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final index = _prefs?.getInt(PyroThemeStorageKeys.themeMode);
      if (index != null && index >= 0 && index < ThemeMode.values.length) {
        return ThemeMode.values[index];
      }
    } else {
      _initStorage();
    }
    return ThemeMode.system;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final index = _prefs?.getInt(PyroThemeStorageKeys.themeMode);
    if (index != null && index >= 0 && index < ThemeMode.values.length) {
      state = ThemeMode.values[index];
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    _prefs?.setInt(PyroThemeStorageKeys.themeMode, mode.index);
  }
}

final themePreferenceProvider =
    NotifierProvider<ThemePreferenceNotifier, ThemeMode>(ThemePreferenceNotifier.new);

/// 2. FlexScheme 预设切换控制器 (持久化 FlexScheme)
class FlexSchemeNotifier extends Notifier<FlexScheme> {
  SharedPreferences? _prefs;

  @override
  FlexScheme build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final name = _prefs?.getString(PyroThemeStorageKeys.flexScheme);
      if (name != null) {
        return FlexScheme.values.firstWhere(
          (e) => e.name == name,
          orElse: () => FlexScheme.sakura,
        );
      }
    } else {
      _initStorage();
    }
    return FlexScheme.sakura;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final name = _prefs?.getString(PyroThemeStorageKeys.flexScheme);
    if (name != null) {
      final found = FlexScheme.values.firstWhere(
        (e) => e.name == name,
        orElse: () => FlexScheme.sakura,
      );
      state = found;
    }
  }

  void setFlexScheme(FlexScheme scheme) {
    state = scheme;
    _prefs?.setString(PyroThemeStorageKeys.flexScheme, scheme.name);
  }
}

final flexSchemeProvider =
    NotifierProvider<FlexSchemeNotifier, FlexScheme>(FlexSchemeNotifier.new);

/// 3. CustomSeedColor 控制器 (持久化 Color)
class CustomSeedColorNotifier extends Notifier<Color?> {
  SharedPreferences? _prefs;

  @override
  Color? build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getInt(PyroThemeStorageKeys.seedColor);
      if (value != null) {
        return Color(value);
      }
    } else {
      _initStorage();
    }
    return null;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getInt(PyroThemeStorageKeys.seedColor);
    if (value != null) {
      state = Color(value);
    }
  }

  void setSeedColor(Color? color) {
    state = color;
    if (color == null) {
      _prefs?.remove(PyroThemeStorageKeys.seedColor);
    } else {
      _prefs?.setInt(PyroThemeStorageKeys.seedColor, color.toARGB32());
    }
  }
}

final customSeedColorProvider =
    NotifierProvider<CustomSeedColorNotifier, Color?>(CustomSeedColorNotifier.new);

/// 4. True Black OLED 开关控制器
class TrueBlackNotifier extends Notifier<bool> {
  SharedPreferences? _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getBool(PyroThemeStorageKeys.isTrueBlack);
      if (value != null) {
        return value;
      }
    } else {
      _initStorage();
    }
    return false;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getBool(PyroThemeStorageKeys.isTrueBlack);
    if (value != null) {
      state = value;
    }
  }

  void toggleTrueBlack(bool enabled) {
    state = enabled;
    _prefs?.setBool(PyroThemeStorageKeys.isTrueBlack, enabled);
  }
}

final isTrueBlackProvider =
    NotifierProvider<TrueBlackNotifier, bool>(TrueBlackNotifier.new);

/// 5. Primary Swap 主辅色颠倒控制器
class PrimarySwapNotifier extends Notifier<bool> {
  SharedPreferences? _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getBool(PyroThemeStorageKeys.isPrimarySwapped);
      if (value != null) {
        return value;
      }
    } else {
      _initStorage();
    }
    return false;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getBool(PyroThemeStorageKeys.isPrimarySwapped);
    if (value != null) {
      state = value;
    }
  }

  void togglePrimarySwap(bool enabled) {
    state = enabled;
    _prefs?.setBool(PyroThemeStorageKeys.isPrimarySwapped, enabled);
  }
}

final isPrimarySwappedProvider =
    NotifierProvider<PrimarySwapNotifier, bool>(PrimarySwapNotifier.new);

/// 6. Dynamic Color 开关控制器 (Android 12+ 原生动态取色)
class DynamicColorEnabledNotifier extends Notifier<bool> {
  SharedPreferences? _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getBool(PyroThemeStorageKeys.useDynamicColor);
      if (value != null) {
        return value;
      }
    } else {
      _initStorage();
    }
    return true;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getBool(PyroThemeStorageKeys.useDynamicColor);
    if (value != null) {
      state = value;
    }
  }

  void toggleDynamicColor(bool enabled) {
    state = enabled;
    _prefs?.setBool(PyroThemeStorageKeys.useDynamicColor, enabled);
  }
}

final useDynamicColorProvider =
    NotifierProvider<DynamicColorEnabledNotifier, bool>(DynamicColorEnabledNotifier.new);

/// 7. 高对比度 (High Contrast) 无障碍模式控制器
class HighContrastNotifier extends Notifier<bool> {
  SharedPreferences? _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getBool(PyroThemeStorageKeys.isHighContrast);
      if (value != null) {
        return value;
      }
    } else {
      _initStorage();
    }
    return false;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getBool(PyroThemeStorageKeys.isHighContrast);
    if (value != null) {
      state = value;
    }
  }

  void toggleHighContrast(bool enabled) {
    state = enabled;
    _prefs?.setBool(PyroThemeStorageKeys.isHighContrast, enabled);
  }
}

final isHighContrastProvider =
    NotifierProvider<HighContrastNotifier, bool>(HighContrastNotifier.new);

/// 8. 动态字体 (FontFamily) 控制器
class FontFamilyNotifier extends Notifier<String?> {
  SharedPreferences? _prefs;

  @override
  String? build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getString(PyroThemeStorageKeys.fontFamily);
      if (value != null && value.isNotEmpty) {
        return value;
      }
    } else {
      _initStorage();
    }
    return null;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getString(PyroThemeStorageKeys.fontFamily);
    if (value != null && value.isNotEmpty) {
      state = value;
    }
  }

  void setFontFamily(String? fontFamily) {
    state = fontFamily;
    if (fontFamily == null || fontFamily.isEmpty) {
      _prefs?.remove(PyroThemeStorageKeys.fontFamily);
    } else {
      _prefs?.setString(PyroThemeStorageKeys.fontFamily, fontFamily);
    }
  }
}

final fontFamilyProvider =
    NotifierProvider<FontFamilyNotifier, String?>(FontFamilyNotifier.new);

/// 9. 动态 TextScaleFactor 控制器
class TextScaleFactorNotifier extends Notifier<double> {
  SharedPreferences? _prefs;

  @override
  double build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getDouble(PyroThemeStorageKeys.textScaleFactor);
      if (value != null) {
        return value;
      }
    } else {
      _initStorage();
    }
    return 1.0;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getDouble(PyroThemeStorageKeys.textScaleFactor);
    if (value != null) {
      state = value;
    }
  }

  void setTextScaleFactor(double factor) {
    state = factor;
    _prefs?.setDouble(PyroThemeStorageKeys.textScaleFactor, factor);
  }
}

final textScaleFactorProvider =
    NotifierProvider<TextScaleFactorNotifier, double>(TextScaleFactorNotifier.new);

/// 10. GlassBlur 高斯模糊度 (0.0 ~ 30.0px) 控制器
class GlassBlurNotifier extends Notifier<double> {
  SharedPreferences? _prefs;

  @override
  double build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getDouble(PyroThemeStorageKeys.glassBlur);
      if (value != null) return value;
    } else {
      _initStorage();
    }
    return 20.0;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getDouble(PyroThemeStorageKeys.glassBlur);
    if (value != null) state = value;
  }

  void setBlur(double blur) {
    state = blur;
    _prefs?.setDouble(PyroThemeStorageKeys.glassBlur, blur);
  }
}

final glassBlurProvider =
    NotifierProvider<GlassBlurNotifier, double>(GlassBlurNotifier.new);

/// 11. GlassOpacity 玻璃不透明度 (0.20 ~ 0.95) 控制器
class GlassOpacityNotifier extends Notifier<double> {
  SharedPreferences? _prefs;

  @override
  double build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    if (_prefs != null) {
      final value = _prefs?.getDouble(PyroThemeStorageKeys.glassOpacity);
      if (value != null) return value;
    } else {
      _initStorage();
    }
    return 0.70;
  }

  Future<void> _initStorage() async {
    _prefs = await SharedPreferences.getInstance();
    final value = _prefs?.getDouble(PyroThemeStorageKeys.glassOpacity);
    if (value != null) state = value;
  }

  void setOpacity(double opacity) {
    state = opacity;
    _prefs?.setDouble(PyroThemeStorageKeys.glassOpacity, opacity);
  }
}

final glassOpacityProvider =
    NotifierProvider<GlassOpacityNotifier, double>(GlassOpacityNotifier.new);

/// 12. 自定义品牌 scheme (FlexSchemeColor) 注册与设置
class CustomFlexSchemeColorNotifier extends Notifier<FlexSchemeColor?> {
  @override
  FlexSchemeColor? build() => null;

  void setCustomSchemeColors(FlexSchemeColor? colors) {
    state = colors;
  }
}

final customFlexSchemeColorProvider = NotifierProvider<
    CustomFlexSchemeColorNotifier,
    FlexSchemeColor?>(CustomFlexSchemeColorNotifier.new);

/// 存储从原生 OS 提取的 Dynamic Color 调色板
class SystemDynamicColorSchemeNotifier extends Notifier<({ColorScheme? light, ColorScheme? dark})> {
  @override
  ({ColorScheme? light, ColorScheme? dark}) build() {
    return (light: null, dark: null);
  }

  void setDynamicSchemes(ColorScheme? light, ColorScheme? dark) {
    state = (light: light, dark: dark);
  }
}

final systemDynamicColorSchemeProvider = NotifierProvider<
    SystemDynamicColorSchemeNotifier,
    ({ColorScheme? light, ColorScheme? dark})>(SystemDynamicColorSchemeNotifier.new);

/// 响应式计算亮色 ThemeData
final lightThemeProvider = Provider<ThemeData>((ref) {
  final flexScheme = ref.watch(flexSchemeProvider);
  final customColors = ref.watch(customFlexSchemeColorProvider);
  final customSeed = ref.watch(customSeedColorProvider);
  final isSwapped = ref.watch(isPrimarySwappedProvider);
  final isHighContrast = ref.watch(isHighContrastProvider);
  final fontFamily = ref.watch(fontFamilyProvider);
  final useDynamic = ref.watch(useDynamicColorProvider);
  final dynamicSchemes = ref.watch(systemDynamicColorSchemeProvider);
  final glassBlur = ref.watch(glassBlurProvider);
  final glassOpacity = ref.watch(glassOpacityProvider);

  return PaletteTokens.getSunlightTheme(
    scheme: flexScheme,
    customColors: customColors,
    seedColor: customSeed,
    dynamicLightScheme: dynamicSchemes.light,
    useDynamicColor: useDynamic,
    swapColors: isSwapped,
    isHighContrast: isHighContrast,
    glassBlur: glassBlur,
    glassOpacity: glassOpacity,
    fontFamily: fontFamily,
  );
});

/// 响应式计算暗色 ThemeData
final darkThemeProvider = Provider<ThemeData>((ref) {
  final flexScheme = ref.watch(flexSchemeProvider);
  final customColors = ref.watch(customFlexSchemeColorProvider);
  final customSeed = ref.watch(customSeedColorProvider);
  final isTrueBlack = ref.watch(isTrueBlackProvider);
  final isSwapped = ref.watch(isPrimarySwappedProvider);
  final isHighContrast = ref.watch(isHighContrastProvider);
  final fontFamily = ref.watch(fontFamilyProvider);
  final useDynamic = ref.watch(useDynamicColorProvider);
  final dynamicSchemes = ref.watch(systemDynamicColorSchemeProvider);
  final glassBlur = ref.watch(glassBlurProvider);
  final glassOpacity = ref.watch(glassOpacityProvider);

  if (isTrueBlack) {
    return PaletteTokens.getOledTrueBlackTheme(
      scheme: flexScheme,
      customColors: customColors,
      seedColor: customSeed,
      dynamicDarkScheme: dynamicSchemes.dark,
      useDynamicColor: useDynamic,
      isHighContrast: isHighContrast,
      glassBlur: glassBlur,
      glassOpacity: glassOpacity,
      fontFamily: fontFamily,
    );
  }

  return PaletteTokens.getMidnightTheme(
    scheme: flexScheme,
    customColors: customColors,
    seedColor: customSeed,
    dynamicDarkScheme: dynamicSchemes.dark,
    useDynamicColor: useDynamic,
    swapColors: isSwapped,
    isHighContrast: isHighContrast,
    glassBlur: glassBlur,
    glassOpacity: glassOpacity,
    fontFamily: fontFamily,
  );
});

/// 单行无侵入式液态高斯玻璃背景作用域 (Zero-Invasive Liquid Glass Theme Scope)
class LiquidGlassThemeScope extends ConsumerWidget {
  final Widget child;

  const LiquidGlassThemeScope({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.scaffoldBackgroundColor,
            colorScheme.primaryContainer.withValues(alpha: isDark ? 0.15 : 0.28),
            colorScheme.secondaryContainer.withValues(alpha: isDark ? 0.10 : 0.20),
            theme.scaffoldBackgroundColor,
          ],
        ),
      ),
      child: child,
    );
  }
}

/// 一键接入 Android 12+ [DynamicColorBuilder] 的顶层包装 Widget
class DynamicThemeScope extends ConsumerWidget {
  final Widget Function(
    BuildContext context,
    ThemeData lightTheme,
    ThemeData darkTheme,
    ThemeMode themeMode,
  ) builder;

  const DynamicThemeScope({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themePreferenceProvider);

    return DynamicColorBuilder(
      builder: (dynamic lightDynamic, dynamic darkDynamic) {
        // 同步系统取色方案给 Provider
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(systemDynamicColorSchemeProvider.notifier)
              .setDynamicSchemes(lightDynamic, darkDynamic);
        });

        final lightTheme = ref.watch(lightThemeProvider);
        final darkTheme = ref.watch(darkThemeProvider);

        return builder(context, lightTheme, darkTheme, themeMode);
      },
    );
  }
}

/// 支持平滑过渡主题切换的 AnimatedTheme 作用域
class AnimatedThemeScope extends ConsumerWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedThemeScope({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themePreferenceProvider);
    final lightTheme = ref.watch(lightThemeProvider);
    final darkTheme = ref.watch(darkThemeProvider);

    final systemBrightness = MediaQuery.platformBrightnessOf(context);
    final isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && systemBrightness == Brightness.dark);

    final currentTheme = isDark ? darkTheme : lightTheme;

    return AnimatedTheme(
      data: currentTheme,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
