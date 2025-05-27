// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get callHistoryInfoTitle => 'Call History';

  @override
  String get callHistoryInfoDesc => 'Here shows your call history, including incoming, outgoing and missed calls.';

  @override
  String get tabAll => 'All';

  @override
  String get tabAnswered => 'Answered';

  @override
  String get tabMissed => 'Missed';

  @override
  String get tabBlocked => 'Blocked';

  @override
  String get tabOutgoing => 'Outgoing';

  @override
  String get callHistoryTimelineToday => 'Today';

  @override
  String get callHistoryTimelineYesterday => 'Yesterday';

  @override
  String get callHistoryTimelineEarlier => 'Earlier';

  @override
  String get callTypeAnswered => 'Answered';

  @override
  String get callTypeOutgoing => 'Outgoing';

  @override
  String get callTypeMissed => 'Missed Call';

  @override
  String get callTypeBlocked => 'Blocked';

  @override
  String get callTypeUnknown => 'Unknown';

  @override
  String get loadMore => 'Load More';

  @override
  String get retry => 'Retry';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Failed to initialize call history: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Failed to refresh call history: $error';
  }

  @override
  String get timeInterceptorSettingsTitle => 'Call Frequency Interception Settings';

  @override
  String settingsLoadFailed(Object error) {
    return 'Failed to load settings: $error';
  }

  @override
  String settingsSaveFailed(Object error) {
    return 'Failed to save settings: $error';
  }

  @override
  String get noRecords => 'No call records';

  @override
  String get noMatchingRecords => 'No matching call records';

  @override
  String get search => 'Search';

  @override
  String get labelFilter => 'Label Filter';

  @override
  String get filterClear => 'Clear Filter';

  @override
  String get noCallRecords => 'No call records';

  @override
  String get refresh => 'Refresh';

  @override
  String get clearLabelFilter => 'Clear Label Filter';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get earlier => 'Earlier';

  @override
  String get statBlocked => 'Blocked';

  @override
  String get statAnswered => 'Answered';

  @override
  String get filterByLabel => 'Filter by Label';

  @override
  String get cancel => 'Cancel';

  @override
  String get clearFilter => 'Clear Filter';

  @override
  String get processingOperation => 'Processing...';

  @override
  String get operationSuccess => 'Operation succeeded';

  @override
  String get operationFailure => 'Operation failed';

  @override
  String get confirm => 'Confirm';

  @override
  String get configManagement => 'Configuration Management';

  @override
  String get importConfig => 'Import Configuration';

  @override
  String get exportConfig => 'Export Configuration';

  @override
  String get processing => 'Processing...';

  @override
  String get configUpdated => 'Configuration updated';

  @override
  String get checkFileFormat => 'Please check file format or permissions';

  @override
  String simInfoLoadFailure(Object error) {
    return 'Failed to load ScM card inforaation: $error';
  }

  @override
  String get operationFailed => 'Operation failed';

  @override
  String get importSuccess => 'Configuration imported successfully';

  @override
  String get importFailure => 'Failed to import configuration';

  @override
  String get exportSuccess => 'Configuration exported successfully';

  @override
  String get exportFailure => 'Failed to export configuration';

  @override
  String axisPosition(Object axis) {
    return '$axis Position';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex error: $error';
  }

  @override
  String get addToRules => 'Add to Rules';

  @override
  String get addToAllowedRules => 'Add to Allowed Rules';

  @override
  String get addToBlockedRules => 'Add to Blocked Rules';

  @override
  String get addToWhitelist => 'Add to Whitelist';

  @override
  String get addToBlacklist => 'Add to Blacklist';

  @override
  String get addedToAllowedRules => 'Added to Allowed Rules';

  @override
  String get addedToBlockedRules => 'Added to Blocked Rules';

  @override
  String get addedToWhitelist => 'Added to Whitelist';

  @override
  String get addedToBlacklist => 'Added to Blacklist';

  @override
  String get addRuleFailed => 'Failed to add rule';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => 'Please enter both phone number and regex pattern';

  @override
  String get enterRuleNameAndPatternMessage => 'Please enter rule name and pattern';

  @override
  String get ruleSavedSuccessMessage => 'Rule saved successfully!';

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get regexTesterTitle => 'Regex Tester';

  @override
  String get enterPhoneNumberHint => 'Enter phone number to test';

  @override
  String get enterRegexHint => 'Enter regular expression';

  @override
  String get enterRuleNameHint => 'Enter name for this rule';

  @override
  String get testButtonText => 'TEST';

  @override
  String get saveButtonText => 'SAVE';

  @override
  String get startColor => 'Start Color';

  @override
  String get endColor => 'End Color';

  @override
  String get height => 'Height';

  @override
  String get width => 'Width';

  @override
  String get labelIconColor => 'Label Icon Color';

  @override
  String get locationIconColor => 'Location Icon Color';

  @override
  String get callTypeIconColor => 'Call Type Icon Color';

  @override
  String get avatarBorderColor => 'Avatar Border Color';

  @override
  String get nameColor => 'Name Color';

  @override
  String get numberColor => 'Number Color';

  @override
  String get locationColor => 'Location Color';

  @override
  String get carrierColor => 'Carrier Color';

  @override
  String get countryNameColor => 'Country Name Color';

  @override
  String get labelsColor => 'Labels Color';

  @override
  String get countColor => 'Count Color';

  @override
  String get numberTypeColor => 'Number Type Color';

  @override
  String get stirColor => 'STIR Color';

  @override
  String get simCardColor => 'SIM Card Color';

  @override
  String get nameFontSize => 'Name Font Size';

  @override
  String get carrierFontSize => 'Carrier Font Size';

  @override
  String get countryNameFontSize => 'Country Name Font Size';

  @override
  String get labelsFontSize => 'Labels Font Size';

  @override
  String get countFontSize => 'Count Font Size';

  @override
  String get numberTypeFontSize => 'Number Type Font Size';

  @override
  String get numberFontSize => 'Number Font Size';

  @override
  String get locationFontSize => 'Location Font Size';

  @override
  String get stirFontSize => 'STIR Font Size';

  @override
  String get simCardFontSize => 'SIM Card Font Size';

  @override
  String get labelsPosition => 'Labels Position';

  @override
  String get countPosition => 'Count Position';

  @override
  String get subscriptionManagementTitle => 'Subscription Management';

  @override
  String get subscriptionEmptyState => 'No subscriptions available';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Failed to toggle subscription status: $error';
  }

  @override
  String get contactsPageTitle => 'Contacts Management';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Failed to load contacts: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Contact Subscriptions';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Failed to load contact subscriptions: $error';
  }

  @override
  String get subscriptionPageTitle => 'Subscription Management';

  @override
  String get subscriptionEmptyText => 'No subscriptions yet';

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String get homeTab => 'Home';

  @override
  String get callHistoryTab => 'Call History';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get settingsTab => 'Settings';

  @override
  String get numberTypePosition => 'Number Type Position';

  @override
  String get numberPosition => 'Number Position';

  @override
  String get locationPosition => 'Location Position';

  @override
  String get stirPosition => 'STIR Position';

  @override
  String get simCardPosition => 'SIM Card Position';

  @override
  String get callTypePosition => 'Call Type Position';

  @override
  String get avatarSize => 'Avatar Size';

  @override
  String get avatarBorderSize => 'Avatar Border Size';

  @override
  String get iconSize => 'Icon Size';

  @override
  String get avatarPosition => 'Avatar Position';

  @override
  String get namePosition => 'Name Position';

  @override
  String get carrierPosition => 'Carrier Position';

  @override
  String get countryRegionNamePosition => 'Country/Region Name Position';

  @override
  String get colorPickerTitle => 'Choose Color';

  @override
  String get enableTimeInterceptor => 'Enable Time Interceptor';

  @override
  String get timeInterceptorDescription => 'Automatically intercept potential spam calls based on call frequency';

  @override
  String get timeInterceptorTitle => 'Enable Call Frequency Interception';

  @override
  String get timeInterceptorSubtitle => 'Automatically intercept potential spam calls based on call frequency';

  @override
  String get timeWindowSetting => 'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted';

  @override
  String get timeInterceptorExplanationTitle => 'Call Frequency Interception Explanation';

  @override
  String get timeInterceptorExplanationContent => 'The call frequency interception feature analyzes call frequency to automatically identify and intercept frequent spam calls.';

  @override
  String get howItWorksTitle => 'How It Works:';

  @override
  String get howItWorksPoint1 => '• The system will automatically intercept calls from the same number within the set time window';

  @override
  String get howItWorksPoint2 => '• Shorter time windows result in stricter interception; longer time windows result in looser interception';

  @override
  String get howItWorksPoint3 => '• The system checks call logs to determine if it\'s a repeated call';

  @override
  String get useCasesTitle => 'Use Cases:';

  @override
  String get useCasesPoint1 => '• Identify auto-redial spam calls';

  @override
  String get useCasesPoint2 => '• Intercept marketing calls that call multiple times in a short period';

  @override
  String get useCasesPoint3 => '• Prevent phone bombing and harassment';

  @override
  String get differentFromLocalCounter => 'This feature is different from the local counter filter, as it focuses on repeated call patterns in a short time rather than long-term marking counts.';

  @override
  String timeWindowLabel(int minutes) {
    return 'Interception Time Window (minutes): $minutes';
  }

  @override
  String get timeWindowDescription => 'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted';

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
  String get phoneNumberLabel => 'Phone Number *';

  @override
  String get regexPatternLabel => 'Regex Pattern';

  @override
  String get ruleNameLabel => 'Rule Name';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get matchSuccessfulMessage => 'Match successful!';

  @override
  String get matchFailedMessage => 'Match failed!';

  @override
  String regexError(Object error) {
    return 'Regex error: $error';
  }

  @override
  String get ruleSaveSuccess => 'Rule saved successfully!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get ruleNamePatternRequired => 'Please enter rule name and pattern';

  @override
  String get phoneNumberRegexRequired => 'Please enter both phone number and regex pattern';

  @override
  String get callFilterSettings => 'Call Filter Settings';

  @override
  String get fraudScamLikely => 'Fraud/Scam Likely';

  @override
  String get spamLikely => 'Spam Likely';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get robocall => 'Robocall';

  @override
  String get delivery => 'Delivery';

  @override
  String get takeaway => 'Takeaway';

  @override
  String get ridesharing => 'Ridesharing';

  @override
  String get insurance => 'Insurance';

  @override
  String get loan => 'Loan';

  @override
  String get customerService => 'Customer Service';

  @override
  String get financial => 'Financial';

  @override
  String get bank => 'Bank';

  @override
  String get education => 'Education';

  @override
  String get medical => 'Medical';

  @override
  String get charity => 'Charity';

  @override
  String get other => 'Other';

  @override
  String get collection => 'Debt Collection';

  @override
  String get survey => 'Survey';

  @override
  String get political => 'Political';

  @override
  String get ecommerce => 'E-commerce';

  @override
  String get risk => 'Risk';

  @override
  String get enhancedFilterSettings => 'Enhanced Filter Settings';

  @override
  String get simSlotManagement => 'SIM Slot Management';

  @override
  String get statisticsPageTitle => 'Data Analysis';

  @override
  String get blockedCallsTitle => 'Blocked Calls';

  @override
  String get blockTypeAnalysisTitle => 'Block Type Analysis';

  @override
  String get weeklyChartTitle => 'Weekly Blocked Calls';

  @override
  String get monthlyChartTitle => 'Monthly Blocked Calls';

  @override
  String get yearlyChartTitle => 'Yearly Blocked Calls';

  @override
  String get callerIdCustomizationTitle => 'Customize Caller ID';

  @override
  String get windowSizeSetting => 'Window Size';

  @override
  String get backgroundGradientSetting => 'Background Gradient';

  @override
  String get textColorsSetting => 'Text & Label Colors';

  @override
  String get fontSizesSetting => 'Font Sizes';

  @override
  String get avatarIconSizesSetting => 'Avatar & Icon Sizes';

  @override
  String get elementPositionsSetting => 'Element Positions';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String loadRulesFailed(Object error) {
    return 'Failed to load rules: $error';
  }

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
  String get phoneNumberHint => 'Enter phone number';

  @override
  String get ruleNameHint => 'Rule name (optional)';

  @override
  String get addRuleButton => 'Add Rule';

  @override
  String get simSlotRuleManagementTitle => 'Rule Management';

  @override
  String get globalFilterSettings => 'Global Filter Settings';

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
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get unknownTag => 'Tag: Unknown';

  @override
  String get testButton => 'TEST';

  @override
  String get saveButton => 'SAVE';

  @override
  String get matchSuccessful => 'Match successful!';

  @override
  String get matchFailed => 'Match failed!';

  @override
  String get enterBothPhoneNumberAndRegexPattern => 'Please enter both phone number and regex pattern';

  @override
  String get enterRuleNameAndPattern => 'Please enter rule name and pattern';

  @override
  String get ruleSavedSuccessfully => 'Rule saved successfully!';

  @override
  String saveFailed(Object error) {
    return 'Save failed: $error';
  }

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
  String get unknown => 'Unknown';

  @override
  String nameLabel(Object name) {
    return 'Name: $name';
  }

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Marked by $count';
  }

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
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
  String get addName => 'Add Name';

  @override
  String get enterName => 'Enter contact name';

  @override
  String get save => 'Save';

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

  @override
  String get addLabelToCall => 'Add Label to Call Record';

  @override
  String get currentLabels => 'Current Labels:';

  @override
  String get expandLabelSelector => 'Expand Label Selector';

  @override
  String get collapseLabelSelector => 'Collapse Label Selector';

  @override
  String get close => 'Close';

  @override
  String get labelRemoved => 'Label removed';

  @override
  String labelRemoveFailed(Object error) {
    return 'Failed to remove label: $error';
  }

  @override
  String get labelUpdated => 'Label updated';

  @override
  String labelUpdateFailed(Object error) {
    return 'Failed to update label: $error';
  }

  @override
  String get addLabel => 'Add Label';

  @override
  String get callback => 'Call Back';

  @override
  String callbackTo(String number) {
    return 'Call back to $number';
  }

  @override
  String get chartToday => 'Today';

  @override
  String get chartOneDayAgo => '1 day ago';

  @override
  String get chartThreeDaysAgo => '3 days ago';

  @override
  String get chartOneWeekAgo => '1 week ago';

  @override
  String get chartTenDaysAgo => '10 days ago';

  @override
  String get chartOneMonthAgo => '1 month ago';

  @override
  String chartMonthFormat(int month) {
    return 'Month $month';
  }

  @override
  String get defaultPeriod => 'Week';

  @override
  String get selectSimSlot => 'Select SIM Slot';

  @override
  String get basicRuleFilterSettings => 'Basic Rule Filter Settings';

  @override
  String get remoteFilterSettings => 'Remote Filter Settings';

  @override
  String get localFilterSettings => 'Local Filter Settings';

  @override
  String get globalFilterToggleInstructions => 'Configure global filter settings that apply to all SIM slots:';

  @override
  String get simSlotSettings => 'SIM Slot Settings';

  @override
  String get globalSettings => 'Global Settings';

  @override
  String get updateCallFilterConfig => 'Update Call Filter Configuration';
}
