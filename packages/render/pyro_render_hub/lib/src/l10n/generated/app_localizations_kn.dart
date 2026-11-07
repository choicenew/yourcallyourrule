// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get demandSentToAi => 'Request dispatched to AI Assistant';

  @override
  String get urlCopiedToClipboard => 'Copied page URL to clipboard';

  @override
  String get cannotOpenExternalUrl => 'Cannot open URL in external browser';

  @override
  String get scanningWebTextNodes => 'Scanning web text nodes...';

  @override
  String get noTranslatableWebNodesFound =>
      'No translatable text nodes found. Please wait for page to fully load.';

  @override
  String get bilingualTranslationComplete =>
      'Inline bilingual translation complete';

  @override
  String get failedToExtractWebText =>
      'Failed to extract translatable content from web page';

  @override
  String get webDictionarySearchTitle => 'Web Word Lookup & Dictionary Search';

  @override
  String get cancel => 'ರದ್ದುಗೊಳಿಸಿ';

  @override
  String get search => 'ಹುಡುಕಿ';

  @override
  String get smartSelectionEnabled =>
      'App smart text selection bubble & action bar linkage enabled';

  @override
  String get systemMenuRestored => 'Restored system native long-press menu';

  @override
  String get copyLink => 'ಲಿಂಕ್ ನಕಲಿಸಿ';

  @override
  String get openInSystemBrowser => 'ಸಿಸ್ಟಮ್ ಬ್ರೌಸರ್‌ನಲ್ಲಿ ತೆರೆಯಿರಿ';

  @override
  String get bilingualPageTranslation => 'Bilingual Page Translation';

  @override
  String get extractAndTranslateContent => 'Extract & Translate Content';

  @override
  String get aiDeepAnalysisSummary => 'AI Deep Analysis & Summary';

  @override
  String get dictionaryLookup => 'Dictionary Lookup';

  @override
  String get shareWebPage => 'Share Web Page';

  @override
  String get lookupWordAction => 'Lookup';

  @override
  String get translateAction => 'Translate';

  @override
  String get inputLookupHint => 'Enter English word or phrase to look up...';
}
