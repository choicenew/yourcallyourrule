import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

const String _kThemeModeKey = 'app_theme_mode_setting';
const String _kThemeColorKey = 'app_theme_color_setting';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    _loadFromPrefs();
    return ThemeMode.system;
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final modeString = prefs.getString(_kThemeModeKey);
      if (modeString != null) {
        switch (modeString) {
          case 'light':
            state = ThemeMode.light;
            break;
          case 'dark':
            state = ThemeMode.dark;
            break;
          case 'system':
          default:
            state = ThemeMode.system;
            break;
        }
      }
    } catch (_) {}
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kThemeModeKey, mode.name);
    } catch (_) {}
  }
}

@riverpod
class ThemeColorNotifier extends _$ThemeColorNotifier {
  static const Color defaultColor = Color(0xFFFF9100);

  @override
  Color build() {
    _loadFromPrefs();
    return defaultColor;
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final colorVal = prefs.getInt(_kThemeColorKey);
      if (colorVal != null) {
        state = Color(colorVal);
      }
    } catch (_) {}
  }

  Future<void> setThemeColor(Color color) async {
    state = color;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_kThemeColorKey, color.toARGB32());
    } catch (_) {}
  }
}
