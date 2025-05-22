import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @callHistoryInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryInfoTitle;

  /// No description provided for @callHistoryInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Here shows your call history, including incoming, outgoing and missed calls.'**
  String get callHistoryInfoDesc;

  /// No description provided for @tabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tabAll;

  /// No description provided for @tabAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get tabAnswered;

  /// No description provided for @tabMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get tabMissed;

  /// No description provided for @tabBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get tabBlocked;

  /// No description provided for @tabOutgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get tabOutgoing;

  /// No description provided for @callHistoryTimelineToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get callHistoryTimelineToday;

  /// No description provided for @callHistoryTimelineYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get callHistoryTimelineYesterday;

  /// No description provided for @callHistoryTimelineEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get callHistoryTimelineEarlier;

  /// No description provided for @callTypeAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get callTypeAnswered;

  /// No description provided for @callTypeOutgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get callTypeOutgoing;

  /// No description provided for @callTypeMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed Call'**
  String get callTypeMissed;

  /// No description provided for @callTypeBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get callTypeBlocked;

  /// No description provided for @callTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get callTypeUnknown;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Call history initialization failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize call history: {error}'**
  String callHistoryInitFailed(Object error);

  /// Call history refresh failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh call history: {error}'**
  String callHistoryRefreshFailed(Object error);

  /// No description provided for @timeInterceptorSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Frequency Interception Settings'**
  String get timeInterceptorSettingsTitle;

  /// No description provided for @settingsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load settings: {error}'**
  String settingsLoadFailed(Object error);

  /// No description provided for @settingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings: {error}'**
  String settingsSaveFailed(Object error);

  /// No description provided for @noRecords.
  ///
  /// In en, this message translates to:
  /// **'No call records'**
  String get noRecords;

  /// No description provided for @noMatchingRecords.
  ///
  /// In en, this message translates to:
  /// **'No matching call records'**
  String get noMatchingRecords;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @labelFilter.
  ///
  /// In en, this message translates to:
  /// **'Label Filter'**
  String get labelFilter;

  /// No description provided for @filterClear.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get filterClear;

  /// No description provided for @noCallRecords.
  ///
  /// In en, this message translates to:
  /// **'No call records'**
  String get noCallRecords;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @clearLabelFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Label Filter'**
  String get clearLabelFilter;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @earlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get earlier;

  /// No description provided for @statBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get statBlocked;

  /// No description provided for @statAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get statAnswered;

  /// No description provided for @filterByLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter by Label'**
  String get filterByLabel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get clearFilter;

  /// No description provided for @processingOperation.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processingOperation;

  /// No description provided for @operationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operation succeeded'**
  String get operationSuccess;

  /// No description provided for @operationFailure.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailure;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @configManagement.
  ///
  /// In en, this message translates to:
  /// **'Configuration Management'**
  String get configManagement;

  /// No description provided for @importConfig.
  ///
  /// In en, this message translates to:
  /// **'Import Configuration'**
  String get importConfig;

  /// No description provided for @exportConfig.
  ///
  /// In en, this message translates to:
  /// **'Export Configuration'**
  String get exportConfig;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @configUpdated.
  ///
  /// In en, this message translates to:
  /// **'Configuration updated'**
  String get configUpdated;

  /// No description provided for @checkFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Please check file format or permissions'**
  String get checkFileFormat;

  /// No description provided for @simInfoLoadFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to load ScM card inforaation: {error}'**
  String simInfoLoadFailure(Object error);

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailed;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Configuration imported successfully'**
  String get importSuccess;

  /// No description provided for @importFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to import configuration'**
  String get importFailure;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Configuration exported successfully'**
  String get exportSuccess;

  /// No description provided for @exportFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to export configuration'**
  String get exportFailure;

  /// No description provided for @axisPosition.
  ///
  /// In en, this message translates to:
  /// **'{axis} Position'**
  String axisPosition(Object axis);

  /// No description provided for @colorPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Color'**
  String get colorPickerTitle;

  /// No description provided for @enableTimeInterceptor.
  ///
  /// In en, this message translates to:
  /// **'Enable Time Interceptor'**
  String get enableTimeInterceptor;

  /// No description provided for @timeInterceptorDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically intercept potential spam calls based on call frequency'**
  String get timeInterceptorDescription;

  /// No description provided for @timeInterceptorTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Call Frequency Interception'**
  String get timeInterceptorTitle;

  /// No description provided for @timeInterceptorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically intercept potential spam calls based on call frequency'**
  String get timeInterceptorSubtitle;

  /// No description provided for @timeWindowSetting.
  ///
  /// In en, this message translates to:
  /// **'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted'**
  String get timeWindowSetting;

  /// No description provided for @timeInterceptorExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Frequency Interception Explanation'**
  String get timeInterceptorExplanationTitle;

  /// No description provided for @timeInterceptorExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'The call frequency interception feature analyzes call frequency to automatically identify and intercept frequent spam calls.'**
  String get timeInterceptorExplanationContent;

  /// No description provided for @howItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How It Works:'**
  String get howItWorksTitle;

  /// No description provided for @howItWorksPoint1.
  ///
  /// In en, this message translates to:
  /// **'• The system will automatically intercept calls from the same number within the set time window'**
  String get howItWorksPoint1;

  /// No description provided for @howItWorksPoint2.
  ///
  /// In en, this message translates to:
  /// **'• Shorter time windows result in stricter interception; longer time windows result in looser interception'**
  String get howItWorksPoint2;

  /// No description provided for @howItWorksPoint3.
  ///
  /// In en, this message translates to:
  /// **'• The system checks call logs to determine if it\'s a repeated call'**
  String get howItWorksPoint3;

  /// No description provided for @useCasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Use Cases:'**
  String get useCasesTitle;

  /// No description provided for @useCasesPoint1.
  ///
  /// In en, this message translates to:
  /// **'• Identify auto-redial spam calls'**
  String get useCasesPoint1;

  /// No description provided for @useCasesPoint2.
  ///
  /// In en, this message translates to:
  /// **'• Intercept marketing calls that call multiple times in a short period'**
  String get useCasesPoint2;

  /// No description provided for @useCasesPoint3.
  ///
  /// In en, this message translates to:
  /// **'• Prevent phone bombing and harassment'**
  String get useCasesPoint3;

  /// No description provided for @differentFromLocalCounter.
  ///
  /// In en, this message translates to:
  /// **'This feature is different from the local counter filter, as it focuses on repeated call patterns in a short time rather than long-term marking counts.'**
  String get differentFromLocalCounter;

  /// Time window label with duration in minutes
  ///
  /// In en, this message translates to:
  /// **'Interception Time Window (minutes): {minutes}'**
  String timeWindowLabel(int minutes);

  /// No description provided for @timeWindowDescription.
  ///
  /// In en, this message translates to:
  /// **'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted'**
  String get timeWindowDescription;

  /// No description provided for @phoneNumberTypeFixedLine.
  ///
  /// In en, this message translates to:
  /// **'Fixed line'**
  String get phoneNumberTypeFixedLine;

  /// No description provided for @phoneNumberTypeMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get phoneNumberTypeMobile;

  /// No description provided for @phoneNumberTypeFixedLineOrMobile.
  ///
  /// In en, this message translates to:
  /// **'Fixed line or mobile'**
  String get phoneNumberTypeFixedLineOrMobile;

  /// No description provided for @phoneNumberTypeTollFree.
  ///
  /// In en, this message translates to:
  /// **'Toll free'**
  String get phoneNumberTypeTollFree;

  /// No description provided for @phoneNumberTypePremiumRate.
  ///
  /// In en, this message translates to:
  /// **'Premium rate'**
  String get phoneNumberTypePremiumRate;

  /// No description provided for @phoneNumberTypeSharedCost.
  ///
  /// In en, this message translates to:
  /// **'Shared cost'**
  String get phoneNumberTypeSharedCost;

  /// No description provided for @phoneNumberTypeVoip.
  ///
  /// In en, this message translates to:
  /// **'VoIP'**
  String get phoneNumberTypeVoip;

  /// No description provided for @phoneNumberTypePersonalNumber.
  ///
  /// In en, this message translates to:
  /// **'Personal number'**
  String get phoneNumberTypePersonalNumber;

  /// No description provided for @phoneNumberTypePager.
  ///
  /// In en, this message translates to:
  /// **'Pager'**
  String get phoneNumberTypePager;

  /// No description provided for @phoneNumberTypeUan.
  ///
  /// In en, this message translates to:
  /// **'UAN'**
  String get phoneNumberTypeUan;

  /// No description provided for @phoneNumberTypeVoicemail.
  ///
  /// In en, this message translates to:
  /// **'Voicemail'**
  String get phoneNumberTypeVoicemail;

  /// No description provided for @phoneNumberTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get phoneNumberTypeUnknown;

  /// No description provided for @callFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'Call Filter Settings'**
  String get callFilterSettings;

  /// Enhanced filter settings page title
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter Settings'**
  String get enhancedFilterSettings;

  /// No description provided for @simSlotManagement.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Management'**
  String get simSlotManagement;

  /// No description provided for @statisticsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis'**
  String get statisticsPageTitle;

  /// No description provided for @blockedCallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedCallsTitle;

  /// No description provided for @blockTypeAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Type Analysis'**
  String get blockTypeAnalysisTitle;

  /// No description provided for @weeklyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Blocked Calls'**
  String get weeklyChartTitle;

  /// No description provided for @monthlyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Blocked Calls'**
  String get monthlyChartTitle;

  /// No description provided for @yearlyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Yearly Blocked Calls'**
  String get yearlyChartTitle;

  /// No description provided for @callerIdCustomizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Customize Caller ID'**
  String get callerIdCustomizationTitle;

  /// No description provided for @windowSizeSetting.
  ///
  /// In en, this message translates to:
  /// **'Window Size'**
  String get windowSizeSetting;

  /// No description provided for @backgroundGradientSetting.
  ///
  /// In en, this message translates to:
  /// **'Background Gradient'**
  String get backgroundGradientSetting;

  /// No description provided for @textColorsSetting.
  ///
  /// In en, this message translates to:
  /// **'Text & Label Colors'**
  String get textColorsSetting;

  /// No description provided for @fontSizesSetting.
  ///
  /// In en, this message translates to:
  /// **'Font Sizes'**
  String get fontSizesSetting;

  /// No description provided for @avatarIconSizesSetting.
  ///
  /// In en, this message translates to:
  /// **'Avatar & Icon Sizes'**
  String get avatarIconSizesSetting;

  /// No description provided for @elementPositionsSetting.
  ///
  /// In en, this message translates to:
  /// **'Element Positions'**
  String get elementPositionsSetting;

  /// No description provided for @periodWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @loadRulesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load rules: {error}'**
  String loadRulesFailed(Object error);

  /// No description provided for @enhancedFilterSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter Settings'**
  String get enhancedFilterSettingsTitle;

  /// No description provided for @globalFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure global filters for all SIM cards:'**
  String get globalFilterDescription;

  /// No description provided for @localCounterFilter.
  ///
  /// In en, this message translates to:
  /// **'Local Counter Filter'**
  String get localCounterFilter;

  /// No description provided for @localCounterFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically filter spam calls based on call frequency'**
  String get localCounterFilterSubtitle;

  /// No description provided for @remoteNumberFilter.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filter'**
  String get remoteNumberFilter;

  /// No description provided for @remoteNumberFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Identify spam calls using cloud database and community reports'**
  String get remoteNumberFilterSubtitle;

  /// No description provided for @basicRuleFilter.
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filter'**
  String get basicRuleFilter;

  /// No description provided for @basicRuleFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Filter calls using blacklist/whitelist and regular expressions'**
  String get basicRuleFilterSubtitle;

  /// No description provided for @simSlotFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure independent filtering rules for each SIM card:'**
  String get simSlotFilterDescription;

  /// No description provided for @enhancedFilterInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter System'**
  String get enhancedFilterInstructionsTitle;

  /// No description provided for @enhancedFilterSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'The enhanced filter system supports both global rules and per-SIM card filtering configurations.'**
  String get enhancedFilterSystemDescription;

  /// No description provided for @systemFeatures.
  ///
  /// In en, this message translates to:
  /// **'System Features:'**
  String get systemFeatures;

  /// No description provided for @globalFilterFeature.
  ///
  /// In en, this message translates to:
  /// **'• Global Filters: Basic rules for all incoming calls'**
  String get globalFilterFeature;

  /// No description provided for @simSlotRuleFeature.
  ///
  /// In en, this message translates to:
  /// **'• SIM Slot Rules: Independent filtering strategies per SIM'**
  String get simSlotRuleFeature;

  /// No description provided for @flexibleCombinationFeature.
  ///
  /// In en, this message translates to:
  /// **'• Flexible Combinations: Enable/disable filters per SIM slot'**
  String get flexibleCombinationFeature;

  /// No description provided for @configurationAdvice.
  ///
  /// In en, this message translates to:
  /// **'Through proper configuration, you can set different filtering strategies for work and personal SIM cards.'**
  String get configurationAdvice;

  /// No description provided for @simSlotRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules'**
  String get simSlotRuleManagement;

  /// No description provided for @simSlotTitle.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot {slotNumber}'**
  String simSlotTitle(Object slotNumber);

  /// No description provided for @ruleDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted successfully'**
  String get ruleDeletedSuccess;

  /// Rule creation success message
  ///
  /// In en, this message translates to:
  /// **'Rule added successfully'**
  String get ruleAddedSuccess;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneNumberHint;

  /// No description provided for @ruleNameHint.
  ///
  /// In en, this message translates to:
  /// **'Rule name (optional)'**
  String get ruleNameHint;

  /// No description provided for @addRuleButton.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRuleButton;

  /// No description provided for @simSlotRuleManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Rule Management'**
  String get simSlotRuleManagementTitle;

  /// Global filter settings section title
  ///
  /// In en, this message translates to:
  /// **'Global Filter Settings'**
  String get globalFilterSettings;

  /// No description provided for @enableNoneActionRules.
  ///
  /// In en, this message translates to:
  /// **'Enable None Action Rules'**
  String get enableNoneActionRules;

  /// No description provided for @enableNoneActionRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow rule configurations with no interception actions'**
  String get enableNoneActionRulesDesc;

  /// No description provided for @allowAllBlacklistedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow All Blacklisted Numbers'**
  String get allowAllBlacklistedNumbers;

  /// Allow calls from blocklist
  ///
  /// In en, this message translates to:
  /// **'Allow calls from blocklist'**
  String get allowAllBlacklistedNumbersDesc;

  /// Title for SIM slot filter settings
  ///
  /// In en, this message translates to:
  /// **'SIM Slot {slotNumber} Filter Settings'**
  String simSlotFilterSettingsTitle(Object slotNumber);

  /// No description provided for @filterToggleInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable filters for this SIM slot:'**
  String get filterToggleInstructions;

  /// Section title for SIM slot rules instructions
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules'**
  String get simRuleInstructionsTitle;

  /// No description provided for @simRuleInstructions.
  ///
  /// In en, this message translates to:
  /// **'SIM slot rules allow you to configure independent filtering rules for each SIM slot.'**
  String get simRuleInstructions;

  /// Title for features list section
  ///
  /// In en, this message translates to:
  /// **'Features:'**
  String get featureListTitle;

  /// No description provided for @featureEnableDisable.
  ///
  /// In en, this message translates to:
  /// **'• Enable/disable different filters per SIM'**
  String get featureEnableDisable;

  /// No description provided for @featureAddRules.
  ///
  /// In en, this message translates to:
  /// **'• Add phone number specific rules'**
  String get featureAddRules;

  /// No description provided for @featureManageRules.
  ///
  /// In en, this message translates to:
  /// **'• Manage rule lists per SIM'**
  String get featureManageRules;

  /// No description provided for @dualSimAdvice.
  ///
  /// In en, this message translates to:
  /// **'This feature is particularly useful for dual-SIM phones to set different filtering strategies for work and personal SIM cards.'**
  String get dualSimAdvice;

  /// No description provided for @simSlotRuleListTitle.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules List'**
  String get simSlotRuleListTitle;

  /// No description provided for @noRulesPrompt.
  ///
  /// In en, this message translates to:
  /// **'No rules found, please add rules'**
  String get noRulesPrompt;

  /// No description provided for @loadingTags.
  ///
  /// In en, this message translates to:
  /// **'Loading tags...'**
  String get loadingTags;

  /// No description provided for @tagLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag: {tag}'**
  String tagLabel(String tag);

  /// No description provided for @unknownTag.
  ///
  /// In en, this message translates to:
  /// **'Tag: Unknown'**
  String get unknownTag;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number *'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to add rule'**
  String get phoneNumberHintText;

  /// No description provided for @contactNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactNameLabel;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name (optional)'**
  String get contactNameHint;

  /// No description provided for @addSimRuleButton.
  ///
  /// In en, this message translates to:
  /// **'Add SIM Rule'**
  String get addSimRuleButton;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @settingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @serviceTypePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Subscription'**
  String get serviceTypePhone;

  /// No description provided for @serviceTypeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS Subscription'**
  String get serviceTypeSms;

  /// No description provided for @serviceTypeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Subscription'**
  String get serviceTypeContact;

  /// No description provided for @serviceTypePlugin.
  ///
  /// In en, this message translates to:
  /// **'Plugin Update'**
  String get serviceTypePlugin;

  /// No description provided for @autoUpdateSettings.
  ///
  /// In en, this message translates to:
  /// **'Auto Update Settings'**
  String get autoUpdateSettings;

  /// No description provided for @updateAllNow.
  ///
  /// In en, this message translates to:
  /// **'Update All Now'**
  String get updateAllNow;

  /// No description provided for @updateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get updateInterval;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @autoUpdateDescription.
  ///
  /// In en, this message translates to:
  /// **'Set auto-update intervals for subscriptions or update manually'**
  String get autoUpdateDescription;

  /// Update interval confirmation message
  ///
  /// In en, this message translates to:
  /// **'{service} update interval set to {days} days'**
  String intervalSetSuccess(Object service, Object days);

  /// Single service update success message
  ///
  /// In en, this message translates to:
  /// **'{service} updated successfully ({count} rules)'**
  String updateSuccess(Object service, Object count);

  /// Full update success message
  ///
  /// In en, this message translates to:
  /// **'All updates completed ({count} rules)'**
  String allUpdateSuccess(Object count);

  /// Service update failure message
  ///
  /// In en, this message translates to:
  /// **'{error}'**
  String serviceUpdateFailure(Object error);

  /// No description provided for @simCard.
  ///
  /// In en, this message translates to:
  /// **'SIM Card {simNumber}'**
  String simCard(Object simNumber);

  /// SIM slot rule management section title
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rule Management'**
  String get simRuleManagement;

  /// SIM slot operation failure message
  ///
  /// In en, this message translates to:
  /// **'SIM slot operation failed: {error}'**
  String simSlotOperationFailed(Object error);

  /// No description provided for @simSlotLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SIM slots: {error}'**
  String simSlotLoadFailed(Object error);

  /// No description provided for @simSlotDataLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SIM data: {error}'**
  String simSlotDataLoadFailed(Object error);

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @contactNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Contact name (optional)'**
  String get contactNameOptional;

  /// No description provided for @ruleAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get ruleAddButton;

  /// No description provided for @rejectAllNumbers.
  ///
  /// In en, this message translates to:
  /// **'Reject All Numbers'**
  String get rejectAllNumbers;

  /// No description provided for @rejectAllNumbersDesc.
  ///
  /// In en, this message translates to:
  /// **'Reject all incoming calls when enabled'**
  String get rejectAllNumbersDesc;

  /// No description provided for @allowAllowedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Allowed Numbers'**
  String get allowAllowedNumbers;

  /// No description provided for @allowAllowedNumbersDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow calls from allowlist'**
  String get allowAllowedNumbersDesc;

  /// No description provided for @allowBlockedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Blocked Numbers'**
  String get allowBlockedNumbers;

  /// No description provided for @allowBlockedNumbersDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow calls from blocklist'**
  String get allowBlockedNumbersDesc;

  /// No description provided for @allowRegexAllowRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Regex Allow Rules'**
  String get allowRegexAllowRules;

  /// No description provided for @allowRegexAllowRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable regex pattern matching for allow rules'**
  String get allowRegexAllowRulesDesc;

  /// No description provided for @allowAllWhitelistedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Whitelisted Numbers'**
  String get allowAllWhitelistedNumbers;

  /// No description provided for @allowAllWhitelistedNumbersDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow calls from whitelist'**
  String get allowAllWhitelistedNumbersDesc;

  /// No description provided for @allowRegexBlockRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Regex Block Rules'**
  String get allowRegexBlockRules;

  /// No description provided for @allowRegexBlockRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable regex pattern matching for block rules'**
  String get allowRegexBlockRulesDesc;

  /// No description provided for @enableMuteRules.
  ///
  /// In en, this message translates to:
  /// **'Enable Mute Rules'**
  String get enableMuteRules;

  /// No description provided for @enableMuteRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Apply mute interception rules configuration'**
  String get enableMuteRulesDesc;

  /// General update failure message
  ///
  /// In en, this message translates to:
  /// **'Update failed: {error}'**
  String generalUpdateFailure(Object error);

  /// Day count display
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String days(num count);

  /// No description provided for @unassignedSIMCard.
  ///
  /// In en, this message translates to:
  /// **'Unnamed SIM Card'**
  String get unassignedSIMCard;

  /// Data loading failure message
  ///
  /// In en, this message translates to:
  /// **'Data load failed: {error}'**
  String dataLoadFailure(Object error);

  /// Filter enable/disable status change notification
  ///
  /// In en, this message translates to:
  /// **'{status} filter: {filterName}'**
  String filterToggleStatus(Object status, Object filterName);

  /// Enabled status text
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Disabled status text
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// Rule creation failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to add rule: {error}'**
  String ruleAddFailure(Object error);

  /// Rule deletion failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete rule: {error}'**
  String ruleDeleteFailure(Object error);

  /// SIM slot position display
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Position {slotNumber}'**
  String simSlotPosition(int slotNumber);

  /// No description provided for @addLabelToCall.
  ///
  /// In en, this message translates to:
  /// **'Add Label to Call Record'**
  String get addLabelToCall;

  /// No description provided for @currentLabels.
  ///
  /// In en, this message translates to:
  /// **'Current Labels:'**
  String get currentLabels;

  /// No description provided for @expandLabelSelector.
  ///
  /// In en, this message translates to:
  /// **'Expand Label Selector'**
  String get expandLabelSelector;

  /// No description provided for @collapseLabelSelector.
  ///
  /// In en, this message translates to:
  /// **'Collapse Label Selector'**
  String get collapseLabelSelector;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @labelRemoved.
  ///
  /// In en, this message translates to:
  /// **'Label removed'**
  String get labelRemoved;

  /// Label removal failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to remove label: {error}'**
  String labelRemoveFailed(Object error);

  /// No description provided for @labelUpdated.
  ///
  /// In en, this message translates to:
  /// **'Label updated'**
  String get labelUpdated;

  /// Label update failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to update label: {error}'**
  String labelUpdateFailed(Object error);

  /// No description provided for @addLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Label'**
  String get addLabel;

  /// No description provided for @callback.
  ///
  /// In en, this message translates to:
  /// **'Call Back'**
  String get callback;

  /// Callback notification message
  ///
  /// In en, this message translates to:
  /// **'Call back to {number}'**
  String callbackTo(String number);

  /// No description provided for @chartToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chartToday;

  /// No description provided for @chartOneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get chartOneDayAgo;

  /// No description provided for @chartThreeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get chartThreeDaysAgo;

  /// No description provided for @chartOneWeekAgo.
  ///
  /// In en, this message translates to:
  /// **'1 week ago'**
  String get chartOneWeekAgo;

  /// No description provided for @chartTenDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'10 days ago'**
  String get chartTenDaysAgo;

  /// No description provided for @chartOneMonthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get chartOneMonthAgo;

  /// Month format for chart labels
  ///
  /// In en, this message translates to:
  /// **'Month {month}'**
  String chartMonthFormat(int month);

  /// No description provided for @defaultPeriod.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get defaultPeriod;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
