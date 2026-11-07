// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

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
