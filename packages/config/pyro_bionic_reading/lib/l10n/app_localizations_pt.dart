// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get bionicReadingTitle => 'Bionic Reading';

  @override
  String get bionicReadingDescription =>
      'Enhance focus by bolding initial letters of words';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get bionicReadingTitle => 'Bionic Reading';

  @override
  String get bionicReadingDescription =>
      'Enhance focus by bolding initial letters of words';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get bionicReadingTitle => 'Bionic Reading';

  @override
  String get bionicReadingDescription =>
      'Enhance focus by bolding initial letters of words';
}
