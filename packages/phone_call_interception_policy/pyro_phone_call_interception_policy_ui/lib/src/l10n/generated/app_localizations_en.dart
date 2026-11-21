// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get actionAllow => 'Allow';

  @override
  String get actionAnswerThenHangup => 'Answer & Hangup';

  @override
  String get actionSilence => 'Silence';

  @override
  String get actionEndCall => 'End Call';

  @override
  String get labelPolicyTitle => 'Label Interception Rules';

  @override
  String get labelPolicySubtitle => 'Execute custom interception actions based on caller identity tags';

  @override
  String get noConfiguredLabels => 'No custom label actions configured. Global default action will apply.';

  @override
  String get deleteRuleTooltip => 'Delete this rule';

  @override
  String get addLabelRuleTitle => 'Add Label Action Rule';

  @override
  String get selectExistingLabel => 'Select existing tag:';

  @override
  String get pleaseSelectLabel => 'Please select a tag';

  @override
  String get customLabelName => 'Custom Tag Name';

  @override
  String get customLabelHint => 'e.g. Spam, Telemarketing, Delivery, Support';

  @override
  String get selectActionPrompt => 'Select action when tag matches:';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get add => 'Add';

  @override
  String get emergencyExemptionTitle => 'Emergency Exemption Guard';

  @override
  String get emergencyExemptionSubtitle => 'Temporarily allow all incoming calls unconditionally after calling emergency services';

  @override
  String emergencyExemptionActiveWithTime(int minutes) {
    return 'Emergency exemption active ($minutes min remaining)';
  }

  @override
  String get emergencyExemptionActive => 'Emergency exemption active. Incoming calls will connect unconditionally.';

  @override
  String get durationTitle => 'Exemption Duration Window';

  @override
  String get durationSubtitle => 'Time window to keep allowing incoming calls after emergency dial';

  @override
  String get duration15Min => '15 minutes';

  @override
  String get duration30Min => '30 minutes (Recommended)';

  @override
  String get duration1Hour => '1 hour';

  @override
  String get duration2Hours => '2 hours';

  @override
  String customEmergencyNumbers(int count) {
    return 'Custom Emergency Numbers ($count)';
  }

  @override
  String get customEmergencySubtitle => 'Add local EMS, community security, family emergency numbers';

  @override
  String get addEmergencyNumberButton => 'Add Number';

  @override
  String get addEmergencyNumberTitle => 'Add Emergency Number';

  @override
  String get addEmergencyNumberDesc => 'Enter local emergency contact numbers (community rescue, station, dispatch, etc.):';

  @override
  String get emergencyPhoneLabel => 'Emergency Phone Number';

  @override
  String get emergencyPhoneHint => 'e.g. 911, 112, 999, 120';

  @override
  String get noCustomEmergencyNumbers => 'No custom emergency numbers added yet. Tap top right to add.';

  @override
  String viewGlobalPresetNumbers(int count) {
    return 'View Global Built-in Emergency Directory ($count)';
  }
}
