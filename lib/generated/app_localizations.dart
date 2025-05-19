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

  /// Global filter settings section title
  ///
  /// In en, this message translates to:
  /// **'Global Filter Settings'**
  String get globalFilterSettings;

  /// No description provided for @simSlotManagement.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Management'**
  String get simSlotManagement;

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
  /// **'Enter phone number to add rule'**
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

  /// No description provided for @callHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryTitle;

  /// No description provided for @allTab.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTab;

  /// No description provided for @answeredCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answeredCallsTab;

  /// No description provided for @missedCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get missedCallsTab;

  /// No description provided for @blockedCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blockedCallsTab;

  /// No description provided for @outgoingCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get outgoingCallsTab;

  /// No description provided for @labelFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Label Filter'**
  String get labelFilterTooltip;

  /// No description provided for @searchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTooltip;

  /// No description provided for @initializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize call history: {error}'**
  String initializationFailed(Object error);

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh call history: {error}'**
  String refreshFailed(Object error);

  /// No description provided for @todayGroup.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayGroup;

  /// No description provided for @yesterdayGroup.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterdayGroup;

  /// No description provided for @thisWeekGroup.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeekGroup;

  /// No description provided for @olderGroup.
  ///
  /// In en, this message translates to:
  /// **'Older'**
  String get olderGroup;

  /// No description provided for @emptyCallLogs.
  ///
  /// In en, this message translates to:
  /// **'No call records found'**
  String get emptyCallLogs;

  /// No description provided for @errorLoadingLogs.
  ///
  /// In en, this message translates to:
  /// **'Error loading call logs'**
  String get errorLoadingLogs;

  /// Tag display
  ///
  /// In en, this message translates to:
  /// **'Tag: {tag}'**
  String tagLabel(Object tag);

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
