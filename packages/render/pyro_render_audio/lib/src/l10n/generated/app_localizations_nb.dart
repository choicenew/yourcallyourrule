// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get play => 'Spill av video';

  @override
  String get download => 'Laster ned';

  @override
  String get downloading => 'Laster ned...';

  @override
  String get like => 'Likte';

  @override
  String get liked => 'Likte';

  @override
  String get pause => 'Pause';

  @override
  String get playlist => 'Legg til i spilleliste';

  @override
  String get previousTrack => 'Forrige';

  @override
  String get nextTrack => 'Neste';

  @override
  String get speed => 'Hastighet';

  @override
  String get share => 'Del';

  @override
  String get description => 'Beskrivelse';

  @override
  String get shareAudio => 'Del lyd: ';

  @override
  String get exploreMore => 'Utforsk mer';

  @override
  String get trending => 'Trendende nå';

  @override
  String get switchSource => 'Bytt kilde / rapporter';
}
