// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get contactsManagementTitle => 'Contacts Management';

  @override
  String selectedItemsCount(Object count) {
    return '$count items selected';
  }

  @override
  String get editContact => 'Edit Contact';

  @override
  String get deleteContactTitle => 'Delete Contact';

  @override
  String get deleteContactConfirmation => 'Are you sure you want to delete contact';

  @override
  String get deleteSuccess => 'Delete successful';

  @override
  String get deleteFailed => 'Delete failed';

  @override
  String get contactDeleted => 'Contact deleted';

  @override
  String get deleteError => 'Delete';

  @override
  String get selectLabelTitle => 'Select Label';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get batchDeleteContactsTitle => 'Batch Delete Contacts';

  @override
  String get batchDeleteContactsConfirmation => 'Are you sure you want to delete the selected contacts?';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get editLabelButton => 'Edit Label';

  @override
  String get deleteButton => 'Delete';

  @override
  String get searchContactsHint => 'Search contacts';

  @override
  String get frequentContacts => 'Frequent Contacts';

  @override
  String get manageButton => 'Manage';

  @override
  String get noContactsMessage => 'No contacts';

  @override
  String get noMatchingContactsMessage => 'No matching contacts';

  @override
  String get addContactButton => 'Add Contact';

  @override
  String get importExportContactsTitle => 'Import/Export Contacts';

  @override
  String get importContactsButton => 'Import Contacts';

  @override
  String get exportContactsButton => 'Export Contacts';

  @override
  String get refreshButton => 'Refresh';

  @override
  String get fileFormatCSV => 'CSV Format';

  @override
  String get fileFormatJSON => 'JSON Format';

  @override
  String fileSavedMessage(Object path) {
    return 'File saved to: $path';
  }

  @override
  String get unsupportedFileFormatMessage => 'Unsupported file format';

  @override
  String get changeLabelButton => 'Change Label';

  @override
  String get dashboardTitle => 'Data Analysis';

  @override
  String get monthlyTotal => 'Monthly Total';

  @override
  String get interceptedCommunications => 'Intercepted Communications';

  @override
  String get adPlaceholder => 'Ad Placeholder';

  @override
  String get adPlaceholderDesc => 'Google AdMob ads can be integrated here';

  @override
  String get interceptedCalls => 'Intercepted Calls';

  @override
  String get filteredSMS => 'Filtered SMS';

  @override
  String get allowRules => 'Allow Rules';

  @override
  String get blockRules => 'Block Rules';

  @override
  String get silenceRules => 'Silence Rules';

  @override
  String get noneActionRules => 'None Action Rules';

  @override
  String get thisWeek => 'This Week';

  @override
  String get total => 'Total';

  @override
  String get interceptTrend => 'Intercept Trend';

  @override
  String get weekPeriod => 'Week';

  @override
  String get monthPeriod => 'Month';

  @override
  String get yearPeriod => 'Year';

  @override
  String get exportStatisticsButton => 'Export Statistics Data';

  @override
  String get statisticsExportComingSoon => 'Statistics export feature coming soon';

  @override
  String get filterControlPanelTitle => 'Filter Control Panel';

  @override
  String get configureSimCardFilterRules => 'Configure SIM Card Filter Rules';

  @override
  String get selectSimCard => 'Select SIM Card';

  @override
  String get globalSettings => 'Global Settings';

  @override
  String get unassignedSIMCard => 'Unnamed SIM Card';

  @override
  String get basicRuleFiltering => 'Basic Rule Filtering';

  @override
  String get rejectAllCalls => 'Reject All Calls';

  @override
  String get rejectAllCallsDescription => 'When enabled, all calls will be rejected with highest priority';

  @override
  String get allowWhitelistedNumbers => 'Allow Whitelisted Numbers';

  @override
  String get allowWhitelistedNumbersDescription => 'Allow all numbers in the whitelist';

  @override
  String get allowRegexAllowRules => 'Allow Regex Allow Rules';

  @override
  String get allowRegexAllowRulesDescription => 'Enable regex-based allow rules';

  @override
  String get allowRegexBlockRules => 'Allow Regex Block Rules';

  @override
  String get allowRegexBlockRulesDescription => 'Enable regex-based block rules';

  @override
  String get localCountFiltering => 'Local Count Filtering';

  @override
  String get enableLocalCountFilter => 'Enable Local Count Filter';

  @override
  String get enableLocalCountFilterDescription => 'Automatically filter spam calls based on local marking count';

  @override
  String get rejectExceededNumbers => 'Reject Exceeded Numbers';

  @override
  String get rejectExceededNumbersDescription => 'Automatically reject all numbers exceeding the count threshold';

  @override
  String get allowNonExceededNumbers => 'Allow Non-Exceeded Numbers';

  @override
  String get allowNonExceededNumbersDescription => 'Automatically allow all numbers not exceeding the count threshold';

  @override
  String get remoteNumberFiltering => 'Remote Number Filtering';

  @override
  String get enableRemoteNumberFilter => 'Enable Remote Number Filter';

  @override
  String get enableRemoteNumberFilterDescription => 'Automatically filter spam calls based on remote database information';

  @override
  String get prioritizeRemoteAction => 'Prioritize Remote Action';

  @override
  String get prioritizeRemoteActionDescription => 'Prioritize action settings from the remote database';

  @override
  String get timeInterceptor => 'Time Interceptor';

  @override
  String get enableTimeInterception => 'Enable Time Interception';

  @override
  String get enableTimeInterceptionDescription => 'Intercept repeated calls within a short time';

  @override
  String get interceptionTimeInterval => 'Interception Time Interval';

  @override
  String get minutes => 'minutes';

  @override
  String get filterExplanation => 'Filter Explanation';

  @override
  String get basicRuleFilteringExplanation => '• Basic Rule Filtering: Filtering rules based on blacklist, whitelist, and regex';

  @override
  String get localCountFilteringExplanation => '• Local Count Filtering: Filtering rules based on local marking count';

  @override
  String get remoteNumberFilteringExplanation => '• Remote Number Filtering: Filtering rules based on remote database information';

  @override
  String get timeInterceptorExplanation => '• Time Interceptor: Intercept repeated calls within a short time';

  @override
  String get simCardConfigurationExplanation => '• SIM Card Configuration: Set independent filtering rules for each SIM card';

  @override
  String get filterPriorityNote => 'Note: There are priority relationships between filters, please refer to the help documentation for details';

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
    return 'Failed to load SIM card information: $error';
  }

  @override
  String get operationFailed => 'Operation failed';

  @override
  String get importSuccess => 'Import successful';

  @override
  String get importFailure => 'Failed to import configuration';

  @override
  String get exportSuccesslly => 'Configuration exported successfully';

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
  String get manageContacts => 'Manage';

  @override
  String get favoriteContacts => 'Favorite Contacts';

  @override
  String get deleteContact => 'Delete Contact';

  @override
  String deleteContactConfirm(Object name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get selectLabel => 'Select Label';

  @override
  String get labelUpdated => 'Label updated';

  @override
  String get updateLabelFailed => 'Failed to update label';

  @override
  String get batchDeleteContacts => 'Batch Delete Contacts';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Are you sure you want to delete $count selected contacts?';
  }

  @override
  String contactsDeleted(Object count) {
    return 'Deleted $count contacts';
  }

  @override
  String get batchDeleteFailed => 'Batch delete failed';

  @override
  String get editLabel => 'Edit Label';

  @override
  String get edit => 'Edit';

  @override
  String get searchContacts => 'Search Contacts';

  @override
  String get changeLabel => 'Change Label';

  @override
  String get noContacts => 'No contacts yet';

  @override
  String get noMatchingContacts => 'No matching contacts';

  @override
  String get addContact => 'Add Contact';

  @override
  String get importExportContacts => 'Import/Export Contacts';

  @override
  String get importContacts => 'Import Contacts';

  @override
  String get exportContacts => 'Export Contacts';

  @override
  String importFailed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String get selectExportFormat => 'Select Export Format';

  @override
  String get csvFormat => 'CSV Format';

  @override
  String get jsonFormat => 'JSON Format';

  @override
  String fileSavedTo(Object path) {
    return 'File saved to: $path';
  }

  @override
  String get exportFailed => 'Export failed';

  @override
  String get unsupportedFileFormat => 'Unsupported file format';

  @override
  String selectedItems(Object count) {
    return '$count items selected';
  }

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
  String get about => 'About';

  @override
  String get callerIdApp => 'Caller ID App';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows => 'This app is a powerful caller ID tool that allows you to identify and block unwanted calls.';

  @override
  String get features => 'Features';

  @override
  String get onlineCallerIdSubscription => 'Online Caller ID Subscription';

  @override
  String get wildcardSupportForFlexibleFiltering => 'Wildcard Support for Flexible Filtering';

  @override
  String get blacklistingAndWhitelisting => 'Blacklisting and Whitelisting';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo => 'Join the Telegram Channel and Group for More Info';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get github => 'GitHub';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get import => 'Import';

  @override
  String get export => 'Export';

  @override
  String get phoneRuleSubscription => 'Phone Rule Subscription';

  @override
  String get aboutPhoneSubscriptionRules => 'About Phone Subscription Rules';

  @override
  String get phoneSubscriptionRulesDescription => 'Subscribe to phone rule lists via URL to automatically update whitelist and blacklist rules. Supports JSON format rule files.';

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
  String get testButtonLabel => 'TEST';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get matchSuccessfulMessage => 'Match successful!';

  @override
  String get matchFailedMessage => 'Match Failed!';

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
  String get allowAllBlockRules => 'Allow All Block Rules';

  @override
  String get allowAllBlockRulesDesc => 'Allow calls from block rules';

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
  String get regexPatternLabel => 'Regex Pattern';

  @override
  String get ruleNameLabel => 'Rule Name';

  @override
  String get testButton => 'TEST';

  @override
  String get saveButton => 'SAVE';

  @override
  String get matchSuccessful => 'Match successful!';

  @override
  String get matchFailed => 'Match failed!';

  @override
  String regexError(Object error) {
    return 'Regex error: $error';
  }

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
  String get allowRegexAllowRulesDesc => 'Enable regex pattern matching for allow rules';

  @override
  String get allowAllAllowRules => 'Allow All Allow Rules';

  @override
  String get allowAllAllowRulesDesc => 'Allow calls from allow rules';

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
  String get selectedDateRange => 'Selected date range';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get dailyStatistics => 'Daily Statistics';

  @override
  String get dailyStatisticsDesc => 'Receive daily statistics about blocked calls and messages';

  @override
  String get weeklyReport => 'Weekly Report';

  @override
  String get weeklyReportDesc => 'Receive weekly summary report of call blocking activity';

  @override
  String get phoneSubscriptionTitle => 'Phone Rule Subscriptions';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Failed to change subscription status: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Failed to update subscription: $error';
  }

  @override
  String get deleteSubscription => 'Delete Subscription';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Are you sure you want to delete subscription \"$name\"?';
  }

  @override
  String get subscriptionDeleted => 'Subscription deleted';

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Failed to delete subscription: $error';
  }

  @override
  String get addAllowSubscription => 'Add Allow Subscription';

  @override
  String get addBlockSubscription => 'Add Block Subscription';

  @override
  String get addSilenceSubscription => 'Add Silence Subscription';

  @override
  String get addNoneSubscription => 'Add None Subscription';

  @override
  String get subscriptionName => 'Subscription Name';

  @override
  String get enterSubscriptionName => 'Enter subscription name';

  @override
  String get subscriptionUrl => 'Subscription URL';

  @override
  String get enterSubscriptionUrl => 'Enter subscription URL';

  @override
  String get enterValidNameAndUrl => 'Please enter valid name and URL';

  @override
  String get add => 'Add';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Subscription \"$name\" added successfully';
  }

  @override
  String addSubscriptionFailed(Object error) {
    return 'Failed to add subscription: $error';
  }

  @override
  String get noSubscriptions => 'No subscriptions';

  @override
  String get addSubscription => 'Add Subscription';

  @override
  String get aboutPhoneSubscriptions => 'About Phone Subscriptions';

  @override
  String get aboutPhoneSubscriptionsDesc => 'Subscribe to phone rule lists via URL, automatically update blacklist and whitelist rules. Supports JSON format rule files.';

  @override
  String get aboutContactSubscription => 'About Contact Subscription';

  @override
  String get contactSubscriptionDescription => 'Subscribe to contact lists via URL, automatically update contact information and labels. Supports JSON format data.';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get blacklist => 'Blacklist';

  @override
  String get synchronized => 'Synchronized';

  @override
  String lastUpdated(Object date) {
    return 'Last updated: $date';
  }

  @override
  String get syncNow => 'Sync Now';

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
  String get allCallsTab => 'All';

  @override
  String get phoneCallsTab => 'Phone';

  @override
  String get smsTab => 'SMS';

  @override
  String get weeklyBlockedCallsSummary => 'Weekly Blocked Calls Summary';

  @override
  String get monthlyTotalLabel => 'Monthly Total';

  @override
  String get blockedCommunications => 'Blocked Communications';

  @override
  String get blockedPhoneLabel => 'Blocked Calls';

  @override
  String get filteredSmsLabel => 'Filtered SMS';

  @override
  String get whitelistLabel => 'Whitelist';

  @override
  String get blacklistLabel => 'Blacklist';

  @override
  String get blockingTrend => 'Blocking Trend';

  @override
  String get exportStatisticsData => 'Export Statistics Data';

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
  String get updateCallFilterConfig => 'Update Call Filter Configuration';

  @override
  String loadLabelFailed(Object error) {
    return 'Failed to load labels: $error';
  }

  @override
  String addLabelFailed(Object error) {
    return 'Failed to add labels: $error';
  }

  @override
  String get selectedLabel => 'Selected:';

  @override
  String get noLabels => 'No Labels';

  @override
  String get addLabelButton => 'Add Label';

  @override
  String get rulesImported => 'Rules imported successfully';

  @override
  String rulesImportFailed(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String get importRules => 'Import Rules';

  @override
  String get importRulesInstructions => 'Import rules from a CSV file';

  @override
  String get importRulesButton => 'Import Rules';

  @override
  String importRulesError(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String get importRulesSuccess => 'Rules imported successfully';

  @override
  String get ruleManagementTitle => 'Rule Management';

  @override
  String ruleLoadFailed(Object error) {
    return 'Failed to load rules: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Rule $status successfully';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operation failed: $error';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Delete Rule';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Are you sure you want to delete this $ruleType?';
  }

  @override
  String get ruleDeleteSuccess => 'Rule deleted successfully';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get actionFilterTitle => 'Filter by Action Type';

  @override
  String get actionFilterAll => 'All Filter';

  @override
  String get actionAll => 'All';

  @override
  String get actionAllow => 'Allow';

  @override
  String get actionBlock => 'Block';

  @override
  String get actionSilence => 'Silence';

  @override
  String get actionNone => 'No Action';

  @override
  String get actionUnknown => 'Unknown';

  @override
  String get labelFilterTooltip => 'Label Filter';

  @override
  String get actionFilterTooltip => 'Action Filter';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String get exportRules => 'Export Rules';

  @override
  String get addRuleTooltip => 'Add Rule';

  @override
  String labelTag(Object labelId) {
    return 'Label: $labelId';
  }

  @override
  String actionTag(Object actionType) {
    return 'Action: $actionType';
  }

  @override
  String noMatchingRules(Object ruleType) {
    return 'No matching $ruleType';
  }

  @override
  String noRules(Object ruleType) {
    return 'No $ruleType yet';
  }

  @override
  String get clearLabelFilterButton => 'Clear Label Filter';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Failed to change subscription status: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Subscription updated successfully';

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Failed to update subscription: $error';
  }

  @override
  String get synced => 'Synced';

  @override
  String get subscriptionDeleteConfirmTitle => 'Delete Subscription';

  @override
  String get subscriptionDeleteConfirmContent => 'Are you sure you want to delete this subscription?';

  @override
  String get subscriptionDeleteSuccess => 'Subscription deleted';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Failed to delete subscription: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Add Subscription';

  @override
  String get addSubscriptionButton => 'Add Subscription';

  @override
  String get nameUnknown => 'Name: Unknown';

  @override
  String nameWithValue(String name) {
    return 'Name: $name';
  }

  @override
  String markedByCount(int count) {
    return 'Marked by $count';
  }

  @override
  String get verifiedText => 'Verified';

  @override
  String get notVerifiedText => 'Not Verified';

  @override
  String get verificationFailedText => 'Failed';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String get contactsManagementPageTitle => 'Contacts Management Page';

  @override
  String get failedToLoadContacts => 'Failed to load contacts';

  @override
  String get contactUpdateSuccess => 'Contact updated successfully';

  @override
  String get contactAddSuccess => 'Contact added successfully';

  @override
  String get name => 'Name';

  @override
  String get enterContactName => 'Please enter contact name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhoneNumber => 'Please enter phone number';

  @override
  String get emailOptional => 'Email (Optional)';

  @override
  String get enterEmail => 'Please enter email';

  @override
  String get nameAndPhoneNumberRequired => 'Name and phone number cannot be empty';

  @override
  String get update => 'Update';

  @override
  String get failedToUpdateContact => 'Failed to update contact';

  @override
  String get failedToAddContact => 'Failed to add contact';

  @override
  String get manageFavoriteContacts => 'Manage Favorite Contacts';

  @override
  String get done => 'Done';

  @override
  String get addedToFavorites => 'Added to favorite contacts';

  @override
  String get removedFromFavorites => 'Removed from favorite contacts';

  @override
  String get confirmDeleteContact => 'Are you sure you want to delete';

  @override
  String get selectTag => 'Select Tag';

  @override
  String get confirmBatchDeleteContacts => 'Are you sure you want to delete the selected';

  @override
  String get contacts => 'contacts?';

  @override
  String get removeFavorite => 'Remove Favorite';

  @override
  String get addFavorite => 'Add Favorite';

  @override
  String get changeTag => 'Change Tag';

  @override
  String get addToFavoriteContacts => 'Add to Favorite Contacts';

  @override
  String dataLoadingFailed(Object error) {
    return 'Failed to load data: $error';
  }

  @override
  String get overview => 'Overview';

  @override
  String get statisticsGrid => 'Statistics Grid';

  @override
  String get trendChart => 'Trend Chart';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get yearly => 'Yearly';

  @override
  String get exportSuccess => 'Export successful';

  @override
  String get blockedCalls => 'Blocked Calls';

  @override
  String get filteredSms => 'Filtered SMS';

  @override
  String get totalBlocked => 'Total Blocked';

  @override
  String get totalFiltered => 'Total Filtered';

  @override
  String get trend => 'Trend';

  @override
  String get exportData => 'Export Data';

  @override
  String get exporting => 'Exporting...';

  @override
  String get exportComplete => 'Export Complete';

  @override
  String get exportError => 'Export Error';

  @override
  String get homePageTitle => 'Home Page';

  @override
  String get callHistory => 'Call History';

  @override
  String get smsHistory => 'SMS History';

  @override
  String get noData => 'No Data';

  @override
  String get loadingData => 'Loading Data...';

  @override
  String get loadFailed => 'Load Failed';

  @override
  String get searchHint => 'Search...';

  @override
  String get filter => 'Filter';

  @override
  String get all => 'All';

  @override
  String get blocked => 'Blocked';

  @override
  String get filtered => 'Filtered';

  @override
  String get last7Days => 'Last 7 Days';

  @override
  String get last30Days => 'Last 30 Days';

  @override
  String get customRange => 'Custom Range';

  @override
  String get apply => 'Apply';

  @override
  String get selectDateRange => 'Select Date Range';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get reset => 'Reset';

  @override
  String get filterManagement => 'Filter Management';

  @override
  String get addFilter => 'Add Filter';

  @override
  String get editFilter => 'Edit Filter';

  @override
  String get deleteFilter => 'Delete Filter';

  @override
  String get filterName => 'Filter Name';

  @override
  String get enterFilterName => 'Please enter filter name';

  @override
  String get filterPattern => 'Filter Pattern';

  @override
  String get enterFilterPattern => 'Please enter filter pattern';

  @override
  String get filterType => 'Filter Type';

  @override
  String get call => 'Call';

  @override
  String get sms => 'SMS';

  @override
  String get both => 'Both';

  @override
  String get action => 'Action';

  @override
  String get block => 'Block';

  @override
  String get allow => 'Allow';

  @override
  String get mute => 'Mute';

  @override
  String get saveFilter => 'Save Filter';

  @override
  String get filterSaveSuccess => 'Filter saved successfully';

  @override
  String get filterSaveFailed => 'Filter save failed';

  @override
  String get confirmDeleteFilter => 'Are you sure you want to delete this filter?';

  @override
  String get filterDeleteSuccess => 'Filter deleted successfully';

  @override
  String get filterDeleteFailed => 'Filter delete failed';

  @override
  String get noFilters => 'No filters yet';

  @override
  String get searchFilters => 'Search Filters';

  @override
  String get filterDetails => 'Filter Details';

  @override
  String get pattern => 'Pattern';

  @override
  String get type => 'Type';

  @override
  String get actionType => 'Action Type';

  @override
  String get blockedCallAction => 'Blocked Call Action';

  @override
  String get incomingCallInterceptAction => 'Incoming Call Intercept Action';

  @override
  String get chooseDefaultInterceptAction => 'Choose the default intercept action';

  @override
  String get endCallImmediately => 'End call immediately';

  @override
  String get answerThenHangup => 'Answer then hang up';

  @override
  String get silenceAndNoAnswer => 'Silence and no answer';
}
