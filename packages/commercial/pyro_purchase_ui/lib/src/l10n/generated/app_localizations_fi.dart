// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get sheetTitle => 'Avaa VIP-erityisedut';

  @override
  String get sheetSubtitle =>
      'Rajoittamaton reunatekoälykäännös · Täysin puhdas ja mainokseton · Pilvisynkronointi';

  @override
  String get buyButtonText => 'Tilaa nyt';

  @override
  String get watchAdButtonText => 'Katso mainos saadaksesi 1 päivän VIP:n';

  @override
  String get restoreButtonText => 'Palauta ostokset';
}
