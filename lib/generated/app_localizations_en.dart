// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get filterControlPanelTitle => 'Filter Control Panel';

  @override
  String get configureSimCardFilterRules => 'Configure SIM Card Filter Rules';

  @override
  String get selectSimCard => 'Select SIM Card';

  @override
  String get globalSettings => 'Global Settings';

  @override
  String get unassignedSIMCard => 'Unassigned SIM Card';

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
  String get enableLocalCountFilterDescription => 'Automatically filter spam calls based on call marking count';

  @override
  String get rejectExceededNumbers => 'Reject Exceeded Numbers';

  @override
  String get rejectExceededNumbersDescription => 'Automatically reject numbers exceeding the count threshold';

  @override
  String get allowNonExceededNumbers => 'Allow Non-Exceeded Numbers';

  @override
  String get allowNonExceededNumbersDescription => 'Automatically allow numbers not exceeding the count threshold';

  @override
  String get remoteNumberFiltering => 'Remote Number Filtering';

  @override
  String get enableRemoteNumberFilter => 'Enable Remote Number Filter';

  @override
  String get enableRemoteNumberFilterDescription => 'Use remote database to filter numbers';

  @override
  String get prioritizeRemoteAction => 'Prioritize Remote Action Settings';

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
  String operationFailed(Object error) {
    return 'Operation failed: $error';
  }

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
  String addRuleFailed(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => 'Please enter both phone number and regex pattern.';

  @override
  String get enterRuleNameAndPatternMessage => 'Please enter both rule name and regex pattern.';

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
  String get enterRegexHint => 'Enter regex pattern';

  @override
  String get enterRuleNameHint => 'Enter rule name';

  @override
  String get testButtonText => 'Test';

  @override
  String get saveButtonText => 'Save';

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
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

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
  String get contactsManagementPageTitle => 'Contacts Management Page';

  @override
  String loadContactsFailed(Object error) {
    return 'Failed to load contacts: $error';
  }

  @override
  String get manageFrequentContacts => 'Manage Frequent Contacts';

  @override
  String get done => 'Done';

  @override
  String get addedToFavoriteContacts => 'Added to favorite contacts';

  @override
  String get removedFromFavoriteContacts => 'Removed from favorite contacts';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Failed to update favorite status: $error';
  }

  @override
  String get contactDeleted => 'Contact deleted';

  @override
  String get deleteFailed => 'Delete failed';

  @override
  String get searchForContacts => 'Search for contacts';

  @override
  String get importExportContactsTooltip => 'Import/Export Contacts';

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Failed to load SMS rules: $error';
  }

  @override
  String get addSmsRule => 'Add SMS Rule';

  @override
  String get ruleName => 'Rule Name';

  @override
  String get ruleNameHint => 'e.g., Family, Friends, etc.';

  @override
  String get senderRegexOptional => 'Sender Regex (Optional)';

  @override
  String get exampleRegexFormat => 'Example: ^10086\$ format';

  @override
  String get contentRegex => 'Content Regex';

  @override
  String get exampleContentRegex => 'e.g., .*offer.*';

  @override
  String get ruleAction => 'Rule Action';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => 'Rule name and content regex cannot be empty';

  @override
  String get invalidContentRegex => 'Invalid content regex';

  @override
  String get invalidSenderRegex => 'Invalid sender regex';

  @override
  String get smsRuleAddedSuccessfully => 'SMS rule added successfully';

  @override
  String failedToAddSmsRule(Object error) {
    return 'Failed to add SMS rule: $error';
  }

  @override
  String get editSmsRule => 'Edit SMS Rule';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS rule updated successfully';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Failed to update SMS rule: $error';
  }

  @override
  String get deleteSmsRule => 'Delete SMS Rule';

  @override
  String get confirmDeleteSmsRule => 'Are you sure you want to delete this SMS rule?';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS rule deleted successfully';

  @override
  String get smsRuleSubscription => 'SMS Rule Subscription';

  @override
  String get noSubscriptionsYet => 'No Subscriptions Yet';

  @override
  String get aboutSmsSubscriptionRules => 'About SMS Subscription Rules';

  @override
  String get smsSubscriptionRulesDescription => 'Subscribe to SMS rule lists via URL, supporting regular expression matching. You can set block or allow actions.';

  @override
  String get blockRule => 'Block Rule';

  @override
  String get allowRule => 'Allow Rule';

  @override
  String get pendingSync => 'Pending Sync';

  @override
  String lastUpdated(Object date) {
    return 'Last updated: $date';
  }

  @override
  String get syncNow => 'Sync Now';

  @override
  String get addSmsSubscription => 'Add SMS Subscription';

  @override
  String get subscriptionName => 'Subscription Name';

  @override
  String get subscriptionNameHint => 'Enter subscription name';

  @override
  String get subscriptionUrl => 'Subscription URL';

  @override
  String get subscriptionUrlHint => 'Enter subscription URL';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => 'Subscription name and URL cannot be empty';

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Failed to add SMS subscription: $error';
  }

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS subscription added successfully';

  @override
  String get deleteSubscription => 'Delete Subscription';

  @override
  String get confirmDeleteSubscription => 'Are you sure you want to delete this subscription?';

  @override
  String get subscriptionDeletedSuccessfully => 'Subscription deleted successfully';

  @override
  String get syncing => 'Syncing...';

  @override
  String get syncSuccessful => 'Sync successful';

  @override
  String get syncFailed => 'Sync failed';

  @override
  String get enableSubscriptionSuccessfully => 'Enable subscription successfully';

  @override
  String get disableSubscriptionSuccessfully => 'Disable subscription successfully';

  @override
  String get failedToToggleSubscriptionStatus => 'Failed to toggle subscription status';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Failed to delete SMS rule: $error';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS rules imported successfully';

  @override
  String failedToImportSmsRules(Object error) {
    return 'Failed to import SMS rules: $error';
  }

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS rules exported successfully to $filePath';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Failed to export SMS rules: $error';
  }

  @override
  String get smsRuleManagement => 'SMS Rule Management';

  @override
  String get noSmsRulesYet => 'No SMS rules yet';

  @override
  String get sender => 'Sender';

  @override
  String get content => 'Content';

  @override
  String get action => 'Action';

  @override
  String get label => 'Label';

  @override
  String get notSet => 'Not Set';

  @override
  String get enableRule => 'Enable Rule';

  @override
  String get ruleEnabledSuccessfully => 'Rule enabled successfully';

  @override
  String get ruleDisabledSuccessfully => 'Rule disabled successfully';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Failed to toggle rule status: $error';
  }

  @override
  String get editRule => 'Edit Rule';

  @override
  String get deleteRule => 'Delete Rule';

  @override
  String successfullyImportedRules(Object count) {
    return 'Successfully imported $count rules';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Failed to export rules: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String failedToAddRule(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String get exportSmsRules => 'Export SMS Rules';

  @override
  String get rulesExportedSuccessfully => 'Rules exported successfully';

  @override
  String get noValidSmsRulesFoundInFile => 'No valid SMS rules found in file';

  @override
  String get exampleSenderRegexHint => 'Example';

  @override
  String get exampleContentRegexHint => 'Example Content Regex';

  @override
  String get noContactsYet => 'No contacts yet';

  @override
  String get noMatchingContactsFound => 'No matching contacts found';

  @override
  String get addContactButton => 'Add Contact';

  @override
  String loadLabelsFailed(Object error) {
    return 'Failed to load labels: $error';
  }

  @override
  String get deleteLabel => 'Delete Label';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Are you sure you want to delete label \"$name\"';
  }

  @override
  String get labelDeleted => 'Label deleted';

  @override
  String deleteLabelFailed(Object error) {
    return 'Failed to delete label: $error';
  }

  @override
  String get addLabel => 'Add Label';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get iconCodeOptional => 'Icon Code (Optional)';

  @override
  String get enterIconCode => 'Enter icon code';

  @override
  String get selectLabelAndEnterPhoneNumber => 'Please select a label and enter a valid phone number';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Label \"$name\" added successfully';
  }

  @override
  String addLabelFailed(Object error) {
    return 'Failed to add label: $error';
  }

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Successfully imported $count labels';
  }

  @override
  String importLabelsFailed(Object error) {
    return 'Failed to import labels: $error';
  }

  @override
  String get labelsExportedSuccessfully => 'Labels exported successfully';

  @override
  String exportLabelsFailed(Object error) {
    return 'Failed to export labels: $error';
  }

  @override
  String get labelManagement => 'Label Management';

  @override
  String get importLabels => 'Import Labels';

  @override
  String get exportLabels => 'Export Labels';

  @override
  String get noLabels => 'No labels yet';

  @override
  String get aboutLabels => 'About Labels';

  @override
  String get labelDescription => 'Labels help you better manage contacts, add custom labels to phone numbers for easy identification of calls and messages.';

  @override
  String get labelCategories => 'Label Categories';

  @override
  String get dataAnalysis => 'Data Analysis';

  @override
  String get loadDataFailed => 'Failed to load data';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get dataAnalysisDashboardPage => 'Data Analysis Dashboard Page';

  @override
  String get monthlyTotal => 'Monthly Total';

  @override
  String get blockedCommunications => 'Blocked Communications';

  @override
  String get googleAdDisplayPosition => 'Google Ad Display Position';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob ads can be integrated here';

  @override
  String get ruleStatistics => 'Rule Statistics';

  @override
  String get blockCalls => 'Block Calls';

  @override
  String get filterSMS => 'Filter SMS';

  @override
  String get allowRules => 'Allow Rules';

  @override
  String get blockRules => 'Block Rules';

  @override
  String get silentRules => 'Silent Rules';

  @override
  String get noActionRules => 'No Action Rules';

  @override
  String get blockingTrend => 'Blocking Trend';

  @override
  String get dataExport => 'Data Export';

  @override
  String get statisticsExportFeatureComingSoon => 'Statistics export feature coming soon';

  @override
  String get exportStatisticsData => 'Export Statistics Data';

  @override
  String get thisWeek => 'This Week';

  @override
  String get total => 'Total';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get initializing => 'Initializing';

  @override
  String get loading => 'Loading...';

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
  String get failure => 'Failure';

  @override
  String get phoneRuleSubscription => 'Phone Rule Subscription';

  @override
  String get aboutPhoneSubscriptionRules => 'About Phone Subscription Rules';

  @override
  String get phoneSubscriptionRulesDescription => 'Subscribe to phone rule lists via URL to automatically update whitelist and blacklist rules. Supports JSON format rule files.';

  @override
  String get selectActionToPerform => 'Select the action to perform when the rule matches';

  @override
  String get allow => 'Allow';

  @override
  String get block => 'Block';

  @override
  String get silence => 'Silence';

  @override
  String get noAction => 'No Action';

  @override
  String get interceptAction => 'Intercept Action';

  @override
  String get selectSpecificActionForBlockedCalls => 'Select the specific action to perform when blocking calls';

  @override
  String get useGlobalSettings => 'Use Global Settings';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'Edit Allow/Block Rule';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => 'Rule name and phone number cannot be empty';

  @override
  String get ruleUpdateSuccess => 'Rule updated successfully';

  @override
  String updateRuleFailed(Object error) {
    return 'Failed to update rule: $error';
  }

  @override
  String get exampleFamilyFriends => 'e.g. Family, Friends, etc.';

  @override
  String get examplePhoneNumber => 'e.g. 10086, 12345, etc.';

  @override
  String get save => 'Save';

  @override
  String get endCallImmediately => 'End call immediately';

  @override
  String get answerThenHangUp => 'Answer Then Hang Up';

  @override
  String get silenceNoAnswer => 'Silence No Answer';

  @override
  String get unknownAction => 'Unknown Action';

  @override
  String get contactEditDialog => 'Contact Edit Dialog';

  @override
  String get addOrEditContactInfo => 'Used to add or edit contact information';

  @override
  String get showContactEditDialogStaticMethod => 'Static method to display contact edit dialog';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => 'Name and phone number cannot be empty';

  @override
  String updateContactFailed(Object error) {
    return 'Failed to update contact: $error';
  }

  @override
  String addContactFailed(Object error) {
    return 'Failed to add contact: $error';
  }

  @override
  String get name => 'Name';

  @override
  String get enterContactName => 'Please enter contact name';

  @override
  String get enterPhoneNumberMultiple => 'Please enter phone number, multiple numbers separated by commas';

  @override
  String get enterEmailOptional => 'Please enter email (optional)';

  @override
  String get editContact => 'Edit Contact';

  @override
  String get contactUpdateSuccess => 'Contact updated successfully';

  @override
  String get contactAddSuccess => 'Contact added successfully';

  @override
  String get countrySelectionDialog => 'Country Selection Dialog';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Failed to load SMS rules: $error';
  }

  @override
  String get addSmsFilterRule => 'Add SMS Filter Rule';

  @override
  String get exampleBlockMarketingSms => 'e.g. Block marketing SMS';

  @override
  String get exampleCouponPromotionDiscount => 'e.g. .*(coupon|promotion|discount).*';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMS filter rule added successfully';

  @override
  String ruleStatusChanged(Object status) {
    return 'Rule $status successfully';
  }

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get confirmDeleteSmsFilterRule => 'Are you sure you want to delete this SMS filter rule?';

  @override
  String get ruleDeletedSuccessfully => 'Rule deleted successfully';

  @override
  String deleteRuleFailed(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get importRules => 'Import Rules';

  @override
  String get importFeatureComingSoon => 'Import feature coming soon';

  @override
  String get exportRules => 'Export Rules';

  @override
  String get exportFeatureComingSoon => 'Export feature coming soon';

  @override
  String get unknown => 'Unknown';

  @override
  String get smsFilterRules => 'SMS Filter Rules';

  @override
  String get importExportRules => 'Import/Export Rules';

  @override
  String get noSmsFilterRulesYet => 'No SMS filter rules yet';

  @override
  String loadSettingsFailed(Object error) {
    return 'Failed to load settings: $error';
  }

  @override
  String get smsFilterEnabled => 'SMS filtering enabled';

  @override
  String get smsFilterDisabled => 'SMS filtering disabled';

  @override
  String get localNotificationEnabled => 'Local notification enabled';

  @override
  String get localNotificationDisabled => 'Local notification disabled';

  @override
  String get smsFilterSettings => 'SMS Filter Settings';

  @override
  String get aboutSmsFilter => 'About SMS Filtering';

  @override
  String get smsFilterDescription => 'SMS filtering helps you automatically filter spam messages and keep your message list clean. You can set filter rules and notification methods.';

  @override
  String get filterSettings => 'Filter Settings';

  @override
  String get enableSmsFilter => 'Enable SMS Filtering';

  @override
  String get enableSmsFilterDescription => 'When enabled, messages will be automatically filtered according to the rules';

  @override
  String get manageFilterRules => 'Manage Filter Rules';

  @override
  String get manageFilterRulesDescription => 'Add, edit, or delete SMS filter rules';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get enableLocalNotification => 'Use Local Notification';

  @override
  String get enableLocalNotificationDescription => 'When enabled, notifications for filtered messages will be displayed on the device';

  @override
  String get enterSearchContent => 'Please enter search content';

  @override
  String get noMatchingNumbersFound => 'No matching numbers found';

  @override
  String searchError(Object error) {
    return 'Search error: $error';
  }

  @override
  String get contactNotFound => 'Contact not found';

  @override
  String get labelNotFound => 'Label not found';

  @override
  String ruleNotFound(Object error) {
    return 'Rule not found: $error';
  }

  @override
  String get numberSearch => 'Number Search';

  @override
  String get enterPhoneNumberToStartSearch => 'Enter phone number to start search';

  @override
  String loadRulesFailed(Object error) {
    return 'Failed to load rules: $error';
  }

  @override
  String get countrySelectionDialogDescription => 'Used to select a country to query caller ID information';

  @override
  String get staticMethodToDisplayCountrySelectionDialog => 'Static method to display country selection dialog';

  @override
  String get selectCountry => 'Select Country';

  @override
  String get phoneRuleEditDialog => 'Phone Rule Edit Dialog';

  @override
  String get editPhoneRules => 'Used to edit phone rules';

  @override
  String get staticMethodToDisplayDialog => 'Static method to display dialog';

  @override
  String get editPhoneRule => 'Edit Phone Rule';

  @override
  String get editPhoneRuleTitle => 'Edit Phone Rule';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => 'Please select a label and enter a valid phone number';

  @override
  String get labelUpdateSuccess => 'Label \"\$labelText\" updated successfully';

  @override
  String get selectActionWhenRuleMatches => 'Select action when rule matches';

  @override
  String get selectActionWhenBlockingCalls => 'Select action when blocking calls';

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
  String get contactsManagement => 'Contacts Management';

  @override
  String get manage => 'Manage Contacts';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get matchSuccessfulMessage => 'Match successful!';

  @override
  String get matchFailedMessage => 'Match failed.';

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
  String get confirmDeleteContactName => 'Confirm delete?';

  @override
  String get updateFavoriteStatus => 'Update Favorite Status';

  @override
  String get bulkDelete => 'Batch Delete Contacts';

  @override
  String get tagsUpdated => 'Tags updated';

  @override
  String get updateTags => 'Update Tags';

  @override
  String get selectTags => 'Select Tags';

  @override
  String get bulkDeleteContacts => 'Batch Delete Contacts';

  @override
  String get confirmDeleteSelectedContacts => 'Are you sure to delete selected contacts?';

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
  String get enhancedFilterSettingsTitle => 'Enhanced Filter Settings';

  @override
  String get globalFilterDescription => 'Configure global filters for all SIM cards:';

  @override
  String get localCounterFilter => 'Local Counter Filter';

  @override
  String get localCounterFilterSubtitle => 'Automatically filter spam calls based on call frequency';

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
  String get statistics => 'Statistics';

  @override
  String get settings => 'Settings';

  @override
  String get callBlocking => 'Call Blocking';

  @override
  String get blockedSpamCalls => 'Blocked Spam Calls';

  @override
  String get simCardFilterRules => 'SIM Card Filter Rules';

  @override
  String get simCardFilterRulesDescription => 'Set different filtering rules based on SIM card slots';

  @override
  String get localCountFilter => 'Local Count Filter';

  @override
  String get localCountFilterDescription => 'Intercept frequent calls based on local number counts';

  @override
  String get remoteNumberFilter => 'Remote Number Filter';

  @override
  String get remoteNumberFilterDescription => 'Intercept harassing calls based on remote database information';

  @override
  String get callFilterRules => 'Call Filter Rules';

  @override
  String get callFilterRulesDescription => 'Set basic rules for call filtering';

  @override
  String get ruleManagement => 'Rule Management';

  @override
  String get createdRules => 'Created Rules';

  @override
  String get callStatistics => 'Call Statistics';

  @override
  String get monthlyCallCount => 'Monthly Calls';

  @override
  String get dataSourceReminder => 'Data Source Reminder';

  @override
  String get selectTrustedDataSource => 'Please select trusted data sources';

  @override
  String get important => 'Important';

  @override
  String get callerIdPreview => 'Caller ID Preview';

  @override
  String get ourOtherApps => 'Our Other Apps';

  @override
  String get ruleVerification => 'Rule Verification';

  @override
  String get enterPhoneNumberToVerify => 'Enter phone number to verify';

  @override
  String get verify => 'Verify';

  @override
  String get featureCenter => 'Feature Center';

  @override
  String get allowBlock => 'Allow/Block';

  @override
  String get blackWhiteList => 'Black/White List';

  @override
  String get regexRules => 'Regex Rules';

  @override
  String get phoneSubscription => 'Phone Subscription';

  @override
  String get smsSubscription => 'SMS Subscription';

  @override
  String get smsManagement => 'SMS Management';

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
  String get saveButton => 'Save';

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
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberHintText => 'Enter phone number to add rule';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactNameHint => 'Enter contact name (optional)';

  @override
  String get addSimRuleButton => 'Add SIM Rule';

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
  String dataLoadFailure(Object error) {
    return 'Data load failed: $error';
  }

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

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
  String get enterSubscriptionName => 'Enter subscription name';

  @override
  String get enterSubscriptionUrl => 'Enter subscription URL';

  @override
  String get enterValidNameAndUrl => 'Please enter valid name and URL';

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
  String get addLabelToCall => 'Add Label to Call Record';

  @override
  String get currentLabels => 'Current Labels:';

  @override
  String get expandLabelSelector => 'Expand Label Selector';

  @override
  String get collapseLabelSelector => 'Collapse Label Selector';

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
  String get blockedPhoneLabel => 'Blocked Calls';

  @override
  String get filteredSmsLabel => 'Filtered SMS';

  @override
  String get whitelistLabel => 'Whitelist';

  @override
  String get blacklistLabel => 'Blacklist';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

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
  String get selectedLabel => 'Selected:';

  @override
  String get addLabelButton => 'Add Label';

  @override
  String get rulesImported => 'Rules imported successfully';

  @override
  String rulesImportFailed(Object error) {
    return 'Failed to import rules: $error';
  }

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
    return 'Failed to delete rule: $error';
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
  String get failedToLoadContacts => 'Failed to load contacts';

  @override
  String get callerIdDialogTitle => 'Caller ID Information';

  @override
  String get staticMethodShowCallerIdDialog => 'Static method to show the Caller ID Information Dialog';

  @override
  String get fetchingCallerIdInfo => 'Fetching caller ID information...';

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Failed to get caller ID information: $error';
  }

  @override
  String get close => 'Close';

  @override
  String get number => 'Number';

  @override
  String get country => 'Country';

  @override
  String get region => 'Region';

  @override
  String get carrier => 'Carrier';

  @override
  String get labels => 'Labels';

  @override
  String get add => 'Add';

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
  String get deleteContactConfirmation => 'Are you sure you want to delete contact';

  @override
  String get deleteSuccess => 'Delete success';

  @override
  String dataLoadingFailed(Object error) {
    return 'Failed to load data: $error';
  }

  @override
  String get overview => 'Overview';

  @override
  String get adPlaceholder => 'Ad Placeholder';

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
  String get answerThenHangup => 'Answer then hang up';

  @override
  String get silenceAndNoAnswer => 'Silence and no answer';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get currentLanguage => 'Current Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get localCountFilterSettings => 'Local Count Filter Settings';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String get countThresholdLabel => 'Count Threshold';

  @override
  String get countThresholdDescription => 'Set the minimum count threshold required to trigger filtering actions';

  @override
  String get logAllLocalQueries => 'Log All Local Queries';

  @override
  String get logAllLocalQueriesDescription => 'Record logs for all local number queries';

  @override
  String get localCountFilterExplanationTitle => 'Local Count Filter Explanation';

  @override
  String get localCountFilterExplanationContent => 'The local count filter analyzes call history records to automatically identify and block frequent spam calls.';

  @override
  String get localCountFilterHowItWorksPoint1 => '• Determine whether to block based on the number\'s count value';

  @override
  String get localCountFilterHowItWorksPoint2 => '• When a number\'s count exceeds the set threshold, you can choose to automatically block it';

  @override
  String get localCountFilterHowItWorksPoint3 => '• You can selectively allow numbers that don\'t exceed the threshold';

  @override
  String get localCountFilterHowItWorksPoint4 => '• You can choose whether to record all query logs';

  @override
  String get localCountFilterUseCases => 'This filter is particularly suitable for identifying auto-dialed spam calls and marketing calls.';

  @override
  String get skip => 'Skip';

  @override
  String get previousStep => 'Previous';

  @override
  String get nextStep => 'Next';

  @override
  String get startUsing => 'Get Started';

  @override
  String get welcome => 'Welcome';

  @override
  String get onboardingWelcomeDescription => 'Your call management expert, providing comprehensive call identification and blocking services.';

  @override
  String get selectYourLanguage => 'Select Your Language';

  @override
  String get onboardingLanguageDescription => 'Choose your preferred language for the best experience.';

  @override
  String get smartCallerId => 'Smart Call Identification';

  @override
  String get onboardingSmartCallerIdDescription => 'Automatically identify unknown calls, mark suspicious numbers, and protect your call safety.';

  @override
  String get powerfulSpamBlocking => 'Powerful Spam Blocking';

  @override
  String get onboardingPowerfulSpamBlockingDescription => 'One-click blocking of spam calls and messages, customize blocking rules, and give you a quiet environment.';

  @override
  String get grantNecessaryPermissions => 'Grant Necessary Permissions';

  @override
  String get onboardingPermissionsDescription => 'To provide full service, we need the following permissions:';

  @override
  String get phonePermission => 'Phone Permission';

  @override
  String get phonePermissionDescription => 'Used to identify and block incoming calls.';

  @override
  String get smsPermission => 'SMS Permission';

  @override
  String get smsPermissionDescription => 'Used to filter spam messages.';

  @override
  String get contactsPermission => 'Contacts Permission';

  @override
  String get contactsPermissionDescription => 'Used to identify contact calls.';

  @override
  String get callScreeningPermission => 'Call Screening Permission';

  @override
  String get callScreeningPermissionDescription => 'Used to screen and block spam calls.';

  @override
  String get callScreeningPermissionNotGranted => 'Call screening permission not granted, may affect app functionality.';

  @override
  String get grantPermissions => 'Grant Permissions';

  @override
  String get ready => 'Ready!';

  @override
  String get allSettingsCompleted => 'All settings completed.';

  @override
  String get onboardingCompleteDescription => 'Your call security manager is ready, start enjoying a secure call experience!';

  @override
  String get storagePermission => 'Storage Permission';

  @override
  String get storagePermissionDescription => 'Used to save settings and rules.';

  @override
  String get overlayPermission => 'Overlay Permission';

  @override
  String get overlayPermissionDescription => 'Used to display incoming call overlay.';

  @override
  String get notificationPermission => 'Notification Permission';

  @override
  String get notificationPermissionDescription => 'Used to display incoming call and message notifications.';

  @override
  String checkPermissionFailed(Object error) {
    return 'Failed to check permissions: $error';
  }

  @override
  String get permissionGranted => 'Permission granted';

  @override
  String get permissionDenied => 'Permission request denied';

  @override
  String requestPermissionFailed(Object error) {
    return 'Failed to request permission: $error';
  }

  @override
  String get allPermissionsGranted => 'All permissions granted';

  @override
  String get somePermissionsDenied => 'Some permission requests denied';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Failed to open app settings: $error';
  }

  @override
  String get permissionManagement => 'Permission Management';

  @override
  String get refreshPermissionStatus => 'Refresh permission status';

  @override
  String get openAppSettings => 'Open app settings';

  @override
  String get requestAllPermissions => 'Request All Permissions';

  @override
  String get granted => 'Granted';

  @override
  String get notGranted => 'Not Granted';

  @override
  String get requestPermission => 'Request Permission';

  @override
  String get pluginName => 'Plugin Name';

  @override
  String get enterPluginName => 'Enter Plugin Name';

  @override
  String get enterVersion => 'Enter Version';

  @override
  String get pluginVersion => 'Plugin Version';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get pluginManagement => 'Plugin Management';

  @override
  String get pluginService => 'Plugin Service';

  @override
  String loadPluginsFailed(Object error) {
    return 'Failed to load plugins: $error';
  }

  @override
  String changePluginStatusFailed(Object error) {
    return 'Failed to change plugin status: $error';
  }

  @override
  String get pluginUpdateSuccess => 'Plugin updated successfully';

  @override
  String get pluginLatestVersion => 'Plugin is already the latest version';

  @override
  String updatePluginFailed(Object error) {
    return 'Failed to update plugin: $error';
  }

  @override
  String get deletePlugin => 'Delete Plugin';

  @override
  String confirmDeletePlugin(Object name) {
    return 'Are you sure you want to delete plugin \"$name\"?';
  }

  @override
  String get pluginDeleted => 'Plugin deleted';

  @override
  String deletePluginFailed(Object error) {
    return 'Failed to delete plugin: $error';
  }

  @override
  String get enterValidUrl => 'Please enter a valid URL';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" added successfully';
  }

  @override
  String get addPluginFailed => 'Failed to add plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Failed to add plugin: $error';
  }

  @override
  String get addPlugin => 'Add Plugin';

  @override
  String get pluginUrl => 'Plugin URL';

  @override
  String get enterPluginUrl => 'Enter plugin URL address';

  @override
  String get addPluginFromUrl => 'Add Plugin from URL';

  @override
  String get addPluginFromLocalFile => 'Add Plugin from Local File';

  @override
  String get exportPluginList => 'Export Plugin List';

  @override
  String get importPluginList => 'Import Plugin List';

  @override
  String get pluginListExportSuccess => 'Plugin list exported successfully';

  @override
  String exportPluginListFailed(Object error) {
    return 'Failed to export plugin list: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Successfully imported $count plugins';
  }

  @override
  String importPluginListFailed(Object error) {
    return 'Failed to import plugin list: $error';
  }

  @override
  String get moreOptions => 'More Options';

  @override
  String get noPlugins => 'No plugins yet';

  @override
  String get installed => 'Installed';

  @override
  String get autoUpdate => 'Auto Update';

  @override
  String version(Object version) {
    return 'Version: $version';
  }

  @override
  String get updatePlugin => 'Update Plugin';

  @override
  String get enableGlobalPlugins => 'Enable global plugins';

  @override
  String get disableGlobalPlugins => 'Disable global plugins';

  @override
  String get selectAll => 'Select All';

  @override
  String get remoteFilterSettingsPageTitle => 'Remote Number Filter Settings';

  @override
  String get settingsLoaded => 'Settings loaded';

  @override
  String saveSettingsFailed(Object error) {
    return 'Failed to save settings: $error';
  }

  @override
  String get countThresholdSettings => 'Count Threshold Settings';

  @override
  String countThresholdValue(Object count) {
    return 'Count Threshold: $count';
  }

  @override
  String get logAllRemoteQueries => 'Log All Remote Queries';

  @override
  String get logAllRemoteQueriesDescription => 'Record all remote number query operations';

  @override
  String get remoteNumberFilterExplanationTitle => 'Remote Number Filter Explanation';

  @override
  String get remoteNumberFilterExplanationContent => 'The remote number filter identifies and blocks spam calls by querying a remote database based on number count.';

  @override
  String get remoteNumberFilterFeatures => 'Features:';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• Count Threshold: Determine based on number occurrence frequency';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• Filter Actions: Configure how to handle numbers exceeding threshold';

  @override
  String get remoteNumberFilterFeaturePriority => '• Priority Settings: Set priority for remote actions';

  @override
  String get remoteNumberFilterDatabaseInfo => 'This filter uses an independent remote database to get the latest number information.';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get incomingCallNotification => 'Incoming Call Notification';

  @override
  String get enableStatisticsNotifications => 'Enable Statistics Notifications';

  @override
  String get receiveWeeklyStatistics => 'Receive weekly statistics';

  @override
  String get notificationSettingsSaved => 'Notification settings saved successfully';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get confirmDeleteRuleMessage => 'Are you sure you want to delete this rule? This action cannot be undone.';

  @override
  String get ruleNotExist => 'Rule does not exist or has been deleted';

  @override
  String get basicInfo => 'Basic Information';

  @override
  String get none => 'None';

  @override
  String get ruleNameRequired => 'Rule name and phone number cannot be empty';

  @override
  String ruleUpdateFailed(Object error) {
    return 'Failed to update rule: $error';
  }

  @override
  String get phoneNumberHint => 'Enter phone number';

  @override
  String get phoneRule => 'Phone Rule';

  @override
  String get phoneRuleManagement => 'Phone Rule Management';

  @override
  String get addPhoneNumberRule => 'Add Phone Number Rule';

  @override
  String get ruleAddSuccess => 'Rule added successfully';

  @override
  String get addRule => 'Add Rule';

  @override
  String get allowedBlockedRule => 'Allow/Block Rule';

  @override
  String get allowedBlockedRuleManagement => 'Allow/Block Rule Management';

  @override
  String get addAllowedBlockedRule => 'Add Allow/Block Rule';

  @override
  String get regexRule => 'Regex Rule';

  @override
  String get regexRuleManagement => 'Regex Rule Management';

  @override
  String get addRegexRule => 'Add Regex Rule';

  @override
  String get regexPattern => 'Regex Pattern';

  @override
  String get validateRegex => 'Validate Regex';

  @override
  String get regexValidationSuccess => 'Regex validation successful';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex validation failed: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex rule added successfully';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Failed to add regex rule: $error';
  }

  @override
  String get regexRuleNamePatternRequired => 'Rule name and regex pattern cannot be empty';

  @override
  String get invalidRegexPattern => 'Invalid regex pattern';

  @override
  String get regexPatternExplanation => 'Regex Pattern Explanation';

  @override
  String get regexPatternExplanationButton => 'Regex Pattern Explanation';

  @override
  String get regexPatternsForPhoneNumberMatching => 'Regex Patterns for Phone Number Matching';

  @override
  String get regexPatternsExamples => 'Use standard regex syntax to define patterns. Examples:';

  @override
  String get blockInternationalCalls => 'matches numbers that don\'t start with + or 00';

  @override
  String get blockPremiumRateNumbers => 'matches numbers that don\'t start with 118 or 120-190';

  @override
  String get blockMobileNumbers => 'matches numbers that don\'t start with 13-19';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples => 'Use standard regex syntax to define patterns. Examples:';

  @override
  String get blockInternationalCallsTitle => 'Block International Calls';

  @override
  String get blockPremiumRateNumbersTitle => 'Block Premium Rate Numbers';

  @override
  String get blockMobileNumbersTitle => 'Block Mobile Numbers';

  @override
  String get blockLandlineNumbersTitle => 'Block Landline Numbers';

  @override
  String get blockSpecificAreaCodesTitle => 'Block specific area codes:';

  @override
  String get matchSpecificDigitPatternsTitle => 'Match specific digit patterns:';

  @override
  String get matchNumbersWithSpecialCharactersTitle => 'Match numbers with special characters:';

  @override
  String get dialogTitle => 'Regex Pattern Explanation';

  @override
  String get closeButton => 'Close';

  @override
  String get showExplanation => 'Show Explanation';

  @override
  String get blockSpecificAreaCodes => 'matches numbers starting with 0 + 2-3 digits';

  @override
  String get matchSpecificDigitPatterns => 'matches XXX-XXXX-XXXX format';

  @override
  String get matchNumbersWithSpecialCharacters => 'matches specific number format';

  @override
  String get exampleBlock400Prefix => 'e.g. Block 400 prefix numbers';

  @override
  String get exampleRegex400Prefix => 'Example regex for 400 prefix';

  @override
  String get wildcardMatchingTitle => 'Wildcard matching:';

  @override
  String get wildcardMatchingDescription => 'Use \'.\' to match any character (e.g. \'123.456\' matches 123-456)';

  @override
  String get backupRestoreTitle => 'Backup & Restore';

  @override
  String get backupSettingsTitle => 'Backup Settings';

  @override
  String get keepAllVersionsTitle => 'Keep All Versions';

  @override
  String get keepAllVersionsSubtitle => 'Keep historical versions of each backup';

  @override
  String get enableEncryptionTitle => 'Enable Encryption';

  @override
  String get enableEncryptionSubtitle => 'Backup files will be encrypted';

  @override
  String get deviceNameLabel => 'Device Name';

  @override
  String get deviceNameHint => 'Please enter device name';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get configureSyncServiceHint => 'Please configure sync service in cloud sync settings first';

  @override
  String get cloudSyncTitle => 'Cloud Sync';

  @override
  String get backupToCloudTitle => 'Backup to Cloud';

  @override
  String get backupToCloudSuccess => 'Successfully backed up to cloud';

  @override
  String backupToCloudFailed(Object error) {
    return 'Failed to backup to cloud: $error';
  }

  @override
  String get restoreFromCloudTitle => 'Restore from Cloud';

  @override
  String get restoreFromCloudSuccess => 'Successfully restored from cloud';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Failed to restore from cloud: $error';
  }

  @override
  String get backupSectionTitle => 'Backup';

  @override
  String get configureBackupOptionsSubtitle => 'Configure backup options';

  @override
  String get exportRulesTitle => 'Export Rules';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'Export all rule configurations';

  @override
  String get exportAllApplicationSettingsSubtitle => 'Export all application settings';

  @override
  String get syncWithCloudStorageSubtitle => 'Sync with cloud storage';

  @override
  String get restoreSectionTitle => 'Restore';

  @override
  String get importRulesTitle => 'Import Rules';

  @override
  String get importRuleConfigurationsFromFileSubtitle => 'Import rule configurations from file';

  @override
  String get restoreSettingsTitle => 'Restore Settings';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => 'Restore application settings from backup';

  @override
  String get dataMigrationSectionTitle => 'Data Migration';

  @override
  String get migrationToolTitle => 'Migration Tool';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => 'Transfer data between devices or platforms';

  @override
  String get noRulesToExport => 'No rules to export';

  @override
  String get exportRulesDialogTitle => 'Export Rules';

  @override
  String rulesExportedTo(Object path) {
    return 'Rules exported to: $path';
  }

  @override
  String get backupSettingsDialogTitle => 'Backup Settings';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Settings backed up to: $path';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Failed to backup settings: $error';
  }

  @override
  String get importRulesDialogTitle => 'Import Rules';

  @override
  String foundRulesToImport(Object count) {
    return 'Found $count rules. Do you want to import them?';
  }

  @override
  String foundRules(Object count) {
    return 'Found $count rules';
  }

  @override
  String get importButton => 'Import';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count rules imported successfully';
  }

  @override
  String get failedToDecryptBackupFile => 'Failed to decrypt backup file';

  @override
  String get restoreSettingsDialogTitle => 'Restore Settings';

  @override
  String get restoreSettingsConfirmation => 'This will replace all your current settings. Are you sure you want to continue?';

  @override
  String get restoreButton => 'Restore';

  @override
  String get settingsRestoredSuccessfully => 'Settings restored successfully. Please restart the app for changes to take effect.';

  @override
  String get failedToRestoreSettings => 'Failed to restore settings';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Failed to restore settings: $error';
  }

  @override
  String get dataMigrationDialogTitle => 'Data Migration';

  @override
  String get dataMigrationDialogContent => 'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.';

  @override
  String get okButton => 'OK';

  @override
  String get setEncryptionPasswordTitle => 'Set Encryption Password';

  @override
  String get enterEncryptionPasswordTitle => 'Enter Encryption Password';

  @override
  String get passwordLabel => 'Password';

  @override
  String get backupFailed => 'Backup failed';

  @override
  String get backupRestoreSubtitle => 'Backup or restore application data';

  @override
  String get webDAVConfigTitle => 'WebDAV Configuration';

  @override
  String get serverAddressLabel => 'Server Address';

  @override
  String get enterWebDAVServerAddressHint => 'Please enter WebDAV server address';

  @override
  String get usernameLabel => 'Username';

  @override
  String get enterWebDAVUsernameHint => 'Please enter WebDAV username';

  @override
  String get enterWebDAVPasswordHint => 'Please enter WebDAV password';

  @override
  String get syncFolderNameLabel => 'Sync Folder Name';

  @override
  String get enterSyncFolderNameHint => 'Please enter sync folder name (default: NotificationManager)';

  @override
  String get testConnectionButton => 'Test Connection';

  @override
  String get oneDriveConfigTitle => 'OneDrive Configuration';

  @override
  String get oneDriveAuthDescription => 'Authorize using system-configured OneDrive client ID and key';

  @override
  String get authorizeLoginButton => 'Authorize Login';

  @override
  String get googleDriveConfigTitle => 'Google Drive Configuration';

  @override
  String get googleDriveAuthDescription => 'Authorize using system-configured Google Drive client ID and key';

  @override
  String get connectionSuccessMessage => 'Connection successful';

  @override
  String get connectionFailedCheckCredentialsMessage => 'Connection failed: Please check server address, username, and password';

  @override
  String get connectionFailedMessage => 'Connection failed';

  @override
  String get authorizationSuccessMessage => 'Authorization successful';

  @override
  String get authorizationFailedCheckCredentialsMessage => 'Authorization failed: Please check client ID and key';

  @override
  String get authorizationFailedMessage => 'Authorization failed';

  @override
  String get syncStatusTitle => 'Sync Status';

  @override
  String get connectionStatusLabel => 'Connection Status';

  @override
  String get connectedStatus => 'Connected';

  @override
  String get disconnectedStatus => 'Disconnected';

  @override
  String get serviceTypeLabel => 'Service Type';

  @override
  String get noneServiceType => 'None';

  @override
  String get autoSyncLabel => 'Auto Sync';

  @override
  String get enabledStatus => 'Enabled';

  @override
  String get disabledStatus => 'Disabled';

  @override
  String get syncNowButton => 'Sync Now';

  @override
  String get disconnectButton => 'Disconnect';

  @override
  String get loadStatusFailedMessage => 'Failed to load status';

  @override
  String get noActiveCloudSyncServiceMessage => 'No active cloud sync service';

  @override
  String get syncSuccessMessage => 'Sync successful';

  @override
  String get syncStatusUpdatedMessage => 'Sync status updated';

  @override
  String get syncFailedMessage => 'Sync failed';

  @override
  String get disconnectedMessage => 'Disconnected';

  @override
  String get disconnectFailedMessage => 'Disconnect failed';

  @override
  String get pluginTestPageTitle => 'Plugin Test';

  @override
  String get pluginUrlLabel => 'Plugin URL';

  @override
  String get pluginUrlHint => 'Enter plugin URL';

  @override
  String get loadPluginButton => 'Load Plugin';

  @override
  String get queryButton => 'Query';

  @override
  String get queryResultTitle => 'Query Result';

  @override
  String get jsLogsTitle => 'JS Logs';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin URL cannot be empty';

  @override
  String get pluginLoadedSuccessfully => 'Plugin loaded successfully';

  @override
  String get failedToLoadPlugin => 'Failed to load plugin';

  @override
  String get errorLoadingPlugin => 'Error loading plugin';

  @override
  String get pluginNotLoaded => 'Plugin is not loaded yet. Please load the plugin first.';

  @override
  String get phoneNumberCannotBeEmpty => 'Phone number cannot be empty';

  @override
  String get querying => 'Querying...';

  @override
  String get queryingPhoneNumber => 'Querying phone number';

  @override
  String get noResultReturned => 'No result returned';

  @override
  String get noResultReturnedLog => 'No result returned from plugin';

  @override
  String get queryFailed => 'Query failed';

  @override
  String get queryFailedLog => 'Query failed';

  @override
  String get backupAndRestoreTitle => 'Backup & Restore';

  @override
  String get backupAndRestoreSubtitle => 'Backup or restore application data';

  @override
  String get webdavConfigurationTitle => 'WebDAV Configuration';

  @override
  String get webdavServerAddressHint => 'Please enter WebDAV server address';

  @override
  String get webdavUsernameHint => 'Please enter WebDAV username';

  @override
  String get webdavPasswordHint => 'Please enter WebDAV password';

  @override
  String get syncFolderNameHint => 'Please enter sync folder name (default: NotificationManager)';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive Configuration';

  @override
  String get oneDriveAuthorizationHint => 'Authorize using system-configured OneDrive client ID and key';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive Configuration';

  @override
  String get googleDriveAuthorizationHint => 'Authorize using system-configured Google Drive client ID and key';

  @override
  String get deviceManagementTitle => 'Device Management';

  @override
  String get currentDeviceTitle => 'Current Device';

  @override
  String get deviceModelLabel => 'Device Model';

  @override
  String get deviceIdLabel => 'Device ID';

  @override
  String get lastSyncLabel => 'Last Sync';

  @override
  String get errorText => 'Error';

  @override
  String get registeredDevicesTitle => 'Registered Devices';

  @override
  String get syncDevicesButton => 'Sync Devices';

  @override
  String get configureCloudSyncServiceHint => 'Please configure a cloud sync service to enable multi-device synchronization.';

  @override
  String get noDevicesRegisteredYet => 'No devices registered yet.';

  @override
  String get currentDeviceChip => 'Current';

  @override
  String get renameDeviceDialogTitle => 'Rename Device';

  @override
  String get enterNewDeviceNameHint => 'Enter a new name for this device';

  @override
  String get renameButton => 'Rename';

  @override
  String get deviceNameCannotBeEmpty => 'Device name cannot be empty';

  @override
  String get deleteDeviceDialogTitle => 'Delete Device';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Are you sure you want to delete $deviceName?';
  }

  @override
  String get deleteButton => 'Delete';

  @override
  String get deviceRenamedSuccessfully => 'Device renamed successfully';

  @override
  String get failedToRenameDevice => 'Failed to rename device';

  @override
  String get deviceDeletedSuccessfully => 'Device deleted successfully';

  @override
  String get failedToDeleteDevice => 'Failed to delete device';

  @override
  String get devicesSyncedSuccessfully => 'Devices synchronized successfully';

  @override
  String get failedToSyncDevices => 'Failed to sync devices';

  @override
  String get enterEncryptionPasswordHint => 'Enter encryption password';

  @override
  String get keepAllVersions => 'Keep All Versions';

  @override
  String get enableEncryption => 'Enable Encryption';

  @override
  String get enterDeviceNameHint => 'Please enter device name';

  @override
  String get backupToCloud => 'Backup to Cloud';

  @override
  String get backupSuccessMessage => 'Successfully backed up to cloud';

  @override
  String get backupFailedMessage => 'Backup failed';

  @override
  String backupFailedWithError(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String get restoreFromCloud => 'Restore from Cloud';

  @override
  String get restoreSuccessMessage => 'Successfully restored from cloud';

  @override
  String restoreFailedWithError(Object error) {
    return 'Restore from cloud failed: $error';
  }

  @override
  String get localBackupTitle => 'Local Backup';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Backup successful to: $path';
  }

  @override
  String get restoreFromLocal => 'Restore from Local';

  @override
  String get restoreSuccessFromLocal => 'Successfully restored from local';

  @override
  String get setEncryptionPassword => 'Set Encryption Password';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get enterCurrentPasswordHint => 'Please enter current password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get enterNewPasswordHint => 'Please enter new password';

  @override
  String get passwordSetSuccessfully => 'Password set successfully';

  @override
  String failedToSetPassword(Object error) {
    return 'Failed to set password: $error';
  }

  @override
  String get clearAllDataConfirmation => 'Are you sure you want to clear all application data? This action cannot be undone.';

  @override
  String get allDataClearedSuccessfully => 'All data cleared successfully';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get reEnterPasswordHint => 'Please re-enter password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Password cannot be empty';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get setButton => 'Set';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get functionSettingsTitle => 'Function Settings';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud Sync & Backup';

  @override
  String get systemSettingsTitle => 'System Settings';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get callSettingsTitle => 'Call Settings';

  @override
  String get callSettingsSubtitle => 'Caller ID, filtering and blocking settings';

  @override
  String get filterControlTitle => 'Filter Control';

  @override
  String get filterControlSubtitle => 'Manage on/off status of all filters';

  @override
  String get interceptionActionSettingsTitle => 'Interception Action Settings';

  @override
  String get interceptionActionSettingsSubtitle => 'Set how blocked calls are handled';

  @override
  String get callFrequencyInterceptionTitle => 'Call Frequency Interception';

  @override
  String get callFrequencyInterceptionSubtitle => 'Set call frequency limits and blocking rules';

  @override
  String get smsSettingsTitle => 'SMS Settings';

  @override
  String get smsSettingsSubtitle => 'SMS filtering and keyword blocking';

  @override
  String get contactSettingsTitle => 'Contact Settings';

  @override
  String get contactSettingsSubtitle => 'Contact management and label settings';

  @override
  String get cloudSyncSettingsTitle => 'Cloud Sync Settings';

  @override
  String get cloudSyncSettingsSubtitle => 'Configure WebDAV, OneDrive and Google Drive';

  @override
  String get deviceManagementSubtitle => 'Manage multi-device synchronization';

  @override
  String get autoUpdateSettingsTitle => 'Auto Update Settings';

  @override
  String get autoUpdateSettingsSubtitle => 'Manage automatic updates for rules and plugins';

  @override
  String get pluginManagementTitle => 'Plugin Management';

  @override
  String get pluginManagementSubtitle => 'Manage and configure third-party plugins';

  @override
  String get languageSettingsTitle => 'Language Settings';

  @override
  String get languageSettingsSubtitle => 'Change application display language';

  @override
  String get globalSearchTitle => 'Global Search';

  @override
  String get globalSearchSubtitle => 'Search contacts, labels, blacklists, whitelists, etc.';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutSubtitle => 'Application version and legal information';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. All rights reserved.';

  @override
  String get filterSettingsTitle => 'Filter Settings';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get enterPasswordAgain => 'Enter Password Again';

  @override
  String get backup => 'Backup';

  @override
  String get backupSettings => 'Backup Settings';

  @override
  String get configureBackupOptions => 'Configure Backup Options';

  @override
  String get exportAllRuleConfigurations => 'Export All Rule Configurations';

  @override
  String get exportAllApplicationSettings => 'Export all application settings';

  @override
  String get cloudSync => 'Cloud Sync';

  @override
  String get syncWithCloudStorage => 'Sync with Cloud Storage';

  @override
  String get restore => 'Restore';

  @override
  String get importRuleConfigurationsFromFile => 'Import Rule Configurations from File';

  @override
  String get restoreSettings => 'Restore Settings';

  @override
  String get restoreApplicationSettingsFromBackup => 'Restore Application Settings from Backup';

  @override
  String get dataMigration => 'Data Migration';

  @override
  String get migrationTool => 'Migration Tool';

  @override
  String get transferDataBetweenDevicesOrPlatforms => 'Transfer data between devices or platforms';

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Found $count rules. Do you want to import them?';
  }

  @override
  String get replaceCurrentSettingsConfirmation => 'This will replace all your current settings. Are you sure you want to continue?';

  @override
  String get dataMigrationDescription => 'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.';

  @override
  String get ok => 'OK';

  @override
  String get enterPasswordHint => 'Please enter password';

  @override
  String get setPasswordButton => 'Set';

  @override
  String get autoUpdateTitle => 'Auto Update';

  @override
  String get autoUpdateSubtitle => 'Manage automatic updates for rules and plugins';

  @override
  String get searchSettingsTitle => 'Search Settings';

  @override
  String get searchSettingsSubtitle => 'Search contacts, labels, blacklists, whitelists, etc.';

  @override
  String get deviceIDLabel => 'Device ID';

  @override
  String get configureCloudSyncServiceMessage => 'Please configure a cloud sync service to enable multi-device synchronization.';

  @override
  String get noDevicesRegisteredMessage => 'No devices registered';

  @override
  String get currentDeviceLabel => 'Current Device Label';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Device renamed successfully';

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Error renaming device: $error';
  }

  @override
  String get deviceDeletedSuccessfullyMessage => 'Device deleted successfully';

  @override
  String get unregisterDeviceTitle => 'Unregister Device';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Are you sure you want to unregister $deviceName?';
  }

  @override
  String get unregisterButton => 'Unregister';

  @override
  String get deviceUnregisteredSuccessfullyMessage => 'Device unregistered successfully';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Error unregistering device: $error';
  }

  @override
  String get devicesSynchronizedSuccessfullyMessage => 'Devices synchronized successfully';

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Error synchronizing devices: $error';
  }

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Error deleting device: $error';
  }

  @override
  String get devicesSyncedSuccessfullyMessage => 'Devices synchronized successfully';

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Error syncing devices: $error';
  }

  @override
  String get keepAllVersionsLabel => 'Keep All Versions';

  @override
  String get keepAllVersionsDescription => 'Keep all historical versions of each backup';

  @override
  String get enableEncryptionLabel => 'Enable Encryption';

  @override
  String get enableEncryptionDescription => 'Encrypt backup files';

  @override
  String get backupToCloudLabel => 'Backup to Cloud';

  @override
  String get backupToCloudDescription => 'Backup settings and rules to cloud storage';

  @override
  String get restoreFromCloudLabel => 'Restore from Cloud';

  @override
  String get restoreFromCloudDescription => 'Restore settings and rules from cloud storage';

  @override
  String get setEncryptionPasswordLabel => 'Set Encryption Password';

  @override
  String get setEncryptionPasswordDescription => 'Set encryption password for backup and restore';

  @override
  String get clearAllDataLabel => 'Clear All Data';

  @override
  String get clearAllDataDescription => 'Clear all application data';

  @override
  String get backupToLocalLabel => 'Backup to Local';

  @override
  String get deviceName => 'Device Name';

  @override
  String get renameDeviceTitle => 'Rename Device';

  @override
  String get enterDeviceName => 'Enter Device Name';

  @override
  String get configureCloudSyncService => 'Configure Cloud Sync Service';

  @override
  String get backupAndRestore => 'Backup and Restore';

  @override
  String errorOccurredMessage(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String get setup => 'Setup';
}
