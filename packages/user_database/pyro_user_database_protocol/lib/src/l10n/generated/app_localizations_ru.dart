// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
