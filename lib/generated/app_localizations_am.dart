// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get aboutContactSubscription => 'ስለ እውቂያ ምዝገባ';

  @override
  String get aboutLabels => 'ስለ መለያዎች';

  @override
  String get aboutPhoneSubscriptionRules => 'ስለ የስልክ የደንበኝነት ምዝገባ ህጎች';

  @override
  String get aboutPhoneSubscriptions => 'ስለ የስልክ ምዝገባዎች';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'የስልክ ህግ ዝርዝሮችን በዩአርኤል ይመዝገቡ፣ ህጎችን በራስ-ሰር ያዘምኑ። የJSON፣CSV ቅርጸት ህግ ፋይሎችን ይደግፋል።';

  @override
  String get aboutSmsFilter => 'ስለ ኤስኤምኤስ ማጣሪያ';

  @override
  String get aboutSmsSubscriptionRules => 'ስለ ኤስኤምኤስ የደንበኝነት ምዝገባ ህጎች';

  @override
  String get aboutSubtitle => 'የመተግበሪያ ስሪት እና ህጋዊ መረጃ';

  @override
  String get aboutTitle => 'ስለ';

  @override
  String get action => 'ድርጊት';

  @override
  String get actionAll => 'ሁሉም';

  @override
  String get actionAllow => 'ፍቀድ';

  @override
  String get actionBlock => 'አግድ';

  @override
  String get actionFilterAll => 'ሁሉም ማጣሪያ';

  @override
  String get actionFilterTitle => 'በድርጊት አይነት ማጣሪያ';

  @override
  String get actionFilterTooltip => 'የድርጊት ማጣሪያ';

  @override
  String get actionNone => 'ምንም እርምጃ የለም';

  @override
  String get actionSilence => 'ዝምታ';

  @override
  String actionTag(Object actionType) {
    return 'ድርጊት: $actionType';
  }

  @override
  String get actionType => 'የድርጊት አይነት';

  @override
  String get actionUnknown => 'ያልታወቀ';

  @override
  String get add => 'አክል';

  @override
  String get addAllowedBlockedRule => 'የፍቀድ/አግድ ህግን አክል';

  @override
  String get addAllowSubscription => 'የፍቀድ ምዝገባን አክል';

  @override
  String get addBlockSubscription => 'የአግድ ምዝገባን አክል';

  @override
  String get addContactButton => 'እውቂያ አክል';

  @override
  String addContactFailed(Object error) {
    return 'እውቂያ ማከል አልተሳካም: $error';
  }

  @override
  String get addedToAllowedRules => 'ወደ ፍቀድ ህጎች ተጨምሯል';

  @override
  String get addedToBlacklist => 'ወደ ጥቁር መዝገብ ተጨምሯል';

  @override
  String get addedToBlockedRules => 'ወደ አግድ ህጎች ተጨምሯል';

  @override
  String get addedToFavoriteContacts => 'ወደ ተወዳጅ እውቂያዎች ተጨምሯል';

  @override
  String get addedToFavorites => 'ወደ ተወዳጆች ተጨምሯል';

  @override
  String get addedToWhitelist => 'ወደ ነጭ ዝርዝር ተጨምሯል';

  @override
  String get addFavorite => 'ተወዳጅ አክል';

  @override
  String get addFilter => 'ማጣሪያ አክል';

  @override
  String get addLabel => 'መለያ አክል';

  @override
  String get addLabelButton => 'መለያ አክል';

  @override
  String addLabelFailed(Object error) {
    return 'መለያ ማከል አልተሳካም: $error';
  }

  @override
  String get addLabelToCall => 'የጥሪ መዝገብ ላይ መለያ አክል';

  @override
  String get addName => 'ስም አክል';

  @override
  String get addNoneSubscription => 'ምንም ምዝገባ የለም';

  @override
  String get addOrEditContactInfo => 'የእውቂያ መረጃን ለማከል ወይም ለማርትዕ ጥቅም ላይ ይውላል';

  @override
  String get addPhoneMark => 'የስልክ ምልክት አክል';

  @override
  String get addPhoneNumberRule => 'የስልክ ቁጥር ህግን አክል';

  @override
  String get addPlugin => 'ተሰኪ አክል';

  @override
  String get addPluginFailed => 'ተሰኪ ማከል አልተሳካም';

  @override
  String addPluginFailedWithError(Object error) {
    return 'ተሰኪ ማከል አልተሳካም: $error';
  }

  @override
  String get addPluginFromLocalFile => 'ተሰኪ ከአካባቢ ፋይል';

  @override
  String get addPluginFromUrl => 'ተሰኪ ከዩአርኤል';

  @override
  String get addRegexRule => 'የቁጥር ግጥሚያ ህግን አክል';

  @override
  String get addRule => 'ህግ አክል';

  @override
  String get addRuleButton => 'ህግ አክል';

  @override
  String addRuleFailed(Object error) {
    return 'ህግ ማከል አልተሳካም: $error';
  }

  @override
  String get addRuleTooltip => 'ህግ አክል';

  @override
  String get addSilenceSubscription => 'የዝምታ ምዝገባን አክል';

  @override
  String get addSimRuleButton => 'የሲም ህግን አክል';

  @override
  String get addSmsFilterRule => 'የኤስኤምኤስ ማጣሪያ ህግን አክል';

  @override
  String get addSmsRule => 'የኤስኤምኤስ ህግን አክል';

  @override
  String get addSmsSubscription => 'የኤስኤምኤስ ምዝገባን አክል';

  @override
  String get addSubscription => 'ምዝገባ አክል';

  @override
  String get addSubscriptionButton => 'ምዝገባ አክል';

  @override
  String addSubscriptionFailed(Object error) {
    return 'ምዝገባ ማከል አልተሳካም: $error';
  }

  @override
  String get addSubscriptionTooltip => 'ምዝገባ አክል';

  @override
  String get addToAllowedRules => 'ወደ ፍቀድ ህጎች አክል';

  @override
  String get addToBlacklist => 'ወደ ጥቁር መዝገብ አክል';

  @override
  String get addToBlockedRules => 'ወደ አግድ ህጎች አክል';

  @override
  String get addToFavoriteContacts => 'ወደ ተወዳጅ እውቂያዎች አክል';

  @override
  String get addToFavorites => 'ወደ ተወዳጆች አክል';

  @override
  String get addToRules => 'ወደ ህጎች አክል';

  @override
  String get addToWhitelist => 'ወደ ነጭ ዝርዝር አክል';

  @override
  String get adPlaceholder => 'የማስታወቂያ መሙያ';

  @override
  String get agent => 'ወኪል';

  @override
  String get all => 'ሁሉም';

  @override
  String get allCallsTab => 'ሁሉም';

  @override
  String get allDataClearedSuccessfully => 'ሁሉም ውሂብ በተሳካ ሁኔታ ተጠርጓል';

  @override
  String get allow => 'ፍቀድ';

  @override
  String get allowAllAllowRules => 'ሁሉንም የፍቀድ ህጎች ፍቀድ';

  @override
  String get allowAllAllowRulesDesc => 'ከፍቀድ ህጎች ጥሪዎችን ፍቀድ';

  @override
  String get allowAllBlacklistedNumbers => 'ሁሉንም በጥቁር መዝገብ የተመዘገቡ ቁጥሮችን ፍቀድ';

  @override
  String get allowAllBlacklistedNumbersDesc => 'ከጥቁር መዝገብ ጥሪዎችን ፍቀድ';

  @override
  String get allowAllBlockRules => 'ሁሉንም የአግድ ህጎች ፍቀድ';

  @override
  String get allowAllBlockRulesDesc => 'ከአግድ ህጎች ጥሪዎችን ፍቀድ';

  @override
  String get allowAllowedNumbers => 'የተፈቀዱ ቁጥሮችን ፍቀድ';

  @override
  String get allowAllowedNumbersDesc => 'ከነጭ ዝርዝር ጥሪዎችን ፍቀድ';

  @override
  String get allowBlock => 'ፍቀድ/አግድ';

  @override
  String get allowBlockedNumbers => 'የተከለከሉ ቁጥሮችን ፍቀድ';

  @override
  String get allowBlockedNumbersDesc => 'ከጥቁር መዝገብ ጥሪዎችን ፍቀድ';

  @override
  String get allowedBlockedRule => 'የፍቀድ/አግድ ህግ';

  @override
  String get allowedBlockedRuleEditDialogTitle => 'የፍቀድ/አግድ ህግን አርትዕ አድርግ';

  @override
  String get allowedBlockedRuleManagement => 'የፍቀድ/አግድ ህግ አስተዳደር';

  @override
  String get allowNonExceededNumbers => 'ከገደቡ በላይ ያልሆኑ ቁጥሮችን ፍቀድ';

  @override
  String get allowNonExceededNumbersDescription =>
      'ከብዛቱ ገደብ ያልበለጠ ቁጥሮችን በራስ-ሰር ፍቀድ';

  @override
  String get allowRegexAllowRules => 'የቁጥር ግጥሚያ ፍቀድ ህጎች';

  @override
  String get allowRegexAllowRulesDesc => 'ለፍቀድ ህጎች የቁጥር ግጥሚያን አንቃ';

  @override
  String get allowRegexAllowRulesDescription => 'በቁጥር ላይ የተመሰረቱ የፍቀድ ህጎችን አንቃ';

  @override
  String get allowRegexBlockRules => 'የቁጥር ግጥሚያ አግድ ህጎች';

  @override
  String get allowRegexBlockRulesDesc => 'ለአግድ ህጎች የቁጥር ግጥሚያን አንቃ';

  @override
  String get allowRegexBlockRulesDescription => 'በቁጥር ላይ የተመሰረቱ የአግድ ህጎችን አንቃ';

  @override
  String get allowRule => 'የፍቀድ ህግ';

  @override
  String get allowRules => 'የፍቀድ ህጎች';

  @override
  String get allowWhitelistedNumbers => 'ነጭ መዝገብ ቁጥሮች ይፍቀዱ';

  @override
  String get allowWhitelistedNumbersDescription => 'ነጭ መዝገብ ያሉትን ሁሉንም ቁጥሮች ፍቀድ';

  @override
  String get allPermissionsGranted => 'ሁሉም ፈቃዶች ተሰጥተዋል';

  @override
  String get allSettingsCompleted => 'ሁሉም ቅንብሮች ተጠናቀዋል።';

  @override
  String allUpdateSuccess(Object count) {
    return 'ሁሉም ዝማኔዎች ተጠናቀዋል ($count ህጎች)';
  }

  @override
  String get answerThenHangup => 'መልስ ከዚያም አንጠልጥል';

  @override
  String get appLegalese => '© 2023 የእርስዎ ጥሪ የእርስዎ ህግ። ሁሉም መብቶች የተጠበቁ ናቸው።';

  @override
  String get applicationSoftware => 'የመተግበሪያ ሶፍትዌር';

  @override
  String get apply => 'ተግብር';

  @override
  String get appName => 'የእርስዎ ጥሪ የእርስዎ ህግ';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'ፍቃድ አልተሳካም፡ እባክዎ የደንበኛ መታወቂያ እና ቁልፍ ይፈትሹ';

  @override
  String get authorizationFailedMessage => 'ፍቃድ አልተሳካም';

  @override
  String get authorizationSuccessMessage => 'ፍቃድ ተሳክቷል';

  @override
  String get authorizeLoginButton => 'ፍቃድ ግባ';

  @override
  String get automotiveIndustry => 'የአውቶሞቲቭ ኢንዱስትሪ';

  @override
  String get autoSyncLabel => 'ራስ-አመሳስል';

  @override
  String get autoUpdate => 'ራስ-አዘምን';

  @override
  String get autoUpdateDescription =>
      'ለደንበኝነት ምዝገባዎች ራስ-ዝማኔ ክፍተቶችን ያዘጋጁ ወይም በእጅ ያዘምኑ';

  @override
  String get autoUpdateSettings => 'ራስ-ዝማኔ ቅንብሮች';

  @override
  String get autoUpdateSettingsSubtitle =>
      'ለህጎች እና ተሰኪዎች ራስ-አውቶማቲክ ዝማኔዎችን ያስተዳድሩ';

  @override
  String get autoUpdateSettingsTitle => 'ራስ-ዝማኔ ቅንብሮች';

  @override
  String get autoUpdateSubtitle => 'ለህጎች እና ተሰኪዎች ራስ-አውቶማቲክ ዝማኔዎችን ያስተዳድሩ';

  @override
  String get autoUpdateTitle => 'ራስ-ዝማኔ';

  @override
  String get avatarBorderColor => 'የአቫታር ድንበር ቀለም';

  @override
  String get avatarBorderSize => 'የአቫታር ድንበር መጠን';

  @override
  String get avatarIconSizesSetting => 'የአቫታር እና አዶ መጠኖች';

  @override
  String get avatarPosition => 'የአቫታር አቀማመጥ';

  @override
  String get avatarSize => 'የአቫታር መጠን';

  @override
  String axisPosition(Object axis) {
    return '$axis አቀማመጥ';
  }

  @override
  String get backgroundGradientSetting => 'የዳራ ውርጭ';

  @override
  String get backup => 'ምትኬ';

  @override
  String get backupAndRestore => 'ምትኬ እና መልሶ ማግኛ';

  @override
  String get backupAndRestoreSubtitle => 'የመተግበሪያ ውሂብ ምትኬ ያስቀምጡ ወይም ይመልሱ';

  @override
  String get backupAndRestoreTitle => 'ምትኬ & መልሶ ማግኛ';

  @override
  String get backupFailed => 'ምትኬ አልተሳካም';

  @override
  String get backupFailedMessage => 'ምትኬ አልተሳካም';

  @override
  String backupFailedWithError(Object error) {
    return 'ምትኬ አልተሳካም: $error';
  }

  @override
  String get backupRestoreSubtitle => 'የመተግበሪያ ውሂብ ምትኬ ያስቀምጡ ወይም ይመልሱ';

  @override
  String get backupRestoreTitle => 'ምትኬ & መልሶ ማግኛ';

  @override
  String get backupSectionTitle => 'ምትኬ';

  @override
  String get backupSettings => 'ምትኬ ቅንብሮች';

  @override
  String get backupSettingsDialogTitle => 'ምትኬ ቅንብሮች';

  @override
  String get backupSettingsTitle => 'ምትኬ ቅንብሮች';

  @override
  String get backupSuccessMessage => 'በደመና ላይ በስኬት ምትኬ ተቀምጧል';

  @override
  String backupSuccessToLocal(Object path) {
    return 'ምትኬ ወደ: $path በተሳካ ሁኔታ ተቀምጧል';
  }

  @override
  String get backupToCloud => 'ወደ ደመና ምትኬ';

  @override
  String get backupToCloudDescription => 'ቅንብሮች እና ህጎች ወደ ደመና ማከማቻ ምትኬ ያስቀምጡ';

  @override
  String backupToCloudFailed(Object error) {
    return 'ወደ ደመና ምትኬ አልተሳካም: $error';
  }

  @override
  String get backupToCloudLabel => 'ወደ ደመና ምትኬ';

  @override
  String get backupToCloudSuccess => 'በደመና ላይ በስኬት ምትኬ ተቀምጧል';

  @override
  String get backupToCloudTitle => 'ወደ ደመና ምትኬ';

  @override
  String get backupToLocalLabel => 'ወደ አካባቢያዊ ምትኬ';

  @override
  String get bank => 'ባንክ';

  @override
  String get basicInfo => 'መሰረታዊ መረጃ';

  @override
  String get basicRuleFilter => 'መሰረታዊ ህግ ማጣሪያ';

  @override
  String get basicRuleFiltering => 'መሰረታዊ ህግ ማጣሪያ';

  @override
  String get basicRuleFilteringExplanation =>
      '• መሰረታዊ ህግ ማጣሪያ፡ ከጥቁር መዝገብ፣ ነጭ መዝገብ እና ሬጌክስ ላይ ተመስርተው ህጎችን ማጣራት';

  @override
  String get basicRuleFilterSettings => 'መሰረታዊ ህግ ማጣሪያ ቅንብሮች';

  @override
  String get basicRuleFilterSubtitle =>
      'ጥሪዎችን በጥቁር/በነጭ መዝገብ እና መደበኛ አገላለጾችን በመጠቀም ያጣሩ';

  @override
  String get batchDeleteContacts => 'የጅምላ እውቂያዎች ሰርዝ';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return '$count የተመረጡ እውቂያዎችን መሰረዝዎን እርግጠኛ ነዎት?';
  }

  @override
  String get batchDeleteFailed => 'የጅምላ መሰረዝ አልተሳካም';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return '$count መለያዎችን መሰረዝዎን እርግጠኛ ነዎት?';
  }

  @override
  String get blacklist => 'ጥቁር መዝገብ';

  @override
  String get blacklistingAndWhitelisting => 'ጥቁር መዝገብ እና ነጭ መዝገብ';

  @override
  String get blacklistLabel => 'ጥቁር መዝገብ';

  @override
  String get blackWhiteList => 'ጥቁር/ነጭ ዝርዝር';

  @override
  String get block => 'አግድ';

  @override
  String get blockCalls => 'ጥሪዎችን አግድ';

  @override
  String get blocked => 'ታገደ';

  @override
  String get blockedCallAction => 'የታገደ ጥሪ እርምጃ';

  @override
  String get blockedCalls => 'የታገዱ ጥሪዎች';

  @override
  String get blockedCallsTitle => 'የታገዱ ጥሪዎች';

  @override
  String get blockedCommunications => 'የታገዱ ግንኙነቶች';

  @override
  String get blockedPhoneLabel => 'የታገዱ ጥሪዎች';

  @override
  String get blockedSpamCalls => 'የታገዱ የስፓም ጥሪዎች';

  @override
  String get blockingTrend => 'የማገድ አዝማሚያ';

  @override
  String get blockInternationalCalls => '+ ወይም 00 የማይጀምሩ ቁጥሮችን ይዛመዳል';

  @override
  String get blockInternationalCallsTitle => 'አለምአቀፍ ጥሪዎችን አግድ';

  @override
  String get blockLandlineNumbersTitle => 'የመሬት መስመር ቁጥሮችን አግድ';

  @override
  String get blockMobileNumbers => '13-19 የማይጀምሩ ቁጥሮችን ይዛመዳል';

  @override
  String get blockMobileNumbersTitle => 'የሞባይል ቁጥሮችን አግድ';

  @override
  String get blockPremiumRateNumbers => '118 ወይም 120-190 የማይጀምሩ ቁጥሮችን ይዛመዳል';

  @override
  String get blockPremiumRateNumbersTitle => 'ፕሪሚየም ዋጋ ቁጥሮችን አግድ';

  @override
  String get blockRule => 'አግድ ህግ';

  @override
  String get blockRules => 'አግድ ህጎች';

  @override
  String get blockSpecificAreaCodes => '0 + 2-3 አሃዞች የሚጀምሩ ቁጥሮችን ይዛመዳል';

  @override
  String get blockSpecificAreaCodesTitle => 'የተወሰኑ የአካባቢ ኮዶችን ያግዱ:';

  @override
  String get blockTypeAnalysisTitle => 'የማገድ አይነት ትንተና';

  @override
  String get both => 'ሁለቱም';

  @override
  String get bulkDelete => 'የጅምላ እውቂያዎች ሰርዝ';

  @override
  String get bulkDeleteContacts => 'የጅምላ እውቂያዎች ሰርዝ';

  @override
  String get bulkDeleteLabels => 'የጅምላ መለያዎች ሰርዝ';

  @override
  String get call => 'ጥሪ';

  @override
  String get callback => 'ጥሪ ተመለስ';

  @override
  String callbackTo(String number) {
    return 'ወደ $number ጥሪ ተመለስ';
  }

  @override
  String get callBlocking => 'የጥሪ ማገድ';

  @override
  String get callerIdApp => 'ደዋይ መታወቂያ መተግበሪያ';

  @override
  String get callerIdCustomizationTitle => 'የደዋይ መታወቂያ ያብጁ';

  @override
  String get callerIdDialogTitle => 'የደዋይ መታወቂያ መረጃ';

  @override
  String get callerIdDisplayMode => 'የደዋይ መታወቂያ ማሳያ ሁኔታ';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'በ$count ተሰይሟል';
  }

  @override
  String get callerIdPreview => 'የደዋይ መታወቂያ ቅድመ እይታ';

  @override
  String get callFilter => 'የጥሪ ማጣሪያ';

  @override
  String get callFilterDescription =>
      'ሲነቃ ገቢ ጥሪዎች ከታች ባለው የደንብ ዝርዝር ጋር ይነጻጸራሉ። የጥሪ ማጣሪያ ህጎች በመሣሪያዎች መካከል በነባሪነት አልተመሳሰሉም።';

  @override
  String get callFilterRules => 'የጥሪ ማጣሪያ ህጎች';

  @override
  String get callFilterRulesDescription => 'ለጥሪ ማጣሪያ መሰረታዊ ህጎችን ያዘጋጁ';

  @override
  String get callFilterSettings => 'የጥሪ ማጣሪያ ቅንብሮች';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'የጥሪ ድግግሞሽ ገደቦችን እና የማገድ ህጎችን ያዘጋጁ';

  @override
  String get callFrequencyInterceptionTitle => 'የጥሪ ድግግሞሽ መጥለፍ';

  @override
  String get callHistory => 'የጥሪ ታሪክ';

  @override
  String get callHistoryInfoDesc =>
      'እዚህ ገቢ፣ ወጪ እና የጠፉ ጥሪዎችን ጨምሮ የጥሪ ታሪክዎን ያሳያል።';

  @override
  String get callHistoryInfoTitle => 'የጥሪ ታሪክ';

  @override
  String callHistoryInitFailed(Object error) {
    return 'የጥሪ ታሪክን ለማስጀመር አልተሳካም: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'የጥሪ ታሪክን ለማደስ አልተሳካም: $error';
  }

  @override
  String get callHistoryTab => 'የጥሪ ታሪክ';

  @override
  String get callHistoryTimelineEarlier => 'ቀደም ብሎ';

  @override
  String get callHistoryTimelineToday => 'ዛሬ';

  @override
  String get callHistoryTimelineYesterday => 'ትናንት';

  @override
  String get callScreeningPermission => 'የጥሪ ማጣሪያ ፈቃድ';

  @override
  String get callScreeningPermissionDescription =>
      'የስፓም ጥሪዎችን ለማጣራት እና ለማገድ ያገለግላል።';

  @override
  String get callScreeningPermissionNotGranted =>
      'የጥሪ ማጣሪያ ፈቃድ አልተሰጠም፣ የኛን መተግበሪያ ተግባራዊነት ሊጎዳ ይችላል።';

  @override
  String get callSettingsSubtitle => 'የደዋይ መታወቂያ፣ ማጣሪያ እና የማገድ ቅንብሮች';

  @override
  String get callSettingsTitle => 'የጥሪ ቅንብሮች';

  @override
  String get callStatistics => 'የጥሪ ስታትስቲክስ';

  @override
  String get callTypeAnswered => 'መልስ የተሰጠበት';

  @override
  String get callTypeBlocked => 'የተከለከለ';

  @override
  String get callTypeIconColor => 'የጥሪ አይነት የአዶ ቀለም';

  @override
  String get callTypeMissed => 'የጠፋ ጥሪ';

  @override
  String get callTypeOutgoing => 'ወጪ';

  @override
  String get callTypePosition => 'የጥሪ አይነት ቦታ';

  @override
  String get callTypeUnknown => 'ያልታወቀ';

  @override
  String get cancelButton => 'ይቅር';

  @override
  String get carRental => 'የመኪና ኪራይ';

  @override
  String get carrier => 'ተሸካሚ';

  @override
  String get carrierColor => 'የተሸካሚ ቀለም';

  @override
  String get carrierFontSize => 'የተሸካሚ ቅርጸ-ቁምፊ መጠን';

  @override
  String get carrierPosition => 'የተሸካሚ ቦታ';

  @override
  String get changeLabel => 'መለያ ቀይር';

  @override
  String changePluginStatusFailed(Object error) {
    return 'የፕለጊን ሁኔታን ለመቀየር አልተሳካም: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'የደንበኝነት ምዝገባ ሁኔታን ለመቀየር አልተሳካም: $error';
  }

  @override
  String get changeTag => 'መለያ ቀይር';

  @override
  String get charity => 'በጎ አድራጎት';

  @override
  String chartMonthFormat(int month) {
    return 'ወር $month';
  }

  @override
  String get chartOneDayAgo => '1 ቀን በፊት';

  @override
  String get chartOneMonthAgo => '1 ወር በፊት';

  @override
  String get chartOneWeekAgo => '1 ሳምንት በፊት';

  @override
  String get chartTenDaysAgo => '10 ቀናት በፊት';

  @override
  String get chartThreeDaysAgo => '3 ቀናት በፊት';

  @override
  String get chartToday => 'ዛሬ';

  @override
  String get checkFileFormat => 'እባክዎ የፋይል ቅርጸት ወይም ፍቃዶችን ይፈትሹ';

  @override
  String checkPermissionFailed(Object error) {
    return 'ፍቃዶችን ለመፈተሽ አልተሳካም: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'ነባሪ የመጥለፍያ እርምጃ ይምረጡ';

  @override
  String get clearAllData => 'ሁሉንም ውሂብ ሰርዝ';

  @override
  String get clearAllDataConfirmation =>
      'ሁሉንም የመተግበሪያ ውሂብ ማጽዳት ይፈልጋሉ? ይህ እርምጃ ሊቀለበስ አይችልም።';

  @override
  String get clearAllDataDescription => 'ሁሉንም የመተግበሪያ ውሂብ ሰርዝ';

  @override
  String get clearAllDataLabel => 'ሁሉንም ውሂብ ሰርዝ';

  @override
  String get clearFilter => 'ማጣሪያ ሰርዝ';

  @override
  String get clearLabelFilter => 'የመለያ ማጣሪያ ሰርዝ';

  @override
  String get clearLabelFilterButton => 'የመለያ ማጣሪያ ሰርዝ';

  @override
  String get closeButton => 'ዝጋ';

  @override
  String get cloudSync => 'የደመና ማመሳሰል';

  @override
  String get cloudSyncAndBackupTitle => 'የደመና ማመሳሰል እና ምትኬ';

  @override
  String get cloudSyncSettingsSubtitle =>
      'WebDAV፣ OneDrive እና Google Drive ያዋቅሩ';

  @override
  String get cloudSyncSettingsTitle => 'የደመና ማመሳሰል ቅንብሮች';

  @override
  String get cloudSyncTitle => 'የደመና ማመሳሰል';

  @override
  String get collapseLabelSelector => 'የመለያ መራጭን ዝጋ';

  @override
  String get collection => 'ዕዳ መሰብሰብ';

  @override
  String get colorPickerTitle => 'ቀለም ይምረጡ';

  @override
  String get configManagement => 'የውቅር አስተዳደር';

  @override
  String get configUpdated => 'ውቅር ተዘምኗል';

  @override
  String get configurationAdvice =>
      'ትክክለኛ ውቅርን በመጠቀም ለስራ እና ለግል ሲም ካርዶች የተለያዩ የማጣሪያ ስልቶችን ማዘጋጀት ይችላሉ።';

  @override
  String get configureBackupOptions => 'የመጠባቂያ አማራጮችን ያዋቅሩ';

  @override
  String get configureBackupOptionsSubtitle => 'የመጠባቂያ አማራጮችን ያዋቅሩ';

  @override
  String get configureCloudSyncService => 'የደመና ማመሳሰል አገልግሎት ያዋቅሩ';

  @override
  String get configureCloudSyncServiceHint =>
      'እባክዎ የብዙ-መሣሪያ ማመሳሰልን ለማንቃት የደመና ማመሳሰል አገልግሎት ያዋቅሩ።';

  @override
  String get configureCloudSyncServiceMessage =>
      'እባክዎ የብዙ-መሣሪያ ማመሳሰልን ለማንቃት የደመና ማመሳሰል አገልግሎት ያዋቅሩ።';

  @override
  String get configureSimCardFilterRules => 'የሲም ካርድ ማጣሪያ ህጎችን ያዋቅሩ';

  @override
  String get configureSyncServiceHint =>
      'እባክዎ በመጀመሪያ የደመና ማመሳሰል ቅንብሮች ውስጥ የማመሳሰል አገልግሎት ያዋቅሩ';

  @override
  String get confirm => 'አረጋግጥ';

  @override
  String get confirmBatchDeleteContacts => 'የተመረጡትን መሰረዝ ይፈልጋሉ?';

  @override
  String get confirmButton => 'አረጋግጥ';

  @override
  String get confirmDelete => 'አረጋግጥ ሰርዝ';

  @override
  String get confirmDeleteContact => 'እርግጠኛ ነዎት መሰረዝ ይፈልጋሉ';

  @override
  String get confirmDeleteContactName => 'መሰረዙን ያረጋግጡ?';

  @override
  String get confirmDeleteFilter => 'ይህን ማጣሪያ መሰረዝ ይፈልጋሉ?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'መለያ \"$name\" መሰረዙን ያረጋግጡ';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'ፕለጊን \"$name\" መሰረዙን ያረጋግጡ?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '$count ፕለጊኖችን መሰረዙን ያረጋግጡ?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'ይህን ህግ መሰረዝ ይፈልጋሉ? ይህ እርምጃ ሊቀለበስ አይችልም።';

  @override
  String get confirmDeleteSelectedContacts => 'የተመረጡ እውቂያዎችን መሰረዙን ያረጋግጡ?';

  @override
  String get confirmDeleteSmsFilterRule => 'ይህን የኤስኤምኤስ ማጣሪያ ህግ መሰረዝ ይፈልጋሉ?';

  @override
  String get confirmDeleteSmsRule => 'ይህን የኤስኤምኤስ ህግ መሰረዝ ይፈልጋሉ?';

  @override
  String get confirmDeleteSubscription => 'ይህን የደንበኝነት ምዝገባ መሰረዝ ይፈልጋሉ?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '$name መሰረዙን ያረጋግጡ?';
  }

  @override
  String get confirmPassword => 'የይለፍ ቃል ያረጋግጡ';

  @override
  String get confirmPasswordLabel => 'የይለፍ ቃል ያረጋግጡ';

  @override
  String get connectedStatus => 'ተገናኝቷል';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'ግንኙነት አልተሳካም: እባክዎ የአገልጋዩን አድራሻ፣ የተጠቃሚ ስም እና የይለፍ ቃል ይፈትሹ';

  @override
  String get connectionFailedMessage => 'ግንኙነት አልተሳካም';

  @override
  String get connectionStatusLabel => 'የግንኙነት ሁኔታ';

  @override
  String get connectionSuccessMessage => 'ግንኙነት ተሳክቷል';

  @override
  String get contactAddSuccess => 'ዕውቂያ በተሳካ ሁኔታ ታክሏል';

  @override
  String get contactDeleted => 'ዕውቂያ ተሰርዟል';

  @override
  String get contactEditDialog => 'የዕውቂያ ማረምያ መስኮት';

  @override
  String get contactNameHint => 'የዕውቂያ ስም ያስገቡ (አማራጭ)';

  @override
  String get contactNameLabel => 'ስም';

  @override
  String get contactNameOptional => 'የዕውቂያ ስም (አማራጭ)';

  @override
  String get contactNotFound => 'ዕውቂያ አልተገኘም';

  @override
  String get contacts => 'ዕውቂያዎች';

  @override
  String contactsDeleted(Object count) {
    return '$count ዕውቂያዎች ተሰርዘዋል';
  }

  @override
  String get contactSettingsSubtitle => 'የዕውቂያ አስተዳደር እና መለያ ቅንብሮች';

  @override
  String get contactSettingsTitle => 'የዕውቂያ ቅንብሮች';

  @override
  String contactsLoadingFailed(Object error) {
    return 'ዕውቂያዎችን በመጫን ላይ አልተሳካም: $error';
  }

  @override
  String get contactsManagement => 'የዕውቂያዎች አስተዳደር';

  @override
  String get contactsManagementPageTitle => 'የዕውቂያዎች አስተዳደር ገጽ';

  @override
  String get contactsPageTitle => 'የዕውቂያዎች አስተዳደር';

  @override
  String get contactsPermission => 'የዕውቂያዎች ፈቃድ';

  @override
  String get contactsPermissionDescription =>
      'ለጥሪዎች ዕውቂያዎችን ለመለየት ጥቅም ላይ ይውላል።';

  @override
  String get contactsTab => 'ዕውቂያዎች';

  @override
  String get contactSubscriptionDescription =>
      'የዕውቂያ ዝርዝሮችን በዩአርኤል ይመዝገቡ፤ የዕውቂያ መረጃዎችን እና መለያዎችን በራስ-ሰር ያዘምኑ። የJSON ቅርጸት መረጃ ይደግፋል።';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'የዕውቂያ ምዝገባዎችን በመጫን ላይ አልተሳካም: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'የዕውቂያ ምዝገባዎች';

  @override
  String get contactUpdateSuccess => 'ዕውቂያ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get contactUs => 'ያግኙን';

  @override
  String get content => 'ይዘት';

  @override
  String get contentRegex => 'የይዘት ሬጌክስ';

  @override
  String get countColor => 'የመቆጠር ቀለም';

  @override
  String get countFontSize => 'የመቆጠር ቅርጸ-ቁመት';

  @override
  String get countPosition => 'የመቆጠር ቦታ';

  @override
  String get country => 'ሀገር';

  @override
  String get countryNameColor => 'የሀገር ስም ቀለም';

  @override
  String get countryNameFontSize => 'የሀገር ስም ቅርጸ-ቁመት';

  @override
  String get countryRegionNamePosition => 'የሀገር/ክልል ስም ቦታ';

  @override
  String get countrySelectionDialog => 'የሀገር ምርጫ መስኮት';

  @override
  String get countrySelectionDialogDescription =>
      'የደዋይ መረጃዎችን ለመጠየቅ ሀገር ለመምረጥ ጥቅም ላይ ይውላል';

  @override
  String get countThresholdDescription =>
      'ማጣሪያዎችን ለማንቀሳቀስ የሚያስፈልገውን ዝቅተኛ የመቆጠር ገደብ ያዘጋጁ';

  @override
  String get countThresholdLabel => 'የመቆጠር ገደብ';

  @override
  String get countThresholdSettings => 'የመቆጠር ገደብ ቅንብሮች';

  @override
  String countThresholdValue(Object count) {
    return 'የመቆጠር ገደብ: $count';
  }

  @override
  String get createdRules => 'የተፈጠሩ ህጎች';

  @override
  String get csvFormat => 'CSV ቅርጸት';

  @override
  String get currentDeviceChip => 'አሁን ያለው';

  @override
  String get currentDeviceLabel => 'አሁን ያለው የመሣሪያ መለያ';

  @override
  String get currentDeviceTitle => 'አሁን ያለው መሣሪያ';

  @override
  String get currentLabels => 'አሁን ያሉ መለያዎች:';

  @override
  String get currentLanguage => 'አሁን ያለው ቋንቋ';

  @override
  String get currentPasswordLabel => 'አሁን ያለው የይለፍ ቃል';

  @override
  String get customerService => 'የደንበኞች አገልግሎት';

  @override
  String get customRange => 'የተስተካከለ ክልል';

  @override
  String get dailyStatistics => 'ዕለታዊ ስታትስቲክስ';

  @override
  String get dailyStatisticsDesc => 'ስለታገዱ ጥሪዎች እና መልእክቶች ዕለታዊ ስታትስቲክስ ይቀበሉ';

  @override
  String get dashboardTab => 'ዳሽቦርድ';

  @override
  String get dataAnalysis => 'የውሂብ ትንተና';

  @override
  String get dataAnalysisDashboardPage => 'የውሂብ ትንተና ዳሽቦርድ ገጽ';

  @override
  String get dataExport => 'የውሂብ ኤክስፖርት';

  @override
  String dataLoadFailure(Object error) {
    return 'ውሂብ መጫን አልተሳካም: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'ውሂብ መጫን አልተሳካም: $error';
  }

  @override
  String get dataMigration => 'የውሂብ ማስተላለፍ';

  @override
  String get dataMigrationDescription =>
      'ይህ ባህሪ ሁሉንም ውሂቦችዎን በመሣሪያዎች መካከል እንዲያስተላልፉ ያስችልዎታል። በአሁኑ ጊዜ ውሂቦችዎን በእጅ ለማስተላለፍ ምትኬ እና እነበረበት መልስ ባህሪያትን መጠቀም ይችላሉ።';

  @override
  String get dataMigrationDialogContent =>
      'ይህ ባህሪ ሁሉንም ውሂቦችዎን በመሣሪያዎች መካከል እንዲያስተላልፉ ያስችልዎታል። በአሁኑ ጊዜ ውሂቦችዎን በእጅ ለማስተላለፍ ምትኬ እና እነበረበት መልስ ባህሪያትን መጠቀም ይችላሉ።';

  @override
  String get dataMigrationDialogTitle => 'የውሂብ ማስተላለፍ';

  @override
  String get dataMigrationSectionTitle => 'የውሂብ ማስተላለፍ';

  @override
  String get dataSourceReminder => 'የውሂብ ምንጭ አስታዋሽ';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ቀናት',
      one: '1 ቀን',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days ቀናት VIP';
  }

  @override
  String get debtCollection => 'ዕዳ መሰብሰብ';

  @override
  String get defaultPeriod => 'ሳምንት';

  @override
  String get delete => 'ሰርዝ';

  @override
  String get deleteButton => 'ሰርዝ';

  @override
  String get deleteContact => 'ዕውቂያ ሰርዝ';

  @override
  String deleteContactConfirm(Object name) {
    return '$nameን መሰረዝ ይፈልጋሉ?';
  }

  @override
  String get deleteContactConfirmation => 'ዕውቂያ መሰረዝ ይፈልጋሉ';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '$deviceNameን መሰረዝ ይፈልጋሉ?';
  }

  @override
  String get deleteDeviceDialogTitle => 'መሣሪያ ሰርዝ';

  @override
  String deleteFailed(Object error) {
    return 'መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deleteFilter => 'ማጣሪያ ሰርዝ';

  @override
  String get deleteLabel => 'መለያ ሰርዝ';

  @override
  String deleteLabelFailed(Object error) {
    return 'መለያ መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deletePlugin => 'ተሰኪ ሰርዝ';

  @override
  String deletePluginFailed(Object error) {
    return 'ተሰኪ መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deletePlugins => 'ተሰኪዎች ሰርዝ';

  @override
  String deletePluginsFailed(Object error) {
    return 'ተሰኪዎች መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deleteRule => 'ህግ ሰርዝ';

  @override
  String deleteRuleFailed(Object error) {
    return 'መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deleteSelected => 'የተመረጡትን ሰርዝ';

  @override
  String get deleteSmsRule => 'የኤስኤምኤስ ህግ ሰርዝ';

  @override
  String get deleteSubscription => 'ምዝገባ ሰርዝ';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '\"$name\" የተባለውን ምዝገባ መሰረዝ ይፈልጋሉ?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'ምዝገባ መሰረዝ አልተሳካም: $error';
  }

  @override
  String get deleteSuccess => 'መሰረዝ ተሳክቷል';

  @override
  String get delivery => 'ማድረስ';

  @override
  String get deviceDeletedSuccessfully => 'መሣሪያ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get deviceDeletedSuccessfullyMessage => 'መሣሪያ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get deviceIdLabel => 'የመሣሪያ መታወቂያ';

  @override
  String get deviceIDLabel => 'የመሣሪያ መታወቂያ';

  @override
  String get deviceManagementSubtitle => 'በርካታ የመሣሪያ ማመሳሰልን ያቀናብሩ';

  @override
  String get deviceManagementTitle => 'የመሣሪያ አስተዳደር';

  @override
  String get deviceModelLabel => 'የመሣሪያ ሞዴል';

  @override
  String get deviceName => 'የመሣሪያ ስም';

  @override
  String get deviceNameCannotBeEmpty => 'የመሳሪያ ስም ባዶ ሊሆን አይችልም';

  @override
  String get deviceNameHint => 'እባክዎ የመሳሪያውን ስም ያስገቡ';

  @override
  String get deviceNameLabel => 'የመሳሪያ ስም';

  @override
  String get deviceRenamedSuccessfully => 'መሳሪያው በተሳካ ሁኔታ ተሰይሟል';

  @override
  String get deviceRenamedSuccessfullyMessage => 'መሳሪያው በተሳካ ሁኔታ ተሰይሟል';

  @override
  String get devicesSyncedSuccessfully => 'መሳሪያዎች በተሳካ ሁኔታ ተመሳስለዋል';

  @override
  String get devicesSyncedSuccessfullyMessage => 'መሳሪያዎች በተሳካ ሁኔታ ተመሳስለዋል';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'መሳሪያዎች በተሳካ ሁኔታ ተመሳስለዋል';

  @override
  String get deviceUnregisteredSuccessfullyMessage => 'መሳሪያው በተሳካ ሁኔታ ተመዝግቧል';

  @override
  String get dialogTitle => 'የRegex Pattern ማብራሪያ';

  @override
  String get differentFromLocalCounter =>
      'ይህ ባህሪ ከሀገር ውስጥ ቆጣሪ ማጣሪያ የተለየ ነው፣ ምክንያቱም የረጅም ጊዜ ምልክት ከመሆን ይልቅ በአጭር ጊዜ ውስጥ በተደጋጋሚ የመደወል ስርዓተ-ጥለቶችን ይመለከታል።';

  @override
  String get disabled => 'የተሰናከለ';

  @override
  String get disabledStatus => 'የተሰናከለ';

  @override
  String get disableGlobalPlugins => 'አለም አቀፍ ተሰኪዎችን ያሰናክሉ';

  @override
  String get disableSubscriptionSuccessfully => 'ምዝገባ በተሳካ ሁኔታ ተሰናክሏል';

  @override
  String get disconnectButton => 'አቋረጥ';

  @override
  String get disconnectedMessage => 'ተቋርጧል';

  @override
  String get disconnectedStatus => 'ተቋርጧል';

  @override
  String get disconnectFailedMessage => 'ማቋረጥ አልተሳካም';

  @override
  String get done => 'ተከናውኗል';

  @override
  String get dualSimAdvice =>
      'ይህ ባህሪ ለሁለት ሲም ስልኮች ለስራ እና ለግል ሲም ካርዶች የተለያዩ የማጣሪያ ስልቶችን ለማዘጋጀት በጣም ጠቃሚ ነው።';

  @override
  String get earlier => 'ቀደም ብሎ';

  @override
  String get ecommerce => 'ኢ-ኮሜርስ';

  @override
  String get edit => 'አርትዕ';

  @override
  String get editContact => 'እውቂያ አርትዕ';

  @override
  String get editFilter => 'ማጣሪያ አርትዕ';

  @override
  String get editLabel => 'መለያ አርትዕ';

  @override
  String get editPhoneRule => 'የስልክ ደንብ አርትዕ';

  @override
  String get editPhoneRules => 'ለስልክ ደንቦች አርትዕ ለማድረግ ጥቅም ላይ ይውላል';

  @override
  String get editPhoneRuleTitle => 'የስልክ ደንብ አርትዕ';

  @override
  String get editRule => 'ደንብ አርትዕ';

  @override
  String get editSmsRule => 'የኤስኤምኤስ ደንብ አርትዕ';

  @override
  String get education => 'ትምህርት';

  @override
  String get elementPositionsSetting => 'የኤለመንት ቦታዎች';

  @override
  String get email => 'ኢሜል';

  @override
  String get emailOptional => 'ኢሜል (አማራጭ)';

  @override
  String get enableCallFilter => 'የጥሪ ማጣሪያን አንቃ';

  @override
  String get enableCallFilterDescription =>
      'ሲነቃ ገቢ ጥሪዎች ከታች ካለው የደንብ ዝርዝር ጋር ይነጻጸራሉ። የጥሪ ማጣሪያ ደንቦች በአብዛኛው በመሳሪያዎች መካከል አይመሳሰሉም።';

  @override
  String get enabled => 'ነቅቷል';

  @override
  String get enabledStatus => 'ነቅቷል';

  @override
  String get enableEncryption => 'ምስጠራን አንቃ';

  @override
  String get enableEncryptionDescription => 'የመጠባበቂያ ፋይሎችን ኢንክሪፕት አድርግ';

  @override
  String get enableEncryptionLabel => 'ምስጠራን አንቃ';

  @override
  String get enableEncryptionSubtitle => 'የመጠባበቂያ ፋይሎች ይመሰጠራሉ';

  @override
  String get enableEncryptionTitle => 'ምስጠራን አንቃ';

  @override
  String get enableGlobalPlugins => 'አለም አቀፍ ተሰኪዎችን አንቃ';

  @override
  String get enableLocalCountFilter => 'የሀገር ውስጥ ቆጠራ ማጣሪያን አንቃ';

  @override
  String get enableLocalCountFilterDescription =>
      'በጥሪ ምልክት ብዛት ላይ ተመስርተው በራስ-ሰር አይፈለጌ መልዕክቶችን ያጣሩ';

  @override
  String get enableLocalNotification => 'የሀገር ውስጥ ማሳወቂያዎችን ተጠቀም';

  @override
  String get enableLocalNotificationDescription =>
      'ሲነቃ ለተጣሩ መልእክቶች ማሳወቂያዎች በመሣሪያው ላይ ይታያሉ';

  @override
  String get enableLocationSummary => 'አካባቢ';

  @override
  String get enableMuteRules => 'ድምጸ-ከል ደንቦችን አንቃ';

  @override
  String get enableMuteRulesDesc => 'የድምጸ-ከል ጣልቃገብነት ደንቦችን ውቅር ተግብር';

  @override
  String get enableNoneActionRules => 'ምንም እርምጃ የሌላቸውን ደንቦች አንቃ';

  @override
  String get enableNoneActionRulesDesc =>
      'የጣልቃገብነት እርምጃዎች የሌላቸውን ደንቦች ውቅረት ይፍቀዱ';

  @override
  String get enableNotifications => 'ማሳወቂያዎችን አንቃ';

  @override
  String get enableRemoteNumberFilter => 'የርቀት ቁጥር ማጣሪያን አንቃ';

  @override
  String get enableRemoteNumberFilterDescription =>
      'ቁጥሮችን ለማጣራት የርቀት ዳታቤዝ ይጠቀሙ';

  @override
  String get enableRule => 'ደንብ አንቃ';

  @override
  String get enableSmsFilter => 'የኤስኤምኤስ ማጣሪያን አንቃ';

  @override
  String get enableSmsFilterDescription => 'ሲነቃ መልእክቶች እንደ ደንቦቹ በራስ-ሰር ይጣራሉ';

  @override
  String get enableStatisticsNotifications => 'የስታቲስቲክስ ማሳወቂያዎችን አንቃ';

  @override
  String get enableSubscriptionSuccessfully => 'ምዝገባ በተሳካ ሁኔታ ተንቀሳቅሷል';

  @override
  String get enableTimeInterception => 'የጊዜ ጣልቃገብነትን አንቃ';

  @override
  String get enableTimeInterceptionDescription =>
      'በአጭር ጊዜ ውስጥ የተደጋገሙ ጥሪዎችን ጣልቃ ይግቡ';

  @override
  String get enableTimeInterceptor => 'የጊዜ ጣልቃገብነትን አንቃ';

  @override
  String get endCallImmediately => 'ጥሪውን ወዲያውኑ ጨርስ';

  @override
  String get endColor => 'የመጨረሻ ቀለም';

  @override
  String get endDate => 'የማብቂያ ቀን';

  @override
  String get enhancedFilterInstructionsTitle => 'የተሻሻለ የማጣሪያ ስርዓት መመሪያዎች';

  @override
  String get enhancedFilterSettings => 'የተሻሻለ የማጣሪያ ቅንብሮች';

  @override
  String get enhancedFilterSettingsTitle => 'የተሻሻለ የማጣሪያ ቅንብሮች';

  @override
  String get enhancedFilterSystemDescription =>
      'የተሻሻለ የማጣሪያ ስርዓቱ ዓለም አቀፍ ደንቦችን እና ለእያንዳንዱ ሲም ካርድ የማጣሪያ ውቅረቶችን ይደግፋል።';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'እባክዎ የስልክ ቁጥር እና የregex pattern ሁለቱንም ያስገቡ';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'እባክዎ የስልክ ቁጥር እና የregex pattern ሁለቱንም ያስገቡ።';

  @override
  String get enterContactName => 'እባክዎ የእውቂያ ስም ያስገቡ';

  @override
  String get enterCurrentPasswordHint => 'እባክዎ የአሁኑን የይለፍ ቃል ያስገቡ';

  @override
  String get enterDeviceName => 'የመሳሪያ ስም አስገባ';

  @override
  String get enterDeviceNameHint => 'እባክዎ የመሳሪያውን ስም ያስገቡ';

  @override
  String get enterEmail => 'እባክዎ ኢሜል ያስገቡ';

  @override
  String get enterEmailOptional => 'እባክዎ ኢሜል (አማራጭ) ያስገቡ';

  @override
  String get enterEncryptionPasswordHint => 'የምስጠራ ይለፍ ቃል አስገባ';

  @override
  String get enterEncryptionPasswordTitle => 'የምስጠራ ይለፍ ቃል አስገባ';

  @override
  String get enterFilterName => 'እባክዎ የማጣሪያ ስም ያስገቡ';

  @override
  String get enterFilterPattern => 'እባክዎ የማጣሪያ pattern ያስገቡ';

  @override
  String get enterIconCode => 'የአዶ ኮድ አስገባ';

  @override
  String get enterName => 'የእውቂያ ስም አስገባ';

  @override
  String get enterNewDeviceNameHint => 'ለዚህ መሣሪያ አዲስ ስም ያስገቡ';

  @override
  String get enterNewPasswordHint => 'እባክዎ አዲስ የይለፍ ቃል ያስገቡ';

  @override
  String get enterPasswordAgain => 'የይለፍ ቃል እንደገና አስገባ';

  @override
  String get enterPasswordHint => 'እባክዎ የይለፍ ቃል ያስገቡ';

  @override
  String get enterPhoneNumber => 'የስልክ ቁጥር አስገባ';

  @override
  String get enterPhoneNumberHint => 'ለመፈተሽ የስልክ ቁጥር አስገባ';

  @override
  String get enterPhoneNumberMultiple =>
      'እባክዎ የስልክ ቁጥር ያስገቡ፣ ብዙ ቁጥሮች በነጠላ ሰረዝ የተከፋፈሉ';

  @override
  String get enterPhoneNumberToStartSearch => 'ለመጀመር የስልክ ቁጥር አስገባ';

  @override
  String get enterPhoneNumberToVerify => 'ለማረጋገጥ የስልክ ቁጥር አስገባ';

  @override
  String get enterPluginName => 'የተሰኪ ስም አስገባ';

  @override
  String get enterPluginUrl => 'የተሰኪ URL አድራሻ አስገባ';

  @override
  String get enterRegexHint => 'የ regex pattern አስገባ';

  @override
  String get enterRuleNameAndPattern => 'እባክዎ የደንብ ስም እና pattern ያስገቡ';

  @override
  String get enterRuleNameAndPatternMessage => 'እባክዎ የህግ ስም እና የቁጥር ንድፍ ያስገቡ።';

  @override
  String get enterRuleNameHint => 'የህግ ስም ያስገቡ';

  @override
  String get enterSearchContent => 'እባክዎ የፍለጋ ይዘት ያስገቡ';

  @override
  String get enterSubscriptionName => 'የምዝገባ ስም ያስገቡ';

  @override
  String get enterSubscriptionUrl => 'የምዝገባ ዩአርኤል ያስገቡ';

  @override
  String get enterSyncFolderNameHint =>
      'እባክዎ የማመሳሰል አቃፊ ስም ያስገቡ (ነባሪ፡ NotificationManager)';

  @override
  String get entertainment => 'መዝናኛ';

  @override
  String get enterValidNameAndUrl => 'እባክዎ ትክክለኛ ስም እና ዩአርኤል ያስገቡ';

  @override
  String get enterValidUrl => 'እባክዎ ትክክለኛ ዩአርኤል ያስገቡ';

  @override
  String get enterVersion => 'ስሪት ያስገቡ';

  @override
  String get enterWebDAVPasswordHint => 'እባክዎ የWebDAV የይለፍ ቃል ያስገቡ';

  @override
  String get enterWebDAVServerAddressHint => 'እባክዎ የWebDAV አገልጋይ አድራሻ ያስገቡ';

  @override
  String get enterWebDAVUsernameHint => 'እባክዎ የWebDAV የተጠቃሚ ስም ያስገቡ';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'መሳሪያን በመሰረዝ ላይ ስህተት፡ $error';
  }

  @override
  String get errorLoadingPlugin => 'ተሰኪ በመጫን ላይ ስህተት';

  @override
  String errorOccurredMessage(Object error) {
    return 'ስህተት ተከስቷል፡ $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'መሳሪያን በመሰየም ላይ ስህተት፡ $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'መሳሪያዎችን በማመሳሰል ላይ ስህተት፡ $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'መሳሪያዎችን በማመሳሰል ላይ ስህተት፡ $error';
  }

  @override
  String get errorText => 'ስህተት';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'መሳሪያን በማስመዝገብ ላይ ስህተት፡ $error';
  }

  @override
  String get exampleBlock400Prefix => 'ለምሳሌ የ400 ቅድመ-ቁጥር ቁጥሮችን አግድ';

  @override
  String get exampleBlockMarketingSms => 'ለምሳሌ የማስታወቂያ ኤስኤምኤስ አግድ';

  @override
  String get exampleContentRegex => 'ለምሳሌ፣ .*offer.*';

  @override
  String get exampleContentRegexHint => 'የይዘት ምሳሌ ንድፍ';

  @override
  String get exampleCouponPromotionDiscount =>
      'ለምሳሌ .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'ለምሳሌ ቤተሰብ፣ ጓደኞች፣ ወዘተ.';

  @override
  String get examplePhoneNumber => 'ለምሳሌ 10086፣ 12345፣ ወዘተ.';

  @override
  String get exampleRegex400Prefix => 'የ400 ቅድመ-ቁጥር ምሳሌ ንድፍ';

  @override
  String get exampleRegexFormat => 'ለምሳሌ፡ ^10086\$ ቅርጸት';

  @override
  String get exampleSenderRegexHint => 'ምሳሌ';

  @override
  String get exchange => 'መለዋወጥ';

  @override
  String get exchangeNow => 'አሁን ይለውጡ';

  @override
  String get exchangeVip => 'VIP ይለውጡ';

  @override
  String get expandLabelSelector => 'መለያ መራጭን አስፋ';

  @override
  String expiryTime(Object time) {
    return 'የማለቂያ ጊዜ፡ $time';
  }

  @override
  String get export => 'ላክ';

  @override
  String get exportAllApplicationSettings => 'ሁሉንም የመተግበሪያ ቅንብሮች ላክ';

  @override
  String get exportAllApplicationSettingsSubtitle => 'ሁሉንም የመተግበሪያ ቅንብሮች ላክ';

  @override
  String get exportAllRuleConfigurations => 'ሁሉንም የህግ ውቅሮች ላክ';

  @override
  String get exportAllRuleConfigurationsSubtitle => 'ሁሉንም የህግ ውቅሮች ላክ';

  @override
  String get exportComplete => 'ላክ ተጠናቀቀ';

  @override
  String get exportConfig => 'ውቅሮስ ላክ';

  @override
  String get exportContacts => 'ዕውቂያዎችን ላክ';

  @override
  String get exportData => 'ውሂብ ላክ';

  @override
  String get exportError => 'ላክ ስህተት';

  @override
  String get exportFailed => 'ላክ አልተሳካም';

  @override
  String get exportFailure => 'ውቅሮስ መላክ አልተሳካም';

  @override
  String get exportFeatureComingSoon => 'የላክ ባህሪ በቅርቡ ይመጣል';

  @override
  String get exporting => 'እየላከ ነው...';

  @override
  String get exportLabels => 'መለያዎችን ላክ';

  @override
  String exportLabelsFailed(Object error) {
    return 'መለያዎችን መላክ አልተሳካም፡ $error';
  }

  @override
  String get exportPluginList => 'ተሰኪ ዝርዝር ላክ';

  @override
  String exportPluginListFailed(Object error) {
    return 'ተሰኪ ዝርዝር መላክ አልተሳካም፡ $error';
  }

  @override
  String get exportRules => 'ህጎችን ላክ';

  @override
  String get exportRulesDialogTitle => 'ህጎችን ላክ';

  @override
  String get exportRulesTitle => 'ህጎችን ላክ';

  @override
  String get exportSmsRules => 'የኤስኤምኤስ ህጎችን ላክ';

  @override
  String get exportStatisticsData => 'የስታቲስቲክስ ውሂብ ላክ';

  @override
  String get exportSuccess => 'ላክ የተሳካ';

  @override
  String get exportSuccesslly => 'ውቅሮስ በተሳካ ሁኔታ ተልኳል';

  @override
  String get failedToAddContact => 'ዕውቂያ ማከል አልተሳካም';

  @override
  String failedToAddRule(Object error) {
    return 'ህግ ማከል አልተሳካም፡ $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'የኤስኤምኤስ ህግ ማከል አልተሳካም፡ $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'የኤስኤምኤስ ምዝገባ ማከል አልተሳካም፡ $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'ቅንብሮችን ምትኬ ማስቀመጥ አልተሳካም፡ $error';
  }

  @override
  String get failedToDecryptBackupFile => 'ምትኬ ፋይል መፍታት አልተሳካም';

  @override
  String get failedToDeleteDevice => 'መሳሪያ መሰረዝ አልተሳካም';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'የኤስኤምኤስ ህግ መሰረዝ አልተሳካም፡ $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'ህጎችን መላክ አልተሳካም፡ $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'የኤስኤምኤስ ህጎችን መላክ አልተሳካም፡ $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'የደዋይ መታወቂያ መረጃ ማግኘት አልተሳካም፡ $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'ህጎችን ማስመጣት አልተሳካም፡ $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'የኤስኤምኤስ ህጎችን ማስመጣት አልተሳካም፡ $error';
  }

  @override
  String get failedToLoadContacts => 'ዕውቂያዎችን መጫን አልተሳካም';

  @override
  String get failedToLoadPlugin => 'ተሰኪ መጫን አልተሳካም';

  @override
  String get failedToRenameDevice => 'መሳሪያ መሰየም አልተሳካም';

  @override
  String get failedToRestoreSettings => 'ቅንብሮችን መልሰው ማግኘት አልተሳካም';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'ቅንብሮችን መልሰው ማግኘት አልተሳካም፡ $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'የይለፍ ቃል ማዘጋጀት አልተሳካም፡ $error';
  }

  @override
  String get failedToSyncDevices => 'መሳሪያዎችን ማመሳሰል አልተሳካም';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'የህግን ሁኔታ መቀየር አልተሳካም፡ $error';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'የምዝገባን ሁኔታ መቀየር አልተሳካም';

  @override
  String get failedToUpdateContact => 'ዕውቂያ ማዘመን አልተሳካም';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'የኤስኤምኤስ ህግ ማዘመን አልተሳካም፡ $error';
  }

  @override
  String get failure => 'ውድቀት';

  @override
  String get favoriteContacts => 'ተወዳጅ ዕውቂያዎች';

  @override
  String get featureAddRules => '• ለስልክ ቁጥር የተለዩ ህጎችን ያክሉ';

  @override
  String get featureCenter => 'የባህሪ ማዕከል';

  @override
  String get featureEnableDisable => '• ለእያንዳንዱ ሲም የተለያዩ ማጣሪያዎችን ያንቁ/ያሰናክሉ';

  @override
  String get featureListTitle => 'ባህሪያት:';

  @override
  String get featureManageRules => '• ለእያንዳንዱ ሲም የህግ ዝርዝሮችን ያቀናብሩ';

  @override
  String get features => 'ባህሪያት';

  @override
  String get fetchingCallerIdInfo => 'የደዋይ መታወቂያ መረጃ እየተገኘ ነው...';

  @override
  String fileSavedTo(Object path) {
    return 'ፋይል ተቀምጧል በ፡ $path';
  }

  @override
  String get filter => 'አጣራ';

  @override
  String get filterByLabel => 'በመለያ አጣራ';

  @override
  String get filterClear => 'አጣራ ሰርዝ';

  @override
  String get filterControlPanelTitle => 'የማጣሪያ መቆጣጠሪያ ፓነል';

  @override
  String get filterControlSubtitle => 'የሁሉንም ማጣሪያዎች በርቷል/አጥፏል ሁኔታን ያቀናብሩ';

  @override
  String get filterControlTitle => 'የማጣሪያ መቆጣጠሪያ';

  @override
  String get filterDeleteFailed => 'ማጣሪያ መሰረዝ አልተሳካም';

  @override
  String get filterDeleteSuccess => 'ማጣሪያው በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get filterDetails => 'የማጣሪያ ዝርዝሮች';

  @override
  String get filtered => 'ተጣርቶ';

  @override
  String get filteredSms => 'የተጣራ ኤስኤምኤስ';

  @override
  String get filteredSmsLabel => 'የተጣራ ኤስኤምኤስ';

  @override
  String get filterExplanation => 'የማጣሪያ ማብራሪያ';

  @override
  String get filterManagement => 'የማጣሪያ አስተዳደር';

  @override
  String get filterName => 'የማጣሪያ ስም';

  @override
  String get filterPattern => 'የማጣሪያ ንድፍ';

  @override
  String get filterPriorityNote =>
      'ማሳሰቢያ፡ በማጣሪያዎች መካከል የቅድሚያ ግንኙነቶች አሉ፣ ለዝርዝሮች የእርዳታ ሰነዱን ይመልከቱ';

  @override
  String get filterSaveFailed => 'ማጣሪያ ማስቀመጥ አልተሳካም';

  @override
  String get filterSaveSuccess => 'ማጣሪያው በተሳካ ሁኔታ ተቀምጧል';

  @override
  String get filterSettings => 'የማጣሪያ ቅንብሮች';

  @override
  String get filterSettingsTitle => 'የማጣሪያ ቅንብሮች';

  @override
  String get filterSMS => 'ኤስኤምኤስ ማጣራት';

  @override
  String get filterToggleInstructions => 'ለዚህ ሲም ማስገቢያ ማጣሪያዎችን አንቃ ወይም አጥፋ፡';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status ማጣሪያ፡ $filterName';
  }

  @override
  String get filterType => 'የማጣሪያ ዓይነት';

  @override
  String get financial => 'ፋይናንሺያል';

  @override
  String get flexibleCombinationFeature =>
      '• ተለዋዋጭ ውህዶች፡ በማጣሪያዎች አንቃ/አጥፋ ለእያንዳንዱ ሲም ማስገቢያ';

  @override
  String get fontSizesSetting => 'የቅርጸ-ቁምፊ መጠኖች';

  @override
  String foundRules(Object count) {
    return '$count ህግ ተገኝቷል';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count ህግ ተገኝቷል። እነሱን ማስመጣት ይፈልጋሉ?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count ህግ ተገኝቷል። እነሱን ማስመጣት ይፈልጋሉ?';
  }

  @override
  String get fraudAlert => 'የማጭበርበር ማስጠንቀቂያ - ጥሪውን ያቋርጡ';

  @override
  String get fraudScamLikely => 'የማጭበርበር ማጭበርበር ሊሆን ይችላል';

  @override
  String get free => 'ነፃ';

  @override
  String get functionSettingsTitle => 'የተግባር ቅንብሮች';

  @override
  String generalUpdateFailure(Object error) {
    return 'ዝማኔ አልተሳካም፡ $error';
  }

  @override
  String get getFree => 'ነፃ ያግኙ';

  @override
  String get github => 'ጊትሀብ';

  @override
  String get globalFilterDescription => 'ለሁሉም ሲም ካርዶች ዓለም አቀፍ ማጣሪያዎችን ያዋቅሩ፡';

  @override
  String get globalFilterFeature => '• ዓለም አቀፍ ማጣሪያዎች፡ ለሁሉም ገቢ ጥሪዎች መሰረታዊ ህጎች';

  @override
  String get globalFilterSettings => 'የአለምአቀፍ ማጣሪያ ቅንብሮች';

  @override
  String get globalFilterToggleInstructions =>
      'ለሁሉም ሲም ማስገቢያዎች የሚተገበሩትን የአለምአቀፍ ማጣሪያ ቅንብሮችን ያዋቅሩ፡';

  @override
  String get globalSearchSubtitle =>
      'እውቂያዎችን፣ መለያዎችን፣ ጥቁር ዝርዝሮችን፣ ነጭ ዝርዝሮችን፣ ወዘተ ይፈልጉ።';

  @override
  String get globalSearchTitle => 'አለምአቀፍ ፍለጋ';

  @override
  String get globalSettings => 'አለምአቀፍ ቅንብሮች';

  @override
  String get googleAdDisplayPosition => 'የጉግል ማስታወቂያ ማሳያ ቦታ';

  @override
  String get googleAdMobIntegrationText => 'የጉግል AdMob ማስታወቂያዎች እዚህ ሊዋሃዱ ይችላሉ';

  @override
  String get googleDriveAuthDescription =>
      'በስርዓት የተዋቀረ የGoogle Drive ደንበኛ መታወቂያ እና ቁልፍ በመጠቀም ፈቃድ ይስጡ';

  @override
  String get googleDriveAuthorizationHint =>
      'በስርዓት የተዋቀረ የGoogle Drive ደንበኛ መታወቂያ እና ቁልፍ በመጠቀም ፈቃድ ይስጡ';

  @override
  String get googleDriveConfigTitle => 'የGoogle Drive ውቅር';

  @override
  String get googleDriveConfigurationTitle => 'የGoogle Drive ውቅር';

  @override
  String get government => 'መንግስት';

  @override
  String get granted => 'ተሰጥቷል';

  @override
  String get grantNecessaryPermissions => 'አስፈላጊ ፈቃዶችን ይስጡ';

  @override
  String get grantPermissions => 'ፈቃዶችን ይስጡ';

  @override
  String get headhunter => 'የጭንቅላት አዳኝ';

  @override
  String get height => 'ቁመት';

  @override
  String get homePageTitle => 'የመነሻ ገጽ';

  @override
  String get homeTab => 'መነሻ';

  @override
  String get howItWorksPoint1 =>
      '• ስርዓቱ በነባሪነት በተጠቀሰው የጊዜ ገደብ ውስጥ ከሚደውሉ ቁጥሮች ጥሪዎችን በራስ-ሰር ይፈቅዳል';

  @override
  String get howItWorksPoint2 =>
      '• አጭር የጊዜ ገደቦች ጥብቅ ጣልቃገብነትን ያስከትላሉ፤ ረዘም ያለ የጊዜ ገደቦች ይበልጥ ዘና ያለ ጣልቃገብነትን ያስከትላሉ';

  @override
  String get howItWorksPoint3 => '• ስርዓቱ የተደጋገመ ጥሪ መሆኑን ለማወቅ የጥሪ ምዝግቦችን ይፈትሻል';

  @override
  String get howItWorksTitle => 'እንዴት እንደሚሰራ፡';

  @override
  String get iconCodeOptional => 'የአዶ ኮድ (አማራጭ)';

  @override
  String get iconSize => 'የአዶ መጠን';

  @override
  String get import => 'አስመጣ';

  @override
  String get important => 'አስፈላጊ';

  @override
  String get importButton => 'አስመጣ';

  @override
  String get importConfig => 'ውቅር አስመጣ';

  @override
  String get importContacts => 'እውቂያዎችን አስመጣ';

  @override
  String get importExportContacts => 'እውቂያዎችን አስመጣ/ላክ';

  @override
  String get importExportContactsTooltip => 'እውቂያዎችን አስመጣ/ላክ';

  @override
  String get importExportRules => 'ህጎችን አስመጣ/ላክ';

  @override
  String importFailed(Object error) {
    return 'አስመጣ አልተሳካም፡ $error';
  }

  @override
  String get importFailure => 'ውቅር ማስመጣት አልተሳካም';

  @override
  String get importFeatureComingSoon => 'የማስመጣት ባህሪ በቅርቡ ይመጣል';

  @override
  String get importLabels => 'መለያዎችን አስመጣ';

  @override
  String importLabelsFailed(Object error) {
    return 'መለያዎችን ማስመጣት አልተሳካም፡ $error';
  }

  @override
  String get importPluginList => 'የፕለጊን ዝርዝር አስመጣ';

  @override
  String importPluginListFailed(Object error) {
    return 'የፕለጊን ዝርዝር ማስመጣት አልተሳካም፡ $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'በተሳካ ሁኔታ $count ፕለጊን አስመጥቷል';
  }

  @override
  String get importRuleConfigurationsFromFile => 'የህግ ውቅረቶችን ከፋይል አስመጣ';

  @override
  String get importRuleConfigurationsFromFileSubtitle => 'የህግ ውቅረቶችን ከፋይል አስመጣ';

  @override
  String get importRules => 'ህጎችን አስመጣ';

  @override
  String get importRulesButton => 'ህጎችን አስመጣ';

  @override
  String get importRulesDialogTitle => 'ህጎችን አስመጣ';

  @override
  String importRulesError(Object error) {
    return 'ህጎችን ማስመጣት አልተሳካም፡ $error';
  }

  @override
  String get importRulesInstructions => 'ህጎችን ከCSV ፋይል አስመጣ';

  @override
  String get importRulesSuccess => 'ህጎች በተሳካ ሁኔታ ተመትተዋል';

  @override
  String get importRulesTitle => 'ህጎችን አስመጣ';

  @override
  String get importSuccess => 'አስመጣ በተሳካ ሁኔታ ተከናውኗል';

  @override
  String get incomingCallInterceptAction => 'ገቢ ጥሪ ጣልቃገብነት እርምጃ';

  @override
  String get incomingCallNotification => 'የገቢ ጥሪ ማሳወቂያ';

  @override
  String get incorrectPassword => 'የይለፍ ቃል የተሳሳተ ነው';

  @override
  String get initializing => 'በመጀመር ላይ';

  @override
  String get installed => 'ተጭኗል';

  @override
  String get insufficientMarks => 'በቂ ምልክቶች የሉም';

  @override
  String get insurance => 'ኢንሹራንስ';

  @override
  String get interceptAction => 'የጣልቃ ገብነት እርምጃ';

  @override
  String get interceptionActionSettingsSubtitle => 'የታገዱ ጥሪዎች እንዴት እንደሚያዙ ያዘጋጁ';

  @override
  String get interceptionActionSettingsTitle => 'የጣልቃ ገብነት እርምጃ ቅንብሮች';

  @override
  String get interceptionTimeInterval => 'የጣልቃ ገብነት የጊዜ ክፍተት';

  @override
  String get internet => 'ኢንተርኔት';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service የዝማኔ ክፍተት ወደ $days ቀናት ተቀናብሯል';
  }

  @override
  String get invalidContentRegex => 'የይዘት ሬጌክስ ትክክል አይደለም';

  @override
  String get invalidLabel => 'ትክክል ያልሆነ መለያ';

  @override
  String get invalidRegexPattern => 'ትክክል ያልሆነ የራግኤክስ ንድፍ';

  @override
  String get invalidSenderRegex => 'ትክክል ያልሆነ ላኪ ራግኤክስ';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'ለተጨማሪ መረጃ የቴሌግራም ቻናል እና ቡድን ይቀላቀሉ';

  @override
  String get jsLogsTitle => 'JS ምዝግብ ማስታወሻዎች';

  @override
  String get jsonFormat => 'JSON ቅርጸት';

  @override
  String get keepAllVersions => 'ሁሉንም ስሪቶች አስቀምጥ';

  @override
  String get keepAllVersionsDescription => 'የእያንዳንዱ ምትኬ ታሪካዊ ስሪቶች ሁሉንም ያስቀምጡ';

  @override
  String get keepAllVersionsLabel => 'ሁሉንም ስሪቶች አስቀምጥ';

  @override
  String get keepAllVersionsSubtitle => 'የእያንዳንዱ ምትኬ ታሪካዊ ስሪቶች ያስቀምጡ';

  @override
  String get keepAllVersionsTitle => 'ሁሉንም ስሪቶች አስቀምጥ';

  @override
  String get label => 'መለያ';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'መለያ \"$name\" በተሳካ ሁኔታ ታክሏል';
  }

  @override
  String get labelCategories => 'የመለያ ምድቦች';

  @override
  String get labelDeleted => 'መለያ ተሰርዟል';

  @override
  String get labelDescription =>
      'መለያዎች እውቂያዎችን በተሻለ ሁኔታ እንዲያስተዳድሩ ያግዙዎታል፣ ጥሪዎችን እና መልዕክቶችን በቀላሉ ለመለየት ለስልክ ቁጥሮች ብጁ መለያዎችን ያክሉ።';

  @override
  String get labelFilter => 'የመለያ ማጣሪያ';

  @override
  String get labelFilterTooltip => 'የመለያ ማጣሪያ';

  @override
  String get labelIconColor => 'የመለያ አዶ ቀለም';

  @override
  String get labelManagement => 'የመለያ አስተዳደር';

  @override
  String get labelNotFound => 'መለያ አልተገኘም';

  @override
  String get labelRemoved => 'መለያ ተወግዷል';

  @override
  String labelRemoveFailed(Object error) {
    return 'መለያውን ማስወገድ አልተቻለም፦ $error';
  }

  @override
  String get labels => 'መለያዎች';

  @override
  String get labelsColor => 'የመለያዎች ቀለም';

  @override
  String labelsDeleted(Object count) {
    return '$count መለያዎች ተሰርዘዋል';
  }

  @override
  String get labelsExportedSuccessfully => 'መለያዎች በተሳካ ሁኔታ ተልከዋል';

  @override
  String get labelsFontSize => 'የመለያዎች የቅርጸ-ቁምፊ መጠን';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count መለያዎች በተሳካ ሁኔታ ገብቷል';
  }

  @override
  String get labelsPosition => 'የመለያዎች ቦታ';

  @override
  String labelTag(Object labelId) {
    return 'መለያ፦ $labelId';
  }

  @override
  String get labelUpdated => 'መለያ ተዘምኗል';

  @override
  String labelUpdateFailed(Object error) {
    return 'መለያውን ማዘመን አልተቻለም፦ $error';
  }

  @override
  String get labelUpdateSuccess => 'መለያ \"\$labelText\" በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get languageSettings => 'የቋንቋ ቅንብሮች';

  @override
  String get languageSettingsSubtitle => 'የመተግበሪያ ማሳያ ቋንቋን ይቀይሩ';

  @override
  String get languageSettingsTitle => 'የቋንቋ ቅንብሮች';

  @override
  String get last30Days => 'ባለፉት 30 ቀናት';

  @override
  String get last7Days => 'ባለፉት 7 ቀናት';

  @override
  String get lastSyncLabel => 'የመጨረሻ ማመሳሰል';

  @override
  String lastUpdated(Object date) {
    return 'የመጨረሻ ማሻሻያ፦ $date';
  }

  @override
  String get lifetimeMembership => 'የዕድሜ ልክ አባልነት';

  @override
  String get lifetimeMembershipDescription =>
      'አንድ ጊዜ ክፍያ፣ ሁሉንም ፕሪሚየም ባህሪያት እና የወደፊት ዝማኔዎችን በቋሚነት ይክፈቱ';

  @override
  String loadContactsFailed(Object error) {
    return 'እውቂያዎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String get loadDataFailed => 'ውሂብ መጫን አልተቻለም';

  @override
  String get loadFailed => 'መጫን አልተቻለም';

  @override
  String get loading => 'በመጫን ላይ...';

  @override
  String get loadingData => 'ውሂብ በመጫን ላይ...';

  @override
  String get loadingTags => 'መለያዎች በመጫን ላይ...';

  @override
  String loadLabelFailed(Object error) {
    return 'መለያዎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'መለያዎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'ምልክት የተደረገባቸውን የስልክ ቁጥሮች መጫን አልተቻለም፦ $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'ምልክት የተደረገባቸውን የስልክ ቁጥሮች መጫን አልተቻለም፦ $error';
  }

  @override
  String get loadMore => 'ተጨማሪ ይጫኑ';

  @override
  String get loadPluginButton => 'ተሰኪን ይጫኑ';

  @override
  String loadPluginsFailed(Object error) {
    return 'ተሰኪዎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'ቅንብሮችን መጫን አልተቻለም፦ $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'የኤስኤምኤስ ህጎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String get loadStatusFailedMessage => 'ሁኔታ መጫን አልተቻለም';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'ምዝገባዎችን መጫን አልተቻለም፦ $error';
  }

  @override
  String get loan => 'ብድር';

  @override
  String get localBackupTitle => 'አካባቢያዊ ምትኬ';

  @override
  String get localCounterFilter => 'የአካባቢያዊ ቆጣሪ ማጣሪያ';

  @override
  String get localCounterFilterSubtitle =>
      'በጥሪ ድግግሞሽ ላይ በመመስረት የአይፈለጌ ጥሪዎችን በራስ-ሰር ያጣሩ';

  @override
  String get localCountFilter => 'የአካባቢያዊ ቆጠራ ማጣሪያ';

  @override
  String get localCountFilterDescription =>
      'በአካባቢያዊ የቁጥር ብዛት ላይ በመመስረት ተደጋጋሚ ጥሪዎችን ያቋርጡ';

  @override
  String get localCountFilterExplanationContent =>
      'የአካባቢያዊ ቆጠራ ማጣሪያ ጥሪ ታሪክ መዝገቦችን በመተንተን ተደጋጋሚ የአይፈለጌ ጥሪዎችን በራስ-ሰር ለመለየት እና ለማገድ ነው።';

  @override
  String get localCountFilterExplanationTitle => 'የአካባቢያዊ ቆጠራ ማጣሪያ ማብራሪያ';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• ሲታገድ እንደ የቁጥሩ የቆጠራ እሴት ላይ በመመስረት ውሳኔ ያድርጉ';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• የቁጥር ብዛት የተቀመጠውን ገደብ ሲያልፍ በራስ-ሰር ሊያግዱት ይችላሉ';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• ገደቡን የማያልፉ ቁጥሮችን በዘዴ መፍቀድ ይችላሉ';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• ሁሉንም የጥያቄ ምዝግብ ማስታወሻዎች የመመዝገብ ምርጫ አለዎት';

  @override
  String get localCountFiltering => 'የአካባቢያዊ ቆጠራ ማጣሪያ';

  @override
  String get localCountFilteringExplanation =>
      '• የአካባቢያዊ ቆጠራ ማጣሪያ፦ በአካባቢያዊ ምልክት ማድረጊያ ቆጠራ ላይ የተመሰረቱ የማጣሪያ ህጎች';

  @override
  String get localCountFilterSettings => 'የአካባቢያዊ ቆጠራ ማጣሪያ ቅንብሮች';

  @override
  String get localCountFilterUseCases =>
      'ይህ ማጣሪያ በተለይ አውቶ-ዳይደር የአይፈለጌ ጥሪዎች እና የግብይት ጥሪዎችን ለመለየት ተስማሚ ነው።';

  @override
  String get localFilterSettings => 'የአካባቢያዊ ማጣሪያ ቅንብሮች';

  @override
  String get localNotificationDisabled => 'አካባቢያዊ ማሳወቂያ የነቃ አይደለም';

  @override
  String get localNotificationEnabled => 'አካባቢያዊ ማሳወቂያ የነቃ ነው';

  @override
  String get localServices => 'አካባቢያዊ አገልግሎቶች';

  @override
  String get locationColor => 'የቦታ ቀለም';

  @override
  String get locationFontSize => 'የቦታ የቅርጸ-ቁምፊ መጠን';

  @override
  String get locationIconColor => 'የቦታ አዶ ቀለም';

  @override
  String get locationPosition => 'የቦታ ቦታ';

  @override
  String get logAllLocalQueries => 'ሁሉንም አካባቢያዊ ጥያቄዎች ይመዝገቡ';

  @override
  String get logAllLocalQueriesDescription =>
      'ለአካባቢያዊ ቁጥር ጥያቄዎች ሁሉ ምዝግብ ማስታወሻዎችን ይፍጠሩ';

  @override
  String get logAllRemoteQueries => 'ሁሉንም የሩቅ ጥያቄዎች ይመዝገቡ';

  @override
  String get logAllRemoteQueriesDescription => 'የሩቅ ቁጥር ጥያቄዎች ሁሉንም ክዋኔዎች ይመዝገቡ';

  @override
  String get manage => 'እውቂያዎችን ያቀናብሩ';

  @override
  String get manageContacts => 'ያቀናብሩ';

  @override
  String get manageFavoriteContacts => 'ተወዳጅ እውቂያዎችን ያቀናብሩ';

  @override
  String get manageFilterRules => 'የማጣሪያ ህጎችን ያቀናብሩ';

  @override
  String get manageFilterRulesDescription =>
      'የኤስኤምኤስ ማጣሪያ ህጎችን ያክሉ፣ ያርትዑ ወይም ይሰርዙ';

  @override
  String get manageFrequentContacts => 'ተደጋጋሚ እውቂያዎችን ያቀናብሩ';

  @override
  String get markCounts => 'የምልክት ቆጠራዎች';

  @override
  String get markCount => 'የምልክት ቆጠራ';

  @override
  String markedByCount(Object count) {
    return 'በ $count ምልክት ተደርጓል';
  }

  @override
  String get markedPhonesList => 'የተደረገባቸው የስልክ ቁጥሮች';

  @override
  String get markExchange => 'ምልክት ልውውጥ';

  @override
  String get markPhone => 'ስልክ ቁጥር ምልክት ያድርጉ';

  @override
  String markPhoneFailed(Object error) {
    return 'ስልክ ቁጥር ምልክት ማድረግ አልተሳካም፡ $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'ስልክ ቁጥሮችን ለመሰየም';

  @override
  String get markPhoneManagementTitle => 'የስልክ ቁጥር አስተዳደር ምልክት';

  @override
  String get markPhoneSuccess => 'ስልክ ቁጥር በተሳካ ሁኔታ ምልክት ተደርጓል';

  @override
  String get matchFailed => 'ግጥሚያ አልተሳካም!';

  @override
  String get matchFailedMessage => 'ግጥሚያ አልተሳካም።';

  @override
  String get matchNumbersWithSpecialCharacters => 'የተወሰነ የቁጥር ቅርጸት ይዛመዳል';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'ልዩ ቁምፊዎችን የያዙ ቁጥሮችን ያዛምዱ፡';

  @override
  String get matchSpecificDigitPatterns => 'XXX-XXXX-XXXX ቅርጸት ይዛመዳል';

  @override
  String get matchSpecificDigitPatternsTitle => 'የተወሰኑ የቁጥር ቅጦችን ያዛምዱ፡';

  @override
  String get matchSuccessful => 'ግጥሚያ ተሳክቷል!';

  @override
  String get matchSuccessfulMessage => 'ግጥሚያ ተሳክቷል።';

  @override
  String get medical => 'ሕክምና';

  @override
  String get membershipPrivileges => 'የአባልነት መብቶች';

  @override
  String get migrationTool => 'የፍልሰት መሣሪያ';

  @override
  String get migrationToolTitle => 'የፍልሰት መሣሪያ';

  @override
  String get minutes => 'ደቂቃዎች';

  @override
  String get month => 'ወር';

  @override
  String get monthly => 'በወር';

  @override
  String get monthlyCallCount => 'የወርሃዊ ጥሪዎች';

  @override
  String get monthlyChartTitle => 'የወርሃዊ የታገዱ ጥሪዎች';

  @override
  String get monthlyMembership => 'ወርሃዊ አባልነት';

  @override
  String get monthlyMembershipDescription =>
      'ሁሉንም ፕሪሚየም ባህሪያት ይክፈቱ፣ በየወሩ በራስ-ሰር ይታደሳል';

  @override
  String get monthlyTotal => 'የወርሃዊ ጠቅላላ';

  @override
  String get monthlyTotalLabel => 'የወርሃዊ ጠቅላላ';

  @override
  String get moreOptions => 'ተጨማሪ አማራጮች';

  @override
  String get mute => 'ድምጸ-ከል';

  @override
  String get name => 'ስም';

  @override
  String get nameAndPhoneNumberCannotBeEmpty => 'ስም እና የስልክ ቁጥር ባዶ ሊሆኑ አይችሉም';

  @override
  String get nameAndPhoneNumberRequired => 'ስም እና የስልክ ቁጥር ባዶ ሊሆኑ አይችሉም';

  @override
  String get nameColor => 'የስም ቀለም';

  @override
  String get nameFontSize => 'የስም ቅርጸ-ቁምፊ መጠን';

  @override
  String nameLabel(Object name) {
    return 'ስም፡ $name';
  }

  @override
  String get namePosition => 'የስም አቀማመጥ';

  @override
  String get nameUnknown => 'ስም፡ непознат';

  @override
  String nameWithValue(String name) {
    return 'ስም፡ $name';
  }

  @override
  String get newPasswordLabel => 'አዲስ የይለፍ ቃል';

  @override
  String get nextStep => 'ቀጣይ';

  @override
  String get noAction => 'ምንም እርምጃ የለም';

  @override
  String get noActionRules => 'ምንም የእርምጃ ህጎች የሉም';

  @override
  String get noActiveCloudSyncServiceMessage => 'ምንም ንቁ የደመና ማመሳሰል አገልግሎት የለም';

  @override
  String get noCallLogs => 'የጥሪ ምዝግብ ማስታወሻዎች የሉም';

  @override
  String get noCallRecords => 'የጥሪ መዝገቦች የሉም';

  @override
  String get noContacts => 'ገና እውቂያዎች የሉም';

  @override
  String get noContactsYet => 'ገና እውቂያዎች የሉም';

  @override
  String get noData => 'ምንም ውሂብ የለም';

  @override
  String get noDevicesRegisteredMessage => 'ምንም መሣሪያዎች አልተመዘገቡም';

  @override
  String get noDevicesRegisteredYet => 'ምንም መሣሪያዎች ገና አልተመዘገቡም።';

  @override
  String get noFilters => 'ማጣሪያዎች ገና የሉም';

  @override
  String get noLabels => 'መለያዎች ገና የሉም';

  @override
  String get noMarkedPhones => 'ምልክት የተደረገባቸው የስልክ ቁጥሮች የሉም';

  @override
  String get noMatchingContacts => 'የሚዛመዱ እውቂያዎች የሉም';

  @override
  String get noMatchingContactsFound => 'የሚዛመዱ እውቂያዎች አልተገኙም።';

  @override
  String get noMatchingNumbersFound => 'የሚዛመዱ ቁጥሮች አልተገኙም።';

  @override
  String get noMatchingRecords => 'የሚዛመዱ የጥሪ መዝገቦች የሉም';

  @override
  String noMatchingRules(Object ruleType) {
    return 'የሚዛመዱ $ruleType የሉም';
  }

  @override
  String get none => 'ምንም የለም';

  @override
  String get noneServiceType => 'ምንም የለም';

  @override
  String get noPlugins => 'ተሰኪዎች ገና የሉም';

  @override
  String get noRecords => 'የጥሪ መዝገቦች የሉም';

  @override
  String get noResultReturned => 'ምንም ውጤት አልተመለሰም';

  @override
  String get noResultReturnedLog => 'ከፕለጊን ምንም ውጤት አልተመለሰም';

  @override
  String noRules(Object ruleType) {
    return '$ruleType ገና የሉም';
  }

  @override
  String get noRulesPrompt => 'ምንም ህጎች አልተገኙም፣ እባክዎ ህጎችን ያክሉ';

  @override
  String get noRulesToExport => 'ለመላክ ምንም ህጎች የሉም';

  @override
  String get noSmsFilterRulesYet => 'የኤስኤምኤስ ማጣሪያ ህጎች ገና የሉም';

  @override
  String get noSmsRulesYet => 'የኤስኤምኤስ ህጎች ገና የሉም';

  @override
  String get noSubscriptions => 'ምዝገባዎች የሉም';

  @override
  String get noSubscriptionsYet => 'ምዝገባዎች ገና የሉም';

  @override
  String get notGranted => 'አልተሰጠም';

  @override
  String get notificationModeDescription => 'አስቸኳይ ጥሪ መረጃ በማስታወቂያ አሞሌ ውስጥ አሳይ';

  @override
  String get notificationPermission => 'የማሳወቂያ ፈቃድ';

  @override
  String get notificationPermissionDescription =>
      'የገቢ ጥሪ እና የመልዕክት ማሳወቂያዎችን ለማሳየት ጥቅም ላይ ይውላል።';

  @override
  String get notifications => 'ማሳወቂያዎች';

  @override
  String get notificationSettings => 'የማሳወቂያ ቅንብሮች';

  @override
  String get notificationSettingsSaved => 'የማሳወቂያ ቅንብሮች በተሳካ ሁኔታ ተቀምጠዋል';

  @override
  String get notSet => 'አልተዘጋጀም';

  @override
  String get notVerifiedText => 'አልተረጋገጠ';

  @override
  String get noValidSmsRulesFoundInFile =>
      'በፋይሉ ውስጥ ምንም ትክክለኛ የኤስኤምኤስ ህጎች አልተገኙም';

  @override
  String get number => 'ቁጥር';

  @override
  String get numberColor => 'የቁጥር ቀለም';

  @override
  String get numberFontSize => 'የቁጥር ቅርጸ-ቁምፊ መጠን';

  @override
  String get numberPosition => 'የቁጥር አቀማመጥ';

  @override
  String get numberSearch => 'የቁጥር ፍለጋ';

  @override
  String get numberTypeColor => 'የቁጥር አይነት ቀለም';

  @override
  String get numberTypeFontSize => 'የቁጥር አይነት ቅርጸ-ቁምፊ መጠን';

  @override
  String get numberTypePosition => 'የቁጥር አይነት አቀማመጥ';

  @override
  String get ok => 'እሺ';

  @override
  String get okButton => 'እሺ';

  @override
  String get onboardingCompleteDescription =>
      'የጥሪ ደህንነት አስተዳዳሪዎ ዝግጁ ነው፣ ደህንነቱ የተጠበቀ የጥሪ ተሞክሮ ይጀምሩ!';

  @override
  String get onboardingLanguageDescription => 'ለተሻለ ተሞክሮ የሚፈልጉትን ቋንቋ ይምረጡ።';

  @override
  String get onboardingPermissionsDescription =>
      'ሙሉ አገልግሎት ለመስጠት የሚከተሉትን ፈቃዶች እንፈልጋለን፡';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'የስፓም ጥሪዎችን እና መልዕክቶችን በአንድ ጠቅታ ማገድ፣ የማገድ ህጎችን ማበጀት እና ጸጥ ያለ አካባቢ መስጠት።';

  @override
  String get onboardingSmartCallerIdDescription =>
      'ያልታወቁ ጥሪዎችን በራስ-ሰር መለየት፣ አደገኛ ቁጥሮችን ምልክት ማድረግ እና የጥሪዎን ደህንነት መጠበቅ።';

  @override
  String get onboardingWelcomeDescription =>
      'የጥሪ አስተዳደር ባለሙያዎ፣ አጠቃላይ የጥሪ መታወቂያ እና የማገድ አገልግሎቶችን ይሰጣል።';

  @override
  String get oneDriveAuthDescription =>
      'በስርዓት የተዋቀረ የOneDrive ደንበኛ መታወቂያ እና ቁልፍ በመጠቀም ፍቃድ ይስጡ';

  @override
  String get oneDriveAuthorizationHint =>
      'በስርዓት የተዋቀረ የOneDrive ደንበኛ መታወቂያ እና ቁልፍ በመጠቀም ፍቃድ ይስጡ';

  @override
  String get oneDriveConfigTitle => 'OneDrive ውቅር';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive ውቅር';

  @override
  String get onlineCallerIdSubscription => 'የመስመር ላይ ጥሪ መታወቂያ ምዝገባ';

  @override
  String get openAppSettings => 'የመተግበሪያ ቅንብሮችን ይክፈቱ';

  @override
  String openAppSettingsFailed(Object error) {
    return 'የመተግበሪያ ቅንብሮችን መክፈት አልተቻለም፡ $error';
  }

  @override
  String operationFailed(Object error) {
    return 'ቀዶ ጥገናው አልተሳካም፡ $error';
  }

  @override
  String get operationFailure => 'ቀዶ ጥገናው አልተሳካም';

  @override
  String get operationSuccess => 'ቀዶ ጥገናው ተሳክቷል';

  @override
  String get other => 'ሌላ';

  @override
  String get ourOtherApps => 'የእኛ ሌሎች መተግበሪያዎች';

  @override
  String get overlayMode => 'ተንሳፋፊ መስኮት';

  @override
  String get overlayModeDescription => 'የጥሪ መረጃን በተንሳፋፊ መስኮት ያሳዩ';

  @override
  String get overlayPermission => 'ተንሳፋፊ ፈቃድ';

  @override
  String get overlayPermissionDescription => 'ለገቢ ጥሪ ተንሳፋፊ ማሳያ ጥቅም ላይ ይውላል።';

  @override
  String get overview => 'አጠቃላይ እይታ';

  @override
  String get password => 'የይለፍ ቃል';

  @override
  String get passwordCannotBeEmpty => 'የይለፍ ቃል ባዶ ሊሆን አይችልም';

  @override
  String get passwordLabel => 'የይለፍ ቃል';

  @override
  String get passwordsDoNotMatch => 'የይለፍ ቃላት አይዛመዱም';

  @override
  String get passwordSetSuccessfully => 'የይለፍ ቃሉ በተሳካ ሁኔታ ተቀናብሯል';

  @override
  String get pattern => 'አብነት';

  @override
  String get pendingSync => 'በመጠባበቅ ላይ ያለ ማመሳሰል';

  @override
  String get periodMonth => 'ወር';

  @override
  String get periodWeek => 'ሳምንት';

  @override
  String get periodYear => 'ዓመት';

  @override
  String get permissionDenied => 'ፈቃድ ጥያቄ ተከልክሏል';

  @override
  String get permissionGranted => 'ፈቃድ ተሰጥቷል';

  @override
  String get permissionManagement => 'የፈቃድ አስተዳደር';

  @override
  String get phoneCallsTab => 'ስልክ';

  @override
  String get phoneNumber => 'የስልክ ቁጥር';

  @override
  String get phoneNumberCannotBeEmpty => 'የስልክ ቁጥር ባዶ ሊሆን አይችልም';

  @override
  String get phoneNumberHintText => 'ህግ ለመጨመር የስልክ ቁጥር ያስገቡ';

  @override
  String get phoneNumberLabel => 'የስልክ ቁጥር';

  @override
  String get phoneNumberRegexRequired => 'እባክዎ የስልክ ቁጥር እና የሬጅክስ ንድፍ ያስገቡ';

  @override
  String get phoneNumberTypeFixedLine => 'የተስተካከለ መስመር';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'የተስተካከለ መስመር ወይም ተንቀሳቃሽ';

  @override
  String get phoneNumberTypeMobile => 'ተንቀሳቃሽ';

  @override
  String get phoneNumberTypePager => 'አጭር መልዕክት';

  @override
  String get phoneNumberTypePersonalNumber => 'የግል ቁጥር';

  @override
  String get phoneNumberTypePremiumRate => 'ፕሪሚየም ዋጋ';

  @override
  String get phoneNumberTypeSharedCost => 'የተጋራ ወጪ';

  @override
  String get phoneNumberTypeTollFree => 'ነፃ ጥሪ';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'ያልታወቀ';

  @override
  String get phoneNumberTypeVoicemail => 'የድምጽ መልዕክት';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'የስልክ ፈቃድ';

  @override
  String get phonePermissionDescription => 'ገቢ ጥሪዎችን ለመለየት እና ለማገድ ያገለግላል።';

  @override
  String get phoneRule => 'የስልክ ህግ';

  @override
  String get phoneRuleEditDialog => 'የስልክ ህግ ማረሚያ ንግግር';

  @override
  String get phoneRuleManagement => 'የስልክ ህግ አስተዳደር';

  @override
  String get phoneRuleSubscription => 'የስልክ ህግ ምዝገባ';

  @override
  String get phoneSubscription => 'የስልክ ምዝገባ';

  @override
  String get phoneSubscriptionRulesDescription =>
      'የነጭ እና ጥቁር መዝገብ ህጎችን በራስ-ሰር ለማዘመን ከዩአርኤል የህግ ህግ ዝርዝሮችን ይመዝገቡ። የJSONException ቅርጸት ህግ ፋይሎችን ይደግፋል።';

  @override
  String get phoneSubscriptionTitle => 'የስልክ ህግ ምዝገባዎች';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'እባክዎ መለያ ይምረጡ እና ትክክለኛውን የስልክ ቁጥር ያስገቡ';

  @override
  String pluginAddedSuccess(Object name) {
    return 'ተሰኪ \"$name\" በተሳካ ሁኔታ ተጨምሯል';
  }

  @override
  String get pluginDeleted => 'ተሰኪ ተሰርዟል';

  @override
  String get pluginLatestVersion => 'ተሰኪው ቀድሞውንም የቅርብ ጊዜው ስሪት ነው።';

  @override
  String get pluginListExportSuccess => 'የተሰኪ ዝርዝር በተሳካ ሁኔታ ተልኳል።';

  @override
  String get pluginLoadedSuccessfully => 'ተሰኪው በተሳካ ሁኔታ ተጭኗል';

  @override
  String get pluginManagement => 'የተሰኪ አስተዳደር';

  @override
  String get pluginManagementSubtitle => 'የሶስተኛ ወገን ተሰኪዎችን ያስተዳድሩ እና ያዋቅሩ';

  @override
  String get pluginManagementTitle => 'የተሰኪ አስተዳደር';

  @override
  String get pluginName => 'የተሰኪ ስም';

  @override
  String get pluginNotLoaded => 'ተሰኪው ገና አልተጫነም። እባክዎ ተሰኪውን በመጀመሪያ ይጫኑ።';

  @override
  String pluginsDeleted(Object count) {
    return '$count ተሰኪዎች በተሳካ ሁኔታ ተሰርዘዋል።';
  }

  @override
  String get pluginService => 'የተሰኪ አገልግሎት';

  @override
  String get pluginTestPageTitle => 'የተሰኪ ሙከራ';

  @override
  String get pluginUpdateSuccess => 'ተሰኪው በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get pluginUrl => 'የተሰኪ ዩአርኤል';

  @override
  String get pluginUrlCannotBeEmpty => 'የተሰኪ ዩአርኤል ባዶ ሊሆን አይችልም';

  @override
  String get pluginUrlHint => 'የተሰኪ ዩአርኤል ያስገቡ';

  @override
  String get pluginUrlLabel => 'የተሰኪ ዩአርኤል';

  @override
  String get pluginVersion => 'የተሰኪ ስሪት';

  @override
  String get political => 'ፖለቲካዊ';

  @override
  String get powerfulSpamBlocking => 'ኃይለኛ የስፓም ማገጃ';

  @override
  String get previousStep => 'ቀዳሚ';

  @override
  String get prioritizeRemoteAction => 'የርቀት እርምጃ ቅንብሮችን ቅድሚያ ይስጡ';

  @override
  String get prioritizeRemoteActionDescription =>
      'የርቀት የውሂብ ጎታ ቅንብሮችን ቅድሚያ ይስጡ';

  @override
  String get processing => 'በማስኬድ ላይ...';

  @override
  String get processingOperation => 'በማስኬድ ላይ...';

  @override
  String get purchase => 'ግዛ';

  @override
  String get quarterlyMembership => 'የሩብ ዓመት አባልነት';

  @override
  String get quarterlyMembershipDescription =>
      'ሁሉንም የፕሪሚየም ባህሪያት ይክፈቱ፣ በሩብ ዓመት በራስ-ሰር ያድሱ';

  @override
  String get queryButton => 'ጠይቅ';

  @override
  String get queryFailed => 'ጥያቄው አልተሳካም';

  @override
  String get queryFailedLog => 'ጥያቄው አልተሳካም';

  @override
  String get querying => 'በመጠየቅ ላይ...';

  @override
  String get queryingPhoneNumber => 'የስልክ ቁጥር በመጠየቅ ላይ';

  @override
  String get queryResultTitle => 'የጥያቄ ውጤት';

  @override
  String get ready => 'ዝግጁ!';

  @override
  String get receiveWeeklyStatistics => 'ሳምንታዊ ስታቲስቲክስ ይቀበሉ';

  @override
  String get recruiter => 'ቀጣሪ';

  @override
  String get reEnterPasswordHint => 'እባክዎ የይለፍ ቃሉን እንደገና ያስገቡ';

  @override
  String get refresh => 'አድስ';

  @override
  String get refreshPermissionStatus => 'የፈቃድ ሁኔታን አድስ';

  @override
  String get refreshTooltip => 'አድስ';

  @override
  String regexError(Object error) {
    return 'የሬጅክስ ስህተት፡ $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'የሬጅክስ ስህተት፡ $error';
  }

  @override
  String get regexPattern => 'የመግለጫ ንድፍ';

  @override
  String get regexPatternExplanation => 'የመግለጫ ንድፍ ማብራሪያ';

  @override
  String get regexPatternExplanationButton => 'የመግለጫ ንድፍ ማብራሪያ';

  @override
  String get regexPatternLabel => 'የመግለጫ ንድፍ';

  @override
  String get regexPatternsExamples =>
      'ደረጃውን የጠበቀ የመግለጫ ውህዶችን በመጠቀም ንድፎችን ይግለጹ። ምሳሌዎች፦';

  @override
  String get regexPatternsForPhoneNumberMatching => 'ለስልክ ቁጥር ተዛማጅ የመግለጫ ንድፎች';

  @override
  String get regexRule => 'የመግለጫ ደንብ';

  @override
  String regexRuleAddFailed(Object error) {
    return 'የመግለጫ ደንብ ለማከል አልተሳካም፦ $error';
  }

  @override
  String get regexRuleAddSuccess => 'የመግለጫ ደንብ በተሳካ ሁኔታ ተጨምሯል';

  @override
  String get regexRuleManagement => 'የመግለጫ ደንብ አስተዳደር';

  @override
  String get regexRuleNamePatternRequired =>
      'የደንቡ ስም እና የመግለጫ ንድፍ ባዶ ሊሆኑ አይችሉም';

  @override
  String get regexRules => 'የመግለጫ ህጎች';

  @override
  String get regexTesterTitle => 'የመግለጫ ሞካሪ';

  @override
  String regexValidationFailed(Object error) {
    return 'የመግለጫ ማረጋገጫ አልተሳካም፦ $error';
  }

  @override
  String get regexValidationSuccess => 'የመግለጫ ማረጋገጫ በተሳካ ሁኔታ ተጠናቋል';

  @override
  String get region => 'ክልል';

  @override
  String get registeredDevicesTitle => 'የተመዘገቡ መሣሪያዎች';

  @override
  String get rejectAllCalls => 'ሁሉንም ጥሪዎች ውድቅ አድርግ';

  @override
  String get rejectAllCallsDescription => 'ሲነቃ፣ ሁሉም ጥሪዎች በከፍተኛ ቅድሚያ ውድቅ ይደረጋሉ';

  @override
  String get rejectAllNumbers => 'ሁሉንም ቁጥሮች ውድቅ አድርግ';

  @override
  String get rejectAllNumbersDesc => 'ሲነቃ ሁሉንም ገቢ ጥሪዎች ውድቅ አድርግ';

  @override
  String get rejectExceededNumbers => 'የበለጠ ቁጥሮችን ውድቅ አድርግ';

  @override
  String get rejectExceededNumbersDescription =>
      'የቁጥሩን ገደብ የሚያልፉ ቁጥሮችን በራስ-ሰር ውድቅ አድርግ';

  @override
  String get remoteFilterSettings => 'የርቀት ማጣሪያ ቅንብሮች';

  @override
  String get remoteFilterSettingsPageTitle => 'የርቀት ቁጥር ማጣሪያ ቅንብሮች';

  @override
  String get remoteNumberFilter => 'የርቀት ቁጥር ማጣሪያ';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'ይህ ማጣሪያ የቅርብ ጊዜውን የቁጥር መረጃ ለማግኘት ገለልተኛ የርቀት የውሂብ ጎታ ይጠቀማል።';

  @override
  String get remoteNumberFilterDescription =>
      'በርቀት የውሂብ ጎታ መረጃ ላይ ተመስርተው የሚያበሳጩ ጥሪዎችን ያቁሙ';

  @override
  String get remoteNumberFilterExplanationContent =>
      'የርቀት ቁጥር ማጣሪያው በቁጥር ብዛት ላይ በመመስረት የርቀት የውሂብ ጎታውን በመጠየቅ የጽሁፍ ጥሪዎችን ይለያል እና ያግዳል።';

  @override
  String get remoteNumberFilterExplanationTitle => 'የርቀት ቁጥር ማጣሪያ ማብራሪያ';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• የቁጥር ገደብ፦ በቁጥር የመከሰት ድግግሞሽ ላይ በመመስረት ይወስኑ';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• የማጣሪያ እርምጃዎች፦ የገደቡን የሚያልፉ ቁጥሮችን እንዴት እንደሚይዙ ያዘጋጁ';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• የቅድሚያ ቅንብሮች፦ ለርቀት እርምጃዎች ቅድሚያ ያዘጋጁ';

  @override
  String get remoteNumberFilterFeatures => 'ባህሪዎች፦';

  @override
  String get remoteNumberFiltering => 'የርቀት ቁጥር ማጣሪያ';

  @override
  String get remoteNumberFilteringExplanation =>
      '• የርቀት ቁጥር ማጣሪያ፦ በማጣሪያ ላይ የተመሰረቱ የርቀት የውሂብ መረጃ';

  @override
  String get remoteNumberFilterSubtitle =>
      'የክላውድ የውሂብ ጎታ እና የማህበረሰብ ሪፖርቶችን በመጠቀም የጽሁፍ ጥሪዎችን ይለዩ';

  @override
  String get removeAdsDescription =>
      'ለስላሳ ተሞክሮ መተግበሪያውን ሁሉንም ማስታወቂያዎች በቋሚነት ያስወግዱ';

  @override
  String get removeAdsTitle => 'ማስታወቂያዎችን አስወግድ';

  @override
  String get removedFromFavoriteContacts => 'ከተወዳጅ እውቂያዎች ተወግዷል';

  @override
  String get removedFromFavorites => 'ከተወዳጆች ተወግዷል';

  @override
  String get removeFavorite => 'ተወዳጅን አስወግድ';

  @override
  String get removeFromFavorites => 'ከተወዳጆች አስወግድ';

  @override
  String get renameButton => 'ስም ቀይር';

  @override
  String get renameDeviceDialogTitle => 'መሣሪያን ስም ቀይር';

  @override
  String get renameDeviceTitle => 'መሣሪያን ስም ቀይር';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'ይህ ሁሉንም አሁን ያሉትን ቅንብሮችዎን ይተካል። ለመቀጠል እርግጠኛ ነዎት?';

  @override
  String get requestAllPermissions => 'ሁሉንም ፈቃዶች ጠይቅ';

  @override
  String get requestPermission => 'ፈቃድ ጠይቅ';

  @override
  String requestPermissionFailed(Object error) {
    return 'ፈቃድ ለመጠየቅ አልተሳካም፦ $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count ምልክቶች';
  }

  @override
  String get reset => 'ዳግም አስጀምር';

  @override
  String get restore => 'መልስ';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'የመተግበሪያ ቅንብሮችን ከመጠባቂያ መልስ';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'የመተግበሪያ ቅንብሮችን ከመጠባቂያ መልስ';

  @override
  String get restoreButton => 'መልስ';

  @override
  String restoreFailedWithError(Object error) {
    return 'ከደመና መልሶ ማቋቋም አልተሳካም፦ $error';
  }

  @override
  String get restoreFromCloud => 'ከደመና መልስ';

  @override
  String get restoreFromCloudDescription => 'ቅንብሮችን እና ህጎችን ከደመና ማከማቻ መልስ';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'ከደመና መልሶ ማቋቋም አልተሳካም፦ $error';
  }

  @override
  String get restoreFromCloudLabel => 'ከደመና መልስ';

  @override
  String get restoreFromCloudSuccess => 'ከደመና በተሳካ ሁኔታ መልሶ ተቋቋመ';

  @override
  String get restoreFromCloudTitle => 'ከደመና መልስ';

  @override
  String get restoreFromLocal => 'ከአካባቢያዊ መልስ';

  @override
  String get restorePurchases => 'ግዢዎችን መልስ';

  @override
  String get restoreSectionTitle => 'መልስ';

  @override
  String get restoreSettings => 'ቅንብሮችን መልስ';

  @override
  String get restoreSettingsConfirmation =>
      'ይህ ሁሉንም አሁን ያሉትን ቅንብሮችዎን ይተካ። ለመቀጠል እርግጠኛ ነዎት?';

  @override
  String get restoreSettingsDialogTitle => 'ቅንብሮችን መልስ';

  @override
  String get restoreSettingsTitle => 'ቅንብሮችን መልስ';

  @override
  String get restoreSuccessFromLocal => 'ከአካባቢያዊ በተሳካ ሁኔታ መልሶ ተቋቋመ';

  @override
  String get restoreSuccessMessage => 'ከደመና በተሳካ ሁኔታ መልሶ ተቋቋመ';

  @override
  String get retry => 'እንደገና ሞክር';

  @override
  String get ridesharing => 'የመኪና መጋራት';

  @override
  String get risk => 'አደጋ';

  @override
  String get robocall => 'ሮቦ ጥሪ';

  @override
  String get ruleAction => 'የደንብ እርምጃ';

  @override
  String get ruleAddButton => 'ደንብ ጨምር';

  @override
  String get ruleAddedSuccess => 'ደንብ በተሳካ ሁኔታ ተጨምሯል';

  @override
  String ruleAddFailure(Object error) {
    return 'ደንብ ለመጨመር አልተሳካም፦ $error';
  }

  @override
  String get ruleAddSuccess => 'ደንብ በተሳካ ሁኔታ ተጨምሯል';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'ይህን $ruleType መሰረዝዎን እርግጠኛ ነዎት?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'ደንብ ሰርዝ';

  @override
  String get ruleDeletedSuccess => 'ደንብ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get ruleDeletedSuccessfully => 'ደንብ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String ruleDeleteFailed(Object error) {
    return 'ደንብ ለመሰረዝ አልተሳካም፦ $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'ደንብ ለመሰረዝ አልተሳካም፦ $error';
  }

  @override
  String get ruleDeleteSuccess => 'ደንብ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String get ruleDisabledSuccessfully => 'ደንብ በተሳካ ሁኔታ ተሰናክሏል';

  @override
  String get ruleEnabledSuccessfully => 'ደንብ በተሳካ ሁኔታ ነቅቷል';

  @override
  String ruleLoadFailed(Object error) {
    return 'ህጎችን ለመጫን አልተሳካም፦ $error';
  }

  @override
  String get ruleManagement => 'የደንብ አስተዳደር';

  @override
  String get ruleManagementTitle => 'የደንብ አስተዳደር';

  @override
  String get ruleName => 'የደንብ ስም';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'የደንቡ ስም እና ይዘት መግለጫ ባዶ ሊሆኑ አይችሉም';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'የደንቡ ስም እና የስልክ ቁጥር ባዶ ሊሆኑ አይችሉም';

  @override
  String get ruleNameHint => 'ለምሳሌ የቤተሰብ፣ የጓደኞች፣ ወዘተ';

  @override
  String get ruleNameLabel => 'የደንብ ስም';

  @override
  String get ruleNamePatternRequired => 'እባክዎ የደንቡን ስም እና ንድፍ ያስገቡ';

  @override
  String get ruleNameRequired => 'የደንቡ ስም እና የስልክ ቁጥር ባዶ ሊሆኑ አይችሉም';

  @override
  String get ruleNotExist => 'ደንቡ የለም ወይም ተሰርዟል';

  @override
  String ruleNotFound(Object error) {
    return 'ደንቡ አልተገኘም፡ $error';
  }

  @override
  String get ruleSavedSuccessfully => 'ደንቡ በተሳካ ሁኔታ ተቀምጧል!';

  @override
  String get ruleSavedSuccessMessage => 'ደንቡ በተሳካ ሁኔታ ተቀምጧል!';

  @override
  String ruleSaveFailed(Object error) {
    return 'ማስቀመጥ አልተሳካም፡ $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'ማስቀመጥ አልተሳካም፡ $error';
  }

  @override
  String get ruleSaveSuccess => 'ደንቡ በተሳካ ሁኔታ ተቀምጧል!';

  @override
  String get rulesExportedSuccessfully => 'ህጎች በተሳካ ሁኔታ ተልከዋል';

  @override
  String rulesExportedTo(Object path) {
    return 'ህጎች ወደዚህ ተልከዋል፡ $path';
  }

  @override
  String get rulesImported => 'ህጎች በተሳካ ሁኔታ ገብተዋል';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count ህጎች በተሳካ ሁኔታ ገብተዋል';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'ህጎችን ማስገባት አልተቻለም፡ $error';
  }

  @override
  String get ruleStatistics => 'የህግ ስታቲስቲክስ';

  @override
  String ruleStatusChanged(Object status) {
    return 'ህጉ $status በተሳካ ሁኔታ';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'ክንዋኔው አልተሳካም፡ $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'ህጉ $status በተሳካ ሁኔታ';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'ህጉን ማዘመን አልተቻለም፡ $error';
  }

  @override
  String get ruleUpdateSuccess => 'ህጉ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get ruleVerification => 'የህግ ማረጋገጫ';

  @override
  String get save => 'አስቀምጥ';

  @override
  String get saveButton => 'አስቀምጥ';

  @override
  String get saveButtonLabel => 'አስቀምጥ';

  @override
  String get saveButtonText => 'አስቀምጥ';

  @override
  String saveFailed(Object error) {
    return 'ማስቀመጥ አልተሳካም፡ $error';
  }

  @override
  String get saveFilter => 'ማጣሪያን አስቀምጥ';

  @override
  String get saveSettings => 'ቅንብሮችን አስቀምጥ';

  @override
  String saveSettingsFailed(Object error) {
    return 'ቅንብሮችን ማስቀመጥ አልተቻለም፡ $error';
  }

  @override
  String get scamsLikely => 'ማጭበርበሮች ሊኖሩ ይችላሉ';

  @override
  String get search => 'ፈልግ';

  @override
  String get searchContacts => 'እውቂያዎችን ፈልግ';

  @override
  String searchError(Object error) {
    return 'የፍለጋ ስህተት፡ $error';
  }

  @override
  String get searchFilters => 'የፍለጋ ማጣሪያዎች';

  @override
  String get searchForContacts => 'እውቂያዎችን ፈልግ';

  @override
  String get searchHint => 'ፈልግ...';

  @override
  String get searchSettingsSubtitle =>
      'እውቂያዎችን፣ መለያዎችን፣ ጥቁር ዝርዝሮችን፣ ነጭ ዝርዝሮችን እና የመሳሰሉትን ይፈልጉ።';

  @override
  String get searchSettingsTitle => 'የፍለጋ ቅንብሮች';

  @override
  String get securityMessage =>
      'በስልክ ጥሪዎች አትመኑ። የአገልግሎት ማዕከል ቁጥሮችን ሁልጊዜ በራስዎ ያረጋግጡ። የይለፍ ቃሎችን፣ የማረጋገጫ ኮዶችን፣ የካርድ ቁጥሮችን ወይም የግል መረጃን በጭራሽ አያጋሩ።';

  @override
  String get selectActionToPerform => 'ህጉ በሚዛመድበት ጊዜ የሚከናወነውን እርምጃ ይምረጡ';

  @override
  String get selectActionWhenBlockingCalls => 'ጥሪዎችን በሚያግዱበት ጊዜ እርምጃ ይምረጡ';

  @override
  String get selectActionWhenRuleMatches => 'ህጉ በሚዛመድበት ጊዜ እርምጃ ይምረጡ';

  @override
  String get selectAll => 'ሁሉንም ምረጥ';

  @override
  String get selectCountry => 'ሀገር ምረጥ';

  @override
  String get selectDateRange => 'የቀን ወሰን ምረጥ';

  @override
  String get selectedDateRange => 'የተመረጠው የቀን ወሰን';

  @override
  String selectedItems(Object count) {
    return '$count ንጥሎች ተመርጠዋል';
  }

  @override
  String get selectedLabel => 'የተመረጠ:';

  @override
  String get selectExportFormat => 'የላኪ ቅርጸት ምረጥ';

  @override
  String get selectLabel => 'መለያ ምረጥ';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'እባክዎ መለያ ይምረጡ እና ትክክለኛ የስልክ ቁጥር ያስገቡ';

  @override
  String get selectLanguage => 'ቋንቋ ምረጥ';

  @override
  String get selectMultiple => 'ብዙ ምረጥ';

  @override
  String get selectPeriod => 'ጊዜ ይምረጡ';

  @override
  String get selectSimCard => 'የሲም ካርድ ምረጥ';

  @override
  String get selectSimSlot => 'የሲም ማስገቢያ ምረጥ';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'በታገዱ ጥሪዎች ጊዜ የሚከናወነውን የተለየ እርምጃ ይምረጡ';

  @override
  String get selectTag => 'መለያ ምረጥ';

  @override
  String get selectTags => 'መለያዎች ምረጥ';

  @override
  String get selectTrustedDataSource => 'እባክዎ የታመኑ የውሂብ ምንጮችን ይምረጡ';

  @override
  String get selectYourLanguage => 'ቋንቋዎን ይምረጡ';

  @override
  String get sender => 'ላኪ';

  @override
  String get senderRegexOptional => 'የላኪ ሬጉለር ኤክስፕሬሽን (አማራጭ)';

  @override
  String get serverAddressLabel => 'የአገልጋይ አድራሻ';

  @override
  String get serviceTypeContact => 'የእውቂያ ምዝገባ';

  @override
  String get serviceTypeLabel => 'የአገልግሎት ዓይነት';

  @override
  String get serviceTypePhone => 'የስልክ ምዝገባ';

  @override
  String get serviceTypePlugin => 'የፕለጊን ዝመና';

  @override
  String get serviceTypeSms => 'የኤስኤምኤስ ምዝገባ';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'አዘጋጅ';

  @override
  String get setEncryptionPassword => 'የምስጠራ የይለፍ ቃል አዘጋጅ';

  @override
  String get setEncryptionPasswordDescription =>
      'ለማስቀመጥ እና መልሶ ለማግኘት የምስጠራ የይለፍ ቃል ያዘጋጁ';

  @override
  String get setEncryptionPasswordLabel => 'የምስጠራ የይለፍ ቃል አዘጋጅ';

  @override
  String get setEncryptionPasswordTitle => 'የምስጠራ የይለፍ ቃል አዘጋጅ';

  @override
  String get setPasswordButton => 'አዘጋጅ';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String settingsBackedUpTo(Object path) {
    return 'ቅንብሮች እዚህ ተቀምጠዋል፡ $path';
  }

  @override
  String get settingsLoaded => 'ቅንብሮች ተጭነዋል';

  @override
  String settingsLoadFailed(Object error) {
    return 'ቅንብሮችን መጫን አልተቻለም፡ $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'ቅንብሮች በተሳካ ሁኔታ መልሰዋል። ለውጦቹ እንዲተገበሩ እባክዎ መተግበሪያውን እንደገና ያስጀምሩ።';

  @override
  String get settingsSaved => 'ቅንብሮች ተቀምጠዋል';

  @override
  String settingsSaveFailed(Object error) {
    return 'ቅንብሮችን ማስቀመጥ አልተቻለም፡ $error';
  }

  @override
  String get settingsTab => 'ቅንብሮች';

  @override
  String get settingsTitle => 'ቅንብሮች';

  @override
  String get setup => 'ማዋቀር';

  @override
  String get showContactEditDialogStaticMethod =>
      'የእውቂያ አርትዕ የንግግር ሳጥን ለማሳየት የማይንቀሳቀስ ዘዴ';

  @override
  String get showExplanation => 'ማብራሪያ አሳይ';

  @override
  String get silence => 'ዝምታ';

  @override
  String get silenceAndNoAnswer => 'ዝምታ እና መልስ የለም';

  @override
  String get silenceNoAnswer => 'ዝምታ መልስ የለም';

  @override
  String get silentCallVoiceClone => 'የዝምታ ጥሪ የድምጽ ክሎን';

  @override
  String get silentRules => 'የዝምታ ህጎች';

  @override
  String simCard(Object simNumber) {
    return 'የሲም ካርድ $simNumber';
  }

  @override
  String get simCardColor => 'የሲም ካርድ ቀለም';

  @override
  String get simCardConfigurationExplanation =>
      '• የሲም ካርድ ማዋቀር፡ ለእያንዳንዱ ሲም ካርድ ገለልተኛ የማጣሪያ ህጎችን ያዘጋጁ';

  @override
  String get simCardFilterRules => 'የሲም ካርድ ማጣሪያ ህጎች';

  @override
  String get simCardFilterRulesDescription =>
      'በሲም ካርድ ማስገቢያዎች ላይ በመመስረት የተለያዩ የማጣሪያ ህጎችን ያዘጋጁ';

  @override
  String get simCardFontSize => 'የሲም ካርድ ቅርጸ-ቁምፊ መጠን';

  @override
  String get simCardPosition => 'የሲም ካርድ ቦታ';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'ሲም $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'የሲም ካርድ መረጃ መጫን አልተቻለም፡ $error';
  }

  @override
  String get simRuleInstructions =>
      'የSIM ማስገቢያ ደንቦች ለእያንዳንዱ የSIM ማስገቢያ የነጻ ማጣሪያ ደንቦችን እንዲያዘጋጁ ያስችሉዎታል።';

  @override
  String get simRuleInstructionsTitle => 'የSIM ማስገቢያ ደንቦች';

  @override
  String get simRuleManagement => 'የSIM ማስገቢያ የደንብ አስተዳደር';

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
    return 'የSIM መረጃ መጫን አልተሳካም፡ $error';
  }

  @override
  String get simSlotFilterConfiguration => 'የSIM ማስገቢያ ማጣሪያ ውቅር';

  @override
  String get simSlotFilterConfigurationDescription =>
      'በSIM ማስገቢያ ማጣሪያ ደንቦችን እንዲያዘጋጁ ያስችላል';

  @override
  String get simSlotFilterDescription => 'ለእያንዳንዱ SIM ካርድ ነጻ ማጣሪያ ደንቦችን ያዘጋጁ፡';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'የSIM ማስገቢያ $slotNumber ማጣሪያ ቅንብሮች';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'የSIM ማስገቢያዎች መጫን አልተሳካም፡ $error';
  }

  @override
  String get simSlotManagement => 'የSIM ማስገቢያ አስተዳደር';

  @override
  String simSlotOperationFailed(Object error) {
    return 'የSIM ማስገቢያ ክወና አልተሳካም፡ $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'የSIM ማስገቢያ ቦታ $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• የSIM ማስገቢያ ደንቦች፡ ለእያንዳንዱ SIM ነጻ የማጣሪያ ስልቶች';

  @override
  String get simSlotRuleListTitle => 'የSIM ማስገቢያ የደንቦች ዝርዝር';

  @override
  String get simSlotRuleManagement => 'የSIM ማስገቢያ ደንቦች';

  @override
  String get simSlotRuleManagementTitle => 'የደንብ አስተዳደር';

  @override
  String get simSlotSettings => 'የSIM ማስገቢያ ቅንብሮች';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM ማስገቢያ $slotNumber';
  }

  @override
  String get skip => 'ዝለል';

  @override
  String get smartCallerId => 'ብልጥ የደዋይ መታወቂያ';

  @override
  String get sms => 'ኤስኤምኤስ';

  @override
  String get smsFilterDescription =>
      'የኤስኤምኤስ ማጣሪያ አይፈለጌ መልዕክቶችን በራስ-ሰር እንዲያጣሩ እና የመልዕክት ዝርዝርዎን ንጹህ እንዲሆን ይረዳዎታል። የማጣሪያ ደንቦችን እና የማሳወቂያ ዘዴዎችን ማዘጋጀት ይችላሉ።';

  @override
  String get smsFilterDisabled => 'የኤስኤምኤስ ማጣሪያ ተሰናክሏል';

  @override
  String get smsFilterEnabled => 'የኤስኤምኤስ ማጣሪያ ነቅቷል';

  @override
  String get smsFilterRuleAddedSuccessfully => 'የኤስኤምኤስ ማጣሪያ ደንብ በተሳካ ሁኔታ ታክሏል';

  @override
  String get smsFilterRules => 'የኤስኤምኤስ ማጣሪያ ደንቦች';

  @override
  String get smsFilterSettings => 'የኤስኤምኤስ ማጣሪያ ቅንብሮች';

  @override
  String get smsHistory => 'የኤስኤምኤስ ታሪክ';

  @override
  String get smsManagement => 'የኤስኤምኤስ አስተዳደር';

  @override
  String get smsPermission => 'የኤስኤምኤስ ፈቃድ';

  @override
  String get smsPermissionDescription => 'አይፈለጌ መልዕክቶችን ለማጣራት ጥቅም ላይ ይውላል።';

  @override
  String get smsRuleAddedSuccessfully => 'የኤስኤምኤስ ደንብ በተሳካ ሁኔታ ታክሏል';

  @override
  String get smsRuleDeletedSuccessfully => 'የኤስኤምኤስ ደንብ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'የኤስኤምኤስ ደንቦች መጫን አልተሳካም፡ $error';
  }

  @override
  String get smsRuleManagement => 'የኤስኤምኤስ የደንብ አስተዳደር';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'የኤስኤምኤስ ደንቦች በተሳካ ሁኔታ ወደ $filePath ተልከዋል';
  }

  @override
  String get smsRulesImportedSuccessfully => 'የኤስኤምኤስ ደንቦች በተሳካ ሁኔታ ገብተዋል';

  @override
  String get smsRuleSubscription => 'የኤስኤምኤስ የደንብ ምዝገባ';

  @override
  String get smsRuleUpdatedSuccessfully => 'የኤስኤምኤስ ደንብ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get smsSettingsSubtitle => 'የኤስኤምኤስ ማጣሪያ እና የቁልፍ ቃል እገዳ';

  @override
  String get smsSettingsTitle => 'የኤስኤምኤስ ቅንብሮች';

  @override
  String get smsSubscription => 'የኤስኤምኤስ ምዝገባ';

  @override
  String get smsSubscriptionAddedSuccessfully => 'የኤስኤምኤስ ምዝገባ በተሳካ ሁኔታ ታክሏል';

  @override
  String get smsSubscriptionRulesDescription =>
      'የኤስኤምኤስ የደንብ ዝርዝሮችን በURL ይግቡ፣ መደበኛውን የቁጥር ግጥሚያ ይደግፋል። የማገድ ወይም የመፍቀድ እርምጃዎችን ማዘጋጀት ይችላሉ።';

  @override
  String get smsTab => 'ኤስኤምኤስ';

  @override
  String get somePermissionsDenied => 'አንዳንድ የፍቃድ ጥያቄዎች ተከልክለዋል';

  @override
  String get spamLikely => 'አይፈለጌ መልዕክት ሊሆን ይችላል';

  @override
  String get startColor => 'የመነሻ ቀለም';

  @override
  String get startDate => 'የመነሻ ቀን';

  @override
  String get startUsing => 'ጀምር';

  @override
  String get statAnswered => 'መልስ የተሰጠባቸው';

  @override
  String get statBlocked => 'የታገዱ';

  @override
  String get staticMethodShowCallerIdDialog =>
      'የደዋይ መታወቂያ መረጃ ማሳያ መገናኛን ለማሳየት የማይንቀሳቀስ ዘዴ';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'የሀገር ምርጫ መገናኛን ለማሳየት የማይንቀሳቀስ ዘዴ';

  @override
  String get staticMethodToDisplayDialog => 'መገናኛን ለማሳየት የማይንቀሳቀስ ዘዴ';

  @override
  String get statistics => 'ስታቲስቲክስ';

  @override
  String get statisticsExportFeatureComingSoon => 'የስታቲስቲክስ መላክ ባህሪ በቅርቡ ይመጣል';

  @override
  String get statisticsGrid => 'የስታቲስቲክስ ፍርግርግ';

  @override
  String get statisticsPageTitle => 'የውሂብ ትንታኔ';

  @override
  String get stirColor => 'STIR ቀለም';

  @override
  String get stirFontSize => 'STIR የቅርጸ-ቁጥር መጠን';

  @override
  String get stirPosition => 'STIR ቦታ';

  @override
  String get storagePermission => 'የማከማቻ ፈቃድ';

  @override
  String get storagePermissionDescription =>
      'ቅንብሮችን እና ደንቦችን ለማስቀመጥ ጥቅም ላይ ይውላል።';

  @override
  String get subscribe => 'ይመዝገቡ';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'ምዝገባ \"$name\" በተሳካ ሁኔታ ታክሏል';
  }

  @override
  String get subscriptionDeleteConfirmContent => 'ይህን ምዝገባ ለመሰረዝ እርግጠኛ ነዎት?';

  @override
  String get subscriptionDeleteConfirmTitle => 'ምዝገባን ሰርዝ';

  @override
  String get subscriptionDeleted => 'ምዝገባ ተሰርዟል';

  @override
  String get subscriptionDeletedSuccessfully => 'ምዝገባ በተሳካ ሁኔታ ተሰርዟል';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'ምዝገባን መሰረዝ አልተሳካም፡ $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'ምዝገባ ተሰርዟል';

  @override
  String get subscriptionEmptyState => 'ምዝገባዎች የሉም';

  @override
  String get subscriptionEmptyText => 'ምዝገባዎች ገና የሉም';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'ምዝገባዎች መጫን አልተሳካም፡ $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'ምዝገባዎች መጫን አልተሳካም፡ $error';
  }

  @override
  String get subscriptionManagementTitle => 'የምዝገባ አስተዳደር';

  @override
  String get subscriptionName => 'የምዝገባ ስም';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'የምዝገባ ስም እና URL ባዶ ሊሆኑ አይችሉም';

  @override
  String get subscriptionNameHint => 'የምዝገባ ስም ያስገቡ';

  @override
  String get subscriptionPageTitle => 'የምዝገባ አስተዳደር';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'የምዝገባ ሁኔታን መቀየር አልተሳካም፡ $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'የምዝገባ ሁኔታን መቀየር አልተሳካም፡ $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'ምዝገባን ማዘመን አልተሳካም፡ $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'ምዝገባ በተሳካ ሁኔታ ተዘምኗል';

  @override
  String get subscriptionUrl => 'የምዝገባ URL';

  @override
  String get subscriptionUrlHint => 'የምዝገባ URL ያስገቡ';

  @override
  String successfullyImportedRules(Object count) {
    return 'በተሳካ ሁኔታ $count ደንቦች ገብተዋል';
  }

  @override
  String get supportSync => 'ማመሳሰልን ይደግፉ';

  @override
  String get survey => 'ዳሰሳ ጥናት';

  @override
  String get syncDevicesButton => 'መሣሪያዎችን አመሳስል';

  @override
  String get syncFailed => 'ማመሳሰል አልተሳካም';

  @override
  String get syncFailedMessage => 'ማመሳሰል አልተሳካም';

  @override
  String get syncFolderNameHint =>
      'እባክዎ የማመሳሰል አቃፊ ስም ያስገቡ (ነባሪ፡ NotificationManager)';

  @override
  String get syncFolderNameLabel => 'የማመሳሰል አቃፊ ስም';

  @override
  String get synchronized => 'ተመሳስሏል';

  @override
  String get syncing => 'በማመሳሰል ላይ...';

  @override
  String get syncNow => 'አሁን አመሳስል';

  @override
  String get syncNowButton => 'አሁን አመሳስል';

  @override
  String get syncStatusTitle => 'የማመሳሰል ሁኔታ';

  @override
  String get syncStatusUpdatedMessage => 'የማመሳሰል ሁኔታ ተዘምኗል';

  @override
  String get syncSuccessful => 'ማመሳሰል ተሳክቷል';

  @override
  String get syncSuccessMessage => 'ማመሳሰል ተሳክቷል';

  @override
  String get syncWithCloudStorage => 'ከደመና ማከማቻ ጋር አመሳስል';

  @override
  String get syncWithCloudStorageSubtitle => 'ከደመና ማከማቻ ጋር አመሳስል';

  @override
  String get systemFeatures => 'የስርዓት ባህሪዎች:';

  @override
  String get systemSettingsTitle => 'የስርዓት ቅንብሮች';

  @override
  String get tabAll => 'ሁሉም';

  @override
  String get tabAnswered => 'ምላሽ የተሰጠባቸው';

  @override
  String get tabBlocked => 'የተከለከሉ';

  @override
  String get tabMissed => 'ያመለጡ';

  @override
  String get tabOutgoing => 'የወጪ ጥሪዎች';

  @override
  String tagLabel(String tag) {
    return 'መለያ: $tag';
  }

  @override
  String get tagsUpdated => 'መለያዎች ተዘምነዋል';

  @override
  String get takeaway => 'ማጠቃለያ';

  @override
  String get telecommunication => 'የቴሌኮሙኒኬሽን';

  @override
  String get telegram => 'ቴሌግራም';

  @override
  String get telemarketing => 'የቴሌማርኬቲንግ';

  @override
  String get testButton => 'ሙከራ';

  @override
  String get testButtonLabel => 'ሙከራ';

  @override
  String get testConnectionButton => 'ግንኙነትን ፈትሽ';

  @override
  String get textColorsSetting => 'የጽሑፍ እና የመለያ ቀለሞች';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'ይህ መተግበሪያ ኃይለኛ የጥሪ መታወቂያ መሣሪያ ሲሆን ያልተፈለጉ ጥሪዎችን ለመለየት እና ለመከልከል ያስችልዎታል።';

  @override
  String get thisWeek => 'ይህ ሳምንት';

  @override
  String get timeInterceptor => 'የጊዜ ጣልቃ ገብ';

  @override
  String get timeInterceptorDescription =>
      'በጥሪ ድግግሞሽ ላይ በመመስረት እምብዛም ጥሪዎችን በራስ-ሰር ይጥለፍ/ይፍቀድ';

  @override
  String get timeInterceptorExplanation =>
      '• የጊዜ ጣልቃ ገብ: በተደጋጋሚ የሚደወሉ ጥሪዎችን በአጭር ጊዜ ይጥለፍ/ይፍቀድ';

  @override
  String get timeInterceptorExplanationContent =>
      'የጥሪ ድግግሞሽ ጣልቃ ገብ ባህሪው ተደጋጋሚ አይፈለጌ ጥሪዎችን በራስ-ሰር ለመለየት እና ለመጥለፍ/ለመፍቀድ የጥሪ ድግግሞሹን ይተነትናል።';

  @override
  String get timeInterceptorExplanationTitle => 'የጥሪ ድግግሞሽ ጣልቃ ገብ ማብራሪያ';

  @override
  String get timeInterceptorSettingsTitle => 'የጥሪ ድግግሞሽ ጣልቃ ገብ ቅንብሮች';

  @override
  String get timeInterceptorSubtitle =>
      'በጥሪ ድግግሞሽ ላይ በመመስረት እምብዛም አይፈለጌ ጥሪዎችን በራስ-ሰር ይጥለፍ';

  @override
  String get timeInterceptorTitle => 'የጥሪ ድግግሞሽ ጣልቃ ገብን አንቃ';

  @override
  String get timeWindowDescription =>
      'ለተደጋጋሚ ጥሪዎች የሚፈቀደውን የጊዜ መስኮት መጠን ያዘጋጁ። በዚህ መስኮት ውስጥ ካሉ ተመሳሳይ ቁጥር የተደረጉ ጥሪዎች ይፈቀዳሉ።';

  @override
  String timeWindowLabel(int minutes) {
    return 'የጣልቃ ገብ ጊዜ መስኮት (ደቂቃዎች): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'ለተደጋጋሚ ጥሪዎች የሚፈቀደውን የጊዜ መስኮት መጠን ያዘጋጁ። በዚህ መስኮት ውስጥ ካሉ ተመሳሳይ ቁጥር የተደረጉ ጥሪዎች ይፈቀዳሉ።';

  @override
  String get today => 'ዛሬ';

  @override
  String get total => 'አጠቃላይ';

  @override
  String get totalBlocked => 'ጠቅላላ የተከለከሉ';

  @override
  String get totalFiltered => 'ጠቅላላ የተጣሩ';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'በመሣሪያዎች ወይም መድረኮች መካከል ውሂብ ያስተላልፉ';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'በመሣሪያዎች ወይም መድረኮች መካከል ውሂብ ያስተላልፉ';

  @override
  String get travelTicketing => 'የጉዞ ትኬት';

  @override
  String get trend => 'አዝማሚያ';

  @override
  String get trendChart => 'የአዝማሚያ ገበታ';

  @override
  String get tutorial => 'አጋዥ ስልጠና';

  @override
  String get type => 'አይነት';

  @override
  String get unassignedSIMCard => 'ያልተመደበ SIM ካርድ';

  @override
  String get unknown => 'ያልታወቀ';

  @override
  String get unknownLabel => 'ያልታወቀ መለያ';

  @override
  String get unknownTag => 'መለያ: ያልታወቀ';

  @override
  String get unregisterButton => 'ምዝገባ ስርዝ';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '$deviceName ማሰናከልዎን እርግጠኛ ነዎት?';
  }

  @override
  String get unregisterDeviceTitle => 'መሣሪያን አሰናክል';

  @override
  String get unsupportedFileFormat => 'የማይደገፍ የፋይል ቅርጸት';

  @override
  String get update => 'አዘምን';

  @override
  String get updateAllNow => 'ሁሉንም አሁን አዘምን';

  @override
  String get updateCallFilterConfig => 'የጥሪ ማጣሪያ ውቅር አዘምን';

  @override
  String updateContactFailed(Object error) {
    return 'ዕውቂያን ማዘመን አልተሳካም: $error';
  }

  @override
  String get updateFavoriteStatus => 'ተወዳጅ ሁኔታን አዘምን';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'ተወዳጅ ሁኔታን ማዘመን አልተሳካም: $error';
  }

  @override
  String get updateInterval => 'የማዘመኛ ክፍተት';

  @override
  String get updateLabelFailed => 'መለያን ማዘመን አልተሳካም';

  @override
  String get updateNow => 'አሁን አዘምን';

  @override
  String get updatePlugin => 'ተሰኪን አዘምን';

  @override
  String updatePluginFailed(Object error) {
    return 'ተሰኪን ማዘመን አልተሳካም: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'ደንብ ማዘመን አልተሳካም: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'ምዝገባ ማዘመን አልተሳካም: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service በተሳካ ሁኔታ ተዘምኗል ($count ህጎች)';
  }

  @override
  String get updateTags => 'መለያዎችን አዘምን';

  @override
  String get useCasesPoint1 => '• ራስ-ሰርድ የውሸት ጥሪዎችን ይለዩ';

  @override
  String get useCasesPoint2 => '• በአጭር ጊዜ ውስጥ ብዙ ጊዜ የሚደውሉ የማስታወቂያ ጥሪዎችን ይጥለፍ';

  @override
  String get useCasesPoint3 => '• የልብ ምት ጥሪ እና አድባሪነትን ይከላከሉ';

  @override
  String get useCasesTitle => 'የአጠቃቀም ሁኔታዎች:';

  @override
  String get useGlobalSettings => 'አለምአቀፍ ቅንብሮችን ይጠቀሙ';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'የተጠቃሚ ስም';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'ቅጦችን ለመግለጽ መደበኛ የ regex ሰዋስውን ይጠቀሙ። ምሳሌዎች:';

  @override
  String get validateRegex => 'Regex ን አረጋግጥ';

  @override
  String get verificationFailedText => 'አልተሳካም';

  @override
  String get verifiedText => 'ተረጋግጧል';

  @override
  String get verify => 'አረጋግጥ';

  @override
  String version(Object version) {
    return 'ስሪት: $version';
  }

  @override
  String get vipExchangeDescription =>
      'የቪአይፒ አባልነትን በስልክ ቁጥር የመመዝገቢያ ቆጠራ ይለዋወጡ';

  @override
  String get vipExchangeTitle => 'ቪአይፒ ይለዋወጡ';

  @override
  String get watchAd => 'ማስታወቂያ ተመልከት';

  @override
  String get watchAdForTemp => 'ለጊዜያዊ መብቶች ማስታወቂያ ተመልከት';

  @override
  String get watchAdForTempDescription =>
      'ፕሪሚየም ባህሪያትን ለጊዜው ለመክፈት አጭር ማስታወቂያ ይመልከቱ';

  @override
  String get webDAVConfigTitle => 'WebDAV ውቅር';

  @override
  String get webdavConfigurationTitle => 'WebDAV ውቅር';

  @override
  String get webdavPasswordHint => 'እባክዎ WebDAV የይለፍ ቃል ያስገቡ';

  @override
  String get webdavServerAddressHint => 'እባክዎ WebDAV አገልጋይ አድራሻ ያስገቡ';

  @override
  String get webdavUsernameHint => 'እባክዎ WebDAV የተጠቃሚ ስም ያስገቡ';

  @override
  String get week => 'ሳምንት';

  @override
  String get weekly => 'በየሳምንቱ';

  @override
  String get weeklyBlockedCallsSummary => 'በየሳምንቱ የተከለከሉ ጥሪዎች ማጠቃለያ';

  @override
  String get weeklyChartTitle => 'በየሳምንቱ የተከለከሉ ጥሪዎች';

  @override
  String get weeklyReport => 'በየሳምንቱ ሪፖርት';

  @override
  String get weeklyReportDesc => 'የጥሪ መከልከል እንቅስቃሴ የሳምንታዊ ማጠቃለያ ሪፖርት ይቀበሉ';

  @override
  String get welcome => 'እንኳን ደህና መጡ';

  @override
  String get whitelist => 'ነጭ ዝርዝር';

  @override
  String get whitelistLabel => 'ነጭ ዝርዝር';

  @override
  String get width => 'ስፋት';

  @override
  String get wildcardMatchingDescription =>
      'ማንኛውንም ቁምፊ ለመምሰል \'.\' ይጠቀሙ (ለምሳሌ \'123.456\' 123-456ን ይገጥማል)';

  @override
  String get wildcardMatchingTitle => 'ዱርዬ ግጥሚያ:';

  @override
  String get wildcardSupportForFlexibleFiltering => 'ለተለዋዋጭ ማጣሪያ የዱርዬ ድጋፍ';

  @override
  String get windowSizeSetting => 'የመስኮት መጠን';

  @override
  String get year => 'ዓመት';

  @override
  String get yearly => 'በየዓመቱ';

  @override
  String get yearlyChartTitle => 'በየዓመቱ የታገዱ ጥሪዎች';

  @override
  String get noSimCardsDetected => 'የሲም ካርዶች አልተገኙም';

  @override
  String get filterManagementDescription => 'የጥሪ ማጣሪያዎችን ያዘጋጁ';

  @override
  String get callerIdCustomizationSubtitle => 'የደዋዩን መታወቂያ አቀማመጥ ያብጁ';

  @override
  String get fraudAlerSettingTitle => 'የማጭበርበር ማስጠንቀቂያ ቅንብር';

  @override
  String get fraudAlerSettingSubtitle => 'ለማጭበርበር ማስጠንቀቂያ ለማዘጋጀት';

  @override
  String get enableFraudAlert => 'ማጭበርበር አስጠንቅቅ';

  @override
  String get enableFraudAlertDescription => 'ለተጠረጠሩ የማጭበርበር ጥሪዎች አስጠንቅቅ';

  @override
  String get enableVibration => 'ንዝረትን አንቃ';

  @override
  String get enableVibrationDescription => 'ጥሪው የተጠረጠረ የማጭበርበር ጥሪ ከሆነ ይንቀጠቀጡ';

  @override
  String get notificationSettingsTitle => 'የማሳወቂያ ቅንብሮች';

  @override
  String get useLocalNotification => 'አካባቢያዊ ማሳወቂያዎችን ተጠቀም';

  @override
  String get useLocalNotificationDescription => 'ለገቢ ጥሪዎች የአካባቢ ማሳወቂያዎችን ያንቁ';

  @override
  String get cancelLocalNotification => 'የአካባቢ ማሳወቂያዎችን ዝጋ';

  @override
  String get useStirNotification => 'ከSTIR ማሳወቂያ ተጠቀም';

  @override
  String get useStirNotificationDescription => 'ለገቢ ጥሪዎች የSTIR ማሳወቂያዎችን ያንቁ';

  @override
  String get cancelLocalNotificationDescription => 'የአካባቢ ማሳወቂያዎችን በራስ-ሰር ዝጋ';

  @override
  String get callerIdSettingsTitle => 'የደዋዩ መታወቂያ ቅንብሮች';

  @override
  String get callerIdSettingsSubtitle => 'ለገቢ ጥሪ ማሳወቂያ እና የማሳያ ሁነታ ለማዘጋጀት';

  @override
  String get purchaseTitle => 'ግዛ';

  @override
  String get purchaseSubtitle => 'አገልግሎቱን ለመግዛት';

  @override
  String get callerIdNotificationTitle => 'ገቢ የጥሪ መረጃ';

  @override
  String callerIdBody(String phoneNumber) {
    return 'ቁጥር: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'የታገደ ጥሪ';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'ከ $phoneNumber የተከለከለ ጥሪ';
  }

  @override
  String get stirVerified => 'ተረጋግጧል';

  @override
  String get stirNotVerified => 'አልተረጋገጠም';

  @override
  String get stirFailed => 'ማረጋገጥ አልተሳካም';

  @override
  String get stirUnknown => 'የማረጋገጫ ሁኔታ ያልታወቀ';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN ማረጋገጥ';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return 'ለቁጥር $phoneNumber $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings => 'የሚሽከረከሩ የደህንነት መልዕክት ቅንብሮች';

  @override
  String get messageColor => 'የመልዕክት ቀለም';

  @override
  String get messageFontSize => 'የመልዕክት ቅርጸ-ቁምፊ መጠን';

  @override
  String get messagePosition => 'የመልዕክት ቦታ';

  @override
  String get containerWidth => 'የመያዣ ስፋት';

  @override
  String get scrollSpeed => 'የማሸብለል ፍጥነት';

  @override
  String get enableSecurityMessage => 'የደህንነት መልዕክት አንቃ';

  @override
  String get fraudAlertTitle => 'የማጭበርበር ማስጠንቀቂያ';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'ከ $phoneNumber ሊሆን የሚችል የማጭበርበር ጥሪ';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'ደንቦችን መጫን አልተሳካም: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'የጥሪ ምዝግብ ማስታወሻ መጫን አልተሳካም: $error';
  }

  @override
  String get noBlockedTypeData => 'የታገዱ የውሂብ አይነቶች የሉም';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeName አስመጣ';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName በተሳካ ሁኔታ ገብቷል, ጠቅላላ $count መዝገቦች ገብተዋል';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName ማስመጣት አልተሳካም: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeName ላክ';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName በተሳካ ሁኔታ ተልኳል';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName መላክ አልተሳካም: $error';
  }

  @override
  String get cloudSyncService => 'የደመና ማመሳሰል አገልግሎት';

  @override
  String get membershipCenter => 'የአባልነት ማዕከል';

  @override
  String get redeemVipWithMarks => 'VIP በምልክቶች አስመልስ';

  @override
  String get currentMarkCount => 'የአሁኑ የመልዕክቶች ብዛት';

  @override
  String get markMoreNumbersForMore => 'ለተጨማሪ ምልክቶች ብዙ ቁጥሮችን ምልክት ያድርጉ';

  @override
  String get noAds => 'ማስታወቂያ የለም';

  @override
  String get cloudBackup => 'የደመና ምትኬ';

  @override
  String get callerIdEnhancement => 'የደዋዩ መታወቂያ ማሻሻል';

  @override
  String get voiceRecognition => 'የድምፅ ማወቂያ';

  @override
  String get feature => 'ባህሪ';

  @override
  String get normalUser => 'መደበኛ ተጠቃሚ';

  @override
  String get vipUser => 'VIP ተጠቃሚ';

  @override
  String get temporaryVip => 'ጊዜያዊ VIP';

  @override
  String get removeAds => 'ማስታወቂያዎችን አስወግድ';

  @override
  String get unknownAction => 'ያልታወቀ ድርጊት';

  @override
  String get settingsBackup => 'ቅንብሮች ምትኬ ';

  @override
  String get allServicesStatusTitle => 'የአሁኑ የአገልግሎት ሁኔታ';

  @override
  String get allServicesStatusSubtitle => 'የእያንዳንዱ የደመና አገልግሎት የአሁኑ ሁኔታ';

  @override
  String get redirect => 'አስቀይር';

  @override
  String get notify => 'አሳውቅ';

  @override
  String get log => 'መዝግብ';

  @override
  String get custom => 'ብጁ';

  @override
  String get allowActionDescription => 'ጥሪዎች ይፈቀዳሉ, ቁጥሩ በብሎክ ዝርዝር ውስጥ ቢሆንም.';

  @override
  String get blockActionDescription =>
      'ጥሪዎች ይከለከላሉ እናም በጥሪ ምዝግብ ማስታወሻ ውስጥ ይታያሉ።';

  @override
  String get silenceActionDescription =>
      'ጥሪዎች ዝም ይላሉ ነገር ግን በጥሪ ምዝግብ ማስታወሻ ውስጥ ይታያሉ።';

  @override
  String get noneActionDescription => 'ለጥሪው ምንም ልዩ እርምጃ አይወሰድም።';

  @override
  String get redirectActionDescription => 'ጥሪውን ወደተገለጸው ቁጥር ያዙሩት።';

  @override
  String get labelActionDescription => 'ለቀላል መለያ ጥሪ መለያ ያክሉ።';

  @override
  String get notifyActionDescription => 'ጥሪ ሲደርስ ማሳወቂያ ይላኩ።';

  @override
  String get logActionDescription => 'የጥሪ መረጃን ሳይወስዱ ሌላ እርምጃ ሳይወስዱ ይዝገቡ።';

  @override
  String get customActionDescription => 'ብጁ እርምጃ ይፈጽሙ።';

  @override
  String get synced => 'ተመሳስሏል';

  @override
  String get needVipAccess => 'ይህን ባህሪ ለመጠቀም የVIP መዳረሻ ያስፈልግዎታል';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeName ውሂብ አስመጣ ወይም ላክ';
  }

  @override
  String get importExportTitle => 'አስመጣ/ላክ';

  @override
  String get noPhoneRules => 'የስልክ ህጎች የሉም';

  @override
  String get noRegexRules => 'የሬጌክስ ህጎች የሉም';

  @override
  String get noAllowedBlockedRules => 'የተፈቀዱ/የታገዱ ህጎች የሉም';

  @override
  String get importExport => 'አስመጣ/ላክ';

  @override
  String get filterByAction => 'በድርጊት አጣራ';

  @override
  String get upgradeToVip => 'ወደ VIP ያሳድጉ';

  @override
  String get batteryOptimizationPermission => 'የባትሪ ማሻሻያ';

  @override
  String get batteryOptimizationPermissionDescription =>
      'እንደ የደዋይ መታወቂያ ያሉ አገልግሎቶችን ለመስጠት አፑ በጀርባ እንዲሰራ ይፍቀዱ።';

  @override
  String get permissionTitle => 'ልዩ ፈቃዶች';

  @override
  String get permissionSubtitle => 'የመስኮት ንብርብር እና የባትሪ ማሻሻያ ፈቃዶችን ያቀናብሩ';

  @override
  String get themeSettingsTitle => 'የገጽታ ቅንጅቶች';

  @override
  String get themeSettingsSubtitle => 'የሚወዱትን ገጽታ ይምረጡ';

  @override
  String get databaseSyncTitle => 'የውሂብ ጎታ ማመሳሰል';

  @override
  String get countrySyncSettingsTitle => 'በሀገር ላይ የተመሰረተ የውሂብ ጎታ ማመሳሰል ቅንጅቶች';

  @override
  String get countrySyncSettingsSubtitle => 'ለማመሳሰል አገሮችን ይምረጡ';

  @override
  String get countryDataDisclaimer =>
      'እባክዎ ልብ ይበሉ፡ የውሂብ ጎታው ለሁሉም የተወሰኑ ሀገራት ወይም ክልሎች መረጃ ላይኖረው ይችላል።';

  @override
  String get editSubscription => 'ምዝገባን ያርትይ';

  @override
  String get searchByNameOrPhoneNumber => 'በስም ወይም በስልክ ቁጥር ይፈልጉ';

  @override
  String get allowedBlockedRulesInfo =>
      'የተፈቀዱ/የታገዱ ህጎች የተወሰኑ የስልክ ቁጥሮችን ለመጥራት ለመመሳሰል ያገለግላሉ፣ ይህም ከፍተኛው ቅድሚያ አለው።';

  @override
  String get searchPhoneRulesHint => 'የስልክ ህጎችን ይፈልጉ';

  @override
  String get phoneRulesInfo =>
      'የስልክ ህጎች የተወሰኑ የስልክ ቁጥሮችን ለመጥራት ለመመሳሰል ያገለግላሉ፣ ይህም ዝቅተኛ ቅድሚያ አለው። አንዳንዶቹ ከphoneRule ምዝገባዎች የመጡ ናቸው';

  @override
  String get searchSubscriptionsHint => 'ምዝገባዎችን ይፈልጉ';

  @override
  String get searchPluginsHint => 'ተሰኪዎችን ይፈልጉ';

  @override
  String get searchLabelsHint => 'መለያዎችን ይፈልጉ';

  @override
  String get pluginDescription => 'የተሰኪ መግለጫ';

  @override
  String get enterPluginDescription => 'የተሰኪ መግለጫ ያስገቡ';

  @override
  String get searchRegexRulesHint => 'የቁጥር ቅጦችን ይፈልጉ';

  @override
  String get regexRulesInfo =>
      'የቁጥር ቅጦች ህጎች የጥሪዎችን በቁጥር ቅጦች ላይ በመመስረት ለማጣራት ያገለግላሉ።';

  @override
  String get searchMarkedPhonesHint => 'የተመዘገቡ ስልኮችን ይፈልጉ';

  @override
  String get searchContactSubscriptionsHint => 'የእውቂያ ምዝገባዎችን ይፈልጉ';

  @override
  String get showAllContacts => 'ሁሉንም እውቂያዎች አሳይ';

  @override
  String get showFavorites => 'ተወዳጆችን አሳይ';

  @override
  String get manualEntry => 'የእጅ ግቤት መረጃ';

  @override
  String get scriptSaved => 'ስክሪፕት ተቀምጧል';

  @override
  String editScriptFor(String pluginName) {
    return 'ለ $pluginName ስክሪፕት ያርትይ';
  }

  @override
  String get saveScript => 'ስክሪፕት አስቀምጥ';

  @override
  String get testPlugin => 'ተሰኪን ይፈትኑ';

  @override
  String get description => 'መግለጫ';

  @override
  String get accessTargetUrl => 'ዒላማውን ዩአርኤል ያግኙ';

  @override
  String get result => 'ውጤት';

  @override
  String get editScript => 'ስክሪፕት ያርትይ';

  @override
  String get numberFormat => 'የቁጥር ቅርጸት';

  @override
  String get nationalNumber => 'አገርኛ ቁጥር';

  @override
  String get e164Number => 'E164 ቁጥር';

  @override
  String get pluginRulesInfo =>
      'ለደህንነት ሲባል፣ እባክዎ የታመኑ ምንጮችን ብቻ ይጠቀሙ። የራስዎን ማበጀት ተሰኪዎችን ለመፍጠር አብነቶቻችንን ለመጠቀም ነጻነት ይሰማዎት!';

  @override
  String get advancedMode => 'የላቀ ሁነታ';

  @override
  String get pleaseEnterAtLeastOneNumber => 'እባክዎ ቢያንስ አንድ ቁጥር ያስገቡ።';

  @override
  String get openInWebView => 'በድር እይታ ይክፈቱ';

  @override
  String get pluginLabel => 'የተሰኪ መለያ';

  @override
  String get pluginID => 'መታወቂያ';

  @override
  String get pluginURL => 'ዩአርኤል';

  @override
  String get messageBackgroundColor => 'የመልዕክት የጀርባ ቀለም';

  @override
  String get clearAllCallLogs => 'ሁሉንም የጥሪ ምዝግቦችን ያጽዱ';

  @override
  String get clearAllCallLogsConfirmation => 'ሁሉንም የጥሪ ምዝግቦችን ለማጽዳት ያረጋግጡ';

  @override
  String get allCallLogsCleared => 'ሁሉም የጥሪ ምዝግቦች ተጸዱ';

  @override
  String get unblocked => 'ያልታገደ';

  @override
  String get blockNumber => 'ቁጥርን አግድ';

  @override
  String get blockNumberSuccess => 'ቁጥርን ማገድ ስኬታማ ሆነ';

  @override
  String get blockNumberFailed => 'ቁጥርን ማገድ አልተሳካም';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '$phoneNumber ን ማገድ ይፈልጋሉ?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '$phoneNumber እየደወለ ነው...';
  }

  @override
  String get viewDetails => 'ዝርዝሮችን ይመልከቱ';

  @override
  String get unblock => 'አግድ';

  @override
  String get unblockNumber => 'ቁጥርን እገድ';

  @override
  String get unblockNumberSuccess => 'ቁጥር በተሳካ ሁኔታ ታገደ';

  @override
  String get unblockNumberFailed => 'ቁጥርን ማገድ አልተሳካም';

  @override
  String get serviceNotAvailable => 'አገልግሎት የለም';

  @override
  String get callingNumberFailed => 'የመደወል ቁጥር አልተሳካም';

  @override
  String get listView => 'የዝርዝር እይታ';

  @override
  String get timelineView => 'የጊዜ መስመር እይታ';

  @override
  String get nameCannotBeEmpty => 'ስም ባዶ ሊሆን አይችልም';

  @override
  String get selectAction => 'ክንዋኔውን ይምረጡ';

  @override
  String get selectTargetService => 'ዒላማውን አገልግሎት ይምረጡ';

  @override
  String get callDetails => 'የጥሪ ዝርዝሮች';

  @override
  String get callType => 'የጥሪ ዓይነት';

  @override
  String get callTime => 'የጥሪ ጊዜ';

  @override
  String get numberInvalidFormat => 'ቁጥር ባልተለመደ ቅርጸት';

  @override
  String get membershipFeature => 'የአባልነት ባህሪ';

  @override
  String get medium => 'መካከለኛ';

  @override
  String get finalRisk => 'የመጨረሻ ስጋት';

  @override
  String get simState => 'የሲም ሁኔታ';

  @override
  String get ipCountry => 'የአይፒ ሀገር';

  @override
  String get simCountry => 'የሲም ሀገር';

  @override
  String get isRoaming => 'ሮሚንግ';

  @override
  String get isNumberMatch => 'የቁጥር ግጥሚያ';

  @override
  String get support => 'ድጋፍ';

  @override
  String get rewardedAdService => 'የተሸላሚ ማስታወቂያ አገልግሎት';

  @override
  String get hasVipPrivilegeExceptAds =>
      'እርስዎ ቀድሞውኑ የቪአይፒ መብት (ከማስታወቂያ በስተቀር) አለዎት';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'እርስዎ ጊዜያዊ መብቶች አሉዎት፣ ጊዜው የሚያበቃበት ቀን፡ $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'ጊዜያዊ የቪአይፒ መብቶችን ለማግኘት $count ተጨማሪ ማስታወቂያዎችን ማየት ያስፈልግዎታል';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '$days ቀናት የጊዜያዊ የግዢ መብቶች ተሰጥተውዎታል ። የሚያበቃበት ቀን፡ $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'ጊዜያዊ የግዢ መብቶች ጊዜያቸው አልፏል';

  @override
  String get loadingAd => 'ማስታወቂያ በመጫን ላይ...';

  @override
  String get earnedTempVip => 'ጊዜያዊ ቪአይፒ አግኝቷል';

  @override
  String get vipExchangeService => 'የቪአይፒ ልውውጥ አገልግሎት';

  @override
  String get marksInsufficient => 'ለመለዋወጥ በቂ ምልክቶች የሉም';

  @override
  String get invalidExchangeRule => 'ትክክል ያልሆነ የልውውጥ ህግ';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'ለ $description በተሳካ ሁኔታ ተለዋውጧል፣ የሚያበቃበት ቀን፡ $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'ልውውጥ አልተሳካም: $error';
  }

  @override
  String get vip3DaysWithAds => '3-ቀን ቪአይፒ በማስታወቂያዎች (ማመሳሰል ብቻ)';

  @override
  String get vip5DaysNoAds => '5-ቀን ሙሉ-ባህሪ ያለው ከማስታወቂያ ነፃ ቪአይፒ';

  @override
  String get vip7DaysNoAds => '7-ቀን ሙሉ-ባህሪ ያለው ከማስታወቂያ ነፃ ቪአይፒ';

  @override
  String get noNotifications => 'ማስታወቂያ የለም';

  @override
  String get clearAllNotifications => 'ሁሉንም ማሳወቂያዎች ያጽዱ';

  @override
  String get clearAllNotificationsConfirmation => 'ሁሉንም ማሳወቂያዎች ለማጽዳት ያረጋግጡ';

  @override
  String get allNotificationsCleared => 'ሁሉም ማሳወቂያዎች ተጠርገዋል';

  @override
  String get clearButton => 'አጥራ';

  @override
  String get justNow => 'አሁን';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ደቂቃዎች በፊት',
      one: '1 ደቂቃ በፊት',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ሰዓታት በፊት',
      one: '1 ሰዓት በፊት',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ቀናት በፊት',
      one: '1 ቀን በፊት',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'ትላንት';

  @override
  String get deletionProposal => 'የመሰረዝ ጥያቄ';

  @override
  String get createProposal => 'ጥያቄ ፍጠር';

  @override
  String get createProposalTitle => 'የመሰረዝ ጥያቄ ፍጠር';

  @override
  String get reason => 'ምክንያት';

  @override
  String get reasonOutdated => 'የዘገየ ቁጥር';

  @override
  String get reasonPrivacy => 'የግላዊነት ስጋት';

  @override
  String get reasonNotInService => 'በአገልግሎት ላይ የለም';

  @override
  String get reasonWronglyIdentified => 'በስህተት ተለይቷል';

  @override
  String get reasonInaccurateInfo => 'የተሳሳተ መረጃ';

  @override
  String get reasonWrongMarked => 'በስህተት ምልክት ተደርጎበታል';

  @override
  String get reasonOther => 'ሌላ';

  @override
  String get submit => 'አስገባ';

  @override
  String get cancel => 'ሰርዝ';

  @override
  String get proposalStatus => 'ሁኔታ';

  @override
  String get statusPending => 'በመጠባበቅ ላይ';

  @override
  String get statusActive => 'ንቁ';

  @override
  String get statusCompleted => 'ተጠናቀቀ';

  @override
  String get statusExpired => 'አብቅቷል';

  @override
  String get riskLevel => 'የአደጋ ደረጃ';

  @override
  String get riskLevelVerified => 'ተረጋግጧል';

  @override
  String get riskLevelLow => 'ዝቅተኛ';

  @override
  String get riskLevelHigh => 'ከፍተኛ';

  @override
  String get riskLevelUnknown => 'ያልታወቀ';

  @override
  String get votingProgress => 'የድምጽ መስጫ እድገት';

  @override
  String agreeVotes(int count) {
    return 'ይስማሙ: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'አይስማሙ: $count';
  }

  @override
  String totalVotes(int count) {
    return 'ጠቅላላ: $count';
  }

  @override
  String get voteAgree => 'ይስማሙ';

  @override
  String get voteDisagree => 'አይስማሙ';

  @override
  String createdAt(String date) {
    return 'የተፈጠረ: $date';
  }

  @override
  String get verificationReport => 'የማረጋገጫ ሪፖርት';

  @override
  String get showReport => 'ሪፖርት አሳይ';

  @override
  String get hideReport => 'ሪፖርት ደብቅ';

  @override
  String get proposalStatistics => 'የጥያቄ ስታቲስቲክስ';

  @override
  String get totalProposals => 'ጠቅላላ ጥያቄዎች';

  @override
  String get activeProposals => 'ንቁ ጥያቄዎች';

  @override
  String get completedProposals => 'የተጠናቀቁ ጥያቄዎች';

  @override
  String get myVotes => 'የእኔ ድምጾች';

  @override
  String get proposalCreated => 'ጥያቄው በተሳካ ሁኔታ ተፈጥሯል';

  @override
  String get proposalCreateFailed => 'ጥያቄ መፍጠር አልተቻለም';

  @override
  String get voteSubmitted => 'ድምጽዎ በተሳካ ሁኔታ ገብቷል';

  @override
  String get voteSubmitFailed => 'ድምጽ ማስገባት አልተቻለም';

  @override
  String get noProposalsFound => 'ምንም ጥያቄዎች አልተገኙም';

  @override
  String get loadingProposals => 'ጥያቄዎች በመጫን ላይ...';

  @override
  String get refreshProposals => 'ጥያቄዎችን አድስ';

  @override
  String get totalPendingProposals => 'ጠቅላላ ጥያቄዎች በመጠባበቅ ላይ';

  @override
  String get highRisk => 'ከፍተኛ ስጋት';

  @override
  String get mediumRisk => 'መካከለኛ ስጋት';

  @override
  String get lowRisk => 'ዝቅተኛ ስጋት';

  @override
  String get communityImpact => 'የማህበረሰብ ተጽእኖ';

  @override
  String get criticalIssues => 'አስቸኳይ ጉዳዮች';

  @override
  String get communityParticipation => 'የማህበረሰብ ተሳትፎ';

  @override
  String get noActivity => 'ምንም እንቅስቃሴ የለም';

  @override
  String get low => 'ዝቅተኛ';

  @override
  String get moderate => 'መካከለኛ';

  @override
  String get high => 'ከፍተኛ';

  @override
  String get veryHigh => 'በጣም ከፍተኛ';

  @override
  String get voted => 'ድምጽ ሰጥተዋል';

  @override
  String get communityVotes => 'የማህበረሰብ ድምጾች';

  @override
  String get waitingForMoreVotes => 'ለተጨማሪ የማህበረሰብ ድምጾች በመጠበቅ ላይ';

  @override
  String get proposalProcessed => 'ይህ ጥያቄ ተፈጽሟል';

  @override
  String get supported => 'ተደግፏል';

  @override
  String get opposed => 'ተቃውሟል';

  @override
  String get approved => 'ጸድቋል';

  @override
  String get rejected => 'ተቀባብሏል';

  @override
  String get completed => 'ተጠናቀቀ';

  @override
  String get pending => 'በመጠባበቅ ላይ';

  @override
  String get critical => 'አስቸኳይ';

  @override
  String get oppose => 'ተቃውሞ';

  @override
  String get veryLow => 'በጣም ዝቅተኛ';

  @override
  String get deletionProposals => 'የመሰረዝ ጥያቄዎች';

  @override
  String get deletionProposalNotificationDescription =>
      'ስለ የመሰረዝ ጥያቄ የድምጽ መስጫ ውጤቶች እና ዝመናዎች ማሳወቂያዎች።';

  @override
  String get deletionProposalCreated => 'የመሰረዝ ጥያቄ ተፈጥሯል';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'የእርስዎ የመሰረዝ ጥያቄ ለ $phoneNumber ለማህበረሰብ ግምገማ ገብቷል።';
  }

  @override
  String get proposalApproved => 'ጥያቄ ጸድቋል ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'ለ $phoneNumber የቀረበው የመሰረዝ ጥያቄ በማህበረሰቡ ጸድቋል ($supportPercentage% ድጋፍ፣ $totalVotes ድምጽ)።';
  }

  @override
  String get proposalRejected => 'ጥያቄ ውድቅ ተደርጓል ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'ለ $phoneNumber የቀረበው የመሰረዝ ጥያቄ በማህበረሰቡ ውድቅ ተደርጓል ($supportPercentage% ድጋፍ፣ $totalVotes ድምጽ)።';
  }

  @override
  String get communityVotingStarted => 'የማህበረሰብ ድምጽ መስጫ ተጀምሯል';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'ለ $phoneNumber አዲስ የመሰረዝ ጥያቄ አሁን ለማህበረሰብ ድምጽ መስጫ ክፍት ነው።';
  }

  @override
  String get votingCompleted => 'የድምጽ መስጫ ተጠናቋል';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'ለ $phoneNumber የማህበረሰብ ድምጽ መስጫ ተጠናቋል። ውጤት: $result ($supportPercentage% ድጋፍ)።';
  }

  @override
  String get newVoteReceived => 'አዲስ ድምጽ ደርሷል';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'አንድ ሰው $phoneNumber ለመሰረዝ ድምጽ ሰጥቷል። የአሁኑ ድምጾች: $totalVotes።';
  }

  @override
  String get loadVoteCountFailed => 'የድምጽ ብዛት መጫን አልተቻለም';

  @override
  String get voteCount => 'የድምጽ ብዛት';

  @override
  String get deletionProposalInfo => 'የመሰረዝ ጥያቄ መረጃ';

  @override
  String get deletionProposalDescription =>
      'የማህበረሰብ መመሪያዎችን የሚጥሱ ቁጥሮችን ለመሰረዝ ጥያቄ ያቅርቡ። ተሳትፎዎ መድረኩን ደህንነቱ የተጠበቀ ለማድረግ ይረዳል።';

  @override
  String get voteToEarnVip => 'የቪአይፒ መብቶችን ለማግኘት በቀረቡ ጥያቄዎች ላይ ድምጽ ይስጡ!';

  @override
  String get voteFailed => 'ድምጽ መስጠት አልተሳካም';

  @override
  String get searchProposals => 'ጥያቄዎችን ፈልግ';

  @override
  String get defaultNotifications => 'ነባሪ ማሳወቂያዎች';

  @override
  String get defaultNotificationsDescription =>
      'Default notification channel for the app.';

  @override
  String get blockedCallNotifications => 'የታገዱ ጥሪ ማሳወቂያዎች';

  @override
  String get blockedCallNotificationsDescription => 'በታገዱ ጥሪዎች ላይ መረጃን ያሳያል።';

  @override
  String get stirVerification => 'STIR/SHAKEN ማረጋገጫ';

  @override
  String get stirVerificationDescription =>
      'ለቁጥሮች የSTIR/SHAKEN ማረጋገጫ ውጤቶችን ያሳያል።';

  @override
  String get fraudAlerts => 'የማጭበርበር ማስጠንቀቂያዎች';

  @override
  String get fraudAlertsDescription =>
      'ሊመጡ ስለሚችሉ የማጭበርበር ጥሪዎች ማስጠንቀቂያዎችን ያሳያል።';

  @override
  String get notificationFrequencyDescription =>
      'ስለ አዲስ የሰርዝ ጥያቄዎች ምን ያህል ጊዜ ማሳወቂያ እንደሚያገኙ ይምረጡ። ወዲያውኑ፣ በቡድን፣ ወይም በተወሰነ የጊዜ ክፍተት ማሳወቂያዎችን መቀበል ይችላሉ።';

  @override
  String get notificationMode => 'የማሳወቂያ ሁነታ';

  @override
  String get immediateNotifications => 'ወዲያውኑ';

  @override
  String get immediateNotificationsDescription => 'ጥያቄ እንደተፈጠረ ማሳወቂያ ይቀበሉ።';

  @override
  String get batchNotifications => 'በቡድን';

  @override
  String get batchNotificationsDescription => 'በየጊዜው የማሳወቂያዎችን ማጠቃለያ ይቀበሉ።';

  @override
  String get customNotifications => 'ብጁ';

  @override
  String get customNotificationsDescription =>
      'ማሳወቂያዎችን ለመቀበል የራስዎን የጊዜ ክፍተት ይግለጹ።';

  @override
  String get customFrequency => 'ብጁ ድግግሞሽ';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes ደቂቃ';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ሰ';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ሰ $minutes ደቂቃ';
  }

  @override
  String get pendingProposals => 'የሚጠባበቁ ጥያቄዎች';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count የሚጠባበቁ ጥያቄዎች',
      one: '1 የሚጠባበቅ ጥያቄ',
      zero: 'የሚጠባበቁ ጥያቄዎች የሉም',
    );
    return '$_temp0.';
  }

  @override
  String get guidelinesLabel => 'መመሪያዎች';

  @override
  String get riskLevelLabel => 'የአደጋ ደረጃ';

  @override
  String get riskLevelDescription => 'የቁጥሩ የአደጋ ደረጃ';

  @override
  String get phoneNumberMinDigits => 'የስልክ ቁጥር ቢያንስ 7 አሃዞች ሊኖረው ይገባል';

  @override
  String get provideDetailedExplanation => 'ዝርዝር ማብራሪያ ይስጡ (ቢያንስ 10 ቁምፊዎች)';

  @override
  String get reasonMinCharacters => 'ምክንያት ቢያንስ 10 ቁምፊዎች መሆን አለበት';

  @override
  String get countryCodeTwoLetters => 'የሀገር ኮድ (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'የሀገር ኮድ (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'ለምሳሌ፣ US, CN, GB';

  @override
  String get countryCodeRequired => 'የሀገር ኮድ ያስፈልጋል';

  @override
  String get countryCodeLengthError => 'የሀገር ኮድ 2 ፊደሎች መሆን አለበት';

  @override
  String get phoneNumberHint => 'የስልክ ቁጥር ያስገቡ';

  @override
  String get phoneNumberRequired => 'የስልክ ቁጥር ያስፈልጋል';

  @override
  String get phoneNumberLengthError => 'የስልክ ቁጥር ቢያንስ 7 አሃዞች ሊኖረው ይገባል';

  @override
  String get reasonHint => 'ዝርዝር ማብራሪያ ይስጡ (ቢያንስ 10 ቁምፊዎች)';

  @override
  String get reasonRequired => 'ምክንያት ያስፈልጋል';

  @override
  String get reasonLengthError => 'ምክንያት ቢያንስ 10 ቁምፊዎች መሆን አለበት';

  @override
  String get guidelinesTitle => 'መመሪያዎች';

  @override
  String get guidelinesText =>
      '• በእርግጥ ችግር ያለባቸውን ቁጥሮች ብቻ ሪፖርት ያድርጉ\n• ትክክለኛ እና ዝርዝር ምክንያቶችን ያቅርቡ\n• እንደ አስከፊነቱ ተገቢውን የአደጋ ደረጃ ይምረጡ\n• የውሸት ሪፖርቶች የመለያ እገዳ ሊያስከትሉ ይችላሉ';

  @override
  String get riskLevelCritical => 'ወሳኝ';

  @override
  String get riskLevelMedium => 'መካከለኛ';

  @override
  String get riskLevelVeryLow => 'በጣም ዝቅተኛ';

  @override
  String get riskDescriptionVeryLow =>
      'በጣም ዝቅተኛ - ትንሽ ብስጭት፣ አልፎ አልፎ የሚደረጉ ጥሪዎች';

  @override
  String get riskDescriptionLow => 'ዝቅተኛ - አልፎ አልፎ የማይፈለጉ ጥሪዎች';

  @override
  String get riskDescriptionMedium => 'መካከለኛ - መደበኛ ስፓም ወይም የቴሌማርኬቲንግ';

  @override
  String get riskDescriptionHigh => 'ከፍተኛ - የማያቋርጥ ጥቃት ወይም የማጭበርበር ሙከራዎች';

  @override
  String get riskDescriptionCritical => 'ወሳኝ - አደገኛ ማጭበርበሮች ወይም ስጋቶች';

  @override
  String get notificationFrequencyTitle => 'የማሳወቂያ ድግግሞሽ';

  @override
  String get notificationFrequencyLabel => 'የማሳወቂያ ድግግሞሽ (ሰዓቶች)';

  @override
  String errorMessage(String error) {
    return 'ስህተት: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'ድምጾች: $totalVotes ($supportPercentage% ድጋፍ)';
  }

  @override
  String get timeJustNow => 'አሁን';

  @override
  String timeMinutesAgo(int minutes) {
    return '${minutes}m በፊት';
  }

  @override
  String timeHoursAgo(int hours) {
    return '${hours}h በፊት';
  }

  @override
  String timeDaysAgo(int days) {
    return '${days}d በፊት';
  }

  @override
  String get reportingGuidelines =>
      '• በእርግጥ ችግር ያለባቸውን ቁጥሮች ብቻ ሪፖርት ያድርጉ\n• ትክክለኛ እና ዝርዝር ምክንያቶችን ያቅርቡ\n• እንደ አስከፊነቱ ተገቢውን የአደጋ ደረጃ ይምረጡ\n• የውሸት ሪፖርቶች የመለያ እገዳ ሊያስከትሉ ይችላሉ';

  @override
  String get notificationFrequencyHours => 'የማሳወቂያ ድግግሞሽ (ሰዓቶች)';

  @override
  String supportCount(int supportCount) {
    return 'ድጋፍ ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'ተቃውሞ ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes ድምጾች ($supportPercentage% ድጋፍ)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ሰዓቶች',
      one: '1 ሰዓት',
      zero: '0 ሰዓቶች',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'ጠቃሚ ማሳሰቢያ';

  @override
  String get dataSourceDisclaimer =>
      'ቁጥሮች ከኢንተርኔት እና ከተጠቃሚዎች የቀረቡ ናቸው። አንድ ቁጥር ከተሰረዘ በሌሎች ተጠቃሚዎች ወይም ምንጮች እንደገና እንደማይቀርብ ዋስትና አንሰጥም። እባክዎ በንቃት ይፈልጉ እና መረጃውን ያረጋግጡ።';

  @override
  String get avatar => 'የመገለጫ ሥዕል';

  @override
  String get location => 'ቦታ';

  @override
  String get simCardTitle => 'የሲም ካርድ';

  @override
  String get liveActivitiesSettingsTitle => 'የቀጥታ እንቅስቃሴ ቅንብሮች';

  @override
  String get elementsSettingsTitle => 'የኤለመንት ቅንብሮች';

  @override
  String get liveActivityMode => 'የቀጥታ እንቅስቃሴ';

  @override
  String get liveActivityModeDescription =>
      'የጥሪ መረጃን እንደ ቋሚ ማሳወቂያ በመቆለፊያ ማያ ገጽ እና በ Dynamic Island (iOS) ላይ ያሳያል።';

  @override
  String get phoneNumberType => 'የስልክ ቁጥር አይነት';

  @override
  String get liveActivitiesTestEndActivity => 'እንቅስቃሴ ጨርስ';

  @override
  String get liveActivitiesTestSendNewActivity => 'አዲስ እንቅስቃሴ ላክ';

  @override
  String get liveActivitiesTestUpdateActivity => 'እንቅስቃሴ አዘምን';

  @override
  String get liveActivityControlsTitle => 'የቀጥታ እንቅስቃሴ ቁጥጥሮች';

  @override
  String get liveActivitiesTestTitle => 'የቀጥታ እንቅስቃሴ ሙከራ';

  @override
  String get liveActivitiesTestSubtitle => 'የቀጥታ እንቅስቃሴ ማሳወቂያውን ይሞክሩ።';

  @override
  String get liveNotificationCustomizationTitle => 'የቀጥታ ማሳወቂያ ማበጀት';

  @override
  String get liveNotificationCustomizationSubtitle => 'የቀጥታ ማሳወቂያዎችን ገጽታ ያብጁ።';

  @override
  String get notification_instructions =>
      'መመሪያዎች:\n1. ለማሳወቂያ ለመፍጠር ወይም ለማዘመን \"ላክ\" የሚለውን ይንኩ።\n2. ውጤቱን ለማየት ወደ መነሻ ማያ ገጽዎ ይሂዱ ወይም የማሳወቂያ መሳቢያውን ይጎትቱ።\n3. ማሳወቂያውን ለማስወገድ \"ጨርስ\" የሚለውን ይንኩ።';

  @override
  String get autoCancelNotification => 'ራስ-ሰር ማሳወቂያ መሰረዝ';

  @override
  String get autoCancelNotificationDescription =>
      'የተመረጠ ከሆነ፣ ተጠቃሚው ሲነካው ማሳወቂያው በራስ-ሰር ይሰረዛል።';

  @override
  String get setDelayTime => 'የመዘግየት ጊዜ ያዘጋጁ';

  @override
  String get proposalDetails => 'የጥያቄ ዝርዝሮች';

  @override
  String get filterByStatus => 'በሁኔታ ያጣሩ';

  @override
  String get proposalNotFound => 'ጥያቄ አልተገኘም';

  @override
  String get processed => 'ተከናውኗል';

  @override
  String get showAll => 'ሁሉንም አሳይ';

  @override
  String get filterAndSortTitle => 'አጣራ እና ደርድር';

  @override
  String get filterVerifiedOwner => 'የተረጋገጠ ባለቤት አጣራ';

  @override
  String get filterBy => 'በ... አጣራ';

  @override
  String get sortOldest => 'በጣም የቆዩትን ደርድር';

  @override
  String get sortNewest => 'በጣም አዲሶቹን ደርድር';

  @override
  String get sortMostPopular => 'በጣም ተወዳጅ የሆኑትን ደርድር';

  @override
  String get sortLeastPopular => 'በጣም ያልተወዳጁትን ደርድር';

  @override
  String get sortBy => 'በ... ደርድር';

  @override
  String get simRulesNotFound => 'የሲም ህጎች አልተገኙም።';

  @override
  String get simSlotRules => 'የሲም ማስገቢያ ህጎች';

  @override
  String get noSimCardDetected => 'የሲም ካርድ አልተገኘም።';

  @override
  String get invalidSimData => 'የሲም ውሂብ ትክክል አይደለም';

  @override
  String get simCardData => 'የሲም ካርድ ውሂብ';

  @override
  String get simSlot => 'የሲም ማስገቢያ';

  @override
  String get enableFiltering => 'ማጣራትን አንቃ';

  @override
  String get detailedSettingsTitle => 'ዝርዝር ቅንብሮች';

  @override
  String get entryPointViewTitle => 'የመግቢያ ነጥብ እይታ';

  @override
  String get callTypeRejected => 'ተቀባይነት አጥቷል';

  @override
  String get callTypeSilenced => 'ጸጥ አለ';

  @override
  String get callTypeVoicemail => 'የድምፅ መልዕክት';

  @override
  String get callTypeUnknownIntercept => 'ያልታወቀ መቅረት';

  @override
  String andMoreItems(int count) {
    return 'እና $count ተጨማሪ እቃዎች';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

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
  String get leaveEmptyToUseDefault => 'Leave empty to use default';

  @override
  String get vipAccessSubtitle => 'Watch ads for free or purchase VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Failed to load settings schema: $error';
  }

  @override
  String get noSettingsAvailable => 'No settings available for this plugin.';

  @override
  String get fieldIsRequired => 'This field is required';

  @override
  String get answerThenHangupDescription =>
      'Automatically answer the incoming call and then immediately hang up to terminate it';

  @override
  String get stirUnverified => 'Not Verified';

  @override
  String markedCountDisplay(int count) {
    return 'Marked: $count';
  }
}
