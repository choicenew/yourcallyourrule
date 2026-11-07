// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get play => 'Lire';

  @override
  String get download => 'Téléchargement';

  @override
  String get downloading => 'Téléchargement...';

  @override
  String get like => 'Favoris';

  @override
  String get liked => 'Aimé';

  @override
  String get pause => 'Pause';

  @override
  String get replay => 'Rejouer';

  @override
  String get speed => 'Vitesse';

  @override
  String get quality => 'Qualité';

  @override
  String get share => 'Partager';

  @override
  String get description => 'Description';

  @override
  String get shareVideo => 'Partager la vidéo : ';
}
