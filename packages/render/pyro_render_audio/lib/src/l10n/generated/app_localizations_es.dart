// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get play => 'Reproducir';

  @override
  String get download => 'Descargando';

  @override
  String get downloading => 'Descargando...';

  @override
  String get like => 'Favorito';

  @override
  String get liked => 'Me gusta';

  @override
  String get pause => 'Pausar';

  @override
  String get playlist => 'Añadir a lista';

  @override
  String get previousTrack => 'Anterior';

  @override
  String get nextTrack => 'Siguiente';

  @override
  String get speed => 'Velocidad';

  @override
  String get share => 'Compartir';

  @override
  String get description => 'Descripción';

  @override
  String get shareAudio => 'Compartir audio: ';

  @override
  String get exploreMore => 'Explorar más';

  @override
  String get trending => 'Tendencias';

  @override
  String get switchSource => 'Cambiar fuente / Reportar';
}
