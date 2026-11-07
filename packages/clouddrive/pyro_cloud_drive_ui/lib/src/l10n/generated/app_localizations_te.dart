// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get cloudSettingsTitle => 'క్లౌడ్ & సింక్ సెట్టింగ్‌లు';

  @override
  String get encryptionTitle => 'ఎండ్-టు-ఎండ్ ఎన్‌క్రిప్షన్ (E2EE)';

  @override
  String get encryptionSubtitle =>
      'అప్‌లోడ్ చేయడానికి ముందు అన్ని బ్యాకప్‌లను AES-256తో ఎన్‌క్రిప్ట్ చేయండి';

  @override
  String get encryptionEnabled => 'ప్రారంభించబడింది (AES-256)';

  @override
  String get encryptionDisabled => 'నిలిపివేయబడింది';

  @override
  String get configuredDrives => 'కాన్ఫిగర్ చేయబడిన క్లౌడ్ డ్రైవ్‌లు';

  @override
  String get noDrivesRegistered => 'క్లౌడ్ డ్రైవ్‌లు కనెక్ట్ చేయబడలేదు';

  @override
  String get cancel => 'రద్దు చేయి';

  @override
  String get save => 'సేవ్ చేయి';

  @override
  String get saveAndEnable => 'సేవ్ చేసి ప్రారంభించు';

  @override
  String get setPasswordTitle => 'E2EE మాస్టర్ పాస్‌వర్డ్‌ని సెట్ చేయి';

  @override
  String get setPasswordDescription =>
      'అప్‌లోడ్ చేయడానికి ముందు మీ బ్యాకప్‌లు AES-256తో ఎన్‌క్రిప్ట్ చేయబడతాయి.';

  @override
  String get masterPasswordLabel => 'మాస్టర్ పాస్‌వర్డ్';

  @override
  String get passwordEmptyError => 'పాస్‌వర్డ్ ఖాళీగా ఉండకూడదు';

  @override
  String get syncNow => 'ఇప్పుడే సింక్ చేయండి';

  @override
  String get settings => 'సెట్టింగ్‌లు';

  @override
  String get connected => 'కనెక్ట్ చేయబడింది';

  @override
  String get disconnected => 'డిస్‌కనెక్ట్ చేయబడింది';

  @override
  String lastSynced(String time) {
    return 'చివరిగా సింక్ చేయబడింది: $time';
  }
}
