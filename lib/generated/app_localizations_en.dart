// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get aboutContactSubscription => 'About Contact Subscription';

  @override
  String get aboutLabels => 'About Labels';

  @override
  String get aboutPhoneSubscriptionRules => 'About Phone Subscription Rules';

  @override
  String get aboutPhoneSubscriptions => 'About Phone Subscriptions';

  @override
  String get aboutPhoneSubscriptionsDesc => 'Subscribe to phone rule lists via URL, automatically update rules. Supports JSON, CSV format rule files.';

  @override
  String get aboutSmsFilter => 'About SMS Filtering';

  @override
  String get aboutSmsSubscriptionRules => 'About SMS Subscription Rules';

  @override
  String get aboutSubtitle => 'Application version and legal information';

  @override
  String get aboutTitle => 'About';

  @override
  String get action => 'Action';

  @override
  String get actionAll => 'All';

  @override
  String get actionAllow => 'Allow';

  @override
  String get actionBlock => 'Block';

  @override
  String get actionFilterAll => 'All Filter';

  @override
  String get actionFilterTitle => 'Filter by Action Type';

  @override
  String get actionFilterTooltip => 'Action Filter';

  @override
  String get actionNone => 'No Action';

  @override
  String get actionSilence => 'Silence';

  @override
  String actionTag(Object actionType) {
    return 'Action: $actionType';
  }

  @override
  String get actionType => 'Action Type';

  @override
  String get actionUnknown => 'Unknown';

  @override
  String get add => 'Add';

  @override
  String get addAllowedBlockedRule => 'Add Allow/Block Rule';

  @override
  String get addAllowSubscription => 'Add Allow Subscription';

  @override
  String get addBlockSubscription => 'Add Block Subscription';

  @override
  String get addContactButton => 'Add Contact';

  @override
  String addContactFailed(Object error) {
    return 'Failed to add contact: $error';
  }

  @override
  String get addedToAllowedRules => 'Added to Allowed Rules';

  @override
  String get addedToBlacklist => 'Added to Blacklist';

  @override
  String get addedToBlockedRules => 'Added to Blocked Rules';

  @override
  String get addedToFavoriteContacts => 'Added to favorite contacts';

  @override
  String get addedToFavorites => 'Added to favorite contacts';

  @override
  String get addedToWhitelist => 'Added to Whitelist';

  @override
  String get addFavorite => 'Add Favorite';

  @override
  String get addFilter => 'Add Filter';

  @override
  String get addLabel => 'Add Label';

  @override
  String get addLabelButton => 'Add Label';

  @override
  String addLabelFailed(Object error) {
    return 'Failed to add label: $error';
  }

  @override
  String get addLabelToCall => 'Add Label to Call Record';

  @override
  String get addName => 'Add Name';

  @override
  String get addNoneSubscription => 'Add None Subscription';

  @override
  String get addOrEditContactInfo => 'Used to add or edit contact information';

  @override
  String get addPhoneMark => 'Add Phone Mark';

  @override
  String get addPhoneNumberRule => 'Add Phone Number Rule';

  @override
  String get addPlugin => 'Add Plugin';

  @override
  String get addPluginFailed => 'Failed to add plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Failed to add plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Add Plugin from Local File';

  @override
  String get addPluginFromUrl => 'Add Plugin from URL';

  @override
  String get addRegexRule => 'Add Regex Rule';

  @override
  String get addRule => 'Add Rule';

  @override
  String get addRuleButton => 'Add Rule';

  @override
  String addRuleFailed(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String get addRuleTooltip => 'Add Rule';

  @override
  String get addSilenceSubscription => 'Add Silence Subscription';

  @override
  String get addSimRuleButton => 'Add SIM Rule';

  @override
  String get addSmsFilterRule => 'Add SMS Filter Rule';

  @override
  String get addSmsRule => 'Add SMS Rule';

  @override
  String get addSmsSubscription => 'Add SMS Subscription';

  @override
  String get addSubscription => 'Add Subscription';

  @override
  String get addSubscriptionButton => 'Add Subscription';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Failed to add subscription: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Add Subscription';

  @override
  String get addToAllowedRules => 'Add to Allowed Rules';

  @override
  String get addToBlacklist => 'Add to Blacklist';

  @override
  String get addToBlockedRules => 'Add to Blocked Rules';

  @override
  String get addToFavoriteContacts => 'Add to Favorite Contacts';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get addToRules => 'Add to Rules';

  @override
  String get addToWhitelist => 'Add to Whitelist';

  @override
  String get adPlaceholder => 'Ad Placeholder';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'All';

  @override
  String get allCallsTab => 'All';

  @override
  String get allDataClearedSuccessfully => 'All data cleared successfully';

  @override
  String get allow => 'Allow';

  @override
  String get allowAllAllowRules => 'Allow All Allow Rules';

  @override
  String get allowAllAllowRulesDesc => 'Allow calls from allow rules';

  @override
  String get allowAllBlacklistedNumbers => 'Allow All Blacklisted Numbers';

  @override
  String get allowAllBlacklistedNumbersDesc => 'Allow calls from blocklist';

  @override
  String get allowAllBlockRules => 'Allow All Block Rules';

  @override
  String get allowAllBlockRulesDesc => 'Allow calls from block rules';

  @override
  String get allowAllowedNumbers => 'Allow Allowed Numbers';

  @override
  String get allowAllowedNumbersDesc => 'Allow calls from allowlist';

  @override
  String get allowBlock => 'Allow/Block';

  @override
  String get allowBlockedNumbers => 'Allow Blocked Numbers';

  @override
  String get allowBlockedNumbersDesc => 'Allow calls from blocklist';

  @override
  String get allowedBlockedRule => 'Allow/Block Rule';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'Edit Allow/Block Rule';

  @override
  String get allowedBlockedRuleManagement => 'Allow/Block Rule Management';

  @override
  String get allowNonExceededNumbers => 'Allow Non-Exceeded Numbers';

  @override
  String get allowNonExceededNumbersDescription => 'Automatically allow numbers not exceeding the count threshold';

  @override
  String get allowRegexAllowRules => 'Allow Regex Allow Rules';

  @override
  String get allowRegexAllowRulesDesc => 'Enable regex pattern matching for allow rules';

  @override
  String get allowRegexAllowRulesDescription => 'Enable regex-based allow rules';

  @override
  String get allowRegexBlockRules => 'Allow Regex Block Rules';

  @override
  String get allowRegexBlockRulesDesc => 'Enable regex pattern matching for block rules';

  @override
  String get allowRegexBlockRulesDescription => 'Enable regex-based block rules';

  @override
  String get allowRule => 'Allow Rule';

  @override
  String get allowRules => 'Allow Rules';

  @override
  String get allowWhitelistedNumbers => 'Allow Whitelisted Numbers';

  @override
  String get allowWhitelistedNumbersDescription => 'Allow all numbers in the whitelist';

  @override
  String get allPermissionsGranted => 'All permissions granted';

  @override
  String get allSettingsCompleted => 'All settings completed.';

  @override
  String allUpdateSuccess(Object count) {
    return 'All updates completed ($count rules)';
  }

  @override
  String get answerThenHangup => 'Answer then hang up';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. All rights reserved.';

  @override
  String get applicationSoftware => 'Application Software';

  @override
  String get apply => 'Apply';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage => 'Authorization failed: Please check client ID and key';

  @override
  String get authorizationFailedMessage => 'Authorization failed';

  @override
  String get authorizationSuccessMessage => 'Authorization successful';

  @override
  String get authorizeLoginButton => 'Authorize Login';

  @override
  String get automotiveIndustry => 'Automotive Industry';

  @override
  String get autoSyncLabel => 'Auto Sync';

  @override
  String get autoUpdate => 'Auto Update';

  @override
  String get autoUpdateDescription => 'Set auto-update intervals for subscriptions or update manually';

  @override
  String get autoUpdateSettings => 'Auto Update Settings';

  @override
  String get autoUpdateSettingsSubtitle => 'Manage automatic updates for rules and plugins';

  @override
  String get autoUpdateSettingsTitle => 'Auto Update Settings';

  @override
  String get autoUpdateSubtitle => 'Manage automatic updates for rules and plugins';

  @override
  String get autoUpdateTitle => 'Auto Update';

  @override
  String get avatarBorderColor => 'Avatar Border Color';

  @override
  String get avatarBorderSize => 'Avatar Border Size';

  @override
  String get avatarIconSizesSetting => 'Avatar & Icon Sizes';

  @override
  String get avatarPosition => 'Avatar Position';

  @override
  String get avatarSize => 'Avatar Size';

  @override
  String axisPosition(Object axis) {
    return '$axis Position';
  }

  @override
  String get backgroundGradientSetting => 'Background Gradient';

  @override
  String get backup => 'Backup';

  @override
  String get backupAndRestore => 'Backup and Restore';

  @override
  String get backupAndRestoreSubtitle => 'Backup or restore application data';

  @override
  String get backupAndRestoreTitle => 'Backup & Restore';

  @override
  String get backupFailed => 'Backup failed';

  @override
  String get backupFailedMessage => 'Backup failed';

  @override
  String backupFailedWithError(Object error) {
    return 'Backup failed: $error';
  }

  @override
  String get backupRestoreSubtitle => 'Backup or restore application data';

  @override
  String get backupRestoreTitle => 'Backup & Restore';

  @override
  String get backupSectionTitle => 'Backup';

  @override
  String get backupSettings => 'Backup Settings';

  @override
  String get backupSettingsDialogTitle => 'Backup Settings';

  @override
  String get backupSettingsTitle => 'Backup Settings';

  @override
  String get backupSuccessMessage => 'Successfully backed up to cloud';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Backup successful to: $path';
  }

  @override
  String get backupToCloud => 'Backup to Cloud';

  @override
  String get backupToCloudDescription => 'Backup settings and rules to cloud storage';

  @override
  String backupToCloudFailed(Object error) {
    return 'Failed to backup to cloud: $error';
  }

  @override
  String get backupToCloudLabel => 'Backup to Cloud';

  @override
  String get backupToCloudSuccess => 'Successfully backed up to cloud';

  @override
  String get backupToCloudTitle => 'Backup to Cloud';

  @override
  String get backupToLocalLabel => 'Backup to Local';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Basic Information';

  @override
  String get basicRuleFilter => 'Basic Rule Filter';

  @override
  String get basicRuleFiltering => 'Basic Rule Filtering';

  @override
  String get basicRuleFilteringExplanation => '• Basic Rule Filtering: Filtering rules based on blacklist, whitelist, and regex';

  @override
  String get basicRuleFilterSettings => 'Basic Rule Filter Settings';

  @override
  String get basicRuleFilterSubtitle => 'Filter calls using blacklist/whitelist and regular expressions';

  @override
  String get batchDeleteContacts => 'Batch Delete Contacts';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Are you sure you want to delete $count selected contacts?';
  }

  @override
  String get batchDeleteFailed => 'Batch delete failed';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Are you sure you want to delete $count labels?';
  }

  @override
  String get blacklist => 'Blacklist';

  @override
  String get blacklistingAndWhitelisting => 'Blacklisting and Whitelisting';

  @override
  String get blacklistLabel => 'Blacklist';

  @override
  String get blackWhiteList => 'Black/White List';

  @override
  String get block => 'Block';

  @override
  String get blockCalls => 'Block Calls';

  @override
  String get blocked => 'Blocked';

  @override
  String get blockedCallAction => 'Blocked Call Action';

  @override
  String get blockedCalls => 'Blocked Calls';

  @override
  String get blockedCallsTitle => 'Blocked Calls';

  @override
  String get blockedCommunications => 'Blocked Communications';

  @override
  String get blockedPhoneLabel => 'Blocked Calls';

  @override
  String get blockedSpamCalls => 'Blocked Spam Calls';

  @override
  String get blockingTrend => 'Blocking Trend';

  @override
  String get blockInternationalCalls => 'matches numbers that don\'t start with + or 00';

  @override
  String get blockInternationalCallsTitle => 'Block International Calls';

  @override
  String get blockLandlineNumbersTitle => 'Block Landline Numbers';

  @override
  String get blockMobileNumbers => 'matches numbers that don\'t start with 13-19';

  @override
  String get blockMobileNumbersTitle => 'Block Mobile Numbers';

  @override
  String get blockPremiumRateNumbers => 'matches numbers that don\'t start with 118 or 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Block Premium Rate Numbers';

  @override
  String get blockRule => 'Block Rule';

  @override
  String get blockRules => 'Block Rules';

  @override
  String get blockSpecificAreaCodes => 'matches numbers starting with 0 + 2-3 digits';

  @override
  String get blockSpecificAreaCodesTitle => 'Block specific area codes:';

  @override
  String get blockTypeAnalysisTitle => 'Block Type Analysis';

  @override
  String get both => 'Both';

  @override
  String get bulkDelete => 'Batch Delete Contacts';

  @override
  String get bulkDeleteContacts => 'Batch Delete Contacts';

  @override
  String get bulkDeleteLabels => 'Bulk Delete Labels';

  @override
  String get call => 'Call';

  @override
  String get callback => 'Call Back';

  @override
  String callbackTo(String number) {
    return 'Call back to $number';
  }

  @override
  String get callBlocking => 'Call Blocking';

  @override
  String get callerIdApp => 'Caller ID App';

  @override
  String get callerIdCustomizationTitle => 'Customize Caller ID';

  @override
  String get callerIdDialogTitle => 'Caller ID Information';

  @override
  String get callerIdDisplayMode => 'Caller ID Display Mode';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Marked by $count';
  }

  @override
  String get callerIdPreview => 'Caller ID Preview';

  @override
  String get callFilter => 'Call Filter';

  @override
  String get callFilterDescription => 'When enabled, incoming calls are checked against the rule list below. Call filtering rules are not synchronized between devices by default.';

  @override
  String get callFilterRules => 'Call Filter Rules';

  @override
  String get callFilterRulesDescription => 'Set basic rules for call filtering';

  @override
  String get callFilterSettings => 'Call Filter Settings';

  @override
  String get callFrequencyInterceptionSubtitle => 'Set call frequency limits and blocking rules';

  @override
  String get callFrequencyInterceptionTitle => 'Call Frequency Interception';

  @override
  String get callHistory => 'Call History';

  @override
  String get callHistoryInfoDesc => 'Here shows your call history, including incoming, outgoing and missed calls.';

  @override
  String get callHistoryInfoTitle => 'Call History';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Failed to initialize call history: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Failed to refresh call history: $error';
  }

  @override
  String get callHistoryTab => 'Call History';

  @override
  String get callHistoryTimelineEarlier => 'Earlier';

  @override
  String get callHistoryTimelineToday => 'Today';

  @override
  String get callHistoryTimelineYesterday => 'Yesterday';

  @override
  String get callScreeningPermission => 'Call Screening Permission';

  @override
  String get callScreeningPermissionDescription => 'Used to screen and block spam calls.';

  @override
  String get callScreeningPermissionNotGranted => 'Call screening permission not granted, may affect app functionality.';

  @override
  String get callSettingsSubtitle => 'Caller ID, filtering and blocking settings';

  @override
  String get callSettingsTitle => 'Call Settings';

  @override
  String get callStatistics => 'Call Statistics';

  @override
  String get callTypeAnswered => 'Answered';

  @override
  String get callTypeBlocked => 'Blocked';

  @override
  String get callTypeIconColor => 'Call Type Icon Color';

  @override
  String get callTypeMissed => 'Missed Call';

  @override
  String get callTypeOutgoing => 'Outgoing';

  @override
  String get callTypePosition => 'Call Type Position';

  @override
  String get callTypeUnknown => 'Unknown';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get carRental => 'Car Rental';

  @override
  String get carrier => 'Carrier';

  @override
  String get carrierColor => 'Carrier Color';

  @override
  String get carrierFontSize => 'Carrier Font Size';

  @override
  String get carrierPosition => 'Carrier Position';

  @override
  String get changeLabel => 'Change Label';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Failed to change plugin status: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Failed to change subscription status: $error';
  }

  @override
  String get changeTag => 'Change Tag';

  @override
  String get charity => 'Charity';

  @override
  String chartMonthFormat(int month) {
    return 'Month $month';
  }

  @override
  String get chartOneDayAgo => '1 day ago';

  @override
  String get chartOneMonthAgo => '1 month ago';

  @override
  String get chartOneWeekAgo => '1 week ago';

  @override
  String get chartTenDaysAgo => '10 days ago';

  @override
  String get chartThreeDaysAgo => '3 days ago';

  @override
  String get chartToday => 'Today';

  @override
  String get checkFileFormat => 'Please check file format or permissions';

  @override
  String checkPermissionFailed(Object error) {
    return 'Failed to check permissions: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Choose the default intercept action';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearAllDataConfirmation => 'Are you sure you want to clear all application data? This action cannot be undone.';

  @override
  String get clearAllDataDescription => 'Clear all application data';

  @override
  String get clearAllDataLabel => 'Clear All Data';

  @override
  String get clearFilter => 'Clear Filter';

  @override
  String get clearLabelFilter => 'Clear Label Filter';

  @override
  String get clearLabelFilterButton => 'Clear Label Filter';

  @override
  String get closeButton => 'Close';

  @override
  String get cloudSync => 'Cloud Sync';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud Sync & Backup';

  @override
  String get cloudSyncSettingsSubtitle => 'Configure WebDAV, OneDrive and Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Cloud Sync Settings';

  @override
  String get cloudSyncTitle => 'Cloud Sync';

  @override
  String get collapseLabelSelector => 'Collapse Label Selector';

  @override
  String get collection => 'Debt Collection';

  @override
  String get colorPickerTitle => 'Choose Color';

  @override
  String get configManagement => 'Configuration Management';

  @override
  String get configUpdated => 'Configuration updated';

  @override
  String get configurationAdvice => 'Through proper configuration, you can set different filtering strategies for work and personal SIM cards.';

  @override
  String get configureBackupOptions => 'Configure Backup Options';

  @override
  String get configureBackupOptionsSubtitle => 'Configure backup options';

  @override
  String get configureCloudSyncService => 'Configure Cloud Sync Service';

  @override
  String get configureCloudSyncServiceHint => 'Please configure a cloud sync service to enable multi-device synchronization.';

  @override
  String get configureCloudSyncServiceMessage => 'Please configure a cloud sync service to enable multi-device synchronization.';

  @override
  String get configureSimCardFilterRules => 'Configure SIM Card Filter Rules';

  @override
  String get configureSyncServiceHint => 'Please configure sync service in cloud sync settings first';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmBatchDeleteContacts => 'Are you sure you want to delete the selected';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get confirmDeleteContact => 'Are you sure you want to delete';

  @override
  String get confirmDeleteContactName => 'Confirm delete?';

  @override
  String get confirmDeleteFilter => 'Are you sure you want to delete this filter?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Are you sure you want to delete label \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Are you sure you want to delete plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Are you sure you want to delete $count plugins?';
  }

  @override
  String get confirmDeleteRuleMessage => 'Are you sure you want to delete this rule? This action cannot be undone.';

  @override
  String get confirmDeleteSelectedContacts => 'Are you sure to delete selected contacts?';

  @override
  String get confirmDeleteSmsFilterRule => 'Are you sure you want to delete this SMS filter rule?';

  @override
  String get confirmDeleteSmsRule => 'Are you sure you want to delete this SMS rule?';

  @override
  String get confirmDeleteSubscription => 'Are you sure you want to delete this subscription?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get connectedStatus => 'Connected';

  @override
  String get connectionFailedCheckCredentialsMessage => 'Connection failed: Please check server address, username, and password';

  @override
  String get connectionFailedMessage => 'Connection failed';

  @override
  String get connectionStatusLabel => 'Connection Status';

  @override
  String get connectionSuccessMessage => 'Connection successful';

  @override
  String get contactAddSuccess => 'Contact added successfully';

  @override
  String get contactDeleted => 'Contact deleted';

  @override
  String get contactEditDialog => 'Contact Edit Dialog';

  @override
  String get contactNameHint => 'Enter contact name (optional)';

  @override
  String get contactNameLabel => 'Name';

  @override
  String get contactNameOptional => 'Contact name (optional)';

  @override
  String get contactNotFound => 'Contact not found';

  @override
  String get contacts => 'contacts';

  @override
  String contactsDeleted(Object count) {
    return 'Deleted $count contacts';
  }

  @override
  String get contactSettingsSubtitle => 'Contact management and label settings';

  @override
  String get contactSettingsTitle => 'Contact Settings';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Failed to load contacts: $error';
  }

  @override
  String get contactsManagement => 'Contacts Management';

  @override
  String get contactsManagementPageTitle => 'Contacts Management Page';

  @override
  String get contactsPageTitle => 'Contacts Management';

  @override
  String get contactsPermission => 'Contacts Permission';

  @override
  String get contactsPermissionDescription => 'Used to identify contact calls.';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get contactSubscriptionDescription => 'Subscribe to contact lists via URL, automatically update contact information and labels. Supports JSON format data.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Failed to load contact subscriptions: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Contact Subscriptions';

  @override
  String get contactUpdateSuccess => 'Contact updated successfully';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get content => 'Content';

  @override
  String get contentRegex => 'Content Regex';

  @override
  String get countColor => 'Count Color';

  @override
  String get countFontSize => 'Count Font Size';

  @override
  String get countPosition => 'Count Position';

  @override
  String get country => 'Country';

  @override
  String get countryNameColor => 'Country Name Color';

  @override
  String get countryNameFontSize => 'Country Name Font Size';

  @override
  String get countryRegionNamePosition => 'Country/Region Name Position';

  @override
  String get countrySelectionDialog => 'Country Selection Dialog';

  @override
  String get countrySelectionDialogDescription => 'Used to select a country to query caller ID information';

  @override
  String get countThresholdDescription => 'Set the minimum count threshold required to trigger filtering actions';

  @override
  String get countThresholdLabel => 'Count Threshold';

  @override
  String get countThresholdSettings => 'Count Threshold Settings';

  @override
  String countThresholdValue(Object count) {
    return 'Count Threshold: $count';
  }

  @override
  String get createdRules => 'Created Rules';

  @override
  String get csvFormat => 'CSV Format';

  @override
  String get currentDeviceChip => 'Current';

  @override
  String get currentDeviceLabel => 'Current Device Label';

  @override
  String get currentDeviceTitle => 'Current Device';

  @override
  String get currentLabels => 'Current Labels:';

  @override
  String get currentLanguage => 'Current Language';

  @override
  String get currentPasswordLabel => 'Current Password';

  @override
  String get customerService => 'Customer Service';

  @override
  String get customRange => 'Custom Range';

  @override
  String get dailyStatistics => 'Daily Statistics';

  @override
  String get dailyStatisticsDesc => 'Receive daily statistics about blocked calls and messages';

  @override
  String get dashboardTab => 'Dashboard';

  @override
  String get dataAnalysis => 'Data Analysis';

  @override
  String get dataAnalysisDashboardPage => 'Data Analysis Dashboard Page';

  @override
  String get dataExport => 'Data Export';

  @override
  String dataLoadFailure(Object error) {
    return 'Data load failed: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Failed to load data: $error';
  }

  @override
  String get dataMigration => 'Data Migration';

  @override
  String get dataMigrationDescription => 'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.';

  @override
  String get dataMigrationDialogContent => 'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.';

  @override
  String get dataMigrationDialogTitle => 'Data Migration';

  @override
  String get dataMigrationSectionTitle => 'Data Migration';

  @override
  String get dataSourceReminder => 'Data Source Reminder';

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
  String daysVip(Object days) {
    return '$days Days VIP';
  }

  @override
  String get debtCollection => 'Debt Collection';

  @override
  String get defaultPeriod => 'Week';

  @override
  String get delete => 'Delete';

  @override
  String get deleteButton => 'Delete';

  @override
  String get deleteContact => 'Delete Contact';

  @override
  String deleteContactConfirm(Object name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get deleteContactConfirmation => 'Are you sure you want to delete contact';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'Are you sure you want to delete $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Delete Device';

  @override
  String deleteFailed(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get deleteFilter => 'Delete Filter';

  @override
  String get deleteLabel => 'Delete Label';

  @override
  String deleteLabelFailed(Object error) {
    return 'Failed to delete label: $error';
  }

  @override
  String get deletePlugin => 'Delete Plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Failed to delete plugin: $error';
  }

  @override
  String get deletePlugins => 'Delete Plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Failed to delete plugins: $error';
  }

  @override
  String get deleteRule => 'Delete Rule';

  @override
  String deleteRuleFailed(Object error) {
    return 'Delete failed: $error';
  }

  @override
  String get deleteSelected => 'Delete Selected';

  @override
  String get deleteSmsRule => 'Delete SMS Rule';

  @override
  String get deleteSubscription => 'Delete Subscription';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Are you sure you want to delete subscription \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Failed to delete subscription: $error';
  }

  @override
  String get deleteSuccess => 'Delete successful';

  @override
  String get delivery => 'Delivery';

  @override
  String get deviceDeletedSuccessfully => 'Device deleted successfully';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Device deleted successfully';

  @override
  String get deviceIdLabel => 'Device ID';

  @override
  String get deviceIDLabel => 'Device ID';

  @override
  String get deviceManagementSubtitle => 'Manage multi-device synchronization';

  @override
  String get deviceManagementTitle => 'Device Management';

  @override
  String get deviceModelLabel => 'Device Model';

  @override
  String get deviceName => 'Device Name';

  @override
  String get deviceNameCannotBeEmpty => 'Device name cannot be empty';

  @override
  String get deviceNameHint => 'Please enter device name';

  @override
  String get deviceNameLabel => 'Device Name';

  @override
  String get deviceRenamedSuccessfully => 'Device renamed successfully';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Device renamed successfully';

  @override
  String get devicesSyncedSuccessfully => 'Devices synchronized successfully';

  @override
  String get devicesSyncedSuccessfullyMessage => 'Devices synchronized successfully';

  @override
  String get devicesSynchronizedSuccessfullyMessage => 'Devices synchronized successfully';

  @override
  String get deviceUnregisteredSuccessfullyMessage => 'Device unregistered successfully';

  @override
  String get dialogTitle => 'Regex Pattern Explanation';

  @override
  String get differentFromLocalCounter => 'This feature is different from the local counter filter, as it focuses on repeated call patterns in a short time rather than long-term marking counts.';

  @override
  String get disabled => 'Disabled';

  @override
  String get disabledStatus => 'Disabled';

  @override
  String get disableGlobalPlugins => 'Disable global plugins';

  @override
  String get disableSubscriptionSuccessfully => 'Disable subscription successfully';

  @override
  String get disconnectButton => 'Disconnect';

  @override
  String get disconnectedMessage => 'Disconnected';

  @override
  String get disconnectedStatus => 'Disconnected';

  @override
  String get disconnectFailedMessage => 'Disconnect failed';

  @override
  String get done => 'Done';

  @override
  String get dualSimAdvice => 'This feature is particularly useful for dual-SIM phones to set different filtering strategies for work and personal SIM cards.';

  @override
  String get earlier => 'Earlier';

  @override
  String get ecommerce => 'Ecommerce';

  @override
  String get edit => 'Edit';

  @override
  String get editContact => 'Edit Contact';

  @override
  String get editFilter => 'Edit Filter';

  @override
  String get editLabel => 'Edit Label';

  @override
  String get editPhoneRule => 'Edit Phone Rule';

  @override
  String get editPhoneRules => 'Used to edit phone rules';

  @override
  String get editPhoneRuleTitle => 'Edit Phone Rule';

  @override
  String get editRule => 'Edit Rule';

  @override
  String get editSmsRule => 'Edit SMS Rule';

  @override
  String get education => 'Education';

  @override
  String get elementPositionsSetting => 'Element Positions';

  @override
  String get email => 'Email';

  @override
  String get emailOptional => 'Email (Optional)';

  @override
  String get enableCallFilter => 'Enable Call Filter';

  @override
  String get enableCallFilterDescription => 'When enabled, incoming calls are checked against the rule list below. Call filtering rules are not synchronized between devices by default.';

  @override
  String get enabled => 'Enabled';

  @override
  String get enabledStatus => 'Enabled';

  @override
  String get enableEncryption => 'Enable Encryption';

  @override
  String get enableEncryptionDescription => 'Encrypt backup files';

  @override
  String get enableEncryptionLabel => 'Enable Encryption';

  @override
  String get enableEncryptionSubtitle => 'Backup files will be encrypted';

  @override
  String get enableEncryptionTitle => 'Enable Encryption';

  @override
  String get enableGlobalPlugins => 'Enable global plugins';

  @override
  String get enableLocalCountFilter => 'Enable Local Count Filter';

  @override
  String get enableLocalCountFilterDescription => 'Automatically filter spam calls based on call marking count';

  @override
  String get enableLocalNotification => 'Use Local Notification';

  @override
  String get enableLocalNotificationDescription => 'When enabled, notifications for filtered messages will be displayed on the device';

  @override
  String get enableLocationSummary => 'Location';

  @override
  String get enableMuteRules => 'Enable Mute Rules';

  @override
  String get enableMuteRulesDesc => 'Apply mute interception rules configuration';

  @override
  String get enableNoneActionRules => 'Enable None Action Rules';

  @override
  String get enableNoneActionRulesDesc => 'Allow rule configurations with no interception actions';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get enableRemoteNumberFilter => 'Enable Remote Number Filter';

  @override
  String get enableRemoteNumberFilterDescription => 'Use remote database to filter numbers';

  @override
  String get enableRule => 'Enable Rule';

  @override
  String get enableSmsFilter => 'Enable SMS Filtering';

  @override
  String get enableSmsFilterDescription => 'When enabled, messages will be automatically filtered according to the rules';

  @override
  String get enableStatisticsNotifications => 'Enable Statistics Notifications';

  @override
  String get enableSubscriptionSuccessfully => 'Enable subscription successfully';

  @override
  String get enableTimeInterception => 'Enable Time Interception';

  @override
  String get enableTimeInterceptionDescription => 'Intercept repeated calls within a short time';

  @override
  String get enableTimeInterceptor => 'Enable Time Interceptor';

  @override
  String get endCallImmediately => 'End call immediately';

  @override
  String get endColor => 'End Color';

  @override
  String get endDate => 'End Date';

  @override
  String get enhancedFilterInstructionsTitle => 'Enhanced Filter System';

  @override
  String get enhancedFilterSettings => 'Enhanced Filter Settings';

  @override
  String get enhancedFilterSettingsTitle => 'Enhanced Filter Settings';

  @override
  String get enhancedFilterSystemDescription => 'The enhanced filter system supports both global rules and per-SIM card filtering configurations.';

  @override
  String get enterBothPhoneNumberAndRegexPattern => 'Please enter both phone number and regex pattern';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage => 'Please enter both phone number and regex pattern.';

  @override
  String get enterContactName => 'Please enter contact name';

  @override
  String get enterCurrentPasswordHint => 'Please enter current password';

  @override
  String get enterDeviceName => 'Enter Device Name';

  @override
  String get enterDeviceNameHint => 'Please enter device name';

  @override
  String get enterEmail => 'Please enter email';

  @override
  String get enterEmailOptional => 'Please enter email (optional)';

  @override
  String get enterEncryptionPasswordHint => 'Enter encryption password';

  @override
  String get enterEncryptionPasswordTitle => 'Enter Encryption Password';

  @override
  String get enterFilterName => 'Please enter filter name';

  @override
  String get enterFilterPattern => 'Please enter filter pattern';

  @override
  String get enterIconCode => 'Enter icon code';

  @override
  String get enterName => 'Enter contact name';

  @override
  String get enterNewDeviceNameHint => 'Enter a new name for this device';

  @override
  String get enterNewPasswordHint => 'Please enter new password';

  @override
  String get enterPasswordAgain => 'Enter Password Again';

  @override
  String get enterPasswordHint => 'Please enter password';

  @override
  String get enterPhoneNumber => 'Enter phone number';

  @override
  String get enterPhoneNumberHint => 'Enter phone number to test';

  @override
  String get enterPhoneNumberMultiple => 'Please enter phone number, multiple numbers separated by commas';

  @override
  String get enterPhoneNumberToStartSearch => 'Enter phone number to start search';

  @override
  String get enterPhoneNumberToVerify => 'Enter phone number to verify';

  @override
  String get enterPluginName => 'Enter Plugin Name';

  @override
  String get enterPluginUrl => 'Enter plugin URL address';

  @override
  String get enterRegexHint => 'Enter regex pattern';

  @override
  String get enterRuleNameAndPattern => 'Please enter rule name and pattern';

  @override
  String get enterRuleNameAndPatternMessage => 'Please enter both rule name and regex pattern.';

  @override
  String get enterRuleNameHint => 'Enter rule name';

  @override
  String get enterSearchContent => 'Please enter search content';

  @override
  String get enterSubscriptionName => 'Enter subscription name';

  @override
  String get enterSubscriptionUrl => 'Enter subscription URL';

  @override
  String get enterSyncFolderNameHint => 'Please enter sync folder name (default: NotificationManager)';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get enterValidNameAndUrl => 'Please enter valid name and URL';

  @override
  String get enterValidUrl => 'Please enter a valid URL';

  @override
  String get enterVersion => 'Enter Version';

  @override
  String get enterWebDAVPasswordHint => 'Please enter WebDAV password';

  @override
  String get enterWebDAVServerAddressHint => 'Please enter WebDAV server address';

  @override
  String get enterWebDAVUsernameHint => 'Please enter WebDAV username';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Error deleting device: $error';
  }

  @override
  String get errorLoadingPlugin => 'Error loading plugin';

  @override
  String errorOccurredMessage(Object error) {
    return 'An error occurred: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Error renaming device: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Error synchronizing devices: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Error syncing devices: $error';
  }

  @override
  String get errorText => 'Error';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Error unregistering device: $error';
  }

  @override
  String get exampleBlock400Prefix => 'e.g. Block 400 prefix numbers';

  @override
  String get exampleBlockMarketingSms => 'e.g. Block marketing SMS';

  @override
  String get exampleContentRegex => 'e.g., .*offer.*';

  @override
  String get exampleContentRegexHint => 'Example Content Regex';

  @override
  String get exampleCouponPromotionDiscount => 'e.g. .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'e.g. Family, Friends, etc.';

  @override
  String get examplePhoneNumber => 'e.g. 10086, 12345, etc.';

  @override
  String get exampleRegex400Prefix => 'Example regex for 400 prefix';

  @override
  String get exampleRegexFormat => 'Example: ^10086\$ format';

  @override
  String get exampleSenderRegexHint => 'Example';

  @override
  String get exchange => 'Exchange';

  @override
  String get exchangeNow => 'Exchange Now';

  @override
  String get exchangeVip => 'Exchange VIP';

  @override
  String get expandLabelSelector => 'Expand Label Selector';

  @override
  String expiryTime(Object time) {
    return 'Expiry time: $time';
  }

  @override
  String get export => 'Export';

  @override
  String get exportAllApplicationSettings => 'Export all application settings';

  @override
  String get exportAllApplicationSettingsSubtitle => 'Export all application settings';

  @override
  String get exportAllRuleConfigurations => 'Export All Rule Configurations';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'Export all rule configurations';

  @override
  String get exportComplete => 'Export Complete';

  @override
  String get exportConfig => 'Export Configuration';

  @override
  String get exportContacts => 'Export Contacts';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportError => 'Export Error';

  @override
  String get exportFailed => 'Export failed';

  @override
  String get exportFailure => 'Failed to export configuration';

  @override
  String get exportFeatureComingSoon => 'Export feature coming soon';

  @override
  String get exporting => 'Exporting...';

  @override
  String get exportLabels => 'Export Labels';

  @override
  String exportLabelsFailed(Object error) {
    return 'Failed to export labels: $error';
  }

  @override
  String get exportPluginList => 'Export Plugin List';

  @override
  String exportPluginListFailed(Object error) {
    return 'Failed to export plugin list: $error';
  }

  @override
  String get exportRules => 'Export Rules';

  @override
  String get exportRulesDialogTitle => 'Export Rules';

  @override
  String get exportRulesTitle => 'Export Rules';

  @override
  String get exportSmsRules => 'Export SMS Rules';

  @override
  String get exportStatisticsData => 'Export Statistics Data';

  @override
  String get exportSuccess => 'Export successful';

  @override
  String get exportSuccesslly => 'Configuration exported successfully';

  @override
  String get failedToAddContact => 'Failed to add contact';

  @override
  String failedToAddRule(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'Failed to add SMS rule: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Failed to add SMS subscription: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Failed to backup settings: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'Failed to decrypt backup file';

  @override
  String get failedToDeleteDevice => 'Failed to delete device';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Failed to delete SMS rule: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Failed to export rules: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'Failed to export SMS rules: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Failed to get caller ID information: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'Failed to import SMS rules: $error';
  }

  @override
  String get failedToLoadContacts => 'Failed to load contacts';

  @override
  String get failedToLoadPlugin => 'Failed to load plugin';

  @override
  String get failedToRenameDevice => 'Failed to rename device';

  @override
  String get failedToRestoreSettings => 'Failed to restore settings';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Failed to restore settings: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Failed to set password: $error';
  }

  @override
  String get failedToSyncDevices => 'Failed to sync devices';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Failed to toggle rule status: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'Failed to toggle subscription status';

  @override
  String get failedToUpdateContact => 'Failed to update contact';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'Failed to update SMS rule: $error';
  }

  @override
  String get failure => 'Failure';

  @override
  String get favoriteContacts => 'Favorite Contacts';

  @override
  String get featureAddRules => '• Add phone number specific rules';

  @override
  String get featureCenter => 'Feature Center';

  @override
  String get featureEnableDisable => '• Enable/disable different filters per SIM';

  @override
  String get featureListTitle => 'Features:';

  @override
  String get featureManageRules => '• Manage rule lists per SIM';

  @override
  String get features => 'Features';

  @override
  String get fetchingCallerIdInfo => 'Fetching caller ID information...';

  @override
  String fileSavedTo(Object path) {
    return 'File saved to: $path';
  }

  @override
  String get filter => 'Filter';

  @override
  String get filterByLabel => 'Filter by Label';

  @override
  String get filterClear => 'Clear Filter';

  @override
  String get filterControlPanelTitle => 'Filter Control Panel';

  @override
  String get filterControlSubtitle => 'Manage on/off status of all filters';

  @override
  String get filterControlTitle => 'Filter Control';

  @override
  String get filterDeleteFailed => 'Filter delete failed';

  @override
  String get filterDeleteSuccess => 'Filter deleted successfully';

  @override
  String get filterDetails => 'Filter Details';

  @override
  String get filtered => 'Filtered';

  @override
  String get filteredSms => 'Filtered SMS';

  @override
  String get filteredSmsLabel => 'Filtered SMS';

  @override
  String get filterExplanation => 'Filter Explanation';

  @override
  String get filterManagement => 'Filter Management';

  @override
  String get filterName => 'Filter Name';

  @override
  String get filterPattern => 'Filter Pattern';

  @override
  String get filterPriorityNote => 'Note: There are priority relationships between filters, please refer to the help documentation for details';

  @override
  String get filterSaveFailed => 'Filter save failed';

  @override
  String get filterSaveSuccess => 'Filter saved successfully';

  @override
  String get filterSettings => 'Filter Settings';

  @override
  String get filterSettingsTitle => 'Filter Settings';

  @override
  String get filterSMS => 'Filter SMS';

  @override
  String get filterToggleInstructions => 'Enable or disable filters for this SIM slot:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get filterType => 'Filter Type';

  @override
  String get financial => 'Financial';

  @override
  String get flexibleCombinationFeature => '• Flexible Combinations: Enable/disable filters per SIM slot';

  @override
  String get fontSizesSetting => 'Font Sizes';

  @override
  String foundRules(Object count) {
    return 'Found $count rules';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return 'Found $count rules. Do you want to import them?';
  }

  @override
  String foundRulesToImport(Object count) {
    return 'Found $count rules. Do you want to import them?';
  }

  @override
  String get fraudAlert => 'FRAUD ALERT - Hang up the call';

  @override
  String get fraudScamLikely => 'Fraud Scam Likely';

  @override
  String get free => 'Free';

  @override
  String get functionSettingsTitle => 'Function Settings';

  @override
  String generalUpdateFailure(Object error) {
    return 'Update failed: $error';
  }

  @override
  String get getFree => 'Get Free';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription => 'Configure global filters for all SIM cards:';

  @override
  String get globalFilterFeature => '• Global Filters: Basic rules for all incoming calls';

  @override
  String get globalFilterSettings => 'Global Filter Settings';

  @override
  String get globalFilterToggleInstructions => 'Configure global filter settings that apply to all SIM slots:';

  @override
  String get globalSearchSubtitle => 'Search contacts, labels, blacklists, whitelists, etc.';

  @override
  String get globalSearchTitle => 'Global Search';

  @override
  String get globalSettings => 'Global Settings';

  @override
  String get googleAdDisplayPosition => 'Google Ad Display Position';

  @override
  String get googleAdMobIntegrationText => 'Google AdMob ads can be integrated here';

  @override
  String get googleDriveAuthDescription => 'Authorize using system-configured Google Drive client ID and key';

  @override
  String get googleDriveAuthorizationHint => 'Authorize using system-configured Google Drive client ID and key';

  @override
  String get googleDriveConfigTitle => 'Google Drive Configuration';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive Configuration';

  @override
  String get government => 'Government';

  @override
  String get granted => 'Granted';

  @override
  String get grantNecessaryPermissions => 'Grant Necessary Permissions';

  @override
  String get grantPermissions => 'Grant Permissions';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Height';

  @override
  String get homePageTitle => 'Home Page';

  @override
  String get homeTab => 'Home';

  @override
  String get howItWorksPoint1 => '• The system will automatically intercept calls from the same number within the set time window';

  @override
  String get howItWorksPoint2 => '• Shorter time windows result in stricter interception; longer time windows result in looser interception';

  @override
  String get howItWorksPoint3 => '• The system checks call logs to determine if it\'s a repeated call';

  @override
  String get howItWorksTitle => 'How It Works:';

  @override
  String get iconCodeOptional => 'Icon Code (Optional)';

  @override
  String get iconSize => 'Icon Size';

  @override
  String get import => 'Import';

  @override
  String get important => 'Important';

  @override
  String get importButton => 'Import';

  @override
  String get importConfig => 'Import Configuration';

  @override
  String get importContacts => 'Import Contacts';

  @override
  String get importExportContacts => 'Import/Export Contacts';

  @override
  String get importExportContactsTooltip => 'Import/Export Contacts';

  @override
  String get importExportRules => 'Import/Export Rules';

  @override
  String importFailed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String get importFailure => 'Failed to import configuration';

  @override
  String get importFeatureComingSoon => 'Import feature coming soon';

  @override
  String get importLabels => 'Import Labels';

  @override
  String importLabelsFailed(Object error) {
    return 'Failed to import labels: $error';
  }

  @override
  String get importPluginList => 'Import Plugin List';

  @override
  String importPluginListFailed(Object error) {
    return 'Failed to import plugin list: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Successfully imported $count plugins';
  }

  @override
  String get importRuleConfigurationsFromFile => 'Import Rule Configurations from File';

  @override
  String get importRuleConfigurationsFromFileSubtitle => 'Import rule configurations from file';

  @override
  String get importRules => 'Import Rules';

  @override
  String get importRulesButton => 'Import Rules';

  @override
  String get importRulesDialogTitle => 'Import Rules';

  @override
  String importRulesError(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String get importRulesInstructions => 'Import rules from a CSV file';

  @override
  String get importRulesSuccess => 'Rules imported successfully';

  @override
  String get importRulesTitle => 'Import Rules';

  @override
  String get importSuccess => 'Import successful';

  @override
  String get incomingCallInterceptAction => 'Incoming Call Intercept Action';

  @override
  String get incomingCallNotification => 'Incoming Call Notification';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get initializing => 'Initializing';

  @override
  String get installed => 'Installed';

  @override
  String get insufficientMarks => 'Insufficient Marks';

  @override
  String get insurance => 'Insurance';

  @override
  String get interceptAction => 'Intercept Action';

  @override
  String get interceptionActionSettingsSubtitle => 'Set how blocked calls are handled';

  @override
  String get interceptionActionSettingsTitle => 'Interception Action Settings';

  @override
  String get interceptionTimeInterval => 'Interception Time Interval';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service update interval set to $days days';
  }

  @override
  String get invalidContentRegex => 'Invalid content regex';

  @override
  String get invalidLabel => 'Invalid label';

  @override
  String get invalidRegexPattern => 'Invalid regex pattern';

  @override
  String get invalidSenderRegex => 'Invalid sender regex';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo => 'Join the Telegram Channel and Group for More Info';

  @override
  String get jsLogsTitle => 'JS Logs';

  @override
  String get jsonFormat => 'JSON Format';

  @override
  String get keepAllVersions => 'Keep All Versions';

  @override
  String get keepAllVersionsDescription => 'Keep all historical versions of each backup';

  @override
  String get keepAllVersionsLabel => 'Keep All Versions';

  @override
  String get keepAllVersionsSubtitle => 'Keep historical versions of each backup';

  @override
  String get keepAllVersionsTitle => 'Keep All Versions';

  @override
  String get label => 'Label';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Label \"$name\" added successfully';
  }

  @override
  String get labelCategories => 'Label Categories';

  @override
  String get labelDeleted => 'Label deleted';

  @override
  String get labelDescription => 'Labels help you better manage contacts, add custom labels to phone numbers for easy identification of calls and messages.';

  @override
  String get labelFilter => 'Label Filter';

  @override
  String get labelFilterTooltip => 'Label Filter';

  @override
  String get labelIconColor => 'Label Icon Color';

  @override
  String get labelManagement => 'Label Management';

  @override
  String get labelNotFound => 'Label not found';

  @override
  String get labelRemoved => 'Label removed';

  @override
  String labelRemoveFailed(Object error) {
    return 'Failed to remove label: $error';
  }

  @override
  String get labels => 'Labels';

  @override
  String get labelsColor => 'Labels Color';

  @override
  String labelsDeleted(Object count) {
    return '$count labels deleted';
  }

  @override
  String get labelsExportedSuccessfully => 'Labels exported successfully';

  @override
  String get labelsFontSize => 'Labels Font Size';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Successfully imported $count labels';
  }

  @override
  String get labelsPosition => 'Labels Position';

  @override
  String labelTag(Object labelId) {
    return 'Label: $labelId';
  }

  @override
  String get labelUpdated => 'Label updated';

  @override
  String labelUpdateFailed(Object error) {
    return 'Failed to update label: $error';
  }

  @override
  String get labelUpdateSuccess => 'Label \"\$labelText\" updated successfully';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get languageSettingsSubtitle => 'Change application display language';

  @override
  String get languageSettingsTitle => 'Language Settings';

  @override
  String get last30Days => 'Last 30 Days';

  @override
  String get last7Days => 'Last 7 Days';

  @override
  String get lastSyncLabel => 'Last Sync';

  @override
  String lastUpdated(Object date) {
    return 'Last Updated: $date';
  }

  @override
  String get lifetimeMembership => 'Lifetime Membership';

  @override
  String get lifetimeMembershipDescription => 'One-time purchase, permanently unlock all premium features and future updates';

  @override
  String loadContactsFailed(Object error) {
    return 'Failed to load contacts: $error';
  }

  @override
  String get loadDataFailed => 'Failed to load data';

  @override
  String get loadFailed => 'Load Failed';

  @override
  String get loading => 'Loading...';

  @override
  String get loadingData => 'Loading Data...';

  @override
  String get loadingTags => 'Loading tags...';

  @override
  String loadLabelFailed(Object error) {
    return 'Failed to load labels: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Failed to load labels: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Failed to load marked phone numbers: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Failed to load marked phones: $error';
  }

  @override
  String get loadMore => 'Load More';

  @override
  String get loadPluginButton => 'Load Plugin';

  @override
  String loadPluginsFailed(Object error) {
    return 'Failed to load plugins: $error';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Failed to load rules: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Failed to load settings: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Failed to load SMS rules: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Failed to load status';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String get loan => 'Loan';

  @override
  String get localBackupTitle => 'Local Backup';

  @override
  String get localCounterFilter => 'Local Counter Filter';

  @override
  String get localCounterFilterSubtitle => 'Automatically filter spam calls based on call frequency';

  @override
  String get localCountFilter => 'Local Count Filter';

  @override
  String get localCountFilterDescription => 'Intercept frequent calls based on local number counts';

  @override
  String get localCountFilterExplanationContent => 'The local count filter analyzes call history records to automatically identify and block frequent spam calls.';

  @override
  String get localCountFilterExplanationTitle => 'Local Count Filter Explanation';

  @override
  String get localCountFilterHowItWorksPoint1 => '• Determine whether to block based on the number\'s count value';

  @override
  String get localCountFilterHowItWorksPoint2 => '• When a number\'s count exceeds the set threshold, you can choose to automatically block it';

  @override
  String get localCountFilterHowItWorksPoint3 => '• You can selectively allow numbers that don\'t exceed the threshold';

  @override
  String get localCountFilterHowItWorksPoint4 => '• You can choose whether to record all query logs';

  @override
  String get localCountFiltering => 'Local Count Filtering';

  @override
  String get localCountFilteringExplanation => '• Local Count Filtering: Filtering rules based on local marking count';

  @override
  String get localCountFilterSettings => 'Local Count Filter Settings';

  @override
  String get localCountFilterUseCases => 'This filter is particularly suitable for identifying auto-dialed spam calls and marketing calls.';

  @override
  String get localFilterSettings => 'Local Filter Settings';

  @override
  String get localNotificationDisabled => 'Local notification disabled';

  @override
  String get localNotificationEnabled => 'Local notification enabled';

  @override
  String get localServices => 'Local Services';

  @override
  String get locationColor => 'Location Color';

  @override
  String get locationFontSize => 'Location Font Size';

  @override
  String get locationIconColor => 'Location Icon Color';

  @override
  String get locationPosition => 'Location Position';

  @override
  String get logAllLocalQueries => 'Log All Local Queries';

  @override
  String get logAllLocalQueriesDescription => 'Record logs for all local number queries';

  @override
  String get logAllRemoteQueries => 'Log All Remote Queries';

  @override
  String get logAllRemoteQueriesDescription => 'Record all remote number query operations';

  @override
  String get manage => 'Manage Contacts';

  @override
  String get manageContacts => 'Manage';

  @override
  String get manageFavoriteContacts => 'Manage Favorite Contacts';

  @override
  String get manageFilterRules => 'Manage Filter Rules';

  @override
  String get manageFilterRulesDescription => 'Add, edit, or delete SMS filter rules';

  @override
  String get manageFrequentContacts => 'Manage Frequent Contacts';

  @override
  String get markCounts => 'Mark Counts';

  @override
  String get markCount => 'Mark Count';

  @override
  String markedByCount(Object count) {
    return 'Marked by $count';
  }

  @override
  String get markedPhonesList => 'Marked Phone Numbers';

  @override
  String get markExchange => 'Mark Exchange';

  @override
  String get markPhone => 'Mark Phone Number';

  @override
  String markPhoneFailed(Object error) {
    return 'Failed to mark phone number: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'To Mark Phone Numbers';

  @override
  String get markPhoneManagementTitle => 'Mark Phone Management';

  @override
  String get markPhoneSuccess => 'Phone number marked successfully';

  @override
  String get matchFailed => 'Match failed!';

  @override
  String get matchFailedMessage => 'Match failed.';

  @override
  String get matchNumbersWithSpecialCharacters => 'matches specific number format';

  @override
  String get matchNumbersWithSpecialCharactersTitle => 'Match numbers with special characters:';

  @override
  String get matchSpecificDigitPatterns => 'matches XXX-XXXX-XXXX format';

  @override
  String get matchSpecificDigitPatternsTitle => 'Match specific digit patterns:';

  @override
  String get matchSuccessful => 'Match successful!';

  @override
  String get matchSuccessfulMessage => 'Match successful!';

  @override
  String get medical => 'Medical';

  @override
  String get membershipPrivileges => 'Membership Privileges';

  @override
  String get migrationTool => 'Migration Tool';

  @override
  String get migrationToolTitle => 'Migration Tool';

  @override
  String get minutes => 'minutes';

  @override
  String get month => 'Month';

  @override
  String get monthly => 'Monthly';

  @override
  String get monthlyCallCount => 'Monthly Calls';

  @override
  String get monthlyChartTitle => 'Monthly Blocked Calls';

  @override
  String get monthlyMembership => 'Monthly Membership';

  @override
  String get monthlyMembershipDescription => 'Unlock all premium features, auto-renew monthly';

  @override
  String get monthlyTotal => 'Monthly Total';

  @override
  String get monthlyTotalLabel => 'Monthly Total';

  @override
  String get moreOptions => 'More Options';

  @override
  String get mute => 'Mute';

  @override
  String get name => 'Name';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => 'Name and phone number cannot be empty';

  @override
  String get nameAndPhoneNumberRequired => 'Name and phone number cannot be empty';

  @override
  String get nameColor => 'Name Color';

  @override
  String get nameFontSize => 'Name Font Size';

  @override
  String nameLabel(Object name) {
    return 'Name: $name';
  }

  @override
  String get namePosition => 'Name Position';

  @override
  String get nameUnknown => 'Name: Unknown';

  @override
  String nameWithValue(String name) {
    return 'Name: $name';
  }

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get nextStep => 'Next';

  @override
  String get noAction => 'No Action';

  @override
  String get noActionRules => 'No Action Rules';

  @override
  String get noActiveCloudSyncServiceMessage => 'No active cloud sync service';

  @override
  String get noAds => 'No Ads';

  @override
  String get noCallLogs => 'No Call Logs';

  @override
  String get noCallRecords => 'No call records';

  @override
  String get noContacts => 'No contacts yet';

  @override
  String get noContactsYet => 'No contacts yet';

  @override
  String get noData => 'No Data';

  @override
  String get noDevicesRegisteredMessage => 'No devices registered';

  @override
  String get noDevicesRegisteredYet => 'No devices registered yet.';

  @override
  String get noFilters => 'No filters yet';

  @override
  String get noLabels => 'No labels yet';

  @override
  String get noMarkedPhones => 'No marked phone numbers';

  @override
  String get noMatchingContacts => 'No matching contacts';

  @override
  String get noMatchingContactsFound => 'No matching contacts found';

  @override
  String get noMatchingNumbersFound => 'No matching numbers found';

  @override
  String get noMatchingRecords => 'No matching call records';

  @override
  String noMatchingRules(Object ruleType) {
    return 'No matching $ruleType';
  }

  @override
  String get none => 'None';

  @override
  String get noneServiceType => 'None';

  @override
  String get noPlugins => 'No plugins yet';

  @override
  String get noRecords => 'No call records';

  @override
  String get noResultReturned => 'No result returned';

  @override
  String get noResultReturnedLog => 'No result returned from plugin';

  @override
  String noRules(Object ruleType) {
    return 'No $ruleType yet';
  }

  @override
  String get noRulesPrompt => 'No rules found, please add rules';

  @override
  String get noRulesToExport => 'No rules to export';

  @override
  String get noSmsFilterRulesYet => 'No SMS filter rules yet';

  @override
  String get noSmsRulesYet => 'No SMS rules yet';

  @override
  String get noSubscriptions => 'No subscriptions';

  @override
  String get noSubscriptionsYet => 'No Subscriptions Yet';

  @override
  String get notGranted => 'Not Granted';

  @override
  String get notificationMode => 'Notification';

  @override
  String get notificationModeDescription => 'Show caller information in the notification bar';

  @override
  String get notificationPermission => 'Notification Permission';

  @override
  String get notificationPermissionDescription => 'Used to display incoming call and message notifications.';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get notificationSettingsSaved => 'Notification settings saved successfully';

  @override
  String get notSet => 'Not Set';

  @override
  String get notVerifiedText => 'Not Verified';

  @override
  String get noValidSmsRulesFoundInFile => 'No valid SMS rules found in file';

  @override
  String get number => 'Number';

  @override
  String get numberColor => 'Number Color';

  @override
  String get numberFontSize => 'Number Font Size';

  @override
  String get numberPosition => 'Number Position';

  @override
  String get numberSearch => 'Number Search';

  @override
  String get numberTypeColor => 'Number Type Color';

  @override
  String get numberTypeFontSize => 'Number Type Font Size';

  @override
  String get numberTypePosition => 'Number Type Position';

  @override
  String get ok => 'OK';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription => 'Your call security manager is ready, start enjoying a secure call experience!';

  @override
  String get onboardingLanguageDescription => 'Choose your preferred language for the best experience.';

  @override
  String get onboardingPermissionsDescription => 'To provide full service, we need the following permissions:';

  @override
  String get onboardingPowerfulSpamBlockingDescription => 'One-click blocking of spam calls and messages, customize blocking rules, and give you a quiet environment.';

  @override
  String get onboardingSmartCallerIdDescription => 'Automatically identify unknown calls, mark suspicious numbers, and protect your call safety.';

  @override
  String get onboardingWelcomeDescription => 'Your call management expert, providing comprehensive call identification and blocking services.';

  @override
  String get oneDriveAuthDescription => 'Authorize using system-configured OneDrive client ID and key';

  @override
  String get oneDriveAuthorizationHint => 'Authorize using system-configured OneDrive client ID and key';

  @override
  String get oneDriveConfigTitle => 'OneDrive Configuration';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive Configuration';

  @override
  String get onlineCallerIdSubscription => 'Online Caller ID Subscription';

  @override
  String get openAppSettings => 'Open app settings';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Failed to open app settings: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operation failed: $error';
  }

  @override
  String get operationFailure => 'Operation failed';

  @override
  String get operationSuccess => 'Operation succeeded';

  @override
  String get other => 'Other';

  @override
  String get ourOtherApps => 'Our Other Apps';

  @override
  String get overlayMode => 'Floating Window';

  @override
  String get overlayModeDescription => 'Show caller information in a floating window';

  @override
  String get overlayPermission => 'Overlay Permission';

  @override
  String get overlayPermissionDescription => 'Used to display incoming call overlay.';

  @override
  String get overview => 'Overview';

  @override
  String get password => 'Password';

  @override
  String get passwordCannotBeEmpty => 'Password cannot be empty';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get passwordSetSuccessfully => 'Password set successfully';

  @override
  String get pattern => 'Pattern';

  @override
  String get pendingSync => 'Pending Sync';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodYear => 'Year';

  @override
  String get permissionDenied => 'Permission request denied';

  @override
  String get permissionGranted => 'Permission granted';

  @override
  String get permissionManagement => 'Permission Management';

  @override
  String get phoneCallsTab => 'Phone';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get phoneNumberCannotBeEmpty => 'Phone number cannot be empty';

  @override
  String get phoneNumberHint => 'Enter phone number';

  @override
  String get phoneNumberHintText => 'Enter phone number to add rule';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberRegexRequired => 'Please enter both phone number and regex pattern';

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get phoneNumberTypeFixedLine => 'Fixed line';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Fixed line or mobile';

  @override
  String get phoneNumberTypeMobile => 'Mobile';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Personal number';

  @override
  String get phoneNumberTypePremiumRate => 'Premium rate';

  @override
  String get phoneNumberTypeSharedCost => 'Shared cost';

  @override
  String get phoneNumberTypeTollFree => 'Toll free';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Unknown';

  @override
  String get phoneNumberTypeVoicemail => 'Voicemail';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Phone Permission';

  @override
  String get phonePermissionDescription => 'Used to identify and block incoming calls.';

  @override
  String get phoneRule => 'Phone Rule';

  @override
  String get phoneRuleEditDialog => 'Phone Rule Edit Dialog';

  @override
  String get phoneRuleManagement => 'Phone Rule Management';

  @override
  String get phoneRuleSubscription => 'Phone Rule Subscription';

  @override
  String get phoneSubscription => 'Phone Subscription';

  @override
  String get phoneSubscriptionRulesDescription => 'Subscribe to phone rule lists via URL to automatically update whitelist and blacklist rules. Supports JSON format rule files.';

  @override
  String get phoneSubscriptionTitle => 'Phone Rule Subscriptions';

  @override
  String get pleaseSelectLabelAndEnterValidPhone => 'Please select a label and enter a valid phone number';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" added successfully';
  }

  @override
  String get pluginDeleted => 'Plugin deleted';

  @override
  String get pluginLatestVersion => 'Plugin is already the latest version';

  @override
  String get pluginListExportSuccess => 'Plugin list exported successfully';

  @override
  String get pluginLoadedSuccessfully => 'Plugin loaded successfully';

  @override
  String get pluginManagement => 'Plugin Management';

  @override
  String get pluginManagementSubtitle => 'Manage and configure third-party plugins';

  @override
  String get pluginManagementTitle => 'Plugin Management';

  @override
  String get pluginName => 'Plugin Name';

  @override
  String get pluginNotLoaded => 'Plugin is not loaded yet. Please load the plugin first.';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins deleted successfully.';
  }

  @override
  String get pluginService => 'Plugin Service';

  @override
  String get pluginTestPageTitle => 'Plugin Test';

  @override
  String get pluginUpdateSuccess => 'Plugin updated successfully';

  @override
  String get pluginUrl => 'Plugin URL';

  @override
  String get pluginUrlCannotBeEmpty => 'Plugin URL cannot be empty';

  @override
  String get pluginUrlHint => 'Enter plugin URL';

  @override
  String get pluginUrlLabel => 'Plugin URL';

  @override
  String get pluginVersion => 'Plugin Version';

  @override
  String get political => 'Political';

  @override
  String get powerfulSpamBlocking => 'Powerful Spam Blocking';

  @override
  String get previousStep => 'Previous';

  @override
  String get prioritizeRemoteAction => 'Prioritize Remote Action Settings';

  @override
  String get prioritizeRemoteActionDescription => 'Prioritize action settings from the remote database';

  @override
  String get processing => 'Processing...';

  @override
  String get processingOperation => 'Processing...';

  @override
  String get purchase => 'Purchase';

  @override
  String get quarterlyMembership => 'Quarterly Membership';

  @override
  String get quarterlyMembershipDescription => 'Unlock all premium features, auto-renew quarterly';

  @override
  String get queryButton => 'Query';

  @override
  String get queryFailed => 'Query failed';

  @override
  String get queryFailedLog => 'Query failed';

  @override
  String get querying => 'Querying...';

  @override
  String get queryingPhoneNumber => 'Querying phone number';

  @override
  String get queryResultTitle => 'Query Result';

  @override
  String get ready => 'Ready!';

  @override
  String get receiveWeeklyStatistics => 'Receive weekly statistics';

  @override
  String get recruiter => 'Recruiter';

  @override
  String get reEnterPasswordHint => 'Please re-enter password';

  @override
  String get refresh => 'Refresh';

  @override
  String get refreshPermissionStatus => 'Refresh permission status';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String regexError(Object error) {
    return 'Regex error: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex error: $error';
  }

  @override
  String get regexPattern => 'Regex Pattern';

  @override
  String get regexPatternExplanation => 'Regex Pattern Explanation';

  @override
  String get regexPatternExplanationButton => 'Regex Pattern Explanation';

  @override
  String get regexPatternLabel => 'Regex Pattern';

  @override
  String get regexPatternsExamples => 'Use standard regex syntax to define patterns. Examples:';

  @override
  String get regexPatternsForPhoneNumberMatching => 'Regex Patterns for Phone Number Matching';

  @override
  String get regexRule => 'Regex Rule';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Failed to add regex rule: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex rule added successfully';

  @override
  String get regexRuleManagement => 'Regex Rule Management';

  @override
  String get regexRuleNamePatternRequired => 'Rule name and regex pattern cannot be empty';

  @override
  String get regexRules => 'Regex Rules';

  @override
  String get regexTesterTitle => 'Regex Tester';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex validation failed: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex validation successful';

  @override
  String get region => 'Region';

  @override
  String get registeredDevicesTitle => 'Registered Devices';

  @override
  String get rejectAllCalls => 'Reject All Calls';

  @override
  String get rejectAllCallsDescription => 'When enabled, all calls will be rejected with highest priority';

  @override
  String get rejectAllNumbers => 'Reject All Numbers';

  @override
  String get rejectAllNumbersDesc => 'Reject all incoming calls when enabled';

  @override
  String get rejectExceededNumbers => 'Reject Exceeded Numbers';

  @override
  String get rejectExceededNumbersDescription => 'Automatically reject numbers exceeding the count threshold';

  @override
  String get remoteFilterSettings => 'Remote Filter Settings';

  @override
  String get remoteFilterSettingsPageTitle => 'Remote Number Filter Settings';

  @override
  String get remoteNumberFilter => 'Remote Number Filter';

  @override
  String get remoteNumberFilterDatabaseInfo => 'This filter uses an independent remote database to get the latest number information.';

  @override
  String get remoteNumberFilterDescription => 'Intercept harassing calls based on remote database information';

  @override
  String get remoteNumberFilterExplanationContent => 'The remote number filter identifies and blocks spam calls by querying a remote database based on number count.';

  @override
  String get remoteNumberFilterExplanationTitle => 'Remote Number Filter Explanation';

  @override
  String get remoteNumberFilterFeatureCountThreshold => '• Count Threshold: Determine based on number occurrence frequency';

  @override
  String get remoteNumberFilterFeatureFilterAction => '• Filter Actions: Configure how to handle numbers exceeding threshold';

  @override
  String get remoteNumberFilterFeaturePriority => '• Priority Settings: Set priority for remote actions';

  @override
  String get remoteNumberFilterFeatures => 'Features:';

  @override
  String get remoteNumberFiltering => 'Remote Number Filtering';

  @override
  String get remoteNumberFilteringExplanation => '• Remote Number Filtering: Filtering rules based on remote database information';

  @override
  String get remoteNumberFilterSubtitle => 'Identify spam calls using cloud database and community reports';

  @override
  String get removeAdsDescription => 'Permanently remove all ads in the app for a smoother experience';

  @override
  String get removeAdsTitle => 'Remove Ads';

  @override
  String get removedFromFavoriteContacts => 'Removed from favorite contacts';

  @override
  String get removedFromFavorites => 'Removed from favorite contacts';

  @override
  String get removeFavorite => 'Remove Favorite';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get renameButton => 'Rename';

  @override
  String get renameDeviceDialogTitle => 'Rename Device';

  @override
  String get renameDeviceTitle => 'Rename Device';

  @override
  String get replaceCurrentSettingsConfirmation => 'This will replace all your current settings. Are you sure you want to continue?';

  @override
  String get requestAllPermissions => 'Request All Permissions';

  @override
  String get requestPermission => 'Request Permission';

  @override
  String requestPermissionFailed(Object error) {
    return 'Failed to request permission: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Marks';
  }

  @override
  String get reset => 'Reset';

  @override
  String get restore => 'Restore';

  @override
  String get restoreApplicationSettingsFromBackup => 'Restore Application Settings from Backup';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle => 'Restore application settings from backup';

  @override
  String get restoreButton => 'Restore';

  @override
  String restoreFailedWithError(Object error) {
    return 'Restore from cloud failed: $error';
  }

  @override
  String get restoreFromCloud => 'Restore from Cloud';

  @override
  String get restoreFromCloudDescription => 'Restore settings and rules from cloud storage';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Failed to restore from cloud: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Restore from Cloud';

  @override
  String get restoreFromCloudSuccess => 'Successfully restored from cloud';

  @override
  String get restoreFromCloudTitle => 'Restore from Cloud';

  @override
  String get restoreFromLocal => 'Restore from Local';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get restoreSectionTitle => 'Restore';

  @override
  String get restoreSettings => 'Restore Settings';

  @override
  String get restoreSettingsConfirmation => 'This will replace all your current settings. Are you sure you want to continue?';

  @override
  String get restoreSettingsDialogTitle => 'Restore Settings';

  @override
  String get restoreSettingsTitle => 'Restore Settings';

  @override
  String get restoreSuccessFromLocal => 'Successfully restored from local';

  @override
  String get restoreSuccessMessage => 'Successfully restored from cloud';

  @override
  String get retry => 'Retry';

  @override
  String get ridesharing => 'Ridesharing';

  @override
  String get risk => 'Risk';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Rule Action';

  @override
  String get ruleAddButton => 'Add Rule';

  @override
  String get ruleAddedSuccess => 'Rule added successfully';

  @override
  String ruleAddFailure(Object error) {
    return 'Failed to add rule: $error';
  }

  @override
  String get ruleAddSuccess => 'Rule added successfully';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Are you sure you want to delete this $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Delete Rule';

  @override
  String get ruleDeletedSuccess => 'Rule deleted successfully';

  @override
  String get ruleDeletedSuccessfully => 'Rule deleted successfully';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Failed to delete rule: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Failed to delete rule: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Rule deleted successfully';

  @override
  String get ruleDisabledSuccessfully => 'Rule disabled successfully';

  @override
  String get ruleEnabledSuccessfully => 'Rule enabled successfully';

  @override
  String ruleLoadFailed(Object error) {
    return 'Failed to load rules: $error';
  }

  @override
  String get ruleManagement => 'Rule Management';

  @override
  String get ruleManagementTitle => 'Rule Management';

  @override
  String get ruleName => 'Rule Name';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty => 'Rule name and content regex cannot be empty';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty => 'Rule name and phone number cannot be empty';

  @override
  String get ruleNameHint => 'e.g., Family, Friends, etc.';

  @override
  String get ruleNameLabel => 'Rule Name';

  @override
  String get ruleNamePatternRequired => 'Please enter rule name and pattern';

  @override
  String get ruleNameRequired => 'Rule name and phone number cannot be empty';

  @override
  String get ruleNotExist => 'Rule does not exist or has been deleted';

  @override
  String ruleNotFound(Object error) {
    return 'Rule not found: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Rule saved successfully!';

  @override
  String get ruleSavedSuccessMessage => 'Rule saved successfully!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get ruleSaveSuccess => 'Rule saved successfully!';

  @override
  String get rulesExportedSuccessfully => 'Rules exported successfully';

  @override
  String rulesExportedTo(Object path) {
    return 'Rules exported to: $path';
  }

  @override
  String get rulesImported => 'Rules imported successfully';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count rules imported successfully';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Failed to import rules: $error';
  }

  @override
  String get ruleStatistics => 'Rule Statistics';

  @override
  String ruleStatusChanged(Object status) {
    return 'Rule $status successfully';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operation failed: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Rule $status successfully';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Failed to update rule: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Rule updated successfully';

  @override
  String get ruleVerification => 'Rule Verification';

  @override
  String get save => 'Save';

  @override
  String get saveButton => 'Save';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get saveButtonText => 'Save';

  @override
  String saveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get saveFilter => 'Save Filter';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String saveSettingsFailed(Object error) {
    return 'Failed to save settings: $error';
  }

  @override
  String get scamsLikely => 'Scams Likely';

  @override
  String get search => 'Search';

  @override
  String get searchContacts => 'Search Contacts';

  @override
  String searchError(Object error) {
    return 'Search error: $error';
  }

  @override
  String get searchFilters => 'Search Filters';

  @override
  String get searchForContacts => 'Search for contacts';

  @override
  String get searchHint => 'Search...';

  @override
  String get searchSettingsSubtitle => 'Search contacts, labels, blacklists, whitelists, etc.';

  @override
  String get searchSettingsTitle => 'Search Settings';

  @override
  String get securityMessage => 'Do not trust any phone calls. Always verify customer service numbers independently. Never share passwords, verification codes, card numbers, or personal information.';

  @override
  String get selectActionToPerform => 'Select the action to perform when the rule matches';

  @override
  String get selectActionWhenBlockingCalls => 'Select action when blocking calls';

  @override
  String get selectActionWhenRuleMatches => 'Select action when rule matches';

  @override
  String get selectAll => 'Select All';

  @override
  String get selectCountry => 'Select Country';

  @override
  String get selectDateRange => 'Select Date Range';

  @override
  String get selectedDateRange => 'Selected date range';

  @override
  String selectedItems(Object count) {
    return '$count items selected';
  }

  @override
  String get selectedLabel => 'Selected:';

  @override
  String get selectExportFormat => 'Select Export Format';

  @override
  String get selectLabel => 'Select Label';

  @override
  String get selectLabelAndEnterPhoneNumber => 'Please select a label and enter a valid phone number';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectMultiple => 'Select Multiple';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get selectSimCard => 'Select SIM Card';

  @override
  String get selectSimSlot => 'Select SIM Slot';

  @override
  String get selectSpecificActionForBlockedCalls => 'Select the specific action to perform when blocking calls';

  @override
  String get selectTag => 'Select Tag';

  @override
  String get selectTags => 'Select Tags';

  @override
  String get selectTrustedDataSource => 'Please select trusted data sources';

  @override
  String get selectYourLanguage => 'Select Your Language';

  @override
  String get sender => 'Sender';

  @override
  String get senderRegexOptional => 'Sender Regex (Optional)';

  @override
  String get serverAddressLabel => 'Server Address';

  @override
  String get serviceTypeContact => 'Contact Subscription';

  @override
  String get serviceTypeLabel => 'Service Type';

  @override
  String get serviceTypePhone => 'Phone Subscription';

  @override
  String get serviceTypePlugin => 'Plugin Update';

  @override
  String get serviceTypeSms => 'SMS Subscription';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Set';

  @override
  String get setEncryptionPassword => 'Set Encryption Password';

  @override
  String get setEncryptionPasswordDescription => 'Set encryption password for backup and restore';

  @override
  String get setEncryptionPasswordLabel => 'Set Encryption Password';

  @override
  String get setEncryptionPasswordTitle => 'Set Encryption Password';

  @override
  String get setPasswordButton => 'Set';

  @override
  String get settings => 'Settings';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Settings backed up to: $path';
  }

  @override
  String get settingsLoaded => 'Settings loaded';

  @override
  String settingsLoadFailed(Object error) {
    return 'Failed to load settings: $error';
  }

  @override
  String get settingsRestoredSuccessfully => 'Settings restored successfully. Please restart the app for changes to take effect.';

  @override
  String get settingsSaved => 'Settings saved';

  @override
  String settingsSaveFailed(Object error) {
    return 'Failed to save settings: $error';
  }

  @override
  String get settingsTab => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get setup => 'Setup';

  @override
  String get showContactEditDialogStaticMethod => 'Static method to display contact edit dialog';

  @override
  String get showExplanation => 'Show Explanation';

  @override
  String get silence => 'Silence';

  @override
  String get silenceAndNoAnswer => 'Silence and No Answer';

  @override
  String get silenceNoAnswer => 'Silence No Answer';

  @override
  String get silentCallVoiceClone => 'Silent Call Voice Clone';

  @override
  String get silentRules => 'Silent Rules';

  @override
  String simCard(Object simNumber) {
    return 'SIM Card $simNumber';
  }

  @override
  String get simCardColor => 'SIM Card Color';

  @override
  String get simCardConfigurationExplanation => '• SIM Card Configuration: Set independent filtering rules for each SIM card';

  @override
  String get simCardFilterRules => 'SIM Card Filter Rules';

  @override
  String get simCardFilterRulesDescription => 'Set different filtering rules based on SIM card slots';

  @override
  String get simCardFontSize => 'SIM Card Font Size';

  @override
  String get simCardPosition => 'SIM Card Position';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'Failed to load SIM card information: $error';
  }

  @override
  String get simRuleInstructions => 'SIM slot rules allow you to configure independent filtering rules for each SIM slot.';

  @override
  String get simRuleInstructionsTitle => 'SIM Slot Rules';

  @override
  String get simRuleManagement => 'SIM Slot Rule Management';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String simSlotDataLoadFailed(Object error) {
    return 'Failed to load SIM data: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM Slot Filter Configuration';

  @override
  String get simSlotFilterConfigurationDescription => 'Allowing to set filter rules by SIM slot';

  @override
  String get simSlotFilterDescription => 'Configure independent filtering rules for each SIM card:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM Slot $slotNumber Filter Settings';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'Failed to load SIM slots: $error';
  }

  @override
  String get simSlotManagement => 'SIM Slot Management';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM slot operation failed: $error';
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
  String get simSlotRuleFeature => '• SIM Slot Rules: Independent filtering strategies per SIM';

  @override
  String get simSlotRuleListTitle => 'SIM Slot Rules List';

  @override
  String get simSlotRuleManagement => 'SIM Slot Rules';

  @override
  String get simSlotRuleManagementTitle => 'Rule Management';

  @override
  String get simSlotSettings => 'SIM Slot Settings';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM Slot $slotNumber';
  }

  @override
  String get skip => 'Skip';

  @override
  String get smartCallerId => 'Smart Call Identification';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription => 'SMS filtering helps you automatically filter spam messages and keep your message list clean. You can set filter rules and notification methods.';

  @override
  String get smsFilterDisabled => 'SMS filtering disabled';

  @override
  String get smsFilterEnabled => 'SMS filtering enabled';

  @override
  String get smsFilterRuleAddedSuccessfully => 'SMS filter rule added successfully';

  @override
  String get smsFilterRules => 'SMS Filter Rules';

  @override
  String get smsFilterSettings => 'SMS Filter Settings';

  @override
  String get smsHistory => 'SMS History';

  @override
  String get smsManagement => 'SMS Management';

  @override
  String get smsPermission => 'SMS Permission';

  @override
  String get smsPermissionDescription => 'Used to filter spam messages.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS rule added successfully';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS rule deleted successfully';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Failed to load SMS rules: $error';
  }

  @override
  String get smsRuleManagement => 'SMS Rule Management';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS rules exported successfully to $filePath';
  }

  @override
  String get smsRulesImportedSuccessfully => 'SMS rules imported successfully';

  @override
  String get smsRuleSubscription => 'SMS Rule Subscription';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS rule updated successfully';

  @override
  String get smsSettingsSubtitle => 'SMS filtering and keyword blocking';

  @override
  String get smsSettingsTitle => 'SMS Settings';

  @override
  String get smsSubscription => 'SMS Subscription';

  @override
  String get smsSubscriptionAddedSuccessfully => 'SMS subscription added successfully';

  @override
  String get smsSubscriptionRulesDescription => 'Subscribe to SMS rule lists via URL, supporting regular expression matching. You can set block or allow actions.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Some permission requests denied';

  @override
  String get spamLikely => 'Spam Likely';

  @override
  String get startColor => 'Start Color';

  @override
  String get startDate => 'Start Date';

  @override
  String get startUsing => 'Get Started';

  @override
  String get statAnswered => 'Answered';

  @override
  String get statBlocked => 'Blocked';

  @override
  String get staticMethodShowCallerIdDialog => 'Static method to show the Caller ID Information Dialog';

  @override
  String get staticMethodToDisplayCountrySelectionDialog => 'Static method to display country selection dialog';

  @override
  String get staticMethodToDisplayDialog => 'Static method to display dialog';

  @override
  String get statistics => 'Statistics';

  @override
  String get statisticsExportFeatureComingSoon => 'Statistics export feature coming soon';

  @override
  String get statisticsGrid => 'Statistics Grid';

  @override
  String get statisticsPageTitle => 'Data Analysis';

  @override
  String get stirColor => 'STIR Color';

  @override
  String get stirFontSize => 'STIR Font Size';

  @override
  String get stirPosition => 'STIR Position';

  @override
  String get storagePermission => 'Storage Permission';

  @override
  String get storagePermissionDescription => 'Used to save settings and rules.';

  @override
  String get subscribe => 'Subscribe';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Subscription \"$name\" added successfully';
  }

  @override
  String get subscriptionDeleteConfirmContent => 'Are you sure you want to delete this subscription?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Delete Subscription';

  @override
  String get subscriptionDeleted => 'Subscription deleted';

  @override
  String get subscriptionDeletedSuccessfully => 'Subscription deleted successfully';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Failed to delete subscription: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Subscription deleted';

  @override
  String get subscriptionEmptyState => 'No subscriptions available';

  @override
  String get subscriptionEmptyText => 'No subscriptions yet';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Failed to load subscriptions: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Subscription Management';

  @override
  String get subscriptionName => 'Subscription Name';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty => 'Subscription name and URL cannot be empty';

  @override
  String get subscriptionNameHint => 'Enter subscription name';

  @override
  String get subscriptionPageTitle => 'Subscription Management';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Failed to change subscription status: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Failed to toggle subscription status: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Failed to update subscription: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Subscription updated successfully';

  @override
  String get subscriptionUrl => 'Subscription URL';

  @override
  String get subscriptionUrlHint => 'Enter subscription URL';

  @override
  String successfullyImportedRules(Object count) {
    return 'Successfully imported $count rules';
  }

  @override
  String get supportSync => 'Support Sync';

  @override
  String get survey => 'Survey';

  @override
  String get syncDevicesButton => 'Sync Devices';

  @override
  String get synced => 'Synced';

  @override
  String get syncFailed => 'Sync failed';

  @override
  String get syncFailedMessage => 'Sync failed';

  @override
  String get syncFolderNameHint => 'Please enter sync folder name (default: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Sync Folder Name';

  @override
  String get synchronized => 'Synchronized';

  @override
  String get syncing => 'Syncing...';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get syncNowButton => 'Sync Now';

  @override
  String get syncStatusTitle => 'Sync Status';

  @override
  String get syncStatusUpdatedMessage => 'Sync status updated';

  @override
  String get syncSuccessful => 'Sync successful';

  @override
  String get syncSuccessMessage => 'Sync successful';

  @override
  String get syncWithCloudStorage => 'Sync with Cloud Storage';

  @override
  String get syncWithCloudStorageSubtitle => 'Sync with cloud storage';

  @override
  String get systemFeatures => 'System Features:';

  @override
  String get systemSettingsTitle => 'System Settings';

  @override
  String get tabAll => 'All';

  @override
  String get tabAnswered => 'Answered';

  @override
  String get tabBlocked => 'Blocked';

  @override
  String get tabMissed => 'Missed';

  @override
  String get tabOutgoing => 'Outgoing';

  @override
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get tagsUpdated => 'Tags updated';

  @override
  String get takeaway => 'Takeaway';

  @override
  String get telecommunication => 'Telecommunication';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Test Connection';

  @override
  String get textColorsSetting => 'Text & Label Colors';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows => 'This app is a powerful caller ID tool that allows you to identify and block unwanted calls.';

  @override
  String get thisWeek => 'This Week';

  @override
  String get timeInterceptor => 'Time Interceptor';

  @override
  String get timeInterceptorDescription => 'Automatically intercept potential spam calls based on call frequency';

  @override
  String get timeInterceptorExplanation => '• Time Interceptor: Intercept repeated calls within a short time';

  @override
  String get timeInterceptorExplanationContent => 'The call frequency interception feature analyzes call frequency to automatically identify and intercept frequent spam calls.';

  @override
  String get timeInterceptorExplanationTitle => 'Call Frequency Interception Explanation';

  @override
  String get timeInterceptorSettingsTitle => 'Call Frequency Interception Settings';

  @override
  String get timeInterceptorSubtitle => 'Automatically intercept potential spam calls based on call frequency';

  @override
  String get timeInterceptorTitle => 'Enable Call Frequency Interception';

  @override
  String get timeWindowDescription => 'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted';

  @override
  String timeWindowLabel(int minutes) {
    return 'Interception Time Window (minutes): $minutes';
  }

  @override
  String get timeWindowSetting => 'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted';

  @override
  String get today => 'Today';

  @override
  String get total => 'Total';

  @override
  String get totalBlocked => 'Total Blocked';

  @override
  String get totalFiltered => 'Total Filtered';

  @override
  String get transferDataBetweenDevicesOrPlatforms => 'Transfer data between devices or platforms';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle => 'Transfer data between devices or platforms';

  @override
  String get travelTicketing => 'Travel Ticketing';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Trend Chart';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Type';

  @override
  String get unassignedSIMCard => 'Unassigned SIM Card';

  @override
  String get unknown => 'Unknown';

  @override
  String get unknownAction => 'Unknown Action';

  @override
  String get unknownLabel => 'Unknown Label';

  @override
  String get unknownTag => 'Tag: Unknown';

  @override
  String get unregisterButton => 'Unregister';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Are you sure you want to unregister $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Unregister Device';

  @override
  String get unsupportedFileFormat => 'Unsupported file format';

  @override
  String get update => 'Update';

  @override
  String get updateAllNow => 'Update All Now';

  @override
  String get updateCallFilterConfig => 'Update Call Filter Configuration';

  @override
  String updateContactFailed(Object error) {
    return 'Failed to update contact: $error';
  }

  @override
  String get updateFavoriteStatus => 'Update Favorite Status';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Failed to update favorite status: $error';
  }

  @override
  String get updateInterval => 'Update Interval';

  @override
  String get updateLabelFailed => 'Failed to update label';

  @override
  String get updateNow => 'Update Now';

  @override
  String get updatePlugin => 'Update Plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Failed to update plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Failed to update rule: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Failed to update subscription: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service updated successfully ($count rules)';
  }

  @override
  String get updateTags => 'Update Tags';

  @override
  String get useCasesPoint1 => '• Identify auto-redial spam calls';

  @override
  String get useCasesPoint2 => '• Intercept marketing calls that call multiple times in a short period';

  @override
  String get useCasesPoint3 => '• Prevent phone bombing and harassment';

  @override
  String get useCasesTitle => 'Use Cases:';

  @override
  String get useGlobalSettings => 'Use Global Settings';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Username';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples => 'Use standard regex syntax to define patterns. Examples:';

  @override
  String get validateRegex => 'Validate Regex';

  @override
  String get verificationFailedText => 'Failed';

  @override
  String get verifiedText => 'Verified';

  @override
  String get verify => 'Verify';

  @override
  String version(Object version) {
    return 'Version: $version';
  }

  @override
  String get vipExchangeDescription => 'Exchange VIP membership with phone number marking counts';

  @override
  String get vipExchangeTitle => 'Mark Exchange VIP';

  @override
  String get watchAd => 'Watch Ad';

  @override
  String get watchAdForTemp => 'Watch Ad for Temporary Privileges';

  @override
  String get watchAdForTempDescription => 'Watch a short ad to temporarily unlock some premium features';

  @override
  String get webDAVConfigTitle => 'WebDAV Configuration';

  @override
  String get webdavConfigurationTitle => 'WebDAV Configuration';

  @override
  String get webdavPasswordHint => 'Please enter WebDAV password';

  @override
  String get webdavServerAddressHint => 'Please enter WebDAV server address';

  @override
  String get webdavUsernameHint => 'Please enter WebDAV username';

  @override
  String get week => 'Week';

  @override
  String get weekly => 'Weekly';

  @override
  String get weeklyBlockedCallsSummary => 'Weekly Blocked Calls Summary';

  @override
  String get weeklyChartTitle => 'Weekly Blocked Calls';

  @override
  String get weeklyReport => 'Weekly Report';

  @override
  String get weeklyReportDesc => 'Receive weekly summary report of call blocking activity';

  @override
  String get welcome => 'Welcome';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get whitelistLabel => 'Whitelist';

  @override
  String get width => 'Width';

  @override
  String get wildcardMatchingDescription => 'Use \'.\' to match any character (e.g. \'123.456\' matches 123-456)';

  @override
  String get wildcardMatchingTitle => 'Wildcard matching:';

  @override
  String get wildcardSupportForFlexibleFiltering => 'Wildcard Support for Flexible Filtering';

  @override
  String get windowSizeSetting => 'Window Size';

  @override
  String get year => 'Year';

  @override
  String get yearly => 'Yearly';

  @override
  String get yearlyChartTitle => 'Yearly Blocked Calls';

  @override
  String get noSimCardsDetected => 'No SIM cards detected';

  @override
  String get filterManagementDescription => 'Set Call Filters';

  @override
  String get callerIdCustomizationSubtitle => 'Customize Caller ID Layout';

  @override
  String get fraudAlerSettingTitle => 'Fraud Alert Setting';

  @override
  String get fraudAlerSettingSubtitle => 'To Set Fraud Alert';

  @override
  String get enableFraudAlert => 'Enable Fraud Alert';

  @override
  String get enableFraudAlertDescription => 'Alert for suspected scam calls';

  @override
  String get enableVibration => 'Enable Vibration';

  @override
  String get enableVibrationDescription => 'Vibrate when call is suspected scam calls';

  @override
  String get notificationSettingsTitle => 'Notification Settings';

  @override
  String get useLocalNotification => 'Use Local Notifications';

  @override
  String get useLocalNotificationDescription => 'Enable local notifications for incoming calls';

  @override
  String get cancelLocalNotification => 'Close Local Notifications';

  @override
  String get useStirNotification => 'Use Notification from STIR';

  @override
  String get useStirNotificationDescription => 'Enable STIR notifications for incoming calls';

  @override
  String get cancelLocalNotificationDescription => 'Close Local Notifications Automatically';

  @override
  String get callerIdSettingsTitle => 'Caller ID Settings';

  @override
  String get callerIdSettingsSubtitle => 'To Set up Incoming Call Notification & Display Mode';

  @override
  String get purchaseTitle => 'Purchase';

  @override
  String get purchaseSubtitle => 'To Purchase the Service';

  @override
  String get callerIdNotificationTitle => 'Incoming Call Info';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Number: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Blocked Call';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Blocked call from $phoneNumber';
  }

  @override
  String get stirVerified => 'Verified';

  @override
  String get stirNotVerified => 'Not Verified';

  @override
  String get stirFailed => 'Verification Failed';

  @override
  String get stirUnknown => 'Unknown Verification Status';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Verification';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage for number $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings => 'Scrolling Security Message Settings';

  @override
  String get messageColor => 'Message Color';

  @override
  String get messageFontSize => 'Message Font Size';

  @override
  String get messagePosition => 'Message Position';

  @override
  String get containerWidth => 'Container Width';

  @override
  String get scrollSpeed => 'Scroll Speed';

  @override
  String get enableSecurityMessage => 'Enable Security Message';

  @override
  String get fraudAlertTitle => 'Fraud Alert';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'Potential fraud call from $phoneNumber';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Failed to load call log: $error';
  }

  @override
  String get noBlockedTypeData => 'No blocked type data available';

  @override
  String importEntity(Object entityTypeName) {
    return 'Import $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName imported successfully, total $count records imported';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Failed to import $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Export $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName exported successfully';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Failed to export $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Cloud Sync Service';

  @override
  String get membershipCenter => 'Membership Center';

  @override
  String get redeemVipWithMarks => 'Redeem VIP with Marks';

  @override
  String get currentMarkCount => 'Current Mark Count';

  @override
  String get markMoreNumbersForMore => 'Mark more numbers for more marks';

  @override
  String get cloudBackup => 'Cloud Backup';

  @override
  String get callerIdEnhancement => 'Caller ID Enhancement';

  @override
  String get voiceRecognition => 'Voice Recognition';

  @override
  String get feature => 'Feature';

  @override
  String get normalUser => 'Normal User';

  @override
  String get vipUser => 'VIP User';

  @override
  String get temporaryVip => 'Temporary VIP';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get settingsBackup => 'Settings Backup ';

  @override
  String get allServicesStatusTitle => 'Current Service Status';

  @override
  String get allServicesStatusSubtitle => 'Current Status of Each Cloud Service';

  @override
  String get redirect => 'Redirect';

  @override
  String get notify => 'Notify';

  @override
  String get log => 'Log';

  @override
  String get custom => 'Custom';

  @override
  String get allowActionDescription => 'Calls will be allowed, even if the number is on the blocklist.';

  @override
  String get blockActionDescription => 'Calls will be blocked and shown in the call log.';

  @override
  String get silenceActionDescription => 'Calls will be silenced but shown in the call log.';

  @override
  String get noneActionDescription => 'No special action will be taken for the call.';

  @override
  String get redirectActionDescription => 'Redirect the call to a specified number.';

  @override
  String get labelActionDescription => 'Add a label to the call for easy identification.';

  @override
  String get notifyActionDescription => 'Send a notification when a call is received.';

  @override
  String get logActionDescription => 'Log the call information without taking any other action.';

  @override
  String get customActionDescription => 'Perform a custom action.';

  @override
  String get needVipAccess => 'You need VIP access to use this feature';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Import or export $entityTypeName data';
  }

  @override
  String get importExportTitle => 'Import/Export';

  @override
  String get noPhoneRules => 'No phone rules found';

  @override
  String get noRegexRules => 'No regex rules found';

  @override
  String get noAllowedBlockedRules => 'No allowed/blocked rules found';

  @override
  String get importExport => 'Import/Export';

  @override
  String get filterByAction => 'Filter by Action';

  @override
  String get upgradeToVip => 'Upgrade to VIP';

  @override
  String get batteryOptimizationPermission => 'Battery Optimization';

  @override
  String get batteryOptimizationPermissionDescription => 'Allow the app to run in the background to provide services like caller ID.';

  @override
  String get permissionTitle => 'Special Permissions';

  @override
  String get permissionSubtitle => 'Manage overlay and battery optimization permissions';

  @override
  String get themeSettingsTitle => 'Theme Settings';

  @override
  String get themeSettingsSubtitle => 'Choose your favorite theme';

  @override
  String get databaseSyncTitle => 'Database Sync';

  @override
  String get countrySyncSettingsTitle => 'Country Based Database Sync Settings';

  @override
  String get countrySyncSettingsSubtitle => 'Select countries for data synchronization';

  @override
  String get countryDataDisclaimer => 'Please note: The database may not include data for all specific countries or regions.';

  @override
  String get editSubscription => 'Edit Subscription';

  @override
  String get searchByNameOrPhoneNumber => 'Search By Name or PhoneNumber';

  @override
  String get allowedBlockedRulesInfo => 'Allowed/blocked rules are used to match calls to specific phone numbers, which have the highest priority.';

  @override
  String get searchPhoneRulesHint => 'Search phone rules';

  @override
  String get phoneRulesInfo => 'Phone rules are used to match calls to specific phone numbers, which havve a lower priority. Some comes from the phoneRule subscriptions';

  @override
  String get searchSubscriptionsHint => 'Search subscriptions';

  @override
  String get searchPluginsHint => 'Search plugins';

  @override
  String get searchLabelsHint => 'Search labels';

  @override
  String get pluginDescription => 'Plugin description';

  @override
  String get enterPluginDescription => 'Enter plugin description';

  @override
  String get searchRegexRulesHint => 'Search regex rules';

  @override
  String get regexRulesInfo => 'Regex rules are used to filter calls based on the Regex Patterns.';

  @override
  String get searchMarkedPhonesHint => 'Search marked phones';

  @override
  String get searchContactSubscriptionsHint => 'Search contact subscriptions';

  @override
  String get showAllContacts => 'Show All Contacts';

  @override
  String get showFavorites => 'Show Favorites';

  @override
  String get manualEntry => 'Manual Entry Info';

  @override
  String get scriptSaved => 'Script saved';

  @override
  String editScriptFor(String pluginName) {
    return 'Edit script for $pluginName';
  }

  @override
  String get saveScript => 'Save Script';

  @override
  String get testPlugin => 'Test Plugin';

  @override
  String get description => 'Description';

  @override
  String get accessTargetUrl => 'Access Target URL';

  @override
  String get result => 'Result';

  @override
  String get editScript => 'Edit Script';

  @override
  String get numberFormat => 'Number Format';

  @override
  String get nationalNumber => 'National Number';

  @override
  String get e164Number => 'E164 Number';

  @override
  String get yesterday => 'Yesterday';
}
