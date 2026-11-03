import 'package:flutter/material.dart';

/// App theme mode setting.
enum ThemeModeType {
  system,
  light,
  dark;

  ThemeMode toFlutterThemeMode() {
    switch (this) {
      case ThemeModeType.light:
        return ThemeMode.light;
      case ThemeModeType.dark:
        return ThemeMode.dark;
      case ThemeModeType.system:
      default:
        return ThemeMode.system;
    }
  }
}
