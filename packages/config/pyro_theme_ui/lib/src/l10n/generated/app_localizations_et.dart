// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Täpsemad välimuse ja värvimootori seaded';

  @override
  String get selectThemeModeTitle => 'Vali teemarežiim';

  @override
  String get themeAuto => 'Süsteemi vaikeseade';

  @override
  String get themeLight => 'Hele teema';

  @override
  String get themeDark => 'Tumepilt';

  @override
  String get dynamicColorTitle =>
      'Android 12+ dünaamiline taustpildi värv (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Ekstraktige süsteemi taustpildi värv automaatselt rakenduse teema põhitooniks';

  @override
  String get flexSchemePresetTitle => 'FlexScheme eelmääratletud värviskeem';

  @override
  String get selectFlexSchemeDialogTitle => 'Valige eelmääratletud värviteema';

  @override
  String get pickCustomThemeColorTitle => 'Vali kohandatud teemavärv';

  @override
  String get oledTrueBlackTitle => 'OLED True Black režiim';

  @override
  String get oledTrueBlackSubtitle =>
      'Kasutage pimedas režiimis aku säästmiseks täiesti puhast musta tausta (#000000)';

  @override
  String get highContrastTitle => 'Kõrge kontrastsusega visuaalne täiustus';

  @override
  String get highContrastSubtitle =>
      'Suurendage teksti ja äärte kontrastsust parema juurdepääsetavuse tagamiseks';

  @override
  String get primarySwapTitle => 'Primaarse / sekundaarse värvi vahetus';

  @override
  String get primarySwapSubtitle =>
      'Vahetage põh- ja lisavärvi täitekaal kasutajaliideses';

  @override
  String get glassmorphismSectionTitle =>
      'Vedelate mattklaasi efektid (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Klaasi uduse raadius (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Klaasinõu läbipaistmatus (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Rakenduse kuvakeel';

  @override
  String get selectAppLanguageTitle => 'Vali rakenduse keel';

  @override
  String get searchLanguageHint =>
      ' Otsige keele nime või koodi järgi (nt et, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Design Tokens värvipaleti eelvaade';

  @override
  String get modeCustomSeed => 'Kohandatud seemnevärv (Custom Seed)';

  @override
  String get modeDynamicWallpaper =>
      'Automaatne ekstraheerimine dünaamilisest taustpildist';

  @override
  String get modeFlexSchemePreset => 'FlexScheme eelseadistatud värvid';

  @override
  String get closeButton => 'Sulge';
}
