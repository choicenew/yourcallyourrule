// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get follow => 'Volgen';

  @override
  String get following => 'Volgend';

  @override
  String get unfollow => 'Ontvolgen';

  @override
  String get followedMessage => 'Auteur gevolgd';

  @override
  String get unfollowedMessage => 'Auteur ontvolgd';

  @override
  String get like => 'Geliked';

  @override
  String get liked => 'Geliked';

  @override
  String get likeAdded => 'Toegevoegd aan geliked auteurs';

  @override
  String get likeRemoved => 'Verwijderd van geliked auteurs';

  @override
  String get share => 'Delen';

  @override
  String get homepage => 'Startpagina';

  @override
  String get works => 'Werken';

  @override
  String get followers => 'Volgers';

  @override
  String get translate => 'Vertalingsopties';
}
