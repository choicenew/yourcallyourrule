import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// About contact subscription title
  ///
  /// In en, this message translates to:
  /// **'About Contact Subscription'**
  String get aboutContactSubscription;

  /// No description provided for @aboutLabels.
  ///
  /// In en, this message translates to:
  /// **'About Labels'**
  String get aboutLabels;

  /// No description provided for @aboutPhoneSubscriptionRules.
  ///
  /// In en, this message translates to:
  /// **'About Phone Subscription Rules'**
  String get aboutPhoneSubscriptionRules;

  /// About phone subscriptions title
  ///
  /// In en, this message translates to:
  /// **'About Phone Subscriptions'**
  String get aboutPhoneSubscriptions;

  /// About phone subscriptions description
  ///
  /// In en, this message translates to:
  /// **'Subscribe to phone rule lists via URL, automatically update rules. Supports JSON, CSV format rule files.'**
  String get aboutPhoneSubscriptionsDesc;

  /// No description provided for @aboutSmsFilter.
  ///
  /// In en, this message translates to:
  /// **'About SMS Filtering'**
  String get aboutSmsFilter;

  /// No description provided for @aboutSmsSubscriptionRules.
  ///
  /// In en, this message translates to:
  /// **'About SMS Subscription Rules'**
  String get aboutSmsSubscriptionRules;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Application version and legal information'**
  String get aboutSubtitle;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

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

  /// No description provided for @actionFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Filter'**
  String get actionFilterAll;

  /// No description provided for @actionFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by Action Type'**
  String get actionFilterTitle;

  /// No description provided for @actionFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Action Filter'**
  String get actionFilterTooltip;

  /// No description provided for @actionNone.
  ///
  /// In en, this message translates to:
  /// **'No Action'**
  String get actionNone;

  /// No description provided for @actionSilence.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get actionSilence;

  /// No description provided for @actionTag.
  ///
  /// In en, this message translates to:
  /// **'Action: {actionType}'**
  String actionTag(Object actionType);

  /// No description provided for @actionType.
  ///
  /// In en, this message translates to:
  /// **'Action Type'**
  String get actionType;

  /// No description provided for @actionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get actionUnknown;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addAllowedBlockedRule.
  ///
  /// In en, this message translates to:
  /// **'Add Allow/Block Rule'**
  String get addAllowedBlockedRule;

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

  /// No description provided for @addContactButton.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get addContactButton;

  /// No description provided for @addContactFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add contact: {error}'**
  String addContactFailed(Object error);

  /// No description provided for @addedToAllowedRules.
  ///
  /// In en, this message translates to:
  /// **'Added to Allowed Rules'**
  String get addedToAllowedRules;

  /// No description provided for @addedToBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Added to Blacklist'**
  String get addedToBlacklist;

  /// No description provided for @addedToBlockedRules.
  ///
  /// In en, this message translates to:
  /// **'Added to Blocked Rules'**
  String get addedToBlockedRules;

  /// No description provided for @addedToFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Added to favorite contacts'**
  String get addedToFavoriteContacts;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorite contacts'**
  String get addedToFavorites;

  /// No description provided for @addedToWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Added to Whitelist'**
  String get addedToWhitelist;

  /// No description provided for @addFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add Favorite'**
  String get addFavorite;

  /// No description provided for @addFilter.
  ///
  /// In en, this message translates to:
  /// **'Add Filter'**
  String get addFilter;

  /// No description provided for @addLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Label'**
  String get addLabel;

  /// No description provided for @addLabelButton.
  ///
  /// In en, this message translates to:
  /// **'Add Label'**
  String get addLabelButton;

  /// No description provided for @addLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add label: {error}'**
  String addLabelFailed(Object error);

  /// No description provided for @addLabelToCall.
  ///
  /// In en, this message translates to:
  /// **'Add Label to Call Record'**
  String get addLabelToCall;

  /// No description provided for @addName.
  ///
  /// In en, this message translates to:
  /// **'Add Name'**
  String get addName;

  /// Add none subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add None Subscription'**
  String get addNoneSubscription;

  /// No description provided for @addOrEditContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Used to add or edit contact information'**
  String get addOrEditContactInfo;

  /// No description provided for @addPhoneMark.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Mark'**
  String get addPhoneMark;

  /// No description provided for @addPhoneNumberRule.
  ///
  /// In en, this message translates to:
  /// **'Add Phone Number Rule'**
  String get addPhoneNumberRule;

  /// No description provided for @addPlugin.
  ///
  /// In en, this message translates to:
  /// **'Add Plugin'**
  String get addPlugin;

  /// No description provided for @addPluginFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add plugin'**
  String get addPluginFailed;

  /// No description provided for @addPluginFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to add plugin: {error}'**
  String addPluginFailedWithError(Object error);

  /// No description provided for @addPluginFromLocalFile.
  ///
  /// In en, this message translates to:
  /// **'Add Plugin from Local File'**
  String get addPluginFromLocalFile;

  /// No description provided for @addPluginFromUrl.
  ///
  /// In en, this message translates to:
  /// **'Add Plugin from URL'**
  String get addPluginFromUrl;

  /// No description provided for @addRegexRule.
  ///
  /// In en, this message translates to:
  /// **'Add Regex Rule'**
  String get addRegexRule;

  /// No description provided for @addRule.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRule;

  /// No description provided for @addRuleButton.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRuleButton;

  /// No description provided for @addRuleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add rule: {error}'**
  String addRuleFailed(Object error);

  /// No description provided for @addRuleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get addRuleTooltip;

  /// Add silence subscription dialog title
  ///
  /// In en, this message translates to:
  /// **'Add Silence Subscription'**
  String get addSilenceSubscription;

  /// No description provided for @addSimRuleButton.
  ///
  /// In en, this message translates to:
  /// **'Add SIM Rule'**
  String get addSimRuleButton;

  /// No description provided for @addSmsFilterRule.
  ///
  /// In en, this message translates to:
  /// **'Add SMS Filter Rule'**
  String get addSmsFilterRule;

  /// No description provided for @addSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Add SMS Rule'**
  String get addSmsRule;

  /// No description provided for @addSmsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Add SMS Subscription'**
  String get addSmsSubscription;

  /// Add subscription button text
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscription;

  /// No description provided for @addSubscriptionButton.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscriptionButton;

  /// Failed to add subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to add subscription: {error}'**
  String addSubscriptionFailed(Object error);

  /// No description provided for @addSubscriptionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscriptionTooltip;

  /// No description provided for @addToAllowedRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Allowed Rules'**
  String get addToAllowedRules;

  /// No description provided for @addToBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Add to Blacklist'**
  String get addToBlacklist;

  /// No description provided for @addToBlockedRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Blocked Rules'**
  String get addToBlockedRules;

  /// No description provided for @addToFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorite Contacts'**
  String get addToFavoriteContacts;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// No description provided for @addToRules.
  ///
  /// In en, this message translates to:
  /// **'Add to Rules'**
  String get addToRules;

  /// No description provided for @addToWhitelist.
  ///
  /// In en, this message translates to:
  /// **'Add to Whitelist'**
  String get addToWhitelist;

  /// No description provided for @adPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ad Placeholder'**
  String get adPlaceholder;

  /// No description provided for @agent.
  ///
  /// In en, this message translates to:
  /// **'Agent'**
  String get agent;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @allCallsTab.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCallsTab;

  /// No description provided for @allDataClearedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'All data cleared successfully'**
  String get allDataClearedSuccessfully;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

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

  /// No description provided for @allowBlock.
  ///
  /// In en, this message translates to:
  /// **'Allow/Block'**
  String get allowBlock;

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

  /// No description provided for @allowedBlockedRule.
  ///
  /// In en, this message translates to:
  /// **'Allow/Block Rule'**
  String get allowedBlockedRule;

  /// No description provided for @allowedBlockedRuleEditDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Allow/Block Rule'**
  String get allowedBlockedRuleEditDialogTitle;

  /// No description provided for @allowedBlockedRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'Allow/Block Rule Management'**
  String get allowedBlockedRuleManagement;

  /// No description provided for @allowNonExceededNumbers.
  ///
  /// In en, this message translates to:
  /// **'Allow Non-Exceeded Numbers'**
  String get allowNonExceededNumbers;

  /// No description provided for @allowNonExceededNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically allow numbers not exceeding the count threshold'**
  String get allowNonExceededNumbersDescription;

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

  /// No description provided for @allowRegexBlockRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable regex pattern matching for block rules'**
  String get allowRegexBlockRulesDesc;

  /// No description provided for @allowRegexBlockRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable regex-based block rules'**
  String get allowRegexBlockRulesDescription;

  /// No description provided for @allowRule.
  ///
  /// In en, this message translates to:
  /// **'Allow Rule'**
  String get allowRule;

  /// No description provided for @allowRules.
  ///
  /// In en, this message translates to:
  /// **'Allow Rules'**
  String get allowRules;

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

  /// No description provided for @allPermissionsGranted.
  ///
  /// In en, this message translates to:
  /// **'All permissions granted'**
  String get allPermissionsGranted;

  /// No description provided for @allSettingsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All settings completed.'**
  String get allSettingsCompleted;

  /// Full update success message
  ///
  /// In en, this message translates to:
  /// **'All updates completed ({count} rules)'**
  String allUpdateSuccess(Object count);

  /// No description provided for @answerThenHangup.
  ///
  /// In en, this message translates to:
  /// **'Answer then hang up'**
  String get answerThenHangup;

  /// No description provided for @appLegalese.
  ///
  /// In en, this message translates to:
  /// **'© 2023 Your Call Your Rule. All rights reserved.'**
  String get appLegalese;

  /// No description provided for @applicationSoftware.
  ///
  /// In en, this message translates to:
  /// **'Application Software'**
  String get applicationSoftware;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Your Call Your Rule'**
  String get appName;

  /// No description provided for @authorizationFailedCheckCredentialsMessage.
  ///
  /// In en, this message translates to:
  /// **'Authorization failed: Please check client ID and key'**
  String get authorizationFailedCheckCredentialsMessage;

  /// No description provided for @authorizationFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Authorization failed'**
  String get authorizationFailedMessage;

  /// No description provided for @authorizationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Authorization successful'**
  String get authorizationSuccessMessage;

  /// No description provided for @authorizeLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Authorize Login'**
  String get authorizeLoginButton;

  /// No description provided for @automotiveIndustry.
  ///
  /// In en, this message translates to:
  /// **'Automotive Industry'**
  String get automotiveIndustry;

  /// No description provided for @autoSyncLabel.
  ///
  /// In en, this message translates to:
  /// **'Auto Sync'**
  String get autoSyncLabel;

  /// No description provided for @autoUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto Update'**
  String get autoUpdate;

  /// No description provided for @autoUpdateDescription.
  ///
  /// In en, this message translates to:
  /// **'Set auto-update intervals for subscriptions or update manually'**
  String get autoUpdateDescription;

  /// No description provided for @autoUpdateSettings.
  ///
  /// In en, this message translates to:
  /// **'Auto Update Settings'**
  String get autoUpdateSettings;

  /// No description provided for @autoUpdateSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage automatic updates for rules and plugins'**
  String get autoUpdateSettingsSubtitle;

  /// No description provided for @autoUpdateSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto Update Settings'**
  String get autoUpdateSettingsTitle;

  /// No description provided for @autoUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage automatic updates for rules and plugins'**
  String get autoUpdateSubtitle;

  /// No description provided for @autoUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto Update'**
  String get autoUpdateTitle;

  /// No description provided for @avatarBorderColor.
  ///
  /// In en, this message translates to:
  /// **'Avatar Border Color'**
  String get avatarBorderColor;

  /// No description provided for @avatarBorderSize.
  ///
  /// In en, this message translates to:
  /// **'Avatar Border Size'**
  String get avatarBorderSize;

  /// No description provided for @avatarIconSizesSetting.
  ///
  /// In en, this message translates to:
  /// **'Avatar & Icon Sizes'**
  String get avatarIconSizesSetting;

  /// No description provided for @avatarPosition.
  ///
  /// In en, this message translates to:
  /// **'Avatar Position'**
  String get avatarPosition;

  /// No description provided for @avatarSize.
  ///
  /// In en, this message translates to:
  /// **'Avatar Size'**
  String get avatarSize;

  /// No description provided for @axisPosition.
  ///
  /// In en, this message translates to:
  /// **'{axis} Position'**
  String axisPosition(Object axis);

  /// No description provided for @backgroundGradientSetting.
  ///
  /// In en, this message translates to:
  /// **'Background Gradient'**
  String get backgroundGradientSetting;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get backupAndRestore;

  /// No description provided for @backupAndRestoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup or restore application data'**
  String get backupAndRestoreSubtitle;

  /// No description provided for @backupAndRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupAndRestoreTitle;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup failed'**
  String get backupFailed;

  /// No description provided for @backupFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Backup failed'**
  String get backupFailedMessage;

  /// No description provided for @backupFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String backupFailedWithError(Object error);

  /// No description provided for @backupRestoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup or restore application data'**
  String get backupRestoreSubtitle;

  /// No description provided for @backupRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupRestoreTitle;

  /// No description provided for @backupSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupSectionTitle;

  /// No description provided for @backupSettings.
  ///
  /// In en, this message translates to:
  /// **'Backup Settings'**
  String get backupSettings;

  /// No description provided for @backupSettingsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup Settings'**
  String get backupSettingsDialogTitle;

  /// No description provided for @backupSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup Settings'**
  String get backupSettingsTitle;

  /// No description provided for @backupSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Successfully backed up to cloud'**
  String get backupSuccessMessage;

  /// No description provided for @backupSuccessToLocal.
  ///
  /// In en, this message translates to:
  /// **'Backup successful to: {path}'**
  String backupSuccessToLocal(Object path);

  /// No description provided for @backupToCloud.
  ///
  /// In en, this message translates to:
  /// **'Backup to Cloud'**
  String get backupToCloud;

  /// No description provided for @backupToCloudDescription.
  ///
  /// In en, this message translates to:
  /// **'Backup settings and rules to cloud storage'**
  String get backupToCloudDescription;

  /// No description provided for @backupToCloudFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to backup to cloud: {error}'**
  String backupToCloudFailed(Object error);

  /// No description provided for @backupToCloudLabel.
  ///
  /// In en, this message translates to:
  /// **'Backup to Cloud'**
  String get backupToCloudLabel;

  /// No description provided for @backupToCloudSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully backed up to cloud'**
  String get backupToCloudSuccess;

  /// No description provided for @backupToCloudTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup to Cloud'**
  String get backupToCloudTitle;

  /// No description provided for @backupToLocalLabel.
  ///
  /// In en, this message translates to:
  /// **'Backup to Local'**
  String get backupToLocalLabel;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// No description provided for @basicRuleFilter.
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filter'**
  String get basicRuleFilter;

  /// No description provided for @basicRuleFiltering.
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filtering'**
  String get basicRuleFiltering;

  /// No description provided for @basicRuleFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Basic Rule Filtering: Filtering rules based on blacklist, whitelist, and regex'**
  String get basicRuleFilteringExplanation;

  /// Title for basic rule filter settings page
  ///
  /// In en, this message translates to:
  /// **'Basic Rule Filter Settings'**
  String get basicRuleFilterSettings;

  /// No description provided for @basicRuleFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Filter calls using blacklist/whitelist and regular expressions'**
  String get basicRuleFilterSubtitle;

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

  /// No description provided for @batchDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Batch delete failed'**
  String get batchDeleteFailed;

  /// No description provided for @batchDeleteLabelsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} labels?'**
  String batchDeleteLabelsConfirm(Object count);

  /// Blacklist label
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklist;

  /// No description provided for @blacklistingAndWhitelisting.
  ///
  /// In en, this message translates to:
  /// **'Blacklisting and Whitelisting'**
  String get blacklistingAndWhitelisting;

  /// No description provided for @blacklistLabel.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get blacklistLabel;

  /// No description provided for @blackWhiteList.
  ///
  /// In en, this message translates to:
  /// **'Black/White List'**
  String get blackWhiteList;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @blockCalls.
  ///
  /// In en, this message translates to:
  /// **'Block Calls'**
  String get blockCalls;

  /// No description provided for @blocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get blocked;

  /// No description provided for @blockedCallAction.
  ///
  /// In en, this message translates to:
  /// **'Blocked Call Action'**
  String get blockedCallAction;

  /// No description provided for @blockedCalls.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedCalls;

  /// No description provided for @blockedCallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedCallsTitle;

  /// No description provided for @blockedCommunications.
  ///
  /// In en, this message translates to:
  /// **'Blocked Communications'**
  String get blockedCommunications;

  /// No description provided for @blockedPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Blocked Calls'**
  String get blockedPhoneLabel;

  /// No description provided for @blockedSpamCalls.
  ///
  /// In en, this message translates to:
  /// **'Blocked Spam Calls'**
  String get blockedSpamCalls;

  /// No description provided for @blockingTrend.
  ///
  /// In en, this message translates to:
  /// **'Blocking Trend'**
  String get blockingTrend;

  /// No description provided for @blockInternationalCalls.
  ///
  /// In en, this message translates to:
  /// **'matches numbers that don\'t start with + or 00'**
  String get blockInternationalCalls;

  /// No description provided for @blockInternationalCallsTitle.
  ///
  /// In en, this message translates to:
  /// **'Block International Calls'**
  String get blockInternationalCallsTitle;

  /// No description provided for @blockLandlineNumbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Landline Numbers'**
  String get blockLandlineNumbersTitle;

  /// No description provided for @blockMobileNumbers.
  ///
  /// In en, this message translates to:
  /// **'matches numbers that don\'t start with 13-19'**
  String get blockMobileNumbers;

  /// No description provided for @blockMobileNumbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Mobile Numbers'**
  String get blockMobileNumbersTitle;

  /// No description provided for @blockPremiumRateNumbers.
  ///
  /// In en, this message translates to:
  /// **'matches numbers that don\'t start with 118 or 120-190'**
  String get blockPremiumRateNumbers;

  /// No description provided for @blockPremiumRateNumbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Premium Rate Numbers'**
  String get blockPremiumRateNumbersTitle;

  /// No description provided for @blockRule.
  ///
  /// In en, this message translates to:
  /// **'Block Rule'**
  String get blockRule;

  /// No description provided for @blockRules.
  ///
  /// In en, this message translates to:
  /// **'Block Rules'**
  String get blockRules;

  /// No description provided for @blockSpecificAreaCodes.
  ///
  /// In en, this message translates to:
  /// **'matches numbers starting with 0 + 2-3 digits'**
  String get blockSpecificAreaCodes;

  /// No description provided for @blockSpecificAreaCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Block specific area codes:'**
  String get blockSpecificAreaCodesTitle;

  /// No description provided for @blockTypeAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Block Type Analysis'**
  String get blockTypeAnalysisTitle;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @bulkDelete.
  ///
  /// In en, this message translates to:
  /// **'Batch Delete Contacts'**
  String get bulkDelete;

  /// No description provided for @bulkDeleteContacts.
  ///
  /// In en, this message translates to:
  /// **'Batch Delete Contacts'**
  String get bulkDeleteContacts;

  /// No description provided for @bulkDeleteLabels.
  ///
  /// In en, this message translates to:
  /// **'Bulk Delete Labels'**
  String get bulkDeleteLabels;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

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

  /// No description provided for @callBlocking.
  ///
  /// In en, this message translates to:
  /// **'Call Blocking'**
  String get callBlocking;

  /// No description provided for @callerIdApp.
  ///
  /// In en, this message translates to:
  /// **'Caller ID App'**
  String get callerIdApp;

  /// No description provided for @callerIdCustomizationTitle.
  ///
  /// In en, this message translates to:
  /// **'Customize Caller ID'**
  String get callerIdCustomizationTitle;

  /// No description provided for @callerIdDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Caller ID Information'**
  String get callerIdDialogTitle;

  /// No description provided for @callerIdDisplayMode.
  ///
  /// In en, this message translates to:
  /// **'Caller ID Display Mode'**
  String get callerIdDisplayMode;

  /// Mark count display
  ///
  /// In en, this message translates to:
  /// **'Marked by {count}'**
  String callerIdMarkedByCount(Object count);

  /// No description provided for @callerIdPreview.
  ///
  /// In en, this message translates to:
  /// **'Caller ID Preview'**
  String get callerIdPreview;

  /// No description provided for @callFilter.
  ///
  /// In en, this message translates to:
  /// **'Call Filter'**
  String get callFilter;

  /// No description provided for @callFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'When enabled, incoming calls are checked against the rule list below. Call filtering rules are not synchronized between devices by default.'**
  String get callFilterDescription;

  /// No description provided for @callFilterRules.
  ///
  /// In en, this message translates to:
  /// **'Call Filter Rules'**
  String get callFilterRules;

  /// No description provided for @callFilterRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Set basic rules for call filtering'**
  String get callFilterRulesDescription;

  /// No description provided for @callFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'Call Filter Settings'**
  String get callFilterSettings;

  /// No description provided for @callFrequencyInterceptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set call frequency limits and blocking rules'**
  String get callFrequencyInterceptionSubtitle;

  /// No description provided for @callFrequencyInterceptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Frequency Interception'**
  String get callFrequencyInterceptionTitle;

  /// No description provided for @callHistory.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistory;

  /// No description provided for @callHistoryInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Here shows your call history, including incoming, outgoing and missed calls.'**
  String get callHistoryInfoDesc;

  /// No description provided for @callHistoryInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryInfoTitle;

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

  /// No description provided for @callHistoryTab.
  ///
  /// In en, this message translates to:
  /// **'Call History'**
  String get callHistoryTab;

  /// No description provided for @callHistoryTimelineEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get callHistoryTimelineEarlier;

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

  /// No description provided for @callScreeningPermission.
  ///
  /// In en, this message translates to:
  /// **'Call Screening Permission'**
  String get callScreeningPermission;

  /// No description provided for @callScreeningPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to screen and block spam calls.'**
  String get callScreeningPermissionDescription;

  /// No description provided for @callScreeningPermissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Call screening permission not granted, may affect app functionality.'**
  String get callScreeningPermissionNotGranted;

  /// No description provided for @callSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Caller ID, filtering and blocking settings'**
  String get callSettingsSubtitle;

  /// No description provided for @callSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Settings'**
  String get callSettingsTitle;

  /// No description provided for @callStatistics.
  ///
  /// In en, this message translates to:
  /// **'Call Statistics'**
  String get callStatistics;

  /// No description provided for @callTypeAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get callTypeAnswered;

  /// No description provided for @callTypeBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get callTypeBlocked;

  /// No description provided for @callTypeIconColor.
  ///
  /// In en, this message translates to:
  /// **'Call Type Icon Color'**
  String get callTypeIconColor;

  /// No description provided for @callTypeMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed Call'**
  String get callTypeMissed;

  /// No description provided for @callTypeOutgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get callTypeOutgoing;

  /// No description provided for @callTypePosition.
  ///
  /// In en, this message translates to:
  /// **'Call Type Position'**
  String get callTypePosition;

  /// No description provided for @callTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get callTypeUnknown;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @carRental.
  ///
  /// In en, this message translates to:
  /// **'Car Rental'**
  String get carRental;

  /// No description provided for @carrier.
  ///
  /// In en, this message translates to:
  /// **'Carrier'**
  String get carrier;

  /// No description provided for @carrierColor.
  ///
  /// In en, this message translates to:
  /// **'Carrier Color'**
  String get carrierColor;

  /// No description provided for @carrierFontSize.
  ///
  /// In en, this message translates to:
  /// **'Carrier Font Size'**
  String get carrierFontSize;

  /// No description provided for @carrierPosition.
  ///
  /// In en, this message translates to:
  /// **'Carrier Position'**
  String get carrierPosition;

  /// No description provided for @changeLabel.
  ///
  /// In en, this message translates to:
  /// **'Change Label'**
  String get changeLabel;

  /// No description provided for @changePluginStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to change plugin status: {error}'**
  String changePluginStatusFailed(Object error);

  /// Failed to change subscription status error message
  ///
  /// In en, this message translates to:
  /// **'Failed to change subscription status: {error}'**
  String changeSubscriptionStatusFailed(Object error);

  /// No description provided for @changeTag.
  ///
  /// In en, this message translates to:
  /// **'Change Tag'**
  String get changeTag;

  /// No description provided for @charity.
  ///
  /// In en, this message translates to:
  /// **'Charity'**
  String get charity;

  /// Month format for chart labels
  ///
  /// In en, this message translates to:
  /// **'Month {month}'**
  String chartMonthFormat(int month);

  /// No description provided for @chartOneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get chartOneDayAgo;

  /// No description provided for @chartOneMonthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get chartOneMonthAgo;

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

  /// No description provided for @chartThreeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'3 days ago'**
  String get chartThreeDaysAgo;

  /// No description provided for @chartToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chartToday;

  /// No description provided for @checkFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Please check file format or permissions'**
  String get checkFileFormat;

  /// No description provided for @checkPermissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to check permissions: {error}'**
  String checkPermissionFailed(Object error);

  /// No description provided for @chooseDefaultInterceptAction.
  ///
  /// In en, this message translates to:
  /// **'Choose the default intercept action'**
  String get chooseDefaultInterceptAction;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearAllDataConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all application data? This action cannot be undone.'**
  String get clearAllDataConfirmation;

  /// No description provided for @clearAllDataDescription.
  ///
  /// In en, this message translates to:
  /// **'Clear all application data'**
  String get clearAllDataDescription;

  /// No description provided for @clearAllDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllDataLabel;

  /// No description provided for @clearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get clearFilter;

  /// No description provided for @clearLabelFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear Label Filter'**
  String get clearLabelFilter;

  /// No description provided for @clearLabelFilterButton.
  ///
  /// In en, this message translates to:
  /// **'Clear Label Filter'**
  String get clearLabelFilterButton;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @cloudSync.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync'**
  String get cloudSync;

  /// No description provided for @cloudSyncAndBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync & Backup'**
  String get cloudSyncAndBackupTitle;

  /// No description provided for @cloudSyncSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure WebDAV, OneDrive and Google Drive'**
  String get cloudSyncSettingsSubtitle;

  /// No description provided for @cloudSyncSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync Settings'**
  String get cloudSyncSettingsTitle;

  /// No description provided for @cloudSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync'**
  String get cloudSyncTitle;

  /// No description provided for @collapseLabelSelector.
  ///
  /// In en, this message translates to:
  /// **'Collapse Label Selector'**
  String get collapseLabelSelector;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Debt Collection'**
  String get collection;

  /// No description provided for @colorPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Color'**
  String get colorPickerTitle;

  /// No description provided for @configManagement.
  ///
  /// In en, this message translates to:
  /// **'Configuration Management'**
  String get configManagement;

  /// No description provided for @configUpdated.
  ///
  /// In en, this message translates to:
  /// **'Configuration updated'**
  String get configUpdated;

  /// No description provided for @configurationAdvice.
  ///
  /// In en, this message translates to:
  /// **'Through proper configuration, you can set different filtering strategies for work and personal SIM cards.'**
  String get configurationAdvice;

  /// No description provided for @configureBackupOptions.
  ///
  /// In en, this message translates to:
  /// **'Configure Backup Options'**
  String get configureBackupOptions;

  /// No description provided for @configureBackupOptionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure backup options'**
  String get configureBackupOptionsSubtitle;

  /// No description provided for @configureCloudSyncService.
  ///
  /// In en, this message translates to:
  /// **'Configure Cloud Sync Service'**
  String get configureCloudSyncService;

  /// No description provided for @configureCloudSyncServiceHint.
  ///
  /// In en, this message translates to:
  /// **'Please configure a cloud sync service to enable multi-device synchronization.'**
  String get configureCloudSyncServiceHint;

  /// No description provided for @configureCloudSyncServiceMessage.
  ///
  /// In en, this message translates to:
  /// **'Please configure a cloud sync service to enable multi-device synchronization.'**
  String get configureCloudSyncServiceMessage;

  /// No description provided for @configureSimCardFilterRules.
  ///
  /// In en, this message translates to:
  /// **'Configure SIM Card Filter Rules'**
  String get configureSimCardFilterRules;

  /// No description provided for @configureSyncServiceHint.
  ///
  /// In en, this message translates to:
  /// **'Please configure sync service in cloud sync settings first'**
  String get configureSyncServiceHint;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmBatchDeleteContacts.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected'**
  String get confirmBatchDeleteContacts;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteContact.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete'**
  String get confirmDeleteContact;

  /// No description provided for @confirmDeleteContactName.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete?'**
  String get confirmDeleteContactName;

  /// No description provided for @confirmDeleteFilter.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this filter?'**
  String get confirmDeleteFilter;

  /// No description provided for @confirmDeleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete label \"{name}\"'**
  String confirmDeleteLabel(Object name);

  /// No description provided for @confirmDeletePlugin.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete plugin \"{name}\"?'**
  String confirmDeletePlugin(Object name);

  /// Confirmation message shown before deleting one or more plugins.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {count} plugins?'**
  String confirmDeletePlugins(Object count);

  /// No description provided for @confirmDeleteRuleMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this rule? This action cannot be undone.'**
  String get confirmDeleteRuleMessage;

  /// No description provided for @confirmDeleteSelectedContacts.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete selected contacts?'**
  String get confirmDeleteSelectedContacts;

  /// No description provided for @confirmDeleteSmsFilterRule.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this SMS filter rule?'**
  String get confirmDeleteSmsFilterRule;

  /// No description provided for @confirmDeleteSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this SMS rule?'**
  String get confirmDeleteSmsRule;

  /// No description provided for @confirmDeleteSubscription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this subscription?'**
  String get confirmDeleteSubscription;

  /// Confirmation message shown before deleting a subscription.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String confirmDeleteSubscriptions(String name);

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @connectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connectedStatus;

  /// No description provided for @connectionFailedCheckCredentialsMessage.
  ///
  /// In en, this message translates to:
  /// **'Connection failed: Please check server address, username, and password'**
  String get connectionFailedCheckCredentialsMessage;

  /// No description provided for @connectionFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get connectionFailedMessage;

  /// No description provided for @connectionStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Connection Status'**
  String get connectionStatusLabel;

  /// No description provided for @connectionSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Connection successful'**
  String get connectionSuccessMessage;

  /// No description provided for @contactAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact added successfully'**
  String get contactAddSuccess;

  /// No description provided for @contactDeleted.
  ///
  /// In en, this message translates to:
  /// **'Contact deleted'**
  String get contactDeleted;

  /// No description provided for @contactEditDialog.
  ///
  /// In en, this message translates to:
  /// **'Contact Edit Dialog'**
  String get contactEditDialog;

  /// No description provided for @contactNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name (optional)'**
  String get contactNameHint;

  /// No description provided for @contactNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactNameLabel;

  /// No description provided for @contactNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Contact name (optional)'**
  String get contactNameOptional;

  /// No description provided for @contactNotFound.
  ///
  /// In en, this message translates to:
  /// **'Contact not found'**
  String get contactNotFound;

  /// No description provided for @contacts.
  ///
  /// In en, this message translates to:
  /// **'contacts'**
  String get contacts;

  /// No description provided for @contactsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted {count} contacts'**
  String contactsDeleted(Object count);

  /// No description provided for @contactSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Contact management and label settings'**
  String get contactSettingsSubtitle;

  /// No description provided for @contactSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Settings'**
  String get contactSettingsTitle;

  /// No description provided for @contactsLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts: {error}'**
  String contactsLoadingFailed(Object error);

  /// No description provided for @contactsManagement.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management'**
  String get contactsManagement;

  /// No description provided for @contactsManagementPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management Page'**
  String get contactsManagementPageTitle;

  /// No description provided for @contactsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts Management'**
  String get contactsPageTitle;

  /// No description provided for @contactsPermission.
  ///
  /// In en, this message translates to:
  /// **'Contacts Permission'**
  String get contactsPermission;

  /// No description provided for @contactsPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to identify contact calls.'**
  String get contactsPermissionDescription;

  /// No description provided for @contactsTab.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get contactsTab;

  /// About contact subscription description
  ///
  /// In en, this message translates to:
  /// **'Subscribe to contact lists via URL, automatically update contact information and labels. Supports JSON format data.'**
  String get contactSubscriptionDescription;

  /// No description provided for @contactSubscriptionLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contact subscriptions: {error}'**
  String contactSubscriptionLoadingFailed(Object error);

  /// No description provided for @contactSubscriptionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact Subscriptions'**
  String get contactSubscriptionPageTitle;

  /// No description provided for @contactUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Contact updated successfully'**
  String get contactUpdateSuccess;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @contentRegex.
  ///
  /// In en, this message translates to:
  /// **'Content Regex'**
  String get contentRegex;

  /// No description provided for @countColor.
  ///
  /// In en, this message translates to:
  /// **'Count Color'**
  String get countColor;

  /// No description provided for @countFontSize.
  ///
  /// In en, this message translates to:
  /// **'Count Font Size'**
  String get countFontSize;

  /// No description provided for @countPosition.
  ///
  /// In en, this message translates to:
  /// **'Count Position'**
  String get countPosition;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @countryNameColor.
  ///
  /// In en, this message translates to:
  /// **'Country Name Color'**
  String get countryNameColor;

  /// No description provided for @countryNameFontSize.
  ///
  /// In en, this message translates to:
  /// **'Country Name Font Size'**
  String get countryNameFontSize;

  /// No description provided for @countryRegionNamePosition.
  ///
  /// In en, this message translates to:
  /// **'Country/Region Name Position'**
  String get countryRegionNamePosition;

  /// No description provided for @countrySelectionDialog.
  ///
  /// In en, this message translates to:
  /// **'Country Selection Dialog'**
  String get countrySelectionDialog;

  /// No description provided for @countrySelectionDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to select a country to query caller ID information'**
  String get countrySelectionDialogDescription;

  /// No description provided for @countThresholdDescription.
  ///
  /// In en, this message translates to:
  /// **'Set the minimum count threshold required to trigger filtering actions'**
  String get countThresholdDescription;

  /// No description provided for @countThresholdLabel.
  ///
  /// In en, this message translates to:
  /// **'Count Threshold'**
  String get countThresholdLabel;

  /// No description provided for @countThresholdSettings.
  ///
  /// In en, this message translates to:
  /// **'Count Threshold Settings'**
  String get countThresholdSettings;

  /// No description provided for @countThresholdValue.
  ///
  /// In en, this message translates to:
  /// **'Count Threshold: {count}'**
  String countThresholdValue(Object count);

  /// No description provided for @createdRules.
  ///
  /// In en, this message translates to:
  /// **'Created Rules'**
  String get createdRules;

  /// No description provided for @csvFormat.
  ///
  /// In en, this message translates to:
  /// **'CSV Format'**
  String get csvFormat;

  /// No description provided for @currentDeviceChip.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currentDeviceChip;

  /// No description provided for @currentDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Device Label'**
  String get currentDeviceLabel;

  /// No description provided for @currentDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Device'**
  String get currentDeviceTitle;

  /// No description provided for @currentLabels.
  ///
  /// In en, this message translates to:
  /// **'Current Labels:'**
  String get currentLabels;

  /// No description provided for @currentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Current Language'**
  String get currentLanguage;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPasswordLabel;

  /// No description provided for @customerService.
  ///
  /// In en, this message translates to:
  /// **'Customer Service'**
  String get customerService;

  /// No description provided for @customRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get customRange;

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

  /// No description provided for @dashboardTab.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTab;

  /// No description provided for @dataAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis'**
  String get dataAnalysis;

  /// No description provided for @dataAnalysisDashboardPage.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis Dashboard Page'**
  String get dataAnalysisDashboardPage;

  /// No description provided for @dataExport.
  ///
  /// In en, this message translates to:
  /// **'Data Export'**
  String get dataExport;

  /// Data loading failure message
  ///
  /// In en, this message translates to:
  /// **'Data load failed: {error}'**
  String dataLoadFailure(Object error);

  /// No description provided for @dataLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data: {error}'**
  String dataLoadingFailed(Object error);

  /// No description provided for @dataMigration.
  ///
  /// In en, this message translates to:
  /// **'Data Migration'**
  String get dataMigration;

  /// No description provided for @dataMigrationDescription.
  ///
  /// In en, this message translates to:
  /// **'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.'**
  String get dataMigrationDescription;

  /// No description provided for @dataMigrationDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This feature allows you to transfer all your data between devices. Currently, you can use the backup and restore features to manually migrate your data.'**
  String get dataMigrationDialogContent;

  /// No description provided for @dataMigrationDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Migration'**
  String get dataMigrationDialogTitle;

  /// No description provided for @dataMigrationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Migration'**
  String get dataMigrationSectionTitle;

  /// No description provided for @dataSourceReminder.
  ///
  /// In en, this message translates to:
  /// **'Data Source Reminder'**
  String get dataSourceReminder;

  /// Day count display
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String days(num count);

  /// No description provided for @daysVip.
  ///
  /// In en, this message translates to:
  /// **'{days} Days VIP'**
  String daysVip(Object days);

  /// No description provided for @debtCollection.
  ///
  /// In en, this message translates to:
  /// **'Debt Collection'**
  String get debtCollection;

  /// No description provided for @defaultPeriod.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get defaultPeriod;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

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

  /// No description provided for @deleteContactConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete contact'**
  String get deleteContactConfirmation;

  /// No description provided for @deleteDeviceConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {deviceName}?'**
  String deleteDeviceConfirmation(Object deviceName);

  /// No description provided for @deleteDeviceDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Device'**
  String get deleteDeviceDialogTitle;

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String deleteFailed(Object error);

  /// No description provided for @deleteFilter.
  ///
  /// In en, this message translates to:
  /// **'Delete Filter'**
  String get deleteFilter;

  /// No description provided for @deleteLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Label'**
  String get deleteLabel;

  /// No description provided for @deleteLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete label: {error}'**
  String deleteLabelFailed(Object error);

  /// No description provided for @deletePlugin.
  ///
  /// In en, this message translates to:
  /// **'Delete Plugin'**
  String get deletePlugin;

  /// No description provided for @deletePluginFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete plugin: {error}'**
  String deletePluginFailed(Object error);

  /// No description provided for @deletePlugins.
  ///
  /// In en, this message translates to:
  /// **'Delete Plugins'**
  String get deletePlugins;

  /// No description provided for @deletePluginsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete plugins: {error}'**
  String deletePluginsFailed(Object error);

  /// No description provided for @deleteRule.
  ///
  /// In en, this message translates to:
  /// **'Delete Rule'**
  String get deleteRule;

  /// No description provided for @deleteRuleFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String deleteRuleFailed(Object error);

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete Selected'**
  String get deleteSelected;

  /// No description provided for @deleteSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Delete SMS Rule'**
  String get deleteSmsRule;

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

  /// Failed to delete subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete subscription: {error}'**
  String deleteSubscriptionFailed(Object error);

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Delete successful'**
  String get deleteSuccess;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @deviceDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Device deleted successfully'**
  String get deviceDeletedSuccessfully;

  /// No description provided for @deviceDeletedSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'Device deleted successfully'**
  String get deviceDeletedSuccessfullyMessage;

  /// No description provided for @deviceIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Device ID'**
  String get deviceIdLabel;

  /// No description provided for @deviceIDLabel.
  ///
  /// In en, this message translates to:
  /// **'Device ID'**
  String get deviceIDLabel;

  /// No description provided for @deviceManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage multi-device synchronization'**
  String get deviceManagementSubtitle;

  /// No description provided for @deviceManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get deviceManagementTitle;

  /// No description provided for @deviceModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Device Model'**
  String get deviceModelLabel;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceName;

  /// No description provided for @deviceNameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Device name cannot be empty'**
  String get deviceNameCannotBeEmpty;

  /// No description provided for @deviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter device name'**
  String get deviceNameHint;

  /// No description provided for @deviceNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceNameLabel;

  /// No description provided for @deviceRenamedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Device renamed successfully'**
  String get deviceRenamedSuccessfully;

  /// No description provided for @deviceRenamedSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'Device renamed successfully'**
  String get deviceRenamedSuccessfullyMessage;

  /// No description provided for @devicesSyncedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Devices synchronized successfully'**
  String get devicesSyncedSuccessfully;

  /// No description provided for @devicesSyncedSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'Devices synchronized successfully'**
  String get devicesSyncedSuccessfullyMessage;

  /// No description provided for @devicesSynchronizedSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'Devices synchronized successfully'**
  String get devicesSynchronizedSuccessfullyMessage;

  /// No description provided for @deviceUnregisteredSuccessfullyMessage.
  ///
  /// In en, this message translates to:
  /// **'Device unregistered successfully'**
  String get deviceUnregisteredSuccessfullyMessage;

  /// No description provided for @dialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern Explanation'**
  String get dialogTitle;

  /// No description provided for @differentFromLocalCounter.
  ///
  /// In en, this message translates to:
  /// **'This feature is different from the local counter filter, as it focuses on repeated call patterns in a short time rather than long-term marking counts.'**
  String get differentFromLocalCounter;

  /// Disabled status text
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabled;

  /// No description provided for @disabledStatus.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get disabledStatus;

  /// No description provided for @disableGlobalPlugins.
  ///
  /// In en, this message translates to:
  /// **'Disable global plugins'**
  String get disableGlobalPlugins;

  /// No description provided for @disableSubscriptionSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Disable subscription successfully'**
  String get disableSubscriptionSuccessfully;

  /// No description provided for @disconnectButton.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnectButton;

  /// No description provided for @disconnectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnectedMessage;

  /// No description provided for @disconnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnectedStatus;

  /// No description provided for @disconnectFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Disconnect failed'**
  String get disconnectFailedMessage;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dualSimAdvice.
  ///
  /// In en, this message translates to:
  /// **'This feature is particularly useful for dual-SIM phones to set different filtering strategies for work and personal SIM cards.'**
  String get dualSimAdvice;

  /// No description provided for @earlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get earlier;

  /// No description provided for @ecommerce.
  ///
  /// In en, this message translates to:
  /// **'Ecommerce'**
  String get ecommerce;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @editContact.
  ///
  /// In en, this message translates to:
  /// **'Edit Contact'**
  String get editContact;

  /// No description provided for @editFilter.
  ///
  /// In en, this message translates to:
  /// **'Edit Filter'**
  String get editFilter;

  /// No description provided for @editLabel.
  ///
  /// In en, this message translates to:
  /// **'Edit Label'**
  String get editLabel;

  /// No description provided for @editPhoneRule.
  ///
  /// In en, this message translates to:
  /// **'Edit Phone Rule'**
  String get editPhoneRule;

  /// No description provided for @editPhoneRules.
  ///
  /// In en, this message translates to:
  /// **'Used to edit phone rules'**
  String get editPhoneRules;

  /// No description provided for @editPhoneRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Phone Rule'**
  String get editPhoneRuleTitle;

  /// No description provided for @editRule.
  ///
  /// In en, this message translates to:
  /// **'Edit Rule'**
  String get editRule;

  /// No description provided for @editSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Edit SMS Rule'**
  String get editSmsRule;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @elementPositionsSetting.
  ///
  /// In en, this message translates to:
  /// **'Element Positions'**
  String get elementPositionsSetting;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (Optional)'**
  String get emailOptional;

  /// No description provided for @enableCallFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable Call Filter'**
  String get enableCallFilter;

  /// No description provided for @enableCallFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'When enabled, incoming calls are checked against the rule list below. Call filtering rules are not synchronized between devices by default.'**
  String get enableCallFilterDescription;

  /// Enabled status text
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// No description provided for @enabledStatus.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabledStatus;

  /// No description provided for @enableEncryption.
  ///
  /// In en, this message translates to:
  /// **'Enable Encryption'**
  String get enableEncryption;

  /// No description provided for @enableEncryptionDescription.
  ///
  /// In en, this message translates to:
  /// **'Encrypt backup files'**
  String get enableEncryptionDescription;

  /// No description provided for @enableEncryptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Enable Encryption'**
  String get enableEncryptionLabel;

  /// No description provided for @enableEncryptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup files will be encrypted'**
  String get enableEncryptionSubtitle;

  /// No description provided for @enableEncryptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Encryption'**
  String get enableEncryptionTitle;

  /// No description provided for @enableGlobalPlugins.
  ///
  /// In en, this message translates to:
  /// **'Enable global plugins'**
  String get enableGlobalPlugins;

  /// No description provided for @enableLocalCountFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable Local Count Filter'**
  String get enableLocalCountFilter;

  /// No description provided for @enableLocalCountFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically filter spam calls based on call marking count'**
  String get enableLocalCountFilterDescription;

  /// No description provided for @enableLocalNotification.
  ///
  /// In en, this message translates to:
  /// **'Use Local Notification'**
  String get enableLocalNotification;

  /// No description provided for @enableLocalNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'When enabled, notifications for filtered messages will be displayed on the device'**
  String get enableLocalNotificationDescription;

  /// No description provided for @enableLocationSummary.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get enableLocationSummary;

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

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @enableRemoteNumberFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable Remote Number Filter'**
  String get enableRemoteNumberFilter;

  /// No description provided for @enableRemoteNumberFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Use remote database to filter numbers'**
  String get enableRemoteNumberFilterDescription;

  /// No description provided for @enableRule.
  ///
  /// In en, this message translates to:
  /// **'Enable Rule'**
  String get enableRule;

  /// No description provided for @enableSmsFilter.
  ///
  /// In en, this message translates to:
  /// **'Enable SMS Filtering'**
  String get enableSmsFilter;

  /// No description provided for @enableSmsFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'When enabled, messages will be automatically filtered according to the rules'**
  String get enableSmsFilterDescription;

  /// No description provided for @enableStatisticsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Statistics Notifications'**
  String get enableStatisticsNotifications;

  /// No description provided for @enableSubscriptionSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Enable subscription successfully'**
  String get enableSubscriptionSuccessfully;

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

  /// No description provided for @enableTimeInterceptor.
  ///
  /// In en, this message translates to:
  /// **'Enable Time Interceptor'**
  String get enableTimeInterceptor;

  /// No description provided for @endCallImmediately.
  ///
  /// In en, this message translates to:
  /// **'End call immediately'**
  String get endCallImmediately;

  /// No description provided for @endColor.
  ///
  /// In en, this message translates to:
  /// **'End Color'**
  String get endColor;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @enhancedFilterInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter System'**
  String get enhancedFilterInstructionsTitle;

  /// Enhanced filter settings page title
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter Settings'**
  String get enhancedFilterSettings;

  /// No description provided for @enhancedFilterSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Filter Settings'**
  String get enhancedFilterSettingsTitle;

  /// No description provided for @enhancedFilterSystemDescription.
  ///
  /// In en, this message translates to:
  /// **'The enhanced filter system supports both global rules and per-SIM card filtering configurations.'**
  String get enhancedFilterSystemDescription;

  /// No description provided for @enterBothPhoneNumberAndRegexPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern'**
  String get enterBothPhoneNumberAndRegexPattern;

  /// No description provided for @enterBothPhoneNumberAndRegexPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern.'**
  String get enterBothPhoneNumberAndRegexPatternMessage;

  /// No description provided for @enterContactName.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact name'**
  String get enterContactName;

  /// No description provided for @enterCurrentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get enterCurrentPasswordHint;

  /// No description provided for @enterDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Enter Device Name'**
  String get enterDeviceName;

  /// No description provided for @enterDeviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter device name'**
  String get enterDeviceNameHint;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get enterEmail;

  /// No description provided for @enterEmailOptional.
  ///
  /// In en, this message translates to:
  /// **'Please enter email (optional)'**
  String get enterEmailOptional;

  /// No description provided for @enterEncryptionPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter encryption password'**
  String get enterEncryptionPasswordHint;

  /// No description provided for @enterEncryptionPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter Encryption Password'**
  String get enterEncryptionPasswordTitle;

  /// No description provided for @enterFilterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter filter name'**
  String get enterFilterName;

  /// No description provided for @enterFilterPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter filter pattern'**
  String get enterFilterPattern;

  /// No description provided for @enterIconCode.
  ///
  /// In en, this message translates to:
  /// **'Enter icon code'**
  String get enterIconCode;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name'**
  String get enterName;

  /// No description provided for @enterNewDeviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a new name for this device'**
  String get enterNewDeviceNameHint;

  /// No description provided for @enterNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get enterNewPasswordHint;

  /// No description provided for @enterPasswordAgain.
  ///
  /// In en, this message translates to:
  /// **'Enter Password Again'**
  String get enterPasswordAgain;

  /// No description provided for @enterPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get enterPasswordHint;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @enterPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to test'**
  String get enterPhoneNumberHint;

  /// No description provided for @enterPhoneNumberMultiple.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number, multiple numbers separated by commas'**
  String get enterPhoneNumberMultiple;

  /// No description provided for @enterPhoneNumberToStartSearch.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to start search'**
  String get enterPhoneNumberToStartSearch;

  /// No description provided for @enterPhoneNumberToVerify.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to verify'**
  String get enterPhoneNumberToVerify;

  /// No description provided for @enterPluginName.
  ///
  /// In en, this message translates to:
  /// **'Enter Plugin Name'**
  String get enterPluginName;

  /// No description provided for @enterPluginUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter plugin URL address'**
  String get enterPluginUrl;

  /// No description provided for @enterRegexHint.
  ///
  /// In en, this message translates to:
  /// **'Enter regex pattern'**
  String get enterRegexHint;

  /// No description provided for @enterRuleNameAndPattern.
  ///
  /// In en, this message translates to:
  /// **'Please enter rule name and pattern'**
  String get enterRuleNameAndPattern;

  /// No description provided for @enterRuleNameAndPatternMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter both rule name and regex pattern.'**
  String get enterRuleNameAndPatternMessage;

  /// No description provided for @enterRuleNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter rule name'**
  String get enterRuleNameHint;

  /// No description provided for @enterSearchContent.
  ///
  /// In en, this message translates to:
  /// **'Please enter search content'**
  String get enterSearchContent;

  /// Subscription name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter subscription name'**
  String get enterSubscriptionName;

  /// Subscription URL field hint
  ///
  /// In en, this message translates to:
  /// **'Enter subscription URL'**
  String get enterSubscriptionUrl;

  /// No description provided for @enterSyncFolderNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter sync folder name (default: NotificationManager)'**
  String get enterSyncFolderNameHint;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// Enter valid name and URL error message
  ///
  /// In en, this message translates to:
  /// **'Please enter valid name and URL'**
  String get enterValidNameAndUrl;

  /// No description provided for @enterValidUrl.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get enterValidUrl;

  /// No description provided for @enterVersion.
  ///
  /// In en, this message translates to:
  /// **'Enter Version'**
  String get enterVersion;

  /// No description provided for @enterWebDAVPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV password'**
  String get enterWebDAVPasswordHint;

  /// No description provided for @enterWebDAVServerAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV server address'**
  String get enterWebDAVServerAddressHint;

  /// No description provided for @enterWebDAVUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV username'**
  String get enterWebDAVUsernameHint;

  /// No description provided for @errorDeletingDeviceMessage.
  ///
  /// In en, this message translates to:
  /// **'Error deleting device: {error}'**
  String errorDeletingDeviceMessage(Object error);

  /// No description provided for @errorLoadingPlugin.
  ///
  /// In en, this message translates to:
  /// **'Error loading plugin'**
  String get errorLoadingPlugin;

  /// No description provided for @errorOccurredMessage.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String errorOccurredMessage(Object error);

  /// No description provided for @errorRenamingDeviceMessage.
  ///
  /// In en, this message translates to:
  /// **'Error renaming device: {error}'**
  String errorRenamingDeviceMessage(Object error);

  /// No description provided for @errorSynchronizingDevicesMessage.
  ///
  /// In en, this message translates to:
  /// **'Error synchronizing devices: {error}'**
  String errorSynchronizingDevicesMessage(Object error);

  /// No description provided for @errorSyncingDevicesMessage.
  ///
  /// In en, this message translates to:
  /// **'Error syncing devices: {error}'**
  String errorSyncingDevicesMessage(Object error);

  /// No description provided for @errorText.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorText;

  /// No description provided for @errorUnregisteringDeviceMessage.
  ///
  /// In en, this message translates to:
  /// **'Error unregistering device: {error}'**
  String errorUnregisteringDeviceMessage(Object error);

  /// No description provided for @exampleBlock400Prefix.
  ///
  /// In en, this message translates to:
  /// **'e.g. Block 400 prefix numbers'**
  String get exampleBlock400Prefix;

  /// No description provided for @exampleBlockMarketingSms.
  ///
  /// In en, this message translates to:
  /// **'e.g. Block marketing SMS'**
  String get exampleBlockMarketingSms;

  /// No description provided for @exampleContentRegex.
  ///
  /// In en, this message translates to:
  /// **'e.g., .*offer.*'**
  String get exampleContentRegex;

  /// No description provided for @exampleContentRegexHint.
  ///
  /// In en, this message translates to:
  /// **'Example Content Regex'**
  String get exampleContentRegexHint;

  /// No description provided for @exampleCouponPromotionDiscount.
  ///
  /// In en, this message translates to:
  /// **'e.g. .*(coupon|promotion|discount).*'**
  String get exampleCouponPromotionDiscount;

  /// No description provided for @exampleFamilyFriends.
  ///
  /// In en, this message translates to:
  /// **'e.g. Family, Friends, etc.'**
  String get exampleFamilyFriends;

  /// No description provided for @examplePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'e.g. 10086, 12345, etc.'**
  String get examplePhoneNumber;

  /// No description provided for @exampleRegex400Prefix.
  ///
  /// In en, this message translates to:
  /// **'Example regex for 400 prefix'**
  String get exampleRegex400Prefix;

  /// No description provided for @exampleRegexFormat.
  ///
  /// In en, this message translates to:
  /// **'Example: ^10086\$ format'**
  String get exampleRegexFormat;

  /// No description provided for @exampleSenderRegexHint.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get exampleSenderRegexHint;

  /// No description provided for @exchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchange;

  /// No description provided for @exchangeNow.
  ///
  /// In en, this message translates to:
  /// **'Exchange Now'**
  String get exchangeNow;

  /// No description provided for @exchangeVip.
  ///
  /// In en, this message translates to:
  /// **'Exchange VIP'**
  String get exchangeVip;

  /// No description provided for @expandLabelSelector.
  ///
  /// In en, this message translates to:
  /// **'Expand Label Selector'**
  String get expandLabelSelector;

  /// No description provided for @expiryTime.
  ///
  /// In en, this message translates to:
  /// **'Expiry time: {time}'**
  String expiryTime(Object time);

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exportAllApplicationSettings.
  ///
  /// In en, this message translates to:
  /// **'Export all application settings'**
  String get exportAllApplicationSettings;

  /// No description provided for @exportAllApplicationSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export all application settings'**
  String get exportAllApplicationSettingsSubtitle;

  /// No description provided for @exportAllRuleConfigurations.
  ///
  /// In en, this message translates to:
  /// **'Export All Rule Configurations'**
  String get exportAllRuleConfigurations;

  /// No description provided for @exportAllRuleConfigurationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export all rule configurations'**
  String get exportAllRuleConfigurationsSubtitle;

  /// No description provided for @exportComplete.
  ///
  /// In en, this message translates to:
  /// **'Export Complete'**
  String get exportComplete;

  /// No description provided for @exportConfig.
  ///
  /// In en, this message translates to:
  /// **'Export Configuration'**
  String get exportConfig;

  /// No description provided for @exportContacts.
  ///
  /// In en, this message translates to:
  /// **'Export Contacts'**
  String get exportContacts;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Export Error'**
  String get exportError;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get exportFailed;

  /// No description provided for @exportFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to export configuration'**
  String get exportFailure;

  /// No description provided for @exportFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Export feature coming soon'**
  String get exportFeatureComingSoon;

  /// No description provided for @exporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exporting;

  /// No description provided for @exportLabels.
  ///
  /// In en, this message translates to:
  /// **'Export Labels'**
  String get exportLabels;

  /// No description provided for @exportLabelsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to export labels: {error}'**
  String exportLabelsFailed(Object error);

  /// No description provided for @exportPluginList.
  ///
  /// In en, this message translates to:
  /// **'Export Plugin List'**
  String get exportPluginList;

  /// No description provided for @exportPluginListFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to export plugin list: {error}'**
  String exportPluginListFailed(Object error);

  /// No description provided for @exportRules.
  ///
  /// In en, this message translates to:
  /// **'Export Rules'**
  String get exportRules;

  /// No description provided for @exportRulesDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Rules'**
  String get exportRulesDialogTitle;

  /// No description provided for @exportRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Rules'**
  String get exportRulesTitle;

  /// No description provided for @exportSmsRules.
  ///
  /// In en, this message translates to:
  /// **'Export SMS Rules'**
  String get exportSmsRules;

  /// No description provided for @exportStatisticsData.
  ///
  /// In en, this message translates to:
  /// **'Export Statistics Data'**
  String get exportStatisticsData;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export successful'**
  String get exportSuccess;

  /// No description provided for @exportSuccesslly.
  ///
  /// In en, this message translates to:
  /// **'Configuration exported successfully'**
  String get exportSuccesslly;

  /// No description provided for @failedToAddContact.
  ///
  /// In en, this message translates to:
  /// **'Failed to add contact'**
  String get failedToAddContact;

  /// No description provided for @failedToAddRule.
  ///
  /// In en, this message translates to:
  /// **'Failed to add rule: {error}'**
  String failedToAddRule(Object error);

  /// No description provided for @failedToAddSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Failed to add SMS rule: {error}'**
  String failedToAddSmsRule(Object error);

  /// No description provided for @failedToAddSmsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Failed to add SMS subscription: {error}'**
  String failedToAddSmsSubscription(Object error);

  /// No description provided for @failedToBackupSettings.
  ///
  /// In en, this message translates to:
  /// **'Failed to backup settings: {error}'**
  String failedToBackupSettings(Object error);

  /// No description provided for @failedToDecryptBackupFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to decrypt backup file'**
  String get failedToDecryptBackupFile;

  /// No description provided for @failedToDeleteDevice.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete device'**
  String get failedToDeleteDevice;

  /// No description provided for @failedToDeleteSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete SMS rule: {error}'**
  String failedToDeleteSmsRule(Object error);

  /// No description provided for @failedToExportRules.
  ///
  /// In en, this message translates to:
  /// **'Failed to export rules: {error}'**
  String failedToExportRules(Object error);

  /// No description provided for @failedToExportSmsRules.
  ///
  /// In en, this message translates to:
  /// **'Failed to export SMS rules: {error}'**
  String failedToExportSmsRules(Object error);

  /// No description provided for @failedToGetCallerIdInfo.
  ///
  /// In en, this message translates to:
  /// **'Failed to get caller ID information: {error}'**
  String failedToGetCallerIdInfo(Object error);

  /// No description provided for @failedToImportRules.
  ///
  /// In en, this message translates to:
  /// **'Failed to import rules: {error}'**
  String failedToImportRules(Object error);

  /// No description provided for @failedToImportSmsRules.
  ///
  /// In en, this message translates to:
  /// **'Failed to import SMS rules: {error}'**
  String failedToImportSmsRules(Object error);

  /// No description provided for @failedToLoadContacts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts'**
  String get failedToLoadContacts;

  /// No description provided for @failedToLoadPlugin.
  ///
  /// In en, this message translates to:
  /// **'Failed to load plugin'**
  String get failedToLoadPlugin;

  /// No description provided for @failedToRenameDevice.
  ///
  /// In en, this message translates to:
  /// **'Failed to rename device'**
  String get failedToRenameDevice;

  /// No description provided for @failedToRestoreSettings.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore settings'**
  String get failedToRestoreSettings;

  /// No description provided for @failedToRestoreSettingsWithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore settings: {error}'**
  String failedToRestoreSettingsWithError(Object error);

  /// No description provided for @failedToSetPassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to set password: {error}'**
  String failedToSetPassword(Object error);

  /// No description provided for @failedToSyncDevices.
  ///
  /// In en, this message translates to:
  /// **'Failed to sync devices'**
  String get failedToSyncDevices;

  /// No description provided for @failedToToggleRuleStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle rule status: {error}'**
  String failedToToggleRuleStatus(Object error);

  /// No description provided for @failedToToggleSubscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle subscription status'**
  String get failedToToggleSubscriptionStatus;

  /// No description provided for @failedToUpdateContact.
  ///
  /// In en, this message translates to:
  /// **'Failed to update contact'**
  String get failedToUpdateContact;

  /// No description provided for @failedToUpdateSmsRule.
  ///
  /// In en, this message translates to:
  /// **'Failed to update SMS rule: {error}'**
  String failedToUpdateSmsRule(Object error);

  /// No description provided for @failure.
  ///
  /// In en, this message translates to:
  /// **'Failure'**
  String get failure;

  /// No description provided for @favoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Favorite Contacts'**
  String get favoriteContacts;

  /// No description provided for @featureAddRules.
  ///
  /// In en, this message translates to:
  /// **'• Add phone number specific rules'**
  String get featureAddRules;

  /// No description provided for @featureCenter.
  ///
  /// In en, this message translates to:
  /// **'Feature Center'**
  String get featureCenter;

  /// No description provided for @featureEnableDisable.
  ///
  /// In en, this message translates to:
  /// **'• Enable/disable different filters per SIM'**
  String get featureEnableDisable;

  /// Title for features list section
  ///
  /// In en, this message translates to:
  /// **'Features:'**
  String get featureListTitle;

  /// No description provided for @featureManageRules.
  ///
  /// In en, this message translates to:
  /// **'• Manage rule lists per SIM'**
  String get featureManageRules;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @fetchingCallerIdInfo.
  ///
  /// In en, this message translates to:
  /// **'Fetching caller ID information...'**
  String get fetchingCallerIdInfo;

  /// No description provided for @fileSavedTo.
  ///
  /// In en, this message translates to:
  /// **'File saved to: {path}'**
  String fileSavedTo(Object path);

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filterByLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter by Label'**
  String get filterByLabel;

  /// No description provided for @filterClear.
  ///
  /// In en, this message translates to:
  /// **'Clear Filter'**
  String get filterClear;

  /// No description provided for @filterControlPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Control Panel'**
  String get filterControlPanelTitle;

  /// No description provided for @filterControlSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage on/off status of all filters'**
  String get filterControlSubtitle;

  /// No description provided for @filterControlTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Control'**
  String get filterControlTitle;

  /// No description provided for @filterDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Filter delete failed'**
  String get filterDeleteFailed;

  /// No description provided for @filterDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Filter deleted successfully'**
  String get filterDeleteSuccess;

  /// No description provided for @filterDetails.
  ///
  /// In en, this message translates to:
  /// **'Filter Details'**
  String get filterDetails;

  /// No description provided for @filtered.
  ///
  /// In en, this message translates to:
  /// **'Filtered'**
  String get filtered;

  /// No description provided for @filteredSms.
  ///
  /// In en, this message translates to:
  /// **'Filtered SMS'**
  String get filteredSms;

  /// No description provided for @filteredSmsLabel.
  ///
  /// In en, this message translates to:
  /// **'Filtered SMS'**
  String get filteredSmsLabel;

  /// No description provided for @filterExplanation.
  ///
  /// In en, this message translates to:
  /// **'Filter Explanation'**
  String get filterExplanation;

  /// No description provided for @filterManagement.
  ///
  /// In en, this message translates to:
  /// **'Filter Management'**
  String get filterManagement;

  /// No description provided for @filterName.
  ///
  /// In en, this message translates to:
  /// **'Filter Name'**
  String get filterName;

  /// No description provided for @filterPattern.
  ///
  /// In en, this message translates to:
  /// **'Filter Pattern'**
  String get filterPattern;

  /// No description provided for @filterPriorityNote.
  ///
  /// In en, this message translates to:
  /// **'Note: There are priority relationships between filters, please refer to the help documentation for details'**
  String get filterPriorityNote;

  /// No description provided for @filterSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Filter save failed'**
  String get filterSaveFailed;

  /// No description provided for @filterSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Filter saved successfully'**
  String get filterSaveSuccess;

  /// No description provided for @filterSettings.
  ///
  /// In en, this message translates to:
  /// **'Filter Settings'**
  String get filterSettings;

  /// No description provided for @filterSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Settings'**
  String get filterSettingsTitle;

  /// No description provided for @filterSMS.
  ///
  /// In en, this message translates to:
  /// **'Filter SMS'**
  String get filterSMS;

  /// No description provided for @filterToggleInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable filters for this SIM slot:'**
  String get filterToggleInstructions;

  /// Filter enable/disable status change notification
  ///
  /// In en, this message translates to:
  /// **'{status} filter: {filterName}'**
  String filterToggleStatus(Object status, Object filterName);

  /// No description provided for @filterType.
  ///
  /// In en, this message translates to:
  /// **'Filter Type'**
  String get filterType;

  /// No description provided for @financial.
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get financial;

  /// No description provided for @flexibleCombinationFeature.
  ///
  /// In en, this message translates to:
  /// **'• Flexible Combinations: Enable/disable filters per SIM slot'**
  String get flexibleCombinationFeature;

  /// No description provided for @fontSizesSetting.
  ///
  /// In en, this message translates to:
  /// **'Font Sizes'**
  String get fontSizesSetting;

  /// No description provided for @foundRules.
  ///
  /// In en, this message translates to:
  /// **'Found {count} rules'**
  String foundRules(Object count);

  /// No description provided for @foundRulesDoYouWantToImport.
  ///
  /// In en, this message translates to:
  /// **'Found {count} rules. Do you want to import them?'**
  String foundRulesDoYouWantToImport(Object count);

  /// No description provided for @foundRulesToImport.
  ///
  /// In en, this message translates to:
  /// **'Found {count} rules. Do you want to import them?'**
  String foundRulesToImport(Object count);

  /// No description provided for @fraudAlert.
  ///
  /// In en, this message translates to:
  /// **'FRAUD ALERT - Hang up the call'**
  String get fraudAlert;

  /// No description provided for @fraudScamLikely.
  ///
  /// In en, this message translates to:
  /// **'Fraud Scam Likely'**
  String get fraudScamLikely;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @functionSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Function Settings'**
  String get functionSettingsTitle;

  /// General update failure message
  ///
  /// In en, this message translates to:
  /// **'Update failed: {error}'**
  String generalUpdateFailure(Object error);

  /// No description provided for @getFree.
  ///
  /// In en, this message translates to:
  /// **'Get Free'**
  String get getFree;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @globalFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure global filters for all SIM cards:'**
  String get globalFilterDescription;

  /// No description provided for @globalFilterFeature.
  ///
  /// In en, this message translates to:
  /// **'• Global Filters: Basic rules for all incoming calls'**
  String get globalFilterFeature;

  /// Global filter settings section title
  ///
  /// In en, this message translates to:
  /// **'Global Filter Settings'**
  String get globalFilterSettings;

  /// Instructions for configuring global filter settings
  ///
  /// In en, this message translates to:
  /// **'Configure global filter settings that apply to all SIM slots:'**
  String get globalFilterToggleInstructions;

  /// No description provided for @globalSearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search contacts, labels, blacklists, whitelists, etc.'**
  String get globalSearchSubtitle;

  /// No description provided for @globalSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Global Search'**
  String get globalSearchTitle;

  /// Title for global settings page
  ///
  /// In en, this message translates to:
  /// **'Global Settings'**
  String get globalSettings;

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

  /// No description provided for @googleDriveAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Authorize using system-configured Google Drive client ID and key'**
  String get googleDriveAuthDescription;

  /// No description provided for @googleDriveAuthorizationHint.
  ///
  /// In en, this message translates to:
  /// **'Authorize using system-configured Google Drive client ID and key'**
  String get googleDriveAuthorizationHint;

  /// No description provided for @googleDriveConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive Configuration'**
  String get googleDriveConfigTitle;

  /// No description provided for @googleDriveConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'Google Drive Configuration'**
  String get googleDriveConfigurationTitle;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @granted.
  ///
  /// In en, this message translates to:
  /// **'Granted'**
  String get granted;

  /// No description provided for @grantNecessaryPermissions.
  ///
  /// In en, this message translates to:
  /// **'Grant Necessary Permissions'**
  String get grantNecessaryPermissions;

  /// No description provided for @grantPermissions.
  ///
  /// In en, this message translates to:
  /// **'Grant Permissions'**
  String get grantPermissions;

  /// No description provided for @headhunter.
  ///
  /// In en, this message translates to:
  /// **'Headhunter'**
  String get headhunter;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @homePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get homePageTitle;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

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

  /// No description provided for @howItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'How It Works:'**
  String get howItWorksTitle;

  /// No description provided for @iconCodeOptional.
  ///
  /// In en, this message translates to:
  /// **'Icon Code (Optional)'**
  String get iconCodeOptional;

  /// No description provided for @iconSize.
  ///
  /// In en, this message translates to:
  /// **'Icon Size'**
  String get iconSize;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @important.
  ///
  /// In en, this message translates to:
  /// **'Important'**
  String get important;

  /// No description provided for @importButton.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importButton;

  /// No description provided for @importConfig.
  ///
  /// In en, this message translates to:
  /// **'Import Configuration'**
  String get importConfig;

  /// No description provided for @importContacts.
  ///
  /// In en, this message translates to:
  /// **'Import Contacts'**
  String get importContacts;

  /// No description provided for @importExportContacts.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Contacts'**
  String get importExportContacts;

  /// No description provided for @importExportContactsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Contacts'**
  String get importExportContactsTooltip;

  /// No description provided for @importExportRules.
  ///
  /// In en, this message translates to:
  /// **'Import/Export Rules'**
  String get importExportRules;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(Object error);

  /// No description provided for @importFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to import configuration'**
  String get importFailure;

  /// No description provided for @importFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Import feature coming soon'**
  String get importFeatureComingSoon;

  /// No description provided for @importLabels.
  ///
  /// In en, this message translates to:
  /// **'Import Labels'**
  String get importLabels;

  /// No description provided for @importLabelsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import labels: {error}'**
  String importLabelsFailed(Object error);

  /// No description provided for @importPluginList.
  ///
  /// In en, this message translates to:
  /// **'Import Plugin List'**
  String get importPluginList;

  /// No description provided for @importPluginListFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import plugin list: {error}'**
  String importPluginListFailed(Object error);

  /// No description provided for @importPluginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully imported {count} plugins'**
  String importPluginSuccess(Object count);

  /// No description provided for @importRuleConfigurationsFromFile.
  ///
  /// In en, this message translates to:
  /// **'Import Rule Configurations from File'**
  String get importRuleConfigurationsFromFile;

  /// No description provided for @importRuleConfigurationsFromFileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import rule configurations from file'**
  String get importRuleConfigurationsFromFileSubtitle;

  /// No description provided for @importRules.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRules;

  /// No description provided for @importRulesButton.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRulesButton;

  /// No description provided for @importRulesDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRulesDialogTitle;

  /// No description provided for @importRulesError.
  ///
  /// In en, this message translates to:
  /// **'Failed to import rules: {error}'**
  String importRulesError(Object error);

  /// No description provided for @importRulesInstructions.
  ///
  /// In en, this message translates to:
  /// **'Import rules from a CSV file'**
  String get importRulesInstructions;

  /// No description provided for @importRulesSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rules imported successfully'**
  String get importRulesSuccess;

  /// No description provided for @importRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Rules'**
  String get importRulesTitle;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import successful'**
  String get importSuccess;

  /// No description provided for @incomingCallInterceptAction.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call Intercept Action'**
  String get incomingCallInterceptAction;

  /// No description provided for @incomingCallNotification.
  ///
  /// In en, this message translates to:
  /// **'Incoming Call Notification'**
  String get incomingCallNotification;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// No description provided for @initializing.
  ///
  /// In en, this message translates to:
  /// **'Initializing'**
  String get initializing;

  /// No description provided for @installed.
  ///
  /// In en, this message translates to:
  /// **'Installed'**
  String get installed;

  /// No description provided for @insufficientMarks.
  ///
  /// In en, this message translates to:
  /// **'Insufficient Marks'**
  String get insufficientMarks;

  /// No description provided for @insurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// No description provided for @interceptAction.
  ///
  /// In en, this message translates to:
  /// **'Intercept Action'**
  String get interceptAction;

  /// No description provided for @interceptionActionSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set how blocked calls are handled'**
  String get interceptionActionSettingsSubtitle;

  /// No description provided for @interceptionActionSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Interception Action Settings'**
  String get interceptionActionSettingsTitle;

  /// No description provided for @interceptionTimeInterval.
  ///
  /// In en, this message translates to:
  /// **'Interception Time Interval'**
  String get interceptionTimeInterval;

  /// No description provided for @internet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get internet;

  /// Update interval confirmation message
  ///
  /// In en, this message translates to:
  /// **'{service} update interval set to {days} days'**
  String intervalSetSuccess(Object service, Object days);

  /// No description provided for @invalidContentRegex.
  ///
  /// In en, this message translates to:
  /// **'Invalid content regex'**
  String get invalidContentRegex;

  /// No description provided for @invalidLabel.
  ///
  /// In en, this message translates to:
  /// **'Invalid label'**
  String get invalidLabel;

  /// No description provided for @invalidRegexPattern.
  ///
  /// In en, this message translates to:
  /// **'Invalid regex pattern'**
  String get invalidRegexPattern;

  /// No description provided for @invalidSenderRegex.
  ///
  /// In en, this message translates to:
  /// **'Invalid sender regex'**
  String get invalidSenderRegex;

  /// No description provided for @joinTheTelegramChannelAndGroupForMoreInfo.
  ///
  /// In en, this message translates to:
  /// **'Join the Telegram Channel and Group for More Info'**
  String get joinTheTelegramChannelAndGroupForMoreInfo;

  /// No description provided for @jsLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'JS Logs'**
  String get jsLogsTitle;

  /// No description provided for @jsonFormat.
  ///
  /// In en, this message translates to:
  /// **'JSON Format'**
  String get jsonFormat;

  /// No description provided for @keepAllVersions.
  ///
  /// In en, this message translates to:
  /// **'Keep All Versions'**
  String get keepAllVersions;

  /// No description provided for @keepAllVersionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep all historical versions of each backup'**
  String get keepAllVersionsDescription;

  /// No description provided for @keepAllVersionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Keep All Versions'**
  String get keepAllVersionsLabel;

  /// No description provided for @keepAllVersionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep historical versions of each backup'**
  String get keepAllVersionsSubtitle;

  /// No description provided for @keepAllVersionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep All Versions'**
  String get keepAllVersionsTitle;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @labelAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Label \"{name}\" added successfully'**
  String labelAddedSuccessfully(Object name);

  /// No description provided for @labelCategories.
  ///
  /// In en, this message translates to:
  /// **'Label Categories'**
  String get labelCategories;

  /// No description provided for @labelDeleted.
  ///
  /// In en, this message translates to:
  /// **'Label deleted'**
  String get labelDeleted;

  /// No description provided for @labelDescription.
  ///
  /// In en, this message translates to:
  /// **'Labels help you better manage contacts, add custom labels to phone numbers for easy identification of calls and messages.'**
  String get labelDescription;

  /// No description provided for @labelFilter.
  ///
  /// In en, this message translates to:
  /// **'Label Filter'**
  String get labelFilter;

  /// No description provided for @labelFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Label Filter'**
  String get labelFilterTooltip;

  /// No description provided for @labelIconColor.
  ///
  /// In en, this message translates to:
  /// **'Label Icon Color'**
  String get labelIconColor;

  /// No description provided for @labelManagement.
  ///
  /// In en, this message translates to:
  /// **'Label Management'**
  String get labelManagement;

  /// No description provided for @labelNotFound.
  ///
  /// In en, this message translates to:
  /// **'Label not found'**
  String get labelNotFound;

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

  /// No description provided for @labels.
  ///
  /// In en, this message translates to:
  /// **'Labels'**
  String get labels;

  /// No description provided for @labelsColor.
  ///
  /// In en, this message translates to:
  /// **'Labels Color'**
  String get labelsColor;

  /// No description provided for @labelsDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count} labels deleted'**
  String labelsDeleted(Object count);

  /// No description provided for @labelsExportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Labels exported successfully'**
  String get labelsExportedSuccessfully;

  /// No description provided for @labelsFontSize.
  ///
  /// In en, this message translates to:
  /// **'Labels Font Size'**
  String get labelsFontSize;

  /// No description provided for @labelsImportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully imported {count} labels'**
  String labelsImportedSuccessfully(Object count);

  /// No description provided for @labelsPosition.
  ///
  /// In en, this message translates to:
  /// **'Labels Position'**
  String get labelsPosition;

  /// No description provided for @labelTag.
  ///
  /// In en, this message translates to:
  /// **'Label: {labelId}'**
  String labelTag(Object labelId);

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

  /// No description provided for @labelUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Label \"\$labelText\" updated successfully'**
  String get labelUpdateSuccess;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @languageSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change application display language'**
  String get languageSettingsSubtitle;

  /// No description provided for @languageSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettingsTitle;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get last30Days;

  /// No description provided for @last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days'**
  String get last7Days;

  /// No description provided for @lastSyncLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Sync'**
  String get lastSyncLabel;

  /// Last updated label
  ///
  /// In en, this message translates to:
  /// **'Last updated: {date}'**
  String lastUpdated(Object date);

  /// No description provided for @lifetimeMembership.
  ///
  /// In en, this message translates to:
  /// **'Lifetime Membership'**
  String get lifetimeMembership;

  /// No description provided for @lifetimeMembershipDescription.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase, permanently unlock all premium features and future updates'**
  String get lifetimeMembershipDescription;

  /// No description provided for @loadContactsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load contacts: {error}'**
  String loadContactsFailed(Object error);

  /// No description provided for @loadDataFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get loadDataFailed;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load Failed'**
  String get loadFailed;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading Data...'**
  String get loadingData;

  /// No description provided for @loadingTags.
  ///
  /// In en, this message translates to:
  /// **'Loading tags...'**
  String get loadingTags;

  /// No description provided for @loadLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load labels: {error}'**
  String loadLabelFailed(Object error);

  /// No description provided for @loadLabelsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load labels: {error}'**
  String loadLabelsFailed(Object error);

  /// No description provided for @loadMarkCountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load marked phone numbers: {error}'**
  String loadMarkCountFailed(Object error);

  /// No description provided for @loadMarkedPhonesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load marked phones: {error}'**
  String loadMarkedPhonesFailed(Object error);

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get loadMore;

  /// No description provided for @loadPluginButton.
  ///
  /// In en, this message translates to:
  /// **'Load Plugin'**
  String get loadPluginButton;

  /// No description provided for @loadPluginsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load plugins: {error}'**
  String loadPluginsFailed(Object error);

  /// No description provided for @loadSettingsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load settings: {error}'**
  String loadSettingsFailed(Object error);

  /// No description provided for @loadSmsRulesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SMS rules: {error}'**
  String loadSmsRulesFailed(Object error);

  /// No description provided for @loadStatusFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to load status'**
  String get loadStatusFailedMessage;

  /// Failed to load subscriptions error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String loadSubscriptionsFailed(Object error);

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// No description provided for @localBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Local Backup'**
  String get localBackupTitle;

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

  /// No description provided for @localCountFilter.
  ///
  /// In en, this message translates to:
  /// **'Local Count Filter'**
  String get localCountFilter;

  /// No description provided for @localCountFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Intercept frequent calls based on local number counts'**
  String get localCountFilterDescription;

  /// No description provided for @localCountFilterExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'The local count filter analyzes call history records to automatically identify and block frequent spam calls.'**
  String get localCountFilterExplanationContent;

  /// No description provided for @localCountFilterExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Local Count Filter Explanation'**
  String get localCountFilterExplanationTitle;

  /// No description provided for @localCountFilterHowItWorksPoint1.
  ///
  /// In en, this message translates to:
  /// **'• Determine whether to block based on the number\'s count value'**
  String get localCountFilterHowItWorksPoint1;

  /// No description provided for @localCountFilterHowItWorksPoint2.
  ///
  /// In en, this message translates to:
  /// **'• When a number\'s count exceeds the set threshold, you can choose to automatically block it'**
  String get localCountFilterHowItWorksPoint2;

  /// No description provided for @localCountFilterHowItWorksPoint3.
  ///
  /// In en, this message translates to:
  /// **'• You can selectively allow numbers that don\'t exceed the threshold'**
  String get localCountFilterHowItWorksPoint3;

  /// No description provided for @localCountFilterHowItWorksPoint4.
  ///
  /// In en, this message translates to:
  /// **'• You can choose whether to record all query logs'**
  String get localCountFilterHowItWorksPoint4;

  /// No description provided for @localCountFiltering.
  ///
  /// In en, this message translates to:
  /// **'Local Count Filtering'**
  String get localCountFiltering;

  /// No description provided for @localCountFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Local Count Filtering: Filtering rules based on local marking count'**
  String get localCountFilteringExplanation;

  /// No description provided for @localCountFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'Local Count Filter Settings'**
  String get localCountFilterSettings;

  /// No description provided for @localCountFilterUseCases.
  ///
  /// In en, this message translates to:
  /// **'This filter is particularly suitable for identifying auto-dialed spam calls and marketing calls.'**
  String get localCountFilterUseCases;

  /// Title for local filter settings page
  ///
  /// In en, this message translates to:
  /// **'Local Filter Settings'**
  String get localFilterSettings;

  /// No description provided for @localNotificationDisabled.
  ///
  /// In en, this message translates to:
  /// **'Local notification disabled'**
  String get localNotificationDisabled;

  /// No description provided for @localNotificationEnabled.
  ///
  /// In en, this message translates to:
  /// **'Local notification enabled'**
  String get localNotificationEnabled;

  /// No description provided for @localServices.
  ///
  /// In en, this message translates to:
  /// **'Local Services'**
  String get localServices;

  /// No description provided for @locationColor.
  ///
  /// In en, this message translates to:
  /// **'Location Color'**
  String get locationColor;

  /// No description provided for @locationFontSize.
  ///
  /// In en, this message translates to:
  /// **'Location Font Size'**
  String get locationFontSize;

  /// No description provided for @locationIconColor.
  ///
  /// In en, this message translates to:
  /// **'Location Icon Color'**
  String get locationIconColor;

  /// No description provided for @locationPosition.
  ///
  /// In en, this message translates to:
  /// **'Location Position'**
  String get locationPosition;

  /// No description provided for @logAllLocalQueries.
  ///
  /// In en, this message translates to:
  /// **'Log All Local Queries'**
  String get logAllLocalQueries;

  /// No description provided for @logAllLocalQueriesDescription.
  ///
  /// In en, this message translates to:
  /// **'Record logs for all local number queries'**
  String get logAllLocalQueriesDescription;

  /// No description provided for @logAllRemoteQueries.
  ///
  /// In en, this message translates to:
  /// **'Log All Remote Queries'**
  String get logAllRemoteQueries;

  /// No description provided for @logAllRemoteQueriesDescription.
  ///
  /// In en, this message translates to:
  /// **'Record all remote number query operations'**
  String get logAllRemoteQueriesDescription;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage Contacts'**
  String get manage;

  /// No description provided for @manageContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manageContacts;

  /// No description provided for @manageFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage Favorite Contacts'**
  String get manageFavoriteContacts;

  /// No description provided for @manageFilterRules.
  ///
  /// In en, this message translates to:
  /// **'Manage Filter Rules'**
  String get manageFilterRules;

  /// No description provided for @manageFilterRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Add, edit, or delete SMS filter rules'**
  String get manageFilterRulesDescription;

  /// No description provided for @manageFrequentContacts.
  ///
  /// In en, this message translates to:
  /// **'Manage Frequent Contacts'**
  String get manageFrequentContacts;

  /// No description provided for @markCounts.
  ///
  /// In en, this message translates to:
  /// **'Mark Counts'**
  String get markCounts;

  /// No description provided for @markCount.
  ///
  /// In en, this message translates to:
  /// **'Mark Count'**
  String get markCount;

  /// Text showing how many users have marked this number
  ///
  /// In en, this message translates to:
  /// **'Marked by {count}'**
  String markedByCount(Object count);

  /// No description provided for @markedPhonesList.
  ///
  /// In en, this message translates to:
  /// **'Marked Phone Numbers'**
  String get markedPhonesList;

  /// No description provided for @markExchange.
  ///
  /// In en, this message translates to:
  /// **'Mark Exchange'**
  String get markExchange;

  /// No description provided for @markPhone.
  ///
  /// In en, this message translates to:
  /// **'Mark Phone Number'**
  String get markPhone;

  /// No description provided for @markPhoneFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to mark phone number: {error}'**
  String markPhoneFailed(Object error);

  /// No description provided for @markPhoneManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To Mark Phone Numbers'**
  String get markPhoneManagementSubtitle;

  /// No description provided for @markPhoneManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark Phone Management'**
  String get markPhoneManagementTitle;

  /// No description provided for @markPhoneSuccess.
  ///
  /// In en, this message translates to:
  /// **'Phone number marked successfully'**
  String get markPhoneSuccess;

  /// No description provided for @matchFailed.
  ///
  /// In en, this message translates to:
  /// **'Match failed!'**
  String get matchFailed;

  /// No description provided for @matchFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Match failed.'**
  String get matchFailedMessage;

  /// No description provided for @matchNumbersWithSpecialCharacters.
  ///
  /// In en, this message translates to:
  /// **'matches specific number format'**
  String get matchNumbersWithSpecialCharacters;

  /// No description provided for @matchNumbersWithSpecialCharactersTitle.
  ///
  /// In en, this message translates to:
  /// **'Match numbers with special characters:'**
  String get matchNumbersWithSpecialCharactersTitle;

  /// No description provided for @matchSpecificDigitPatterns.
  ///
  /// In en, this message translates to:
  /// **'matches XXX-XXXX-XXXX format'**
  String get matchSpecificDigitPatterns;

  /// No description provided for @matchSpecificDigitPatternsTitle.
  ///
  /// In en, this message translates to:
  /// **'Match specific digit patterns:'**
  String get matchSpecificDigitPatternsTitle;

  /// No description provided for @matchSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Match successful!'**
  String get matchSuccessful;

  /// No description provided for @matchSuccessfulMessage.
  ///
  /// In en, this message translates to:
  /// **'Match successful!'**
  String get matchSuccessfulMessage;

  /// No description provided for @medical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get medical;

  /// No description provided for @membershipPrivileges.
  ///
  /// In en, this message translates to:
  /// **'Membership Privileges'**
  String get membershipPrivileges;

  /// No description provided for @migrationTool.
  ///
  /// In en, this message translates to:
  /// **'Migration Tool'**
  String get migrationTool;

  /// No description provided for @migrationToolTitle.
  ///
  /// In en, this message translates to:
  /// **'Migration Tool'**
  String get migrationToolTitle;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @monthlyCallCount.
  ///
  /// In en, this message translates to:
  /// **'Monthly Calls'**
  String get monthlyCallCount;

  /// No description provided for @monthlyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Blocked Calls'**
  String get monthlyChartTitle;

  /// No description provided for @monthlyMembership.
  ///
  /// In en, this message translates to:
  /// **'Monthly Membership'**
  String get monthlyMembership;

  /// No description provided for @monthlyMembershipDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock all premium features, auto-renew monthly'**
  String get monthlyMembershipDescription;

  /// No description provided for @monthlyTotal.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get monthlyTotal;

  /// No description provided for @monthlyTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get monthlyTotalLabel;

  /// No description provided for @moreOptions.
  ///
  /// In en, this message translates to:
  /// **'More Options'**
  String get moreOptions;

  /// No description provided for @mute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get mute;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameAndPhoneNumberCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name and phone number cannot be empty'**
  String get nameAndPhoneNumberCannotBeEmpty;

  /// No description provided for @nameAndPhoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Name and phone number cannot be empty'**
  String get nameAndPhoneNumberRequired;

  /// No description provided for @nameColor.
  ///
  /// In en, this message translates to:
  /// **'Name Color'**
  String get nameColor;

  /// No description provided for @nameFontSize.
  ///
  /// In en, this message translates to:
  /// **'Name Font Size'**
  String get nameFontSize;

  /// Caller ID name label
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String nameLabel(Object name);

  /// No description provided for @namePosition.
  ///
  /// In en, this message translates to:
  /// **'Name Position'**
  String get namePosition;

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

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextStep;

  /// No description provided for @noAction.
  ///
  /// In en, this message translates to:
  /// **'No Action'**
  String get noAction;

  /// No description provided for @noActionRules.
  ///
  /// In en, this message translates to:
  /// **'No Action Rules'**
  String get noActionRules;

  /// No description provided for @noActiveCloudSyncServiceMessage.
  ///
  /// In en, this message translates to:
  /// **'No active cloud sync service'**
  String get noActiveCloudSyncServiceMessage;

  /// No description provided for @noCallLogs.
  ///
  /// In en, this message translates to:
  /// **'No Call Logs'**
  String get noCallLogs;

  /// No description provided for @noCallRecords.
  ///
  /// In en, this message translates to:
  /// **'No call records'**
  String get noCallRecords;

  /// No description provided for @noContacts.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get noContacts;

  /// No description provided for @noContactsYet.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get noContactsYet;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @noDevicesRegisteredMessage.
  ///
  /// In en, this message translates to:
  /// **'No devices registered'**
  String get noDevicesRegisteredMessage;

  /// No description provided for @noDevicesRegisteredYet.
  ///
  /// In en, this message translates to:
  /// **'No devices registered yet.'**
  String get noDevicesRegisteredYet;

  /// No description provided for @noFilters.
  ///
  /// In en, this message translates to:
  /// **'No filters yet'**
  String get noFilters;

  /// No description provided for @noLabels.
  ///
  /// In en, this message translates to:
  /// **'No labels yet'**
  String get noLabels;

  /// No description provided for @noMarkedPhones.
  ///
  /// In en, this message translates to:
  /// **'No marked phone numbers'**
  String get noMarkedPhones;

  /// No description provided for @noMatchingContacts.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts'**
  String get noMatchingContacts;

  /// No description provided for @noMatchingContactsFound.
  ///
  /// In en, this message translates to:
  /// **'No matching contacts found'**
  String get noMatchingContactsFound;

  /// No description provided for @noMatchingNumbersFound.
  ///
  /// In en, this message translates to:
  /// **'No matching numbers found'**
  String get noMatchingNumbersFound;

  /// No description provided for @noMatchingRecords.
  ///
  /// In en, this message translates to:
  /// **'No matching call records'**
  String get noMatchingRecords;

  /// No description provided for @noMatchingRules.
  ///
  /// In en, this message translates to:
  /// **'No matching {ruleType}'**
  String noMatchingRules(Object ruleType);

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @noneServiceType.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noneServiceType;

  /// No description provided for @noPlugins.
  ///
  /// In en, this message translates to:
  /// **'No plugins yet'**
  String get noPlugins;

  /// No description provided for @noRecords.
  ///
  /// In en, this message translates to:
  /// **'No call records'**
  String get noRecords;

  /// No description provided for @noResultReturned.
  ///
  /// In en, this message translates to:
  /// **'No result returned'**
  String get noResultReturned;

  /// No description provided for @noResultReturnedLog.
  ///
  /// In en, this message translates to:
  /// **'No result returned from plugin'**
  String get noResultReturnedLog;

  /// No description provided for @noRules.
  ///
  /// In en, this message translates to:
  /// **'No {ruleType} yet'**
  String noRules(Object ruleType);

  /// No description provided for @noRulesPrompt.
  ///
  /// In en, this message translates to:
  /// **'No rules found, please add rules'**
  String get noRulesPrompt;

  /// No description provided for @noRulesToExport.
  ///
  /// In en, this message translates to:
  /// **'No rules to export'**
  String get noRulesToExport;

  /// No description provided for @noSmsFilterRulesYet.
  ///
  /// In en, this message translates to:
  /// **'No SMS filter rules yet'**
  String get noSmsFilterRulesYet;

  /// No description provided for @noSmsRulesYet.
  ///
  /// In en, this message translates to:
  /// **'No SMS rules yet'**
  String get noSmsRulesYet;

  /// No subscriptions message
  ///
  /// In en, this message translates to:
  /// **'No subscriptions'**
  String get noSubscriptions;

  /// No description provided for @noSubscriptionsYet.
  ///
  /// In en, this message translates to:
  /// **'No Subscriptions Yet'**
  String get noSubscriptionsYet;

  /// No description provided for @notGranted.
  ///
  /// In en, this message translates to:
  /// **'Not Granted'**
  String get notGranted;

  /// Title for the mode selection part (Immediate, Batched, Custom)
  ///
  /// In en, this message translates to:
  /// **'Notification Mode'**
  String get notificationMode;

  /// No description provided for @notificationModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Show caller information in the notification bar'**
  String get notificationModeDescription;

  /// No description provided for @notificationPermission.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get notificationPermission;

  /// No description provided for @notificationPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to display incoming call and message notifications.'**
  String get notificationPermissionDescription;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Notification settings title
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @notificationSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Notification settings saved successfully'**
  String get notificationSettingsSaved;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get notSet;

  /// No description provided for @notVerifiedText.
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get notVerifiedText;

  /// No description provided for @noValidSmsRulesFoundInFile.
  ///
  /// In en, this message translates to:
  /// **'No valid SMS rules found in file'**
  String get noValidSmsRulesFoundInFile;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @numberColor.
  ///
  /// In en, this message translates to:
  /// **'Number Color'**
  String get numberColor;

  /// No description provided for @numberFontSize.
  ///
  /// In en, this message translates to:
  /// **'Number Font Size'**
  String get numberFontSize;

  /// No description provided for @numberPosition.
  ///
  /// In en, this message translates to:
  /// **'Number Position'**
  String get numberPosition;

  /// No description provided for @numberSearch.
  ///
  /// In en, this message translates to:
  /// **'Number Search'**
  String get numberSearch;

  /// No description provided for @numberTypeColor.
  ///
  /// In en, this message translates to:
  /// **'Number Type Color'**
  String get numberTypeColor;

  /// No description provided for @numberTypeFontSize.
  ///
  /// In en, this message translates to:
  /// **'Number Type Font Size'**
  String get numberTypeFontSize;

  /// No description provided for @numberTypePosition.
  ///
  /// In en, this message translates to:
  /// **'Number Type Position'**
  String get numberTypePosition;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @onboardingCompleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Your call security manager is ready, start enjoying a secure call experience!'**
  String get onboardingCompleteDescription;

  /// No description provided for @onboardingLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language for the best experience.'**
  String get onboardingLanguageDescription;

  /// No description provided for @onboardingPermissionsDescription.
  ///
  /// In en, this message translates to:
  /// **'To provide full service, we need the following permissions:'**
  String get onboardingPermissionsDescription;

  /// No description provided for @onboardingPowerfulSpamBlockingDescription.
  ///
  /// In en, this message translates to:
  /// **'One-click blocking of spam calls and messages, customize blocking rules, and give you a quiet environment.'**
  String get onboardingPowerfulSpamBlockingDescription;

  /// No description provided for @onboardingSmartCallerIdDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically identify unknown calls, mark suspicious numbers, and protect your call safety.'**
  String get onboardingSmartCallerIdDescription;

  /// No description provided for @onboardingWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your call management expert, providing comprehensive call identification and blocking services.'**
  String get onboardingWelcomeDescription;

  /// No description provided for @oneDriveAuthDescription.
  ///
  /// In en, this message translates to:
  /// **'Authorize using system-configured OneDrive client ID and key'**
  String get oneDriveAuthDescription;

  /// No description provided for @oneDriveAuthorizationHint.
  ///
  /// In en, this message translates to:
  /// **'Authorize using system-configured OneDrive client ID and key'**
  String get oneDriveAuthorizationHint;

  /// No description provided for @oneDriveConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'OneDrive Configuration'**
  String get oneDriveConfigTitle;

  /// No description provided for @oneDriveConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'OneDrive Configuration'**
  String get oneDriveConfigurationTitle;

  /// No description provided for @onlineCallerIdSubscription.
  ///
  /// In en, this message translates to:
  /// **'Online Caller ID Subscription'**
  String get onlineCallerIdSubscription;

  /// No description provided for @openAppSettings.
  ///
  /// In en, this message translates to:
  /// **'Open app settings'**
  String get openAppSettings;

  /// No description provided for @openAppSettingsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to open app settings: {error}'**
  String openAppSettingsFailed(Object error);

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String operationFailed(Object error);

  /// No description provided for @operationFailure.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailure;

  /// No description provided for @operationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Operation succeeded'**
  String get operationSuccess;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @ourOtherApps.
  ///
  /// In en, this message translates to:
  /// **'Our Other Apps'**
  String get ourOtherApps;

  /// No description provided for @overlayMode.
  ///
  /// In en, this message translates to:
  /// **'Floating Window'**
  String get overlayMode;

  /// No description provided for @overlayModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Show caller information in a floating window'**
  String get overlayModeDescription;

  /// No description provided for @overlayPermission.
  ///
  /// In en, this message translates to:
  /// **'Overlay Permission'**
  String get overlayPermission;

  /// No description provided for @overlayPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to display incoming call overlay.'**
  String get overlayPermissionDescription;

  /// Overview label
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordCannotBeEmpty;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordSetSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password set successfully'**
  String get passwordSetSuccessfully;

  /// No description provided for @pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get pattern;

  /// No description provided for @pendingSync.
  ///
  /// In en, this message translates to:
  /// **'Pending Sync'**
  String get pendingSync;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission request denied'**
  String get permissionDenied;

  /// No description provided for @permissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission granted'**
  String get permissionGranted;

  /// No description provided for @permissionManagement.
  ///
  /// In en, this message translates to:
  /// **'Permission Management'**
  String get permissionManagement;

  /// No description provided for @phoneCallsTab.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneCallsTab;

  /// Phone number label
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Phone number cannot be empty'**
  String get phoneNumberCannotBeEmpty;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneNumberHint;

  /// No description provided for @phoneNumberHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number to add rule'**
  String get phoneNumberHintText;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberRegexRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter both phone number and regex pattern'**
  String get phoneNumberRegexRequired;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberTypeFixedLine.
  ///
  /// In en, this message translates to:
  /// **'Fixed line'**
  String get phoneNumberTypeFixedLine;

  /// No description provided for @phoneNumberTypeFixedLineOrMobile.
  ///
  /// In en, this message translates to:
  /// **'Fixed line or mobile'**
  String get phoneNumberTypeFixedLineOrMobile;

  /// No description provided for @phoneNumberTypeMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get phoneNumberTypeMobile;

  /// No description provided for @phoneNumberTypePager.
  ///
  /// In en, this message translates to:
  /// **'Pager'**
  String get phoneNumberTypePager;

  /// No description provided for @phoneNumberTypePersonalNumber.
  ///
  /// In en, this message translates to:
  /// **'Personal number'**
  String get phoneNumberTypePersonalNumber;

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

  /// No description provided for @phoneNumberTypeTollFree.
  ///
  /// In en, this message translates to:
  /// **'Toll free'**
  String get phoneNumberTypeTollFree;

  /// No description provided for @phoneNumberTypeUan.
  ///
  /// In en, this message translates to:
  /// **'UAN'**
  String get phoneNumberTypeUan;

  /// No description provided for @phoneNumberTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get phoneNumberTypeUnknown;

  /// No description provided for @phoneNumberTypeVoicemail.
  ///
  /// In en, this message translates to:
  /// **'Voicemail'**
  String get phoneNumberTypeVoicemail;

  /// No description provided for @phoneNumberTypeVoip.
  ///
  /// In en, this message translates to:
  /// **'VoIP'**
  String get phoneNumberTypeVoip;

  /// No description provided for @phonePermission.
  ///
  /// In en, this message translates to:
  /// **'Phone Permission'**
  String get phonePermission;

  /// No description provided for @phonePermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to identify and block incoming calls.'**
  String get phonePermissionDescription;

  /// No description provided for @phoneRule.
  ///
  /// In en, this message translates to:
  /// **'Phone Rule'**
  String get phoneRule;

  /// No description provided for @phoneRuleEditDialog.
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Edit Dialog'**
  String get phoneRuleEditDialog;

  /// No description provided for @phoneRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Management'**
  String get phoneRuleManagement;

  /// No description provided for @phoneRuleSubscription.
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Subscription'**
  String get phoneRuleSubscription;

  /// No description provided for @phoneSubscription.
  ///
  /// In en, this message translates to:
  /// **'Phone Subscription'**
  String get phoneSubscription;

  /// No description provided for @phoneSubscriptionRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to phone rule lists via URL to automatically update whitelist and blacklist rules. Supports JSON format rule files.'**
  String get phoneSubscriptionRulesDescription;

  /// Phone subscription page title
  ///
  /// In en, this message translates to:
  /// **'Phone Rule Subscriptions'**
  String get phoneSubscriptionTitle;

  /// No description provided for @pleaseSelectLabelAndEnterValidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please select a label and enter a valid phone number'**
  String get pleaseSelectLabelAndEnterValidPhone;

  /// No description provided for @pluginAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plugin \"{name}\" added successfully'**
  String pluginAddedSuccess(Object name);

  /// No description provided for @pluginDeleted.
  ///
  /// In en, this message translates to:
  /// **'Plugin deleted'**
  String get pluginDeleted;

  /// No description provided for @pluginLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'Plugin is already the latest version'**
  String get pluginLatestVersion;

  /// No description provided for @pluginListExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plugin list exported successfully'**
  String get pluginListExportSuccess;

  /// No description provided for @pluginLoadedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Plugin loaded successfully'**
  String get pluginLoadedSuccessfully;

  /// No description provided for @pluginManagement.
  ///
  /// In en, this message translates to:
  /// **'Plugin Management'**
  String get pluginManagement;

  /// No description provided for @pluginManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage and configure third-party plugins'**
  String get pluginManagementSubtitle;

  /// No description provided for @pluginManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Plugin Management'**
  String get pluginManagementTitle;

  /// No description provided for @pluginName.
  ///
  /// In en, this message translates to:
  /// **'Plugin Name'**
  String get pluginName;

  /// No description provided for @pluginNotLoaded.
  ///
  /// In en, this message translates to:
  /// **'Plugin is not loaded yet. Please load the plugin first.'**
  String get pluginNotLoaded;

  /// No description provided for @pluginsDeleted.
  ///
  /// In en, this message translates to:
  /// **'{count} plugins deleted successfully.'**
  String pluginsDeleted(Object count);

  /// No description provided for @pluginService.
  ///
  /// In en, this message translates to:
  /// **'Plugin Service'**
  String get pluginService;

  /// No description provided for @pluginTestPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Plugin Test'**
  String get pluginTestPageTitle;

  /// No description provided for @pluginUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plugin updated successfully'**
  String get pluginUpdateSuccess;

  /// No description provided for @pluginUrl.
  ///
  /// In en, this message translates to:
  /// **'Plugin URL'**
  String get pluginUrl;

  /// No description provided for @pluginUrlCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Plugin URL cannot be empty'**
  String get pluginUrlCannotBeEmpty;

  /// No description provided for @pluginUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Enter plugin URL'**
  String get pluginUrlHint;

  /// No description provided for @pluginUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Plugin URL'**
  String get pluginUrlLabel;

  /// No description provided for @pluginVersion.
  ///
  /// In en, this message translates to:
  /// **'Plugin Version'**
  String get pluginVersion;

  /// No description provided for @political.
  ///
  /// In en, this message translates to:
  /// **'Political'**
  String get political;

  /// No description provided for @powerfulSpamBlocking.
  ///
  /// In en, this message translates to:
  /// **'Powerful Spam Blocking'**
  String get powerfulSpamBlocking;

  /// No description provided for @previousStep.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousStep;

  /// No description provided for @prioritizeRemoteAction.
  ///
  /// In en, this message translates to:
  /// **'Prioritize Remote Action Settings'**
  String get prioritizeRemoteAction;

  /// No description provided for @prioritizeRemoteActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Prioritize action settings from the remote database'**
  String get prioritizeRemoteActionDescription;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @processingOperation.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processingOperation;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchase;

  /// No description provided for @quarterlyMembership.
  ///
  /// In en, this message translates to:
  /// **'Quarterly Membership'**
  String get quarterlyMembership;

  /// No description provided for @quarterlyMembershipDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock all premium features, auto-renew quarterly'**
  String get quarterlyMembershipDescription;

  /// No description provided for @queryButton.
  ///
  /// In en, this message translates to:
  /// **'Query'**
  String get queryButton;

  /// No description provided for @queryFailed.
  ///
  /// In en, this message translates to:
  /// **'Query failed'**
  String get queryFailed;

  /// No description provided for @queryFailedLog.
  ///
  /// In en, this message translates to:
  /// **'Query failed'**
  String get queryFailedLog;

  /// No description provided for @querying.
  ///
  /// In en, this message translates to:
  /// **'Querying...'**
  String get querying;

  /// No description provided for @queryingPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Querying phone number'**
  String get queryingPhoneNumber;

  /// No description provided for @queryResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Query Result'**
  String get queryResultTitle;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready!'**
  String get ready;

  /// No description provided for @receiveWeeklyStatistics.
  ///
  /// In en, this message translates to:
  /// **'Receive weekly statistics'**
  String get receiveWeeklyStatistics;

  /// No description provided for @recruiter.
  ///
  /// In en, this message translates to:
  /// **'Recruiter'**
  String get recruiter;

  /// No description provided for @reEnterPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please re-enter password'**
  String get reEnterPasswordHint;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @refreshPermissionStatus.
  ///
  /// In en, this message translates to:
  /// **'Refresh permission status'**
  String get refreshPermissionStatus;

  /// No description provided for @refreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refreshTooltip;

  /// No description provided for @regexError.
  ///
  /// In en, this message translates to:
  /// **'Regex error: {error}'**
  String regexError(Object error);

  /// No description provided for @regexErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Regex error: {error}'**
  String regexErrorMessage(Object error);

  /// No description provided for @regexPattern.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern'**
  String get regexPattern;

  /// No description provided for @regexPatternExplanation.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern Explanation'**
  String get regexPatternExplanation;

  /// No description provided for @regexPatternExplanationButton.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern Explanation'**
  String get regexPatternExplanationButton;

  /// No description provided for @regexPatternLabel.
  ///
  /// In en, this message translates to:
  /// **'Regex Pattern'**
  String get regexPatternLabel;

  /// No description provided for @regexPatternsExamples.
  ///
  /// In en, this message translates to:
  /// **'Use standard regex syntax to define patterns. Examples:'**
  String get regexPatternsExamples;

  /// No description provided for @regexPatternsForPhoneNumberMatching.
  ///
  /// In en, this message translates to:
  /// **'Regex Patterns for Phone Number Matching'**
  String get regexPatternsForPhoneNumberMatching;

  /// No description provided for @regexRule.
  ///
  /// In en, this message translates to:
  /// **'Regex Rule'**
  String get regexRule;

  /// No description provided for @regexRuleAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to add regex rule: {error}'**
  String regexRuleAddFailed(Object error);

  /// No description provided for @regexRuleAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'Regex rule added successfully'**
  String get regexRuleAddSuccess;

  /// No description provided for @regexRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'Regex Rule Management'**
  String get regexRuleManagement;

  /// No description provided for @regexRuleNamePatternRequired.
  ///
  /// In en, this message translates to:
  /// **'Rule name and regex pattern cannot be empty'**
  String get regexRuleNamePatternRequired;

  /// No description provided for @regexRules.
  ///
  /// In en, this message translates to:
  /// **'Regex Rules'**
  String get regexRules;

  /// No description provided for @regexTesterTitle.
  ///
  /// In en, this message translates to:
  /// **'Regex Tester'**
  String get regexTesterTitle;

  /// No description provided for @regexValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Regex validation failed: {error}'**
  String regexValidationFailed(Object error);

  /// No description provided for @regexValidationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Regex validation successful'**
  String get regexValidationSuccess;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @registeredDevicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Registered Devices'**
  String get registeredDevicesTitle;

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

  /// No description provided for @rejectExceededNumbers.
  ///
  /// In en, this message translates to:
  /// **'Reject Exceeded Numbers'**
  String get rejectExceededNumbers;

  /// No description provided for @rejectExceededNumbersDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically reject numbers exceeding the count threshold'**
  String get rejectExceededNumbersDescription;

  /// Title for remote filter settings page
  ///
  /// In en, this message translates to:
  /// **'Remote Filter Settings'**
  String get remoteFilterSettings;

  /// No description provided for @remoteFilterSettingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filter Settings'**
  String get remoteFilterSettingsPageTitle;

  /// No description provided for @remoteNumberFilter.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filter'**
  String get remoteNumberFilter;

  /// No description provided for @remoteNumberFilterDatabaseInfo.
  ///
  /// In en, this message translates to:
  /// **'This filter uses an independent remote database to get the latest number information.'**
  String get remoteNumberFilterDatabaseInfo;

  /// No description provided for @remoteNumberFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Intercept harassing calls based on remote database information'**
  String get remoteNumberFilterDescription;

  /// No description provided for @remoteNumberFilterExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'The remote number filter identifies and blocks spam calls by querying a remote database based on number count.'**
  String get remoteNumberFilterExplanationContent;

  /// No description provided for @remoteNumberFilterExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filter Explanation'**
  String get remoteNumberFilterExplanationTitle;

  /// No description provided for @remoteNumberFilterFeatureCountThreshold.
  ///
  /// In en, this message translates to:
  /// **'• Count Threshold: Determine based on number occurrence frequency'**
  String get remoteNumberFilterFeatureCountThreshold;

  /// No description provided for @remoteNumberFilterFeatureFilterAction.
  ///
  /// In en, this message translates to:
  /// **'• Filter Actions: Configure how to handle numbers exceeding threshold'**
  String get remoteNumberFilterFeatureFilterAction;

  /// No description provided for @remoteNumberFilterFeaturePriority.
  ///
  /// In en, this message translates to:
  /// **'• Priority Settings: Set priority for remote actions'**
  String get remoteNumberFilterFeaturePriority;

  /// No description provided for @remoteNumberFilterFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features:'**
  String get remoteNumberFilterFeatures;

  /// No description provided for @remoteNumberFiltering.
  ///
  /// In en, this message translates to:
  /// **'Remote Number Filtering'**
  String get remoteNumberFiltering;

  /// No description provided for @remoteNumberFilteringExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Remote Number Filtering: Filtering rules based on remote database information'**
  String get remoteNumberFilteringExplanation;

  /// No description provided for @remoteNumberFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Identify spam calls using cloud database and community reports'**
  String get remoteNumberFilterSubtitle;

  /// No description provided for @removeAdsDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove all ads in the app for a smoother experience'**
  String get removeAdsDescription;

  /// No description provided for @removeAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAdsTitle;

  /// No description provided for @removedFromFavoriteContacts.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorite contacts'**
  String get removedFromFavoriteContacts;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorite contacts'**
  String get removedFromFavorites;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove Favorite'**
  String get removeFavorite;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No description provided for @renameButton.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get renameButton;

  /// No description provided for @renameDeviceDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Device'**
  String get renameDeviceDialogTitle;

  /// No description provided for @renameDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Device'**
  String get renameDeviceTitle;

  /// No description provided for @replaceCurrentSettingsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This will replace all your current settings. Are you sure you want to continue?'**
  String get replaceCurrentSettingsConfirmation;

  /// No description provided for @requestAllPermissions.
  ///
  /// In en, this message translates to:
  /// **'Request All Permissions'**
  String get requestAllPermissions;

  /// No description provided for @requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request Permission'**
  String get requestPermission;

  /// No description provided for @requestPermissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to request permission: {error}'**
  String requestPermissionFailed(Object error);

  /// No description provided for @requiredMarks.
  ///
  /// In en, this message translates to:
  /// **'{count} Marks'**
  String requiredMarks(Object count);

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreApplicationSettingsFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Application Settings from Backup'**
  String get restoreApplicationSettingsFromBackup;

  /// No description provided for @restoreApplicationSettingsFromBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore application settings from backup'**
  String get restoreApplicationSettingsFromBackupSubtitle;

  /// No description provided for @restoreButton.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreButton;

  /// No description provided for @restoreFailedWithError.
  ///
  /// In en, this message translates to:
  /// **'Restore from cloud failed: {error}'**
  String restoreFailedWithError(Object error);

  /// No description provided for @restoreFromCloud.
  ///
  /// In en, this message translates to:
  /// **'Restore from Cloud'**
  String get restoreFromCloud;

  /// No description provided for @restoreFromCloudDescription.
  ///
  /// In en, this message translates to:
  /// **'Restore settings and rules from cloud storage'**
  String get restoreFromCloudDescription;

  /// No description provided for @restoreFromCloudFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to restore from cloud: {error}'**
  String restoreFromCloudFailed(Object error);

  /// No description provided for @restoreFromCloudLabel.
  ///
  /// In en, this message translates to:
  /// **'Restore from Cloud'**
  String get restoreFromCloudLabel;

  /// No description provided for @restoreFromCloudSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully restored from cloud'**
  String get restoreFromCloudSuccess;

  /// No description provided for @restoreFromCloudTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore from Cloud'**
  String get restoreFromCloudTitle;

  /// No description provided for @restoreFromLocal.
  ///
  /// In en, this message translates to:
  /// **'Restore from Local'**
  String get restoreFromLocal;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @restoreSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreSectionTitle;

  /// No description provided for @restoreSettings.
  ///
  /// In en, this message translates to:
  /// **'Restore Settings'**
  String get restoreSettings;

  /// No description provided for @restoreSettingsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This will replace all your current settings. Are you sure you want to continue?'**
  String get restoreSettingsConfirmation;

  /// No description provided for @restoreSettingsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Settings'**
  String get restoreSettingsDialogTitle;

  /// No description provided for @restoreSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Settings'**
  String get restoreSettingsTitle;

  /// No description provided for @restoreSuccessFromLocal.
  ///
  /// In en, this message translates to:
  /// **'Successfully restored from local'**
  String get restoreSuccessFromLocal;

  /// No description provided for @restoreSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Successfully restored from cloud'**
  String get restoreSuccessMessage;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @ridesharing.
  ///
  /// In en, this message translates to:
  /// **'Ridesharing'**
  String get ridesharing;

  /// No description provided for @risk.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get risk;

  /// No description provided for @robocall.
  ///
  /// In en, this message translates to:
  /// **'Robocall'**
  String get robocall;

  /// No description provided for @ruleAction.
  ///
  /// In en, this message translates to:
  /// **'Rule Action'**
  String get ruleAction;

  /// No description provided for @ruleAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Rule'**
  String get ruleAddButton;

  /// Rule creation success message
  ///
  /// In en, this message translates to:
  /// **'Rule added successfully'**
  String get ruleAddedSuccess;

  /// Rule creation failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to add rule: {error}'**
  String ruleAddFailure(Object error);

  /// No description provided for @ruleAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule added successfully'**
  String get ruleAddSuccess;

  /// No description provided for @ruleDeleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this {ruleType}?'**
  String ruleDeleteConfirmContent(Object ruleType);

  /// No description provided for @ruleDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Rule'**
  String get ruleDeleteConfirmTitle;

  /// No description provided for @ruleDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted successfully'**
  String get ruleDeletedSuccess;

  /// No description provided for @ruleDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted successfully'**
  String get ruleDeletedSuccessfully;

  /// No description provided for @ruleDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete rule: {error}'**
  String ruleDeleteFailed(Object error);

  /// Rule deletion failure message
  ///
  /// In en, this message translates to:
  /// **'Failed to delete rule: {error}'**
  String ruleDeleteFailure(Object error);

  /// No description provided for @ruleDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule deleted successfully'**
  String get ruleDeleteSuccess;

  /// No description provided for @ruleDisabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule disabled successfully'**
  String get ruleDisabledSuccessfully;

  /// No description provided for @ruleEnabledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule enabled successfully'**
  String get ruleEnabledSuccessfully;

  /// No description provided for @ruleLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load rules: {error}'**
  String ruleLoadFailed(Object error);

  /// No description provided for @ruleManagement.
  ///
  /// In en, this message translates to:
  /// **'Rule Management'**
  String get ruleManagement;

  /// No description provided for @ruleManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Rule Management'**
  String get ruleManagementTitle;

  /// No description provided for @ruleName.
  ///
  /// In en, this message translates to:
  /// **'Rule Name'**
  String get ruleName;

  /// No description provided for @ruleNameAndContentRegexCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Rule name and content regex cannot be empty'**
  String get ruleNameAndContentRegexCannotBeEmpty;

  /// No description provided for @ruleNameAndPhoneNumberCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Rule name and phone number cannot be empty'**
  String get ruleNameAndPhoneNumberCannotBeEmpty;

  /// No description provided for @ruleNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Family, Friends, etc.'**
  String get ruleNameHint;

  /// No description provided for @ruleNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Rule Name'**
  String get ruleNameLabel;

  /// No description provided for @ruleNamePatternRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter rule name and pattern'**
  String get ruleNamePatternRequired;

  /// No description provided for @ruleNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Rule name and phone number cannot be empty'**
  String get ruleNameRequired;

  /// No description provided for @ruleNotExist.
  ///
  /// In en, this message translates to:
  /// **'Rule does not exist or has been deleted'**
  String get ruleNotExist;

  /// No description provided for @ruleNotFound.
  ///
  /// In en, this message translates to:
  /// **'Rule not found: {error}'**
  String ruleNotFound(Object error);

  /// No description provided for @ruleSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSavedSuccessfully;

  /// No description provided for @ruleSavedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSavedSuccessMessage;

  /// No description provided for @ruleSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String ruleSaveFailed(Object error);

  /// No description provided for @ruleSaveFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String ruleSaveFailedMessage(Object error);

  /// No description provided for @ruleSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule saved successfully!'**
  String get ruleSaveSuccess;

  /// No description provided for @rulesExportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Rules exported successfully'**
  String get rulesExportedSuccessfully;

  /// No description provided for @rulesExportedTo.
  ///
  /// In en, this message translates to:
  /// **'Rules exported to: {path}'**
  String rulesExportedTo(Object path);

  /// No description provided for @rulesImported.
  ///
  /// In en, this message translates to:
  /// **'Rules imported successfully'**
  String get rulesImported;

  /// No description provided for @rulesImportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'{count} rules imported successfully'**
  String rulesImportedSuccessfully(Object count);

  /// No description provided for @rulesImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import rules: {error}'**
  String rulesImportFailed(Object error);

  /// No description provided for @ruleStatistics.
  ///
  /// In en, this message translates to:
  /// **'Rule Statistics'**
  String get ruleStatistics;

  /// No description provided for @ruleStatusChanged.
  ///
  /// In en, this message translates to:
  /// **'Rule {status} successfully'**
  String ruleStatusChanged(Object status);

  /// No description provided for @ruleToggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String ruleToggleFailed(Object error);

  /// No description provided for @ruleToggleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule {status} successfully'**
  String ruleToggleSuccess(Object status);

  /// No description provided for @ruleUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update rule: {error}'**
  String ruleUpdateFailed(Object error);

  /// No description provided for @ruleUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rule updated successfully'**
  String get ruleUpdateSuccess;

  /// No description provided for @ruleVerification.
  ///
  /// In en, this message translates to:
  /// **'Rule Verification'**
  String get ruleVerification;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @saveButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get saveButtonLabel;

  /// No description provided for @saveButtonText.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButtonText;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Save failed: {error}'**
  String saveFailed(Object error);

  /// No description provided for @saveFilter.
  ///
  /// In en, this message translates to:
  /// **'Save Filter'**
  String get saveFilter;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @saveSettingsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings: {error}'**
  String saveSettingsFailed(Object error);

  /// No description provided for @scamsLikely.
  ///
  /// In en, this message translates to:
  /// **'Scams Likely'**
  String get scamsLikely;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchContacts.
  ///
  /// In en, this message translates to:
  /// **'Search Contacts'**
  String get searchContacts;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Search error: {error}'**
  String searchError(Object error);

  /// No description provided for @searchFilters.
  ///
  /// In en, this message translates to:
  /// **'Search Filters'**
  String get searchFilters;

  /// No description provided for @searchForContacts.
  ///
  /// In en, this message translates to:
  /// **'Search for contacts'**
  String get searchForContacts;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @searchSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search contacts, labels, blacklists, whitelists, etc.'**
  String get searchSettingsSubtitle;

  /// No description provided for @searchSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Settings'**
  String get searchSettingsTitle;

  /// No description provided for @securityMessage.
  ///
  /// In en, this message translates to:
  /// **'Do not trust any phone calls. Always verify customer service numbers independently. Never share passwords, verification codes, card numbers, or personal information.'**
  String get securityMessage;

  /// No description provided for @selectActionToPerform.
  ///
  /// In en, this message translates to:
  /// **'Select the action to perform when the rule matches'**
  String get selectActionToPerform;

  /// No description provided for @selectActionWhenBlockingCalls.
  ///
  /// In en, this message translates to:
  /// **'Select action when blocking calls'**
  String get selectActionWhenBlockingCalls;

  /// No description provided for @selectActionWhenRuleMatches.
  ///
  /// In en, this message translates to:
  /// **'Select action when rule matches'**
  String get selectActionWhenRuleMatches;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get selectCountry;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRange;

  /// Selected date range text
  ///
  /// In en, this message translates to:
  /// **'Selected date range'**
  String get selectedDateRange;

  /// No description provided for @selectedItems.
  ///
  /// In en, this message translates to:
  /// **'{count} items selected'**
  String selectedItems(Object count);

  /// No description provided for @selectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected:'**
  String get selectedLabel;

  /// No description provided for @selectExportFormat.
  ///
  /// In en, this message translates to:
  /// **'Select Export Format'**
  String get selectExportFormat;

  /// No description provided for @selectLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Label'**
  String get selectLabel;

  /// No description provided for @selectLabelAndEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please select a label and enter a valid phone number'**
  String get selectLabelAndEnterPhoneNumber;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectMultiple.
  ///
  /// In en, this message translates to:
  /// **'Select Multiple'**
  String get selectMultiple;

  /// No description provided for @selectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// No description provided for @selectSimCard.
  ///
  /// In en, this message translates to:
  /// **'Select SIM Card'**
  String get selectSimCard;

  /// Title for SIM slot selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select SIM Slot'**
  String get selectSimSlot;

  /// No description provided for @selectSpecificActionForBlockedCalls.
  ///
  /// In en, this message translates to:
  /// **'Select the specific action to perform when blocking calls'**
  String get selectSpecificActionForBlockedCalls;

  /// No description provided for @selectTag.
  ///
  /// In en, this message translates to:
  /// **'Select Tag'**
  String get selectTag;

  /// No description provided for @selectTags.
  ///
  /// In en, this message translates to:
  /// **'Select Tags'**
  String get selectTags;

  /// No description provided for @selectTrustedDataSource.
  ///
  /// In en, this message translates to:
  /// **'Please select trusted data sources'**
  String get selectTrustedDataSource;

  /// No description provided for @selectYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Your Language'**
  String get selectYourLanguage;

  /// No description provided for @sender.
  ///
  /// In en, this message translates to:
  /// **'Sender'**
  String get sender;

  /// No description provided for @senderRegexOptional.
  ///
  /// In en, this message translates to:
  /// **'Sender Regex (Optional)'**
  String get senderRegexOptional;

  /// No description provided for @serverAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Server Address'**
  String get serverAddressLabel;

  /// No description provided for @serviceTypeContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Subscription'**
  String get serviceTypeContact;

  /// No description provided for @serviceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceTypeLabel;

  /// No description provided for @serviceTypePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Subscription'**
  String get serviceTypePhone;

  /// No description provided for @serviceTypePlugin.
  ///
  /// In en, this message translates to:
  /// **'Plugin Update'**
  String get serviceTypePlugin;

  /// No description provided for @serviceTypeSms.
  ///
  /// In en, this message translates to:
  /// **'SMS Subscription'**
  String get serviceTypeSms;

  /// Service update failure message
  ///
  /// In en, this message translates to:
  /// **'{error}'**
  String serviceUpdateFailure(Object error);

  /// No description provided for @setButton.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get setButton;

  /// No description provided for @setEncryptionPassword.
  ///
  /// In en, this message translates to:
  /// **'Set Encryption Password'**
  String get setEncryptionPassword;

  /// No description provided for @setEncryptionPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Set encryption password for backup and restore'**
  String get setEncryptionPasswordDescription;

  /// No description provided for @setEncryptionPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Set Encryption Password'**
  String get setEncryptionPasswordLabel;

  /// No description provided for @setEncryptionPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Encryption Password'**
  String get setEncryptionPasswordTitle;

  /// No description provided for @setPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Set'**
  String get setPasswordButton;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsBackedUpTo.
  ///
  /// In en, this message translates to:
  /// **'Settings backed up to: {path}'**
  String settingsBackedUpTo(Object path);

  /// No description provided for @settingsLoaded.
  ///
  /// In en, this message translates to:
  /// **'Settings loaded'**
  String get settingsLoaded;

  /// No description provided for @settingsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load settings: {error}'**
  String settingsLoadFailed(Object error);

  /// No description provided for @settingsRestoredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Settings restored successfully. Please restart the app for changes to take effect.'**
  String get settingsRestoredSuccessfully;

  /// Settings saved confirmation message
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get settingsSaved;

  /// No description provided for @settingsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings: {error}'**
  String settingsSaveFailed(Object error);

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @setup.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setup;

  /// No description provided for @showContactEditDialogStaticMethod.
  ///
  /// In en, this message translates to:
  /// **'Static method to display contact edit dialog'**
  String get showContactEditDialogStaticMethod;

  /// No description provided for @showExplanation.
  ///
  /// In en, this message translates to:
  /// **'Show Explanation'**
  String get showExplanation;

  /// No description provided for @silence.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get silence;

  /// No description provided for @silenceAndNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Silence and No Answer'**
  String get silenceAndNoAnswer;

  /// No description provided for @silenceNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Silence No Answer'**
  String get silenceNoAnswer;

  /// No description provided for @silentCallVoiceClone.
  ///
  /// In en, this message translates to:
  /// **'Silent Call Voice Clone'**
  String get silentCallVoiceClone;

  /// No description provided for @silentRules.
  ///
  /// In en, this message translates to:
  /// **'Silent Rules'**
  String get silentRules;

  /// No description provided for @simCard.
  ///
  /// In en, this message translates to:
  /// **'SIM Card {simNumber}'**
  String simCard(Object simNumber);

  /// No description provided for @simCardColor.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Color'**
  String get simCardColor;

  /// No description provided for @simCardConfigurationExplanation.
  ///
  /// In en, this message translates to:
  /// **'• SIM Card Configuration: Set independent filtering rules for each SIM card'**
  String get simCardConfigurationExplanation;

  /// No description provided for @simCardFilterRules.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Filter Rules'**
  String get simCardFilterRules;

  /// No description provided for @simCardFilterRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Set different filtering rules based on SIM card slots'**
  String get simCardFilterRulesDescription;

  /// No description provided for @simCardFontSize.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Font Size'**
  String get simCardFontSize;

  /// No description provided for @simCardPosition.
  ///
  /// In en, this message translates to:
  /// **'SIM Card Position'**
  String get simCardPosition;

  /// SIM Card information
  ///
  /// In en, this message translates to:
  /// **'SIM {slotNumber} - {countryIso}'**
  String simInfo(Object slotNumber, Object countryIso);

  /// No description provided for @simInfoLoadFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SIM card information: {error}'**
  String simInfoLoadFailure(Object error);

  /// No description provided for @simRuleInstructions.
  ///
  /// In en, this message translates to:
  /// **'SIM slot rules allow you to configure independent filtering rules for each SIM slot.'**
  String get simRuleInstructions;

  /// Section title for SIM slot rules instructions
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules'**
  String get simRuleInstructionsTitle;

  /// SIM slot rule management section title
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rule Management'**
  String get simRuleManagement;

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

  /// No description provided for @simSlotDataLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SIM data: {error}'**
  String simSlotDataLoadFailed(Object error);

  /// No description provided for @simSlotFilterConfiguration.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Filter Configuration'**
  String get simSlotFilterConfiguration;

  /// No description provided for @simSlotFilterConfigurationDescription.
  ///
  /// In en, this message translates to:
  /// **'Allowing to set filter rules by SIM slot'**
  String get simSlotFilterConfigurationDescription;

  /// No description provided for @simSlotFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'Configure independent filtering rules for each SIM card:'**
  String get simSlotFilterDescription;

  /// Title for SIM slot filter settings
  ///
  /// In en, this message translates to:
  /// **'SIM Slot {slotNumber} Filter Settings'**
  String simSlotFilterSettingsTitle(Object slotNumber);

  /// No description provided for @simSlotLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SIM slots: {error}'**
  String simSlotLoadFailed(Object error);

  /// No description provided for @simSlotManagement.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Management'**
  String get simSlotManagement;

  /// SIM slot operation failure message
  ///
  /// In en, this message translates to:
  /// **'SIM slot operation failed: {error}'**
  String simSlotOperationFailed(Object error);

  /// SIM slot position display
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Position {slotNumber}'**
  String simSlotPosition(int slotNumber);

  /// No description provided for @simSlotRuleFeature.
  ///
  /// In en, this message translates to:
  /// **'• SIM Slot Rules: Independent filtering strategies per SIM'**
  String get simSlotRuleFeature;

  /// No description provided for @simSlotRuleListTitle.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules List'**
  String get simSlotRuleListTitle;

  /// No description provided for @simSlotRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Rules'**
  String get simSlotRuleManagement;

  /// No description provided for @simSlotRuleManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Rule Management'**
  String get simSlotRuleManagementTitle;

  /// Title for SIM slot settings page
  ///
  /// In en, this message translates to:
  /// **'SIM Slot Settings'**
  String get simSlotSettings;

  /// No description provided for @simSlotTitle.
  ///
  /// In en, this message translates to:
  /// **'SIM Slot {slotNumber}'**
  String simSlotTitle(Object slotNumber);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @smartCallerId.
  ///
  /// In en, this message translates to:
  /// **'Smart Call Identification'**
  String get smartCallerId;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @smsFilterDescription.
  ///
  /// In en, this message translates to:
  /// **'SMS filtering helps you automatically filter spam messages and keep your message list clean. You can set filter rules and notification methods.'**
  String get smsFilterDescription;

  /// No description provided for @smsFilterDisabled.
  ///
  /// In en, this message translates to:
  /// **'SMS filtering disabled'**
  String get smsFilterDisabled;

  /// No description provided for @smsFilterEnabled.
  ///
  /// In en, this message translates to:
  /// **'SMS filtering enabled'**
  String get smsFilterEnabled;

  /// No description provided for @smsFilterRuleAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS filter rule added successfully'**
  String get smsFilterRuleAddedSuccessfully;

  /// No description provided for @smsFilterRules.
  ///
  /// In en, this message translates to:
  /// **'SMS Filter Rules'**
  String get smsFilterRules;

  /// No description provided for @smsFilterSettings.
  ///
  /// In en, this message translates to:
  /// **'SMS Filter Settings'**
  String get smsFilterSettings;

  /// No description provided for @smsHistory.
  ///
  /// In en, this message translates to:
  /// **'SMS History'**
  String get smsHistory;

  /// No description provided for @smsManagement.
  ///
  /// In en, this message translates to:
  /// **'SMS Management'**
  String get smsManagement;

  /// No description provided for @smsPermission.
  ///
  /// In en, this message translates to:
  /// **'SMS Permission'**
  String get smsPermission;

  /// No description provided for @smsPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to filter spam messages.'**
  String get smsPermissionDescription;

  /// No description provided for @smsRuleAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS rule added successfully'**
  String get smsRuleAddedSuccessfully;

  /// No description provided for @smsRuleDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS rule deleted successfully'**
  String get smsRuleDeletedSuccessfully;

  /// No description provided for @smsRuleLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load SMS rules: {error}'**
  String smsRuleLoadFailed(Object error);

  /// No description provided for @smsRuleManagement.
  ///
  /// In en, this message translates to:
  /// **'SMS Rule Management'**
  String get smsRuleManagement;

  /// No description provided for @smsRulesExportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS rules exported successfully to {filePath}'**
  String smsRulesExportedSuccessfully(Object filePath);

  /// No description provided for @smsRulesImportedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS rules imported successfully'**
  String get smsRulesImportedSuccessfully;

  /// No description provided for @smsRuleSubscription.
  ///
  /// In en, this message translates to:
  /// **'SMS Rule Subscription'**
  String get smsRuleSubscription;

  /// No description provided for @smsRuleUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS rule updated successfully'**
  String get smsRuleUpdatedSuccessfully;

  /// No description provided for @smsSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'SMS filtering and keyword blocking'**
  String get smsSettingsSubtitle;

  /// No description provided for @smsSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS Settings'**
  String get smsSettingsTitle;

  /// No description provided for @smsSubscription.
  ///
  /// In en, this message translates to:
  /// **'SMS Subscription'**
  String get smsSubscription;

  /// No description provided for @smsSubscriptionAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'SMS subscription added successfully'**
  String get smsSubscriptionAddedSuccessfully;

  /// No description provided for @smsSubscriptionRulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to SMS rule lists via URL, supporting regular expression matching. You can set block or allow actions.'**
  String get smsSubscriptionRulesDescription;

  /// No description provided for @smsTab.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get smsTab;

  /// No description provided for @somePermissionsDenied.
  ///
  /// In en, this message translates to:
  /// **'Some permission requests denied'**
  String get somePermissionsDenied;

  /// No description provided for @spamLikely.
  ///
  /// In en, this message translates to:
  /// **'Spam Likely'**
  String get spamLikely;

  /// No description provided for @startColor.
  ///
  /// In en, this message translates to:
  /// **'Start Color'**
  String get startColor;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @startUsing.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get startUsing;

  /// No description provided for @statAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get statAnswered;

  /// No description provided for @statBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get statBlocked;

  /// No description provided for @staticMethodShowCallerIdDialog.
  ///
  /// In en, this message translates to:
  /// **'Static method to show the Caller ID Information Dialog'**
  String get staticMethodShowCallerIdDialog;

  /// No description provided for @staticMethodToDisplayCountrySelectionDialog.
  ///
  /// In en, this message translates to:
  /// **'Static method to display country selection dialog'**
  String get staticMethodToDisplayCountrySelectionDialog;

  /// No description provided for @staticMethodToDisplayDialog.
  ///
  /// In en, this message translates to:
  /// **'Static method to display dialog'**
  String get staticMethodToDisplayDialog;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @statisticsExportFeatureComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Statistics export feature coming soon'**
  String get statisticsExportFeatureComingSoon;

  /// No description provided for @statisticsGrid.
  ///
  /// In en, this message translates to:
  /// **'Statistics Grid'**
  String get statisticsGrid;

  /// No description provided for @statisticsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Analysis'**
  String get statisticsPageTitle;

  /// No description provided for @stirColor.
  ///
  /// In en, this message translates to:
  /// **'STIR Color'**
  String get stirColor;

  /// No description provided for @stirFontSize.
  ///
  /// In en, this message translates to:
  /// **'STIR Font Size'**
  String get stirFontSize;

  /// No description provided for @stirPosition.
  ///
  /// In en, this message translates to:
  /// **'STIR Position'**
  String get stirPosition;

  /// No description provided for @storagePermission.
  ///
  /// In en, this message translates to:
  /// **'Storage Permission'**
  String get storagePermission;

  /// No description provided for @storagePermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Used to save settings and rules.'**
  String get storagePermissionDescription;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// Subscription added success message
  ///
  /// In en, this message translates to:
  /// **'Subscription \"{name}\" added successfully'**
  String subscriptionAddSuccess(Object name);

  /// No description provided for @subscriptionDeleteConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this subscription?'**
  String get subscriptionDeleteConfirmContent;

  /// No description provided for @subscriptionDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Subscription'**
  String get subscriptionDeleteConfirmTitle;

  /// Subscription deleted success message
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted'**
  String get subscriptionDeleted;

  /// No description provided for @subscriptionDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted successfully'**
  String get subscriptionDeletedSuccessfully;

  /// No description provided for @subscriptionDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete subscription: {error}'**
  String subscriptionDeleteFailed(Object error);

  /// No description provided for @subscriptionDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription deleted'**
  String get subscriptionDeleteSuccess;

  /// No description provided for @subscriptionEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions available'**
  String get subscriptionEmptyState;

  /// No description provided for @subscriptionEmptyText.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet'**
  String get subscriptionEmptyText;

  /// No description provided for @subscriptionLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String subscriptionLoadFailed(Object error);

  /// No description provided for @subscriptionLoadingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscriptions: {error}'**
  String subscriptionLoadingFailed(Object error);

  /// No description provided for @subscriptionManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Management'**
  String get subscriptionManagementTitle;

  /// Subscription name field label
  ///
  /// In en, this message translates to:
  /// **'Subscription Name'**
  String get subscriptionName;

  /// No description provided for @subscriptionNameAndUrlCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subscription name and URL cannot be empty'**
  String get subscriptionNameAndUrlCannotBeEmpty;

  /// No description provided for @subscriptionNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter subscription name'**
  String get subscriptionNameHint;

  /// No description provided for @subscriptionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Management'**
  String get subscriptionPageTitle;

  /// No description provided for @subscriptionStatusChangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to change subscription status: {error}'**
  String subscriptionStatusChangeFailed(Object error);

  /// No description provided for @subscriptionToggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle subscription status: {error}'**
  String subscriptionToggleFailed(Object error);

  /// No description provided for @subscriptionUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update subscription: {error}'**
  String subscriptionUpdateFailed(Object error);

  /// Subscription update success message
  ///
  /// In en, this message translates to:
  /// **'Subscription updated successfully'**
  String get subscriptionUpdateSuccess;

  /// Subscription URL field label
  ///
  /// In en, this message translates to:
  /// **'Subscription URL'**
  String get subscriptionUrl;

  /// No description provided for @subscriptionUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Enter subscription URL'**
  String get subscriptionUrlHint;

  /// No description provided for @successfullyImportedRules.
  ///
  /// In en, this message translates to:
  /// **'Successfully imported {count} rules'**
  String successfullyImportedRules(Object count);

  /// No description provided for @supportSync.
  ///
  /// In en, this message translates to:
  /// **'Support Sync'**
  String get supportSync;

  /// No description provided for @survey.
  ///
  /// In en, this message translates to:
  /// **'Survey'**
  String get survey;

  /// No description provided for @syncDevicesButton.
  ///
  /// In en, this message translates to:
  /// **'Sync Devices'**
  String get syncDevicesButton;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncFailed;

  /// No description provided for @syncFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncFailedMessage;

  /// No description provided for @syncFolderNameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter sync folder name (default: NotificationManager)'**
  String get syncFolderNameHint;

  /// No description provided for @syncFolderNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Sync Folder Name'**
  String get syncFolderNameLabel;

  /// Synchronized status label
  ///
  /// In en, this message translates to:
  /// **'Synchronized'**
  String get synchronized;

  /// No description provided for @syncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncing;

  /// Sync now button text
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @syncNowButton.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNowButton;

  /// No description provided for @syncStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Status'**
  String get syncStatusTitle;

  /// No description provided for @syncStatusUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Sync status updated'**
  String get syncStatusUpdatedMessage;

  /// No description provided for @syncSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Sync successful'**
  String get syncSuccessful;

  /// No description provided for @syncSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Sync successful'**
  String get syncSuccessMessage;

  /// No description provided for @syncWithCloudStorage.
  ///
  /// In en, this message translates to:
  /// **'Sync with Cloud Storage'**
  String get syncWithCloudStorage;

  /// No description provided for @syncWithCloudStorageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sync with cloud storage'**
  String get syncWithCloudStorageSubtitle;

  /// No description provided for @systemFeatures.
  ///
  /// In en, this message translates to:
  /// **'System Features:'**
  String get systemFeatures;

  /// No description provided for @systemSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettingsTitle;

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

  /// No description provided for @tabBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get tabBlocked;

  /// No description provided for @tabMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get tabMissed;

  /// No description provided for @tabOutgoing.
  ///
  /// In en, this message translates to:
  /// **'Outgoing'**
  String get tabOutgoing;

  /// No description provided for @tagLabel.
  ///
  /// In en, this message translates to:
  /// **'Tag: {tag}'**
  String tagLabel(String tag);

  /// No description provided for @tagsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Tags updated'**
  String get tagsUpdated;

  /// No description provided for @takeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get takeaway;

  /// No description provided for @telecommunication.
  ///
  /// In en, this message translates to:
  /// **'Telecommunication'**
  String get telecommunication;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @telemarketing.
  ///
  /// In en, this message translates to:
  /// **'Telemarketing'**
  String get telemarketing;

  /// No description provided for @testButton.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get testButton;

  /// No description provided for @testButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'TEST'**
  String get testButtonLabel;

  /// No description provided for @testConnectionButton.
  ///
  /// In en, this message translates to:
  /// **'Test Connection'**
  String get testConnectionButton;

  /// No description provided for @textColorsSetting.
  ///
  /// In en, this message translates to:
  /// **'Text & Label Colors'**
  String get textColorsSetting;

  /// No description provided for @thisAppIsAPowerfulCallerIdToolThatAllows.
  ///
  /// In en, this message translates to:
  /// **'This app is a powerful caller ID tool that allows you to identify and block unwanted calls.'**
  String get thisAppIsAPowerfulCallerIdToolThatAllows;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @timeInterceptor.
  ///
  /// In en, this message translates to:
  /// **'Time Interceptor'**
  String get timeInterceptor;

  /// No description provided for @timeInterceptorDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically intercept potential spam calls based on call frequency'**
  String get timeInterceptorDescription;

  /// No description provided for @timeInterceptorExplanation.
  ///
  /// In en, this message translates to:
  /// **'• Time Interceptor: Intercept repeated calls within a short time'**
  String get timeInterceptorExplanation;

  /// No description provided for @timeInterceptorExplanationContent.
  ///
  /// In en, this message translates to:
  /// **'The call frequency interception feature analyzes call frequency to automatically identify and intercept frequent spam calls.'**
  String get timeInterceptorExplanationContent;

  /// No description provided for @timeInterceptorExplanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Frequency Interception Explanation'**
  String get timeInterceptorExplanationTitle;

  /// No description provided for @timeInterceptorSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Call Frequency Interception Settings'**
  String get timeInterceptorSettingsTitle;

  /// No description provided for @timeInterceptorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically intercept potential spam calls based on call frequency'**
  String get timeInterceptorSubtitle;

  /// No description provided for @timeInterceptorTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Call Frequency Interception'**
  String get timeInterceptorTitle;

  /// No description provided for @timeWindowDescription.
  ///
  /// In en, this message translates to:
  /// **'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted'**
  String get timeWindowDescription;

  /// Time window label with duration in minutes
  ///
  /// In en, this message translates to:
  /// **'Interception Time Window (minutes): {minutes}'**
  String timeWindowLabel(int minutes);

  /// No description provided for @timeWindowSetting.
  ///
  /// In en, this message translates to:
  /// **'Set the time window size for intercepting repeated calls. Calls from the same number within this window will be intercepted'**
  String get timeWindowSetting;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

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

  /// No description provided for @transferDataBetweenDevicesOrPlatforms.
  ///
  /// In en, this message translates to:
  /// **'Transfer data between devices or platforms'**
  String get transferDataBetweenDevicesOrPlatforms;

  /// No description provided for @transferDataBetweenDevicesOrPlatformsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Transfer data between devices or platforms'**
  String get transferDataBetweenDevicesOrPlatformsSubtitle;

  /// No description provided for @travelTicketing.
  ///
  /// In en, this message translates to:
  /// **'Travel Ticketing'**
  String get travelTicketing;

  /// No description provided for @trend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get trend;

  /// No description provided for @trendChart.
  ///
  /// In en, this message translates to:
  /// **'Trend Chart'**
  String get trendChart;

  /// No description provided for @tutorial.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorial;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @unassignedSIMCard.
  ///
  /// In en, this message translates to:
  /// **'Unassigned SIM Card'**
  String get unassignedSIMCard;

  /// Display text for unknown status
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @unknownLabel.
  ///
  /// In en, this message translates to:
  /// **'Unknown Label'**
  String get unknownLabel;

  /// No description provided for @unknownTag.
  ///
  /// In en, this message translates to:
  /// **'Tag: Unknown'**
  String get unknownTag;

  /// No description provided for @unregisterButton.
  ///
  /// In en, this message translates to:
  /// **'Unregister'**
  String get unregisterButton;

  /// No description provided for @unregisterDeviceConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unregister {deviceName}?'**
  String unregisterDeviceConfirmationMessage(Object deviceName);

  /// No description provided for @unregisterDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Unregister Device'**
  String get unregisterDeviceTitle;

  /// No description provided for @unsupportedFileFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported file format'**
  String get unsupportedFileFormat;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateAllNow.
  ///
  /// In en, this message translates to:
  /// **'Update All Now'**
  String get updateAllNow;

  /// Button text for updating call filter configuration
  ///
  /// In en, this message translates to:
  /// **'Update Call Filter Configuration'**
  String get updateCallFilterConfig;

  /// No description provided for @updateContactFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update contact: {error}'**
  String updateContactFailed(Object error);

  /// No description provided for @updateFavoriteStatus.
  ///
  /// In en, this message translates to:
  /// **'Update Favorite Status'**
  String get updateFavoriteStatus;

  /// No description provided for @updateFavoriteStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite status: {error}'**
  String updateFavoriteStatusFailed(Object error);

  /// No description provided for @updateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get updateInterval;

  /// No description provided for @updateLabelFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update label'**
  String get updateLabelFailed;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get updateNow;

  /// No description provided for @updatePlugin.
  ///
  /// In en, this message translates to:
  /// **'Update Plugin'**
  String get updatePlugin;

  /// No description provided for @updatePluginFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update plugin: {error}'**
  String updatePluginFailed(Object error);

  /// No description provided for @updateRuleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update rule: {error}'**
  String updateRuleFailed(Object error);

  /// Failed to update subscription error message
  ///
  /// In en, this message translates to:
  /// **'Failed to update subscription: {error}'**
  String updateSubscriptionFailed(Object error);

  /// Single service update success message
  ///
  /// In en, this message translates to:
  /// **'{service} updated successfully ({count} rules)'**
  String updateSuccess(Object service, Object count);

  /// No description provided for @updateTags.
  ///
  /// In en, this message translates to:
  /// **'Update Tags'**
  String get updateTags;

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

  /// No description provided for @useCasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Use Cases:'**
  String get useCasesTitle;

  /// No description provided for @useGlobalSettings.
  ///
  /// In en, this message translates to:
  /// **'Use Global Settings'**
  String get useGlobalSettings;

  /// No description provided for @userEmail.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get userEmail;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @useStandardRegexSyntaxToDefinePatternsExamples.
  ///
  /// In en, this message translates to:
  /// **'Use standard regex syntax to define patterns. Examples:'**
  String get useStandardRegexSyntaxToDefinePatternsExamples;

  /// No description provided for @validateRegex.
  ///
  /// In en, this message translates to:
  /// **'Validate Regex'**
  String get validateRegex;

  /// No description provided for @verificationFailedText.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get verificationFailedText;

  /// No description provided for @verifiedText.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verifiedText;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String version(Object version);

  /// No description provided for @vipExchangeDescription.
  ///
  /// In en, this message translates to:
  /// **'Exchange VIP membership with phone number marking counts'**
  String get vipExchangeDescription;

  /// No description provided for @vipExchangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark Exchange VIP'**
  String get vipExchangeTitle;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch Ad'**
  String get watchAd;

  /// No description provided for @watchAdForTemp.
  ///
  /// In en, this message translates to:
  /// **'Watch Ad for Temporary Privileges'**
  String get watchAdForTemp;

  /// No description provided for @watchAdForTempDescription.
  ///
  /// In en, this message translates to:
  /// **'Watch a short ad to temporarily unlock some premium features'**
  String get watchAdForTempDescription;

  /// No description provided for @webDAVConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'WebDAV Configuration'**
  String get webDAVConfigTitle;

  /// No description provided for @webdavConfigurationTitle.
  ///
  /// In en, this message translates to:
  /// **'WebDAV Configuration'**
  String get webdavConfigurationTitle;

  /// No description provided for @webdavPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV password'**
  String get webdavPasswordHint;

  /// No description provided for @webdavServerAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV server address'**
  String get webdavServerAddressHint;

  /// No description provided for @webdavUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter WebDAV username'**
  String get webdavUsernameHint;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @weeklyBlockedCallsSummary.
  ///
  /// In en, this message translates to:
  /// **'Weekly Blocked Calls Summary'**
  String get weeklyBlockedCallsSummary;

  /// No description provided for @weeklyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Blocked Calls'**
  String get weeklyChartTitle;

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

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Whitelist label
  ///
  /// In en, this message translates to:
  /// **'Whitelist'**
  String get whitelist;

  /// No description provided for @whitelistLabel.
  ///
  /// In en, this message translates to:
  /// **'Whitelist'**
  String get whitelistLabel;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @wildcardMatchingDescription.
  ///
  /// In en, this message translates to:
  /// **'Use \'.\' to match any character (e.g. \'123.456\' matches 123-456)'**
  String get wildcardMatchingDescription;

  /// No description provided for @wildcardMatchingTitle.
  ///
  /// In en, this message translates to:
  /// **'Wildcard matching:'**
  String get wildcardMatchingTitle;

  /// No description provided for @wildcardSupportForFlexibleFiltering.
  ///
  /// In en, this message translates to:
  /// **'Wildcard Support for Flexible Filtering'**
  String get wildcardSupportForFlexibleFiltering;

  /// No description provided for @windowSizeSetting.
  ///
  /// In en, this message translates to:
  /// **'Window Size'**
  String get windowSizeSetting;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @yearlyChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Yearly Blocked Calls'**
  String get yearlyChartTitle;

  /// No description provided for @noSimCardsDetected.
  ///
  /// In en, this message translates to:
  /// **'No SIM cards detected'**
  String get noSimCardsDetected;

  /// No description provided for @filterManagementDescription.
  ///
  /// In en, this message translates to:
  /// **'Set Call Filters'**
  String get filterManagementDescription;

  /// No description provided for @callerIdCustomizationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize Caller ID Layout'**
  String get callerIdCustomizationSubtitle;

  /// No description provided for @fraudAlerSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Fraud Alert Setting'**
  String get fraudAlerSettingTitle;

  /// No description provided for @fraudAlerSettingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To Set Fraud Alert'**
  String get fraudAlerSettingSubtitle;

  /// No description provided for @enableFraudAlert.
  ///
  /// In en, this message translates to:
  /// **'Enable Fraud Alert'**
  String get enableFraudAlert;

  /// No description provided for @enableFraudAlertDescription.
  ///
  /// In en, this message translates to:
  /// **'Alert for suspected scam calls'**
  String get enableFraudAlertDescription;

  /// No description provided for @enableVibration.
  ///
  /// In en, this message translates to:
  /// **'Enable Vibration'**
  String get enableVibration;

  /// No description provided for @enableVibrationDescription.
  ///
  /// In en, this message translates to:
  /// **'Vibrate when call is suspected scam calls'**
  String get enableVibrationDescription;

  /// No description provided for @notificationSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettingsTitle;

  /// No description provided for @useLocalNotification.
  ///
  /// In en, this message translates to:
  /// **'Use Local Notifications'**
  String get useLocalNotification;

  /// No description provided for @useLocalNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable local notifications for incoming calls'**
  String get useLocalNotificationDescription;

  /// No description provided for @cancelLocalNotification.
  ///
  /// In en, this message translates to:
  /// **'Close Local Notifications'**
  String get cancelLocalNotification;

  /// No description provided for @useStirNotification.
  ///
  /// In en, this message translates to:
  /// **'Use Notification from STIR'**
  String get useStirNotification;

  /// No description provided for @useStirNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable STIR notifications for incoming calls'**
  String get useStirNotificationDescription;

  /// No description provided for @cancelLocalNotificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Close Local Notifications Automatically'**
  String get cancelLocalNotificationDescription;

  /// No description provided for @callerIdSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Caller ID Settings'**
  String get callerIdSettingsTitle;

  /// No description provided for @callerIdSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To Set up Incoming Call Notification & Display Mode'**
  String get callerIdSettingsSubtitle;

  /// No description provided for @purchaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get purchaseTitle;

  /// No description provided for @purchaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To Purchase the Service'**
  String get purchaseSubtitle;

  /// Title for the Incoming Call Info
  ///
  /// In en, this message translates to:
  /// **'Incoming Call Info'**
  String get callerIdNotificationTitle;

  /// Body for the caller ID notification, showing the phone number
  ///
  /// In en, this message translates to:
  /// **'Number: {phoneNumber}'**
  String callerIdBody(String phoneNumber);

  /// Title for blocked call notification
  ///
  /// In en, this message translates to:
  /// **'Blocked Call'**
  String get blockedCallTitle;

  /// Body for blocked call notification, showing the phone number
  ///
  /// In en, this message translates to:
  /// **'Blocked call from {phoneNumber}'**
  String blockedCallBody(String phoneNumber);

  /// STIR/SHAKEN verification status: Verified
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get stirVerified;

  /// STIR/SHAKEN verification status: Not Verified
  ///
  /// In en, this message translates to:
  /// **'Not Verified'**
  String get stirNotVerified;

  /// STIR/SHAKEN verification status: Verification Failed
  ///
  /// In en, this message translates to:
  /// **'Verification Failed'**
  String get stirFailed;

  /// STIR/SHAKEN verification status: Unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown Verification Status'**
  String get stirUnknown;

  /// Title for STIR/SHAKEN verification notification
  ///
  /// In en, this message translates to:
  /// **'STIR/SHAKEN Verification'**
  String get stirVerificationTitle;

  /// Body for STIR/SHAKEN verification notification, showing result and phone number
  ///
  /// In en, this message translates to:
  /// **'{stirResultMessage} for number {phoneNumber}'**
  String stirVerificationBody(String stirResultMessage, String phoneNumber);

  /// No description provided for @scrollingSecurityMessageSettings.
  ///
  /// In en, this message translates to:
  /// **'Scrolling Security Message Settings'**
  String get scrollingSecurityMessageSettings;

  /// No description provided for @messageColor.
  ///
  /// In en, this message translates to:
  /// **'Message Color'**
  String get messageColor;

  /// No description provided for @messageFontSize.
  ///
  /// In en, this message translates to:
  /// **'Message Font Size'**
  String get messageFontSize;

  /// No description provided for @messagePosition.
  ///
  /// In en, this message translates to:
  /// **'Message Position'**
  String get messagePosition;

  /// No description provided for @containerWidth.
  ///
  /// In en, this message translates to:
  /// **'Container Width'**
  String get containerWidth;

  /// No description provided for @scrollSpeed.
  ///
  /// In en, this message translates to:
  /// **'Scroll Speed'**
  String get scrollSpeed;

  /// No description provided for @enableSecurityMessage.
  ///
  /// In en, this message translates to:
  /// **'Enable Security Message'**
  String get enableSecurityMessage;

  /// Title for the fraud alert notification
  ///
  /// In en, this message translates to:
  /// **'Fraud Alert'**
  String get fraudAlertTitle;

  /// Body for the fraud alert notification
  ///
  /// In en, this message translates to:
  /// **'Potential fraud call from {phoneNumber}'**
  String fraudAlertBody(String phoneNumber);

  /// No description provided for @loadRulesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load rules: {error}'**
  String loadRulesFailed(Object error);

  /// No description provided for @loadCallLogFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load call log: {error}'**
  String loadCallLogFailed(Object error);

  /// No description provided for @noBlockedTypeData.
  ///
  /// In en, this message translates to:
  /// **'No blocked type data available'**
  String get noBlockedTypeData;

  /// Dialog title for importing an entity
  ///
  /// In en, this message translates to:
  /// **'Import {entityTypeName}'**
  String importEntity(Object entityTypeName);

  /// Success message after importing entities
  ///
  /// In en, this message translates to:
  /// **'{entityTypeName} imported successfully, total {count} records imported'**
  String entityImportSuccess(Object entityTypeName, Object count);

  /// Error message when importing entities fails
  ///
  /// In en, this message translates to:
  /// **'Failed to import {entityTypeName}: {error}'**
  String entityImportFailed(Object entityTypeName, Object error);

  /// Dialog title for exporting an entity
  ///
  /// In en, this message translates to:
  /// **'Export {entityTypeName}'**
  String exportEntity(Object entityTypeName);

  /// Success message after exporting entities
  ///
  /// In en, this message translates to:
  /// **'{entityTypeName} exported successfully'**
  String entityExportSuccess(Object entityTypeName);

  /// Error message when exporting entities fails
  ///
  /// In en, this message translates to:
  /// **'Failed to export {entityTypeName}: {error}'**
  String entityExportFailed(Object entityTypeName, Object error);

  /// No description provided for @cloudSyncService.
  ///
  /// In en, this message translates to:
  /// **'Cloud Sync Service'**
  String get cloudSyncService;

  /// No description provided for @membershipCenter.
  ///
  /// In en, this message translates to:
  /// **'Membership Center'**
  String get membershipCenter;

  /// No description provided for @redeemVipWithMarks.
  ///
  /// In en, this message translates to:
  /// **'Redeem VIP with Marks'**
  String get redeemVipWithMarks;

  /// No description provided for @currentMarkCount.
  ///
  /// In en, this message translates to:
  /// **'Current Mark Count'**
  String get currentMarkCount;

  /// No description provided for @markMoreNumbersForMore.
  ///
  /// In en, this message translates to:
  /// **'Mark more numbers for more marks'**
  String get markMoreNumbersForMore;

  /// No description provided for @noAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackup;

  /// No description provided for @callerIdEnhancement.
  ///
  /// In en, this message translates to:
  /// **'Caller ID Enhancement'**
  String get callerIdEnhancement;

  /// No description provided for @voiceRecognition.
  ///
  /// In en, this message translates to:
  /// **'Voice Recognition'**
  String get voiceRecognition;

  /// No description provided for @feature.
  ///
  /// In en, this message translates to:
  /// **'Feature'**
  String get feature;

  /// No description provided for @normalUser.
  ///
  /// In en, this message translates to:
  /// **'Normal User'**
  String get normalUser;

  /// No description provided for @vipUser.
  ///
  /// In en, this message translates to:
  /// **'VIP User'**
  String get vipUser;

  /// No description provided for @temporaryVip.
  ///
  /// In en, this message translates to:
  /// **'Temporary VIP'**
  String get temporaryVip;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @unknownAction.
  ///
  /// In en, this message translates to:
  /// **'Unknown Action'**
  String get unknownAction;

  /// No description provided for @settingsBackup.
  ///
  /// In en, this message translates to:
  /// **'Settings Backup '**
  String get settingsBackup;

  /// No description provided for @allServicesStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Service Status'**
  String get allServicesStatusTitle;

  /// No description provided for @allServicesStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current Status of Each Cloud Service'**
  String get allServicesStatusSubtitle;

  /// No description provided for @redirect.
  ///
  /// In en, this message translates to:
  /// **'Redirect'**
  String get redirect;

  /// No description provided for @notify.
  ///
  /// In en, this message translates to:
  /// **'Notify'**
  String get notify;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get log;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @allowActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Calls will be allowed, even if the number is on the blocklist.'**
  String get allowActionDescription;

  /// No description provided for @blockActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Calls will be blocked and shown in the call log.'**
  String get blockActionDescription;

  /// No description provided for @silenceActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Calls will be silenced but shown in the call log.'**
  String get silenceActionDescription;

  /// No description provided for @noneActionDescription.
  ///
  /// In en, this message translates to:
  /// **'No special action will be taken for the call.'**
  String get noneActionDescription;

  /// No description provided for @redirectActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Redirect the call to a specified number.'**
  String get redirectActionDescription;

  /// No description provided for @labelActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a label to the call for easy identification.'**
  String get labelActionDescription;

  /// No description provided for @notifyActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Send a notification when a call is received.'**
  String get notifyActionDescription;

  /// No description provided for @logActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Log the call information without taking any other action.'**
  String get logActionDescription;

  /// No description provided for @customActionDescription.
  ///
  /// In en, this message translates to:
  /// **'Perform a custom action.'**
  String get customActionDescription;

  /// Synced status label
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @needVipAccess.
  ///
  /// In en, this message translates to:
  /// **'You need VIP access to use this feature'**
  String get needVipAccess;

  /// No description provided for @importExportDescription.
  ///
  /// In en, this message translates to:
  /// **'Import or export {entityTypeName} data'**
  String importExportDescription(Object entityTypeName);

  /// No description provided for @importExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Import/Export'**
  String get importExportTitle;

  /// No description provided for @noPhoneRules.
  ///
  /// In en, this message translates to:
  /// **'No phone rules found'**
  String get noPhoneRules;

  /// No description provided for @noRegexRules.
  ///
  /// In en, this message translates to:
  /// **'No regex rules found'**
  String get noRegexRules;

  /// No description provided for @noAllowedBlockedRules.
  ///
  /// In en, this message translates to:
  /// **'No allowed/blocked rules found'**
  String get noAllowedBlockedRules;

  /// No description provided for @importExport.
  ///
  /// In en, this message translates to:
  /// **'Import/Export'**
  String get importExport;

  /// No description provided for @filterByAction.
  ///
  /// In en, this message translates to:
  /// **'Filter by Action'**
  String get filterByAction;

  /// No description provided for @upgradeToVip.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to VIP'**
  String get upgradeToVip;

  /// No description provided for @batteryOptimizationPermission.
  ///
  /// In en, this message translates to:
  /// **'Battery Optimization'**
  String get batteryOptimizationPermission;

  /// No description provided for @batteryOptimizationPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow the app to run in the background to provide services like caller ID.'**
  String get batteryOptimizationPermissionDescription;

  /// No description provided for @permissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Special Permissions'**
  String get permissionTitle;

  /// No description provided for @permissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage overlay and battery optimization permissions'**
  String get permissionSubtitle;

  /// No description provided for @themeSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettingsTitle;

  /// No description provided for @themeSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your favorite theme'**
  String get themeSettingsSubtitle;

  /// No description provided for @databaseSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Database Sync'**
  String get databaseSyncTitle;

  /// No description provided for @countrySyncSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Country Based Database Sync Settings'**
  String get countrySyncSettingsTitle;

  /// No description provided for @countrySyncSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select countries for data synchronization'**
  String get countrySyncSettingsSubtitle;

  /// No description provided for @countryDataDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Please note: The database may not include data for all specific countries or regions.'**
  String get countryDataDisclaimer;

  /// No description provided for @editSubscription.
  ///
  /// In en, this message translates to:
  /// **'Edit Subscription'**
  String get editSubscription;

  /// No description provided for @searchByNameOrPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Search By Name or PhoneNumber'**
  String get searchByNameOrPhoneNumber;

  /// No description provided for @allowedBlockedRulesInfo.
  ///
  /// In en, this message translates to:
  /// **'Allowed/blocked rules are used to match calls to specific phone numbers, which have the highest priority.'**
  String get allowedBlockedRulesInfo;

  /// No description provided for @searchPhoneRulesHint.
  ///
  /// In en, this message translates to:
  /// **'Search phone rules'**
  String get searchPhoneRulesHint;

  /// No description provided for @phoneRulesInfo.
  ///
  /// In en, this message translates to:
  /// **'Phone rules are used to match calls to specific phone numbers, which havve a lower priority. Some comes from the phoneRule subscriptions'**
  String get phoneRulesInfo;

  /// No description provided for @searchSubscriptionsHint.
  ///
  /// In en, this message translates to:
  /// **'Search subscriptions'**
  String get searchSubscriptionsHint;

  /// No description provided for @searchPluginsHint.
  ///
  /// In en, this message translates to:
  /// **'Search plugins'**
  String get searchPluginsHint;

  /// No description provided for @searchLabelsHint.
  ///
  /// In en, this message translates to:
  /// **'Search labels'**
  String get searchLabelsHint;

  /// No description provided for @pluginDescription.
  ///
  /// In en, this message translates to:
  /// **'Plugin description'**
  String get pluginDescription;

  /// No description provided for @enterPluginDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter plugin description'**
  String get enterPluginDescription;

  /// No description provided for @searchRegexRulesHint.
  ///
  /// In en, this message translates to:
  /// **'Search regex rules'**
  String get searchRegexRulesHint;

  /// No description provided for @regexRulesInfo.
  ///
  /// In en, this message translates to:
  /// **'Regex rules are used to filter calls based on the Regex Patterns.'**
  String get regexRulesInfo;

  /// No description provided for @searchMarkedPhonesHint.
  ///
  /// In en, this message translates to:
  /// **'Search marked phones'**
  String get searchMarkedPhonesHint;

  /// No description provided for @searchContactSubscriptionsHint.
  ///
  /// In en, this message translates to:
  /// **'Search contact subscriptions'**
  String get searchContactSubscriptionsHint;

  /// No description provided for @showAllContacts.
  ///
  /// In en, this message translates to:
  /// **'Show All Contacts'**
  String get showAllContacts;

  /// No description provided for @showFavorites.
  ///
  /// In en, this message translates to:
  /// **'Show Favorites'**
  String get showFavorites;

  /// No description provided for @manualEntry.
  ///
  /// In en, this message translates to:
  /// **'Manual Entry Info'**
  String get manualEntry;

  /// No description provided for @scriptSaved.
  ///
  /// In en, this message translates to:
  /// **'Script saved'**
  String get scriptSaved;

  /// The title text for the page where a user can edit a script for a specific plugin.
  ///
  /// In en, this message translates to:
  /// **'Edit script for {pluginName}'**
  String editScriptFor(String pluginName);

  /// No description provided for @saveScript.
  ///
  /// In en, this message translates to:
  /// **'Save Script'**
  String get saveScript;

  /// No description provided for @testPlugin.
  ///
  /// In en, this message translates to:
  /// **'Test Plugin'**
  String get testPlugin;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @accessTargetUrl.
  ///
  /// In en, this message translates to:
  /// **'Access Target URL'**
  String get accessTargetUrl;

  /// No description provided for @result.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get result;

  /// No description provided for @editScript.
  ///
  /// In en, this message translates to:
  /// **'Edit Script'**
  String get editScript;

  /// No description provided for @numberFormat.
  ///
  /// In en, this message translates to:
  /// **'Number Format'**
  String get numberFormat;

  /// No description provided for @nationalNumber.
  ///
  /// In en, this message translates to:
  /// **'National Number'**
  String get nationalNumber;

  /// No description provided for @e164Number.
  ///
  /// In en, this message translates to:
  /// **'E164 Number'**
  String get e164Number;

  /// No description provided for @pluginRulesInfo.
  ///
  /// In en, this message translates to:
  /// **'For security, please use plugins from trusted sources only. Feel free to use our templates to create your own custom plugins!'**
  String get pluginRulesInfo;

  /// No description provided for @advancedMode.
  ///
  /// In en, this message translates to:
  /// **'Advanced Mode'**
  String get advancedMode;

  /// No description provided for @pleaseEnterAtLeastOneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter at least one number.'**
  String get pleaseEnterAtLeastOneNumber;

  /// No description provided for @openInWebView.
  ///
  /// In en, this message translates to:
  /// **'Open in WebView'**
  String get openInWebView;

  /// No description provided for @pluginLabel.
  ///
  /// In en, this message translates to:
  /// **'Plugin Label'**
  String get pluginLabel;

  /// No description provided for @pluginID.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get pluginID;

  /// No description provided for @pluginURL.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get pluginURL;

  /// No description provided for @messageBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Message Background Color'**
  String get messageBackgroundColor;

  /// No description provided for @clearAllCallLogs.
  ///
  /// In en, this message translates to:
  /// **'Clear All Call Logs'**
  String get clearAllCallLogs;

  /// No description provided for @clearAllCallLogsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm to clear all call logs'**
  String get clearAllCallLogsConfirmation;

  /// No description provided for @allCallLogsCleared.
  ///
  /// In en, this message translates to:
  /// **'All call logs cleared'**
  String get allCallLogsCleared;

  /// No description provided for @unblocked.
  ///
  /// In en, this message translates to:
  /// **'Unblocked'**
  String get unblocked;

  /// No description provided for @blockNumber.
  ///
  /// In en, this message translates to:
  /// **'Block Number'**
  String get blockNumber;

  /// No description provided for @blockNumberSuccess.
  ///
  /// In en, this message translates to:
  /// **'Block number success'**
  String get blockNumberSuccess;

  /// No description provided for @blockNumberFailed.
  ///
  /// In en, this message translates to:
  /// **'Block number failed'**
  String get blockNumberFailed;

  /// Confirmation message shown when a user tries to unblock a number from their blocklist.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unblock {phoneNumber}?'**
  String unblockNumberConfirmation(String phoneNumber);

  /// Status text displayed on the screen when an outgoing call is initiated.
  ///
  /// In en, this message translates to:
  /// **'Calling {phoneNumber}...'**
  String callingNumber(String phoneNumber);

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @unblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblock;

  /// No description provided for @unblockNumber.
  ///
  /// In en, this message translates to:
  /// **'Unblock Number'**
  String get unblockNumber;

  /// No description provided for @unblockNumberSuccess.
  ///
  /// In en, this message translates to:
  /// **'Number unblocked successfully'**
  String get unblockNumberSuccess;

  /// No description provided for @unblockNumberFailed.
  ///
  /// In en, this message translates to:
  /// **'Unblock number failed'**
  String get unblockNumberFailed;

  /// No description provided for @serviceNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Service not available'**
  String get serviceNotAvailable;

  /// No description provided for @callingNumberFailed.
  ///
  /// In en, this message translates to:
  /// **'Calling number failed'**
  String get callingNumberFailed;

  /// No description provided for @listView.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get listView;

  /// No description provided for @timelineView.
  ///
  /// In en, this message translates to:
  /// **'Timeline View'**
  String get timelineView;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty'**
  String get nameCannotBeEmpty;

  /// No description provided for @selectAction.
  ///
  /// In en, this message translates to:
  /// **'Select the action'**
  String get selectAction;

  /// No description provided for @selectTargetService.
  ///
  /// In en, this message translates to:
  /// **'Select the target service'**
  String get selectTargetService;

  /// No description provided for @callDetails.
  ///
  /// In en, this message translates to:
  /// **'Call Details'**
  String get callDetails;

  /// No description provided for @callType.
  ///
  /// In en, this message translates to:
  /// **'Call Type'**
  String get callType;

  /// No description provided for @callTime.
  ///
  /// In en, this message translates to:
  /// **'Call Time'**
  String get callTime;

  /// No description provided for @numberInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Number invalid format'**
  String get numberInvalidFormat;

  /// No description provided for @membershipFeature.
  ///
  /// In en, this message translates to:
  /// **'Membership Feature'**
  String get membershipFeature;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Verification report label
  ///
  /// In en, this message translates to:
  /// **'Verification Report'**
  String get verificationReport;

  /// No description provided for @finalRisk.
  ///
  /// In en, this message translates to:
  /// **'Final Risk'**
  String get finalRisk;

  /// No description provided for @simState.
  ///
  /// In en, this message translates to:
  /// **'SIM State'**
  String get simState;

  /// No description provided for @ipCountry.
  ///
  /// In en, this message translates to:
  /// **'IP Country'**
  String get ipCountry;

  /// No description provided for @simCountry.
  ///
  /// In en, this message translates to:
  /// **'SIM Country'**
  String get simCountry;

  /// No description provided for @isRoaming.
  ///
  /// In en, this message translates to:
  /// **'Roaming'**
  String get isRoaming;

  /// No description provided for @isNumberMatch.
  ///
  /// In en, this message translates to:
  /// **'Number Match'**
  String get isNumberMatch;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @rewardedAdService.
  ///
  /// In en, this message translates to:
  /// **'Rewarded Ad Service'**
  String get rewardedAdService;

  /// No description provided for @hasVipPrivilegeExceptAds.
  ///
  /// In en, this message translates to:
  /// **'You already have VIP privileges (except for ads)'**
  String get hasVipPrivilegeExceptAds;

  /// No description provided for @hasTempPrivilegeWithExpiry.
  ///
  /// In en, this message translates to:
  /// **'You already have temporary privileges, expiry date: {expiryDate}'**
  String hasTempPrivilegeWithExpiry(Object expiryDate);

  /// No description provided for @watchMoreAdsForTempVip.
  ///
  /// In en, this message translates to:
  /// **'You need to watch {count} more ads to get temporary VIP privileges'**
  String watchMoreAdsForTempVip(Object count);

  /// No description provided for @grantedTempPurchaseWithExpiry.
  ///
  /// In en, this message translates to:
  /// **'You have been granted {days} days of temporary purchase privileges. Expiry date: {expiryDate}'**
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate);

  /// No description provided for @tempPurchaseExpired.
  ///
  /// In en, this message translates to:
  /// **'Temporary purchase privilege has expired'**
  String get tempPurchaseExpired;

  /// No description provided for @loadingAd.
  ///
  /// In en, this message translates to:
  /// **'Loading Ad...'**
  String get loadingAd;

  /// No description provided for @earnedTempVip.
  ///
  /// In en, this message translates to:
  /// **'Earned temporary VIP'**
  String get earnedTempVip;

  /// No description provided for @vipExchangeService.
  ///
  /// In en, this message translates to:
  /// **'VIP Exchange Service'**
  String get vipExchangeService;

  /// No description provided for @marksInsufficient.
  ///
  /// In en, this message translates to:
  /// **'Insufficient marks to exchange'**
  String get marksInsufficient;

  /// No description provided for @invalidExchangeRule.
  ///
  /// In en, this message translates to:
  /// **'Invalid exchange rule'**
  String get invalidExchangeRule;

  /// No description provided for @exchangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully exchanged for {description}, expiry date: {expiryDate}'**
  String exchangeSuccess(Object description, Object expiryDate);

  /// No description provided for @exchangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Exchange failed: {error}'**
  String exchangeFailed(Object error);

  /// No description provided for @vip3DaysWithAds.
  ///
  /// In en, this message translates to:
  /// **'3-day VIP with ads (sync only)'**
  String get vip3DaysWithAds;

  /// No description provided for @vip5DaysNoAds.
  ///
  /// In en, this message translates to:
  /// **'5-day full-featured ad-free VIP'**
  String get vip5DaysNoAds;

  /// No description provided for @vip7DaysNoAds.
  ///
  /// In en, this message translates to:
  /// **'7-day full-featured ad-free VIP'**
  String get vip7DaysNoAds;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @clearAllNotifications.
  ///
  /// In en, this message translates to:
  /// **'Clear All Notifications'**
  String get clearAllNotifications;

  /// No description provided for @clearAllNotificationsConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm to clear all notifications'**
  String get clearAllNotificationsConfirmation;

  /// No description provided for @allNotificationsCleared.
  ///
  /// In en, this message translates to:
  /// **'All notifications cleared'**
  String get allNotificationsCleared;

  /// No description provided for @clearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButton;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// Relative time for minutes ago.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String minutesAgo(int count);

  /// Relative time for hours ago.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{1 hour ago} other{{count} hours ago}}'**
  String hoursAgo(int count);

  /// Relative time for days ago.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(int count);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Deletion proposal title
  ///
  /// In en, this message translates to:
  /// **'Deletion Proposal'**
  String get deletionProposal;

  /// Title for deletion proposals notification channel
  ///
  /// In en, this message translates to:
  /// **'Deletion Proposals'**
  String get deletionProposals;

  /// Create proposal button text
  ///
  /// In en, this message translates to:
  /// **'Create Proposal'**
  String get createProposal;

  /// Create proposal dialog title
  ///
  /// In en, this message translates to:
  /// **'Create Deletion Proposal'**
  String get createProposalTitle;

  /// Reason label
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// Outdated Number reason option
  ///
  /// In en, this message translates to:
  /// **'Outdated Number'**
  String get reasonOutdated;

  /// Privacy Concern reason option
  ///
  /// In en, this message translates to:
  /// **'Privacy Concern'**
  String get reasonPrivacy;

  /// Not in Service reason option
  ///
  /// In en, this message translates to:
  /// **'Not in Service'**
  String get reasonNotInService;

  /// Wrongly Identified reason option
  ///
  /// In en, this message translates to:
  /// **'Wrongly Identified'**
  String get reasonWronglyIdentified;

  /// Inaccurate Information reason option
  ///
  /// In en, this message translates to:
  /// **'Inaccurate Information'**
  String get reasonInaccurateInfo;

  /// Wrong marked reason option
  ///
  /// In en, this message translates to:
  /// **'Wrong Marked'**
  String get reasonWrongMarked;

  /// Other reason option
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get reasonOther;

  /// Submit button text
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Proposal status label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get proposalStatus;

  /// Pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// Expired status
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// Risk level label
  ///
  /// In en, this message translates to:
  /// **'Risk Level'**
  String get riskLevel;

  /// Verified risk level
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get riskLevelVerified;

  /// Low risk level
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get riskLevelLow;

  /// High risk level
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get riskLevelHigh;

  /// Unknown risk level
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get riskLevelUnknown;

  /// Voting progress label
  ///
  /// In en, this message translates to:
  /// **'Voting Progress'**
  String get votingProgress;

  /// Agree votes count
  ///
  /// In en, this message translates to:
  /// **'Agree: {count}'**
  String agreeVotes(int count);

  /// Disagree votes count
  ///
  /// In en, this message translates to:
  /// **'Disagree: {count}'**
  String disagreeVotes(int count);

  /// Total votes count
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String totalVotes(int count);

  /// Vote agree button text
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get voteAgree;

  /// Vote disagree button text
  ///
  /// In en, this message translates to:
  /// **'Disagree'**
  String get voteDisagree;

  /// Created date label
  ///
  /// In en, this message translates to:
  /// **'Created: {date}'**
  String createdAt(String date);

  /// Show report button text
  ///
  /// In en, this message translates to:
  /// **'Show Report'**
  String get showReport;

  /// Hide report button text
  ///
  /// In en, this message translates to:
  /// **'Hide Report'**
  String get hideReport;

  /// Proposal statistics title
  ///
  /// In en, this message translates to:
  /// **'Proposal Statistics'**
  String get proposalStatistics;

  /// Total proposals label
  ///
  /// In en, this message translates to:
  /// **'Total Proposals'**
  String get totalProposals;

  /// Active proposals label
  ///
  /// In en, this message translates to:
  /// **'Active Proposals'**
  String get activeProposals;

  /// Completed proposals label
  ///
  /// In en, this message translates to:
  /// **'Completed Proposals'**
  String get completedProposals;

  /// My votes label
  ///
  /// In en, this message translates to:
  /// **'My Votes'**
  String get myVotes;

  /// Proposal created success message
  ///
  /// In en, this message translates to:
  /// **'Proposal created successfully'**
  String get proposalCreated;

  /// Proposal create failed message
  ///
  /// In en, this message translates to:
  /// **'Failed to create proposal'**
  String get proposalCreateFailed;

  /// Vote submitted success message
  ///
  /// In en, this message translates to:
  /// **'Vote submitted successfully'**
  String get voteSubmitted;

  /// Vote submit failed message
  ///
  /// In en, this message translates to:
  /// **'Failed to submit vote'**
  String get voteSubmitFailed;

  /// No proposals found message
  ///
  /// In en, this message translates to:
  /// **'No proposals found'**
  String get noProposalsFound;

  /// Loading proposals message
  ///
  /// In en, this message translates to:
  /// **'Loading proposals...'**
  String get loadingProposals;

  /// Refresh proposals button text
  ///
  /// In en, this message translates to:
  /// **'Refresh Proposals'**
  String get refreshProposals;

  /// Total pending proposals label
  ///
  /// In en, this message translates to:
  /// **'Total Pending Proposals'**
  String get totalPendingProposals;

  /// High risk label
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get highRisk;

  /// Medium risk label
  ///
  /// In en, this message translates to:
  /// **'Medium Risk'**
  String get mediumRisk;

  /// Low risk label
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get lowRisk;

  /// Community impact label
  ///
  /// In en, this message translates to:
  /// **'Community Impact'**
  String get communityImpact;

  /// Critical issues label
  ///
  /// In en, this message translates to:
  /// **'Critical Issues'**
  String get criticalIssues;

  /// Community participation label
  ///
  /// In en, this message translates to:
  /// **'Community Participation'**
  String get communityParticipation;

  /// No activity label
  ///
  /// In en, this message translates to:
  /// **'No Activity'**
  String get noActivity;

  /// Low level label
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// Moderate level label
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// High level label
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// Very high level label
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get veryHigh;

  /// Label for when user voted
  ///
  /// In en, this message translates to:
  /// **'Voted'**
  String get voted;

  /// Label for community votes count
  ///
  /// In en, this message translates to:
  /// **'Community votes'**
  String get communityVotes;

  /// Message when waiting for more votes
  ///
  /// In en, this message translates to:
  /// **'Waiting for more community votes'**
  String get waitingForMoreVotes;

  /// Message when proposal is completed
  ///
  /// In en, this message translates to:
  /// **'This proposal has been processed'**
  String get proposalProcessed;

  /// Label for supported vote
  ///
  /// In en, this message translates to:
  /// **'SUPPORTED'**
  String get supported;

  /// Label for opposed vote
  ///
  /// In en, this message translates to:
  /// **'OPPOSED'**
  String get opposed;

  /// Status label for approved
  ///
  /// In en, this message translates to:
  /// **'APPROVED'**
  String get approved;

  /// Status label for rejected
  ///
  /// In en, this message translates to:
  /// **'REJECTED'**
  String get rejected;

  /// Status label for completed
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get completed;

  /// Status label for pending
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pending;

  /// Critical risk level label
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// Label for oppose votes
  ///
  /// In en, this message translates to:
  /// **'Oppose'**
  String get oppose;

  /// Very low risk level label
  ///
  /// In en, this message translates to:
  /// **'Very Low'**
  String get veryLow;

  /// Description for deletion proposal notification channel
  ///
  /// In en, this message translates to:
  /// **'Notifications about deletion proposal voting results and updates.'**
  String get deletionProposalNotificationDescription;

  /// Title for deletion proposal created notification
  ///
  /// In en, this message translates to:
  /// **'Deletion Proposal Created'**
  String get deletionProposalCreated;

  /// Body text for deletion proposal created notification
  ///
  /// In en, this message translates to:
  /// **'Your deletion proposal for {phoneNumber} has been submitted for community review.'**
  String deletionProposalCreatedBody(String phoneNumber);

  /// Title for proposal approved notification
  ///
  /// In en, this message translates to:
  /// **'Proposal Approved ✅'**
  String get proposalApproved;

  /// Body text for proposal approved notification
  ///
  /// In en, this message translates to:
  /// **'The deletion proposal for {phoneNumber} has been approved by the community ({supportPercentage}% support, {totalVotes} votes).'**
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  );

  /// Title for proposal rejected notification
  ///
  /// In en, this message translates to:
  /// **'Proposal Rejected ❌'**
  String get proposalRejected;

  /// Body text for proposal rejected notification
  ///
  /// In en, this message translates to:
  /// **'The deletion proposal for {phoneNumber} has been rejected by the community ({supportPercentage}% support, {totalVotes} votes).'**
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  );

  /// Title for community voting started notification
  ///
  /// In en, this message translates to:
  /// **'Community Voting Started'**
  String get communityVotingStarted;

  /// Body text for community voting started notification
  ///
  /// In en, this message translates to:
  /// **'A new deletion proposal for {phoneNumber} is now open for community voting.'**
  String communityVotingStartedBody(String phoneNumber);

  /// Title for voting completed notification
  ///
  /// In en, this message translates to:
  /// **'Voting Completed'**
  String get votingCompleted;

  /// Body text for voting completed notification
  ///
  /// In en, this message translates to:
  /// **'Community voting for {phoneNumber} has ended. Result: {result} ({supportPercentage}% support).'**
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  );

  /// Title for new vote received notification
  ///
  /// In en, this message translates to:
  /// **'New Vote Received'**
  String get newVoteReceived;

  /// Body text for new vote received notification
  ///
  /// In en, this message translates to:
  /// **'Someone voted to {voteType} the deletion of {phoneNumber}. Current votes: {totalVotes}.'**
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  );

  /// No description provided for @loadVoteCountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load vote count'**
  String get loadVoteCountFailed;

  /// No description provided for @voteCount.
  ///
  /// In en, this message translates to:
  /// **'Vote Count'**
  String get voteCount;

  /// No description provided for @deletionProposalInfo.
  ///
  /// In en, this message translates to:
  /// **'Deletion Proposal Information'**
  String get deletionProposalInfo;

  /// No description provided for @deletionProposalDescription.
  ///
  /// In en, this message translates to:
  /// **'Propose numbers for deletion that violate community guidelines. Your participation helps keep the platform safe.'**
  String get deletionProposalDescription;

  /// No description provided for @voteToEarnVip.
  ///
  /// In en, this message translates to:
  /// **'Vote on proposals to earn VIP privileges!'**
  String get voteToEarnVip;

  /// No description provided for @voteFailed.
  ///
  /// In en, this message translates to:
  /// **'Vote failed'**
  String get voteFailed;

  /// No description provided for @searchProposals.
  ///
  /// In en, this message translates to:
  /// **'Search Proposals'**
  String get searchProposals;

  /// No description provided for @defaultNotifications.
  ///
  /// In en, this message translates to:
  /// **'Default Notifications'**
  String get defaultNotifications;

  /// No description provided for @defaultNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Default notification channel for the app.'**
  String get defaultNotificationsDescription;

  /// No description provided for @blockedCallNotifications.
  ///
  /// In en, this message translates to:
  /// **'Blocked Call Notifications'**
  String get blockedCallNotifications;

  /// No description provided for @blockedCallNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Displays information about blocked calls.'**
  String get blockedCallNotificationsDescription;

  /// No description provided for @stirVerification.
  ///
  /// In en, this message translates to:
  /// **'STIR/SHAKEN Verification'**
  String get stirVerification;

  /// No description provided for @stirVerificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Displays STIR/SHAKEN verification results for numbers.'**
  String get stirVerificationDescription;

  /// No description provided for @fraudAlerts.
  ///
  /// In en, this message translates to:
  /// **'Fraud Alerts'**
  String get fraudAlerts;

  /// No description provided for @fraudAlertsDescription.
  ///
  /// In en, this message translates to:
  /// **'Displays warnings for potential fraudulent calls.'**
  String get fraudAlertsDescription;

  /// A detailed explanation of what the notification frequency settings do
  ///
  /// In en, this message translates to:
  /// **'Choose how often you receive notifications about new deletion proposals. You can receive them immediately, in batches, or at a custom interval.'**
  String get notificationFrequencyDescription;

  /// Label for the immediate notification mode
  ///
  /// In en, this message translates to:
  /// **'Immediate'**
  String get immediateNotifications;

  /// Description for the immediate notification mode
  ///
  /// In en, this message translates to:
  /// **'Receive a notification as soon as a proposal is created.'**
  String get immediateNotificationsDescription;

  /// Label for the batched notification mode
  ///
  /// In en, this message translates to:
  /// **'Batched'**
  String get batchNotifications;

  /// Description for the batched notification mode
  ///
  /// In en, this message translates to:
  /// **'Receive a summary of notifications periodically.'**
  String get batchNotificationsDescription;

  /// Label for the custom notification mode
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customNotifications;

  /// Description for the custom notification mode
  ///
  /// In en, this message translates to:
  /// **'Define your own interval for receiving notifications.'**
  String get customNotificationsDescription;

  /// Title for the custom frequency slider section
  ///
  /// In en, this message translates to:
  /// **'Custom Frequency'**
  String get customFrequency;

  /// Formats a duration that is only in minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String notificationFrequencyDurationMinutes(int minutes);

  /// Formats a duration that is in whole hours.
  ///
  /// In en, this message translates to:
  /// **'{hours} h'**
  String notificationFrequencyDurationHours(int hours);

  /// Formats a duration that has both hours and minutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes);

  /// No description provided for @pendingProposals.
  ///
  /// In en, this message translates to:
  /// **'Pending Proposals'**
  String get pendingProposals;

  /// No description provided for @pendingProposalsBody.
  ///
  /// In en, this message translates to:
  /// **'You have {count, plural, =0 {no pending proposals} one {1 pending proposal} other {{count} pending proposals}}.'**
  String pendingProposalsBody(num count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
