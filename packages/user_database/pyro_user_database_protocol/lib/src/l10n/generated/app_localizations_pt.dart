// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get cloudflareSyncTitle => 'Cloudflare Worker Edge Sync';

  @override
  String get supabaseSyncTitle => 'Supabase Cloud Database Sync';

  @override
  String get testConnection => 'Test Connectivity';

  @override
  String get connected => 'Connected';

  @override
  String get connectionFailed => 'Connection Failed';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');
}
