import 'package:flutter/foundation.dart';
import 'package:pyro_theme_protocol/pyro_theme_protocol.dart';

/// Central state manager for Theme and Design System.
class ThemeHub extends ChangeNotifier {
  static final ThemeHub _instance = ThemeHub._internal();
  static ThemeHub get instance => _instance;

  ThemeHub._internal();

  ThemeModeType _themeMode = ThemeModeType.system;
  ThemeModeType get themeMode => _themeMode;

  ThemePaletteEntity _palette = ThemePaletteEntity.defaultBlue;
  ThemePaletteEntity get palette => _palette;

  void setThemeMode(ThemeModeType mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  void setPalette(ThemePaletteEntity palette) {
    _palette = palette;
    notifyListeners();
  }
}
