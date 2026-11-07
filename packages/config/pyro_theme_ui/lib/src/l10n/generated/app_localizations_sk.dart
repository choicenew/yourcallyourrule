// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Rozšírené nastavenia vzhľadu a farebného motora';

  @override
  String get selectThemeModeTitle => 'Vybrať režim témy';

  @override
  String get themeAuto => 'Predvolené systémom';

  @override
  String get themeLight => 'Svetlá téma';

  @override
  String get themeDark => 'Tmavá téma';

  @override
  String get dynamicColorTitle =>
      'Dynamická farba tapety Android 12+ (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Automaticky extrahovať farbu systémovej tapety ako hlavný tón témy aplikácie';

  @override
  String get flexSchemePresetTitle => 'Prednastavená farebná schéma FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Vyberte prednastavenú farebnú tému';

  @override
  String get pickCustomThemeColorTitle => 'Vybrať vlastnú farbu témy';

  @override
  String get oledTrueBlackTitle => 'Režim OLED True Black';

  @override
  String get oledTrueBlackSubtitle =>
      'V tmavom režime použite absolútne čisté čierne pozadie (#000000) na úsporu batérie';

  @override
  String get highContrastTitle => 'Vizuálne vylepšenie s vysokým kontrastom';

  @override
  String get highContrastSubtitle =>
      'Zvýšte kontrast textu a okrajov pre lepšiu prístupnosť';

  @override
  String get primarySwapTitle => 'Výmena primárnej / sekundárnej farby';

  @override
  String get primarySwapSubtitle =>
      'Zmeňte váhu výplne hlavnej a vedľajšej farby v používateľskom rozhraní';

  @override
  String get glassmorphismSectionTitle => 'Efekty matného skla (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Polomer rozostrenia skla (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Nepriehľadnosť sklenenej nádoby (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Jazyk zobrazenia aplikácie';

  @override
  String get selectAppLanguageTitle => 'Vybrať jazyk aplikácie';

  @override
  String get searchLanguageHint =>
      'Vyhľadajte názov jazyka alebo kód (napr. sk, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Ukážka palety Design Tokens';

  @override
  String get modeCustomSeed => 'Vlastné semeno farby (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Automatická extrakcia z dynamickej tapety';

  @override
  String get modeFlexSchemePreset => 'Prednastavené farby FlexScheme';

  @override
  String get closeButton => 'Zatvoriť';
}
