// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get phoneNumberTypeFixedLine => 'Fixed line';

  @override
  String get phoneNumberTypeMobile => 'Mobile';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Fixed line or mobile';

  @override
  String get phoneNumberTypeTollFree => 'Toll free';

  @override
  String get phoneNumberTypePremiumRate => 'Premium rate';

  @override
  String get phoneNumberTypeSharedCost => 'Shared cost';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phoneNumberTypePersonalNumber => 'Personal number';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeVoicemail => 'Voicemail';

  @override
  String get phoneNumberTypeUnknown => 'Unknown';

  @override
  String get callFilterSettings => 'Call Filter Settings';

  @override
  String get enhancedFilterSettings => 'Enhanced Filter Settings';

  @override
  String get globalFilterSettings => 'Global Filter Settings';

  @override
  String get simSlotManagement => 'SIM Slot Management';

  @override
  String get enhancedFilterSettingsTitle => 'Enhanced Filter Settings';

  @override
  String get globalFilterDescription => 'Configure global filters for all SIM cards:';

  @override
  String get localCounterFilter => 'Local Counter Filter';

  @override
  String get localCounterFilterSubtitle => 'Automatically filter spam calls based on call frequency';

  @override
  String get remoteNumberFilter => 'Remote Number Filter';

  @override
  String get remoteNumberFilterSubtitle => 'Identify spam calls using cloud database and community reports';

  @override
  String get basicRuleFilter => 'Basic Rule Filter';

  @override
  String get basicRuleFilterSubtitle => 'Filter calls using blacklist/whitelist and regular expressions';

  @override
  String get simSlotFilterDescription => 'Configure independent filtering rules for each SIM card:';

  @override
  String get enhancedFilterInstructionsTitle => 'Enhanced Filter System';

  @override
  String get enhancedFilterSystemDescription => 'The enhanced filter system supports both global rules and per-SIM card filtering configurations.';

  @override
  String get systemFeatures => 'System Features:';

  @override
  String get globalFilterFeature => '• Global Filters: Basic rules for all incoming calls';

  @override
  String get simSlotRuleFeature => '• SIM Slot Rules: Independent filtering strategies per SIM';

  @override
  String get flexibleCombinationFeature => '• Flexible Combinations: Enable/disable filters per SIM slot';

  @override
  String get configurationAdvice => 'Through proper configuration, you can set different filtering strategies for work and personal SIM cards.';

  @override
  String get simSlotRuleManagement => 'SIM Slot Rules';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM Slot $slotNumber';
  }

  @override
  String get ruleDeletedSuccess => 'Rule deleted successfully';

  @override
  String get ruleAddedSuccess => 'Rule added successfully';

  @override
  String get phoneNumberHint => 'Enter phone number to add rule';

  @override
  String get ruleNameHint => 'Rule name (optional)';

  @override
  String get addRuleButton => 'Add Rule';

  @override
  String get simSlotRuleManagementTitle => 'Rule Management';

  @override
  String get enableNoneActionRules => 'Enable None Action Rules';

  @override
  String get enableNoneActionRulesDesc => 'Allow rule configurations with no interception actions';

  @override
  String get allowAllBlacklistedNumbers => 'Allow All Blacklisted Numbers';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Allow calls from blocklist';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM Slot $slotNumber Filter Settings';
  }

  @override
  String get filterToggleInstructions => 'Enable or disable filters for this SIM slot:';

  @override
  String get simRuleInstructionsTitle => 'SIM Slot Rules';

  @override
  String get simRuleInstructions => 'SIM slot rules allow you to configure independent filtering rules for each SIM slot.';

  @override
  String get featureListTitle => 'Features:';

  @override
  String get featureEnableDisable => '• Enable/disable different filters per SIM';

  @override
  String get featureAddRules => '• Add phone number specific rules';

  @override
  String get featureManageRules => '• Manage rule lists per SIM';

  @override
  String get dualSimAdvice => 'This feature is particularly useful for dual-SIM phones to set different filtering strategies for work and personal SIM cards.';

  @override
  String get simSlotRuleListTitle => 'SIM Slot Rules List';

  @override
  String get noRulesPrompt => 'No rules found, please add rules';

  @override
  String get loadingTags => 'Loading tags...';

  @override
  String get callHistoryTitle => 'Call History';

  @override
  String get allTab => 'All';

  @override
  String get answeredCallsTab => 'Answered';

  @override
  String get missedCallsTab => 'Missed';

  @override
  String get blockedCallsTab => 'Blocked';

  @override
  String get outgoingCallsTab => 'Outgoing';

  @override
  String get labelFilterTooltip => 'Label Filter';

  @override
  String get searchTooltip => 'Search';

  @override
  String initializationFailed(Object error) {
    return 'Failed to initialize call history: $error';
  }

  @override
  String refreshFailed(Object error) {
    return 'Failed to refresh call history: $error';
  }

  @override
  String get todayGroup => 'Today';

  @override
  String get yesterdayGroup => 'Yesterday';

  @override
  String get thisWeekGroup => 'This Week';

  @override
  String get olderGroup => 'Older';

  @override
  String get emptyCallLogs => 'No call records found';

  @override
  String get errorLoadingLogs => 'Error loading call logs';

  @override
  String tagLabel(Object tag) {
    return 'Tag: $tag';
  }

  @override
  String get unknownTag => 'Tag: Unknown';

  @override
  String get phoneNumberLabel => 'Phone Number *';

  @override
  String get phoneNumberHintText => 'Enter phone number to add rule';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactNameHint => 'Enter contact name (optional)';

  @override
  String get addSimRuleButton => 'Add SIM Rule';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get serviceTypePhone => 'Phone Subscription';

  @override
  String get serviceTypeSms => 'SMS Subscription';

  @override
  String get serviceTypeContact => 'Contact Subscription';

  @override
  String get serviceTypePlugin => 'Plugin Update';

  @override
  String get autoUpdateSettings => 'Auto Update Settings';

  @override
  String get updateAllNow => 'Update All Now';

  @override
  String get updateInterval => 'Update Interval';

  @override
  String get updateNow => 'Update Now';

  @override
  String get autoUpdateDescription => 'Set auto-update intervals for subscriptions or update manually';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service update interval set to $days days';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service updated successfully ($count rules)';
  }

  @override
  String allUpdateSuccess(Object count) {
    return 'All updates completed ($count rules)';
  }

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String simCard(Object simNumber) {
    return 'SIM Card $simNumber';
  }

  @override
  String get simRuleManagement => 'SIM Slot Rule Management';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM slot operation failed: $error';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Failed to load SIM slots: $error';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'Failed to load SIM data: $error';
  }

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get contactNameOptional => 'Contact name (optional)';

  @override
  String get ruleAddButton => 'Add Rule';

  @override
  String get rejectAllNumbers => 'Reject All Numbers';

  @override
  String get rejectAllNumbersDesc => 'Reject all incoming calls when enabled';

  @override
  String get allowAllowedNumbers => 'Allow Allowed Numbers';

  @override
  String get allowAllowedNumbersDesc => 'Allow calls from allowlist';

  @override
  String get allowBlockedNumbers => 'Allow Blocked Numbers';

  @override
  String get allowBlockedNumbersDesc => 'Allow calls from blocklist';

  @override
  String get allowRegexAllowRules => 'Allow Regex Allow Rules';

  @override
  String get allowRegexAllowRulesDesc => 'Enable regex pattern matching for allow rules';

  @override
  String get allowAllWhitelistedNumbers => 'Allow Whitelisted Numbers';

  @override
  String get allowAllWhitelistedNumbersDesc => 'Allow calls from whitelist';

  @override
  String get allowRegexBlockRules => 'Allow Regex Block Rules';

  @override
  String get allowRegexBlockRulesDesc => 'Enable regex pattern matching for block rules';

  @override
  String get enableMuteRules => 'Enable Mute Rules';

  @override
  String get enableMuteRulesDesc => 'Apply mute interception rules configuration';

  @override
  String generalUpdateFailure(Object error) {
    return 'Update failed: $error';
  }

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get unassignedSIMCard => 'Unnamed SIM Card';

  @override
  String dataLoadFailure(Object error) {
    return 'Data load failed: $error';
  }

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String ruleAddFailure(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Failed to delete rule: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM Slot Position $slotNumberString';
  }
}
