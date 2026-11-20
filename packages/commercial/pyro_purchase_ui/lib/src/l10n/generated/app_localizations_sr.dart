// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get sheetTitle => 'Otključajte VIP privilegije';

  @override
  String get sheetSubtitle =>
      'Neograničen AI prevod · Iskustvo bez oglasa · Sinhronizacija u oblaku';

  @override
  String get buyButtonText => 'Pretplatite se odmah';

  @override
  String get watchAdButtonText => 'Pogledajte oglas za 1 dan VIP-a';

  @override
  String get restoreButtonText => 'Vrati kupovine';
}
