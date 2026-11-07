// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get sheetTitle => 'Débloquer les privilèges VIP';

  @override
  String get sheetSubtitle =>
      'Traduction LLM illimitée · Zéro pub · Synchro cloud de haute précision';

  @override
  String get buyButtonText => 'Activer maintenant';

  @override
  String get watchAdButtonText => 'Regarder une pub pour 1 jour VIP';

  @override
  String get restoreButtonText => 'Restaurer les achats';
}
