// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get follow => 'Suivre';

  @override
  String get following => 'Abonnements';

  @override
  String get unfollow => 'Ne plus suivre';

  @override
  String get followedMessage => 'Auteur suivi';

  @override
  String get unfollowedMessage => 'Auteur non suivi';

  @override
  String get like => 'Favoris';

  @override
  String get liked => 'Aimé';

  @override
  String get likeAdded => 'Ajouté aux auteurs aimés';

  @override
  String get likeRemoved => 'Retiré des auteurs aimés';

  @override
  String get share => 'Partager';

  @override
  String get homepage => 'Accueil';

  @override
  String get works => 'Œuvres';

  @override
  String get followers => 'Abonnés';

  @override
  String get translate => 'Options de traduction';
}
