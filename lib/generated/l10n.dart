// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Import Configuration`
  String get importConfiguration {
    return Intl.message(
      'Import Configuration',
      name: 'importConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Paste JSON`
  String get pasteJson {
    return Intl.message(
      'Paste JSON',
      name: 'pasteJson',
      desc: '',
      args: [],
    );
  }

  /// `Import from file`
  String get importFromFile {
    return Intl.message(
      'Import from file',
      name: 'importFromFile',
      desc: '',
      args: [],
    );
  }

  /// `Customize Caller ID`
  String get customizeCallerId {
    return Intl.message(
      'Customize Caller ID',
      name: 'customizeCallerId',
      desc: '',
      args: [],
    );
  }

  /// `Window Size`
  String get windowSize {
    return Intl.message(
      'Window Size',
      name: 'windowSize',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Paste JSON Configuration`
  String get pasteJsonConfiguration {
    return Intl.message(
      'Paste JSON Configuration',
      name: 'pasteJsonConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `Paste JSON here`
  String get pasteJsonHere {
    return Intl.message(
      'Paste JSON here',
      name: 'pasteJsonHere',
      desc: '',
      args: [],
    );
  }

  /// `Configuration imported`
  String get configurationImported {
    return Intl.message(
      'Configuration imported',
      name: 'configurationImported',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Background Gradient`
  String get backgroundGradient {
    return Intl.message(
      'Background Gradient',
      name: 'backgroundGradient',
      desc: '',
      args: [],
    );
  }

  /// `Text & Label Colors`
  String get textLabelColors {
    return Intl.message(
      'Text & Label Colors',
      name: 'textLabelColors',
      desc: '',
      args: [],
    );
  }

  /// `Avatar and Icon Sizes`
  String get avatarAndIconSizes {
    return Intl.message(
      'Avatar and Icon Sizes',
      name: 'avatarAndIconSizes',
      desc: '',
      args: [],
    );
  }

  /// `Element Positions`
  String get elementPositions {
    return Intl.message(
      'Element Positions',
      name: 'elementPositions',
      desc: '',
      args: [],
    );
  }

  /// `Configuration imported Successfully`
  String get configurationImportedSuccessfully {
    return Intl.message(
      'Configuration imported Successfully',
      name: 'configurationImportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Invalid JSON format`
  String get invalidJsonFormat {
    return Intl.message(
      'Invalid JSON format',
      name: 'invalidJsonFormat',
      desc: '',
      args: [],
    );
  }

  /// `Configuration exported to file!`
  String get configurationExportedToFile {
    return Intl.message(
      'Configuration exported to file!',
      name: 'configurationExportedToFile',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message(
      'Export',
      name: 'export',
      desc: '',
      args: [],
    );
  }

  /// `Configuration Saved!`
  String get configurationSaved {
    return Intl.message(
      'Configuration Saved!',
      name: 'configurationSaved',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Width`
  String get width {
    return Intl.message(
      'Width',
      name: 'width',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Start Color`
  String get startColor {
    return Intl.message(
      'Start Color',
      name: 'startColor',
      desc: '',
      args: [],
    );
  }

  /// `End Color`
  String get endColor {
    return Intl.message(
      'End Color',
      name: 'endColor',
      desc: '',
      args: [],
    );
  }

  /// `Label Icon Color`
  String get labelIconColor {
    return Intl.message(
      'Label Icon Color',
      name: 'labelIconColor',
      desc: '',
      args: [],
    );
  }

  /// `Location Icon Color`
  String get locationIconColor {
    return Intl.message(
      'Location Icon Color',
      name: 'locationIconColor',
      desc: '',
      args: [],
    );
  }

  /// `CallType Icon Color`
  String get calltypeIconColor {
    return Intl.message(
      'CallType Icon Color',
      name: 'calltypeIconColor',
      desc: '',
      args: [],
    );
  }

  /// `Avatar Border Color`
  String get avatarBorderColor {
    return Intl.message(
      'Avatar Border Color',
      name: 'avatarBorderColor',
      desc: '',
      args: [],
    );
  }

  /// `Name Color`
  String get nameColor {
    return Intl.message(
      'Name Color',
      name: 'nameColor',
      desc: '',
      args: [],
    );
  }

  /// `Number Color`
  String get numberColor {
    return Intl.message(
      'Number Color',
      name: 'numberColor',
      desc: '',
      args: [],
    );
  }

  /// `Location Color`
  String get locationColor {
    return Intl.message(
      'Location Color',
      name: 'locationColor',
      desc: '',
      args: [],
    );
  }

  /// `Carrier Color`
  String get carrierColor {
    return Intl.message(
      'Carrier Color',
      name: 'carrierColor',
      desc: '',
      args: [],
    );
  }

  /// `Country Name Color`
  String get countryNameColor {
    return Intl.message(
      'Country Name Color',
      name: 'countryNameColor',
      desc: '',
      args: [],
    );
  }

  /// `Labels Color`
  String get labelsColor {
    return Intl.message(
      'Labels Color',
      name: 'labelsColor',
      desc: '',
      args: [],
    );
  }

  /// `Count Color`
  String get countColor {
    return Intl.message(
      'Count Color',
      name: 'countColor',
      desc: '',
      args: [],
    );
  }

  /// `Number Type Color`
  String get numberTypeColor {
    return Intl.message(
      'Number Type Color',
      name: 'numberTypeColor',
      desc: '',
      args: [],
    );
  }

  /// `Stir Color`
  String get stirColor {
    return Intl.message(
      'Stir Color',
      name: 'stirColor',
      desc: '',
      args: [],
    );
  }

  /// `SIM Card Color`
  String get simCardColor {
    return Intl.message(
      'SIM Card Color',
      name: 'simCardColor',
      desc: '',
      args: [],
    );
  }

  /// `Name Font Size`
  String get nameFontSize {
    return Intl.message(
      'Name Font Size',
      name: 'nameFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Carrier Font Size`
  String get carrierFontSize {
    return Intl.message(
      'Carrier Font Size',
      name: 'carrierFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Country Name Font Size`
  String get countryNameFontSize {
    return Intl.message(
      'Country Name Font Size',
      name: 'countryNameFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Labels Font Size`
  String get labelsFontSize {
    return Intl.message(
      'Labels Font Size',
      name: 'labelsFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Count Font Size`
  String get countFontSize {
    return Intl.message(
      'Count Font Size',
      name: 'countFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Number Type Font Size`
  String get numberTypeFontSize {
    return Intl.message(
      'Number Type Font Size',
      name: 'numberTypeFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Number Font Size`
  String get numberFontSize {
    return Intl.message(
      'Number Font Size',
      name: 'numberFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Location Font Size`
  String get locationFontSize {
    return Intl.message(
      'Location Font Size',
      name: 'locationFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Stir Font Size`
  String get stirFontSize {
    return Intl.message(
      'Stir Font Size',
      name: 'stirFontSize',
      desc: '',
      args: [],
    );
  }

  /// `SIM Card Font Size`
  String get simCardFontSize {
    return Intl.message(
      'SIM Card Font Size',
      name: 'simCardFontSize',
      desc: '',
      args: [],
    );
  }

  /// `Avatar Size`
  String get avatarSize {
    return Intl.message(
      'Avatar Size',
      name: 'avatarSize',
      desc: '',
      args: [],
    );
  }

  /// `Avatar Border Size`
  String get avatarBorderSize {
    return Intl.message(
      'Avatar Border Size',
      name: 'avatarBorderSize',
      desc: '',
      args: [],
    );
  }

  /// `Icon Size`
  String get iconSize {
    return Intl.message(
      'Icon Size',
      name: 'iconSize',
      desc: '',
      args: [],
    );
  }

  /// `Avatar Position`
  String get avatarPosition {
    return Intl.message(
      'Avatar Position',
      name: 'avatarPosition',
      desc: '',
      args: [],
    );
  }

  /// `Name Position`
  String get namePosition {
    return Intl.message(
      'Name Position',
      name: 'namePosition',
      desc: '',
      args: [],
    );
  }

  /// `Carrier Position`
  String get carrierPosition {
    return Intl.message(
      'Carrier Position',
      name: 'carrierPosition',
      desc: '',
      args: [],
    );
  }

  /// `Country Name Position`
  String get countryNamePosition {
    return Intl.message(
      'Country Name Position',
      name: 'countryNamePosition',
      desc: '',
      args: [],
    );
  }

  /// `Labels Position`
  String get labelsPosition {
    return Intl.message(
      'Labels Position',
      name: 'labelsPosition',
      desc: '',
      args: [],
    );
  }

  /// `Count Position`
  String get countPosition {
    return Intl.message(
      'Count Position',
      name: 'countPosition',
      desc: '',
      args: [],
    );
  }

  /// `Number Type Position`
  String get numberTypePosition {
    return Intl.message(
      'Number Type Position',
      name: 'numberTypePosition',
      desc: '',
      args: [],
    );
  }

  /// `Number Position`
  String get numberPosition {
    return Intl.message(
      'Number Position',
      name: 'numberPosition',
      desc: '',
      args: [],
    );
  }

  /// `Location Position`
  String get locationPosition {
    return Intl.message(
      'Location Position',
      name: 'locationPosition',
      desc: '',
      args: [],
    );
  }

  /// `Stir Position`
  String get stirPosition {
    return Intl.message(
      'Stir Position',
      name: 'stirPosition',
      desc: '',
      args: [],
    );
  }

  /// `Sim Card Position`
  String get simCardPosition {
    return Intl.message(
      'Sim Card Position',
      name: 'simCardPosition',
      desc: '',
      args: [],
    );
  }

  /// `Select Color`
  String get selectColor {
    return Intl.message(
      'Select Color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `STIR Verified`
  String get verified {
    return Intl.message(
      'STIR Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `STIR Not Verified`
  String get notVerified {
    return Intl.message(
      'STIR Not Verified',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Marked by`
  String get markedBy {
    return Intl.message(
      'Marked by',
      name: 'markedBy',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get localCard1 {
    return Intl.message(
      'Notice',
      name: 'localCard1',
      desc: '',
      args: [],
    );
  }

  /// `To ensure your security, please use only subscription sources that you trust. we are not responsible for this`
  String get localCard1Content {
    return Intl.message(
      'To ensure your security, please use only subscription sources that you trust. we are not responsible for this',
      name: 'localCard1Content',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Calls Statistics`
  String get blockedCallsStatistics {
    return Intl.message(
      'Blocked Calls Statistics',
      name: 'blockedCallsStatistics',
      desc: '',
      args: [],
    );
  }

  /// `Caller ID Style`
  String get callerIdStyle {
    return Intl.message(
      'Caller ID Style',
      name: 'callerIdStyle',
      desc: '',
      args: [],
    );
  }

  /// `customize caller ID style`
  String get callerIdStyleContent {
    return Intl.message(
      'customize caller ID style',
      name: 'callerIdStyleContent',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist`
  String get whitelist {
    return Intl.message(
      'Whitelist',
      name: 'whitelist',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist`
  String get blacklist {
    return Intl.message(
      'Blacklist',
      name: 'blacklist',
      desc: '',
      args: [],
    );
  }

  /// `Allowed`
  String get allowed {
    return Intl.message(
      'Allowed',
      name: 'allowed',
      desc: '',
      args: [],
    );
  }

  /// `Blocked`
  String get blocked {
    return Intl.message(
      'Blocked',
      name: 'blocked',
      desc: '',
      args: [],
    );
  }

  /// `Regex`
  String get regex {
    return Intl.message(
      'Regex',
      name: 'regex',
      desc: '',
      args: [],
    );
  }

  /// `Sync`
  String get sync {
    return Intl.message(
      'Sync',
      name: 'sync',
      desc: '',
      args: [],
    );
  }

  /// `Label`
  String get label {
    return Intl.message(
      'Label',
      name: 'label',
      desc: '',
      args: [],
    );
  }

  /// `Plugins`
  String get plugins {
    return Intl.message(
      'Plugins',
      name: 'plugins',
      desc: '',
      args: [],
    );
  }

  /// `Manage Rules`
  String get manageRules {
    return Intl.message(
      'Manage Rules',
      name: 'manageRules',
      desc: '',
      args: [],
    );
  }

  /// `Allow All Allowed Numbers`
  String get allowAllAllowedNumbers {
    return Intl.message(
      'Allow All Allowed Numbers',
      name: 'allowAllAllowedNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Allow Regex Blacklisted Patterns`
  String get allowRegexBlacklistedPatterns {
    return Intl.message(
      'Allow Regex Blacklisted Patterns',
      name: 'allowRegexBlacklistedPatterns',
      desc: '',
      args: [],
    );
  }

  /// `Allow All Whitelisted Numbers`
  String get allowAllWhitelistedNumbers {
    return Intl.message(
      'Allow All Whitelisted Numbers',
      name: 'allowAllWhitelistedNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Allow Blocked Numbers`
  String get allowBlockedNumbers {
    return Intl.message(
      'Allow Blocked Numbers',
      name: 'allowBlockedNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Allow Regex Whitelisted Patterns`
  String get allowRegexWhitelistedPatterns {
    return Intl.message(
      'Allow Regex Whitelisted Patterns',
      name: 'allowRegexWhitelistedPatterns',
      desc: '',
      args: [],
    );
  }

  /// `Allow All Blacklisted Numbers`
  String get allowAllBlacklistedNumbers {
    return Intl.message(
      'Allow All Blacklisted Numbers',
      name: 'allowAllBlacklistedNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Reject All Numbers`
  String get rejectAllNumbers {
    return Intl.message(
      'Reject All Numbers',
      name: 'rejectAllNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Repeated Blocked Calls in`
  String get repeatedBlockedCallsIn {
    return Intl.message(
      'Repeated Blocked Calls in',
      name: 'repeatedBlockedCallsIn',
      desc: '',
      args: [],
    );
  }

  /// `mins`
  String get mins {
    return Intl.message(
      'mins',
      name: 'mins',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `endCall`
  String get endcall {
    return Intl.message(
      'endCall',
      name: 'endcall',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Initializing...`
  String get initializing {
    return Intl.message(
      'Initializing...',
      name: 'initializing',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Initializing database...`
  String get initializingDatabase {
    return Intl.message(
      'Initializing database...',
      name: 'initializingDatabase',
      desc: '',
      args: [],
    );
  }

  /// `Please wait for database initialization to complete.`
  String get pleaseWaitForDatabaseInitializationToComplete {
    return Intl.message(
      'Please wait for database initialization to complete.',
      name: 'pleaseWaitForDatabaseInitializationToComplete',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Language`
  String get chooseYourLanguage {
    return Intl.message(
      'Choose Your Language',
      name: 'chooseYourLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Enable Overlay Permission`
  String get enableOverlayPermission {
    return Intl.message(
      'Enable Overlay Permission',
      name: 'enableOverlayPermission',
      desc: '',
      args: [],
    );
  }

  /// `This permission is required for our app to display important information on top of other apps.\n\n`
  String get thisPermissionIsRequiredForOurAppToDisplayImportant {
    return Intl.message(
      'This permission is required for our app to display important information on top of other apps.\\n\\n',
      name: 'thisPermissionIsRequiredForOurAppToDisplayImportant',
      desc: '',
      args: [],
    );
  }

  /// `Please tap "Grant Permission" and allow the permission in the next screen.`
  String get pleaseTapGrantPermissionAndAllowThePermissionInThe {
    return Intl.message(
      'Please tap "Grant Permission" and allow the permission in the next screen.',
      name: 'pleaseTapGrantPermissionAndAllowThePermissionInThe',
      desc: '',
      args: [],
    );
  }

  /// `You have enabled the permission.`
  String get youHaveEnabledThePermission {
    return Intl.message(
      'You have enabled the permission.',
      name: 'youHaveEnabledThePermission',
      desc: '',
      args: [],
    );
  }

  /// `Overlay permission not granted, which may affect the caller ID display function. You can enable the permission in the app settings.`
  String get overlayPermissionNotGrantedWhichMayAffectTheCallerId {
    return Intl.message(
      'Overlay permission not granted, which may affect the caller ID display function. You can enable the permission in the app settings.',
      name: 'overlayPermissionNotGrantedWhichMayAffectTheCallerId',
      desc: '',
      args: [],
    );
  }

  /// `Grant Permission`
  String get grantPermission {
    return Intl.message(
      'Grant Permission',
      name: 'grantPermission',
      desc: '',
      args: [],
    );
  }

  /// `This permission is required for our app to be the default caller id app.`
  String get thisPermissionIsRequiredForOurAppToBeThe {
    return Intl.message(
      'This permission is required for our app to be the default caller id app.',
      name: 'thisPermissionIsRequiredForOurAppToBeThe',
      desc: '',
      args: [],
    );
  }

  /// `Please tap "SetUp Default" and allow the permission in the next screen.`
  String get pleaseTapSetupDefaultAndAllowThePermissionInThe {
    return Intl.message(
      'Please tap "SetUp Default" and allow the permission in the next screen.',
      name: 'pleaseTapSetupDefaultAndAllowThePermissionInThe',
      desc: '',
      args: [],
    );
  }

  /// `Call screening role request successful!`
  String get callScreeningRoleRequestSuccessful {
    return Intl.message(
      'Call screening role request successful!',
      name: 'callScreeningRoleRequestSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Call screening role request failed!`
  String get callScreeningRoleRequestFailed {
    return Intl.message(
      'Call screening role request failed!',
      name: 'callScreeningRoleRequestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Error requesting call screening role:`
  String get errorRequestingCallScreeningRole {
    return Intl.message(
      'Error requesting call screening role:',
      name: 'errorRequestingCallScreeningRole',
      desc: '',
      args: [],
    );
  }

  /// `SetUp Default`
  String get setupDefault {
    return Intl.message(
      'SetUp Default',
      name: 'setupDefault',
      desc: '',
      args: [],
    );
  }

  /// `Feature`
  String get feature {
    return Intl.message(
      'Feature',
      name: 'feature',
      desc: '',
      args: [],
    );
  }

  /// `Supporting Subscription`
  String get feature1 {
    return Intl.message(
      'Supporting Subscription',
      name: 'feature1',
      desc: '',
      args: [],
    );
  }

  /// `Supporting Regex`
  String get feature2 {
    return Intl.message(
      'Supporting Regex',
      name: 'feature2',
      desc: '',
      args: [],
    );
  }

  /// `privacy`
  String get feature3 {
    return Intl.message(
      'privacy',
      name: 'feature3',
      desc: '',
      args: [],
    );
  }

  /// `feature description`
  String get featureDescription {
    return Intl.message(
      'feature description',
      name: 'featureDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved`
  String get settingsSaved {
    return Intl.message(
      'Settings saved',
      name: 'settingsSaved',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Ad Enabled:`
  String get adEnabled {
    return Intl.message(
      'Ad Enabled:',
      name: 'adEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message(
      'Enabled',
      name: 'enabled',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Remove ADs and Enable Online Backup`
  String get removeAdsAndEnableOnlineBackup {
    return Intl.message(
      'Remove ADs and Enable Online Backup',
      name: 'removeAdsAndEnableOnlineBackup',
      desc: '',
      args: [],
    );
  }

  /// `Enable to remove ads`
  String get enableToRemoveAds {
    return Intl.message(
      'Enable to remove ads',
      name: 'enableToRemoveAds',
      desc: '',
      args: [],
    );
  }

  /// `In-app purchases enabled`
  String get inappPurchasesEnabled {
    return Intl.message(
      'In-app purchases enabled',
      name: 'inappPurchasesEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Call Action`
  String get blockedCallAction {
    return Intl.message(
      'Blocked Call Action',
      name: 'blockedCallAction',
      desc: '',
      args: [],
    );
  }

  /// `Repeated Calls`
  String get repeatedCalls {
    return Intl.message(
      'Repeated Calls',
      name: 'repeatedCalls',
      desc: '',
      args: [],
    );
  }

  /// `AnswerThenHangup`
  String get answerthenhangup {
    return Intl.message(
      'AnswerThenHangup',
      name: 'answerthenhangup',
      desc: '',
      args: [],
    );
  }

  /// `SilenceNoAnswer`
  String get silencenoanswer {
    return Intl.message(
      'SilenceNoAnswer',
      name: 'silencenoanswer',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Call Notification`
  String get blockedCallNotification {
    return Intl.message(
      'Blocked Call Notification',
      name: 'blockedCallNotification',
      desc: '',
      args: [],
    );
  }

  /// `Enable Blocked Call Notification`
  String get enableBlockedCallNotification {
    return Intl.message(
      'Enable Blocked Call Notification',
      name: 'enableBlockedCallNotification',
      desc: '',
      args: [],
    );
  }

  /// `Disable Blocked Call Notification`
  String get disableBlockedCallNotification {
    return Intl.message(
      'Disable Blocked Call Notification',
      name: 'disableBlockedCallNotification',
      desc: '',
      args: [],
    );
  }

  /// `Auto Close Local Notification`
  String get autoCloseLocalNotification {
    return Intl.message(
      'Auto Close Local Notification',
      name: 'autoCloseLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Only Original Call App Notification`
  String get onlyOriginalCallAppNotification {
    return Intl.message(
      'Only Original Call App Notification',
      name: 'onlyOriginalCallAppNotification',
      desc: '',
      args: [],
    );
  }

  /// `Both Original Call App & Local Notification`
  String get bothOriginalCallAppLocalNotification {
    return Intl.message(
      'Both Original Call App & Local Notification',
      name: 'bothOriginalCallAppLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Statistics Time Range (minutes):`
  String get statisticsTimeRangeMinutes {
    return Intl.message(
      'Statistics Time Range (minutes):',
      name: 'statisticsTimeRangeMinutes',
      desc: '',
      args: [],
    );
  }

  /// `Intercept repeated incoming calls within the time range`
  String get interceptRepeatedIncomingCallsWithinTheTimeRange {
    return Intl.message(
      'Intercept repeated incoming calls within the time range',
      name: 'interceptRepeatedIncomingCallsWithinTheTimeRange',
      desc: '',
      args: [],
    );
  }

  /// `Allow Repeated incoming calls`
  String get allowRepeatedIncomingCalls {
    return Intl.message(
      'Allow Repeated incoming calls',
      name: 'allowRepeatedIncomingCalls',
      desc: '',
      args: [],
    );
  }

  /// `Filter Repeated incoming calls`
  String get filterRepeatedIncomingCalls {
    return Intl.message(
      'Filter Repeated incoming calls',
      name: 'filterRepeatedIncomingCalls',
      desc: '',
      args: [],
    );
  }

  /// `SMS Notification`
  String get smsNotification {
    return Intl.message(
      'SMS Notification',
      name: 'smsNotification',
      desc: '',
      args: [],
    );
  }

  /// `SMS Filtering`
  String get smsFiltering {
    return Intl.message(
      'SMS Filtering',
      name: 'smsFiltering',
      desc: '',
      args: [],
    );
  }

  /// `Filter incoming SMS messages`
  String get filterIncomingSmsMessages {
    return Intl.message(
      'Filter incoming SMS messages',
      name: 'filterIncomingSmsMessages',
      desc: '',
      args: [],
    );
  }

  /// `No incoming SMS messages Filter`
  String get noIncomingSmsMessagesFilter {
    return Intl.message(
      'No incoming SMS messages Filter',
      name: 'noIncomingSmsMessagesFilter',
      desc: '',
      args: [],
    );
  }

  /// `SMS Local Notification`
  String get smsLocalNotification {
    return Intl.message(
      'SMS Local Notification',
      name: 'smsLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Enable SMS Local Notification`
  String get enableSmsLocalNotification {
    return Intl.message(
      'Enable SMS Local Notification',
      name: 'enableSmsLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Disable SMS Local Notification`
  String get disableSmsLocalNotification {
    return Intl.message(
      'Disable SMS Local Notification',
      name: 'disableSmsLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Choose the default Intercept Action`
  String get chooseTheDefaultInterceptAction {
    return Intl.message(
      'Choose the default Intercept Action',
      name: 'chooseTheDefaultInterceptAction',
      desc: '',
      args: [],
    );
  }

  /// `Incoming Call Intercept Action`
  String get incomingCallInterceptAction {
    return Intl.message(
      'Incoming Call Intercept Action',
      name: 'incomingCallInterceptAction',
      desc: '',
      args: [],
    );
  }

  /// `Only Ring Local Notification`
  String get onlyRingLocalNotification {
    return Intl.message(
      'Only Ring Local Notification',
      name: 'onlyRingLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Only Use Original SMS Notification`
  String get onlyUseOriginalSmsNotification {
    return Intl.message(
      'Only Use Original SMS Notification',
      name: 'onlyUseOriginalSmsNotification',
      desc: '',
      args: [],
    );
  }

  /// `Both Original SMS & Local Notification`
  String get bothOriginalSmsLocalNotification {
    return Intl.message(
      'Both Original SMS & Local Notification',
      name: 'bothOriginalSmsLocalNotification',
      desc: '',
      args: [],
    );
  }

  /// `Permissions Required`
  String get permissionsRequired {
    return Intl.message(
      'Permissions Required',
      name: 'permissionsRequired',
      desc: '',
      args: [],
    );
  }

  /// `SMS filtering requires SMS, notification, and phone permissions. Please grant these permissions to enable this feature.`
  String get smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant {
    return Intl.message(
      'SMS filtering requires SMS, notification, and phone permissions. Please grant these permissions to enable this feature.',
      name: 'smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Service Update Intervals (days)`
  String get serviceUpdateIntervalsDays {
    return Intl.message(
      'Service Update Intervals (days)',
      name: 'serviceUpdateIntervalsDays',
      desc: '',
      args: [],
    );
  }

  /// `SetUp Default Caller ID APP`
  String get setupDefaultCallerIdApp {
    return Intl.message(
      'SetUp Default Caller ID APP',
      name: 'setupDefaultCallerIdApp',
      desc: '',
      args: [],
    );
  }

  /// `Allow This App To Show Caller ID`
  String get allowThisAppToShowCallerId {
    return Intl.message(
      'Allow This App To Show Caller ID',
      name: 'allowThisAppToShowCallerId',
      desc: '',
      args: [],
    );
  }

  /// `Disable This App To Show Caller ID`
  String get disableThisAppToShowCallerId {
    return Intl.message(
      'Disable This App To Show Caller ID',
      name: 'disableThisAppToShowCallerId',
      desc: '',
      args: [],
    );
  }

  /// `Error getting permission status`
  String get errorGettingPermissionStatus {
    return Intl.message(
      'Error getting permission status',
      name: 'errorGettingPermissionStatus',
      desc: '',
      args: [],
    );
  }

  /// `Disable Permission`
  String get disablePermission {
    return Intl.message(
      'Disable Permission',
      name: 'disablePermission',
      desc: '',
      args: [],
    );
  }

  /// `Permissions`
  String get permissions {
    return Intl.message(
      'Permissions',
      name: 'permissions',
      desc: '',
      args: [],
    );
  }

  /// `Call Log`
  String get callLog {
    return Intl.message(
      'Call Log',
      name: 'callLog',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Overlay`
  String get overlay {
    return Intl.message(
      'Overlay',
      name: 'overlay',
      desc: '',
      args: [],
    );
  }

  /// `SMS`
  String get sms {
    return Intl.message(
      'SMS',
      name: 'sms',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storage {
    return Intl.message(
      'Storage',
      name: 'storage',
      desc: '',
      args: [],
    );
  }

  /// `Battery Optimization`
  String get batteryOptimization {
    return Intl.message(
      'Battery Optimization',
      name: 'batteryOptimization',
      desc: '',
      args: [],
    );
  }

  /// `You need to manually disable the {permissionName} permission in the app settings.`
  String youNeedToManuallyDisableThePermissionnamePermissionInThe(
      Object permissionName) {
    return Intl.message(
      'You need to manually disable the $permissionName permission in the app settings.',
      name: 'youNeedToManuallyDisableThePermissionnamePermissionInThe',
      desc: '',
      args: [permissionName],
    );
  }

  /// `You need to manually disable the`
  String get youNeedToManuallyDisableThe {
    return Intl.message(
      'You need to manually disable the',
      name: 'youNeedToManuallyDisableThe',
      desc: '',
      args: [],
    );
  }

  /// `permission in the app settings.`
  String get permissionInTheAppSettings {
    return Intl.message(
      'permission in the app settings.',
      name: 'permissionInTheAppSettings',
      desc: '',
      args: [],
    );
  }

  /// `:You need to manually disable the permission in the app settings.`
  String get permissionInAppSetting {
    return Intl.message(
      ':You need to manually disable the permission in the app settings.',
      name: 'permissionInAppSetting',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get permissionDenied {
    return Intl.message(
      'Permission Denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Enable dark mode based on time`
  String get enableDarkModeBasedOnTime {
    return Intl.message(
      'Enable dark mode based on time',
      name: 'enableDarkModeBasedOnTime',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `permission was not granted.`
  String get permissionWasNotGranted {
    return Intl.message(
      'permission was not granted.',
      name: 'permissionWasNotGranted',
      desc: '',
      args: [],
    );
  }

  /// `Edit Avatar`
  String get editAvatar {
    return Intl.message(
      'Edit Avatar',
      name: 'editAvatar',
      desc: '',
      args: [],
    );
  }

  /// `No image selected`
  String get noImageSelected {
    return Intl.message(
      'No image selected',
      name: 'noImageSelected',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Use Network Image`
  String get useNetworkImage {
    return Intl.message(
      'Use Network Image',
      name: 'useNetworkImage',
      desc: '',
      args: [],
    );
  }

  /// `Enter Image URL`
  String get enterImageUrl {
    return Intl.message(
      'Enter Image URL',
      name: 'enterImageUrl',
      desc: '',
      args: [],
    );
  }

  /// `Crop Avatar`
  String get cropAvatar {
    return Intl.message(
      'Crop Avatar',
      name: 'cropAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Select a label:`
  String get selectALabel {
    return Intl.message(
      'Select a label:',
      name: 'selectALabel',
      desc: '',
      args: [],
    );
  }

  /// `Selected Label`
  String get selectedLabel {
    return Intl.message(
      'Selected Label',
      name: 'selectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Fraud Scam Likely`
  String get fraudScamLikely {
    return Intl.message(
      'Fraud Scam Likely',
      name: 'fraudScamLikely',
      desc: '',
      args: [],
    );
  }

  /// `Spam Likely`
  String get spamLikely {
    return Intl.message(
      'Spam Likely',
      name: 'spamLikely',
      desc: '',
      args: [],
    );
  }

  /// `Telemarketing`
  String get telemarketing {
    return Intl.message(
      'Telemarketing',
      name: 'telemarketing',
      desc: '',
      args: [],
    );
  }

  /// `Robocall`
  String get robocall {
    return Intl.message(
      'Robocall',
      name: 'robocall',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Takeaway`
  String get takeaway {
    return Intl.message(
      'Takeaway',
      name: 'takeaway',
      desc: '',
      args: [],
    );
  }

  /// `Ridesharing`
  String get ridesharing {
    return Intl.message(
      'Ridesharing',
      name: 'ridesharing',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get insurance {
    return Intl.message(
      'Insurance',
      name: 'insurance',
      desc: '',
      args: [],
    );
  }

  /// `Loan`
  String get loan {
    return Intl.message(
      'Loan',
      name: 'loan',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get customerService {
    return Intl.message(
      'Customer Service',
      name: 'customerService',
      desc: '',
      args: [],
    );
  }

  /// `Financial`
  String get financial {
    return Intl.message(
      'Financial',
      name: 'financial',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message(
      'Bank',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Medical`
  String get medical {
    return Intl.message(
      'Medical',
      name: 'medical',
      desc: '',
      args: [],
    );
  }

  /// `Charity`
  String get charity {
    return Intl.message(
      'Charity',
      name: 'charity',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get collection {
    return Intl.message(
      'Collection',
      name: 'collection',
      desc: '',
      args: [],
    );
  }

  /// `Survey`
  String get survey {
    return Intl.message(
      'Survey',
      name: 'survey',
      desc: '',
      args: [],
    );
  }

  /// `Political`
  String get political {
    return Intl.message(
      'Political',
      name: 'political',
      desc: '',
      args: [],
    );
  }

  /// `Ecommerce`
  String get ecommerce {
    return Intl.message(
      'Ecommerce',
      name: 'ecommerce',
      desc: '',
      args: [],
    );
  }

  /// `Risk`
  String get risk {
    return Intl.message(
      'Risk',
      name: 'risk',
      desc: '',
      args: [],
    );
  }

  /// `Select entries to export`
  String get selectEntriesToExport {
    return Intl.message(
      'Select entries to export',
      name: 'selectEntriesToExport',
      desc: '',
      args: [],
    );
  }

  /// `selecting export folder`
  String get selectingExportFolder {
    return Intl.message(
      'selecting export folder',
      name: 'selectingExportFolder',
      desc: '',
      args: [],
    );
  }

  /// `export format:`
  String get exportFormat {
    return Intl.message(
      'export format:',
      name: 'exportFormat',
      desc: '',
      args: [],
    );
  }

  /// `Please select an export folder`
  String get pleaseSelectAnExportFolder {
    return Intl.message(
      'Please select an export folder',
      name: 'pleaseSelectAnExportFolder',
      desc: '',
      args: [],
    );
  }

  /// `Please select entries to export`
  String get pleaseSelectEntriesToExport {
    return Intl.message(
      'Please select entries to export',
      name: 'pleaseSelectEntriesToExport',
      desc: '',
      args: [],
    );
  }

  /// `Export successful`
  String get exportSuccessful {
    return Intl.message(
      'Export successful',
      name: 'exportSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Export failed`
  String get exportFailed {
    return Intl.message(
      'Export failed',
      name: 'exportFailed',
      desc: '',
      args: [],
    );
  }

  /// `Link`
  String get link {
    return Intl.message(
      'Link',
      name: 'link',
      desc: '',
      args: [],
    );
  }

  /// `Choose only link or file`
  String get chooseOnlyLinkOrFile {
    return Intl.message(
      'Choose only link or file',
      name: 'chooseOnlyLinkOrFile',
      desc: '',
      args: [],
    );
  }

  /// `Open Local Folder`
  String get openLocalFolder {
    return Intl.message(
      'Open Local Folder',
      name: 'openLocalFolder',
      desc: '',
      args: [],
    );
  }

  /// `Add to {listType}`
  String addToAllowedtype(Object listType) {
    return Intl.message(
      'Add to $listType',
      name: 'addToAllowedtype',
      desc: '',
      args: [listType],
    );
  }

  /// `Add to {listType}`
  String addToBlockedtype(Object listType) {
    return Intl.message(
      'Add to $listType',
      name: 'addToBlockedtype',
      desc: '',
      args: [listType],
    );
  }

  /// `Remove {listType}`
  String removeBlockedtype(Object listType) {
    return Intl.message(
      'Remove $listType',
      name: 'removeBlockedtype',
      desc: '',
      args: [listType],
    );
  }

  /// `Remove {listType}`
  String removeAllowedtype(Object listType) {
    return Intl.message(
      'Remove $listType',
      name: 'removeAllowedtype',
      desc: '',
      args: [listType],
    );
  }

  /// `{permissionName} permission was not granted.`
  String PermissionWasNotGranted(Object permissionName) {
    return Intl.message(
      '$permissionName permission was not granted.',
      name: 'PermissionWasNotGranted',
      desc: '',
      args: [permissionName],
    );
  }

  /// `You need to manually disable the {permissionName} permission in the app settings.`
  String manuallyDisablePermissionInAppSetting(Object permissionName) {
    return Intl.message(
      'You need to manually disable the $permissionName permission in the app settings.',
      name: 'manuallyDisablePermissionInAppSetting',
      desc: '',
      args: [permissionName],
    );
  }

  /// `Choose Avatar (Local or Network):`
  String get chooseAvatarLocalOrNetwork {
    return Intl.message(
      'Choose Avatar (Local or Network):',
      name: 'chooseAvatarLocalOrNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Avatar URL or Path`
  String get avatarUrlOrPath {
    return Intl.message(
      'Avatar URL or Path',
      name: 'avatarUrlOrPath',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `PhoneNumber`
  String get phonenumber {
    return Intl.message(
      'PhoneNumber',
      name: 'phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Keyword`
  String get keyword {
    return Intl.message(
      'Keyword',
      name: 'keyword',
      desc: '',
      args: [],
    );
  }

  /// `Pattern`
  String get pattern {
    return Intl.message(
      'Pattern',
      name: 'pattern',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Url`
  String get url {
    return Intl.message(
      'Url',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `Auto Update Enabled`
  String get autoUpdateEnabled {
    return Intl.message(
      'Auto Update Enabled',
      name: 'autoUpdateEnabled',
      desc: '',
      args: [],
    );
  }

  /// `Auto Update Disabled`
  String get autoUpdateDisabled {
    return Intl.message(
      'Auto Update Disabled',
      name: 'autoUpdateDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Number Type`
  String get numberType {
    return Intl.message(
      'Number Type',
      name: 'numberType',
      desc: '',
      args: [],
    );
  }

  /// `Text Type`
  String get textType {
    return Intl.message(
      'Text Type',
      name: 'textType',
      desc: '',
      args: [],
    );
  }

  /// `is Subscribed`
  String get isSubscribed {
    return Intl.message(
      'is Subscribed',
      name: 'isSubscribed',
      desc: '',
      args: [],
    );
  }

  /// `is not Subscribed`
  String get isNotSubscribed {
    return Intl.message(
      'is not Subscribed',
      name: 'isNotSubscribed',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the item`
  String get areYouSureYouWantToDeleteTheItem {
    return Intl.message(
      'Are you sure you want to delete the item',
      name: 'areYouSureYouWantToDeleteTheItem',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `successfully`
  String get successfully {
    return Intl.message(
      'successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed`
  String get subscribed {
    return Intl.message(
      'Subscribed',
      name: 'subscribed',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribed`
  String get unsubscribed {
    return Intl.message(
      'Unsubscribed',
      name: 'unsubscribed',
      desc: '',
      args: [],
    );
  }

  /// `Select All`
  String get selectAll {
    return Intl.message(
      'Select All',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Search Entries`
  String get searchEntries {
    return Intl.message(
      'Search Entries',
      name: 'searchEntries',
      desc: '',
      args: [],
    );
  }

  /// `Select Entries`
  String get selectEntries {
    return Intl.message(
      'Select Entries',
      name: 'selectEntries',
      desc: '',
      args: [],
    );
  }

  /// `Country:`
  String get country {
    return Intl.message(
      'Country:',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Region:`
  String get region {
    return Intl.message(
      'Region:',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `Carrier:`
  String get carrier {
    return Intl.message(
      'Carrier:',
      name: 'carrier',
      desc: '',
      args: [],
    );
  }

  /// `Select Country Code (Optional)`
  String get selectCountryCodeOptional {
    return Intl.message(
      'Select Country Code (Optional)',
      name: 'selectCountryCodeOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add to Label`
  String get addToLabel {
    return Intl.message(
      'Add to Label',
      name: 'addToLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Entry`
  String get entry {
    return Intl.message(
      'Entry',
      name: 'entry',
      desc: '',
      args: [],
    );
  }

  /// `Page`
  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  /// `Add Allowed Entry Page`
  String get addAllowedEntryPage {
    return Intl.message(
      'Add Allowed Entry Page',
      name: 'addAllowedEntryPage',
      desc: '',
      args: [],
    );
  }

  /// `AllowedPageView`
  String get allowedpageview {
    return Intl.message(
      'AllowedPageView',
      name: 'allowedpageview',
      desc: '',
      args: [],
    );
  }

  /// `Allowed Entry Page`
  String get allowedEntryPage {
    return Intl.message(
      'Allowed Entry Page',
      name: 'allowedEntryPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Allowed Entry Page`
  String get exportAllowedEntryPage {
    return Intl.message(
      'Export Allowed Entry Page',
      name: 'exportAllowedEntryPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Allowed Entry Page`
  String get importAllowedEntryPage {
    return Intl.message(
      'Import Allowed Entry Page',
      name: 'importAllowedEntryPage',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameCannotBeEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get pleaseEnterAPhoneNumber {
    return Intl.message(
      'Please enter a phone number',
      name: 'pleaseEnterAPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please select a label`
  String get pleaseSelectALabel {
    return Intl.message(
      'Please select a label',
      name: 'pleaseSelectALabel',
      desc: '',
      args: [],
    );
  }

  /// `entry added successfully`
  String get entryAddedSuccessfully {
    return Intl.message(
      'entry added successfully',
      name: 'entryAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add entry:`
  String get failedToAddEntry {
    return Intl.message(
      'Failed to add entry:',
      name: 'failedToAddEntry',
      desc: '',
      args: [],
    );
  }

  /// `URL format is incorrect`
  String get urlFormatIsIncorrect {
    return Intl.message(
      'URL format is incorrect',
      name: 'urlFormatIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Please select a file or input a URL`
  String get pleaseSelectAFileOrInputAUrl {
    return Intl.message(
      'Please select a file or input a URL',
      name: 'pleaseSelectAFileOrInputAUrl',
      desc: '',
      args: [],
    );
  }

  /// `Add Blacklist Page`
  String get addBlacklistPage {
    return Intl.message(
      'Add Blacklist Page',
      name: 'addBlacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `BlacklistPageView`
  String get blacklistpageview {
    return Intl.message(
      'BlacklistPageView',
      name: 'blacklistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Import Blacklists Page`
  String get importBlacklistsPage {
    return Intl.message(
      'Import Blacklists Page',
      name: 'importBlacklistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Blacklist Page`
  String get exportBlacklistPage {
    return Intl.message(
      'Export Blacklist Page',
      name: 'exportBlacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `Blacklist Page`
  String get blacklistPage {
    return Intl.message(
      'Blacklist Page',
      name: 'blacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add:`
  String get failedToAdd {
    return Intl.message(
      'Failed to add:',
      name: 'failedToAdd',
      desc: '',
      args: [],
    );
  }

  /// `added successfully`
  String get addedSuccessfully {
    return Intl.message(
      'added successfully',
      name: 'addedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Add Label Page`
  String get addLabelPage {
    return Intl.message(
      'Add Label Page',
      name: 'addLabelPage',
      desc: '',
      args: [],
    );
  }

  /// `LabelPageView`
  String get labelpageview {
    return Intl.message(
      'LabelPageView',
      name: 'labelpageview',
      desc: '',
      args: [],
    );
  }

  /// `Add Plugin Page`
  String get addPluginPage {
    return Intl.message(
      'Add Plugin Page',
      name: 'addPluginPage',
      desc: '',
      args: [],
    );
  }

  /// `PluginsPageView`
  String get pluginspageview {
    return Intl.message(
      'PluginsPageView',
      name: 'pluginspageview',
      desc: '',
      args: [],
    );
  }

  /// `Add Blocked Page`
  String get addBlockedPage {
    return Intl.message(
      'Add Blocked Page',
      name: 'addBlockedPage',
      desc: '',
      args: [],
    );
  }

  /// `BlockedPageView`
  String get blockedpageview {
    return Intl.message(
      'BlockedPageView',
      name: 'blockedpageview',
      desc: '',
      args: [],
    );
  }

  /// `Add Regex Page`
  String get addRegexPage {
    return Intl.message(
      'Add Regex Page',
      name: 'addRegexPage',
      desc: '',
      args: [],
    );
  }

  /// `RegexPageView`
  String get regexpageview {
    return Intl.message(
      'RegexPageView',
      name: 'regexpageview',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an pattern`
  String get pleaseEnterAnPattern {
    return Intl.message(
      'Please enter an pattern',
      name: 'pleaseEnterAnPattern',
      desc: '',
      args: [],
    );
  }

  /// `Add Whitelists Page`
  String get addWhitelistsPage {
    return Intl.message(
      'Add Whitelists Page',
      name: 'addWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `WhitelistPageView`
  String get whitelistpageview {
    return Intl.message(
      'WhitelistPageView',
      name: 'whitelistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an url`
  String get pleaseEnterAnUrl {
    return Intl.message(
      'Please enter an url',
      name: 'pleaseEnterAnUrl',
      desc: '',
      args: [],
    );
  }

  /// `Add Subscription Page`
  String get addSubscriptionPage {
    return Intl.message(
      'Add Subscription Page',
      name: 'addSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `SubscriptionListView`
  String get subscriptionlistview {
    return Intl.message(
      'SubscriptionListView',
      name: 'subscriptionlistview',
      desc: '',
      args: [],
    );
  }

  /// `Add SMS Text Whitelists Page`
  String get addSmsTextWhitelistsPage {
    return Intl.message(
      'Add SMS Text Whitelists Page',
      name: 'addSmsTextWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `SmsTextWhitelistPageView`
  String get smstextwhitelistpageview {
    return Intl.message(
      'SmsTextWhitelistPageView',
      name: 'smstextwhitelistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Add SMS Text Blacklist Page`
  String get addSmsTextBlacklistPage {
    return Intl.message(
      'Add SMS Text Blacklist Page',
      name: 'addSmsTextBlacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `SmsTextBlacklistPageView`
  String get smstextblacklistpageview {
    return Intl.message(
      'SmsTextBlacklistPageView',
      name: 'smstextblacklistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Add SMS Whitelist Page`
  String get addSmsWhitelistPage {
    return Intl.message(
      'Add SMS Whitelist Page',
      name: 'addSmsWhitelistPage',
      desc: '',
      args: [],
    );
  }

  /// `SmsWhitelistPageView`
  String get smswhitelistpageview {
    return Intl.message(
      'SmsWhitelistPageView',
      name: 'smswhitelistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Add SMS Subscription Page`
  String get addSmsSubscriptionPage {
    return Intl.message(
      'Add SMS Subscription Page',
      name: 'addSmsSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `SmsSubscriptionListView`
  String get smssubscriptionlistview {
    return Intl.message(
      'SmsSubscriptionListView',
      name: 'smssubscriptionlistview',
      desc: '',
      args: [],
    );
  }

  /// `Add SMS Blacklist Page`
  String get addSmsBlacklistPage {
    return Intl.message(
      'Add SMS Blacklist Page',
      name: 'addSmsBlacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `SmsBlacklistPageView`
  String get smsblacklistpageview {
    return Intl.message(
      'SmsBlacklistPageView',
      name: 'smsblacklistpageview',
      desc: '',
      args: [],
    );
  }

  /// `Regex Page`
  String get regexPage {
    return Intl.message(
      'Regex Page',
      name: 'regexPage',
      desc: '',
      args: [],
    );
  }

  /// `Whitelist Page`
  String get whitelistPage {
    return Intl.message(
      'Whitelist Page',
      name: 'whitelistPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Blocked Page`
  String get exportBlockedPage {
    return Intl.message(
      'Export Blocked Page',
      name: 'exportBlockedPage',
      desc: '',
      args: [],
    );
  }

  /// `Import BlockedEntries Page`
  String get importBlockedentriesPage {
    return Intl.message(
      'Import BlockedEntries Page',
      name: 'importBlockedentriesPage',
      desc: '',
      args: [],
    );
  }

  /// `Subscription List Page`
  String get subscriptionListPage {
    return Intl.message(
      'Subscription List Page',
      name: 'subscriptionListPage',
      desc: '',
      args: [],
    );
  }

  /// `SMS Text Whitelist Page`
  String get smsTextWhitelistPage {
    return Intl.message(
      'SMS Text Whitelist Page',
      name: 'smsTextWhitelistPage',
      desc: '',
      args: [],
    );
  }

  /// `SMS Blacklist Page`
  String get smsBlacklistPage {
    return Intl.message(
      'SMS Blacklist Page',
      name: 'smsBlacklistPage',
      desc: '',
      args: [],
    );
  }

  /// `SMS Subscription Page`
  String get smsSubscriptionPage {
    return Intl.message(
      'SMS Subscription Page',
      name: 'smsSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `Plugin Page`
  String get pluginPage {
    return Intl.message(
      'Plugin Page',
      name: 'pluginPage',
      desc: '',
      args: [],
    );
  }

  /// `Edit Code`
  String get editCode {
    return Intl.message(
      'Edit Code',
      name: 'editCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter plugin code here`
  String get enterPluginCodeHere {
    return Intl.message(
      'Enter plugin code here',
      name: 'enterPluginCodeHere',
      desc: '',
      args: [],
    );
  }

  /// `Edit Plugin Code`
  String get editPluginCode {
    return Intl.message(
      'Edit Plugin Code',
      name: 'editPluginCode',
      desc: '',
      args: [],
    );
  }

  /// `Label Page`
  String get labelPage {
    return Intl.message(
      'Label Page',
      name: 'labelPage',
      desc: '',
      args: [],
    );
  }

  /// `Contact Subscription Page`
  String get contactSubscriptionPage {
    return Intl.message(
      'Contact Subscription Page',
      name: 'contactSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `ContactSubscriptionListView`
  String get contactsubscriptionlistview {
    return Intl.message(
      'ContactSubscriptionListView',
      name: 'contactsubscriptionlistview',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Show Contact Icon Button`
  String get showContactIconButton {
    return Intl.message(
      'Show Contact Icon Button',
      name: 'showContactIconButton',
      desc: '',
      args: [],
    );
  }

  /// `Show Contact Button`
  String get showContactButton {
    return Intl.message(
      'Show Contact Button',
      name: 'showContactButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Contact`
  String get addContact {
    return Intl.message(
      'Add Contact',
      name: 'addContact',
      desc: '',
      args: [],
    );
  }

  /// `Add to Blocked`
  String get addToBlocked {
    return Intl.message(
      'Add to Blocked',
      name: 'addToBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Remove Blocked`
  String get removeBlocked {
    return Intl.message(
      'Remove Blocked',
      name: 'removeBlocked',
      desc: '',
      args: [],
    );
  }

  /// `Add to Allowed`
  String get addToAllowed {
    return Intl.message(
      'Add to Allowed',
      name: 'addToAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Remove Allowed`
  String get removeAllowed {
    return Intl.message(
      'Remove Allowed',
      name: 'removeAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Call History`
  String get callHistory {
    return Intl.message(
      'Call History',
      name: 'callHistory',
      desc: '',
      args: [],
    );
  }

  /// `Call log permission denied`
  String get callLogPermissionDenied {
    return Intl.message(
      'Call log permission denied',
      name: 'callLogPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `You have denied permission. You can manually enable permission in Settings.`
  String get youHaveDeniedPermissionYouCanManuallyEnablePermissionIn {
    return Intl.message(
      'You have denied permission. You can manually enable permission in Settings.',
      name: 'youHaveDeniedPermissionYouCanManuallyEnablePermissionIn',
      desc: '',
      args: [],
    );
  }

  /// `You have denied permission. You can manually enable permission in Settings.`
  String get deniedPermissionCanManuallyEnablePermissionInSetting {
    return Intl.message(
      'You have denied permission. You can manually enable permission in Settings.',
      name: 'deniedPermissionCanManuallyEnablePermissionInSetting',
      desc: '',
      args: [],
    );
  }

  /// `Permission granted`
  String get permissionGranted {
    return Intl.message(
      'Permission granted',
      name: 'permissionGranted',
      desc: '',
      args: [],
    );
  }

  /// `This app needs access to your call log information to function properly. Please grant permission.`
  String get thisAppNeedsAccessToYourCallLogInformation {
    return Intl.message(
      'This app needs access to your call log information to function properly. Please grant permission.',
      name: 'thisAppNeedsAccessToYourCallLogInformation',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Page`
  String get blockedPage {
    return Intl.message(
      'Blocked Page',
      name: 'blockedPage',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video {
    return Intl.message(
      'Video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsapp {
    return Intl.message(
      'WhatsApp',
      name: 'whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Telegram`
  String get telegram {
    return Intl.message(
      'Telegram',
      name: 'telegram',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Subscribed link`
  String get subscribedLink {
    return Intl.message(
      'Subscribed link',
      name: 'subscribedLink',
      desc: '',
      args: [],
    );
  }

  /// `Delete Contact`
  String get deleteContact {
    return Intl.message(
      'Delete Contact',
      name: 'deleteContact',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this contact?`
  String get areYouSureYouWantToDeleteThisContact {
    return Intl.message(
      'Are you sure you want to delete this contact?',
      name: 'areYouSureYouWantToDeleteThisContact',
      desc: '',
      args: [],
    );
  }

  /// `Sharing`
  String get sharing {
    return Intl.message(
      'Sharing',
      name: 'sharing',
      desc: '',
      args: [],
    );
  }

  /// `Contact File`
  String get contactFile {
    return Intl.message(
      'Contact File',
      name: 'contactFile',
      desc: '',
      args: [],
    );
  }

  /// `Error exporting contacts:`
  String get errorExportingContacts {
    return Intl.message(
      'Error exporting contacts:',
      name: 'errorExportingContacts',
      desc: '',
      args: [],
    );
  }

  /// `Contacts exported successfully`
  String get contactsExportedSuccessfully {
    return Intl.message(
      'Contacts exported successfully',
      name: 'contactsExportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please select an output file:`
  String get pleaseSelectAnOutputFile {
    return Intl.message(
      'Please select an output file:',
      name: 'pleaseSelectAnOutputFile',
      desc: '',
      args: [],
    );
  }

  /// `Export as YAML`
  String get exportAsYaml {
    return Intl.message(
      'Export as YAML',
      name: 'exportAsYaml',
      desc: '',
      args: [],
    );
  }

  /// `Export as JSON`
  String get exportAsJson {
    return Intl.message(
      'Export as JSON',
      name: 'exportAsJson',
      desc: '',
      args: [],
    );
  }

  /// `Export as CSV`
  String get exportAsCsv {
    return Intl.message(
      'Export as CSV',
      name: 'exportAsCsv',
      desc: '',
      args: [],
    );
  }

  /// `Export as VCF`
  String get exportAsVcf {
    return Intl.message(
      'Export as VCF',
      name: 'exportAsVcf',
      desc: '',
      args: [],
    );
  }

  /// `Export Contacts`
  String get exportContacts {
    return Intl.message(
      'Export Contacts',
      name: 'exportContacts',
      desc: '',
      args: [],
    );
  }

  /// `Edit Contact`
  String get editContact {
    return Intl.message(
      'Edit Contact',
      name: 'editContact',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter`
  String get pleaseEnter {
    return Intl.message(
      'Please enter',
      name: 'pleaseEnter',
      desc: '',
      args: [],
    );
  }

  /// `Import Contacts`
  String get importContacts {
    return Intl.message(
      'Import Contacts',
      name: 'importContacts',
      desc: '',
      args: [],
    );
  }

  /// `Import from VCF`
  String get importFromVcf {
    return Intl.message(
      'Import from VCF',
      name: 'importFromVcf',
      desc: '',
      args: [],
    );
  }

  /// `Import from CSV`
  String get importFromCsv {
    return Intl.message(
      'Import from CSV',
      name: 'importFromCsv',
      desc: '',
      args: [],
    );
  }

  /// `Import from JSON`
  String get importFromJson {
    return Intl.message(
      'Import from JSON',
      name: 'importFromJson',
      desc: '',
      args: [],
    );
  }

  /// `Import from YAML`
  String get importFromYaml {
    return Intl.message(
      'Import from YAML',
      name: 'importFromYaml',
      desc: '',
      args: [],
    );
  }

  /// `Import from URL`
  String get importFromUrl {
    return Intl.message(
      'Import from URL',
      name: 'importFromUrl',
      desc: '',
      args: [],
    );
  }

  /// `Contacts imported successfully`
  String get contactsImportedSuccessfully {
    return Intl.message(
      'Contacts imported successfully',
      name: 'contactsImportedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Error importing`
  String get errorImporting {
    return Intl.message(
      'Error importing',
      name: 'errorImporting',
      desc: '',
      args: [],
    );
  }

  /// `Enter URL`
  String get enterUrl {
    return Intl.message(
      'Enter URL',
      name: 'enterUrl',
      desc: '',
      args: [],
    );
  }

  /// `Imported successfully from URL`
  String get importedSuccessfullyFromUrl {
    return Intl.message(
      'Imported successfully from URL',
      name: 'importedSuccessfullyFromUrl',
      desc: '',
      args: [],
    );
  }

  /// `Contacts Page`
  String get contactsPage {
    return Intl.message(
      'Contacts Page',
      name: 'contactsPage',
      desc: '',
      args: [],
    );
  }

  /// `Search contacts`
  String get searchContacts {
    return Intl.message(
      'Search contacts',
      name: 'searchContacts',
      desc: '',
      args: [],
    );
  }

  /// `Showing results for`
  String get showingResultsFor {
    return Intl.message(
      'Showing results for',
      name: 'showingResultsFor',
      desc: '',
      args: [],
    );
  }

  /// `Merge Contacts`
  String get mergeContacts {
    return Intl.message(
      'Merge Contacts',
      name: 'mergeContacts',
      desc: '',
      args: [],
    );
  }

  /// `Merge`
  String get merge {
    return Intl.message(
      'Merge',
      name: 'merge',
      desc: '',
      args: [],
    );
  }

  /// `contacts with number`
  String get contactsWithNumber {
    return Intl.message(
      'contacts with number',
      name: 'contactsWithNumber',
      desc: '',
      args: [],
    );
  }

  /// `Merge Selected`
  String get mergeSelected {
    return Intl.message(
      'Merge Selected',
      name: 'mergeSelected',
      desc: '',
      args: [],
    );
  }

  /// `Selected contacts merged successfully`
  String get selectedContactsMergedSuccessfully {
    return Intl.message(
      'Selected contacts merged successfully',
      name: 'selectedContactsMergedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Show Telegram`
  String get showTelegram {
    return Intl.message(
      'Show Telegram',
      name: 'showTelegram',
      desc: '',
      args: [],
    );
  }

  /// `Show WhatsApp`
  String get showWhatsapp {
    return Intl.message(
      'Show WhatsApp',
      name: 'showWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Add Contact Subscription Page`
  String get addContactSubscriptionPage {
    return Intl.message(
      'Add Contact Subscription Page',
      name: 'addContactSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Contact Subscription Page`
  String get exportContactSubscriptionPage {
    return Intl.message(
      'Export Contact Subscription Page',
      name: 'exportContactSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Label Page`
  String get exportLabelPage {
    return Intl.message(
      'Export Label Page',
      name: 'exportLabelPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Label Page`
  String get importLabelPage {
    return Intl.message(
      'Import Label Page',
      name: 'importLabelPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Plugin Page`
  String get exportPluginPage {
    return Intl.message(
      'Export Plugin Page',
      name: 'exportPluginPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Plugin Page`
  String get importPluginPage {
    return Intl.message(
      'Import Plugin Page',
      name: 'importPluginPage',
      desc: '',
      args: [],
    );
  }

  /// `Export SMS Blacklists Page`
  String get exportSmsBlacklistsPage {
    return Intl.message(
      'Export SMS Blacklists Page',
      name: 'exportSmsBlacklistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Whitelists Page`
  String get importWhitelistsPage {
    return Intl.message(
      'Import Whitelists Page',
      name: 'importWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export SMS Whitelists Page`
  String get exportSmsWhitelistsPage {
    return Intl.message(
      'Export SMS Whitelists Page',
      name: 'exportSmsWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export SMS Subscription Page`
  String get exportSmsSubscriptionPage {
    return Intl.message(
      'Export SMS Subscription Page',
      name: 'exportSmsSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `Import SMS Subscription Page`
  String get importSmsSubscriptionPage {
    return Intl.message(
      'Import SMS Subscription Page',
      name: 'importSmsSubscriptionPage',
      desc: '',
      args: [],
    );
  }

  /// `Export SMS Text Blacklists Page`
  String get exportSmsTextBlacklistsPage {
    return Intl.message(
      'Export SMS Text Blacklists Page',
      name: 'exportSmsTextBlacklistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Import SMS Text Blacklists Page`
  String get importSmsTextBlacklistsPage {
    return Intl.message(
      'Import SMS Text Blacklists Page',
      name: 'importSmsTextBlacklistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export SMS Text Whitelists Page`
  String get exportSmsTextWhitelistsPage {
    return Intl.message(
      'Export SMS Text Whitelists Page',
      name: 'exportSmsTextWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Import SMS Text Whitelists Page`
  String get importSmsTextWhitelistsPage {
    return Intl.message(
      'Import SMS Text Whitelists Page',
      name: 'importSmsTextWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Subscriptions Page`
  String get exportSubscriptionsPage {
    return Intl.message(
      'Export Subscriptions Page',
      name: 'exportSubscriptionsPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Subscriptions Page`
  String get importSubscriptionsPage {
    return Intl.message(
      'Import Subscriptions Page',
      name: 'importSubscriptionsPage',
      desc: '',
      args: [],
    );
  }

  /// `Local Backup Directory only under Download folder`
  String get localBackupDirectoryOnlyUnderDownloadFolder {
    return Intl.message(
      'Local Backup Directory only under Download folder',
      name: 'localBackupDirectoryOnlyUnderDownloadFolder',
      desc: '',
      args: [],
    );
  }

  /// `Keep Only Latest Backup`
  String get keepOnlyLatestBackup {
    return Intl.message(
      'Keep Only Latest Backup',
      name: 'keepOnlyLatestBackup',
      desc: '',
      args: [],
    );
  }

  /// `Cloud Backup Directory Name`
  String get cloudBackupDirectoryName {
    return Intl.message(
      'Cloud Backup Directory Name',
      name: 'cloudBackupDirectoryName',
      desc: '',
      args: [],
    );
  }

  /// `Cloud Services`
  String get cloudServices {
    return Intl.message(
      'Cloud Services',
      name: 'cloudServices',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get backup {
    return Intl.message(
      'Backup',
      name: 'backup',
      desc: '',
      args: [],
    );
  }

  /// `Cloud backup requires Auto backup`
  String get cloudBackupRequiresAutoBackup {
    return Intl.message(
      'Cloud backup requires Auto backup',
      name: 'cloudBackupRequiresAutoBackup',
      desc: '',
      args: [],
    );
  }

  /// `Backup and Restore`
  String get backupAndRestore {
    return Intl.message(
      'Backup and Restore',
      name: 'backupAndRestore',
      desc: '',
      args: [],
    );
  }

  /// `Manual Backup`
  String get manualBackup {
    return Intl.message(
      'Manual Backup',
      name: 'manualBackup',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Local`
  String get restoreFromLocal {
    return Intl.message(
      'Restore from Local',
      name: 'restoreFromLocal',
      desc: '',
      args: [],
    );
  }

  /// `Restore from WebDAV`
  String get restoreFromWebdav {
    return Intl.message(
      'Restore from WebDAV',
      name: 'restoreFromWebdav',
      desc: '',
      args: [],
    );
  }

  /// `Restore from Google Drive`
  String get restoreFromGoogleDrive {
    return Intl.message(
      'Restore from Google Drive',
      name: 'restoreFromGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Restore from OneDrive`
  String get restoreFromOnedrive {
    return Intl.message(
      'Restore from OneDrive',
      name: 'restoreFromOnedrive',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV Setting`
  String get webdav {
    return Intl.message(
      'WebDAV Setting',
      name: 'webdav',
      desc: '',
      args: [],
    );
  }

  /// `WebDAV URL`
  String get webdavUrl {
    return Intl.message(
      'WebDAV URL',
      name: 'webdavUrl',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Google Drive Setting`
  String get googleDriveSetting {
    return Intl.message(
      'Google Drive Setting',
      name: 'googleDriveSetting',
      desc: '',
      args: [],
    );
  }

  /// `Login/Logout Google Drive`
  String get loginlogoutGoogleDrive {
    return Intl.message(
      'Login/Logout Google Drive',
      name: 'loginlogoutGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Logout Google Drive`
  String get logoutGoogleDrive {
    return Intl.message(
      'Logout Google Drive',
      name: 'logoutGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Login Google Drive`
  String get loginGoogleDrive {
    return Intl.message(
      'Login Google Drive',
      name: 'loginGoogleDrive',
      desc: '',
      args: [],
    );
  }

  /// `Google Drive Login Failed`
  String get googleDriveLoginFailed {
    return Intl.message(
      'Google Drive Login Failed',
      name: 'googleDriveLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Google Drive Login Successfully`
  String get googleDriveLoginSuccessfully {
    return Intl.message(
      'Google Drive Login Successfully',
      name: 'googleDriveLoginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Tenant ID`
  String get tenantId {
    return Intl.message(
      'Tenant ID',
      name: 'tenantId',
      desc: '',
      args: [],
    );
  }

  /// `Client ID`
  String get clientId {
    return Intl.message(
      'Client ID',
      name: 'clientId',
      desc: '',
      args: [],
    );
  }

  /// `Input OneDrive Credentials`
  String get inputOnedriveCredentials {
    return Intl.message(
      'Input OneDrive Credentials',
      name: 'inputOnedriveCredentials',
      desc: '',
      args: [],
    );
  }

  /// `OneDrive Setting`
  String get onedriveSetting {
    return Intl.message(
      'OneDrive Setting',
      name: 'onedriveSetting',
      desc: '',
      args: [],
    );
  }

  /// `Input Client ID & Tenant ID`
  String get inputClientIdTenantId {
    return Intl.message(
      'Input Client ID & Tenant ID',
      name: 'inputClientIdTenantId',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get loginFailed {
    return Intl.message(
      'Login failed',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Export Whitelists Page`
  String get exportWhitelistsPage {
    return Intl.message(
      'Export Whitelists Page',
      name: 'exportWhitelistsPage',
      desc: '',
      args: [],
    );
  }

  /// `Export Regex Page`
  String get exportRegexPage {
    return Intl.message(
      'Export Regex Page',
      name: 'exportRegexPage',
      desc: '',
      args: [],
    );
  }

  /// `Import Regex Page`
  String get importRegexPage {
    return Intl.message(
      'Import Regex Page',
      name: 'importRegexPage',
      desc: '',
      args: [],
    );
  }

  /// `Regex Pattern Explanation`
  String get regexPatternExplanation {
    return Intl.message(
      'Regex Pattern Explanation',
      name: 'regexPatternExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Regex patterns are regular expressions used to match phone numbers.`
  String get regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers {
    return Intl.message(
      'Regex patterns are regular expressions used to match phone numbers.',
      name: 'regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers',
      desc: '',
      args: [],
    );
  }

  /// `You can use standard regular expression syntax to define patterns, or Asking AI to generate the pattern for Flutter sqflite.`
  String get youCanUseStandardRegularExpressionSyntaxToDefinePatterns {
    return Intl.message(
      'You can use standard regular expression syntax to define patterns, or Asking AI to generate the pattern for Flutter sqflite.',
      name: 'youCanUseStandardRegularExpressionSyntaxToDefinePatterns',
      desc: '',
      args: [],
    );
  }

  /// `Block international calls:`
  String get blockInternationalCalls {
    return Intl.message(
      'Block international calls:',
      name: 'blockInternationalCalls',
      desc: '',
      args: [],
    );
  }

  /// `Use the pattern '^\+' to match all phone numbers starting with a plus sign, which typically indicates an international number.`
  String get useThePatternToMatchAllPhoneNumbersStartingWith {
    return Intl.message(
      'Use the pattern \'^\\+\' to match all phone numbers starting with a plus sign, which typically indicates an international number.',
      name: 'useThePatternToMatchAllPhoneNumbersStartingWith',
      desc: '',
      args: [],
    );
  }

  /// `Block calls from specific area codes:`
  String get blockCallsFromSpecificAreaCodes {
    return Intl.message(
      'Block calls from specific area codes:',
      name: 'blockCallsFromSpecificAreaCodes',
      desc: '',
      args: [],
    );
  }

  /// `Use the pattern '^0[0-9]{2,3}' to match phone numbers starting with '0' followed by 2 or 3 digits, which typically represents an area code.\nUse the pattern '^010' to block calls from Beijing area code (010).\nUse the pattern '^202' to block calls from Washington area code (202).\nReplace the '^0[0-9]{2,3}' area code with the specific one you want to block.`
  String get useThePattern0d23ToMatchPhoneNumbersStartingWith {
    return Intl.message(
      'Use the pattern \'^0[0-9]{2,3}\' to match phone numbers starting with \'0\' followed by 2 or 3 digits, which typically represents an area code.\nUse the pattern \'^010\' to block calls from Beijing area code (010).\nUse the pattern \'^202\' to block calls from Washington area code (202).\nReplace the \'^0[0-9]{2,3}\' area code with the specific one you want to block.',
      name: 'useThePattern0d23ToMatchPhoneNumbersStartingWith',
      desc: '',
      args: [],
    );
  }

  /// `Match phone numbers containing specific digits:`
  String get matchPhoneNumbersContainingSpecificDigits {
    return Intl.message(
      'Match phone numbers containing specific digits:',
      name: 'matchPhoneNumbersContainingSpecificDigits',
      desc: '',
      args: [],
    );
  }

  /// `Use the pattern '[0-9]{3}-[0-9]{4}-[0-9]{4}' to match phone numbers in the format 'XXX-XXXX-XXXX'. Replace 'X' with the specific digits you want to match.`
  String get useThePatternD3d4d4ToMatchPhoneNumbersInThe {
    return Intl.message(
      'Use the pattern \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' to match phone numbers in the format \'XXX-XXXX-XXXX\'. Replace \'X\' with the specific digits you want to match.',
      name: 'useThePatternD3d4d4ToMatchPhoneNumbersInThe',
      desc: '',
      args: [],
    );
  }

  /// `Match phone numbers with specific characters in the middle:`
  String get matchPhoneNumbersWithSpecificCharactersInTheMiddle {
    return Intl.message(
      'Match phone numbers with specific characters in the middle:',
      name: 'matchPhoneNumbersWithSpecificCharactersInTheMiddle',
      desc: '',
      args: [],
    );
  }

  /// `Use the pattern '^170 [0-9]{3} 656 [0-9]{2}$'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string '505'. '' Matches a single space character. '[0-9]{3}': Matches exactly three digits (0-9).'' Matches a single space character.656: Matches the literal string '656'.'[0-9]{1}': Matches exactly one digit (0-9).'$' (optional): Matches the end of the string (only if you need a full string match).`
  String get useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens {
    return Intl.message(
      'Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match).',
      name: 'useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens',
      desc: '',
      args: [],
    );
  }

  /// `Match any character:`
  String get matchAnyCharacter {
    return Intl.message(
      'Match any character:',
      name: 'matchAnyCharacter',
      desc: '',
      args: [],
    );
  }

  /// `Use the '.' character to match any single character.For example, the pattern '123.456' matches '123-456', '123.456', '123a456', etc.`
  String get useTheCharacterToMatchAnySingleCharacterforExampleThe {
    return Intl.message(
      'Use the \'.\' character to match any single character.For example, the pattern \'123.456\' matches \'123-456\', \'123.456\', \'123a456\', etc.',
      name: 'useTheCharacterToMatchAnySingleCharacterforExampleThe',
      desc: '',
      args: [],
    );
  }

  /// `Caller ID App`
  String get callerIdApp {
    return Intl.message(
      'Caller ID App',
      name: 'callerIdApp',
      desc: '',
      args: [],
    );
  }

  /// `This app is a powerful caller ID tool that allows you to identify unknown callers and block unwanted calls. It features:`
  String get thisAppIsAPowerfulCallerIdToolThatAllows {
    return Intl.message(
      'This app is a powerful caller ID tool that allows you to identify unknown callers and block unwanted calls. It features:',
      name: 'thisAppIsAPowerfulCallerIdToolThatAllows',
      desc: '',
      args: [],
    );
  }

  /// `Tutorial`
  String get tutorial {
    return Intl.message(
      'Tutorial',
      name: 'tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Online caller ID subscription`
  String get onlineCallerIdSubscription {
    return Intl.message(
      'Online caller ID subscription',
      name: 'onlineCallerIdSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Wildcard support for flexible filtering`
  String get wildcardSupportForFlexibleFiltering {
    return Intl.message(
      'Wildcard support for flexible filtering',
      name: 'wildcardSupportForFlexibleFiltering',
      desc: '',
      args: [],
    );
  }

  /// `Blacklisting and whitelisting`
  String get blacklistingAndWhitelisting {
    return Intl.message(
      'Blacklisting and whitelisting',
      name: 'blacklistingAndWhitelisting',
      desc: '',
      args: [],
    );
  }

  /// `Join the Telegram Channel and Group for more Info`
  String get joinTheTelegramChannelAndGroupForMoreInfo {
    return Intl.message(
      'Join the Telegram Channel and Group for more Info',
      name: 'joinTheTelegramChannelAndGroupForMoreInfo',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Fixed Line or Moblie`
  String get phoneNumberTypeFixedLineOrMobile {
    return Intl.message(
      'Fixed Line or Moblie',
      name: 'phoneNumberTypeFixedLineOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get phoneNumberTypeMobile {
    return Intl.message(
      'Mobile',
      name: 'phoneNumberTypeMobile',
      desc: '',
      args: [],
    );
  }

  /// `Fixed Line`
  String get phoneNumberTypeFixedLine {
    return Intl.message(
      'Fixed Line',
      name: 'phoneNumberTypeFixedLine',
      desc: '',
      args: [],
    );
  }

  /// `Toll Free`
  String get phoneNumberTypeTollFree {
    return Intl.message(
      'Toll Free',
      name: 'phoneNumberTypeTollFree',
      desc: '',
      args: [],
    );
  }

  /// `Premium Rate`
  String get phoneNumberTypePremiumRate {
    return Intl.message(
      'Premium Rate',
      name: 'phoneNumberTypePremiumRate',
      desc: '',
      args: [],
    );
  }

  /// `Shared Cost`
  String get phoneNumberTypeSharedCost {
    return Intl.message(
      'Shared Cost',
      name: 'phoneNumberTypeSharedCost',
      desc: '',
      args: [],
    );
  }

  /// `VoIP`
  String get phoneNumberTypeVoip {
    return Intl.message(
      'VoIP',
      name: 'phoneNumberTypeVoip',
      desc: '',
      args: [],
    );
  }

  /// `Personal Number`
  String get phoneNumberTypePpersonalNumber {
    return Intl.message(
      'Personal Number',
      name: 'phoneNumberTypePpersonalNumber',
      desc: '',
      args: [],
    );
  }

  /// `Pager`
  String get phoneNumberTypePager {
    return Intl.message(
      'Pager',
      name: 'phoneNumberTypePager',
      desc: '',
      args: [],
    );
  }

  /// `UAN`
  String get phoneNumberTypeUan {
    return Intl.message(
      'UAN',
      name: 'phoneNumberTypeUan',
      desc: '',
      args: [],
    );
  }

  /// `Voicemail`
  String get phoneNumberTypeVoicemail {
    return Intl.message(
      'Voicemail',
      name: 'phoneNumberTypeVoicemail',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get phoneNumberTypeUnknown {
    return Intl.message(
      'Unknown',
      name: 'phoneNumberTypeUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Calls`
  String get blockedCalls {
    return Intl.message(
      'Blocked Calls',
      name: 'blockedCalls',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Blocked Calls Summary`
  String get weeklyBlockedCallsSummary {
    return Intl.message(
      'Weekly Blocked Calls Summary',
      name: 'weeklyBlockedCallsSummary',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Showing search results for`
  String get showingSearchResultsFor {
    return Intl.message(
      'Showing search results for',
      name: 'showingSearchResultsFor',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Watch Ad`
  String get watchAd {
    return Intl.message(
      'Watch Ad',
      name: 'watchAd',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Watch Ads to Get Temporary Privileges`
  String get watchAdsToGetTemporaryPrivileges {
    return Intl.message(
      'Watch Ads to Get Temporary Privileges',
      name: 'watchAdsToGetTemporaryPrivileges',
      desc: '',
      args: [],
    );
  }

  /// `Watch a short ad to temporarily unlock some advanced features.`
  String get watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures {
    return Intl.message(
      'Watch a short ad to temporarily unlock some advanced features.',
      name: 'watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `One-time purchase to permanently unlock all advanced features and future updates.`
  String get onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture {
    return Intl.message(
      'One-time purchase to permanently unlock all advanced features and future updates.',
      name: 'onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture',
      desc: '',
      args: [],
    );
  }

  /// `Lifetime Purchase`
  String get lifetimePurchase {
    return Intl.message(
      'Lifetime Purchase',
      name: 'lifetimePurchase',
      desc: '',
      args: [],
    );
  }

  /// `Unlock premium features every quarter and enjoy a better price.`
  String get unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice {
    return Intl.message(
      'Unlock premium features every quarter and enjoy a better price.',
      name: 'unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Quarterly Subscription`
  String get quarterlySubscription {
    return Intl.message(
      'Quarterly Subscription',
      name: 'quarterlySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Unlock premium features every month, including exclusive content and removing Ads.`
  String
      get unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving {
    return Intl.message(
      'Unlock premium features every month, including exclusive content and removing Ads.',
      name:
          'unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Subscription`
  String get monthlySubscription {
    return Intl.message(
      'Monthly Subscription',
      name: 'monthlySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ads`
  String get removeAds {
    return Intl.message(
      'Remove Ads',
      name: 'removeAds',
      desc: '',
      args: [],
    );
  }

  /// `Permanently remove all ads in the app and enjoy a clean user experience.`
  String get permanentlyRemoveAllAdsInTheAppAndEnjoyA {
    return Intl.message(
      'Permanently remove all ads in the app and enjoy a clean user experience.',
      name: 'permanentlyRemoveAllAdsInTheAppAndEnjoyA',
      desc: '',
      args: [],
    );
  }

  /// `Function`
  String get function {
    return Intl.message(
      'Function',
      name: 'function',
      desc: '',
      args: [],
    );
  }

  /// `Normal User`
  String get normalUser {
    return Intl.message(
      'Normal User',
      name: 'normalUser',
      desc: '',
      args: [],
    );
  }

  /// `VIP User`
  String get vipUser {
    return Intl.message(
      'VIP User',
      name: 'vipUser',
      desc: '',
      args: [],
    );
  }

  /// `Temporary VIP User`
  String get temporaryVipUser {
    return Intl.message(
      'Temporary VIP User',
      name: 'temporaryVipUser',
      desc: '',
      args: [],
    );
  }

  /// `Feature Introduction`
  String get featureIntroduction {
    return Intl.message(
      'Feature Introduction',
      name: 'featureIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `Cloud Backup`
  String get cloudBackup {
    return Intl.message(
      'Cloud Backup',
      name: 'cloudBackup',
      desc: '',
      args: [],
    );
  }

  /// `Caller ID SIM Source`
  String get callerIdSimSource {
    return Intl.message(
      'Caller ID SIM Source',
      name: 'callerIdSimSource',
      desc: '',
      args: [],
    );
  }

  /// `STIR Recognition`
  String get stirRecognition {
    return Intl.message(
      'STIR Recognition',
      name: 'stirRecognition',
      desc: '',
      args: [],
    );
  }

  /// `In-app purchase`
  String get inappPurchase {
    return Intl.message(
      'In-app purchase',
      name: 'inappPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Subscription valid`
  String get subscriptionValid {
    return Intl.message(
      'Subscription valid',
      name: 'subscriptionValid',
      desc: '',
      args: [],
    );
  }

  /// `Purchase successful!`
  String get purchaseSuccessful {
    return Intl.message(
      'Purchase successful!',
      name: 'purchaseSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Purchase is being processed...`
  String get purchaseIsBeingProcessed {
    return Intl.message(
      'Purchase is being processed...',
      name: 'purchaseIsBeingProcessed',
      desc: '',
      args: [],
    );
  }

  /// `Purchase failed:`
  String get purchaseFailed {
    return Intl.message(
      'Purchase failed:',
      name: 'purchaseFailed',
      desc: '',
      args: [],
    );
  }

  /// `Cannot find item`
  String get cannotFindItem {
    return Intl.message(
      'Cannot find item',
      name: 'cannotFindItem',
      desc: '',
      args: [],
    );
  }

  /// `You have VIP privileges except for turning off ads.`
  String get youHaveVipPrivilegesExceptForTurningOffAds {
    return Intl.message(
      'You have VIP privileges except for turning off ads.',
      name: 'youHaveVipPrivilegesExceptForTurningOffAds',
      desc: '',
      args: [],
    );
  }

  /// `You already have temporary privileges. Expiry date`
  String get youAlreadyHaveTemporaryPrivilegesExpiryDate {
    return Intl.message(
      'You already have temporary privileges. Expiry date',
      name: 'youAlreadyHaveTemporaryPrivilegesExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `You need to watch`
  String get youNeedToWatch {
    return Intl.message(
      'You need to watch',
      name: 'youNeedToWatch',
      desc: '',
      args: [],
    );
  }

  /// `more ads to get temporary VIP privileges.`
  String get moreAdsToGetTemporaryVipPrivileges {
    return Intl.message(
      'more ads to get temporary VIP privileges.',
      name: 'moreAdsToGetTemporaryVipPrivileges',
      desc: '',
      args: [],
    );
  }

  /// `Temporary purchase privilege has expired`
  String get temporaryPurchasePrivilegeHasExpired {
    return Intl.message(
      'Temporary purchase privilege has expired',
      name: 'temporaryPurchasePrivilegeHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `You have obtained temporary purchase privileges for`
  String get youHaveObtainedTemporaryPurchasePrivilegesFor {
    return Intl.message(
      'You have obtained temporary purchase privileges for',
      name: 'youHaveObtainedTemporaryPurchasePrivilegesFor',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get expirationDate {
    return Intl.message(
      'Expiration date',
      name: 'expirationDate',
      desc: '',
      args: [],
    );
  }

  /// `Temporary VIP obtained`
  String get temporaryVipObtained {
    return Intl.message(
      'Temporary VIP obtained',
      name: 'temporaryVipObtained',
      desc: '',
      args: [],
    );
  }

  /// `Enable sorting: `
  String get enableSorting {
    return Intl.message(
      'Enable sorting: ',
      name: 'enableSorting',
      desc: '',
      args: [],
    );
  }

  /// `Sort by: `
  String get sortBy {
    return Intl.message(
      'Sort by: ',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Stir Notification`
  String get stirNotification {
    return Intl.message(
      'Stir Notification',
      name: 'stirNotification',
      desc: '',
      args: [],
    );
  }

  /// `Only for supported Area`
  String get onlyForSupportedArea {
    return Intl.message(
      'Only for supported Area',
      name: 'onlyForSupportedArea',
      desc: '',
      args: [],
    );
  }

  /// `Enable Stir Notification`
  String get enableStirNotification {
    return Intl.message(
      'Enable Stir Notification',
      name: 'enableStirNotification',
      desc: '',
      args: [],
    );
  }

  /// `Disable Stir Notification`
  String get disableStirNotification {
    return Intl.message(
      'Disable Stir Notification',
      name: 'disableStirNotification',
      desc: '',
      args: [],
    );
  }

  /// `The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here.`
  String get theTranslationIsNotYetComplete {
    return Intl.message(
      'The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here.',
      name: 'theTranslationIsNotYetComplete',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get translation {
    return Intl.message(
      'Translation',
      name: 'translation',
      desc: '',
      args: [],
    );
  }

  /// `The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information.`
  String get descriptionFeature1 {
    return Intl.message(
      'The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information.',
      name: 'descriptionFeature1',
      desc: '',
      args: [],
    );
  }

  /// `The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls.`
  String get descriptionFeature2 {
    return Intl.message(
      'The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls.',
      name: 'descriptionFeature2',
      desc: '',
      args: [],
    );
  }

  /// `Import or export your database locally or online via WebDAV, Google Drive, or OneDrive.`
  String get descriptionFeature3 {
    return Intl.message(
      'Import or export your database locally or online via WebDAV, Google Drive, or OneDrive.',
      name: 'descriptionFeature3',
      desc: '',
      args: [],
    );
  }

  /// `SMS Subscribe`
  String get smsSubscribe {
    return Intl.message(
      'SMS Subscribe',
      name: 'smsSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `SMS Blacklist`
  String get smsBlacklist {
    return Intl.message(
      'SMS Blacklist',
      name: 'smsBlacklist',
      desc: '',
      args: [],
    );
  }

  /// `SMS Whitelist`
  String get smsWhitelist {
    return Intl.message(
      'SMS Whitelist',
      name: 'smsWhitelist',
      desc: '',
      args: [],
    );
  }

  /// `SMS Text Blacklist`
  String get smsTextBlacklist {
    return Intl.message(
      'SMS Text Blacklist',
      name: 'smsTextBlacklist',
      desc: '',
      args: [],
    );
  }

  /// `SMS Text Whitelist`
  String get smsTextwhitelist {
    return Intl.message(
      'SMS Text Whitelist',
      name: 'smsTextwhitelist',
      desc: '',
      args: [],
    );
  }

  /// `if there is an error select a country`
  String get ifThereIsAnErrorSelectACountry {
    return Intl.message(
      'if there is an error select a country',
      name: 'ifThereIsAnErrorSelectACountry',
      desc: '',
      args: [],
    );
  }

  /// `No data available.`
  String get noDataAvailable {
    return Intl.message(
      'No data available.',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `SubscriptionModel`
  String get subscriptionmodel {
    return Intl.message(
      'SubscriptionModel',
      name: 'subscriptionmodel',
      desc: '',
      args: [],
    );
  }

  /// `ContactSubscription`
  String get contactsubscription {
    return Intl.message(
      'ContactSubscription',
      name: 'contactsubscription',
      desc: '',
      args: [],
    );
  }

  /// `AutoBackup`
  String get autobackup {
    return Intl.message(
      'AutoBackup',
      name: 'autobackup',
      desc: '',
      args: [],
    );
  }

  /// `PluginUpdate`
  String get pluginupdate {
    return Intl.message(
      'PluginUpdate',
      name: 'pluginupdate',
      desc: '',
      args: [],
    );
  }

  /// `RecordBackup`
  String get recordbackup {
    return Intl.message(
      'RecordBackup',
      name: 'recordbackup',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchase`
  String get restorePurchase {
    return Intl.message(
      'Restore Purchase',
      name: 'restorePurchase',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number and regex pattern`
  String get pleaseEnterAPhoneNumberAndRegexPattern {
    return Intl.message(
      'Please enter a phone number and regex pattern',
      name: 'pleaseEnterAPhoneNumberAndRegexPattern',
      desc: '',
      args: [],
    );
  }

  /// `Match successful!`
  String get matchSuccessful {
    return Intl.message(
      'Match successful!',
      name: 'matchSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Regex Phone Number Test`
  String get regexPhoneNumberTest {
    return Intl.message(
      'Regex Phone Number Test',
      name: 'regexPhoneNumberTest',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get successful {
    return Intl.message(
      'Successful',
      name: 'successful',
      desc: '',
      args: [],
    );
  }

  /// `Regex Pattern Test`
  String get regexPatternTest {
    return Intl.message(
      'Regex Pattern Test',
      name: 'regexPatternTest',
      desc: '',
      args: [],
    );
  }

  /// `Caller ID Data is not available`
  String get callerIdDataIsNotAvailable {
    return Intl.message(
      'Caller ID Data is not available',
      name: 'callerIdDataIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Verify Phone Number`
  String get verifyPhoneNumber {
    return Intl.message(
      'Verify Phone Number',
      name: 'verifyPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Country Code`
  String get countryCode {
    return Intl.message(
      'Country Code',
      name: 'countryCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter country code (e.g., US, CA)`
  String get enterCountryCode {
    return Intl.message(
      'Enter country code (e.g., US, CA)',
      name: 'enterCountryCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Verification Results (shouldAcceptCall Rules):`
  String get verificationResultsRules {
    return Intl.message(
      'Verification Results (shouldAcceptCall Rules):',
      name: 'verificationResultsRules',
      desc: '',
      args: [],
    );
  }

  /// `Caller ID Data:`
  String get callerIdData {
    return Intl.message(
      'Caller ID Data:',
      name: 'callerIdData',
      desc: '',
      args: [],
    );
  }

  /// `Country Name`
  String get countryName {
    return Intl.message(
      'Country Name',
      name: 'countryName',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get avatar {
    return Intl.message(
      'Avatar',
      name: 'avatar',
      desc: '',
      args: [],
    );
  }

  /// `Count`
  String get count {
    return Intl.message(
      'Count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Plugin Data:`
  String get pluginData {
    return Intl.message(
      'Plugin Data:',
      name: 'pluginData',
      desc: '',
      args: [],
    );
  }

  /// `Test Caller ID Overlay`
  String get testCallerIdOverlay {
    return Intl.message(
      'Test Caller ID Overlay',
      name: 'testCallerIdOverlay',
      desc: '',
      args: [],
    );
  }

  /// `Allow Other Numbers`
  String get allowOtherNumbers {
    return Intl.message(
      'Allow Other Numbers',
      name: 'allowOtherNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Verification Page (Rules)`
  String get verificationPageRules {
    return Intl.message(
      'Verification Page (Rules)',
      name: 'verificationPageRules',
      desc: '',
      args: [],
    );
  }

  /// `To test rules`
  String get toTestRules {
    return Intl.message(
      'To test rules',
      name: 'toTestRules',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'da', countryCode: 'DK'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el', countryCode: 'GR'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'GB'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'he', countryCode: 'IL'),
      Locale.fromSubtags(languageCode: 'id', countryCode: 'ID'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja', countryCode: 'JP'),
      Locale.fromSubtags(languageCode: 'ko', countryCode: 'KR'),
      Locale.fromSubtags(languageCode: 'ms', countryCode: 'MY'),
      Locale.fromSubtags(languageCode: 'my', countryCode: 'MM'),
      Locale.fromSubtags(languageCode: 'nl', countryCode: 'NL'),
      Locale.fromSubtags(languageCode: 'pl', countryCode: 'PL'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
      Locale.fromSubtags(languageCode: 'sv', countryCode: 'SE'),
      Locale.fromSubtags(languageCode: 'th', countryCode: 'TH'),
      Locale.fromSubtags(languageCode: 'tr', countryCode: 'TR'),
      Locale.fromSubtags(languageCode: 'uk', countryCode: 'UA'),
      Locale.fromSubtags(languageCode: 'vi', countryCode: 'VN'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'MO'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
