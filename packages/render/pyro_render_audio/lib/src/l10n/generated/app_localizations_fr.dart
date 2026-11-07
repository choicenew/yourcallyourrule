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
  String get playlist => 'Ajouter à la playlist';

  @override
  String get previousTrack => 'Précédent';

  @override
  String get nextTrack => 'Suivant';

  @override
  String get speed => 'Vitesse';

  @override
  String get share => 'Partager';

  @override
  String get description => 'Description';

  @override
  String get shareAudio => 'Partager l\'audio : ';

  @override
  String get exploreMore => 'Explorer plus';

  @override
  String get trending => 'Tendances';

  @override
  String get switchSource => 'Changer de source / Signaler';
}
