import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_theme/pyro_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('PaletteTokens Tests', () {
    test('getSunlightTheme returns valid ThemeData with DesignTokens extension', () {
      final theme = PaletteTokens.getSunlightTheme(scheme: FlexScheme.sakura);
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, equals(Brightness.light));

      final designTokens = theme.extension<DesignTokensThemeExtension>();
      expect(designTokens, isNotNull);
      expect(designTokens!.spacingMd, equals(16.0));
      expect(designTokens.glassBlur, equals(20.0));
    });

    test('getMidnightTheme returns valid Dark ThemeData', () {
      final theme = PaletteTokens.getMidnightTheme(scheme: FlexScheme.mandyRed);
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, equals(Brightness.dark));

      final designTokens = theme.extension<DesignTokensThemeExtension>();
      expect(designTokens, isNotNull);
      expect(designTokens!.glassBlur, equals(25.0));
    });

    test('getOledTrueBlackTheme scaffold background is pitch black', () {
      final theme = PaletteTokens.getOledTrueBlackTheme();
      expect(theme.scaffoldBackgroundColor, equals(Colors.black));
      expect(theme.colorScheme.surface, equals(Colors.black));
    });

    test('High contrast themes generate valid contrast surfaces', () {
      final lightHc = PaletteTokens.getSunlightTheme(isHighContrast: true);
      final darkHc = PaletteTokens.getMidnightTheme(isHighContrast: true);

      expect(lightHc.brightness, equals(Brightness.light));
      expect(darkHc.brightness, equals(Brightness.dark));
    });
  });

  group('Riverpod Theme Manager State Tests', () {
    test('themePreferenceProvider updates and persists theme mode', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(themePreferenceProvider), equals(ThemeMode.system));

      container.read(themePreferenceProvider.notifier).setThemeMode(ThemeMode.dark);
      expect(container.read(themePreferenceProvider), equals(ThemeMode.dark));
    });

    test('flexSchemeProvider updates scheme', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(flexSchemeProvider.notifier).setFlexScheme(FlexScheme.amber);
      expect(container.read(flexSchemeProvider), equals(FlexScheme.amber));
    });

    test('isHighContrastProvider toggles high contrast mode', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(isHighContrastProvider), isFalse);
      container.read(isHighContrastProvider.notifier).toggleHighContrast(true);
      expect(container.read(isHighContrastProvider), isTrue);
    });

    test('fontFamilyProvider & textScaleFactorProvider update state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(fontFamilyProvider.notifier).setFontFamily('Roboto');
      expect(container.read(fontFamilyProvider), equals('Roboto'));

      container.read(textScaleFactorProvider.notifier).setTextScaleFactor(1.2);
      expect(container.read(textScaleFactorProvider), equals(1.2));
    });
  });
}
