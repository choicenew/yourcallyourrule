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

  /// No description provided for @filterControlPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Control Panel'**
  String get filterControlPanelTitle;

  /// No description provided for @configureSimCardFilterRules.
  ///
  /// In en, this message translates to:
  /// **'Configure SIM Card Filter Rules'**
  String get configureSimCardFilterRules;

  /// No description provided for @selectSimCard.
  ///
  /// In en, this message translates to:
  /// **'Select SIM Card'**
  String get selectSimCard;

  /// Title for global settings page
  ///
  /// In en, this message translates to:
  /// **'Global Settings'**
  String get globalSettings;

  /// No description provided for @unassignedSIMCard.
  ///
  /// In en, this message translates to:
  /// **'Unnamed SIM Card'**
  String get unassignedSIMCard;

  /// No description provided for @basicRuleFiltering.
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filtering'**
  String get basicRuleFiltering;

  /// No description provided for @rejectAllCalls.
  ///
  /// In en, this message translates to:
  /// **'Reject All Calls'**
  String get rejectAllCalls;

  /// No description provided for @rejectAllCallsDescription.
  ///
  /// In en, this message translates to:
  /// **'When enabled, all calls will be rejected with highest priority'**
  String get rejectAllCallsDescription;

  /// No description provided for @allowWhitelistedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Whitelisted Numbers'**
  String get allowWhitelistedNumbers;

  /// No description provided for @allowWhitelistedNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow all numbers in the whitelist'**
  String get allowWhitelistedNumbersDescription;

  /// No description provided for @allowRegexAllowRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Regex Allow Rules'**
  String get allowRegexAllowRules;

  /// No description provided for @allowRegexAllowRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable regex-based allow rules'**
  String get allowRegexAllowRulesDescription;

  /// No description provided for @allowRegexBlockRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Regex Block Rules'**
  String get allowRegexBlockRules;

  /// No description provided for @allowRegexBlockRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable regex-based block rules'**
  String get allowRegexBlockRulesDescription;

  /// No description provided for @localCountFiltering.
  ///
  /// In en, this message translates to:
  /// **'Local Count Filtering'**
  String get localCountFiltering;

  /// No description provided for @enableLocalCountFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable Local Count Filter'**
  String get enableLocalCountFilter;

  /// No description provided for @enableLocalCountFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically filter spam calls based on local marking count'**
  String get enableLocalCountFilterDescription;

  /// No description provided for @rejectExceededNumbers.
  ///
  /// In en, this message translates to:
  /// **'Reject Exceeded Numbers'**
  String get rejectExceededNumbers;

  /// No description provided for @rejectExceededNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically reject all numbers exceeding the count threshold'**
  String get rejectExceededNumbersDescription;

  /// No description provided for @allowNonExceededNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Non-Exceeded Numbers'**
  String get allowNonExceededNumbers;

  /// No description provided for @allowNonExceededNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically allow all numbers not exceeding the count threshold'**
  String get allowNonExceededNumbersDescription;

  /// No description provided for @remoteNumberFiltering.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filtering'**
  String get remoteNumberFiltering;

  /// No description provided for @enableRemoteNumberFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable Remote Number Filter'**
  String get enableRemoteNumberFilter;

  /// No description provided for @enableRemoteNumberFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically filter spam calls based on remote database information'**
  String get enableRemoteNumberFilterDescription;

  /// No description provided for @prioritizeRemoteAction.
  ///
  /// In en, this message translates to:
  /// **'Prioritize Remote Action'**
  String get prioritizeRemoteAction;

  /// No description provided for @prioritizeRemoteActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Prioritize action settings from the remote database'**
  String get prioritizeRemoteActionDescription;

  /// No description provided for @timeInterceptor.
  ///
  /// In en, this message translates to:
  /// **'Time Interceptor'**
  String get timeInterceptor;

  /// No description provided for @enableTimeInterception.
  ///
  /// In en, this message translates to:
  /// **'Enable Time Interception'**
  String get enableTimeInterception;

  /// No description provided for @enableTimeInterceptionDescription.
  ///
  /// In en, this message translates to:
  /// **'Intercept repeated calls within a short time'**
  String get enableTimeInterceptionDescription;

  /// No description provided for @interceptionTimeInterval.
  ///
  /// In en, this message translates to:
  /// **'Interception Time Interval'**
  String get interceptionTimeInterval;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @filterExplanation.
  ///
  /// In en, this message translates to:
  /// **'Filter Explanation'**
  String get filterExplanation;

  /// No description provided for @basicRuleFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Basic Rule Filtering: Filtering rules based on blacklist, whitelist, and regex'**
  String get basicRuleFilteringExplanation;

  /// No description provided for @localCountFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Local Count Filtering: Filtering rules based on local marking count'**
  String get localCountFilteringExplanation;

  /// No description provided for @remoteNumberFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Remote Number Filtering: Filtering rules based on remote database information'**
  String get remoteNumberFilteringExplanation;

  /// No description provided for @timeInterceptorExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Time Interceptor: Intercept repeated calls within a short time'**
  String get timeInterceptorExplanation;

  /// No description provided for @simCardConfigurationExplanation.
  ///
  /// In en, this message translates to:
  /// **'• SIM Card Configuration: Set independent filtering rules for each SIM card'**
  String get simCardConfigurationExplanation;

  /// No description provided for @filterPriorityNote.
  ///
  /// In en, this message translates to:
  /// **'Note: There are priority relationships between filters, please refer to the help documentation for details'**
  String get filterPriorityNote;

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
  /// **'Failed to load SIM card information: {error}'**
  String simInfoLoadFailure(Object error);

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String operationFailed(Object error);

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import successful'**
  String get importSuccess;

  /// No description provided for @importFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to import configuration'**
  String get importFailure;

  /// No description provided for @exportSuccesslly.
  ///
  /// In en, this message translates to:
  /// **'Configuration exported successfully'**
  String get exportSuccesslly;

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

  /// No description provided for @regexErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Regex error: {error}'**
  String regexErrorMessage(Object error);

  /// No description provided for @addToRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Rules'**
  String get addToRules;

  /// No description provided for @addToAllowedRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Allowed Rules'**
  String get addToAllowedRules;

  /// No description provided for @addToBlockedRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Blocked Rules'**
  String get addToBlockedRules;

  /// No description provided for @addToWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Add to Whitelist'**
  String get addToWhitelist;

  /// No description provided for @addToBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Add to Blacklist'**
  String get addToBlacklist;

  /// No description provided for @addedToAllowedRules.
  ///
  /// In en, this message translates to:
  /// **'Added to Allowed Rules'**
  String get addedToAllowedRules;

  /// No description provided for @addedToBlockedRules.
  ///
  /// In en, this message translates to:
  /// **'Added to Blocked Rules'**
  String get addedToBlockedRules;

  /// No description provided for @addedToWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Added to Whitelist'**
  String get addedToWhitelist;

  /// No description provided for @addedToBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Added to Blacklist'**
  String get addedToBlacklist;

  /// No description provided for @addRuleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add rule'**
  String get addRuleFailed;

  /// No description provided for @enterBothPhoneNumberAndRegexPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern'**
  String get enterBothPhoneNumberAndRegexPatternMessage;

  /// No description provided for @enterRuleNameAndPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter rule name and pattern'**
  String get enterRuleNameAndPatternMessage;

  /// No description provided for @ruleSavedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSavedSuccessMessage;

  /// No description provided for @ruleSaveFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String ruleSaveFailedMessage(Object error);

  /// No description provided for @regexTesterTitle.
  ///
  /// In en, this message translates to:
  /// **'Regex Tester'**
  String get regexTesterTitle;

  /// No description provided for @enterPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to test'**
  String get enterPhoneNumberHint;

  /// No description provided for @enterRegexHint.
  ///
  /// In en, this message translates to:
  /// **'Enter regular expression'**
  String get enterRegexHint;

  /// No description provided for @enterRuleNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter name for this rule'**
  String get enterRuleNameHint;

  /// No description provided for @testButtonText.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get testButtonText;

  /// No description provided for @saveButtonText.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveButtonText;

  /// No description provided for @startColor.
  ///
  /// In en, this message translates to:
  /// **'Start Color'**
  String get startColor;

  /// No description provided for @endColor.
  ///
  /// In en, this message translates to:
  /// **'End Color'**
  String get endColor;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @labelIconColor.
  ///
  /// In en, this message translates to:
  /// **'Label Icon Color'**
  String get labelIconColor;

  /// No description provided for @locationIconColor.
  ///
  /// In en, this message translates to:
  /// **'Location Icon Color'**
  String get locationIconColor;

  /// No description provided for @callTypeIconColor.
  ///
  /// In en, this message translates to:
  /// **'Call Type Icon Color'**
  String get callTypeIconColor;

  /// No description provided for @avatarBorderColor.
  ///
  /// In en, this message translates to:
  /// **'Avatar Border Color'**
  String get avatarBorderColor;

  /// No description provided for @nameColor.
  ///
  /// In en, this message translates to:
  /// **'Name Color'**
  String get nameColor;

  /// No description provided for @numberColor.
  ///
  /// In en, this message translates to:
  /// **'Number Color'**
  String get numberColor;

  /// No description provided for @locationColor.
  ///
  /// In en, this message translates to:
  /// **'Location Color'**
  String get locationColor;

  /// No description provided for @carrierColor.
  ///
  /// In en, this message translates to:
  /// **'Carrier Color'**
  String get carrierColor;

  /// No description provided for @countryNameColor.
  ///
  /// In en, this message translates to:
  /// **'Country Name Color'**
  String get countryNameColor;

  /// No description provided for @labelsColor.
  ///
  /// In en, this message translates to:
  /// **'Labels Color'**
  String get labelsColor;

  /// No description provided for @countColor.
  ///
  /// In en, this message translates to:
  /// **'Count Color'**
  String get countColor;

  /// No description provided for @numberTypeColor.
  ///
  /// In en, this message translates to:
  /// **'Number Type Color'**
  String get numberTypeColor;

  /// No description provided for @stirColor.
  ///
  /// In en, this message translates to:
  /// **'STIR Color'**
  String get stirColor;

  /// No description provided for @simCardColor.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Color'**
  String get simCardColor;

  /// No description provided for @nameFontSize.
  ///
  /// In en, this message translates to:
  /// **'Name Font Size'**
  String get nameFontSize;

  /// No description provided for @carrierFontSize.
  ///
  /// In en, this message translates to:
  /// **'Carrier Font Size'**
  String get carrierFontSize;

  /// No description provided for @countryNameFontSize.
  ///
  /// In en, this message translates to:
  /// **'Country Name Font Size'**
  String get countryNameFontSize;

  /// No description provided for @labelsFontSize.
  ///
  /// In en, this message translates to:
  /// **'Labels Font Size'**
  String get labelsFontSize;

  /// No description provided for @countFontSize.
  ///
  /// In en, this message translates to:
  /// **'Count Font Size'**
  String get countFontSize;

  /// No description provided for @numberTypeFontSize.
  ///
  /// In en, this message translates to:
  /// **'Number Type Font Size'**
  String get numberTypeFontSize;

  /// No description provided for @numberFontSize.
  ///
  /// In en, this message translates to:
  /// **'Number Font Size'**
  String get numberFontSize;

  /// No description provided for @locationFontSize.
  ///
  /// In en, this message translates to:
  /// **'Location Font Size'**
  String get locationFontSize;

  /// No description provided for @stirFontSize.
  ///
  /// In en, this message translates to:
  /// **'STIR Font Size'**
  String get stirFontSize;

  /// No description provided for @simCardFontSize.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Font Size'**
  String get simCardFontSize;

  /// No description provided for @labelsPosition.
  ///
  /// In en, this message translates to:
  /// **'Labels Position'**
  String get labelsPosition;

  /// No description provided for @countPosition.
  ///
  /// In en, this message translates to:
  /// **'Count Position'**
  String get countPosition;

  /// No description provided for @subscriptionManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Management'**
  String get subscriptionManagementTitle;

  /// No description provided for @subscriptionEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions available'**
  String get subscriptionEmptyState;

  /// No description provided for @subscriptionLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String subscriptionLoadFailed(Object error);

  /// No description provided for @subscriptionToggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle subscription status: {error}'**
  String subscriptionToggleFailed(Object error);

  /// No description provided for @contactsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management'**
  String get contactsPageTitle;

  /// No description provided for @manageContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageContacts;

  /// No description provided for @favoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Favorite Contacts'**
  String get favoriteContacts;

  /// No description provided for @deleteContact.
  ///
  /// In en, this message translates to:
  /// **'Delete Contact'**
  String get deleteContact;

  /// No description provided for @deleteContactConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String deleteContactConfirm(Object name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Label'**
  String get selectLabel;

  /// No description provided for @labelUpdated.
  ///
  /// In en, this message translates to:
  /// **'Label updated'**
  String get labelUpdated;

  /// No description provided for @updateLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update label'**
  String get updateLabelFailed;

  /// No description provided for @batchDeleteContacts.
  ///
  /// In en, this message translates to:
  /// **'Batch Delete Contacts'**
  String get batchDeleteContacts;

  /// No description provided for @batchDeleteContactsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} selected contacts?'**
  String batchDeleteContactsConfirm(Object count);

  /// No description provided for @contactsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted {count} contacts'**
  String contactsDeleted(Object count);

  /// No description provided for @batchDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Batch delete failed'**
  String get batchDeleteFailed;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No description provided for @editLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit Label'**
  String get editLabel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search Contacts'**
  String get searchContacts;

  /// No description provided for @changeLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Label'**
  String get changeLabel;

  /// No description provided for @noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get noContacts;

  /// No description provided for @noMatchingContacts.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts'**
  String get noMatchingContacts;

  /// No description provided for @addContact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get addContact;

  /// No description provided for @importExportContacts.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Contacts'**
  String get importExportContacts;

  /// No description provided for @importContacts.
  ///
  /// In en, this message translates to:
  /// **'Import Contacts'**
  String get importContacts;

  /// No description provided for @exportContacts.
  ///
  /// In en, this message translates to:
  /// **'Export Contacts'**
  String get exportContacts;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(Object error);

  /// No description provided for @selectExportFormat.
  ///
  /// In en, this message translates to:
  /// **'Select Export Format'**
  String get selectExportFormat;

  /// No description provided for @csvFormat.
  ///
  /// In en, this message translates to:
  /// **'CSV Format'**
  String get csvFormat;

  /// No description provided for @jsonFormat.
  ///
  /// In en, this message translates to:
  /// **'JSON Format'**
  String get jsonFormat;

  /// No description provided for @fileSavedTo.
  ///
  /// In en, this message translates to:
  /// **'File saved to: {path}'**
  String fileSavedTo(Object path);

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get exportFailed;

  /// No description provided for @unsupportedFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file format'**
  String get unsupportedFileFormat;

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'{count} items selected'**
  String selectedItems(Object count);

  /// No description provided for @contactsLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts: {error}'**
  String contactsLoadingFailed(Object error);

  /// No description provided for @contactsManagementPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management Page'**
  String get contactsManagementPageTitle;

  /// No description provided for @loadContactsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts: {error}'**
  String loadContactsFailed(Object error);

  /// No description provided for @manageFrequentContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage Frequent Contacts'**
  String get manageFrequentContacts;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @addedToFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Added to favorite contacts'**
  String get addedToFavoriteContacts;

  /// No description provided for @removedFromFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorite contacts'**
  String get removedFromFavoriteContacts;

  /// No description provided for @updateFavoriteStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite status: {error}'**
  String updateFavoriteStatusFailed(Object error);

  /// No description provided for @contactDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted'**
  String get contactDeleted;

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed'**
  String get deleteFailed;

  /// No description provided for @searchForContacts.
  ///
  /// In en, this message translates to:
  /// **'Search for contacts'**
  String get searchForContacts;

  /// No description provided for @importExportContactsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Contacts'**
  String get importExportContactsTooltip;

  /// No description provided for @noContactsYet.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get noContactsYet;

  /// No description provided for @noMatchingContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts found'**
  String get noMatchingContactsFound;

  /// No description provided for @addContactButton.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get addContactButton;

  /// No description provided for @dataAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis'**
  String get dataAnalysis;

  /// No description provided for @loadDataFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get loadDataFailed;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @dataAnalysisDashboardPage.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis Dashboard Page'**
  String get dataAnalysisDashboardPage;

  /// No description provided for @monthlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get monthlyTotal;

  /// No description provided for @blockedCommunications.
  ///
  /// In en, this message translates to:
  /// **'Blocked Communications'**
  String get blockedCommunications;

  /// No description provided for @googleAdDisplayPosition.
  ///
  /// In en, this message translates to:
  /// **'Google Ad Display Position'**
  String get googleAdDisplayPosition;

  /// No description provided for @googleAdMobIntegrationText.
  ///
  /// In en, this message translates to:
  /// **'Google AdMob ads can be integrated here'**
  String get googleAdMobIntegrationText;

  /// No description provided for @ruleStatistics.
  ///
  /// In en, this message translates to:
  /// **'Rule Statistics'**
  String get ruleStatistics;

  /// No description provided for @loadRulesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load rules: {error}'**
  String loadRulesFailed(Object error);

  /// No description provided for @blockCalls.
  ///
  /// In en, this message translates to:
  /// **'Block Calls'**
  String get blockCalls;

  /// No description provided for @filterSMS.
  ///
  /// In en, this message translates to:
  /// **'Filter SMS'**
  String get filterSMS;

  /// No description provided for @allowRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Rules'**
  String get allowRules;

  /// No description provided for @blockRules.
  ///
  /// In en, this message translates to:
  /// **'Block Rules'**
  String get blockRules;

  /// No description provided for @silentRules.
  ///
  /// In en, this message translates to:
  /// **'Silent Rules'**
  String get silentRules;

  /// No description provided for @noActionRules.
  ///
  /// In en, this message translates to:
  /// **'No Action Rules'**
  String get noActionRules;

  /// No description provided for @blockingTrend.
  ///
  /// In en, this message translates to:
  /// **'Blocking Trend'**
  String get blockingTrend;

  /// No description provided for @dataExport.
  ///
  /// In en, this message translates to:
  /// **'Data Export'**
  String get dataExport;

  /// No description provided for @statisticsExportFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Statistics export feature coming soon'**
  String get statisticsExportFeatureComingSoon;

  /// No description provided for @exportStatisticsData.
  ///
  /// In en, this message translates to:
  /// **'Export Statistics Data'**
  String get exportStatisticsData;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @contactSubscriptionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Subscriptions'**
  String get contactSubscriptionPageTitle;

  /// No description provided for @contactSubscriptionLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contact subscriptions: {error}'**
  String contactSubscriptionLoadingFailed(Object error);

  /// No description provided for @subscriptionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Management'**
  String get subscriptionPageTitle;

  /// No description provided for @subscriptionEmptyText.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet'**
  String get subscriptionEmptyText;

  /// No description provided for @subscriptionLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String subscriptionLoadingFailed(Object error);

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @callHistoryTab.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryTab;

  /// No description provided for @contactsTab.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTab;

  /// No description provided for @dashboardTab.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @numberTypePosition.
  ///
  /// In en, this message translates to:
  /// **'Number Type Position'**
  String get numberTypePosition;

  /// No description provided for @numberPosition.
  ///
  /// In en, this message translates to:
  /// **'Number Position'**
  String get numberPosition;

  /// No description provided for @locationPosition.
  ///
  /// In en, this message translates to:
  /// **'Location Position'**
  String get locationPosition;

  /// No description provided for @stirPosition.
  ///
  /// In en, this message translates to:
  /// **'STIR Position'**
  String get stirPosition;

  /// No description provided for @simCardPosition.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Position'**
  String get simCardPosition;

  /// No description provided for @callTypePosition.
  ///
  /// In en, this message translates to:
  /// **'Call Type Position'**
  String get callTypePosition;

  /// No description provided for @avatarSize.
  ///
  /// In en, this message translates to:
  /// **'Avatar Size'**
  String get avatarSize;

  /// No description provided for @avatarBorderSize.
  ///
  /// In en, this message translates to:
  /// **'Avatar Border Size'**
  String get avatarBorderSize;

  /// No description provided for @iconSize.
  ///
  /// In en, this message translates to:
  /// **'Icon Size'**
  String get iconSize;

  /// No description provided for @avatarPosition.
  ///
  /// In en, this message translates to:
  /// **'Avatar Position'**
  String get avatarPosition;

  /// No description provided for @namePosition.
  ///
  /// In en, this message translates to:
  /// **'Name Position'**
  String get namePosition;

  /// No description provided for @carrierPosition.
  ///
  /// In en, this message translates to:
  /// **'Carrier Position'**
  String get carrierPosition;

  /// No description provided for @countryRegionNamePosition.
  ///
  /// In en, this message translates to:
  /// **'Country/Region Name Position'**
  String get countryRegionNamePosition;

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

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @callerIdApp.
  ///
  /// In en, this message translates to:
  /// **'Caller ID App'**
  String get callerIdApp;

  /// No description provided for @thisAppIsAPowerfulCallerIdToolThatAllows.
  ///
  /// In en, this message translates to:
  /// **'This app is a powerful caller ID tool that allows you to identify and block unwanted calls.'**
  String get thisAppIsAPowerfulCallerIdToolThatAllows;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @onlineCallerIdSubscription.
  ///
  /// In en, this message translates to:
  /// **'Online Caller ID Subscription'**
  String get onlineCallerIdSubscription;

  /// No description provided for @wildcardSupportForFlexibleFiltering.
  ///
  /// In en, this message translates to:
  /// **'Wildcard Support for Flexible Filtering'**
  String get wildcardSupportForFlexibleFiltering;

  /// No description provided for @blacklistingAndWhitelisting.
  ///
  /// In en, this message translates to:
  /// **'Blacklisting and Whitelisting'**
  String get blacklistingAndWhitelisting;

  /// No description provided for @joinTheTelegramChannelAndGroupForMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'Join the Telegram Channel and Group for More Info'**
  String get joinTheTelegramChannelAndGroupForMoreInfo;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @failure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get failure;

  /// No description provided for @phoneRuleSubscription.
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Subscription'**
  String get phoneRuleSubscription;

  /// No description provided for @aboutPhoneSubscriptionRules.
  ///
  /// In en, this message translates to:
  /// **'About Phone Subscription Rules'**
  String get aboutPhoneSubscriptionRules;

  /// No description provided for @phoneSubscriptionRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to phone rule lists via URL to automatically update whitelist and blacklist rules. Supports JSON format rule files.'**
  String get phoneSubscriptionRulesDescription;

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

  /// No description provided for @contactsManagement.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management'**
  String get contactsManagement;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage Contacts'**
  String get manage;

  /// No description provided for @testButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get testButtonLabel;

  /// No description provided for @saveButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveButtonLabel;

  /// No description provided for @matchSuccessfulMessage.
  ///
  /// In en, this message translates to:
  /// **'Match successful!'**
  String get matchSuccessfulMessage;

  /// No description provided for @matchFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Match Failed!'**
  String get matchFailedMessage;

  /// No description provided for @ruleSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSaveSuccess;

  /// No description provided for @ruleSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String ruleSaveFailed(Object error);

  /// No description provided for @ruleNamePatternRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter rule name and pattern'**
  String get ruleNamePatternRequired;

  /// No description provided for @phoneNumberRegexRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern'**
  String get phoneNumberRegexRequired;

  /// No description provided for @callFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'Call Filter Settings'**
  String get callFilterSettings;

  /// No description provided for @fraudScamLikely.
  ///
  /// In en, this message translates to:
  /// **'Fraud/Scam Likely'**
  String get fraudScamLikely;

  /// No description provided for @spamLikely.
  ///
  /// In en, this message translates to:
  /// **'Spam Likely'**
  String get spamLikely;

  /// No description provided for @telemarketing.
  ///
  /// In en, this message translates to:
  /// **'Telemarketing'**
  String get telemarketing;

  /// No description provided for @robocall.
  ///
  /// In en, this message translates to:
  /// **'Robocall'**
  String get robocall;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @takeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get takeaway;

  /// No description provided for @ridesharing.
  ///
  /// In en, this message translates to:
  /// **'Ridesharing'**
  String get ridesharing;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// No description provided for @customerService.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get customerService;

  /// No description provided for @financial.
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get financial;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @medical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get medical;

  /// No description provided for @charity.
  ///
  /// In en, this message translates to:
  /// **'Charity'**
  String get charity;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Debt Collection'**
  String get collection;

  /// No description provided for @survey.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get survey;

  /// No description provided for @political.
  ///
  /// In en, this message translates to:
  /// **'Political'**
  String get political;

  /// No description provided for @ecommerce.
  ///
  /// In en, this message translates to:
  /// **'E-commerce'**
  String get ecommerce;

  /// No description provided for @risk.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get risk;

  /// No description provided for @confirmDeleteContactName.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete?'**
  String get confirmDeleteContactName;

  /// No description provided for @updateFavoriteStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Favorite Status'**
  String get updateFavoriteStatus;

  /// No description provided for @bulkDelete.
  ///
  /// In en, this message translates to:
  /// **'Batch Delete Contacts'**
  String get bulkDelete;

  /// No description provided for @tagsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Tags updated'**
  String get tagsUpdated;

  /// No description provided for @updateTags.
  ///
  /// In en, this message translates to:
  /// **'Update Tags'**
  String get updateTags;

  /// No description provided for @selectTags.
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get selectTags;

  /// No description provided for @bulkDeleteContacts.
  ///
  /// In en, this message translates to:
  /// **'Batch Delete Contacts'**
  String get bulkDeleteContacts;

  /// No description provided for @confirmDeleteSelectedContacts.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete selected contacts?'**
  String get confirmDeleteSelectedContacts;

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

  /// No description provided for @allowAllBlockRules.
  ///
  /// In en, this message translates to:
  /// **'Allow All Block Rules'**
  String get allowAllBlockRules;

  /// No description provided for @allowAllBlockRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow calls from block rules'**
  String get allowAllBlockRulesDesc;

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

  /// No description provided for @regexPatternLabel.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern'**
  String get regexPatternLabel;

  /// No description provided for @ruleNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Rule Name'**
  String get ruleNameLabel;

  /// No description provided for @testButton.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get testButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveButton;

  /// No description provided for @matchSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Match successful!'**
  String get matchSuccessful;

  /// No description provided for @matchFailed.
  ///
  /// In en, this message translates to:
  /// **'Match failed!'**
  String get matchFailed;

  /// No description provided for @regexError.
  ///
  /// In en, this message translates to:
  /// **'Regex error: {error}'**
  String regexError(Object error);

  /// No description provided for @enterBothPhoneNumberAndRegexPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern'**
  String get enterBothPhoneNumberAndRegexPattern;

  /// No description provided for @enterRuleNameAndPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter rule name and pattern'**
  String get enterRuleNameAndPattern;

  /// No description provided for @ruleSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSavedSuccessfully;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String saveFailed(Object error);

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

  /// Settings saved confirmation message
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

  /// Display text for unknown status
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Caller ID name label
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String nameLabel(Object name);

  /// Mark count display
  ///
  /// In en, this message translates to:
  /// **'Marked by {count}'**
  String callerIdMarkedByCount(Object count);

  /// SIM卡信息显示
  ///
  /// In en, this message translates to:
  /// **'SIM {slotNumber} - {countryIso}'**
  String simInfo(Object slotNumber, Object countryIso);

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

  /// No description provided for @allowRegexAllowRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable regex pattern matching for allow rules'**
  String get allowRegexAllowRulesDesc;

  /// No description provided for @allowAllAllowRules.
  ///
  /// In en, this message translates to:
  /// **'Allow All Allow Rules'**
  String get allowAllAllowRules;

  /// No description provided for @allowAllAllowRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow calls from allow rules'**
  String get allowAllAllowRulesDesc;

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

  /// No description provided for @addName.
  ///
  /// In en, this message translates to:
  /// **'Add Name'**
  String get addName;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name'**
  String get enterName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

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

  /// Selected date range text
  ///
  /// In en, this message translates to:
  /// **'Selected date range'**
  String get selectedDateRange;

  /// Notification settings title
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// Daily statistics notification option
  ///
  /// In en, this message translates to:
  /// **'Daily Statistics'**
  String get dailyStatistics;

  /// Description for daily statistics option
  ///
  /// In en, this message translates to:
  /// **'Receive daily statistics about blocked calls and messages'**
  String get dailyStatisticsDesc;

  /// Weekly report notification option
  ///
  /// In en, this message translates to:
  /// **'Weekly Report'**
  String get weeklyReport;

  /// Description for weekly report option
  ///
  /// In en, this message translates to:
  /// **'Receive weekly summary report of call blocking activity'**
  String get weeklyReportDesc;

  /// Phone subscription page title
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Subscriptions'**
  String get phoneSubscriptionTitle;

  /// Failed to load subscriptions error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String loadSubscriptionsFailed(Object error);

  /// Failed to change subscription status error message
  ///
  /// In en, this message translates to:
  /// **'Failed to change subscription status: {error}'**
  String changeSubscriptionStatusFailed(Object error);

  /// Failed to update subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to update subscription: {error}'**
  String updateSubscriptionFailed(Object error);

  /// Delete subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Subscription'**
  String get deleteSubscription;

  /// Delete subscription confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete subscription \"{name}\"?'**
  String deleteSubscriptionConfirm(Object name);

  /// Subscription deleted success message
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted'**
  String get subscriptionDeleted;

  /// Failed to delete subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete subscription: {error}'**
  String deleteSubscriptionFailed(Object error);

  /// Add allow subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Allow Subscription'**
  String get addAllowSubscription;

  /// Add block subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Block Subscription'**
  String get addBlockSubscription;

  /// Add silence subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Silence Subscription'**
  String get addSilenceSubscription;

  /// Add none subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add None Subscription'**
  String get addNoneSubscription;

  /// Subscription name field label
  ///
  /// In en, this message translates to:
  /// **'Subscription Name'**
  String get subscriptionName;

  /// Subscription name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter subscription name'**
  String get enterSubscriptionName;

  /// Subscription URL field label
  ///
  /// In en, this message translates to:
  /// **'Subscription URL'**
  String get subscriptionUrl;

  /// Subscription URL field hint
  ///
  /// In en, this message translates to:
  /// **'Enter subscription URL'**
  String get enterSubscriptionUrl;

  /// Enter valid name and URL error message
  ///
  /// In en, this message translates to:
  /// **'Please enter valid name and URL'**
  String get enterValidNameAndUrl;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Subscription added success message
  ///
  /// In en, this message translates to:
  /// **'Subscription \"{name}\" added successfully'**
  String subscriptionAddSuccess(Object name);

  /// Failed to add subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to add subscription: {error}'**
  String addSubscriptionFailed(Object error);

  /// No subscriptions message
  ///
  /// In en, this message translates to:
  /// **'No subscriptions'**
  String get noSubscriptions;

  /// Add subscription button text
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscription;

  /// About phone subscriptions title
  ///
  /// In en, this message translates to:
  /// **'About Phone Subscriptions'**
  String get aboutPhoneSubscriptions;

  /// About phone subscriptions description
  ///
  /// In en, this message translates to:
  /// **'Subscribe to phone rule lists via URL, automatically update blacklist and whitelist rules. Supports JSON format rule files.'**
  String get aboutPhoneSubscriptionsDesc;

  /// About contact subscription title
  ///
  /// In en, this message translates to:
  /// **'About Contact Subscription'**
  String get aboutContactSubscription;

  /// About contact subscription description
  ///
  /// In en, this message translates to:
  /// **'Subscribe to contact lists via URL, automatically update contact information and labels. Supports JSON format data.'**
  String get contactSubscriptionDescription;

  /// Whitelist label
  ///
  /// In en, this message translates to:
  /// **'Whitelist'**
  String get whitelist;

  /// Blacklist label
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// Synchronized status label
  ///
  /// In en, this message translates to:
  /// **'Synchronized'**
  String get synchronized;

  /// Last updated label
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String lastUpdated(Object date);

  /// Sync now button text
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

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

  /// No description provided for @allCallsTab.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCallsTab;

  /// No description provided for @phoneCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneCallsTab;

  /// No description provided for @smsTab.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get smsTab;

  /// No description provided for @weeklyBlockedCallsSummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Blocked Calls Summary'**
  String get weeklyBlockedCallsSummary;

  /// No description provided for @monthlyTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get monthlyTotalLabel;

  /// No description provided for @blockedPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedPhoneLabel;

  /// No description provided for @filteredSmsLabel.
  ///
  /// In en, this message translates to:
  /// **'Filtered SMS'**
  String get filteredSmsLabel;

  /// No description provided for @whitelistLabel.
  ///
  /// In en, this message translates to:
  /// **'Whitelist'**
  String get whitelistLabel;

  /// No description provided for @blacklistLabel.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklistLabel;

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

  /// Title for SIM slot selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select SIM Slot'**
  String get selectSimSlot;

  /// Title for basic rule filter settings page
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filter Settings'**
  String get basicRuleFilterSettings;

  /// Title for remote filter settings page
  ///
  /// In en, this message translates to:
  /// **'Remote Filter Settings'**
  String get remoteFilterSettings;

  /// Title for local filter settings page
  ///
  /// In en, this message translates to:
  /// **'Local Filter Settings'**
  String get localFilterSettings;

  /// Instructions for configuring global filter settings
  ///
  /// In en, this message translates to:
  /// **'Configure global filter settings that apply to all SIM slots:'**
  String get globalFilterToggleInstructions;

  /// Title for SIM slot settings page
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Settings'**
  String get simSlotSettings;

  /// Button text for updating call filter configuration
  ///
  /// In en, this message translates to:
  /// **'Update Call Filter Configuration'**
  String get updateCallFilterConfig;

  /// No description provided for @loadLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load labels: {error}'**
  String loadLabelFailed(Object error);

  /// No description provided for @addLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add labels: {error}'**
  String addLabelFailed(Object error);

  /// No description provided for @selectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected:'**
  String get selectedLabel;

  /// No description provided for @noLabels.
  ///
  /// In en, this message translates to:
  /// **'No Labels'**
  String get noLabels;

  /// No description provided for @addLabelButton.
  ///
  /// In en, this message translates to:
  /// **'Add Label'**
  String get addLabelButton;

  /// No description provided for @rulesImported.
  ///
  /// In en, this message translates to:
  /// **'Rules imported successfully'**
  String get rulesImported;

  /// No description provided for @rulesImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import rules: {error}'**
  String rulesImportFailed(Object error);

  /// No description provided for @importRules.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRules;

  /// No description provided for @importRulesInstructions.
  ///
  /// In en, this message translates to:
  /// **'Import rules from a CSV file'**
  String get importRulesInstructions;

  /// No description provided for @importRulesButton.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRulesButton;

  /// No description provided for @importRulesError.
  ///
  /// In en, this message translates to:
  /// **'Failed to import rules: {error}'**
  String importRulesError(Object error);

  /// No description provided for @importRulesSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rules imported successfully'**
  String get importRulesSuccess;

  /// No description provided for @ruleManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Rule Management'**
  String get ruleManagementTitle;

  /// No description provided for @ruleLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load rules: {error}'**
  String ruleLoadFailed(Object error);

  /// No description provided for @ruleToggleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule {status} successfully'**
  String ruleToggleSuccess(Object status);

  /// No description provided for @ruleToggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String ruleToggleFailed(Object error);

  /// No description provided for @ruleDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Rule'**
  String get ruleDeleteConfirmTitle;

  /// No description provided for @ruleDeleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this {ruleType}?'**
  String ruleDeleteConfirmContent(Object ruleType);

  /// No description provided for @ruleDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted successfully'**
  String get ruleDeleteSuccess;

  /// No description provided for @ruleDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String ruleDeleteFailed(Object error);

  /// No description provided for @actionFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by Action Type'**
  String get actionFilterTitle;

  /// No description provided for @actionFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Filter'**
  String get actionFilterAll;

  /// No description provided for @actionAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get actionAll;

  /// No description provided for @actionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get actionAllow;

  /// No description provided for @actionBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get actionBlock;

  /// No description provided for @actionSilence.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get actionSilence;

  /// No description provided for @actionNone.
  ///
  /// In en, this message translates to:
  /// **'No Action'**
  String get actionNone;

  /// No description provided for @actionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get actionUnknown;

  /// No description provided for @labelFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Label Filter'**
  String get labelFilterTooltip;

  /// No description provided for @actionFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Action Filter'**
  String get actionFilterTooltip;

  /// No description provided for @refreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshTooltip;

  /// No description provided for @exportRules.
  ///
  /// In en, this message translates to:
  /// **'Export Rules'**
  String get exportRules;

  /// No description provided for @addRuleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRuleTooltip;

  /// No description provided for @labelTag.
  ///
  /// In en, this message translates to:
  /// **'Label: {labelId}'**
  String labelTag(Object labelId);

  /// No description provided for @actionTag.
  ///
  /// In en, this message translates to:
  /// **'Action: {actionType}'**
  String actionTag(Object actionType);

  /// No description provided for @noMatchingRules.
  ///
  /// In en, this message translates to:
  /// **'No matching {ruleType}'**
  String noMatchingRules(Object ruleType);

  /// No description provided for @noRules.
  ///
  /// In en, this message translates to:
  /// **'No {ruleType} yet'**
  String noRules(Object ruleType);

  /// No description provided for @clearLabelFilterButton.
  ///
  /// In en, this message translates to:
  /// **'Clear Label Filter'**
  String get clearLabelFilterButton;

  /// No description provided for @subscriptionStatusChangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to change subscription status: {error}'**
  String subscriptionStatusChangeFailed(Object error);

  /// Subscription update success message
  ///
  /// In en, this message translates to:
  /// **'Subscription updated successfully'**
  String get subscriptionUpdateSuccess;

  /// No description provided for @subscriptionUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update subscription: {error}'**
  String subscriptionUpdateFailed(Object error);

  /// Synced status label
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @subscriptionDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Subscription'**
  String get subscriptionDeleteConfirmTitle;

  /// No description provided for @subscriptionDeleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this subscription?'**
  String get subscriptionDeleteConfirmContent;

  /// No description provided for @subscriptionDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted'**
  String get subscriptionDeleteSuccess;

  /// No description provided for @subscriptionDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete subscription: {error}'**
  String subscriptionDeleteFailed(Object error);

  /// No description provided for @addSubscriptionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscriptionTooltip;

  /// No description provided for @addSubscriptionButton.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscriptionButton;

  /// No description provided for @nameUnknown.
  ///
  /// In en, this message translates to:
  /// **'Name: Unknown'**
  String get nameUnknown;

  /// Text showing the name of a contact
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String nameWithValue(String name);

  /// Text showing how many users have marked this number
  ///
  /// In en, this message translates to:
  /// **'Marked by {count}'**
  String markedByCount(int count);

  /// No description provided for @verifiedText.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verifiedText;

  /// No description provided for @notVerifiedText.
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get notVerifiedText;

  /// No description provided for @verificationFailedText.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get verificationFailedText;

  /// Text showing SIM slot 1 with country ISO code
  ///
  /// In en, this message translates to:
  /// **'SIM 1,-{countryIso}'**
  String simSlot1(String countryIso);

  /// Text showing SIM slot 2 with country ISO code
  ///
  /// In en, this message translates to:
  /// **'SIM 2,-{countryIso}'**
  String simSlot2(String countryIso);

  /// No description provided for @failedToLoadContacts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts'**
  String get failedToLoadContacts;

  /// No description provided for @editContact.
  ///
  /// In en, this message translates to:
  /// **'Edit Contact'**
  String get editContact;

  /// No description provided for @contactUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact updated successfully'**
  String get contactUpdateSuccess;

  /// No description provided for @contactAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact added successfully'**
  String get contactAddSuccess;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterContactName.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact name'**
  String get enterContactName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (Optional)'**
  String get emailOptional;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get enterEmail;

  /// No description provided for @nameAndPhoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Name and phone number cannot be empty'**
  String get nameAndPhoneNumberRequired;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @failedToUpdateContact.
  ///
  /// In en, this message translates to:
  /// **'Failed to update contact'**
  String get failedToUpdateContact;

  /// No description provided for @failedToAddContact.
  ///
  /// In en, this message translates to:
  /// **'Failed to add contact'**
  String get failedToAddContact;

  /// No description provided for @manageFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage Favorite Contacts'**
  String get manageFavoriteContacts;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorite contacts'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorite contacts'**
  String get removedFromFavorites;

  /// No description provided for @confirmDeleteContact.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete'**
  String get confirmDeleteContact;

  /// No description provided for @selectTag.
  ///
  /// In en, this message translates to:
  /// **'Select Tag'**
  String get selectTag;

  /// No description provided for @confirmBatchDeleteContacts.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected'**
  String get confirmBatchDeleteContacts;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'contacts?'**
  String get contacts;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove Favorite'**
  String get removeFavorite;

  /// No description provided for @addFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add Favorite'**
  String get addFavorite;

  /// No description provided for @changeTag.
  ///
  /// In en, this message translates to:
  /// **'Change Tag'**
  String get changeTag;

  /// No description provided for @addToFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorite Contacts'**
  String get addToFavoriteContacts;

  /// No description provided for @deleteContactConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete contact'**
  String get deleteContactConfirmation;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delete success'**
  String get deleteSuccess;

  /// No description provided for @dataLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data: {error}'**
  String dataLoadingFailed(Object error);

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @adPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ad Placeholder'**
  String get adPlaceholder;

  /// No description provided for @statisticsGrid.
  ///
  /// In en, this message translates to:
  /// **'Statistics Grid'**
  String get statisticsGrid;

  /// No description provided for @trendChart.
  ///
  /// In en, this message translates to:
  /// **'Trend Chart'**
  String get trendChart;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export successful'**
  String get exportSuccess;

  /// No description provided for @blockedCalls.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedCalls;

  /// No description provided for @filteredSms.
  ///
  /// In en, this message translates to:
  /// **'Filtered SMS'**
  String get filteredSms;

  /// No description provided for @totalBlocked.
  ///
  /// In en, this message translates to:
  /// **'Total Blocked'**
  String get totalBlocked;

  /// No description provided for @totalFiltered.
  ///
  /// In en, this message translates to:
  /// **'Total Filtered'**
  String get totalFiltered;

  /// No description provided for @trend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get trend;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exporting;

  /// No description provided for @exportComplete.
  ///
  /// In en, this message translates to:
  /// **'Export Complete'**
  String get exportComplete;

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Export Error'**
  String get exportError;

  /// No description provided for @homePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homePageTitle;

  /// No description provided for @callHistory.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistory;

  /// No description provided for @smsHistory.
  ///
  /// In en, this message translates to:
  /// **'SMS History'**
  String get smsHistory;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading Data...'**
  String get loadingData;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load Failed'**
  String get loadFailed;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @filtered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get filtered;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get last7Days;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get last30Days;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get customRange;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRange;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @filterManagement.
  ///
  /// In en, this message translates to:
  /// **'Filter Management'**
  String get filterManagement;

  /// No description provided for @addFilter.
  ///
  /// In en, this message translates to:
  /// **'Add Filter'**
  String get addFilter;

  /// No description provided for @editFilter.
  ///
  /// In en, this message translates to:
  /// **'Edit Filter'**
  String get editFilter;

  /// No description provided for @deleteFilter.
  ///
  /// In en, this message translates to:
  /// **'Delete Filter'**
  String get deleteFilter;

  /// No description provided for @filterName.
  ///
  /// In en, this message translates to:
  /// **'Filter Name'**
  String get filterName;

  /// No description provided for @enterFilterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter filter name'**
  String get enterFilterName;

  /// No description provided for @filterPattern.
  ///
  /// In en, this message translates to:
  /// **'Filter Pattern'**
  String get filterPattern;

  /// No description provided for @enterFilterPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter filter pattern'**
  String get enterFilterPattern;

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Filter Type'**
  String get filterType;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @saveFilter.
  ///
  /// In en, this message translates to:
  /// **'Save Filter'**
  String get saveFilter;

  /// No description provided for @filterSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Filter saved successfully'**
  String get filterSaveSuccess;

  /// No description provided for @filterSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Filter save failed'**
  String get filterSaveFailed;

  /// No description provided for @confirmDeleteFilter.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this filter?'**
  String get confirmDeleteFilter;

  /// No description provided for @filterDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Filter deleted successfully'**
  String get filterDeleteSuccess;

  /// No description provided for @filterDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Filter delete failed'**
  String get filterDeleteFailed;

  /// No description provided for @noFilters.
  ///
  /// In en, this message translates to:
  /// **'No filters yet'**
  String get noFilters;

  /// No description provided for @searchFilters.
  ///
  /// In en, this message translates to:
  /// **'Search Filters'**
  String get searchFilters;

  /// No description provided for @filterDetails.
  ///
  /// In en, this message translates to:
  /// **'Filter Details'**
  String get filterDetails;

  /// No description provided for @pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get pattern;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @actionType.
  ///
  /// In en, this message translates to:
  /// **'Action Type'**
  String get actionType;

  /// No description provided for @blockedCallAction.
  ///
  /// In en, this message translates to:
  /// **'Blocked Call Action'**
  String get blockedCallAction;

  /// No description provided for @incomingCallInterceptAction.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call Intercept Action'**
  String get incomingCallInterceptAction;

  /// No description provided for @chooseDefaultInterceptAction.
  ///
  /// In en, this message translates to:
  /// **'Choose the default intercept action'**
  String get chooseDefaultInterceptAction;

  /// No description provided for @endCallImmediately.
  ///
  /// In en, this message translates to:
  /// **'End call immediately'**
  String get endCallImmediately;

  /// No description provided for @answerThenHangup.
  ///
  /// In en, this message translates to:
  /// **'Answer then hang up'**
  String get answerThenHangup;

  /// No description provided for @silenceAndNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Silence and no answer'**
  String get silenceAndNoAnswer;
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
