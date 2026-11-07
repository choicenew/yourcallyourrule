// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Gelişmiş Görünüm ve Renk Motoru Ayarları';

  @override
  String get selectThemeModeTitle => 'Tema Modunu Seç';

  @override
  String get themeAuto => 'Sistem Varsayılanı';

  @override
  String get themeLight => 'Açık Tema';

  @override
  String get themeDark => 'Koyu Tema';

  @override
  String get dynamicColorTitle =>
      'Android 12+ Dinamik Duvar Kağıdı Rengi (Material You)';

  @override
  String get dynamicColorSubtitle =>
      'Uygulama teması ana rengi olarak sistem duvar kağıdı rengini otomatik olarak çıkar';

  @override
  String get flexSchemePresetTitle => 'FlexScheme Hazır Renk Şeması';

  @override
  String get selectFlexSchemeDialogTitle =>
      'Önceden Ayarlanmış Renk Temasını Seçin';

  @override
  String get pickCustomThemeColorTitle => 'Özel Tema Rengi Seç';

  @override
  String get oledTrueBlackTitle => 'OLED Gerçek Siyah Modu';

  @override
  String get oledTrueBlackSubtitle =>
      'Karanlık modda mutlak saf siyah arka plan (#000000) kullanarak pil tasarrufu sağlayın';

  @override
  String get highContrastTitle => 'Yüksek Kontrast Görsel Geliştirme';

  @override
  String get highContrastSubtitle =>
      'Erişilebilirlik okunabilirliğini artırmak için metin ve kenarlık kontrastını artırın';

  @override
  String get primarySwapTitle => 'Birincil / İkincil Renk Değişimi';

  @override
  String get primarySwapSubtitle =>
      'Arayüzde ana renk ile ikincil renk dolgu ağırlığını değiştirin';

  @override
  String get glassmorphismSectionTitle =>
      'Sıvı Buzlu Cam Efektleri (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Cam Bulanıklığı Yarıçapı (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Cam Konteyner Opaklığı (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Uygulama Arayüzü Görüntüleme Dili';

  @override
  String get selectAppLanguageTitle => 'Uygulama Dilini Seç';

  @override
  String get searchLanguageHint =>
      'Dil adını veya kodunu arayın (örn. tr, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Design Tokens Renk Paleti Önizlemesi';

  @override
  String get modeCustomSeed => 'Özel Seed Renk Tohumu';

  @override
  String get modeDynamicWallpaper => 'Duvar Kağıdından Otomatik Çıkarma';

  @override
  String get modeFlexSchemePreset => 'FlexScheme Hazır Renkleri';

  @override
  String get closeButton => 'Kapat';
}
