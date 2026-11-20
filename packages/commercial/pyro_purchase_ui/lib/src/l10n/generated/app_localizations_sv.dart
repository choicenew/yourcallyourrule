// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get sheetTitle => 'Lås upp VIP-förmåner';

  @override
  String get sheetSubtitle =>
      'Obegränsad AI-översättning · Annonsfri upplevelse · Molnsynk';

  @override
  String get buyButtonText => 'Prenumerera nu';

  @override
  String get watchAdButtonText => 'Titta på annons för 1 dag VIP';

  @override
  String get restoreButtonText => 'Återställ köp';
}
