import 'package:material_ui/material_ui.dart';

/// Strongly typed Material 3 Theme Palette contract.
class ThemePaletteEntity {
  final Color primary;
  final Color secondary;
  final Color surface;

  const ThemePaletteEntity({
    required this.primary,
    required this.secondary,
    required this.surface,
  });

  static const ThemePaletteEntity defaultBlue = ThemePaletteEntity(
    primary: Color(0xFF1976D2),
    secondary: Color(0xFF00897B),
    surface: Color(0xFFFAFAFA),
  );

  ThemeData buildLightData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
    );
  }

  ThemeData buildDarkData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ),
    );
  }
}
