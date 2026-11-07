// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Pokročilá nastavení vzhledu a barevného enginu';

  @override
  String get selectThemeModeTitle => 'Vybrat režim motivu';

  @override
  String get themeAuto => 'Výchozí systém';

  @override
  String get themeLight => 'Světlý motiv';

  @override
  String get themeDark => 'Tmavý motiv';

  @override
  String get dynamicColorTitle =>
      'Dynamická barva tapety Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Automaticky extrahovat barvu systémové tapety jako hlavní tón motivu aplikace';

  @override
  String get flexSchemePresetTitle => 'Přednastavené schéma barev FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Vyberte přednastavenou barevnou tému';

  @override
  String get pickCustomThemeColorTitle => 'Vyberte vlastní barvu motivu';

  @override
  String get oledTrueBlackTitle => 'Režim OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'V tmavém režimu použijte absolutně čisté černé pozadí (#000000) pro úsporu baterie';

  @override
  String get highContrastTitle => 'Vizuální vylepšení s vysokým kontrastem';

  @override
  String get highContrastSubtitle =>
      'Zvětšete kontrast textu a okrajů pro lepší přístupnost';

  @override
  String get primarySwapTitle => 'Výměna primární / sekundární barvy';

  @override
  String get primarySwapSubtitle =>
      'Změňte váhu výplně hlavní a vedlejší barvy v uživatelském rozhraní';

  @override
  String get glassmorphismSectionTitle =>
      'Efekty tekutého matného skla (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Poloměr rozostření skla (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Neprůhlednost skleněné nádoby (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Jazyk zobrazení aplikace';

  @override
  String get selectAppLanguageTitle => 'Vybrat jazyk aplikace';

  @override
  String get searchLanguageHint =>
      'Vyhledejte název jazyka nebo kód (např. cs, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Náhled palety Design Tokens';

  @override
  String get modeCustomSeed => 'Vlastní semeno barvy (Custom Seed)';

  @override
  String get modeDynamicWallpaper => 'Automatická extrakce z dynamické tapety';

  @override
  String get modeFlexSchemePreset => 'Přednastavené barvy FlexScheme';

  @override
  String get closeButton => 'Zavřít';
}
