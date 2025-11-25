// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get aboutContactSubscription => 'যোগাযোগ সাবস্ক্রিপশন সম্পর্কে';

  @override
  String get aboutLabels => 'লেবেল সম্পর্কে';

  @override
  String get aboutPhoneSubscriptionRules => 'ফোন সাবস্ক্রিপশন নিয়ম সম্পর্কে';

  @override
  String get aboutPhoneSubscriptions => 'ফোন সাবস্ক্রিপশন সম্পর্কে';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'URL এর মাধ্যমে ফোন রুল লিস্টে সাবস্ক্রাইব করুন, স্বয়ংক্রিয়ভাবে নিয়ম আপডেট করুন। JSON, CSV ফরম্যাট রুল ফাইল সমর্থন করে।';

  @override
  String get aboutSmsFilter => 'SMS ফিল্টার সম্পর্কে';

  @override
  String get aboutSmsSubscriptionRules => 'SMS সাবস্ক্রিপশন নিয়ম সম্পর্কে';

  @override
  String get aboutSubtitle => 'অ্যাপ্লিকেশন সংস্করণ এবং আইনি তথ্য';

  @override
  String get aboutTitle => 'সম্পর্কে';

  @override
  String get action => 'অ্যাকশন';

  @override
  String get actionAll => 'সব';

  @override
  String get actionAllow => 'অনুমতি দিন';

  @override
  String get actionBlock => 'ব্লক করুন';

  @override
  String get actionFilterAll => 'সব ফিল্টার';

  @override
  String get actionFilterTitle => 'অ্যাকশন টাইপ দ্বারা ফিল্টার করুন';

  @override
  String get actionFilterTooltip => 'অ্যাকশন ফিল্টার';

  @override
  String get actionNone => 'কোনো অ্যাকশন নয়';

  @override
  String get actionSilence => 'নীরব';

  @override
  String actionTag(Object actionType) {
    return 'অ্যাকশন: $actionType';
  }

  @override
  String get actionType => 'অ্যাকশন টাইপ';

  @override
  String get actionUnknown => 'অজানা';

  @override
  String get add => 'যোগ করুন';

  @override
  String get addAllowedBlockedRule => 'অনুমতি/ব্লক নিয়ম যোগ করুন';

  @override
  String get addAllowSubscription => 'অনুমতি সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addBlockSubscription => 'ব্লক সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addContactButton => 'যোগাযোগ যোগ করুন';

  @override
  String addContactFailed(Object error) {
    return 'যোগাযোগ যোগ করা যায়নি: $error';
  }

  @override
  String get addedToAllowedRules => 'অনুমোদিত নিয়মে যোগ করা হয়েছে';

  @override
  String get addedToBlacklist => 'ব্ল্যাকলিস্টে যোগ করা হয়েছে';

  @override
  String get addedToBlockedRules => 'ব্লক করা নিয়মে যোগ করা হয়েছে';

  @override
  String get addedToFavoriteContacts => 'প্রিয় যোগাযোগে যোগ করা হয়েছে';

  @override
  String get addedToFavorites => 'প্রিয়তে যোগ করা হয়েছে';

  @override
  String get addedToWhitelist => 'হোয়াইটলিস্টে যোগ করা হয়েছে';

  @override
  String get addFavorite => 'প্রিয় যোগ করুন';

  @override
  String get addFilter => 'ফিল্টার যোগ করুন';

  @override
  String get addLabel => 'লেবেল যোগ করুন';

  @override
  String get addLabelButton => 'লেবেল যোগ করুন';

  @override
  String addLabelFailed(Object error) {
    return 'লেবেল যোগ করা যায়নি: $error';
  }

  @override
  String get addLabelToCall => 'কল রেকর্ডে লেবেল যোগ করুন';

  @override
  String get addName => 'নাম যোগ করুন';

  @override
  String get addNoneSubscription => 'কোনো সাবস্ক্রিপশন নেই';

  @override
  String get addOrEditContactInfo =>
      'যোগাযোগের তথ্য যোগ বা সম্পাদনা করতে ব্যবহৃত হয়';

  @override
  String get addPhoneMark => 'ফোন মার্ক যোগ করুন';

  @override
  String get addPhoneNumberRule => 'ফোন নম্বর নিয়ম যোগ করুন';

  @override
  String get addPlugin => 'প্লাগইন যোগ করুন';

  @override
  String get addPluginFailed => 'প্লাগইন যোগ করা যায়নি';

  @override
  String addPluginFailedWithError(Object error) {
    return 'প্লাগইন যোগ করা যায়নি: $error';
  }

  @override
  String get addPluginFromLocalFile => 'স্থানীয় ফাইল থেকে প্লাগইন যোগ করুন';

  @override
  String get addPluginFromUrl => 'URL থেকে প্লাগইন যোগ করুন';

  @override
  String get addRegexRule => 'রেজেক্স নিয়ম যোগ করুন';

  @override
  String get addRule => 'নিয়ম যোগ করুন';

  @override
  String get addRuleButton => 'নিয়ম যোগ করুন';

  @override
  String addRuleFailed(Object error) {
    return 'নিয়ম যোগ করা যায়নি: $error';
  }

  @override
  String get addRuleTooltip => 'নিয়ম যোগ করুন';

  @override
  String get addSilenceSubscription => 'নীরব সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addSimRuleButton => 'SIM নিয়ম যোগ করুন';

  @override
  String get addSmsFilterRule => 'SMS ফিল্টার নিয়ম যোগ করুন';

  @override
  String get addSmsRule => 'SMS নিয়ম যোগ করুন';

  @override
  String get addSmsSubscription => 'SMS সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addSubscription => 'সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addSubscriptionButton => 'সাবস্ক্রিপশন যোগ করুন';

  @override
  String addSubscriptionFailed(Object error) {
    return 'সাবস্ক্রিপশন যোগ করা যায়নি: $error';
  }

  @override
  String get addSubscriptionTooltip => 'সাবস্ক্রিপশন যোগ করুন';

  @override
  String get addToAllowedRules => 'অনুমোদিত নিয়মে যোগ করুন';

  @override
  String get addToBlacklist => 'ব্ল্যাকলিস্টে যোগ করুন';

  @override
  String get addToBlockedRules => 'ব্লক করা নিয়মে যোগ করুন';

  @override
  String get addToFavoriteContacts => 'প্রিয় যোগাযোগে যোগ করুন';

  @override
  String get addToFavorites => 'প্রিয়তে যোগ করুন';

  @override
  String get addToRules => 'নিয়মে যোগ করুন';

  @override
  String get addToWhitelist => 'হোয়াইটলিস্টে যোগ করুন';

  @override
  String get adPlaceholder => 'বিজ্ঞাপন প্লেসহোল্ডার';

  @override
  String get agent => 'এজেন্ট';

  @override
  String get all => 'সব';

  @override
  String get allCallsTab => 'সব';

  @override
  String get allDataClearedSuccessfully =>
      'সমস্ত ডেটা সফলভাবে পরিষ্কার করা হয়েছে';

  @override
  String get allow => 'অনুমতি দিন';

  @override
  String get allowAllAllowRules => 'সমস্ত অনুমতি নিয়ম';

  @override
  String get allowAllAllowRulesDesc => 'অনুমতি নিয়ম থেকে কল করার অনুমতি দিন';

  @override
  String get allowAllBlacklistedNumbers => 'সমস্ত ব্ল্যাকলিস্টেড নম্বর';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'ব্লকলিস্ট থেকে কল করার অনুমতি দিন';

  @override
  String get allowAllBlockRules => 'সমস্ত ব্লক নিয়ম';

  @override
  String get allowAllBlockRulesDesc => 'ব্লক নিয়ম থেকে কল করার অনুমতি দিন';

  @override
  String get allowAllowedNumbers => 'অনুমোদিত নম্বর';

  @override
  String get allowAllowedNumbersDesc => 'হোয়াইটলিস্ট থেকে কল করার অনুমতি দিন';

  @override
  String get allowBlock => 'অনুমতি/ব্লক';

  @override
  String get allowBlockedNumbers => 'ব্লক করা নম্বরগুলি অনুমতি দিন';

  @override
  String get allowBlockedNumbersDesc => 'ব্লকলিস্ট থেকে কল করার অনুমতি দিন';

  @override
  String get allowedBlockedRule => 'অনুমতি/ব্লক নিয়ম';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'অনুমতি/ব্লক নিয়ম সম্পাদনা করুন';

  @override
  String get allowedBlockedRuleManagement => 'অনুমতি/ব্লক নিয়ম ব্যবস্থাপনা';

  @override
  String get allowNonExceededNumbers => 'সীমা অতিক্রম না করা নম্বর';

  @override
  String get allowNonExceededNumbersDescription =>
      'গণনা সীমা অতিক্রম না করা নম্বরগুলি স্বয়ংক্রিয়ভাবে অনুমতি দিন';

  @override
  String get allowRegexAllowRules => 'রেজেক্স অনুমতি নিয়ম';

  @override
  String get allowRegexAllowRulesDesc =>
      'অনুমতি নিয়মের জন্য রেজেক্স প্যাটার্ন ম্যাচিং সক্ষম করুন';

  @override
  String get allowRegexAllowRulesDescription =>
      'রেজেক্স-ভিত্তিক অনুমতি নিয়ম সক্রিয় করুন';

  @override
  String get allowRegexBlockRules => 'রেজেক্স ব্লক নিয়ম';

  @override
  String get allowRegexBlockRulesDesc =>
      'ব্লক নিয়মের জন্য রেজেক্স প্যাটার্ন ম্যাচিং সক্ষম করুন';

  @override
  String get allowRegexBlockRulesDescription =>
      'রেজেক্স-ভিত্তিক ব্লক নিয়ম সক্রিয় করুন';

  @override
  String get allowRule => 'অনুমতি নিয়ম';

  @override
  String get allowRules => 'অনুমতি নিয়ম';

  @override
  String get allowWhitelistedNumbers => 'হোয়াইটলিস্টেড নম্বরগুলির অনুমতি দিন';

  @override
  String get allowWhitelistedNumbersDescription =>
      'হোয়াইটলিস্টের সমস্ত নম্বরের অনুমতি দিন';

  @override
  String get allPermissionsGranted => 'সমস্ত অনুমতি মঞ্জুর করা হয়েছে';

  @override
  String get allSettingsCompleted => 'সমস্ত সেটিংস সম্পন্ন হয়েছে।';

  @override
  String allUpdateSuccess(Object count) {
    return 'সমস্ত আপডেট সম্পন্ন হয়েছে ($count টি নিয়ম)';
  }

  @override
  String get answerThenHangup => 'উত্তর দিয়ে ফোন কেটে দিন';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. সর্বস্বত্ব সংরক্ষিত।';

  @override
  String get applicationSoftware => 'অ্যাপ্লিকেশন সফটওয়্যার';

  @override
  String get apply => 'প্রয়োগ';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'অনুমোদন ব্যর্থ হয়েছে: অনুগ্রহ করে ক্লায়েন্ট আইডি এবং কী পরীক্ষা করুন';

  @override
  String get authorizationFailedMessage => 'অনুমোদন ব্যর্থ হয়েছে';

  @override
  String get authorizationSuccessMessage => 'অনুমোদন সফল হয়েছে';

  @override
  String get authorizeLoginButton => 'লগইন অনুমোদন করুন';

  @override
  String get automotiveIndustry => 'অটোমোটিভ ইন্ডাস্ট্রি';

  @override
  String get autoSyncLabel => 'স্বয়ংক্রিয় সিঙ্ক';

  @override
  String get autoUpdate => 'স্বয়ংক্রিয় আপডেট';

  @override
  String get autoUpdateDescription =>
      'সাবস্ক্রিপশনের জন্য স্বয়ংক্রিয়-আপডেট ব্যবধান সেট করুন বা ম্যানুয়ালি আপডেট করুন';

  @override
  String get autoUpdateSettings => 'স্বয়ংক্রিয় আপডেট সেটিংস';

  @override
  String get autoUpdateSettingsSubtitle =>
      'নিয়ম এবং প্লাগইনগুলির জন্য স্বয়ংক্রিয় আপডেটগুলি পরিচালনা করুন';

  @override
  String get autoUpdateSettingsTitle => 'স্বয়ংক্রিয় আপডেট সেটিংস';

  @override
  String get autoUpdateSubtitle =>
      'নিয়ম এবং প্লাগইনগুলির জন্য স্বয়ংক্রিয় আপডেটগুলি পরিচালনা করুন';

  @override
  String get autoUpdateTitle => 'স্বয়ংক্রিয় আপডেট';

  @override
  String get avatarBorderColor => 'অ্যাভাটার বর্ডারের রঙ';

  @override
  String get avatarBorderSize => 'অ্যাভাটার বর্ডারের আকার';

  @override
  String get avatarIconSizesSetting => 'অ্যাভাটার এবং আইকন আকার';

  @override
  String get avatarPosition => 'অ্যাভাটার অবস্থান';

  @override
  String get avatarSize => 'অ্যাভাটার আকার';

  @override
  String axisPosition(Object axis) {
    return '$axis অবস্থান';
  }

  @override
  String get backgroundGradientSetting => 'ব্যাকগ্রাউন্ড গ্রেডিয়েন্ট';

  @override
  String get backup => 'ব্যাকআপ';

  @override
  String get backupAndRestore => 'ব্যাকআপ এবং পুনরুদ্ধার';

  @override
  String get backupAndRestoreSubtitle =>
      'অ্যাপ্লিকেশনের ডেটা ব্যাকআপ বা পুনরুদ্ধার করুন';

  @override
  String get backupAndRestoreTitle => 'ব্যাকআপ এবং পুনরুদ্ধার';

  @override
  String get backupFailed => 'ব্যাকআপ ব্যর্থ হয়েছে';

  @override
  String get backupFailedMessage => 'ব্যাকআপ ব্যর্থ হয়েছে';

  @override
  String backupFailedWithError(Object error) {
    return 'ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'অ্যাপ্লিকেশনের ডেটা ব্যাকআপ বা পুনরুদ্ধার করুন';

  @override
  String get backupRestoreTitle => 'ব্যাকআপ এবং পুনরুদ্ধার';

  @override
  String get backupSectionTitle => 'ব্যাকআপ';

  @override
  String get backupSettings => 'ব্যাকআপ সেটিংস';

  @override
  String get backupSettingsDialogTitle => 'ব্যাকআপ সেটিংস';

  @override
  String get backupSettingsTitle => 'ব্যাকআপ সেটিংস';

  @override
  String get backupSuccessMessage => 'সফলভাবে ক্লাউডে ব্যাকআপ করা হয়েছে';

  @override
  String backupSuccessToLocal(Object path) {
    return 'স্থানীয়ভাবে ব্যাকআপ সফল: $path';
  }

  @override
  String get backupToCloud => 'ক্লাউডে ব্যাকআপ';

  @override
  String get backupToCloudDescription =>
      'ক্লাউড স্টোরেজে সেটিংস এবং নিয়মগুলি ব্যাকআপ করুন';

  @override
  String backupToCloudFailed(Object error) {
    return 'ক্লাউডে ব্যাকআপ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get backupToCloudLabel => 'ক্লাউডে ব্যাকআপ';

  @override
  String get backupToCloudSuccess => 'সফলভাবে ক্লাউডে ব্যাকআপ করা হয়েছে';

  @override
  String get backupToCloudTitle => 'ক্লাউডে ব্যাকআপ';

  @override
  String get backupToLocalLabel => 'স্থানীয়ভাবে ব্যাকআপ';

  @override
  String get bank => 'ব্যাংক';

  @override
  String get basicInfo => 'মৌলিক তথ্য';

  @override
  String get basicRuleFilter => 'মৌলিক নিয়ম ফিল্টার';

  @override
  String get basicRuleFiltering => 'মৌলিক নিয়ম ফিল্টারিং';

  @override
  String get basicRuleFilteringExplanation =>
      '• মৌলিক নিয়ম ফিল্টারিং: ব্ল্যাকলিস্ট, হোয়াইটলিস্ট এবং রেজেক্সের উপর ভিত্তি করে নিয়ম ফিল্টার করা';

  @override
  String get basicRuleFilterSettings => 'মৌলিক নিয়ম ফিল্টার সেটিংস';

  @override
  String get basicRuleFilterSubtitle =>
      'ব্ল্যাকলিস্ট/হোয়াইটলিস্ট এবং রেগুলার এক্সপ্রেশন ব্যবহার করে কল ফিল্টার করুন';

  @override
  String get batchDeleteContacts => 'যোগাযোগগুলি ব্যাচ ডিলিট করুন';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'আপনি কি $count টি নির্বাচিত যোগাযোগ মুছতে চান?';
  }

  @override
  String get batchDeleteFailed => 'ব্যাচ ডিলিট ব্যর্থ হয়েছে';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'আপনি কি $count টি লেবেল মুছতে চান?';
  }

  @override
  String get blacklist => 'ব্ল্যাকলিস্ট';

  @override
  String get blacklistingAndWhitelisting => 'ব্ল্যাকলিস্টিং এবং হোয়াইটলিস্টিং';

  @override
  String get blacklistLabel => 'ব্ল্যাকলিস্ট';

  @override
  String get blackWhiteList => 'ব্ল্যাক/হোয়াইট লিস্ট';

  @override
  String get block => 'ব্লক';

  @override
  String get blockCalls => 'কল ব্লক করুন';

  @override
  String get blocked => 'ব্লক করা হয়েছে';

  @override
  String get blockedCallAction => 'ব্লক করা কলের অ্যাকশন';

  @override
  String get blockedCalls => 'ব্লক করা কল';

  @override
  String get blockedCallsTitle => 'ব্লক করা কল';

  @override
  String get blockedCommunications => 'ব্লক করা যোগাযোগ';

  @override
  String get blockedPhoneLabel => 'ব্লক করা কল';

  @override
  String get blockedSpamCalls => 'ব্লক করা স্প্যাম কল';

  @override
  String get blockingTrend => 'ব্লকিং ট্রেন্ড';

  @override
  String get blockInternationalCalls =>
      '+ বা 00 দিয়ে শুরু হয় না এমন নম্বরগুলির সাথে মেলে';

  @override
  String get blockInternationalCallsTitle => 'আন্তর্জাতিক কল ব্লক করুন';

  @override
  String get blockLandlineNumbersTitle => 'ল্যান্ডলাইন নম্বর ব্লক করুন';

  @override
  String get blockMobileNumbers =>
      '13-19 দিয়ে শুরু হয় না এমন নম্বরগুলির সাথে মেলে';

  @override
  String get blockMobileNumbersTitle => 'মোবাইল নম্বর ব্লক করুন';

  @override
  String get blockPremiumRateNumbers =>
      '118 বা 120-190 দিয়ে শুরু হয় না এমন নম্বরগুলির সাথে মেলে';

  @override
  String get blockPremiumRateNumbersTitle => 'প্রিমিয়াম রেট নম্বর ব্লক করুন';

  @override
  String get blockRule => 'ব্লক রুল';

  @override
  String get blockRules => 'ব্লক রুলস';

  @override
  String get blockSpecificAreaCodes =>
      '0 + 2-3 অঙ্কের সংখ্যা দিয়ে শুরু হওয়া নম্বরগুলির সাথে মেলে';

  @override
  String get blockSpecificAreaCodesTitle => 'নির্দিষ্ট এরিয়া কোড ব্লক করুন:';

  @override
  String get blockTypeAnalysisTitle => 'ব্লক টাইপ বিশ্লেষণ';

  @override
  String get both => 'উভয়';

  @override
  String get bulkDelete => 'যোগাযোগগুলি ব্যাচ ডিলিট করুন';

  @override
  String get bulkDeleteContacts => 'যোগাযোগগুলি ব্যাচ ডিলিট করুন';

  @override
  String get bulkDeleteLabels => 'লেবেলগুলি ব্যাচ ডিলিট করুন';

  @override
  String get call => 'কল';

  @override
  String get callback => 'কল ব্যাক';

  @override
  String callbackTo(String number) {
    return '$number-এ কল ব্যাক করুন';
  }

  @override
  String get callBlocking => 'কল ব্লকিং';

  @override
  String get callerIdApp => 'কলার আইডি অ্যাপ';

  @override
  String get callerIdCustomizationTitle => 'কলার আইডি কাস্টমাইজ করুন';

  @override
  String get callerIdDialogTitle => 'কলার আইডি তথ্য';

  @override
  String get callerIdDisplayMode => 'কলার আইডি ডিসপ্লে মোড';

  @override
  String callerIdMarkedByCount(Object count) {
    return '$count জন চিহ্নিত করেছে';
  }

  @override
  String get callerIdPreview => 'কলার আইডি প্রিভিউ';

  @override
  String get callFilter => 'কল ফিল্টার';

  @override
  String get callFilterDescription =>
      'সক্ষম হলে, আগত কলগুলি নীচের নিয়মের তালিকার সাথে তুলনা করা হবে। কল ফিল্টারিং নিয়মগুলি ডিফল্টরূপে ডিভাইসগুলির মধ্যে সিঙ্ক্রোনাইজ করা হয় না।';

  @override
  String get callFilterRules => 'কল ফিল্টার নিয়ম';

  @override
  String get callFilterRulesDescription =>
      'কল ফিল্টারিংয়ের জন্য মৌলিক নিয়ম সেট করুন';

  @override
  String get callFilterSettings => 'কল ফিল্টার সেটিংস';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'কল ফ্রিকোয়েন্সি সীমা এবং ব্লকিং নিয়ম সেট করুন';

  @override
  String get callFrequencyInterceptionTitle => 'কল ফ্রিকোয়েন্সি ইন্টারসেপশন';

  @override
  String get callHistory => 'কল হিস্টোরি';

  @override
  String get callHistoryInfoDesc =>
      'এখানে আপনার কল হিস্টোরি দেখানো হবে, ইনকামিং, আউটগোয়িং এবং মিসড কল সহ।';

  @override
  String get callHistoryInfoTitle => 'কল হিস্টোরি';

  @override
  String callHistoryInitFailed(Object error) {
    return 'কল হিস্টোরি ইনিশিয়ালাইজ করা যায়নি: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'কল হিস্টোরি রিফ্রেশ করা যায়নি: $error';
  }

  @override
  String get callHistoryTab => 'কল হিস্টোরি';

  @override
  String get callHistoryTimelineEarlier => 'আগের';

  @override
  String get callHistoryTimelineToday => 'আজ';

  @override
  String get callHistoryTimelineYesterday => 'গতকাল';

  @override
  String get callScreeningPermission => 'কল স্ক্রিনিং পারমিশন';

  @override
  String get callScreeningPermissionDescription =>
      'স্প্যাম কল স্ক্রিন এবং ব্লক করতে ব্যবহৃত হয়।';

  @override
  String get callScreeningPermissionNotGranted =>
      'কল স্ক্রিনিং পারমিশন মঞ্জুর করা হয়নি, এটি অ্যাপের কার্যকারিতা প্রভাবিত করতে পারে।';

  @override
  String get callSettingsSubtitle => 'কলার আইডি, ফিল্টারিং এবং ব্লকিং সেটিংস';

  @override
  String get callSettingsTitle => 'কল সেটিংস';

  @override
  String get callStatistics => 'কল পরিসংখ্যান';

  @override
  String get callTypeAnswered => 'উত্তর দেওয়া হয়েছে';

  @override
  String get callTypeBlocked => 'ব্লক করা হয়েছে';

  @override
  String get callTypeIconColor => 'কল টাইপ আইকন রঙ';

  @override
  String get callTypeMissed => 'মিসড কল';

  @override
  String get callTypeOutgoing => 'আউটগোয়িং';

  @override
  String get callTypePosition => 'কল টাইপের অবস্থান';

  @override
  String get callTypeUnknown => 'অজানা';

  @override
  String get cancelButton => 'বাতিল';

  @override
  String get carRental => 'গাড়ী ভাড়া';

  @override
  String get carrier => 'ক্যারিয়ার';

  @override
  String get carrierColor => 'ক্যারিয়ার রঙ';

  @override
  String get carrierFontSize => 'ক্যারিয়ার ফন্ট সাইজ';

  @override
  String get carrierPosition => 'ক্যারিয়ার অবস্থান';

  @override
  String get changeLabel => 'লেবেল পরিবর্তন করুন';

  @override
  String changePluginStatusFailed(Object error) {
    return 'প্লাগইন স্ট্যাটাস পরিবর্তন করা যায়নি: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'সাবস্ক্রিপশন স্ট্যাটাস পরিবর্তন করা যায়নি: $error';
  }

  @override
  String get changeTag => 'ট্যাগ পরিবর্তন করুন';

  @override
  String get charity => 'দাতব্য';

  @override
  String chartMonthFormat(int month) {
    return 'মাস $month';
  }

  @override
  String get chartOneDayAgo => '১ দিন আগে';

  @override
  String get chartOneMonthAgo => '১ মাস আগে';

  @override
  String get chartOneWeekAgo => '১ সপ্তাহ আগে';

  @override
  String get chartTenDaysAgo => '১০ দিন আগে';

  @override
  String get chartThreeDaysAgo => '৩ দিন আগে';

  @override
  String get chartToday => 'আজ';

  @override
  String get checkFileFormat =>
      'অনুগ্রহ করে ফাইলের ফরম্যাট বা পারমিশন চেক করুন';

  @override
  String checkPermissionFailed(Object error) {
    return 'পারমিশন চেক করা যায়নি: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'ডিফল্ট ইন্টারসেপ্ট অ্যাকশন চয়ন করুন';

  @override
  String get clearAllData => 'সমস্ত ডেটা মুছুন';

  @override
  String get clearAllDataConfirmation =>
      'আপনি কি নিশ্চিত যে আপনি সমস্ত অ্যাপ্লিকেশন ডেটা মুছতে চান? এই কাজটি অপরিবর্তনীয়।';

  @override
  String get clearAllDataDescription => 'সমস্ত অ্যাপ্লিকেশন ডেটা মুছুন';

  @override
  String get clearAllDataLabel => 'সমস্ত ডেটা মুছুন';

  @override
  String get clearFilter => 'ফিল্টার মুছুন';

  @override
  String get clearLabelFilter => 'লেবেল ফিল্টার মুছুন';

  @override
  String get clearLabelFilterButton => 'লেবেল ফিল্টার মুছুন';

  @override
  String get closeButton => 'বন্ধ করুন';

  @override
  String get cloudSync => 'ক্লাউড সিঙ্ক';

  @override
  String get cloudSyncAndBackupTitle => 'ক্লাউড সিঙ্ক ও ব্যাকআপ';

  @override
  String get cloudSyncSettingsSubtitle =>
      'WebDAV, OneDrive এবং Google Drive কনফিগার করুন';

  @override
  String get cloudSyncSettingsTitle => 'ক্লাউড সিঙ্ক সেটিংস';

  @override
  String get cloudSyncTitle => 'ক্লাউড সিঙ্ক';

  @override
  String get collapseLabelSelector => 'লেবেল সিলেক্টর সংকুচিত করুন';

  @override
  String get collection => 'ঋণ সংগ্রহ';

  @override
  String get colorPickerTitle => 'রঙ নির্বাচন করুন';

  @override
  String get configManagement => 'কনফিগারেশন ম্যানেজমেন্ট';

  @override
  String get configUpdated => 'কনফিগারেশন আপডেট করা হয়েছে';

  @override
  String get configurationAdvice =>
      'সঠিক কনফিগারেশনের মাধ্যমে, আপনি কর্মস্থল এবং ব্যক্তিগত SIM কার্ডের জন্য বিভিন্ন ফিল্টারিং কৌশল সেট করতে পারেন।';

  @override
  String get configureBackupOptions => 'ব্যাকআপ বিকল্পগুলি কনফিগার করুন';

  @override
  String get configureBackupOptionsSubtitle =>
      'ব্যাকআপ বিকল্পগুলি কনফিগার করুন';

  @override
  String get configureCloudSyncService => 'ক্লাউড সিঙ্ক পরিষেবা কনফিগার করুন';

  @override
  String get configureCloudSyncServiceHint =>
      'মাল্টি-ডিভাইস সিঙ্ক সক্ষম করতে অনুগ্রহ করে একটি ক্লাউড সিঙ্ক পরিষেবা কনফিগার করুন।';

  @override
  String get configureCloudSyncServiceMessage =>
      'মাল্টি-ডিভাইস সিঙ্ক সক্ষম করতে অনুগ্রহ করে একটি ক্লাউড সিঙ্ক পরিষেবা কনফিগার করুন।';

  @override
  String get configureSimCardFilterRules =>
      'SIM কার্ড ফিল্টার নিয়মগুলি কনফিগার করুন';

  @override
  String get configureSyncServiceHint =>
      'অনুগ্রহ করে প্রথমে ক্লাউড সিঙ্ক সেটিংসে সিঙ্ক পরিষেবা কনফিগার করুন';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get confirmBatchDeleteContacts =>
      'আপনি কি নির্বাচিত যোগাযোগগুলি মুছতে চান?';

  @override
  String get confirmButton => 'নিশ্চিত করুন';

  @override
  String get confirmDelete => 'মুছে ফেলার নিশ্চিতকরণ';

  @override
  String get confirmDeleteContact =>
      'আপনি কি নিশ্চিত যে আপনি যোগাযোগ মুছতে চান?';

  @override
  String get confirmDeleteContactName => 'মুছে ফেলার নিশ্চিতকরণ?';

  @override
  String get confirmDeleteFilter =>
      'আপনি কি নিশ্চিত যে আপনি এই ফিল্টারটি মুছতে চান?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'আপনি কি নিশ্চিত যে আপনি \"$name\" লেবেলটি মুছতে চান?';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'আপনি কি নিশ্চিত যে আপনি \"$name\" প্লাগইনটি মুছতে চান?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'আপনি কি নিশ্চিত যে আপনি $count টি প্লাগইন মুছতে চান?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'আপনি কি নিশ্চিত যে আপনি এই নিয়মটি মুছতে চান? এই কাজটি অপরিবর্তনীয়।';

  @override
  String get confirmDeleteSelectedContacts =>
      'আপনি কি নির্বাচিত যোগাযোগগুলি মুছতে চান?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'আপনি কি নিশ্চিত যে আপনি এই SMS ফিল্টার নিয়মটি মুছতে চান?';

  @override
  String get confirmDeleteSmsRule =>
      'আপনি কি নিশ্চিত যে আপনি এই SMS নিয়মটি মুছতে চান?';

  @override
  String get confirmDeleteSubscription =>
      'আপনি কি নিশ্চিত যে আপনি এই সাবস্ক্রিপশনটি মুছতে চান?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'আপনি কি নিশ্চিত যে আপনি $name মুছতে চান?';
  }

  @override
  String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get confirmPasswordLabel => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get connectedStatus => 'সংযুক্ত';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'সংযোগ ব্যর্থ হয়েছে: অনুগ্রহ করে সার্ভার ঠিকানা, ব্যবহারকারীর নাম এবং পাসওয়ার্ড পরীক্ষা করুন';

  @override
  String get connectionFailedMessage => 'সংযোগ ব্যর্থ হয়েছে';

  @override
  String get connectionStatusLabel => 'সংযোগের অবস্থা';

  @override
  String get connectionSuccessMessage => 'সংযোগ সফল';

  @override
  String get contactAddSuccess => 'যোগাযোগ সফলভাবে যোগ করা হয়েছে';

  @override
  String get contactDeleted => 'যোগাযোগ মুছে ফেলা হয়েছে';

  @override
  String get contactEditDialog => 'যোগাযোগ সম্পাদনা ডায়ালগ';

  @override
  String get contactNameHint => 'যোগাযোগের নাম লিখুন (ঐচ্ছিক)';

  @override
  String get contactNameLabel => 'নাম';

  @override
  String get contactNameOptional => 'যোগাযোগের নাম (ঐচ্ছিক)';

  @override
  String get contactNotFound => 'যোগাযোগ পাওয়া যায়নি';

  @override
  String get contacts => 'যোগাযোগ';

  @override
  String contactsDeleted(Object count) {
    return '$countটি যোগাযোগ মুছে ফেলা হয়েছে';
  }

  @override
  String get contactSettingsSubtitle => 'যোগাযোগ ব্যবস্থাপনা এবং লেবেল সেটিংস';

  @override
  String get contactSettingsTitle => 'যোগাযোগ সেটিংস';

  @override
  String contactsLoadingFailed(Object error) {
    return 'যোগাযোগ লোড করতে ব্যর্থ: $error';
  }

  @override
  String get contactsManagement => 'যোগাযোগ ব্যবস্থাপনা';

  @override
  String get contactsManagementPageTitle => 'যোগাযোগ ব্যবস্থাপনা পৃষ্ঠা';

  @override
  String get contactsPageTitle => 'যোগাযোগ ব্যবস্থাপনা';

  @override
  String get contactsPermission => 'যোগাযোগের অনুমতি';

  @override
  String get contactsPermissionDescription =>
      'যোগাযোগের কল শনাক্ত করতে ব্যবহৃত হয়।';

  @override
  String get contactsTab => 'যোগাযোগ';

  @override
  String get contactSubscriptionDescription =>
      'URL এর মাধ্যমে যোগাযোগ তালিকা সাবস্ক্রাইব করুন, যোগাযোগের তথ্য এবং লেবেল স্বয়ংক্রিয়ভাবে আপডেট করুন। JSON ফরম্যাট ডেটা সমর্থন করে।';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'যোগাযোগ সাবস্ক্রিপশন লোড করতে ব্যর্থ: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'যোগাযোগ সাবস্ক্রিপশন';

  @override
  String get contactUpdateSuccess => 'যোগাযোগ সফলভাবে আপডেট করা হয়েছে';

  @override
  String get contactUs => 'আমাদের সাথে যোগাযোগ করুন';

  @override
  String get content => 'বিষয়বস্তু';

  @override
  String get contentRegex => 'বিষয়বস্তু রেজেক্স';

  @override
  String get countColor => 'গণনা রঙ';

  @override
  String get countFontSize => 'গণনা ফন্ট সাইজ';

  @override
  String get countPosition => 'গণনা অবস্থান';

  @override
  String get country => 'দেশ';

  @override
  String get countryNameColor => 'দেশের নামের রঙ';

  @override
  String get countryNameFontSize => 'দেশের নামের ফন্ট সাইজ';

  @override
  String get countryRegionNamePosition => 'দেশ/অঞ্চলের নামের অবস্থান';

  @override
  String get countrySelectionDialog => 'দেশ নির্বাচন ডায়ালগ';

  @override
  String get countrySelectionDialogDescription =>
      'কলার আইডি তথ্য জিজ্ঞাসা করার জন্য একটি দেশ নির্বাচন করতে ব্যবহৃত হয়';

  @override
  String get countThresholdDescription =>
      'ফিল্টারিং অ্যাকশন ট্রিগার করার জন্য প্রয়োজনীয় সর্বনিম্ন গণনা সীমা সেট করুন';

  @override
  String get countThresholdLabel => 'গণনা সীমা';

  @override
  String get countThresholdSettings => 'গণনা সীমা সেটিংস';

  @override
  String countThresholdValue(Object count) {
    return 'গণনা সীমা: $count';
  }

  @override
  String get createdRules => 'তৈরি করা নিয়ম';

  @override
  String get csvFormat => 'CSV ফরম্যাট';

  @override
  String get currentDeviceChip => 'বর্তমান';

  @override
  String get currentDeviceLabel => 'বর্তমান ডিভাইসের লেবেল';

  @override
  String get currentDeviceTitle => 'বর্তমান ডিভাইস';

  @override
  String get currentLabels => 'বর্তমান লেবেল:';

  @override
  String get currentLanguage => 'বর্তমান ভাষা';

  @override
  String get currentPasswordLabel => 'বর্তমান পাসওয়ার্ড';

  @override
  String get customerService => 'গ্রাহক পরিষেবা';

  @override
  String get customRange => 'কাস্টম পরিসীমা';

  @override
  String get dailyStatistics => 'দৈনিক পরিসংখ্যান';

  @override
  String get dailyStatisticsDesc =>
      'ব্লক করা কল এবং বার্তাগুলির দৈনিক পরিসংখ্যান পান';

  @override
  String get dashboardTab => 'ড্যাশবোর্ড';

  @override
  String get dataAnalysis => 'ডেটা বিশ্লেষণ';

  @override
  String get dataAnalysisDashboardPage => 'ডেটা বিশ্লেষণ ড্যাশবোর্ড পৃষ্ঠা';

  @override
  String get dataExport => 'ডেটা এক্সপোর্ট';

  @override
  String dataLoadFailure(Object error) {
    return 'ডেটা লোড করতে ব্যর্থ: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'ডেটা লোড করতে ব্যর্থ: $error';
  }

  @override
  String get dataMigration => 'ডেটা মাইগ্রেশন';

  @override
  String get dataMigrationDescription =>
      'এই বৈশিষ্ট্যটি আপনাকে ডিভাইসগুলির মধ্যে আপনার সমস্ত ডেটা স্থানান্তর করতে দেয়। বর্তমানে, আপনি আপনার ডেটা ম্যানুয়ালি স্থানান্তর করতে ব্যাকআপ এবং পুনরুদ্ধার বৈশিষ্ট্যগুলি ব্যবহার করতে পারেন।';

  @override
  String get dataMigrationDialogContent =>
      'এই বৈশিষ্ট্যটি আপনাকে ডিভাইসগুলির মধ্যে আপনার সমস্ত ডেটা স্থানান্তর করতে দেয়। বর্তমানে, আপনি আপনার ডেটা ম্যানুয়ালি স্থানান্তর করতে ব্যাকআপ এবং পুনরুদ্ধার বৈশিষ্ট্যগুলি ব্যবহার করতে পারেন।';

  @override
  String get dataMigrationDialogTitle => 'ডেটা মাইগ্রেশন';

  @override
  String get dataMigrationSectionTitle => 'ডেটা মাইগ্রেশন';

  @override
  String get dataSourceReminder => 'ডেটা উৎস অনুস্মারক';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count দিন',
      one: '1 দিন',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days দিন ভিআইপি';
  }

  @override
  String get debtCollection => 'ঋণ সংগ্রহ';

  @override
  String get defaultPeriod => 'সপ্তাহ';

  @override
  String get delete => 'মুছে ফেলুন';

  @override
  String get deleteButton => 'মুছে ফেলুন';

  @override
  String get deleteContact => 'যোগাযোগ মুছে ফেলুন';

  @override
  String deleteContactConfirm(Object name) {
    return 'আপনি কি নিশ্চিত যে আপনি $name মুছে ফেলতে চান?';
  }

  @override
  String get deleteContactConfirmation =>
      'আপনি কি নিশ্চিত যে আপনি যোগাযোগ মুছে ফেলতে চান';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'আপনি কি নিশ্চিত যে আপনি $deviceName মুছে ফেলতে চান?';
  }

  @override
  String get deleteDeviceDialogTitle => 'ডিভাইস মুছে ফেলুন';

  @override
  String deleteFailed(Object error) {
    return 'মুছে ফেলতে ব্যর্থ: $error';
  }

  @override
  String get deleteFilter => 'ফিল্টার মুছে ফেলুন';

  @override
  String get deleteLabel => 'লেবেল মুছে ফেলুন';

  @override
  String deleteLabelFailed(Object error) {
    return 'লেবেল মুছতে ব্যর্থ: $error';
  }

  @override
  String get deletePlugin => 'প্লাগইন মুছে ফেলুন';

  @override
  String deletePluginFailed(Object error) {
    return 'প্লাগইন মুছতে ব্যর্থ: $error';
  }

  @override
  String get deletePlugins => 'প্লাগইন মুছে ফেলুন';

  @override
  String deletePluginsFailed(Object error) {
    return 'প্লাগইন মুছতে ব্যর্থ: $error';
  }

  @override
  String get deleteRule => 'নিয়ম মুছে ফেলুন';

  @override
  String deleteRuleFailed(Object error) {
    return 'মুছতে ব্যর্থ: $error';
  }

  @override
  String get deleteSelected => 'নির্বাচিতগুলি মুছে ফেলুন';

  @override
  String get deleteSmsRule => 'এসএমএস নিয়ম মুছে ফেলুন';

  @override
  String get deleteSubscription => 'সাবস্ক্রিপশন মুছুন';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'আপনি কি নিশ্চিত যে আপনি \"$name\" সাবস্ক্রিপশনটি মুছতে চান?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'সাবস্ক্রিপশন মুছতে ব্যর্থ: $error';
  }

  @override
  String get deleteSuccess => 'মুছে ফেলা সফল';

  @override
  String get delivery => 'ডেলিভারি';

  @override
  String get deviceDeletedSuccessfully => 'ডিভাইস সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get deviceDeletedSuccessfullyMessage =>
      'ডিভাইস সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get deviceIdLabel => 'ডিভাইস আইডি';

  @override
  String get deviceIDLabel => 'ডিভাইস আইডি';

  @override
  String get deviceManagementSubtitle =>
      'মাল্টি-ডিভাইস সিঙ্ক্রোনাইজেশন পরিচালনা করুন';

  @override
  String get deviceManagementTitle => 'ডিভাইস ব্যবস্থাপনা';

  @override
  String get deviceModelLabel => 'ডিভাইসের মডেল';

  @override
  String get deviceName => 'ডিভাইসের নাম';

  @override
  String get deviceNameCannotBeEmpty => 'ডিভাইসের নাম খালি রাখা যাবে না';

  @override
  String get deviceNameHint => 'অনুগ্রহ করে ডিভাইসের নাম লিখুন';

  @override
  String get deviceNameLabel => 'ডিভাইসের নাম';

  @override
  String get deviceRenamedSuccessfully =>
      'ডিভাইসের নাম সফলভাবে পরিবর্তন করা হয়েছে';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'ডিভাইসের নাম সফলভাবে পরিবর্তন করা হয়েছে';

  @override
  String get devicesSyncedSuccessfully => 'ডিভাইসগুলি সফলভাবে সিঙ্ক করা হয়েছে';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'ডিভাইসগুলি সফলভাবে সিঙ্ক করা হয়েছে';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'ডিভাইসগুলি সফলভাবে সিঙ্ক্রোনাইজ করা হয়েছে';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'ডিভাইস সফলভাবে নিবন্ধিতকরণ বাতিল করা হয়েছে';

  @override
  String get dialogTitle => 'রেজেক্স প্যাটার্ন ব্যাখ্যা';

  @override
  String get differentFromLocalCounter =>
      'এই ফিচারটি লোকাল কাউন্টার ফিল্টারের থেকে আলাদা, কারণ এটি দীর্ঘমেয়াদী মার্কিং কাউন্টের পরিবর্তে অল্প সময়ের মধ্যে বারবার কল প্যাটার্নের উপর দৃষ্টি নিবদ্ধ করে।';

  @override
  String get disabled => 'অক্ষম';

  @override
  String get disabledStatus => 'অক্ষম';

  @override
  String get disableGlobalPlugins => 'গ্লোবাল প্লাগইনগুলি অক্ষম করুন';

  @override
  String get disableSubscriptionSuccessfully =>
      'সাবস্ক্রিপশন সফলভাবে অক্ষম করা হয়েছে';

  @override
  String get disconnectButton => 'সংযোগ বিচ্ছিন্ন করুন';

  @override
  String get disconnectedMessage => 'সংযোগ বিচ্ছিন্ন';

  @override
  String get disconnectedStatus => 'সংযোগ বিচ্ছিন্ন';

  @override
  String get disconnectFailedMessage => 'সংযোগ বিচ্ছিন্নকরণ ব্যর্থ হয়েছে';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get dualSimAdvice =>
      'এই ফিচারটি বিশেষভাবে ডুয়াল-সিম ফোনগুলির জন্য উপযোগী, যেখানে ওয়ার্ক এবং ব্যক্তিগত সিম কার্ডের জন্য ভিন্ন ভিন্ন ফিল্টারিং কৌশল সেট করা যেতে পারে।';

  @override
  String get earlier => 'আগের';

  @override
  String get ecommerce => 'ই-কমার্স';

  @override
  String get edit => 'সম্পাদনা করুন';

  @override
  String get editContact => 'যোগাযোগ সম্পাদনা করুন';

  @override
  String get editFilter => 'ফিল্টার সম্পাদনা করুন';

  @override
  String get editLabel => 'লেবেল সম্পাদনা করুন';

  @override
  String get editPhoneRule => 'ফোন রুল সম্পাদনা করুন';

  @override
  String get editPhoneRules => 'ফোন রুল সম্পাদনা করতে ব্যবহৃত হয়';

  @override
  String get editPhoneRuleTitle => 'ফোন রুল সম্পাদনা করুন';

  @override
  String get editRule => 'রুল সম্পাদনা করুন';

  @override
  String get editSmsRule => 'এসএমএস রুল সম্পাদনা করুন';

  @override
  String get education => 'শিক্ষা';

  @override
  String get elementPositionsSetting => 'উপাদানের অবস্থান';

  @override
  String get email => 'ইমেইল';

  @override
  String get emailOptional => 'ইমেইল (ঐচ্ছিক)';

  @override
  String get enableCallFilter => 'কল ফিল্টার সক্ষম করুন';

  @override
  String get enableCallFilterDescription =>
      'সক্ষম করা হলে, ইনকামিং কলগুলি নীচের রুল তালিকার সাথে মিলিয়ে দেখা হবে। কল ফিল্টারিং রুলগুলি ডিফল্টরূপে ডিভাইসগুলির মধ্যে সিঙ্ক্রোনাইজ হয় না।';

  @override
  String get enabled => 'সক্ষম';

  @override
  String get enabledStatus => 'সক্ষম';

  @override
  String get enableEncryption => 'এনক্রিপশন সক্ষম করুন';

  @override
  String get enableEncryptionDescription => 'ব্যাকআপ ফাইল এনক্রিপ্ট করুন';

  @override
  String get enableEncryptionLabel => 'এনক্রিপশন সক্ষম করুন';

  @override
  String get enableEncryptionSubtitle => 'ব্যাকআপ ফাইল এনক্রিপ্ট করা হবে';

  @override
  String get enableEncryptionTitle => 'এনক্রিপশন সক্ষম করুন';

  @override
  String get enableGlobalPlugins => 'গ্লোবাল প্লাগইনগুলি সক্ষম করুন';

  @override
  String get enableLocalCountFilter => 'লোকাল কাউন্ট ফিল্টার সক্ষম করুন';

  @override
  String get enableLocalCountFilterDescription =>
      'কল মার্কিং কাউন্টের উপর ভিত্তি করে স্বয়ংক্রিয়ভাবে স্প্যাম কলগুলি ফিল্টার করুন';

  @override
  String get enableLocalNotification => 'লোকাল নোটিফিকেশন ব্যবহার করুন';

  @override
  String get enableLocalNotificationDescription =>
      'সক্ষম করা হলে, ফিল্টার করা বার্তাগুলির জন্য নোটিফিকেশন ডিভাইসে প্রদর্শিত হবে';

  @override
  String get enableLocationSummary => 'অবস্থান';

  @override
  String get enableMuteRules => 'মিউট রুল সক্ষম করুন';

  @override
  String get enableMuteRulesDesc =>
      'মিউট ইন্টারসেপশন রুল কনফিগারেশন প্রয়োগ করুন';

  @override
  String get enableNoneActionRules => 'কোনো অ্যাকশন রুল সক্ষম করুন';

  @override
  String get enableNoneActionRulesDesc =>
      'কোনো ইন্টারসেপশন অ্যাকশন ছাড়াই রুল কনফিগারেশন করার অনুমতি দিন';

  @override
  String get enableNotifications => 'নোটিফিকেশন সক্ষম করুন';

  @override
  String get enableRemoteNumberFilter => 'রিমোট নম্বর ফিল্টার সক্ষম করুন';

  @override
  String get enableRemoteNumberFilterDescription =>
      'নম্বর ফিল্টার করতে রিমোট ডেটাবেস ব্যবহার করুন';

  @override
  String get enableRule => 'রুল সক্ষম করুন';

  @override
  String get enableSmsFilter => 'এসএমএস ফিল্টারিং সক্ষম করুন';

  @override
  String get enableSmsFilterDescription =>
      'সক্ষম করা হলে, রুল অনুযায়ী বার্তাগুলি স্বয়ংক্রিয়ভাবে ফিল্টার করা হবে';

  @override
  String get enableStatisticsNotifications =>
      'পরিসংখ্যান নোটিফিকেশন সক্ষম করুন';

  @override
  String get enableSubscriptionSuccessfully =>
      'সাবস্ক্রিপশন সফলভাবে সক্ষম করা হয়েছে';

  @override
  String get enableTimeInterception => 'সময়ভিত্তিক ইন্টারসেপশন সক্ষম করুন';

  @override
  String get enableTimeInterceptionDescription =>
      'অল্প সময়ের মধ্যে পুনরাবৃত্ত কলগুলি ইন্টারসেপ্ট করুন';

  @override
  String get enableTimeInterceptor => 'টাইম ইন্টারসেপ্টর সক্ষম করুন';

  @override
  String get endCallImmediately => 'কল অবিলম্বে শেষ করুন';

  @override
  String get endColor => 'শেষ রঙ';

  @override
  String get endDate => 'শেষ তারিখ';

  @override
  String get enhancedFilterInstructionsTitle => 'উন্নত ফিল্টার সিস্টেম';

  @override
  String get enhancedFilterSettings => 'উন্নত ফিল্টার সেটিংস';

  @override
  String get enhancedFilterSettingsTitle => 'উন্নত ফিল্টার সেটিংস';

  @override
  String get enhancedFilterSystemDescription =>
      'উন্নত ফিল্টার সিস্টেম গ্লোবাল রুল এবং প্রতি-সিম কার্ড ফিল্টারিং কনফিগারেশন উভয়কেই সমর্থন করে।';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'অনুগ্রহ করে ফোন নম্বর এবং রেজেক্স প্যাটার্ন উভয়ই লিখুন';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'অনুগ্রহ করে ফোন নম্বর এবং রেজেক্স প্যাটার্ন উভয়ই লিখুন।';

  @override
  String get enterContactName => 'অনুগ্রহ করে যোগাযোগের নাম লিখুন';

  @override
  String get enterCurrentPasswordHint => 'বর্তমান পাসওয়ার্ড লিখুন';

  @override
  String get enterDeviceName => 'ডিভাইসের নাম লিখুন';

  @override
  String get enterDeviceNameHint => 'অনুগ্রহ করে ডিভাইসের নাম লিখুন';

  @override
  String get enterEmail => 'অনুগ্রহ করে ইমেইল লিখুন';

  @override
  String get enterEmailOptional => 'অনুগ্রহ করে ইমেইল (ঐচ্ছিক) লিখুন';

  @override
  String get enterEncryptionPasswordHint => 'এনক্রিপশন পাসওয়ার্ড লিখুন';

  @override
  String get enterEncryptionPasswordTitle => 'এনক্রিপশন পাসওয়ার্ড লিখুন';

  @override
  String get enterFilterName => 'অনুগ্রহ করে ফিল্টারের নাম লিখুন';

  @override
  String get enterFilterPattern => 'অনুগ্রহ করে ফিল্টারের প্যাটার্ন লিখুন';

  @override
  String get enterIconCode => 'আইকন কোড লিখুন';

  @override
  String get enterName => 'যোগাযোগের নাম লিখুন';

  @override
  String get enterNewDeviceNameHint => 'এই ডিভাইসের জন্য একটি নতুন নাম লিখুন';

  @override
  String get enterNewPasswordHint => 'নতুন পাসওয়ার্ড লিখুন';

  @override
  String get enterPasswordAgain => 'পাসওয়ার্ড আবার লিখুন';

  @override
  String get enterPasswordHint => 'পাসওয়ার্ড লিখুন';

  @override
  String get enterPhoneNumber => 'ফোন নম্বর লিখুন';

  @override
  String get enterPhoneNumberHint => 'পরীক্ষা করার জন্য ফোন নম্বর লিখুন';

  @override
  String get enterPhoneNumberMultiple =>
      'অনুগ্রহ করে ফোন নম্বর লিখুন, কমা দ্বারা পৃথক করা একাধিক নম্বর';

  @override
  String get enterPhoneNumberToStartSearch =>
      'অনুসন্ধান শুরু করার জন্য ফোন নম্বর লিখুন';

  @override
  String get enterPhoneNumberToVerify => 'যাচাই করার জন্য ফোন নম্বর লিখুন';

  @override
  String get enterPluginName => 'প্লাগইনের নাম লিখুন';

  @override
  String get enterPluginUrl => 'প্লাগইন ইউআরএল ঠিকানা লিখুন';

  @override
  String get enterRegexHint => 'রেজেক্স প্যাটার্ন লিখুন';

  @override
  String get enterRuleNameAndPattern =>
      'অনুগ্রহ করে রুল এর নাম এবং প্যাটার্ন লিখুন';

  @override
  String get enterRuleNameAndPatternMessage =>
      'অনুগ্রহ করে নিয়ম নাম এবং রেগুলার এক্সপ্রেশন প্যাটার্ন উভয়ই লিখুন।';

  @override
  String get enterRuleNameHint => 'নিয়ম নাম লিখুন';

  @override
  String get enterSearchContent => 'অনুগ্রহ করে অনুসন্ধানের বিষয়বস্তু লিখুন';

  @override
  String get enterSubscriptionName => 'সাবস্ক্রিপশন নাম লিখুন';

  @override
  String get enterSubscriptionUrl => 'সাবস্ক্রিপশন URL লিখুন';

  @override
  String get enterSyncFolderNameHint =>
      'অনুগ্রহ করে সিঙ্ক ফোল্ডারের নাম লিখুন (ডিফল্ট: NotificationManager)';

  @override
  String get entertainment => 'বিনোদন';

  @override
  String get enterValidNameAndUrl => 'অনুগ্রহ করে সঠিক নাম এবং URL লিখুন';

  @override
  String get enterValidUrl => 'অনুগ্রহ করে একটি বৈধ URL লিখুন';

  @override
  String get enterVersion => 'সংস্করণ লিখুন';

  @override
  String get enterWebDAVPasswordHint => 'অনুগ্রহ করে WebDAV পাসওয়ার্ড লিখুন';

  @override
  String get enterWebDAVServerAddressHint =>
      'অনুগ্রহ করে WebDAV সার্ভারের ঠিকানা লিখুন';

  @override
  String get enterWebDAVUsernameHint =>
      'অনুগ্রহ করে WebDAV ব্যবহারকারীর নাম লিখুন';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'ডিভাইস মুছতে ত্রুটি: $error';
  }

  @override
  String get errorLoadingPlugin => 'প্লাগইন লোড হতে ত্রুটি';

  @override
  String errorOccurredMessage(Object error) {
    return 'একটি ত্রুটি ঘটেছে: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'ডিভাইসের নাম পরিবর্তন করতে ত্রুটি: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'ডিভাইস সিঙ্ক করতে ত্রুটি: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'ডিভাইস সিঙ্ক করতে ত্রুটি: $error';
  }

  @override
  String get errorText => 'ত্রুটি';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'ডিভাইস নিবন্ধন বাতিল করতে ত্রুটি: $error';
  }

  @override
  String get exampleBlock400Prefix => 'যেমন, 400 উপসর্গ নম্বর ব্লক করুন';

  @override
  String get exampleBlockMarketingSms => 'যেমন, মার্কেটিং SMS ব্লক করুন';

  @override
  String get exampleContentRegex => 'যেমন, .*offer.*';

  @override
  String get exampleContentRegexHint => 'উদাহরণ বিষয়বস্তুর রেগুলার এক্সপ্রেশন';

  @override
  String get exampleCouponPromotionDiscount =>
      'যেমন, .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'যেমন, পরিবার, বন্ধু, ইত্যাদি।';

  @override
  String get examplePhoneNumber => 'যেমন, 10086, 12345, ইত্যাদি।';

  @override
  String get exampleRegex400Prefix =>
      '400 উপসর্গ সংখ্যার জন্য উদাহরণ রেগুলার এক্সপ্রেশন';

  @override
  String get exampleRegexFormat => 'উদাহরণ: ^10086\$ ফরম্যাট';

  @override
  String get exampleSenderRegexHint => 'উদাহরণ';

  @override
  String get exchange => 'বিনিময়';

  @override
  String get exchangeNow => 'এখন বিনিময় করুন';

  @override
  String get exchangeVip => 'VIP বিনিময়';

  @override
  String get expandLabelSelector => 'লেবেল নির্বাচক প্রসারিত করুন';

  @override
  String expiryTime(Object time) {
    return 'মেয়াদ উত্তীর্ণের সময়: $time';
  }

  @override
  String get export => 'রপ্তানি';

  @override
  String get exportAllApplicationSettings =>
      'সমস্ত অ্যাপ্লিকেশন সেটিংস রপ্তানি করুন';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'সমস্ত অ্যাপ্লিকেশন সেটিংস রপ্তানি করুন';

  @override
  String get exportAllRuleConfigurations =>
      'সমস্ত নিয়মের কনফিগারেশন রপ্তানি করুন';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'সমস্ত নিয়মের কনফিগারেশন রপ্তানি করুন';

  @override
  String get exportComplete => 'রপ্তানি সম্পন্ন';

  @override
  String get exportConfig => 'কনফিগারেশন রপ্তানি করুন';

  @override
  String get exportContacts => 'যোগাযোগ রপ্তানি করুন';

  @override
  String get exportData => 'ডেটা রপ্তানি করুন';

  @override
  String get exportError => 'রপ্তানি ত্রুটি';

  @override
  String get exportFailed => 'রপ্তানি ব্যর্থ';

  @override
  String get exportFailure => 'কনফিগারেশন রপ্তানি করতে ব্যর্থ';

  @override
  String get exportFeatureComingSoon => 'রপ্তানি বৈশিষ্ট্য শীঘ্রই আসছে';

  @override
  String get exporting => 'রপ্তানি হচ্ছে...';

  @override
  String get exportLabels => 'লেবেল রপ্তানি করুন';

  @override
  String exportLabelsFailed(Object error) {
    return 'লেবেল রপ্তানি করতে ব্যর্থ: $error';
  }

  @override
  String get exportPluginList => 'প্লাগইন তালিকা রপ্তানি করুন';

  @override
  String exportPluginListFailed(Object error) {
    return 'প্লাগইন তালিকা রপ্তানি করতে ব্যর্থ: $error';
  }

  @override
  String get exportRules => 'নিয়ম রপ্তানি করুন';

  @override
  String get exportRulesDialogTitle => 'নিয়ম রপ্তানি করুন';

  @override
  String get exportRulesTitle => 'নিয়ম রপ্তানি করুন';

  @override
  String get exportSmsRules => 'SMS নিয়ম রপ্তানি করুন';

  @override
  String get exportStatisticsData => 'পরিসংখ্যান ডেটা রপ্তানি করুন';

  @override
  String get exportSuccess => 'রপ্তানি সফল';

  @override
  String get exportSuccesslly => 'কনফিগারেশন সফলভাবে রপ্তানি করা হয়েছে';

  @override
  String get failedToAddContact => 'যোগাযোগ যোগ করতে ব্যর্থ';

  @override
  String failedToAddRule(Object error) {
    return 'নিয়ম যোগ করতে ব্যর্থ: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS নিয়ম যোগ করতে ব্যর্থ: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS সাবস্ক্রিপশন যোগ করতে ব্যর্থ: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'সেটিংস ব্যাকআপ করতে ব্যর্থ: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'ব্যাকআপ ফাইল ডিক্রিপ্ট করতে ব্যর্থ';

  @override
  String get failedToDeleteDevice => 'ডিভাইস মুছতে ব্যর্থ';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS নিয়ম মুছতে ব্যর্থ: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'নিয়ম রপ্তানি করতে ব্যর্থ: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS নিয়ম রপ্তানি করতে ব্যর্থ: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'কলার আইডি তথ্য পেতে ব্যর্থ: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'নিয়ম আমদানি করতে ব্যর্থ: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS নিয়ম আমদানি করতে ব্যর্থ: $error';
  }

  @override
  String get failedToLoadContacts => 'যোগাযোগ লোড করতে ব্যর্থ';

  @override
  String get failedToLoadPlugin => 'প্লাগইন লোড করতে ব্যর্থ';

  @override
  String get failedToRenameDevice => 'ডিভাইসের নাম পরিবর্তন করতে ব্যর্থ';

  @override
  String get failedToRestoreSettings => 'সেটিংস পুনরুদ্ধার করতে ব্যর্থ';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'সেটিংস পুনরুদ্ধার করতে ব্যর্থ: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'পাসওয়ার্ড সেট করতে ব্যর্থ: $error';
  }

  @override
  String get failedToSyncDevices => 'ডিভাইস সিঙ্ক করতে ব্যর্থ';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'নিয়মের স্থিতি পরিবর্তন করতে ব্যর্থ: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'সাবস্ক্রিপশনের স্থিতি পরিবর্তন করতে ব্যর্থ';

  @override
  String get failedToUpdateContact => 'যোগাযোগ আপডেট করতে ব্যর্থ';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS নিয়ম আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String get failure => 'ব্যর্থতা';

  @override
  String get favoriteContacts => 'প্রিয় যোগাযোগ';

  @override
  String get featureAddRules => '• ফোন নম্বর নির্দিষ্ট নিয়ম যোগ করুন';

  @override
  String get featureCenter => 'ফিচার সেন্টার';

  @override
  String get featureEnableDisable =>
      '• প্রতিটি SIM এর জন্য বিভিন্ন ফিল্টার সক্ষম/নিষ্ক্রিয় করুন';

  @override
  String get featureListTitle => 'ফিচারসমূহ:';

  @override
  String get featureManageRules =>
      '• প্রতিটি SIM এর জন্য নিয়ম তালিকা পরিচালনা করুন';

  @override
  String get features => 'ফিচারসমূহ';

  @override
  String get fetchingCallerIdInfo => 'কলার আইডি তথ্য আনা হচ্ছে...';

  @override
  String fileSavedTo(Object path) {
    return 'ফাইল সংরক্ষিত হয়েছে: $path';
  }

  @override
  String get filter => 'ফিল্টার';

  @override
  String get filterByLabel => 'লেবেল দ্বারা ফিল্টার করুন';

  @override
  String get filterClear => 'ফিল্টার সাফ করুন';

  @override
  String get filterControlPanelTitle => 'ফিল্টার নিয়ন্ত্রণ প্যানেল';

  @override
  String get filterControlSubtitle =>
      'সমস্ত ফিল্টারের চালু/বন্ধ স্থিতি পরিচালনা করুন';

  @override
  String get filterControlTitle => 'ফিল্টার কন্ট্রোল';

  @override
  String get filterDeleteFailed => 'ফিল্টার ডিলিট ব্যর্থ হয়েছে';

  @override
  String get filterDeleteSuccess => 'ফিল্টার সফলভাবে ডিলিট হয়েছে';

  @override
  String get filterDetails => 'ফিল্টার বিস্তারিত';

  @override
  String get filtered => 'ফিল্টার করা';

  @override
  String get filteredSms => 'ফিল্টার করা SMS';

  @override
  String get filteredSmsLabel => 'ফিল্টার করা SMS';

  @override
  String get filterExplanation => 'ফিল্টার ব্যাখ্যা';

  @override
  String get filterManagement => 'ফিল্টার ম্যানেজমেন্ট';

  @override
  String get filterName => 'ফিল্টার নাম';

  @override
  String get filterPattern => 'ফিল্টার প্যাটার্ন';

  @override
  String get filterPriorityNote =>
      'দ্রষ্টব্য: ফিল্টারগুলির মধ্যে অগ্রাধিকার সম্পর্ক রয়েছে, বিস্তারিত জানার জন্য সাহায্য ডকুমেন্টেশন দেখুন';

  @override
  String get filterSaveFailed => 'ফিল্টার সেভ ব্যর্থ হয়েছে';

  @override
  String get filterSaveSuccess => 'ফিল্টার সফলভাবে সেভ হয়েছে';

  @override
  String get filterSettings => 'ফিল্টার সেটিংস';

  @override
  String get filterSettingsTitle => 'ফিল্টার সেটিংস';

  @override
  String get filterSMS => 'SMS ফিল্টার করুন';

  @override
  String get filterToggleInstructions =>
      'এই SIM স্লটের জন্য ফিল্টার সক্রিয় বা নিষ্ক্রিয় করুন:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status ফিল্টার: $filterName';
  }

  @override
  String get filterType => 'ফিল্টার টাইপ';

  @override
  String get financial => 'আর্থিক';

  @override
  String get flexibleCombinationFeature =>
      '• ফ্লেক্সিবল কম্বিনেশন: প্রতি SIM স্লটের জন্য ফিল্টার সক্ষম/অক্ষম করুন';

  @override
  String get fontSizesSetting => 'ফন্টের আকার';

  @override
  String foundRules(Object count) {
    return '$count টি নিয়ম পাওয়া গেছে';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count টি নিয়ম পাওয়া গেছে। আপনি কি সেগুলি ইম্পোর্ট করতে চান?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count টি নিয়ম পাওয়া গেছে। আপনি কি সেগুলি ইম্পোর্ট করতে চান?';
  }

  @override
  String get fraudAlert => 'প্রতারণার সতর্কতা - কল কেটে দিন';

  @override
  String get fraudScamLikely => 'প্রতারণা স্ক্যাম সম্ভাব্য';

  @override
  String get free => 'ফ্রি';

  @override
  String get functionSettingsTitle => 'ফাংশন সেটিংস';

  @override
  String generalUpdateFailure(Object error) {
    return 'আপডেট ব্যর্থ হয়েছে: $error';
  }

  @override
  String get getFree => 'বিনামূল্যে পান';

  @override
  String get github => 'গিটহাব';

  @override
  String get globalFilterDescription =>
      'সমস্ত SIM কার্ডের জন্য গ্লোবাল ফিল্টার কনফিগার করুন:';

  @override
  String get globalFilterFeature =>
      '• গ্লোবাল ফিল্টার: সমস্ত আগত কলের জন্য মৌলিক নিয়ম';

  @override
  String get globalFilterSettings => 'গ্লোবাল ফিল্টার সেটিংস';

  @override
  String get globalFilterToggleInstructions =>
      'সমস্ত SIM স্লটে প্রযোজ্য গ্লোবাল ফিল্টার সেটিংস কনফিগার করুন:';

  @override
  String get globalSearchSubtitle =>
      'যোগাযোগ, লেবেল, ব্ল্যাকলিস্ট, হোয়াইটলিস্ট, ইত্যাদি অনুসন্ধান করুন';

  @override
  String get globalSearchTitle => 'গ্লোবাল অনুসন্ধান';

  @override
  String get globalSettings => 'গ্লোবাল সেটিংস';

  @override
  String get googleAdDisplayPosition => 'গুগল বিজ্ঞাপন প্রদর্শনের অবস্থান';

  @override
  String get googleAdMobIntegrationText =>
      'এখানে Google AdMob বিজ্ঞাপনগুলি সংহত করা যেতে পারে';

  @override
  String get googleDriveAuthDescription =>
      'সিস্টেম-কনফিগার করা Google Drive ক্লায়েন্ট আইডি এবং কী ব্যবহার করে অনুমোদন করুন';

  @override
  String get googleDriveAuthorizationHint =>
      'সিস্টেম-কনফিগার করা Google Drive ক্লায়েন্ট আইডি এবং কী ব্যবহার করে অনুমোদন করুন';

  @override
  String get googleDriveConfigTitle => 'Google Drive কনফিগারেশন';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive কনফিগারেশন';

  @override
  String get government => 'সরকারি';

  @override
  String get granted => 'অনুমোদিত';

  @override
  String get grantNecessaryPermissions => 'প্রয়োজনীয় অনুমতি প্রদান করুন';

  @override
  String get grantPermissions => 'অনুমতি প্রদান করুন';

  @override
  String get headhunter => 'হেডহান্টার';

  @override
  String get height => 'উচ্চতা';

  @override
  String get homePageTitle => 'হোম পেজ';

  @override
  String get homeTab => 'হোম';

  @override
  String get howItWorksPoint1 =>
      '• সিস্টেম স্বয়ংক্রিয়ভাবে একটি নির্দিষ্ট সময়সীমার মধ্যে একই নম্বর থেকে কলগুলি গ্রহণ করবে';

  @override
  String get howItWorksPoint2 =>
      '• ছোট সময়সীমা কঠোরভাবে আটকানো হবে; দীর্ঘ সময়সীমা শিথিলভাবে আটকানো হবে';

  @override
  String get howItWorksPoint3 =>
      '• সিস্টেম কল লগগুলি পরীক্ষা করে দেখবে যে এটি একটি পুনরাবৃত্তি কল কিনা';

  @override
  String get howItWorksTitle => 'কীভাবে কাজ করে:';

  @override
  String get iconCodeOptional => 'আইকন কোড (ঐচ্ছিক)';

  @override
  String get iconSize => 'আইকন আকার';

  @override
  String get import => 'ইম্পোর্ট';

  @override
  String get important => 'গুরুত্বপূর্ণ';

  @override
  String get importButton => 'ইম্পোর্ট';

  @override
  String get importConfig => 'কনফিগারেশন ইম্পোর্ট';

  @override
  String get importContacts => 'যোগাযোগ ইম্পোর্ট';

  @override
  String get importExportContacts => 'যোগাযোগ ইম্পোর্ট/এক্সপোর্ট';

  @override
  String get importExportContactsTooltip => 'যোগাযোগ ইম্পোর্ট/এক্সপোর্ট';

  @override
  String get importExportRules => 'নিয়ম ইম্পোর্ট/এক্সপোর্ট';

  @override
  String importFailed(Object error) {
    return 'ইম্পোর্ট ব্যর্থ হয়েছে: $error';
  }

  @override
  String get importFailure => 'কনফিগারেশন ইম্পোর্ট করতে ব্যর্থ';

  @override
  String get importFeatureComingSoon => 'ইম্পোর্ট বৈশিষ্ট্য শীঘ্রই আসছে';

  @override
  String get importLabels => 'লেবেল ইম্পোর্ট';

  @override
  String importLabelsFailed(Object error) {
    return 'লেবেল ইম্পোর্ট করতে ব্যর্থ: $error';
  }

  @override
  String get importPluginList => 'প্লাগইন তালিকা ইম্পোর্ট';

  @override
  String importPluginListFailed(Object error) {
    return 'প্লাগইন তালিকা ইম্পোর্ট করতে ব্যর্থ: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'সফলভাবে $count টি প্লাগইন ইম্পোর্ট করা হয়েছে';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'ফাইল থেকে নিয়ম কনফিগারেশন ইম্পোর্ট করুন';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'ফাইল থেকে নিয়ম কনফিগারেশন ইম্পোর্ট করুন';

  @override
  String get importRules => 'নিয়ম ইম্পোর্ট';

  @override
  String get importRulesButton => 'নিয়ম ইম্পোর্ট করুন';

  @override
  String get importRulesDialogTitle => 'নিয়ম ইম্পোর্ট';

  @override
  String importRulesError(Object error) {
    return 'নিয়ম ইম্পোর্ট করতে ব্যর্থ: $error';
  }

  @override
  String get importRulesInstructions => 'CSV ফাইল থেকে নিয়ম ইম্পোর্ট করুন';

  @override
  String get importRulesSuccess => 'নিয়ম সফলভাবে ইম্পোর্ট করা হয়েছে';

  @override
  String get importRulesTitle => 'নিয়ম ইম্পোর্ট';

  @override
  String get importSuccess => 'ইম্পোর্ট সফল';

  @override
  String get incomingCallInterceptAction => 'আগত কল ইন্টারসেপ্ট অ্যাকশন';

  @override
  String get incomingCallNotification => 'আগত কল বিজ্ঞপ্তি';

  @override
  String get incorrectPassword => 'ভুল পাসওয়ার্ড';

  @override
  String get initializing => 'শুরু হচ্ছে';

  @override
  String get installed => 'ইনস্টল করা';

  @override
  String get insufficientMarks => 'অপর্যাপ্ত নম্বর';

  @override
  String get insurance => 'বীমা';

  @override
  String get interceptAction => 'ইন্টারসেপ্ট অ্যাকশন';

  @override
  String get interceptionActionSettingsSubtitle =>
      'ব্লক করা কলগুলি কীভাবে পরিচালনা করা হয় তা সেট করুন';

  @override
  String get interceptionActionSettingsTitle => 'ইন্টারসেপশন অ্যাকশন সেটিংস';

  @override
  String get interceptionTimeInterval => 'ইন্টারসেপশন সময় ব্যবধান';

  @override
  String get internet => 'ইন্টারনেট';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service আপডেট ব্যবধান $days দিনে সেট করা হয়েছে';
  }

  @override
  String get invalidContentRegex => 'অবৈধ কন্টেন্ট রেজেক্স';

  @override
  String get invalidLabel => 'অবৈধ লেবেল';

  @override
  String get invalidRegexPattern => 'অবৈধ রেগেএক্স প্যাটার্ন';

  @override
  String get invalidSenderRegex => 'অবৈধ প্রেরক রেগেএক্স';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'আরও তথ্যের জন্য টেলিগ্রাম চ্যানেল এবং গ্রুপে যোগ দিন';

  @override
  String get jsLogsTitle => 'জেএস লগ';

  @override
  String get jsonFormat => 'জেএসওএন ফরম্যাট';

  @override
  String get keepAllVersions => 'সমস্ত সংস্করণ রাখুন';

  @override
  String get keepAllVersionsDescription =>
      'প্রতিটি ব্যাকআপের সমস্ত ঐতিহাসিক সংস্করণ রাখুন';

  @override
  String get keepAllVersionsLabel => 'সমস্ত সংস্করণ রাখুন';

  @override
  String get keepAllVersionsSubtitle =>
      'প্রতিটি ব্যাকআপের ঐতিহাসিক সংস্করণ রাখুন';

  @override
  String get keepAllVersionsTitle => 'সমস্ত সংস্করণ রাখুন';

  @override
  String get label => 'লেবেল';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'লেবেল \"$name\" সফলভাবে যোগ করা হয়েছে';
  }

  @override
  String get labelCategories => 'লেবেল বিভাগ';

  @override
  String get labelDeleted => 'লেবেল মুছে ফেলা হয়েছে';

  @override
  String get labelDescription =>
      'লেবেলগুলি আপনাকে পরিচিতিগুলি আরও ভালভাবে পরিচালনা করতে সহায়তা করে, কল এবং বার্তাগুলির সহজ সনাক্তকরণের জন্য ফোন নম্বরগুলিতে কাস্টম লেবেল যুক্ত করুন।';

  @override
  String get labelFilter => 'লেবেল ফিল্টার';

  @override
  String get labelFilterTooltip => 'লেবেল ফিল্টার';

  @override
  String get labelIconColor => 'লেবেল আইকনের রঙ';

  @override
  String get labelManagement => 'লেবেল ব্যবস্থাপনা';

  @override
  String get labelNotFound => 'লেবেল পাওয়া যায়নি';

  @override
  String get labelRemoved => 'লেবেল সরানো হয়েছে';

  @override
  String labelRemoveFailed(Object error) {
    return 'লেবেল সরাতে ব্যর্থ: $error';
  }

  @override
  String get labels => 'লেবেল';

  @override
  String get labelsColor => 'লেবেলের রঙ';

  @override
  String labelsDeleted(Object count) {
    return '$count লেবেল মুছে ফেলা হয়েছে';
  }

  @override
  String get labelsExportedSuccessfully => 'লেবেল সফলভাবে রপ্তানি করা হয়েছে';

  @override
  String get labelsFontSize => 'লেবেলের ফন্ট সাইজ';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'সফলভাবে $count লেবেল আমদানি করা হয়েছে';
  }

  @override
  String get labelsPosition => 'লেবেলের অবস্থান';

  @override
  String labelTag(Object labelId) {
    return 'লেবেল: $labelId';
  }

  @override
  String get labelUpdated => 'লেবেল আপডেট করা হয়েছে';

  @override
  String labelUpdateFailed(Object error) {
    return 'লেবেল আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'লেবেল \"\$labelText\" সফলভাবে আপডেট করা হয়েছে';

  @override
  String get languageSettings => 'ভাষা সেটিংস';

  @override
  String get languageSettingsSubtitle =>
      'অ্যাপ্লিকেশনের ডিসপ্লে ভাষা পরিবর্তন করুন';

  @override
  String get languageSettingsTitle => 'ভাষা সেটিংস';

  @override
  String get last30Days => 'গত ৩০ দিন';

  @override
  String get last7Days => 'গত ৭ দিন';

  @override
  String get lastSyncLabel => 'শেষ সিঙ্ক';

  @override
  String lastUpdated(Object date) {
    return 'শেষ আপডেট: $date';
  }

  @override
  String get lifetimeMembership => 'আজীবন সদস্যপদ';

  @override
  String get lifetimeMembershipDescription =>
      'এককালীন ক্রয়, সমস্ত প্রিমিয়াম বৈশিষ্ট্য এবং ভবিষ্যতের আপডেটগুলি স্থায়ীভাবে আনলক করুন';

  @override
  String loadContactsFailed(Object error) {
    return 'পরিচিতি লোড করতে ব্যর্থ: $error';
  }

  @override
  String get loadDataFailed => 'ডেটা লোড করতে ব্যর্থ';

  @override
  String get loadFailed => 'লোড ব্যর্থ';

  @override
  String get loading => 'লোড হচ্ছে...';

  @override
  String get loadingData => 'ডেটা লোড হচ্ছে...';

  @override
  String get loadingTags => 'ট্যাগ লোড হচ্ছে...';

  @override
  String loadLabelFailed(Object error) {
    return 'লেবেল লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'লেবেল লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'মার্ক করা ফোন নম্বর লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'মার্ক করা ফোন লোড করতে ব্যর্থ: $error';
  }

  @override
  String get loadMore => 'আরও লোড করুন';

  @override
  String get loadPluginButton => 'প্লাগইন লোড করুন';

  @override
  String loadPluginsFailed(Object error) {
    return 'প্লাগইন লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'সেটিংস লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'এসএমএস নিয়ম লোড করতে ব্যর্থ: $error';
  }

  @override
  String get loadStatusFailedMessage => 'স্ট্যাটাস লোড করতে ব্যর্থ';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'সাবস্ক্রিপশন লোড করতে ব্যর্থ: $error';
  }

  @override
  String get loan => 'ঋণ';

  @override
  String get localBackupTitle => 'স্থানীয় ব্যাকআপ';

  @override
  String get localCounterFilter => 'স্থানীয় কাউন্টার ফিল্টার';

  @override
  String get localCounterFilterSubtitle =>
      'কল ফ্রিকোয়েন্সির উপর ভিত্তি করে স্বয়ংক্রিয়ভাবে স্প্যাম কল ফিল্টার করুন';

  @override
  String get localCountFilter => 'স্থানীয় গণনা ফিল্টার';

  @override
  String get localCountFilterDescription =>
      'স্থানীয় সংখ্যা গণনার উপর ভিত্তি করে ঘন ঘন কল আটকান';

  @override
  String get localCountFilterExplanationContent =>
      'স্থানীয় গণনা ফিল্টার স্বয়ংক্রিয়ভাবে ঘন ঘন স্প্যাম কল সনাক্ত এবং ব্লক করতে কল ইতিহাস রেকর্ড বিশ্লেষণ করে।';

  @override
  String get localCountFilterExplanationTitle =>
      'স্থানীয় গণনা ফিল্টার ব্যাখ্যা';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• সংখ্যার গণনা মানের উপর ভিত্তি করে ব্লক করবেন কিনা তা নির্ধারণ করুন';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• যখন একটি সংখ্যার গণনা নির্ধারিত সীমা অতিক্রম করে, আপনি এটি স্বয়ংক্রিয়ভাবে ব্লক করতে পারেন';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• আপনি নির্দিষ্ট সংখ্যাগুলি নির্বাচন করতে পারেন যা সীমা অতিক্রম করে না';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• আপনি সমস্ত কোয়েরি লগ রেকর্ড করতে চান কিনা তা চয়ন করতে পারেন';

  @override
  String get localCountFiltering => 'স্থানীয় গণনা ফিল্টারিং';

  @override
  String get localCountFilteringExplanation =>
      '• স্থানীয় গণনা ফিল্টারিং: স্থানীয় মার্কিং গণনার উপর ভিত্তি করে ফিল্টারিং নিয়ম';

  @override
  String get localCountFilterSettings => 'স্থানীয় গণনা ফিল্টার সেটিংস';

  @override
  String get localCountFilterUseCases =>
      'এই ফিল্টারটি অটো-ডায়াল করা স্প্যাম কল এবং বিপণন কল সনাক্ত করার জন্য বিশেষভাবে উপযুক্ত।';

  @override
  String get localFilterSettings => 'স্থানীয় ফিল্টার সেটিংস';

  @override
  String get localNotificationDisabled => 'স্থানীয় বিজ্ঞপ্তি নিষ্ক্রিয়';

  @override
  String get localNotificationEnabled => 'স্থানীয় বিজ্ঞপ্তি সক্রিয়';

  @override
  String get localServices => 'স্থানীয় পরিষেবা';

  @override
  String get locationColor => 'অবস্থানের রঙ';

  @override
  String get locationFontSize => 'অবস্থানের ফন্ট সাইজ';

  @override
  String get locationIconColor => 'অবস্থান আইকন রঙ';

  @override
  String get locationPosition => 'অবস্থানের অবস্থান';

  @override
  String get logAllLocalQueries => 'সমস্ত স্থানীয় কোয়েরি লগ করুন';

  @override
  String get logAllLocalQueriesDescription =>
      'সমস্ত স্থানীয় সংখ্যা কোয়েরির জন্য লগ রেকর্ড করুন';

  @override
  String get logAllRemoteQueries => 'সমস্ত রিমোট কোয়েরি লগ করুন';

  @override
  String get logAllRemoteQueriesDescription =>
      'সমস্ত রিমোট নম্বর কোয়েরি অপারেশন রেকর্ড করুন';

  @override
  String get manage => 'যোগাযোগ পরিচালনা করুন';

  @override
  String get manageContacts => 'পরিচালনা';

  @override
  String get manageFavoriteContacts => 'প্রিয় যোগাযোগগুলি পরিচালনা করুন';

  @override
  String get manageFilterRules => 'ফিল্টার নিয়ম পরিচালনা করুন';

  @override
  String get manageFilterRulesDescription =>
      'এসএমএস ফিল্টার নিয়ম যোগ করুন, সম্পাদনা করুন বা মুছুন';

  @override
  String get manageFrequentContacts => 'ঘন ঘন যোগাযোগগুলি পরিচালনা করুন';

  @override
  String get markCounts => 'মার্ক গণনা';

  @override
  String get markCount => 'মার্ক গণনা';

  @override
  String markedByCount(Object count) {
    return '$count দ্বারা মার্ক করা';
  }

  @override
  String get markedPhonesList => 'মার্ক করা ফোন নম্বর';

  @override
  String get markExchange => 'মার্ক বিনিময়';

  @override
  String get markPhone => 'ফোন নম্বর মার্ক করুন';

  @override
  String markPhoneFailed(Object error) {
    return 'ফোন নম্বর চিহ্নিতকরণ ব্যর্থ: $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'ফোন নম্বর চিহ্নিত করতে';

  @override
  String get markPhoneManagementTitle => 'চিহ্নিত ফোন ব্যবস্থাপনা';

  @override
  String get markPhoneSuccess => 'ফোন নম্বর সফলভাবে চিহ্নিত করা হয়েছে';

  @override
  String get matchFailed => 'মিল মেলেনি!';

  @override
  String get matchFailedMessage => 'মিল মেলেনি।';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'নির্দিষ্ট নম্বর বিন্যাসের সাথে মেলে';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'বিশেষ অক্ষর সহ নম্বর মেলান:';

  @override
  String get matchSpecificDigitPatterns => 'XXX-XXXX-XXXX বিন্যাসের সাথে মেলে';

  @override
  String get matchSpecificDigitPatternsTitle => 'নির্দিষ্ট অঙ্ক বিন্যাস মেলান:';

  @override
  String get matchSuccessful => 'মিল সফল!';

  @override
  String get matchSuccessfulMessage => 'মিল সফল!';

  @override
  String get medical => 'মেডিকেল';

  @override
  String get membershipPrivileges => 'সদস্যপদ সুবিধা';

  @override
  String get migrationTool => 'মাইগ্রেশন টুল';

  @override
  String get migrationToolTitle => 'মাইগ্রেশন টুল';

  @override
  String get minutes => 'মিনিট';

  @override
  String get month => 'মাস';

  @override
  String get monthly => 'মাসিক';

  @override
  String get monthlyCallCount => 'মাসিক কল';

  @override
  String get monthlyChartTitle => 'মাসিক ব্লক করা কল';

  @override
  String get monthlyMembership => 'মাসিক সদস্যপদ';

  @override
  String get monthlyMembershipDescription =>
      'সমস্ত প্রিমিয়াম বৈশিষ্ট্য আনলক করুন, মাসিক স্বয়ংক্রিয়ভাবে নবায়ন করুন';

  @override
  String get monthlyTotal => 'মাসিক মোট';

  @override
  String get monthlyTotalLabel => 'মাসিক মোট';

  @override
  String get moreOptions => 'আরও বিকল্প';

  @override
  String get mute => 'মিউট';

  @override
  String get name => 'নাম';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'নাম এবং ফোন নম্বর খালি রাখা যাবে না';

  @override
  String get nameAndPhoneNumberRequired =>
      'নাম এবং ফোন নম্বর খালি রাখা যাবে না';

  @override
  String get nameColor => 'নামের রঙ';

  @override
  String get nameFontSize => 'নামের ফন্ট সাইজ';

  @override
  String nameLabel(Object name) {
    return 'নাম: $name';
  }

  @override
  String get namePosition => 'নামের অবস্থান';

  @override
  String get nameUnknown => 'নাম: অজানা';

  @override
  String nameWithValue(String name) {
    return 'নাম: $name';
  }

  @override
  String get newPasswordLabel => 'নতুন পাসওয়ার্ড';

  @override
  String get nextStep => 'পরবর্তী';

  @override
  String get noAction => 'কোনো পদক্ষেপ নেই';

  @override
  String get noActionRules => 'কোনো পদক্ষেপের নিয়ম নেই';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'কোনো সক্রিয় ক্লাউড সিঙ্ক পরিষেবা নেই';

  @override
  String get noCallLogs => 'কল লগ নেই';

  @override
  String get noCallRecords => 'কোনো কল রেকর্ড নেই';

  @override
  String get noContacts => 'এখনো কোনো পরিচিতি নেই';

  @override
  String get noContactsYet => 'এখনো কোনো পরিচিতি নেই';

  @override
  String get noData => 'কোনো ডেটা নেই';

  @override
  String get noDevicesRegisteredMessage => 'কোনো ডিভাইস নিবন্ধিত নেই';

  @override
  String get noDevicesRegisteredYet => 'এখনো কোনো ডিভাইস নিবন্ধিত নেই।';

  @override
  String get noFilters => 'এখনো কোনো ফিল্টার নেই';

  @override
  String get noLabels => 'এখনো কোনো লেবেল নেই';

  @override
  String get noMarkedPhones => 'কোনো চিহ্নিত ফোন নম্বর নেই';

  @override
  String get noMatchingContacts => 'কোনো মিলযুক্ত পরিচিতি নেই';

  @override
  String get noMatchingContactsFound => 'কোনো মিলযুক্ত পরিচিতি পাওয়া যায়নি';

  @override
  String get noMatchingNumbersFound => 'কোনো মিলযুক্ত নম্বর পাওয়া যায়নি';

  @override
  String get noMatchingRecords => 'কোনো মিলযুক্ত কল রেকর্ড নেই';

  @override
  String noMatchingRules(Object ruleType) {
    return 'কোনো মিলযুক্ত $ruleType নেই';
  }

  @override
  String get none => 'কোনোটিই নয়';

  @override
  String get noneServiceType => 'কোনোটিই নয়';

  @override
  String get noPlugins => 'এখনো কোনো প্লাগইন নেই';

  @override
  String get noRecords => 'কোনো কল রেকর্ড নেই';

  @override
  String get noResultReturned => 'কোনো ফলাফল পাওয়া যায়নি';

  @override
  String get noResultReturnedLog => 'প্লাগইন থেকে কোনো ফলাফল পাওয়া যায়নি';

  @override
  String noRules(Object ruleType) {
    return 'কোনো $ruleType নেই';
  }

  @override
  String get noRulesPrompt =>
      'কোনো নিয়ম পাওয়া যায়নি, অনুগ্রহ করে নিয়ম যোগ করুন';

  @override
  String get noRulesToExport => 'রপ্তানির জন্য কোনো নিয়ম নেই';

  @override
  String get noSmsFilterRulesYet => 'এখনো কোনো এসএমএস ফিল্টার নিয়ম নেই';

  @override
  String get noSmsRulesYet => 'এখনো কোনো এসএমএস নিয়ম নেই';

  @override
  String get noSubscriptions => 'কোনো সাবস্ক্রিপশন নেই';

  @override
  String get noSubscriptionsYet => 'এখনো কোনো সাবস্ক্রিপশন নেই';

  @override
  String get notGranted => 'অনুমতি দেওয়া হয়নি';

  @override
  String get notificationMode => 'বিজ্ঞপ্তি মোড';

  @override
  String get notificationModeDescription => 'বিজ্ঞপ্তি বারে কলারের তথ্য দেখান';

  @override
  String get notificationPermission => 'বিজ্ঞপ্তি অনুমতি';

  @override
  String get notificationPermissionDescription =>
      'ইনকামিং কল এবং মেসেজ নোটিফিকেশন দেখানোর জন্য ব্যবহৃত হয়।';

  @override
  String get notifications => 'বিজ্ঞপ্তি';

  @override
  String get notificationSettings => 'বিজ্ঞপ্তি সেটিংস';

  @override
  String get notificationSettingsSaved =>
      'বিজ্ঞপ্তি সেটিংস সফলভাবে সংরক্ষিত হয়েছে';

  @override
  String get notSet => 'সেট করা হয়নি';

  @override
  String get notVerifiedText => 'যাচাই করা হয়নি';

  @override
  String get noValidSmsRulesFoundInFile =>
      'ফাইলে কোনো বৈধ এসএমএস নিয়ম পাওয়া যায়নি';

  @override
  String get number => 'নম্বর';

  @override
  String get numberColor => 'নম্বর রঙ';

  @override
  String get numberFontSize => 'নম্বর ফন্ট সাইজ';

  @override
  String get numberPosition => 'নম্বর অবস্থান';

  @override
  String get numberSearch => 'নম্বর অনুসন্ধান';

  @override
  String get numberTypeColor => 'নম্বর টাইপ রঙ';

  @override
  String get numberTypeFontSize => 'নম্বর টাইপ ফন্ট সাইজ';

  @override
  String get numberTypePosition => 'নম্বর টাইপ অবস্থান';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get okButton => 'ঠিক আছে';

  @override
  String get onboardingCompleteDescription =>
      'আপনার কল সুরক্ষা ম্যানেজার প্রস্তুত, একটি নিরাপদ কল অভিজ্ঞতা উপভোগ শুরু করুন!';

  @override
  String get onboardingLanguageDescription =>
      'সেরা অভিজ্ঞতার জন্য আপনার পছন্দের ভাষা নির্বাচন করুন।';

  @override
  String get onboardingPermissionsDescription =>
      'সম্পূর্ণ পরিষেবা প্রদানের জন্য, আমাদের নিম্নলিখিত অনুমতিগুলির প্রয়োজন:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'স্প্যাম কল এবং মেসেজ এক-ক্লিক ব্লক করুন, ব্লকিং নিয়ম কাস্টমাইজ করুন এবং আপনাকে একটি শান্ত পরিবেশ দিন।';

  @override
  String get onboardingSmartCallerIdDescription =>
      'অজানা কলগুলি স্বয়ংক্রিয়ভাবে সনাক্ত করুন, সন্দেহজনক নম্বর চিহ্নিত করুন এবং আপনার কলের সুরক্ষা নিশ্চিত করুন।';

  @override
  String get onboardingWelcomeDescription =>
      'আপনার কল ম্যানেজমেন্ট বিশেষজ্ঞ, ব্যাপক কল সনাক্তকরণ এবং ব্লকিং পরিষেবা সরবরাহ করে।';

  @override
  String get oneDriveAuthDescription =>
      'সিস্টেম-কনফিগার করা OneDrive ক্লায়েন্ট আইডি এবং কী ব্যবহার করে অনুমোদন করুন';

  @override
  String get oneDriveAuthorizationHint =>
      'সিস্টেম-কনফিগার করা OneDrive ক্লায়েন্ট আইডি এবং কী ব্যবহার করে অনুমোদন করুন';

  @override
  String get oneDriveConfigTitle => 'OneDrive কনফিগারেশন';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive কনফিগারেশন';

  @override
  String get onlineCallerIdSubscription => 'অনলাইন কলার আইডি সাবস্ক্রিপশন';

  @override
  String get openAppSettings => 'অ্যাপ সেটিংস খুলুন';

  @override
  String openAppSettingsFailed(Object error) {
    return 'অ্যাপ সেটিংস খোলা যায়নি: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'অপারেশন ব্যর্থ হয়েছে: $error';
  }

  @override
  String get operationFailure => 'অপারেশন ব্যর্থ হয়েছে';

  @override
  String get operationSuccess => 'অপারেশন সফল হয়েছে';

  @override
  String get other => 'অন্যান্য';

  @override
  String get ourOtherApps => 'আমাদের অন্যান্য অ্যাপ';

  @override
  String get overlayMode => 'ফ্লোটিং উইন্ডো';

  @override
  String get overlayModeDescription => 'কলার তথ্য একটি ভাসমান উইন্ডোতে দেখান';

  @override
  String get overlayPermission => 'ওভারলে অনুমতি';

  @override
  String get overlayPermissionDescription =>
      'ইনকামিং কল ওভারলে প্রদর্শনের জন্য ব্যবহৃত হয়।';

  @override
  String get overview => 'সংক্ষিপ্ত বিবরণ';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get passwordCannotBeEmpty => 'পাসওয়ার্ড খালি রাখা যাবে না';

  @override
  String get passwordLabel => 'পাসওয়ার্ড';

  @override
  String get passwordsDoNotMatch => 'পাসওয়ার্ড মেলে না';

  @override
  String get passwordSetSuccessfully => 'পাসওয়ার্ড সফলভাবে সেট করা হয়েছে';

  @override
  String get pattern => 'প্যাটার্ন';

  @override
  String get pendingSync => 'সিঙ্ক মুলতুবি';

  @override
  String get periodMonth => 'মাস';

  @override
  String get periodWeek => 'সপ্তাহ';

  @override
  String get periodYear => 'বছর';

  @override
  String get permissionDenied => 'অনুমতি অনুরোধ প্রত্যাখ্যান করা হয়েছে';

  @override
  String get permissionGranted => 'অনুমতি মঞ্জুর করা হয়েছে';

  @override
  String get permissionManagement => 'অনুমতি ব্যবস্থাপনা';

  @override
  String get phoneCallsTab => 'ফোন';

  @override
  String get phoneNumber => 'ফোন নম্বর';

  @override
  String get phoneNumberCannotBeEmpty => 'ফোন নম্বর খালি রাখা যাবে না';

  @override
  String get phoneNumberHint => 'ফোন নম্বর লিখুন';

  @override
  String get phoneNumberHintText => 'রুল যোগ করার জন্য ফোন নম্বর লিখুন';

  @override
  String get phoneNumberLabel => 'ফোন নম্বর';

  @override
  String get phoneNumberRegexRequired =>
      'অনুগ্রহ করে ফোন নম্বর এবং রেজেক্স প্যাটার্ন উভয়ই লিখুন';

  @override
  String get phoneNumberRequired => 'ফোন নম্বর প্রয়োজন';

  @override
  String get phoneNumberTypeFixedLine => 'ফিক্সড লাইন';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'ফিক্সড লাইন বা মোবাইল';

  @override
  String get phoneNumberTypeMobile => 'মোবাইল';

  @override
  String get phoneNumberTypePager => 'পেজার';

  @override
  String get phoneNumberTypePersonalNumber => 'ব্যক্তিগত নম্বর';

  @override
  String get phoneNumberTypePremiumRate => 'প্রিমিয়াম রেট';

  @override
  String get phoneNumberTypeSharedCost => 'শেয়ার্ড কস্ট';

  @override
  String get phoneNumberTypeTollFree => 'টোল ফ্রি';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'অজানা';

  @override
  String get phoneNumberTypeVoicemail => 'ভয়েসমেইল';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'ফোন অনুমতি';

  @override
  String get phonePermissionDescription =>
      'ইনকামিং কল সনাক্তকরণ এবং ব্লক করার জন্য ব্যবহৃত হয়।';

  @override
  String get phoneRule => 'ফোন রুল';

  @override
  String get phoneRuleEditDialog => 'ফোন রুল এডিট ডায়ালগ';

  @override
  String get phoneRuleManagement => 'ফোন রুল ব্যবস্থাপনা';

  @override
  String get phoneRuleSubscription => 'ফোন রুল সাবস্ক্রিপশন';

  @override
  String get phoneSubscription => 'ফোন সাবস্ক্রিপশন';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Whitelist এবং blacklist রুল স্বয়ংক্রিয়ভাবে আপডেট করতে URL এর মাধ্যমে ফোন রুল লিস্ট সাবস্ক্রাইব করুন। JSON ফরম্যাটের রুল ফাইল সমর্থন করে।';

  @override
  String get phoneSubscriptionTitle => 'ফোন রুল সাবস্ক্রিপশন';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'অনুগ্রহ করে একটি লেবেল নির্বাচন করুন এবং একটি বৈধ ফোন নম্বর লিখুন';

  @override
  String pluginAddedSuccess(Object name) {
    return 'প্লাগইন \"$name\" সফলভাবে যোগ করা হয়েছে';
  }

  @override
  String get pluginDeleted => 'প্লাগইন মুছে ফেলা হয়েছে';

  @override
  String get pluginLatestVersion => 'প্লাগইন ইতিমধ্যেই সর্বশেষ সংস্করণে আছে';

  @override
  String get pluginListExportSuccess =>
      'প্লাগইন তালিকা সফলভাবে এক্সপোর্ট করা হয়েছে';

  @override
  String get pluginLoadedSuccessfully => 'প্লাগইন সফলভাবে লোড হয়েছে';

  @override
  String get pluginManagement => 'প্লাগইন ব্যবস্থাপনা';

  @override
  String get pluginManagementSubtitle =>
      'তৃতীয় পক্ষের প্লাগইনগুলি পরিচালনা এবং কনফিগার করুন';

  @override
  String get pluginManagementTitle => 'প্লাগইন ব্যবস্থাপনা';

  @override
  String get pluginName => 'প্লাগইনের নাম';

  @override
  String get pluginNotLoaded =>
      'প্লাগইন এখনো লোড হয়নি। অনুগ্রহ করে প্রথমে প্লাগইন লোড করুন।';

  @override
  String pluginsDeleted(Object count) {
    return '$count প্লাগইন সফলভাবে মুছে ফেলা হয়েছে।';
  }

  @override
  String get pluginService => 'প্লাগইন সার্ভিস';

  @override
  String get pluginTestPageTitle => 'প্লাগইন টেস্ট';

  @override
  String get pluginUpdateSuccess => 'প্লাগইন সফলভাবে আপডেট করা হয়েছে';

  @override
  String get pluginUrl => 'প্লাগইন URL';

  @override
  String get pluginUrlCannotBeEmpty => 'প্লাগইন URL খালি রাখা যাবে না';

  @override
  String get pluginUrlHint => 'প্লাগইন URL লিখুন';

  @override
  String get pluginUrlLabel => 'প্লাগইন URL';

  @override
  String get pluginVersion => 'প্লাগইন সংস্করণ';

  @override
  String get political => 'রাজনৈতিক';

  @override
  String get powerfulSpamBlocking => 'শক্তিশালী স্প্যাম ব্লকিং';

  @override
  String get previousStep => 'পূর্ববর্তী';

  @override
  String get prioritizeRemoteAction => 'রিমোট অ্যাকশন সেটিংসকে অগ্রাধিকার দিন';

  @override
  String get prioritizeRemoteActionDescription =>
      'রিমোট ডাটাবেস থেকে অ্যাকশন সেটিংসকে অগ্রাধিকার দিন';

  @override
  String get processing => 'প্রক্রিয়াকরণ হচ্ছে...';

  @override
  String get processingOperation => 'প্রক্রিয়াকরণ হচ্ছে...';

  @override
  String get purchase => 'কিনুন';

  @override
  String get quarterlyMembership => 'ত্রৈমাসিক সদস্যপদ';

  @override
  String get quarterlyMembershipDescription =>
      'সমস্ত প্রিমিয়াম বৈশিষ্ট্য আনলক করুন, ত্রৈমাসিকভাবে স্বয়ংক্রিয়ভাবে নবায়ন করুন';

  @override
  String get queryButton => 'অনুসন্ধান';

  @override
  String get queryFailed => 'অনুসন্ধান ব্যর্থ হয়েছে';

  @override
  String get queryFailedLog => 'অনুসন্ধান ব্যর্থ হয়েছে';

  @override
  String get querying => 'অনুসন্ধান করা হচ্ছে...';

  @override
  String get queryingPhoneNumber => 'ফোন নম্বর অনুসন্ধান করা হচ্ছে';

  @override
  String get queryResultTitle => 'অনুসন্ধানের ফলাফল';

  @override
  String get ready => 'প্রস্তুত!';

  @override
  String get receiveWeeklyStatistics => 'সাপ্তাহিক পরিসংখ্যান গ্রহণ করুন';

  @override
  String get recruiter => 'নিয়োগকর্তা';

  @override
  String get reEnterPasswordHint => 'অনুগ্রহ করে পাসওয়ার্ড পুনরায় লিখুন';

  @override
  String get refresh => 'রিফ্রেশ';

  @override
  String get refreshPermissionStatus => 'অনুমতির স্থিতি রিফ্রেশ করুন';

  @override
  String get refreshTooltip => 'রিফ্রেশ';

  @override
  String regexError(Object error) {
    return 'Regex ত্রুটি: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex ত্রুটি: $error';
  }

  @override
  String get regexPattern => 'রেজেক্স প্যাটার্ন';

  @override
  String get regexPatternExplanation => 'রেজেক্স প্যাটার্নের ব্যাখ্যা';

  @override
  String get regexPatternExplanationButton => 'রেজেক্স প্যাটার্নের ব্যাখ্যা';

  @override
  String get regexPatternLabel => 'রেজেক্স প্যাটার্ন';

  @override
  String get regexPatternsExamples =>
      'প্যাটার্ন সংজ্ঞায়িত করতে স্ট্যান্ডার্ড রেজেক্স সিনট্যাক্স ব্যবহার করুন। উদাহরণ:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'ফোন নম্বর মেলানোর জন্য রেজেক্স প্যাটার্ন';

  @override
  String get regexRule => 'রেজেক্স নিয়ম';

  @override
  String regexRuleAddFailed(Object error) {
    return 'রেজেক্স নিয়ম যোগ করা যায়নি: $error';
  }

  @override
  String get regexRuleAddSuccess => 'রেজেক্স নিয়ম সফলভাবে যোগ করা হয়েছে';

  @override
  String get regexRuleManagement => 'রেজেক্স নিয়ম ব্যবস্থাপনা';

  @override
  String get regexRuleNamePatternRequired =>
      'নিয়মের নাম এবং রেজেক্স প্যাটার্ন খালি রাখা যাবে না';

  @override
  String get regexRules => 'রেজেক্স নিয়মাবলী';

  @override
  String get regexTesterTitle => 'রেজেক্স পরীক্ষক';

  @override
  String regexValidationFailed(Object error) {
    return 'রেজেক্স যাচাইকরণ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get regexValidationSuccess => 'রেজেক্স যাচাইকরণ সফল হয়েছে';

  @override
  String get region => 'অঞ্চল';

  @override
  String get registeredDevicesTitle => 'নিবন্ধিত ডিভাইস';

  @override
  String get rejectAllCalls => 'সমস্ত কল প্রত্যাখ্যান করুন';

  @override
  String get rejectAllCallsDescription =>
      'সক্ষম করা হলে, সমস্ত কল সর্বোচ্চ অগ্রাধিকার সহ প্রত্যাখ্যান করা হবে';

  @override
  String get rejectAllNumbers => 'সমস্ত নম্বর প্রত্যাখ্যান করুন';

  @override
  String get rejectAllNumbersDesc =>
      'সক্ষম করা হলে সমস্ত ইনকামিং কল প্রত্যাখ্যান করুন';

  @override
  String get rejectExceededNumbers =>
      'সীমা অতিক্রমকারী নম্বর প্রত্যাখ্যান করুন';

  @override
  String get rejectExceededNumbersDescription =>
      'স্বয়ংক্রিয়ভাবে সংখ্যার সীমা অতিক্রমকারী নম্বর প্রত্যাখ্যান করুন';

  @override
  String get remoteFilterSettings => 'দূরবর্তী ফিল্টার সেটিংস';

  @override
  String get remoteFilterSettingsPageTitle => 'দূরবর্তী নম্বর ফিল্টার সেটিংস';

  @override
  String get remoteNumberFilter => 'দূরবর্তী নম্বর ফিল্টার';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'এই ফিল্টারটি সর্বশেষ নম্বর তথ্যের জন্য একটি স্বাধীন দূরবর্তী ডেটাবেস ব্যবহার করে।';

  @override
  String get remoteNumberFilterDescription =>
      'দূরবর্তী ডেটাবেসের তথ্যের উপর ভিত্তি করে হয়রানির কলগুলি আটকান';

  @override
  String get remoteNumberFilterExplanationContent =>
      'দূরবর্তী নম্বর ফিল্টার সংখ্যার সংখ্যার উপর ভিত্তি করে একটি দূরবর্তী ডেটাবেস জিজ্ঞাসা করে স্প্যাম কল সনাক্ত করে এবং ব্লক করে।';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'দূরবর্তী নম্বর ফিল্টারের ব্যাখ্যা';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• সংখ্যার সীমা: নম্বরের পুনরাবৃত্তির ফ্রিকোয়েন্সির উপর ভিত্তি করে নির্ধারণ করুন';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• ফিল্টার অ্যাকশন: সীমা অতিক্রমকারী নম্বরগুলি কীভাবে পরিচালনা করবেন তা কনফিগার করুন';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• অগ্রাধিকার সেটিংস: দূরবর্তী অ্যাকশনের জন্য অগ্রাধিকার সেট করুন';

  @override
  String get remoteNumberFilterFeatures => 'বৈশিষ্ট্য:';

  @override
  String get remoteNumberFiltering => 'দূরবর্তী নম্বর ফিল্টারিং';

  @override
  String get remoteNumberFilteringExplanation =>
      '• দূরবর্তী নম্বর ফিল্টারিং: দূরবর্তী ডেটাবেসের তথ্যের উপর ভিত্তি করে ফিল্টারিং নিয়ম';

  @override
  String get remoteNumberFilterSubtitle =>
      'ক্লাউড ডেটাবেস এবং কমিউনিটি রিপোর্ট ব্যবহার করে স্প্যাম কল সনাক্ত করুন';

  @override
  String get removeAdsDescription =>
      'মসৃণ অভিজ্ঞতার জন্য অ্যাপের সমস্ত বিজ্ঞাপন স্থায়ীভাবে সরান';

  @override
  String get removeAdsTitle => 'বিজ্ঞাপন সরান';

  @override
  String get removedFromFavoriteContacts => 'প্রিয় পরিচিতি থেকে সরানো হয়েছে';

  @override
  String get removedFromFavorites => 'প্রিয় থেকে সরানো হয়েছে';

  @override
  String get removeFavorite => 'প্রিয় সরান';

  @override
  String get removeFromFavorites => 'প্রিয় থেকে সরান';

  @override
  String get renameButton => 'নাম পরিবর্তন';

  @override
  String get renameDeviceDialogTitle => 'ডিভাইসের নাম পরিবর্তন করুন';

  @override
  String get renameDeviceTitle => 'ডিভাইসের নাম পরিবর্তন করুন';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'এটি আপনার সমস্ত বর্তমান সেটিংস প্রতিস্থাপন করবে। আপনি কি নিশ্চিত যে আপনি চালিয়ে যেতে চান?';

  @override
  String get requestAllPermissions => 'সমস্ত অনুমতি অনুরোধ করুন';

  @override
  String get requestPermission => 'অনুমতি অনুরোধ করুন';

  @override
  String requestPermissionFailed(Object error) {
    return 'অনুমতি অনুরোধ ব্যর্থ হয়েছে: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count চিহ্ন';
  }

  @override
  String get reset => 'রিসেট';

  @override
  String get restore => 'পুনঃস্থাপন';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'ব্যাকআপ থেকে অ্যাপ্লিকেশন সেটিংস পুনরুদ্ধার করুন';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'ব্যাকআপ থেকে অ্যাপ্লিকেশন সেটিংস পুনরুদ্ধার করুন';

  @override
  String get restoreButton => 'পুনঃস্থাপন';

  @override
  String restoreFailedWithError(Object error) {
    return 'ক্লাউড থেকে পুনরুদ্ধার ব্যর্থ হয়েছে: $error';
  }

  @override
  String get restoreFromCloud => 'ক্লাউড থেকে পুনরুদ্ধার';

  @override
  String get restoreFromCloudDescription =>
      'ক্লাউড স্টোরেজ থেকে সেটিংস এবং নিয়ম পুনরুদ্ধার করুন';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'ক্লাউড থেকে পুনরুদ্ধার ব্যর্থ হয়েছে: $error';
  }

  @override
  String get restoreFromCloudLabel => 'ক্লাউড থেকে পুনরুদ্ধার';

  @override
  String get restoreFromCloudSuccess =>
      'ক্লাউড থেকে সফলভাবে পুনরুদ্ধার করা হয়েছে';

  @override
  String get restoreFromCloudTitle => 'ক্লাউড থেকে পুনরুদ্ধার';

  @override
  String get restoreFromLocal => 'লোকাল থেকে পুনরুদ্ধার';

  @override
  String get restorePurchases => 'কেনাকাটা পুনরুদ্ধার করুন';

  @override
  String get restoreSectionTitle => 'পুনঃস্থাপন';

  @override
  String get restoreSettings => 'সেটিংস পুনরুদ্ধার';

  @override
  String get restoreSettingsConfirmation =>
      'এটি আপনার সমস্ত বর্তমান সেটিংস প্রতিস্থাপন করবে। আপনি কি নিশ্চিত যে আপনি চালিয়ে যেতে চান?';

  @override
  String get restoreSettingsDialogTitle => 'সেটিংস পুনরুদ্ধার';

  @override
  String get restoreSettingsTitle => 'সেটিংস পুনরুদ্ধার';

  @override
  String get restoreSuccessFromLocal =>
      'লোকাল থেকে সফলভাবে পুনরুদ্ধার করা হয়েছে';

  @override
  String get restoreSuccessMessage =>
      'ক্লাউড থেকে সফলভাবে পুনরুদ্ধার করা হয়েছে';

  @override
  String get retry => 'পুনরায় চেষ্টা করুন';

  @override
  String get ridesharing => 'রাইডশেয়ারিং';

  @override
  String get risk => 'ঝুঁকি';

  @override
  String get robocall => 'রোবোকল';

  @override
  String get ruleAction => 'নিয়মের অ্যাকশন';

  @override
  String get ruleAddButton => 'নিয়ম যোগ করুন';

  @override
  String get ruleAddedSuccess => 'নিয়ম সফলভাবে যোগ করা হয়েছে';

  @override
  String ruleAddFailure(Object error) {
    return 'নিয়ম যোগ করা যায়নি: $error';
  }

  @override
  String get ruleAddSuccess => 'নিয়ম সফলভাবে যোগ করা হয়েছে';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'আপনি কি নিশ্চিত যে আপনি এই $ruleType মুছতে চান?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'নিয়ম মুছুন';

  @override
  String get ruleDeletedSuccess => 'নিয়ম সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get ruleDeletedSuccessfully => 'নিয়ম সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String ruleDeleteFailed(Object error) {
    return 'নিয়ম মুছতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'নিয়ম মুছতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get ruleDeleteSuccess => 'নিয়ম সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get ruleDisabledSuccessfully => 'নিয়ম সফলভাবে নিষ্ক্রিয় করা হয়েছে';

  @override
  String get ruleEnabledSuccessfully => 'নিয়ম সফলভাবে সক্রিয় করা হয়েছে';

  @override
  String ruleLoadFailed(Object error) {
    return 'নিয়ম লোড করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get ruleManagement => 'নিয়ম ব্যবস্থাপনা';

  @override
  String get ruleManagementTitle => 'নিয়ম ব্যবস্থাপনা';

  @override
  String get ruleName => 'নিয়মের নাম';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'নিয়মের নাম এবং কন্টেন্ট রেজেক্স খালি রাখা যাবে না';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'নিয়মের নাম এবং ফোন নম্বর খালি রাখা যাবে না';

  @override
  String get ruleNameHint => 'যেমন, পরিবার, বন্ধু, ইত্যাদি।';

  @override
  String get ruleNameLabel => 'নিয়মের নাম';

  @override
  String get ruleNamePatternRequired =>
      'দয়া করে নিয়মের নাম এবং প্যাটার্ন লিখুন';

  @override
  String get ruleNameRequired => 'নিয়মের নাম এবং ফোন নম্বর খালি রাখা যাবে না';

  @override
  String get ruleNotExist => 'রুলটি বিদ্যমান নেই বা মুছে ফেলা হয়েছে';

  @override
  String ruleNotFound(Object error) {
    return 'রুলটি খুঁজে পাওয়া যায়নি: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'রুল সফলভাবে সংরক্ষণ করা হয়েছে!';

  @override
  String get ruleSavedSuccessMessage => 'রুল সফলভাবে সংরক্ষণ করা হয়েছে!';

  @override
  String ruleSaveFailed(Object error) {
    return 'সংরক্ষণ ব্যর্থ হয়েছে: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'সংরক্ষণ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get ruleSaveSuccess => 'রুল সফলভাবে সংরক্ষণ করা হয়েছে!';

  @override
  String get rulesExportedSuccessfully => 'রুল সফলভাবে এক্সপোর্ট করা হয়েছে';

  @override
  String rulesExportedTo(Object path) {
    return 'রুল এখানে এক্সপোর্ট করা হয়েছে: $path';
  }

  @override
  String get rulesImported => 'রুল সফলভাবে ইম্পোর্ট করা হয়েছে';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count টি রুল সফলভাবে ইম্পোর্ট করা হয়েছে';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'রুল ইম্পোর্ট করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get ruleStatistics => 'রুল পরিসংখ্যান';

  @override
  String ruleStatusChanged(Object status) {
    return 'রুল সফলভাবে $status হয়েছে';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'অপারেশন ব্যর্থ হয়েছে: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'রুল সফলভাবে $status হয়েছে';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'রুল আপডেট করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get ruleUpdateSuccess => 'রুল সফলভাবে আপডেট করা হয়েছে';

  @override
  String get ruleVerification => 'রুল যাচাইকরণ';

  @override
  String get save => 'সংরক্ষণ করুন';

  @override
  String get saveButton => 'সংরক্ষণ করুন';

  @override
  String get saveButtonLabel => 'সংরক্ষণ';

  @override
  String get saveButtonText => 'সংরক্ষণ করুন';

  @override
  String saveFailed(Object error) {
    return 'সংরক্ষণ ব্যর্থ হয়েছে: $error';
  }

  @override
  String get saveFilter => 'ফিল্টার সংরক্ষণ করুন';

  @override
  String get saveSettings => 'সেটিংস সংরক্ষণ করুন';

  @override
  String saveSettingsFailed(Object error) {
    return 'সেটিংস সংরক্ষণ করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get scamsLikely => 'সম্ভবত স্ক্যাম';

  @override
  String get search => 'অনুসন্ধান';

  @override
  String get searchContacts => 'যোগাযোগ অনুসন্ধান করুন';

  @override
  String searchError(Object error) {
    return 'অনুসন্ধান ত্রুটি: $error';
  }

  @override
  String get searchFilters => 'অনুসন্ধান ফিল্টার';

  @override
  String get searchForContacts => 'যোগাযোগ খুঁজুন';

  @override
  String get searchHint => 'অনুসন্ধান...';

  @override
  String get searchSettingsSubtitle =>
      'যোগাযোগ, লেবেল, ব্ল্যাকলিস্ট, হোয়াইটলিস্ট ইত্যাদি অনুসন্ধান করুন।';

  @override
  String get searchSettingsTitle => 'অনুসন্ধান সেটিংস';

  @override
  String get securityMessage =>
      'কোন ফোন কলে বিশ্বাস করবেন না। সর্বদা গ্রাহক পরিষেবা নম্বর স্বাধীনভাবে যাচাই করুন। পাসওয়ার্ড, যাচাইকরণ কোড, কার্ড নম্বর বা ব্যক্তিগত তথ্য কখনই শেয়ার করবেন না।';

  @override
  String get selectActionToPerform =>
      'রুল মিলে গেলে কোন কাজটি করতে হবে তা নির্বাচন করুন';

  @override
  String get selectActionWhenBlockingCalls =>
      'কল ব্লক করার সময় অ্যাকশন নির্বাচন করুন';

  @override
  String get selectActionWhenRuleMatches => 'রুল মিললে অ্যাকশন নির্বাচন করুন';

  @override
  String get selectAll => 'সব নির্বাচন করুন';

  @override
  String get selectCountry => 'দেশ নির্বাচন করুন';

  @override
  String get selectDateRange => 'তারিখ সীমা নির্বাচন করুন';

  @override
  String get selectedDateRange => 'নির্বাচিত তারিখ সীমা';

  @override
  String selectedItems(Object count) {
    return '$count টি আইটেম নির্বাচিত';
  }

  @override
  String get selectedLabel => 'নির্বাচিত:';

  @override
  String get selectExportFormat => 'এক্সপোর্ট ফরম্যাট নির্বাচন করুন';

  @override
  String get selectLabel => 'লেবেল নির্বাচন করুন';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'অনুগ্রহ করে একটি লেবেল নির্বাচন করুন এবং একটি বৈধ ফোন নম্বর লিখুন';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get selectMultiple => 'একাধিক নির্বাচন করুন';

  @override
  String get selectPeriod => 'সময়কাল নির্বাচন করুন';

  @override
  String get selectSimCard => 'সিম কার্ড নির্বাচন করুন';

  @override
  String get selectSimSlot => 'সিম স্লট নির্বাচন করুন';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'ব্লক করা কলের জন্য নির্দিষ্ট অ্যাকশন নির্বাচন করুন';

  @override
  String get selectTag => 'ট্যাগ নির্বাচন করুন';

  @override
  String get selectTags => 'ট্যাগ নির্বাচন করুন';

  @override
  String get selectTrustedDataSource =>
      'অনুগ্রহ করে বিশ্বস্ত ডেটা উৎস নির্বাচন করুন';

  @override
  String get selectYourLanguage => 'আপনার ভাষা নির্বাচন করুন';

  @override
  String get sender => 'প্রেরক';

  @override
  String get senderRegexOptional => 'প্রেরক রেজেক্স (ঐচ্ছিক)';

  @override
  String get serverAddressLabel => 'সার্ভার ঠিকানা';

  @override
  String get serviceTypeContact => 'যোগাযোগ সাবস্ক্রিপশন';

  @override
  String get serviceTypeLabel => 'পরিষেবার ধরন';

  @override
  String get serviceTypePhone => 'ফোন সাবস্ক্রিপশন';

  @override
  String get serviceTypePlugin => 'প্লাগইন আপডেট';

  @override
  String get serviceTypeSms => 'এসএমএস সাবস্ক্রিপশন';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'সেট';

  @override
  String get setEncryptionPassword => 'এনক্রিপশন পাসওয়ার্ড সেট করুন';

  @override
  String get setEncryptionPasswordDescription =>
      'ব্যাকআপ এবং পুনরুদ্ধারের জন্য এনক্রিপশন পাসওয়ার্ড সেট করুন';

  @override
  String get setEncryptionPasswordLabel => 'এনক্রিপশন পাসওয়ার্ড সেট করুন';

  @override
  String get setEncryptionPasswordTitle => 'এনক্রিপশন পাসওয়ার্ড সেট করুন';

  @override
  String get setPasswordButton => 'সেট';

  @override
  String get settings => 'সেটিংস';

  @override
  String settingsBackedUpTo(Object path) {
    return 'সেটিংস এখানে ব্যাকআপ করা হয়েছে: $path';
  }

  @override
  String get settingsLoaded => 'সেটিংস লোড হয়েছে';

  @override
  String settingsLoadFailed(Object error) {
    return 'সেটিংস লোড করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'সেটিংস সফলভাবে পুনরুদ্ধার করা হয়েছে। পরিবর্তনগুলি কার্যকর করার জন্য অনুগ্রহ করে অ্যাপটি পুনরায় চালু করুন।';

  @override
  String get settingsSaved => 'সেটিংস সংরক্ষিত';

  @override
  String settingsSaveFailed(Object error) {
    return 'সেটিংস সংরক্ষণ করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get settingsTab => 'সেটিংস';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get setup => 'সেটআপ';

  @override
  String get showContactEditDialogStaticMethod =>
      'যোগাযোগ সম্পাদনা ডায়ালগ দেখানোর স্ট্যাটিক পদ্ধতি';

  @override
  String get showExplanation => 'ব্যাখ্যা দেখান';

  @override
  String get silence => 'নীরব';

  @override
  String get silenceAndNoAnswer => 'নীরব এবং কোন উত্তর নেই';

  @override
  String get silenceNoAnswer => 'নীরব কোন উত্তর নেই';

  @override
  String get silentCallVoiceClone => 'নীরব কল ভয়েস ক্লোন';

  @override
  String get silentRules => 'নীরব নিয়ম';

  @override
  String simCard(Object simNumber) {
    return 'সিম কার্ড $simNumber';
  }

  @override
  String get simCardColor => 'সিম কার্ডের রং';

  @override
  String get simCardConfigurationExplanation =>
      '• সিম কার্ড কনফিগারেশন: প্রতিটি সিম কার্ডের জন্য স্বাধীন ফিল্টারিং নিয়ম সেট করুন';

  @override
  String get simCardFilterRules => 'সিম কার্ড ফিল্টার নিয়ম';

  @override
  String get simCardFilterRulesDescription =>
      'সিম কার্ড স্লটের উপর ভিত্তি করে বিভিন্ন ফিল্টারিং নিয়ম সেট করুন';

  @override
  String get simCardFontSize => 'সিম কার্ডের ফন্ট সাইজ';

  @override
  String get simCardPosition => 'সিম কার্ডের অবস্থান';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'সিম $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'সিম কার্ড তথ্য লোড করতে ব্যর্থ হয়েছে: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM স্লট নিয়মাবলী আপনাকে প্রতিটি SIM স্লটের জন্য স্বাধীন ফিল্টারিং নিয়ম কনফিগার করার অনুমতি দেয়।';

  @override
  String get simRuleInstructionsTitle => 'SIM স্লট নিয়মাবলী';

  @override
  String get simRuleManagement => 'SIM স্লট নিয়ম ব্যবস্থাপনা';

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
    return 'SIM ডেটা লোড করতে ব্যর্থ: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM স্লট ফিল্টার কনফিগারেশন';

  @override
  String get simSlotFilterConfigurationDescription =>
      'SIM স্লট অনুযায়ী ফিল্টার নিয়ম সেট করার অনুমতি';

  @override
  String get simSlotFilterDescription =>
      'প্রতিটি সিম কার্ডের জন্য স্বাধীন ফিল্টারিং নিয়ম কনফিগার করুন:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM স্লট $slotNumber ফিল্টার সেটিংস';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM স্লট লোড করতে ব্যর্থ: $error';
  }

  @override
  String get simSlotManagement => 'SIM স্লট ব্যবস্থাপনা';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM স্লট অপারেশন ব্যর্থ: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM স্লট অবস্থান $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM স্লট নিয়মাবলী: প্রতি SIM-এর জন্য স্বাধীন ফিল্টারিং কৌশল';

  @override
  String get simSlotRuleListTitle => 'SIM স্লট নিয়মাবলী তালিকা';

  @override
  String get simSlotRuleManagement => 'SIM স্লট নিয়মাবলী';

  @override
  String get simSlotRuleManagementTitle => 'নিয়ম ব্যবস্থাপনা';

  @override
  String get simSlotSettings => 'SIM স্লট সেটিংস';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM স্লট $slotNumber';
  }

  @override
  String get skip => 'এড়িয়ে যান';

  @override
  String get smartCallerId => 'স্মার্ট কলার আইডি শনাক্তকরণ';

  @override
  String get sms => 'এসএমএস';

  @override
  String get smsFilterDescription =>
      'এসএমএস ফিল্টারিং আপনাকে স্বয়ংক্রিয়ভাবে স্প্যাম বার্তা ফিল্টার করতে এবং আপনার বার্তা তালিকা পরিষ্কার রাখতে সহায়তা করে। আপনি ফিল্টার নিয়ম এবং বিজ্ঞপ্তি পদ্ধতি সেট করতে পারেন।';

  @override
  String get smsFilterDisabled => 'এসএমএস ফিল্টারিং নিষ্ক্রিয়';

  @override
  String get smsFilterEnabled => 'এসএমএস ফিল্টারিং সক্রিয়';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'এসএমএস ফিল্টার নিয়ম সফলভাবে যোগ করা হয়েছে';

  @override
  String get smsFilterRules => 'এসএমএস ফিল্টার নিয়মাবলী';

  @override
  String get smsFilterSettings => 'এসএমএস ফিল্টার সেটিংস';

  @override
  String get smsHistory => 'এসএমএস ইতিহাস';

  @override
  String get smsManagement => 'এসএমএস ব্যবস্থাপনা';

  @override
  String get smsPermission => 'এসএমএস অনুমতি';

  @override
  String get smsPermissionDescription =>
      'স্প্যাম বার্তা ফিল্টার করতে ব্যবহৃত হয়।';

  @override
  String get smsRuleAddedSuccessfully => 'এসএমএস নিয়ম সফলভাবে যোগ করা হয়েছে';

  @override
  String get smsRuleDeletedSuccessfully =>
      'এসএমএস নিয়ম সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'এসএমএস নিয়ম লোড করতে ব্যর্থ: $error';
  }

  @override
  String get smsRuleManagement => 'এসএমএস নিয়ম ব্যবস্থাপনা';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'এসএমএস নিয়মাবলী সফলভাবে $filePath এ এক্সপোর্ট করা হয়েছে';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'এসএমএস নিয়মাবলী সফলভাবে ইম্পোর্ট করা হয়েছে';

  @override
  String get smsRuleSubscription => 'এসএমএস নিয়ম সাবস্ক্রিপশন';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'এসএমএস নিয়ম সফলভাবে আপডেট করা হয়েছে';

  @override
  String get smsSettingsSubtitle => 'এসএমএস ফিল্টারিং এবং কীওয়ার্ড ব্লকিং';

  @override
  String get smsSettingsTitle => 'এসএমএস সেটিংস';

  @override
  String get smsSubscription => 'এসএমএস সাবস্ক্রিপশন';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'এসএমএস সাবস্ক্রিপশন সফলভাবে যোগ করা হয়েছে';

  @override
  String get smsSubscriptionRulesDescription =>
      'URL এর মাধ্যমে এসএমএস নিয়ম তালিকার সাবস্ক্রিপশন নিন, রেগুলার এক্সপ্রেশন ম্যাচিং সমর্থন করে। আপনি ব্লক বা অনুমতি অ্যাকশন সেট করতে পারেন।';

  @override
  String get smsTab => 'এসএমএস';

  @override
  String get somePermissionsDenied =>
      'কিছু অনুমতি অনুরোধ প্রত্যাখ্যান করা হয়েছে';

  @override
  String get spamLikely => 'স্প্যাম হওয়ার সম্ভাবনা';

  @override
  String get startColor => 'শুরুর রঙ';

  @override
  String get startDate => 'শুরুর তারিখ';

  @override
  String get startUsing => 'ব্যবহার শুরু করুন';

  @override
  String get statAnswered => 'উত্তর দেওয়া হয়েছে';

  @override
  String get statBlocked => 'ব্লক করা হয়েছে';

  @override
  String get staticMethodShowCallerIdDialog =>
      'কলার আইডি তথ্য ডায়ালগ দেখানোর জন্য স্ট্যাটিক পদ্ধতি';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'দেশ নির্বাচন ডায়ালগ প্রদর্শনের জন্য স্ট্যাটিক পদ্ধতি';

  @override
  String get staticMethodToDisplayDialog =>
      'ডায়ালগ প্রদর্শনের জন্য স্ট্যাটিক পদ্ধতি';

  @override
  String get statistics => 'পরিসংখ্যান';

  @override
  String get statisticsExportFeatureComingSoon =>
      'পরিসংখ্যান এক্সপোর্ট ফিচার শীঘ্রই আসছে';

  @override
  String get statisticsGrid => 'পরিসংখ্যান গ্রিড';

  @override
  String get statisticsPageTitle => 'ডেটা বিশ্লেষণ';

  @override
  String get stirColor => 'STIR রঙ';

  @override
  String get stirFontSize => 'STIR ফন্ট সাইজ';

  @override
  String get stirPosition => 'STIR অবস্থান';

  @override
  String get storagePermission => 'স্টোরেজ অনুমতি';

  @override
  String get storagePermissionDescription =>
      'সেটিংস এবং নিয়মাবলী সংরক্ষণ করতে ব্যবহৃত হয়।';

  @override
  String get subscribe => 'সাবস্ক্রাইব করুন';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'সাবস্ক্রিপশন \"$name\" সফলভাবে যোগ করা হয়েছে';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'আপনি কি নিশ্চিত যে আপনি এই সাবস্ক্রিপশনটি মুছতে চান?';

  @override
  String get subscriptionDeleteConfirmTitle => 'সাবস্ক্রিপশন মুছুন';

  @override
  String get subscriptionDeleted => 'সাবস্ক্রিপশন মুছে ফেলা হয়েছে';

  @override
  String get subscriptionDeletedSuccessfully =>
      'সাবস্ক্রিপশন সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'সাবস্ক্রিপশন মুছতে ব্যর্থ: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'সাবস্ক্রিপশন মুছে ফেলা হয়েছে';

  @override
  String get subscriptionEmptyState => 'কোন সাবস্ক্রিপশন উপলব্ধ নেই';

  @override
  String get subscriptionEmptyText => 'এখনও কোনো সাবস্ক্রিপশন নেই';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'সাবস্ক্রিপশন লোড করতে ব্যর্থ: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'সাবস্ক্রিপশন লোড করতে ব্যর্থ: $error';
  }

  @override
  String get subscriptionManagementTitle => 'সাবস্ক্রিপশন ব্যবস্থাপনা';

  @override
  String get subscriptionName => 'সাবস্ক্রিপশন নাম';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'সাবস্ক্রিপশন নাম এবং URL খালি রাখা যাবে না';

  @override
  String get subscriptionNameHint => 'সাবস্ক্রিপশন নাম লিখুন';

  @override
  String get subscriptionPageTitle => 'সাবস্ক্রিপশন ব্যবস্থাপনা';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'সাবস্ক্রিপশন স্ট্যাটাস পরিবর্তন করতে ব্যর্থ: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'সাবস্ক্রিপশন স্ট্যাটাস টগল করতে ব্যর্থ: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'সাবস্ক্রিপশন আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String get subscriptionUpdateSuccess =>
      'সাবস্ক্রিপশন সফলভাবে আপডেট করা হয়েছে';

  @override
  String get subscriptionUrl => 'সাবস্ক্রিপশন URL';

  @override
  String get subscriptionUrlHint => 'সাবস্ক্রিপশন URL লিখুন';

  @override
  String successfullyImportedRules(Object count) {
    return '$count টি নিয়মাবলী সফলভাবে ইম্পোর্ট করা হয়েছে';
  }

  @override
  String get supportSync => 'সিঙ্ক সাপোর্ট';

  @override
  String get survey => 'জরিপ';

  @override
  String get syncDevicesButton => 'ডিভাইস সিঙ্ক করুন';

  @override
  String get syncFailed => 'সিঙ্ক ব্যর্থ';

  @override
  String get syncFailedMessage => 'সিঙ্ক ব্যর্থ';

  @override
  String get syncFolderNameHint =>
      'অনুগ্রহ করে সিঙ্ক ফোল্ডারের নাম লিখুন (ডিফল্ট: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'সিঙ্ক ফোল্ডারের নাম';

  @override
  String get synchronized => 'সিঙ্ক্রোনাইজড';

  @override
  String get syncing => 'সিঙ্কিং...';

  @override
  String get syncNow => 'এখনই সিঙ্ক করুন';

  @override
  String get syncNowButton => 'এখন সিঙ্ক করুন';

  @override
  String get syncStatusTitle => 'সিঙ্ক স্ট্যাটাস';

  @override
  String get syncStatusUpdatedMessage => 'সিঙ্ক স্ট্যাটাস আপডেট করা হয়েছে';

  @override
  String get syncSuccessful => 'সিঙ্ক সফল';

  @override
  String get syncSuccessMessage => 'সিঙ্ক সফল';

  @override
  String get syncWithCloudStorage => 'ক্লাউড স্টোরেজের সাথে সিঙ্ক করুন';

  @override
  String get syncWithCloudStorageSubtitle => 'ক্লাউড স্টোরেজের সাথে সিঙ্ক করুন';

  @override
  String get systemFeatures => 'সিস্টেম বৈশিষ্ট্য:';

  @override
  String get systemSettingsTitle => 'সিস্টেম সেটিংস';

  @override
  String get tabAll => 'সব';

  @override
  String get tabAnswered => 'উত্তর দেওয়া';

  @override
  String get tabBlocked => 'ব্লক করা';

  @override
  String get tabMissed => 'মিসড';

  @override
  String get tabOutgoing => 'আউটগোয়িং';

  @override
  String tagLabel(String tag) {
    return 'ট্যাগ: $tag';
  }

  @override
  String get tagsUpdated => 'ট্যাগ আপডেট করা হয়েছে';

  @override
  String get takeaway => 'টেকঅ্যাওয়ে';

  @override
  String get telecommunication => 'টেলিকমিউনিকেশন';

  @override
  String get telegram => 'টেলিগ্রাম';

  @override
  String get telemarketing => 'টেলিমার্কেটিং';

  @override
  String get testButton => 'পরীক্ষা';

  @override
  String get testButtonLabel => 'পরীক্ষা';

  @override
  String get testConnectionButton => 'সংযোগ পরীক্ষা করুন';

  @override
  String get textColorsSetting => 'টেক্সট এবং লেবেলের রং';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'এই অ্যাপটি একটি শক্তিশালী কলার আইডি টুল যা আপনাকে অবাঞ্ছিত কল শনাক্ত এবং ব্লক করতে দেয়।';

  @override
  String get thisWeek => 'এই সপ্তাহে';

  @override
  String get timeInterceptor => 'সময় ইন্টারসেপ্টর';

  @override
  String get timeInterceptorDescription =>
      'কল ফ্রিকোয়েন্সির উপর ভিত্তি করে স্বয়ংক্রিয়ভাবে সম্ভাব্য কলগুলি ইন্টারসেপ্ট/অনুমতি দিন';

  @override
  String get timeInterceptorExplanation =>
      '• সময় ইন্টারসেপ্টর: অল্প সময়ের মধ্যে পুনরাবৃত্ত কলগুলি ইন্টারসেপ্ট/অনুমতি দিন';

  @override
  String get timeInterceptorExplanationContent =>
      'কল ফ্রিকোয়েন্সি ইন্টারসেপশন বৈশিষ্ট্যটি স্বয়ংক্রিয়ভাবে ঘন ঘন স্প্যাম কলগুলি শনাক্ত এবং ইন্টারসেপ্ট/অনুমতি দেওয়ার জন্য কল ফ্রিকোয়েন্সি বিশ্লেষণ করে।';

  @override
  String get timeInterceptorExplanationTitle =>
      'কল ফ্রিকোয়েন্সি ইন্টারসেপশন ব্যাখ্যা';

  @override
  String get timeInterceptorSettingsTitle =>
      'কল ফ্রিকোয়েন্সি ইন্টারসেপশন সেটিংস';

  @override
  String get timeInterceptorSubtitle =>
      'কল ফ্রিকোয়েন্সির উপর ভিত্তি করে সম্ভাব্য স্প্যাম কলগুলি স্বয়ংক্রিয়ভাবে ইন্টারসেপ্ট করুন';

  @override
  String get timeInterceptorTitle => 'কল ফ্রিকোয়েন্সি ইন্টারসেপশন সক্ষম করুন';

  @override
  String get timeWindowDescription =>
      'পুনরাবৃত্ত কলগুলি অনুমোদনের জন্য সময় উইন্ডোর আকার সেট করুন। এই উইন্ডোর মধ্যে একই নম্বর থেকে আসা কলগুলি অনুমোদিত হবে';

  @override
  String timeWindowLabel(int minutes) {
    return 'ইন্টারসেপশন টাইম উইন্ডো (মিনিট): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'পুনরাবৃত্ত কলগুলি অনুমোদনের জন্য সময় উইন্ডোর আকার সেট করুন। এই উইন্ডোর মধ্যে একই নম্বর থেকে আসা কলগুলি অনুমোদিত হবে';

  @override
  String get today => 'আজ';

  @override
  String get total => 'মোট';

  @override
  String get totalBlocked => 'মোট ব্লক করা';

  @override
  String get totalFiltered => 'মোট ফিল্টার করা';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'ডিভাইস বা প্ল্যাটফর্মের মধ্যে ডেটা স্থানান্তর করুন';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'ডিভাইস বা প্ল্যাটফর্মের মধ্যে ডেটা স্থানান্তর করুন';

  @override
  String get travelTicketing => 'ভ্রমণ টিকিট';

  @override
  String get trend => 'প্রবণতা';

  @override
  String get trendChart => 'প্রবণতা চার্ট';

  @override
  String get tutorial => 'টিউটোরিয়াল';

  @override
  String get type => 'প্রকার';

  @override
  String get unassignedSIMCard => 'অ্যাসাইন করা হয়নি সিম কার্ড';

  @override
  String get unknown => 'অজানা';

  @override
  String get unknownLabel => 'অজানা লেবেল';

  @override
  String get unknownTag => 'ট্যাগ: অজানা';

  @override
  String get unregisterButton => 'নিবন্ধন বাতিল';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'আপনি কি নিশ্চিত যে আপনি $deviceName ডিভাইসটি নিবন্ধন বাতিল করতে চান?';
  }

  @override
  String get unregisterDeviceTitle => 'ডিভাইস নিবন্ধন বাতিল করুন';

  @override
  String get unsupportedFileFormat => 'অসমর্থিত ফাইল ফরম্যাট';

  @override
  String get update => 'আপডেট';

  @override
  String get updateAllNow => 'এখনই সব আপডেট করুন';

  @override
  String get updateCallFilterConfig => 'কল ফিল্টার কনফিগারেশন আপডেট করুন';

  @override
  String updateContactFailed(Object error) {
    return 'যোগাযোগ আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String get updateFavoriteStatus => 'প্রিয় স্ট্যাটাস আপডেট করুন';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'প্রিয় স্ট্যাটাস আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String get updateInterval => 'আপডেট ব্যবধান';

  @override
  String get updateLabelFailed => 'লেবেল আপডেট করতে ব্যর্থ';

  @override
  String get updateNow => 'এখনই আপডেট করুন';

  @override
  String get updatePlugin => 'প্লাগইন আপডেট করুন';

  @override
  String updatePluginFailed(Object error) {
    return 'প্লাগইন আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'নিয়ম আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'সাবস্ক্রিপশন আপডেট করতে ব্যর্থ: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service সফলভাবে আপডেট হয়েছে ($count নিয়ম)';
  }

  @override
  String get updateTags => 'ট্যাগ আপডেট করুন';

  @override
  String get useCasesPoint1 => '• অটো-রিডায়াল স্প্যাম কল শনাক্ত করুন';

  @override
  String get useCasesPoint2 =>
      '• অল্প সময়ের মধ্যে একাধিকবার কল করা বিপণন কলগুলি ইন্টারসেপ্ট করুন';

  @override
  String get useCasesPoint3 => '• ফোন বোমাবাজি এবং হয়রানি প্রতিরোধ করুন';

  @override
  String get useCasesTitle => 'ব্যবহারের ক্ষেত্র:';

  @override
  String get useGlobalSettings => 'গ্লোবাল সেটিংস ব্যবহার করুন';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'ব্যবহারকারীর নাম';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'প্যাটার্ন সংজ্ঞায়িত করতে স্ট্যান্ডার্ড রেজেক্স সিনট্যাক্স ব্যবহার করুন। উদাহরণ:';

  @override
  String get validateRegex => 'রেজেক্স যাচাই করুন';

  @override
  String get verificationFailedText => 'ব্যর্থ';

  @override
  String get verifiedText => 'যাচাই করা';

  @override
  String get verify => 'যাচাই করুন';

  @override
  String version(Object version) {
    return 'সংস্করণ: $version';
  }

  @override
  String get vipExchangeDescription =>
      'ফোন নম্বর মার্কিং কাউন্টগুলির সাথে ভিআইপি সদস্যতা বিনিময় করুন';

  @override
  String get vipExchangeTitle => 'মার্ক এক্সচেঞ্জ ভিআইপি';

  @override
  String get watchAd => 'বিজ্ঞাপন দেখুন';

  @override
  String get watchAdForTemp => 'অস্থায়ী সুযোগ-সুবিধা পেতে বিজ্ঞাপন দেখুন';

  @override
  String get watchAdForTempDescription =>
      'কিছু প্রিমিয়াম ফিচার সাময়িকভাবে আনলক করতে একটি ছোট বিজ্ঞাপন দেখুন';

  @override
  String get webDAVConfigTitle => 'WebDAV কনফিগারেশন';

  @override
  String get webdavConfigurationTitle => 'WebDAV কনফিগারেশন';

  @override
  String get webdavPasswordHint => 'অনুগ্রহ করে WebDAV পাসওয়ার্ড লিখুন';

  @override
  String get webdavServerAddressHint =>
      'অনুগ্রহ করে WebDAV সার্ভার ঠিকানা লিখুন';

  @override
  String get webdavUsernameHint => 'অনুগ্রহ করে WebDAV ব্যবহারকারীর নাম লিখুন';

  @override
  String get week => 'সপ্তাহ';

  @override
  String get weekly => 'সাপ্তাহিক';

  @override
  String get weeklyBlockedCallsSummary => 'সাপ্তাহিক ব্লক করা কলগুলির সারাংশ';

  @override
  String get weeklyChartTitle => 'সাপ্তাহিক ব্লক করা কল';

  @override
  String get weeklyReport => 'সাপ্তাহিক প্রতিবেদন';

  @override
  String get weeklyReportDesc =>
      'কল ব্লকিং কার্যকলাপের সাপ্তাহিক সারাংশ প্রতিবেদন পান';

  @override
  String get welcome => 'স্বাগতম';

  @override
  String get whitelist => 'হোয়াইটলিস্ট';

  @override
  String get whitelistLabel => 'হোয়াইটলিস্ট';

  @override
  String get width => 'প্রস্থ';

  @override
  String get wildcardMatchingDescription =>
      'যেকোনো অক্ষর মেলাতে \'.\' ব্যবহার করুন (যেমন \'123.456\' 123-456 এর সাথে মিলবে)';

  @override
  String get wildcardMatchingTitle => 'ওয়াইল্ডকার্ড ম্যাচিং:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'নমনীয় ফিল্টারিংয়ের জন্য ওয়াইল্ডকার্ড সাপোর্ট';

  @override
  String get windowSizeSetting => 'উইন্ডো সাইজ';

  @override
  String get year => 'বছর';

  @override
  String get yearly => 'বার্ষিক';

  @override
  String get yearlyChartTitle => 'বার্ষিক ব্লক করা কল';

  @override
  String get noSimCardsDetected => 'কোন সিম কার্ড সনাক্ত করা হয়নি';

  @override
  String get filterManagementDescription => 'কল ফিল্টার সেট করুন';

  @override
  String get callerIdCustomizationSubtitle => 'কলার আইডি লেআউট কাস্টমাইজ করুন';

  @override
  String get fraudAlerSettingTitle => 'প্রতারণা সতর্কতার সেটিংস';

  @override
  String get fraudAlerSettingSubtitle => 'প্রতারণা সতর্কতা সেট করতে';

  @override
  String get enableFraudAlert => 'প্রতারণা সতর্কতা সক্ষম করুন';

  @override
  String get enableFraudAlertDescription =>
      'সন্দেহজনক স্ক্যাম কলের জন্য সতর্কতা';

  @override
  String get enableVibration => 'ভাইব্রেশন চালু করুন';

  @override
  String get enableVibrationDescription =>
      'কলটি সন্দেহজনক স্ক্যাম কল হলে ভাইব্রেট করুন';

  @override
  String get notificationSettingsTitle => 'বিজ্ঞপ্তি সেটিংস';

  @override
  String get useLocalNotification => 'লোকাল নোটিফিকেশন ব্যবহার করুন';

  @override
  String get useLocalNotificationDescription =>
      'ইনকামিং কলের জন্য লোকাল নোটিফিকেশন চালু করুন';

  @override
  String get cancelLocalNotification => 'লোকাল নোটিফিকেশন বন্ধ করুন';

  @override
  String get useStirNotification => 'STIR থেকে নোটিফিকেশন ব্যবহার করুন';

  @override
  String get useStirNotificationDescription =>
      'ইনকামিং কলের জন্য STIR নোটিফিকেশন চালু করুন';

  @override
  String get cancelLocalNotificationDescription =>
      'লোকাল নোটিফিকেশন স্বয়ংক্রিয়ভাবে বন্ধ করুন';

  @override
  String get callerIdSettingsTitle => 'কলার আইডি সেটিংস';

  @override
  String get callerIdSettingsSubtitle =>
      'ইনকামিং কল নোটিফিকেশন এবং ডিসপ্লে মোড সেট আপ করতে';

  @override
  String get purchaseTitle => 'ক্রয়';

  @override
  String get purchaseSubtitle => 'পরিষেবা কেনার জন্য';

  @override
  String get callerIdNotificationTitle => 'ইনকামিং কলের তথ্য';

  @override
  String callerIdBody(String phoneNumber) {
    return 'নম্বর: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'ব্লক করা কল';

  @override
  String blockedCallBody(String phoneNumber) {
    return '$phoneNumber থেকে ব্লক করা কল';
  }

  @override
  String get stirVerified => 'যাচাইকৃত';

  @override
  String get stirNotVerified => 'যাচাই করা হয়নি';

  @override
  String get stirFailed => 'যাচাইকরণ ব্যর্থ';

  @override
  String get stirUnknown => 'অজানা যাচাইকরণের অবস্থা';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN যাচাইকরণ';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$phoneNumber নম্বরের জন্য $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'স্ক্রলিং সুরক্ষা বার্তা সেটিংস';

  @override
  String get messageColor => 'বার্তার রঙ';

  @override
  String get messageFontSize => 'বার্তার ফন্ট সাইজ';

  @override
  String get messagePosition => 'বার্তার অবস্থান';

  @override
  String get containerWidth => 'কন্টেইনারের প্রস্থ';

  @override
  String get scrollSpeed => 'স্ক্রলের গতি';

  @override
  String get enableSecurityMessage => 'সুরক্ষা বার্তা সক্ষম করুন';

  @override
  String get fraudAlertTitle => 'প্রতারণা সতর্কতা';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '$phoneNumber থেকে সম্ভাব্য প্রতারণার কল';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'রুল লোড করতে ব্যর্থ: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'কল লগ লোড করতে ব্যর্থ: $error';
  }

  @override
  String get noBlockedTypeData => 'কোন ব্লক হওয়া প্রকারের ডেটা উপলব্ধ নেই';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeName আমদানি করুন';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName সফলভাবে আমদানি করা হয়েছে, মোট $count রেকর্ড আমদানি করা হয়েছে';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName আমদানি করতে ব্যর্থ: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeName রপ্তানি করুন';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName সফলভাবে রপ্তানি করা হয়েছে';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName রপ্তানি করতে ব্যর্থ: $error';
  }

  @override
  String get cloudSyncService => 'ক্লাউড সিঙ্ক পরিষেবা';

  @override
  String get membershipCenter => 'সদস্যপদ কেন্দ্র';

  @override
  String get redeemVipWithMarks => 'মার্ক সহ ভিআইপি রিডিম করুন';

  @override
  String get currentMarkCount => 'বর্তমান মার্ক সংখ্যা';

  @override
  String get markMoreNumbersForMore =>
      'আরও মার্কের জন্য আরও নম্বর চিহ্নিত করুন';

  @override
  String get noAds => 'কোন বিজ্ঞাপন নেই';

  @override
  String get cloudBackup => 'ক্লাউড ব্যাকআপ';

  @override
  String get callerIdEnhancement => 'কলার আইডি উন্নতি';

  @override
  String get voiceRecognition => 'কণ্ঠস্বর সনাক্তকরণ';

  @override
  String get feature => 'বৈশিষ্ট্য';

  @override
  String get normalUser => 'সাধারণ ব্যবহারকারী';

  @override
  String get vipUser => 'ভিআইপি ব্যবহারকারী';

  @override
  String get temporaryVip => 'অস্থায়ী ভিআইপি';

  @override
  String get removeAds => 'বিজ্ঞাপন সরান';

  @override
  String get unknownAction => 'অজানা কর্ম';

  @override
  String get settingsBackup => 'সেটিংস ব্যাকআপ ';

  @override
  String get allServicesStatusTitle => 'বর্তমান পরিষেবা স্থিতি';

  @override
  String get allServicesStatusSubtitle =>
      'প্রতিটি ক্লাউড পরিষেবার বর্তমান অবস্থা';

  @override
  String get redirect => 'পুনঃনির্দেশ';

  @override
  String get notify => 'বিজ্ঞপ্তি';

  @override
  String get log => 'লগ';

  @override
  String get custom => 'কাস্টম';

  @override
  String get allowActionDescription =>
      'কলগুলি ব্লক করা তালিকায় থাকা সত্ত্বেও অনুমতি দেওয়া হবে।';

  @override
  String get blockActionDescription =>
      'কলগুলি ব্লক করা হবে এবং কল লগে দেখানো হবে।';

  @override
  String get silenceActionDescription =>
      'কলগুলি সাইলেন্ট করা হবে কিন্তু কল লগে দেখানো হবে।';

  @override
  String get noneActionDescription =>
      'কলের জন্য কোন বিশেষ পদক্ষেপ নেওয়া হবে না।';

  @override
  String get redirectActionDescription =>
      'একটি নির্দিষ্ট নম্বরে কল পুনঃনির্দেশ করুন।';

  @override
  String get labelActionDescription =>
      'সহজে সনাক্তকরণের জন্য কলে একটি লেবেল যোগ করুন।';

  @override
  String get notifyActionDescription => 'কল আসলে একটি বিজ্ঞপ্তি পাঠান।';

  @override
  String get logActionDescription =>
      'অন্য কোনো পদক্ষেপ ছাড়াই কলের তথ্য লগ করুন।';

  @override
  String get customActionDescription => 'একটি কাস্টম অ্যাকশন সম্পাদন করুন।';

  @override
  String get synced => 'সিঙ্ক করা হয়েছে';

  @override
  String get needVipAccess =>
      'এই বৈশিষ্ট্যটি ব্যবহার করার জন্য আপনার ভিআইপি অ্যাক্সেস প্রয়োজন';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeName ডেটা আমদানি বা রপ্তানি করুন';
  }

  @override
  String get importExportTitle => 'আমদানি/রপ্তানি';

  @override
  String get noPhoneRules => 'কোন ফোন রুল পাওয়া যায়নি';

  @override
  String get noRegexRules => 'কোন রেজেক্স রুল পাওয়া যায়নি';

  @override
  String get noAllowedBlockedRules => 'কোন অনুমোদিত/ব্লক করা রুল পাওয়া যায়নি';

  @override
  String get importExport => 'আমদানি/রপ্তানি';

  @override
  String get filterByAction => 'অ্যাকশন দ্বারা ফিল্টার করুন';

  @override
  String get upgradeToVip => 'ভিআইপি-তে আপগ্রেড করুন';

  @override
  String get batteryOptimizationPermission => 'ব্যাটারি অপ্টিমাইজেশন';

  @override
  String get batteryOptimizationPermissionDescription =>
      'কলালার আইডি-এর মতো পরিষেবা সরবরাহ করার জন্য অ্যাপটিকে ব্যাকগ্রাউন্ডে চলার অনুমতি দিন।';

  @override
  String get permissionTitle => 'বিশেষ অনুমতি';

  @override
  String get permissionSubtitle =>
      'ওভারলে এবং ব্যাটারি অপ্টিমাইজেশন অনুমতিগুলি পরিচালনা করুন';

  @override
  String get themeSettingsTitle => 'থিম সেটিংস';

  @override
  String get themeSettingsSubtitle => 'আপনার প্রিয় থিম চয়ন করুন';

  @override
  String get databaseSyncTitle => 'ডাটাবেস সিঙ্ক';

  @override
  String get countrySyncSettingsTitle => 'দেশ ভিত্তিক ডাটাবেস সিঙ্ক সেটিংস';

  @override
  String get countrySyncSettingsSubtitle =>
      'ডেটা সিঙ্ক্রোনাইজেশনের জন্য দেশ নির্বাচন করুন';

  @override
  String get countryDataDisclaimer =>
      'অনুগ্রহ করে মনে রাখবেন: ডাটাবেসে সমস্ত নির্দিষ্ট দেশ বা অঞ্চলের ডেটা অন্তর্ভুক্ত নাও থাকতে পারে।';

  @override
  String get editSubscription => 'সাবস্ক্রিপশন সম্পাদনা করুন';

  @override
  String get searchByNameOrPhoneNumber =>
      'নাম বা ফোন নম্বর দ্বারা অনুসন্ধান করুন';

  @override
  String get allowedBlockedRulesInfo =>
      'অনুমোদিত/ব্লক করা নিয়মগুলি নির্দিষ্ট ফোন নম্বরগুলির সাথে কলগুলি মেলানোর জন্য ব্যবহৃত হয়, যেগুলির সর্বোচ্চ অগ্রাধিকার রয়েছে।';

  @override
  String get searchPhoneRulesHint => 'ফোন নিয়ম অনুসন্ধান করুন';

  @override
  String get phoneRulesInfo =>
      'ফোন নিয়মগুলি নির্দিষ্ট ফোন নম্বরগুলির সাথে কলগুলি মেলানোর জন্য ব্যবহৃত হয়, যেগুলির অগ্রাধিকার কম। কিছু ফোন রুল সাবস্ক্রিপশন থেকে আসে';

  @override
  String get searchSubscriptionsHint => 'সাবস্ক্রিপশন অনুসন্ধান করুন';

  @override
  String get searchPluginsHint => 'প্লাগইন অনুসন্ধান করুন';

  @override
  String get searchLabelsHint => 'লেবেল অনুসন্ধান করুন';

  @override
  String get pluginDescription => 'প্লাগইন বর্ণনা';

  @override
  String get enterPluginDescription => 'প্লাগইনের বর্ণনা লিখুন';

  @override
  String get searchRegexRulesHint => 'রেজেক্স নিয়ম অনুসন্ধান করুন';

  @override
  String get regexRulesInfo =>
      'রেজেক্স নিয়মগুলি রেজেক্স প্যাটার্নের উপর ভিত্তি করে কল ফিল্টার করতে ব্যবহৃত হয়।';

  @override
  String get searchMarkedPhonesHint => 'চিহ্নিত ফোন অনুসন্ধান করুন';

  @override
  String get searchContactSubscriptionsHint =>
      'যোগাযোগের সাবস্ক্রিপশন অনুসন্ধান করুন';

  @override
  String get showAllContacts => 'সমস্ত পরিচিতি দেখান';

  @override
  String get showFavorites => 'প্রিয় দেখান';

  @override
  String get manualEntry => 'ম্যানুয়াল এন্ট্রি তথ্য';

  @override
  String get scriptSaved => 'স্ক্রিপ্ট সংরক্ষিত হয়েছে';

  @override
  String editScriptFor(String pluginName) {
    return '$pluginName-এর জন্য স্ক্রিপ্ট সম্পাদনা করুন';
  }

  @override
  String get saveScript => 'স্ক্রিপ্ট সংরক্ষণ করুন';

  @override
  String get testPlugin => 'প্লাগইন পরীক্ষা করুন';

  @override
  String get description => 'বর্ণনা';

  @override
  String get accessTargetUrl => 'টার্গেট URL অ্যাক্সেস করুন';

  @override
  String get result => 'ফলাফল';

  @override
  String get editScript => 'স্ক্রিপ্ট সম্পাদনা করুন';

  @override
  String get numberFormat => 'নম্বর বিন্যাস';

  @override
  String get nationalNumber => 'জাতীয় নম্বর';

  @override
  String get e164Number => 'E164 নম্বর';

  @override
  String get pluginRulesInfo =>
      'নিরাপত্তার জন্য, অনুগ্রহ করে শুধুমাত্র বিশ্বস্ত উৎস থেকে প্লাগইন ব্যবহার করুন। আপনার নিজস্ব কাস্টম প্লাগইন তৈরি করতে আমাদের টেমপ্লেটগুলি ব্যবহার করতে দ্বিধা বোধ করবেন না!';

  @override
  String get advancedMode => 'উন্নত মোড';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'অনুগ্রহ করে কমপক্ষে একটি নম্বর প্রবেশ করান।';

  @override
  String get openInWebView => 'WebView-এ খুলুন';

  @override
  String get pluginLabel => 'প্লাগইন লেবেল';

  @override
  String get pluginID => 'আইডি';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'বার্তার পটভূমির রঙ';

  @override
  String get clearAllCallLogs => 'সমস্ত কল লগ মুছুন';

  @override
  String get clearAllCallLogsConfirmation => 'সমস্ত কল লগ মুছতে নিশ্চিত করুন';

  @override
  String get allCallLogsCleared => 'সমস্ত কল লগ মুছে ফেলা হয়েছে';

  @override
  String get unblocked => 'আনব্লক করা হয়েছে';

  @override
  String get blockNumber => 'নম্বর ব্লক করুন';

  @override
  String get blockNumberSuccess => 'নম্বর ব্লক সফল';

  @override
  String get blockNumberFailed => 'নম্বর ব্লক ব্যর্থ';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'আপনি কি নিশ্চিত যে আপনি $phoneNumber আনব্লক করতে চান?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '$phoneNumber কল করা হচ্ছে...';
  }

  @override
  String get viewDetails => 'বিস্তারিত দেখুন';

  @override
  String get unblock => 'আনব্লক';

  @override
  String get unblockNumber => 'নম্বর আনব্লক করুন';

  @override
  String get unblockNumberSuccess => 'নম্বর সফলভাবে আনব্লক করা হয়েছে';

  @override
  String get unblockNumberFailed => 'নম্বর আনব্লক ব্যর্থ';

  @override
  String get serviceNotAvailable => 'পরিষেবা উপলব্ধ নয়';

  @override
  String get callingNumberFailed => 'কলিং নম্বর ব্যর্থ';

  @override
  String get listView => 'তালিকা ভিউ';

  @override
  String get timelineView => 'টাইমলাইন ভিউ';

  @override
  String get nameCannotBeEmpty => 'নাম খালি থাকতে পারে না';

  @override
  String get selectAction => 'অ্যাকশন নির্বাচন করুন';

  @override
  String get selectTargetService => 'টার্গেট পরিষেবা নির্বাচন করুন';

  @override
  String get callDetails => 'কলের বিবরণ';

  @override
  String get callType => 'কলের প্রকার';

  @override
  String get callTime => 'কলের সময়';

  @override
  String get numberInvalidFormat => 'নম্বর অবৈধ বিন্যাস';

  @override
  String get membershipFeature => 'সদস্যপদ বৈশিষ্ট্য';

  @override
  String get medium => 'মাধ্যম';

  @override
  String get verificationReport => 'যাচাইকরণ প্রতিবেদন';

  @override
  String get finalRisk => 'চূড়ান্ত ঝুঁকি';

  @override
  String get simState => 'SIM স্টেট';

  @override
  String get ipCountry => 'IP দেশ';

  @override
  String get simCountry => 'SIM দেশ';

  @override
  String get isRoaming => 'রোমিং';

  @override
  String get isNumberMatch => 'নম্বর ম্যাচ';

  @override
  String get support => 'সহায়তা';

  @override
  String get rewardedAdService => 'পুরস্কৃত বিজ্ঞাপন পরিষেবা';

  @override
  String get hasVipPrivilegeExceptAds =>
      'আপনার কাছে ইতিমধ্যেই VIP সুবিধা রয়েছে (বিজ্ঞাপন ব্যতীত)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'আপনার কাছে ইতিমধ্যেই অস্থায়ী সুবিধা রয়েছে, মেয়াদ শেষ হওয়ার তারিখ: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'অস্থায়ী VIP সুবিধা পেতে আপনাকে আরও $count টি বিজ্ঞাপন দেখতে হবে';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'আপনাকে $days দিনের অস্থায়ী ক্রয় সুবিধা প্রদান করা হয়েছে। মেয়াদ শেষ হওয়ার তারিখ: $expiryDate';
  }

  @override
  String get tempPurchaseExpired =>
      'অস্থায়ী ক্রয় সুবিধা মেয়াদ উত্তীর্ণ হয়েছে';

  @override
  String get loadingAd => 'বিজ্ঞাপন লোড হচ্ছে...';

  @override
  String get earnedTempVip => 'অস্থায়ী VIP অর্জন করেছেন';

  @override
  String get vipExchangeService => 'VIP এক্সচেঞ্জ পরিষেবা';

  @override
  String get marksInsufficient => 'বিনিময়ের জন্য পর্যাপ্ত মার্কস নেই';

  @override
  String get invalidExchangeRule => 'অবৈধ বিনিময় নিয়ম';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'সফলভাবে $description-এর জন্য বিনিময় করা হয়েছে, মেয়াদ শেষ হওয়ার তারিখ: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'বিনিময় ব্যর্থ: $error';
  }

  @override
  String get vip3DaysWithAds => '3 দিনের VIP বিজ্ঞাপন সহ (শুধুমাত্র সিঙ্ক)';

  @override
  String get vip5DaysNoAds => '5 দিনের পূর্ণ-বৈশিষ্ট্যযুক্ত বিজ্ঞাপন-মুক্ত VIP';

  @override
  String get vip7DaysNoAds => '7 দিনের পূর্ণ-বৈশিষ্ট্যযুক্ত বিজ্ঞাপন-মুক্ত VIP';

  @override
  String get noNotifications => 'কোন বিজ্ঞপ্তি নেই';

  @override
  String get clearAllNotifications => 'সমস্ত বিজ্ঞপ্তি মুছুন';

  @override
  String get clearAllNotificationsConfirmation =>
      'সমস্ত বিজ্ঞপ্তি মুছতে নিশ্চিত করুন';

  @override
  String get allNotificationsCleared => 'সমস্ত নোটিফিকেশন মুছে ফেলা হয়েছে';

  @override
  String get clearButton => 'মুছে ফেলুন';

  @override
  String get justNow => 'এখনই';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count মিনিট আগে',
      one: '১ মিনিট আগে',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ঘন্টা আগে',
      one: '১ ঘন্টা আগে',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count দিন আগে',
      one: '১ দিন আগে',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'গতকাল';

  @override
  String get deletionProposal => 'ডিলিট করার প্রস্তাব';

  @override
  String get deletionProposals => 'ডিলিট করার প্রস্তাবসমূহ';

  @override
  String get createProposal => 'প্রস্তাব তৈরি করুন';

  @override
  String get createProposalTitle => 'ডিলিট করার প্রস্তাব তৈরি করুন';

  @override
  String get reason => 'কারণ';

  @override
  String get reasonOutdated => 'পুরোনো নম্বর';

  @override
  String get reasonPrivacy => 'গোপনীয়তার উদ্বেগ';

  @override
  String get reasonNotInService => 'পরিষেবায় নেই';

  @override
  String get reasonWronglyIdentified => 'ভুলভাবে চিহ্নিত';

  @override
  String get reasonInaccurateInfo => 'ভুল তথ্য';

  @override
  String get reasonWrongMarked => 'ভুল চিহ্নিত';

  @override
  String get reasonOther => 'অন্যান্য';

  @override
  String get submit => 'জমা দিন';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get proposalStatus => 'অবস্থা';

  @override
  String get statusPending => 'মুলতবি';

  @override
  String get statusActive => 'সক্রিয়';

  @override
  String get statusCompleted => 'সম্পন্ন';

  @override
  String get statusExpired => 'মেয়াদ উত্তীর্ণ';

  @override
  String get riskLevel => 'ঝুঁকির স্তর';

  @override
  String get riskLevelVerified => 'যাচাইকৃত';

  @override
  String get riskLevelLow => 'কম';

  @override
  String get riskLevelHigh => 'উচ্চ';

  @override
  String get riskLevelUnknown => 'অজানা';

  @override
  String get votingProgress => 'ভোটাভুটির অগ্রগতি';

  @override
  String agreeVotes(int count) {
    return 'সম্মত: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'সম্মত নয়: $count';
  }

  @override
  String totalVotes(int count) {
    return 'মোট: $count';
  }

  @override
  String get voteAgree => 'সম্মত';

  @override
  String get voteDisagree => 'সম্মত নয়';

  @override
  String createdAt(String date) {
    return 'তৈরি: $date';
  }

  @override
  String get showReport => 'রিপোর্ট দেখান';

  @override
  String get hideReport => 'রিপোর্ট লুকান';

  @override
  String get proposalStatistics => 'প্রস্তাবের পরিসংখ্যান';

  @override
  String get totalProposals => 'মোট প্রস্তাব';

  @override
  String get activeProposals => 'সক্রিয় প্রস্তাব';

  @override
  String get completedProposals => 'সম্পন্ন প্রস্তাব';

  @override
  String get myVotes => 'আমার ভোট';

  @override
  String get proposalCreated => 'প্রস্তাব সফলভাবে তৈরি হয়েছে';

  @override
  String get proposalCreateFailed => 'প্রস্তাব তৈরি করা যায়নি';

  @override
  String get voteSubmitted => 'ভোট সফলভাবে জমা দেওয়া হয়েছে';

  @override
  String get voteSubmitFailed => 'ভোট জমা দেওয়া যায়নি';

  @override
  String get noProposalsFound => 'কোন প্রস্তাব পাওয়া যায়নি';

  @override
  String get loadingProposals => 'প্রস্তাব লোড হচ্ছে...';

  @override
  String get refreshProposals => 'প্রস্তাব রিফ্রেশ করুন';

  @override
  String get totalPendingProposals => 'মোট মুলতবি প্রস্তাব';

  @override
  String get highRisk => 'উচ্চ ঝুঁকি';

  @override
  String get mediumRisk => 'মাঝারি ঝুঁকি';

  @override
  String get lowRisk => 'কম ঝুঁকি';

  @override
  String get communityImpact => 'কমিউনিটির প্রভাব';

  @override
  String get criticalIssues => 'গুরুতর সমস্যা';

  @override
  String get communityParticipation => 'কমিউনিটির অংশগ্রহণ';

  @override
  String get noActivity => 'কোন কার্যকলাপ নেই';

  @override
  String get low => 'কম';

  @override
  String get moderate => 'মাঝারি';

  @override
  String get high => 'উচ্চ';

  @override
  String get veryHigh => 'খুব উচ্চ';

  @override
  String get voted => 'ভোট দিয়েছেন';

  @override
  String get communityVotes => 'কমিউনিটির ভোট';

  @override
  String get waitingForMoreVotes => 'আরও কমিউনিটির ভোটের অপেক্ষায়';

  @override
  String get proposalProcessed => 'এই প্রস্তাব প্রক্রিয়া করা হয়েছে';

  @override
  String get supported => 'সমর্থিত';

  @override
  String get opposed => 'বিরুদ্ধে';

  @override
  String get approved => 'অনুমোদিত';

  @override
  String get rejected => 'প্রত্যাখ্যাত';

  @override
  String get completed => 'সম্পন্ন';

  @override
  String get pending => 'মুলতবি';

  @override
  String get critical => 'গুরুতর';

  @override
  String get oppose => 'বিরোধিতা';

  @override
  String get veryLow => 'খুব কম';

  @override
  String get deletionProposalNotificationDescription =>
      'ডিলিট করার প্রস্তাবের ভোটিং ফলাফল এবং আপডেটের নোটিফিকেশন।';

  @override
  String get deletionProposalCreated => 'ডিলিট করার প্রস্তাব তৈরি হয়েছে';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '$phoneNumber এর জন্য আপনার ডিলিট করার প্রস্তাব কমিউনিটির পর্যালোচনার জন্য জমা দেওয়া হয়েছে।';
  }

  @override
  String get proposalApproved => 'প্রস্তাব অনুমোদিত ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber এর জন্য ডিলিট করার প্রস্তাবটি কমিউনিটি দ্বারা অনুমোদিত হয়েছে ($supportPercentage% সমর্থন, $totalVotes ভোট)।';
  }

  @override
  String get proposalRejected => 'প্রস্তাব প্রত্যাখ্যাত ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber এর জন্য ডিলিট করার প্রস্তাবটি কমিউনিটি দ্বারা প্রত্যাখ্যাত হয়েছে ($supportPercentage% সমর্থন, $totalVotes ভোট)।';
  }

  @override
  String get communityVotingStarted => 'কমিউনিটির ভোটাভুটি শুরু হয়েছে';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '$phoneNumber এর জন্য একটি নতুন ডিলিট করার প্রস্তাব কমিউনিটির ভোটাভুটির জন্য এখন উন্মুক্ত।';
  }

  @override
  String get votingCompleted => 'ভোটাভুটি সম্পন্ন';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '$phoneNumber এর জন্য কমিউনিটির ভোটাভুটি শেষ হয়েছে। ফলাফল: $result ($supportPercentage% সমর্থন)।';
  }

  @override
  String get newVoteReceived => 'নতুন ভোট পাওয়া গেছে';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'কেউ $phoneNumber ডিলিট করার পক্ষে/বিপক্ষে ভোট দিয়েছেন। বর্তমান ভোট: $totalVotes।';
  }

  @override
  String get loadVoteCountFailed => 'ভোট সংখ্যা লোড করা যায়নি';

  @override
  String get voteCount => 'ভোট সংখ্যা';

  @override
  String get deletionProposalInfo => 'ডিলিট করার প্রস্তাবের তথ্য';

  @override
  String get deletionProposalDescription =>
      'কমিউনিটির নির্দেশিকা লঙ্ঘন করে এমন নম্বরগুলি ডিলিট করার জন্য প্রস্তাব করুন। আপনার অংশগ্রহণ প্ল্যাটফর্মকে নিরাপদ রাখতে সাহায্য করে।';

  @override
  String get voteToEarnVip => 'VIP সুবিধা অর্জনের জন্য প্রস্তাবে ভোট দিন!';

  @override
  String get voteFailed => 'ভোট ব্যর্থ হয়েছে';

  @override
  String get searchProposals => 'প্রস্তাব অনুসন্ধান করুন';

  @override
  String get defaultNotifications => 'ডিফল্ট নোটিফিকেশন';

  @override
  String get defaultNotificationsDescription =>
      'অ্যাপের জন্য ডিফল্ট নোটিফিকেশন চ্যানেল।';

  @override
  String get blockedCallNotifications => 'ব্লক করা কলের নোটিফিকেশন';

  @override
  String get blockedCallNotificationsDescription =>
      'ব্লক করা কলগুলির তথ্য প্রদর্শন করে।';

  @override
  String get stirVerification => 'STIR/SHAKEN যাচাইকরণ';

  @override
  String get stirVerificationDescription =>
      'নম্বরগুলির জন্য STIR/SHAKEN যাচাইকরণের ফলাফল প্রদর্শন করে।';

  @override
  String get fraudAlerts => 'জালিয়াতি সতর্কতা';

  @override
  String get fraudAlertsDescription =>
      'সম্ভাব্য জালিয়াতি কলগুলির জন্য সতর্কতা প্রদর্শন করে।';

  @override
  String get notificationFrequencyDescription =>
      'আপনি নতুন ডিলিশন প্রস্তাবনা সম্পর্কে বিজ্ঞপ্তি কত ঘন ঘন পাবেন তা চয়ন করুন। আপনি সেগুলি অবিলম্বে, ব্যাচে বা একটি কাস্টম ব্যবধানে পেতে পারেন।';

  @override
  String get immediateNotifications => 'তাৎক্ষণিক';

  @override
  String get immediateNotificationsDescription =>
      'একটি প্রস্তাবনা তৈরি হওয়ার সাথে সাথেই একটি বিজ্ঞপ্তি পান।';

  @override
  String get batchNotifications => 'ব্যাচ করা';

  @override
  String get batchNotificationsDescription =>
      'পর্যায়ক্রমে বিজ্ঞপ্তিগুলির একটি সারাংশ পান।';

  @override
  String get customNotifications => 'কাস্টম';

  @override
  String get customNotificationsDescription =>
      'বিজ্ঞপ্তি পাওয়ার জন্য আপনার নিজস্ব ব্যবধান নির্ধারণ করুন।';

  @override
  String get customFrequency => 'কাস্টম ফ্রিকোয়েন্সি';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes মিনিট';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ঘন্টা';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ঘন্টা $minutes মিনিট';
  }

  @override
  String get pendingProposals => 'প্রতীক্ষাধীন প্রস্তাবনা';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count টি প্রতীক্ষাধীন প্রস্তাবনা আছে',
      one: '১টি প্রতীক্ষাধীন প্রস্তাবনা আছে',
      zero: 'কোনো প্রতীক্ষাধীন প্রস্তাবনা নেই',
    );
    return 'আপনার $_temp0।';
  }

  @override
  String get guidelinesLabel => 'নির্দেশিকা';

  @override
  String get reportingGuidelines =>
      '• শুধুমাত্র প্রকৃত সমস্যাযুক্ত নম্বর রিপোর্ট করুন\n• সঠিক এবং বিস্তারিত কারণ প্রদান করুন\n• তীব্রতার উপর ভিত্তি করে উপযুক্ত ঝুঁকির স্তর নির্বাচন করুন\n• মিথ্যা রিপোর্ট করলে অ্যাকাউন্ট সীমাবদ্ধ হতে পারে';

  @override
  String get riskLevelLabel => 'ঝুঁকির স্তর';

  @override
  String get riskLevelDescription => 'নম্বরটির ঝুঁকির স্তর';

  @override
  String get phoneNumberMinDigits => 'ফোন নম্বরে কমপক্ষে ৭টি অঙ্ক থাকতে হবে';

  @override
  String get provideDetailedExplanation =>
      'একটি বিস্তারিত ব্যাখ্যা দিন (ন্যূনতম ১০ অক্ষর)';

  @override
  String get reasonMinCharacters => 'কারণ অবশ্যই কমপক্ষে ১০ অক্ষর হতে হবে';

  @override
  String get countryCodeTwoLetters => 'দেশের কোড (ISO 3166-1 আলফা-২) *';

  @override
  String get countryCodeLabel => 'দেশের কোড (ISO 3166-1 আলফা-২) *';

  @override
  String get countryCodeHint => 'যেমন, US, CN, GB';

  @override
  String get countryCodeRequired => 'দেশের কোড প্রয়োজন';

  @override
  String get countryCodeLengthError => 'দেশের কোড অবশ্যই ২ অক্ষরের হতে হবে';

  @override
  String get phoneNumberLengthError => 'ফোন নম্বরে কমপক্ষে ৭টি অঙ্ক থাকতে হবে';

  @override
  String get reasonHint => 'বিস্তারিত ব্যাখ্যা দিন (ন্যূনতম ১০ অক্ষর)';

  @override
  String get reasonRequired => 'কারণ প্রয়োজন';

  @override
  String get reasonLengthError => 'কারণ অবশ্যই কমপক্ষে ১০ অক্ষর হতে হবে';

  @override
  String get guidelinesTitle => 'নির্দেশিকা';

  @override
  String get guidelinesText =>
      '• শুধুমাত্র প্রকৃত সমস্যাযুক্ত নম্বর রিপোর্ট করুন\n• সঠিক এবং বিস্তারিত কারণ প্রদান করুন\n• তীব্রতার উপর ভিত্তি করে উপযুক্ত ঝুঁকির স্তর নির্বাচন করুন\n• মিথ্যা রিপোর্ট করলে অ্যাকাউন্ট সীমাবদ্ধ হতে পারে';

  @override
  String get riskLevelCritical => 'গুরুতর';

  @override
  String get riskLevelMedium => 'মাঝারি';

  @override
  String get riskLevelVeryLow => 'খুব কম';

  @override
  String get riskDescriptionVeryLow => 'খুব কম - সামান্য বিরক্তি, অনিয়মিত কল';

  @override
  String get riskDescriptionLow => 'কম - মাঝে মাঝে অবাঞ্ছিত কল';

  @override
  String get riskDescriptionMedium =>
      'মাঝারি - নিয়মিত স্প্যাম বা টেলি মার্কেটিং';

  @override
  String get riskDescriptionHigh =>
      'উচ্চ - অবিরাম হয়রানি বা স্ক্যাম প্রচেষ্টা';

  @override
  String get riskDescriptionCritical => 'গুরুতর - বিপজ্জনক স্ক্যাম বা হুমকি';

  @override
  String get notificationFrequencyTitle => 'বিজ্ঞপ্তি ফ্রিকোয়েন্সি';

  @override
  String get notificationFrequencyLabel => 'বিজ্ঞপ্তি ফ্রিকোয়েন্সি (ঘন্টা)';

  @override
  String errorMessage(String error) {
    return 'ত্রুটি: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'ভোট: $totalVotes ($supportPercentage% সমর্থন)';
  }

  @override
  String supportCount(int supportCount) {
    return 'সমর্থন ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'বিরোধিতা ($opposeCount)';
  }

  @override
  String get timeJustNow => 'এইমাত্র';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes মিনিট আগে';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours ঘন্টা আগে';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days দিন আগে';
  }

  @override
  String get notificationFrequencyHours => 'বিজ্ঞপ্তি ফ্রিকোয়েন্সি (ঘন্টা)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes ভোট ($supportPercentage% সমর্থন)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ঘন্টা',
      one: '১ ঘন্টা',
      zero: '০ ঘন্টা',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'গুরুত্বপূর্ণ বিজ্ঞপ্তি';

  @override
  String get dataSourceDisclaimer =>
      'নম্বরগুলি ইন্টারনেট এবং ব্যবহারকারীর জমা থেকে সংগ্রহ করা হয়। আমরা নিশ্চয়তা দিতে পারি না যে একটি নম্বর, একবার মুছে ফেলা হলে, অন্য ব্যবহারকারী বা উত্স দ্বারা পুনরায় জমা দেওয়া হবে না। অনুগ্রহ করে সক্রিয়ভাবে অনুসন্ধান করুন এবং তথ্য যাচাই করুন।';

  @override
  String get avatar => 'অবতার';

  @override
  String get location => 'অবস্থান';

  @override
  String get simCardTitle => 'সিম কার্ড';

  @override
  String get liveActivitiesSettingsTitle => 'লাইভ অ্যাক্টিভিটি সেটিংস';

  @override
  String get elementsSettingsTitle => 'উপাদান সেটিংস';

  @override
  String get liveActivityMode => 'লাইভ অ্যাক্টিভিটি';

  @override
  String get liveActivityModeDescription =>
      'কলের তথ্য লক স্ক্রীন এবং ডায়নামিক আইল্যান্ডে (iOS) একটি স্থায়ী বিজ্ঞপ্তি হিসাবে প্রদর্শন করে।';

  @override
  String get phoneNumberType => 'ফোন নম্বরের প্রকার';

  @override
  String get liveActivitiesTestEndActivity => 'কার্যকলাপ শেষ করুন';

  @override
  String get liveActivitiesTestSendNewActivity => 'নতুন কার্যকলাপ পাঠান';

  @override
  String get liveActivitiesTestUpdateActivity => 'কার্যকলাপ আপডেট করুন';

  @override
  String get liveActivityControlsTitle => 'লাইভ অ্যাক্টিভিটি নিয়ন্ত্রণ';

  @override
  String get liveActivitiesTestTitle => 'লাইভ অ্যাক্টিভিটি পরীক্ষা';

  @override
  String get liveActivitiesTestSubtitle =>
      'লাইভ অ্যাক্টিভিটি বিজ্ঞপ্তি পরীক্ষা করুন।';

  @override
  String get liveNotificationCustomizationTitle =>
      'লাইভ বিজ্ঞপ্তি কাস্টমাইজেশন';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'লাইভ বিজ্ঞপ্তির চেহারা কাস্টমাইজ করুন।';

  @override
  String get notification_instructions =>
      'নির্দেশাবলী:\n1. একটি বিজ্ঞপ্তি তৈরি বা আপডেট করতে \"SEND\" ট্যাপ করুন।\n2. ফলাফল দেখতে আপনার হোম স্ক্রিনে যান বা বিজ্ঞপ্তি ট্রে নিচে টানুন।\n3. বিজ্ঞপ্তি বাতিল করতে \"END\" ট্যাপ করুন।';

  @override
  String get autoCancelNotification => 'স্বয়ংক্রিয়ভাবে বাতিল বিজ্ঞপ্তি';

  @override
  String get autoCancelNotificationDescription =>
      'যদি চেক করা হয়, ব্যবহারকারী ট্যাপ করলে বিজ্ঞপ্তিটি স্বয়ংক্রিয়ভাবে বাতিল হয়ে যাবে।';

  @override
  String get setDelayTime => 'বিলম্বের সময় সেট করুন';

  @override
  String get proposalDetails => 'প্রস্তাবনার বিবরণ';

  @override
  String get filterByStatus => 'স্থিতি অনুসারে ফিল্টার করুন';

  @override
  String get proposalNotFound => 'প্রস্তাবনা খুঁজে পাওয়া যায়নি';

  @override
  String get processed => 'প্রক্রিয়াজাত';

  @override
  String get showAll => 'সব দেখান';

  @override
  String get filterAndSortTitle => 'ফিল্টার এবং সাজান';

  @override
  String get filterVerifiedOwner => 'যাচাইকৃত মালিক দ্বারা ফিল্টার করুন';

  @override
  String get filterBy => 'দ্বারা ফিল্টার করুন';

  @override
  String get sortOldest => 'পুরাতনতম অনুসারে সাজান';

  @override
  String get sortNewest => 'নতুনতম অনুসারে সাজান';

  @override
  String get sortMostPopular => 'সবচেয়ে জনপ্রিয় অনুসারে সাজান';

  @override
  String get sortLeastPopular => 'সবচেয়ে কম জনপ্রিয় অনুসারে সাজান';

  @override
  String get sortBy => 'দ্বারা সাজান';

  @override
  String get simRulesNotFound => 'সিম নিয়ম খুঁজে পাওয়া যায়নি';

  @override
  String get simSlotRules => 'সিম স্লট নিয়ম';

  @override
  String get noSimCardDetected => 'কোন সিম কার্ড সনাক্ত করা যায়নি';

  @override
  String get invalidSimData => 'অবৈধ সিম ডেটা';

  @override
  String get simCardData => 'সিম কার্ড ডেটা';

  @override
  String get simSlot => 'সিম স্লট';

  @override
  String get enableFiltering => 'ফিল্টারিং সক্ষম করুন';

  @override
  String get detailedSettingsTitle => 'বিস্তারিত সেটিংস';

  @override
  String get entryPointViewTitle => 'প্রবেশ বিন্দু দৃশ্য';

  @override
  String get callTypeRejected => 'প্রত্যাখ্যাত';

  @override
  String get callTypeSilenced => 'নীরব';

  @override
  String get callTypeVoicemail => 'ভয়েসমেইল';

  @override
  String get callTypeUnknownIntercept => 'অজানা আটক';

  @override
  String andMoreItems(int count) {
    return 'এবং আরও $count আইটেম';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Cloud Sync Settings';

  @override
  String get localDatabaseSyncSubtitle => 'Sync data across devices';

  @override
  String get localDatabaseSyncDescription =>
      'Connect your personal Supabase database to sync data across devices.';

  @override
  String get supabaseProjectUrl => 'Supabase Project URL';

  @override
  String get supabaseAnonKey => 'Anon Key';

  @override
  String get supabaseAnonKeyHint => 'API Key, anon public key';

  @override
  String get connectionString => 'Connection String (URI)';

  @override
  String get connectionStringHelper =>
      'Only needed for \'Initialize Database\'';

  @override
  String get syncCallHistory => 'Sync Call History';

  @override
  String get syncCallHistorySubtitle => 'Include private call logs in sync';

  @override
  String get requiredField => 'Required';

  @override
  String get requiredInitField => 'Required for initialization';

  @override
  String get initDbButton => 'Initialize Database';

  @override
  String get dbInitSuccess => 'Database Initialized Successfully!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Sync Complete. Sent: $pushed, Received: $pulled';
  }

  @override
  String get errorPrefix => 'Error';

  @override
  String get errorLoadingSettings => 'Error loading settings';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusConnected => 'Connected / Configured';

  @override
  String get statusNotConfigured => 'Not Configured';

  @override
  String get configSaved => 'Configuration Saved!';

  @override
  String get masterDeviceLabel => 'Is Master Device (Admin)';

  @override
  String get masterDeviceHelp =>
      'Only the master device can initialize the database structure.';

  @override
  String get syncIntervalLabel => 'Auto-sync Interval';

  @override
  String syncIntervalValue(int hours) {
    return 'Every $hours hours';
  }

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';
}
