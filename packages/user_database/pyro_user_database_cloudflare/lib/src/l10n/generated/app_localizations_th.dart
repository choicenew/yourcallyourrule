// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get cloudflareConfigTitle =>
      'Cloudflare Worker Edge Sync Configuration';

  @override
  String get workerUrlLabel => 'Worker Endpoint URL';

  @override
  String get workerUrlHint => 'https://your-worker.workers.dev';

  @override
  String get apiSecretLabel => 'API Secret / Key';

  @override
  String get apiSecretHint => 'Enter X-API-SECRET Key';

  @override
  String get deviceIdLabel => 'Hardware Device ID';

  @override
  String get deviceIdHint => 'e.g. dev_pixel8_001';

  @override
  String get saveConfigButton => 'Save Configuration';

  @override
  String get testConnectionButton => 'Test Connectivity';

  @override
  String get saveSuccessMessage => 'Settings saved successfully!';

  @override
  String get testingMessage => 'Testing connectivity with Cloudflare Worker...';

  @override
  String get testSuccessMessage =>
      'Connectivity test passed! Cloudflare Worker is healthy.';

  @override
  String get testFailedMessage =>
      'Connection failed. Please check Worker URL and API Key.';
}
