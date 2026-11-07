// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Расширенные настройки внешнего вида и цветового движка';

  @override
  String get selectThemeModeTitle => 'Выберите тему';

  @override
  String get themeAuto => 'Системная';

  @override
  String get themeLight => 'Светлая тема';

  @override
  String get themeDark => 'Темная тема';

  @override
  String get dynamicColorTitle => 'Динамические цвета обоев (Android 12+)';

  @override
  String get dynamicColorSubtitle =>
      'Автоматически извлекать цвета системных обоев для темы';

  @override
  String get flexSchemePresetTitle => 'Предустановленные темы FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Выберите цветовую тему';

  @override
  String get pickCustomThemeColorTitle => 'Выберите свой цвет темы';

  @override
  String get oledTrueBlackTitle => 'Режим глубокого черного OLED';

  @override
  String get oledTrueBlackSubtitle =>
      'Использовать чистый черный фон (#000000) в темном режиме для экономии энергии';

  @override
  String get highContrastTitle => 'Повышенный контраст';

  @override
  String get highContrastSubtitle =>
      'Увеличить контраст текста и границ для лучшей читаемости';

  @override
  String get primarySwapTitle => 'Поменять местами основной и вторичный цвета';

  @override
  String get primarySwapSubtitle =>
      'Изменить приоритет основного и вторичного цветов в интерфейсе';

  @override
  String get glassmorphismSectionTitle =>
      'Эффект матового стекла (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Радиус размытия стекла (Blur Radius)';

  @override
  String get glassOpacityTitle => 'Прозрачность контейнера (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Язык интерфейса приложения';

  @override
  String get selectAppLanguageTitle => 'Выберите язык приложения';

  @override
  String get searchLanguageHint =>
      'Поиск по названию или коду языка (напр. ru, en, zh)...';

  @override
  String get designTokensPreviewTitle => 'Предпросмотр палитры дизайн-токенов';

  @override
  String get modeCustomSeed => 'Пользовательский Seed цвет';

  @override
  String get modeDynamicWallpaper => 'Автоизвлечение из динамических обоев';

  @override
  String get modeFlexSchemePreset => 'Предустановка FlexScheme';

  @override
  String get closeButton => 'Закрыть';
}
