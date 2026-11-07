// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Zaawansowane ustawienia wyglądu i silnika kolorów';

  @override
  String get selectThemeModeTitle => 'Wybierz tryb motywu';

  @override
  String get themeAuto => 'Domyślny systemowy';

  @override
  String get themeLight => 'Jasny motyw';

  @override
  String get themeDark => 'Ciemny motyw';

  @override
  String get dynamicColorTitle =>
      'Dynamiczne kolory tapety Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Automatycznie pobieraj kolory z tapety systemowej jako motyw główny';

  @override
  String get flexSchemePresetTitle => 'Domyślne motywy FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Wybierz motyw kolorystyczny';

  @override
  String get pickCustomThemeColorTitle => 'Wybierz niestandardowy kolor motywu';

  @override
  String get oledTrueBlackTitle => 'Tryb czystej czerni OLED';

  @override
  String get oledTrueBlackSubtitle =>
      'Używaj czystego czarnego tła (#000000) w trybie ciemnym, aby oszczędzać energię';

  @override
  String get highContrastTitle => 'Wzmocnienie wysokiego kontrastu';

  @override
  String get highContrastSubtitle =>
      'Zwiększ kontrast tekstu i ramek dla lepszej czytelności';

  @override
  String get primarySwapTitle => 'Zamień kolory podstawowy i drugorzędny';

  @override
  String get primarySwapSubtitle =>
      'Zamień wagę kolorów głównego i podrzędnego w interfejsie';

  @override
  String get glassmorphismSectionTitle => 'Efekt szkła (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Promień rozmycia szkła (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Przezroczystość kontenera (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Język wyświetlania aplikacji';

  @override
  String get selectAppLanguageTitle => 'Wybierz język aplikacji';

  @override
  String get searchLanguageHint =>
      'Szukaj nazwy języka lub kodu (np. pl, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Podgląd palety tokenów projektowych';

  @override
  String get modeCustomSeed => 'Niestandardowy kolor Seed';

  @override
  String get modeDynamicWallpaper =>
      'Automatyczne pobieranie z dynamicznej tapety';

  @override
  String get modeFlexSchemePreset => 'Ustawienie wstępne FlexScheme';

  @override
  String get closeButton => 'Zamknij';
}
