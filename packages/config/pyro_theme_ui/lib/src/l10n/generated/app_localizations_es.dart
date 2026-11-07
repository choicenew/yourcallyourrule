// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get themeSettingsExpansionTitle =>
      'Ajustes avanzados de apariencia y motor de color';

  @override
  String get selectThemeModeTitle => 'Seleccionar modo de tema';

  @override
  String get themeAuto => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Tema claro';

  @override
  String get themeDark => 'Tema oscuro';

  @override
  String get dynamicColorTitle =>
      'Color dinámico de fondo de pantalla (Android 12+)';

  @override
  String get dynamicColorSubtitle =>
      'Extraer automáticamente colores del fondo del sistema como tema principal';

  @override
  String get flexSchemePresetTitle => 'Temas preestablecidos FlexScheme';

  @override
  String get selectFlexSchemeDialogTitle => 'Seleccionar tema de color';

  @override
  String get pickCustomThemeColorTitle => 'Elegir color de tema personalizado';

  @override
  String get oledTrueBlackTitle => 'Modo Negro Puro OLED';

  @override
  String get oledTrueBlackSubtitle =>
      'Usar fondo negro puro (#000000) en modo oscuro para ahorrar batería';

  @override
  String get highContrastTitle => 'Mejora de alto contraste';

  @override
  String get highContrastSubtitle =>
      'Aumentar el contraste del texto y bordes para mayor accesibilidad';

  @override
  String get primarySwapTitle => 'Intercambiar colores primario y secundario';

  @override
  String get primarySwapSubtitle =>
      'Cambiar la prioridad de los colores primario y secundario en la interfaz';

  @override
  String get glassmorphismSectionTitle =>
      'Efecto de cristal esmerilado (Glassmorphism)';

  @override
  String get glassBlurTitle => 'Radio de desenfoque del cristal (Blur Radius)';

  @override
  String get glassOpacityTitle =>
      'Opacidad del contenedor de cristal (Glass Opacity)';

  @override
  String get appDisplayLanguageTitle => 'Idioma de interfaz de la aplicación';

  @override
  String get selectAppLanguageTitle => 'Seleccionar idioma de la aplicación';

  @override
  String get searchLanguageHint =>
      'Buscar nombre de idioma o código (ej. es, en, zh)...';

  @override
  String get designTokensPreviewTitle =>
      'Vista previa de la paleta de tokens de diseño';

  @override
  String get modeCustomSeed => 'Color Seed personalizado';

  @override
  String get modeDynamicWallpaper => 'Extracción automática del fondo dinámico';

  @override
  String get modeFlexSchemePreset => 'Ajuste preestablecido FlexScheme';

  @override
  String get closeButton => 'Cerrar';
}
