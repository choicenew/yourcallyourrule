// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get read => 'Empezar a leer';

  @override
  String get shelf => 'Añadir a la estantería';

  @override
  String get shelfIn => 'En estantería';

  @override
  String get ocr => 'Extrayendo...';

  @override
  String get ocrExtracting => 'Extrayendo...';

  @override
  String get translate => 'Opciones de traducción';

  @override
  String get comicTranslateAi => 'Traducción IA';

  @override
  String get comicTranslateEngine => 'Traducción de motor';

  @override
  String get page => 'Página';

  @override
  String get pageOf => 'de';

  @override
  String get stripMode => 'Tira continua';

  @override
  String get pageMode => 'Página única';

  @override
  String get description => 'Descripción';

  @override
  String get shareComic => 'Compartir cómic: ';
}
