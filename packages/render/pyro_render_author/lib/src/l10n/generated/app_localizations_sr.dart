// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get follow => 'Prati';

  @override
  String get following => 'Praćeno';

  @override
  String get unfollow => 'Prestani prati';

  @override
  String get followedMessage => 'Praćen autor';

  @override
  String get unfollowedMessage => 'Nije više praćen autor';

  @override
  String get like => 'Sviđa mi se';

  @override
  String get liked => 'Sviđa mi se';

  @override
  String get likeAdded => 'Dodato u omiljene autore';

  @override
  String get likeRemoved => 'Uklonjeno iz omiljenih autora';

  @override
  String get share => 'Podeli';

  @override
  String get homepage => 'Početna stranica';

  @override
  String get works => 'Radovi';

  @override
  String get followers => 'Pratioci';

  @override
  String get translate => 'Opcije prevoda';
}
