// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get aboutContactSubscription => 'អំពីការជាវទំនាក់ទំនង';

  @override
  String get aboutLabels => 'អំពីស្លាក';

  @override
  String get aboutPhoneSubscriptionRules => 'អំពីច្បាប់ជាវទូរស័ព្ទ';

  @override
  String get aboutPhoneSubscriptions => 'អំពីការជាវទូរស័ព្ទ';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'ជាវបញ្ជីច្បាប់ទូរស័ព្ទតាមរយៈ URL អាប់ដេតច្បាប់ដោយស្វ័យប្រវត្តិ។ គាំទ្រឯកសារច្បាប់ទម្រង់ JSON, CSV។';

  @override
  String get aboutSmsFilter => 'អំពីការត្រងសារ SMS';

  @override
  String get aboutSmsSubscriptionRules => 'អំពីច្បាប់ជាវសារ SMS';

  @override
  String get aboutSubtitle => 'កំណែកម្មវិធី និងព័ត៌មានស្របច្បាប់';

  @override
  String get aboutTitle => 'អំពី';

  @override
  String get action => 'សកម្មភាព';

  @override
  String get actionAll => 'ទាំងអស់';

  @override
  String get actionAllow => 'អនុញ្ញាត';

  @override
  String get actionBlock => 'ទប់ស្កាត់';

  @override
  String get actionFilterAll => 'តម្រងទាំងអស់';

  @override
  String get actionFilterTitle => 'តម្រងតាមប្រភេទសកម្មភាព';

  @override
  String get actionFilterTooltip => 'តម្រងសកម្មភាព';

  @override
  String get actionNone => 'គ្មានសកម្មភាព';

  @override
  String get actionSilence => 'ស្ងាត់';

  @override
  String actionTag(Object actionType) {
    return 'សកម្មភាព៖ $actionType';
  }

  @override
  String get actionType => 'ប្រភេទសកម្មភាព';

  @override
  String get actionUnknown => 'មិនស្គាល់';

  @override
  String get add => 'បន្ថែម';

  @override
  String get addAllowedBlockedRule => 'បន្ថែមច្បាប់អនុញ្ញាត/ទប់ស្កាត់';

  @override
  String get addAllowSubscription => 'បន្ថែមការជាវអនុញ្ញាត';

  @override
  String get addBlockSubscription => 'បន្ថែមការជាវទប់ស្កាត់';

  @override
  String get addContactButton => 'បន្ថែមទំនាក់ទំនង';

  @override
  String addContactFailed(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមទំនាក់ទំនង៖ $error';
  }

  @override
  String get addedToAllowedRules => 'បានបន្ថែមទៅក្នុងច្បាប់ដែលបានអនុញ្ញាត';

  @override
  String get addedToBlacklist => 'បានបន្ថែមទៅក្នុងបញ្ជីខ្មៅ';

  @override
  String get addedToBlockedRules => 'បានបន្ថែមទៅក្នុងច្បាប់ដែលបានទប់ស្កាត់';

  @override
  String get addedToFavoriteContacts => 'បានបន្ថែមទៅក្នុងទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get addedToFavorites => 'បានបន្ថែមទៅក្នុងទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get addedToWhitelist => 'បានបន្ថែមទៅក្នុងបញ្ជីស';

  @override
  String get addFavorite => 'បន្ថែមទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get addFilter => 'បន្ថែមតម្រង';

  @override
  String get addLabel => 'បន្ថែមស្លាក';

  @override
  String get addLabelButton => 'បន្ថែមស្លាក';

  @override
  String addLabelFailed(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមស្លាក៖ $error';
  }

  @override
  String get addLabelToCall => 'បន្ថែមស្លាកទៅកំណត់ត្រាវីដេអូ';

  @override
  String get addName => 'បន្ថែមឈ្មោះ';

  @override
  String get addNoneSubscription => 'បន្ថែមការជាវគ្មាន';

  @override
  String get addOrEditContactInfo =>
      'ប្រើដើម្បីបន្ថែម ឬកែសម្រួលព័ត៌មានទំនាក់ទំនង';

  @override
  String get addPhoneMark => 'បន្ថែមសញ្ញាទូរស័ព្ទ';

  @override
  String get addPhoneNumberRule => 'បន្ថែមច្បាប់លេខទូរស័ព្ទ';

  @override
  String get addPlugin => 'បន្ថែមកម្មវិធីជំនួយ';

  @override
  String get addPluginFailed => 'បរាជ័យក្នុងការបន្ថែមកម្មវិធីជំនួយ';

  @override
  String addPluginFailedWithError(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមកម្មវិធីជំនួយ៖ $error';
  }

  @override
  String get addPluginFromLocalFile =>
      'បន្ថែមកម្មវិធីជំនួយពីឯកសារក្នុងមូលដ្ឋាន';

  @override
  String get addPluginFromUrl => 'បន្ថែមកម្មវិធីជំនួយពី URL';

  @override
  String get addRegexRule => 'បន្ថែមច្បាប់ Regex';

  @override
  String get addRule => 'បន្ថែមច្បាប់';

  @override
  String get addRuleButton => 'បន្ថែមច្បាប់';

  @override
  String addRuleFailed(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមច្បាប់៖ $error';
  }

  @override
  String get addRuleTooltip => 'បន្ថែមច្បាប់';

  @override
  String get addSilenceSubscription => 'បន្ថែមការជាវស្ងាត់';

  @override
  String get addSimRuleButton => 'បន្ថែមច្បាប់ SIM';

  @override
  String get addSmsFilterRule => 'បន្ថែមច្បាប់ត្រង SMS';

  @override
  String get addSmsRule => 'បន្ថែមច្បាប់ SMS';

  @override
  String get addSmsSubscription => 'បន្ថែមការជាវ SMS';

  @override
  String get addSubscription => 'បន្ថែមការជាវ';

  @override
  String get addSubscriptionButton => 'បន្ថែមការជាវ';

  @override
  String addSubscriptionFailed(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមការជាវ៖ $error';
  }

  @override
  String get addSubscriptionTooltip => 'បន្ថែមការជាវ';

  @override
  String get addToAllowedRules => 'បន្ថែមទៅក្នុងច្បាប់ដែលបានអនុញ្ញាត';

  @override
  String get addToBlacklist => 'បន្ថែមទៅក្នុងបញ្ជីខ្មៅ';

  @override
  String get addToBlockedRules => 'បន្ថែមទៅក្នុងច្បាប់ដែលបានទប់ស្កាត់';

  @override
  String get addToFavoriteContacts => 'បន្ថែមទៅក្នុងទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get addToFavorites => 'បន្ថែមទៅក្នុងទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get addToRules => 'បន្ថែមទៅក្នុងច្បាប់';

  @override
  String get addToWhitelist => 'បន្ថែមទៅក្នុងបញ្ជីស';

  @override
  String get adPlaceholder => 'Ad Placeholder';

  @override
  String get agent => 'ភ្នាក់ងារ';

  @override
  String get all => 'ទាំងអស់';

  @override
  String get allCallsTab => 'ទាំងអស់';

  @override
  String get allDataClearedSuccessfully => 'បានលុបទិន្នន័យទាំងអស់ដោយជោគជ័យ';

  @override
  String get allow => 'អនុញ្ញាត';

  @override
  String get allowAllAllowRules => 'អនុញ្ញាតច្បាប់អនុញ្ញាតទាំងអស់';

  @override
  String get allowAllAllowRulesDesc => 'អនុញ្ញាតការហៅទូរស័ព្ទពីច្បាប់អនុញ្ញាត';

  @override
  String get allowAllBlacklistedNumbers => 'អនុញ្ញាតលេខក្នុងបញ្ជីខ្មៅទាំងអស់';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'អនុញ្ញាតការហៅទូរស័ព្ទពីបញ្ជីទប់ស្កាត់';

  @override
  String get allowAllBlockRules => 'អនុញ្ញាតច្បាប់ទប់ស្កាត់ទាំងអស់';

  @override
  String get allowAllBlockRulesDesc => 'អនុញ្ញាតការហៅទូរស័ព្ទពីច្បាប់ទប់ស្កាត់';

  @override
  String get allowAllowedNumbers => 'អនុញ្ញាតលេខដែលបានអនុញ្ញាត';

  @override
  String get allowAllowedNumbersDesc => 'អនុញ្ញាតការហៅទូរស័ព្ទពីបញ្ជីអនុញ្ញាត';

  @override
  String get allowBlock => 'អនុញ្ញាត/ទប់ស្កាត់';

  @override
  String get allowBlockedNumbers => 'អនុញ្ញាតលេខដែលបានទប់ស្កាត់';

  @override
  String get allowBlockedNumbersDesc => 'អនុញ្ញាតការហៅទូរស័ព្ទពីបញ្ជីទប់ស្កាត់';

  @override
  String get allowedBlockedRule => 'ច្បាប់អនុញ្ញាត/ទប់ស្កាត់';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'កែសម្រួលច្បាប់អនុញ្ញាត/ទប់ស្កាត់';

  @override
  String get allowedBlockedRuleManagement =>
      'ការគ្រប់គ្រងច្បាប់អនុញ្ញាត/ទប់ស្កាត់';

  @override
  String get allowNonExceededNumbers => 'អនុញ្ញាតលេខដែលមិនលើសពីចំនួនកំណត់';

  @override
  String get allowNonExceededNumbersDescription =>
      'អនុញ្ញាតដោយស្វ័យប្រវត្តិនូវលេខដែលមិនលើសពីចំនួនកំណត់';

  @override
  String get allowRegexAllowRules => 'អនុញ្ញាតច្បាប់ Regex អនុញ្ញាត';

  @override
  String get allowRegexAllowRulesDesc =>
      'បើកដំណើរការការផ្គូផ្គងលំនាំ regex សម្រាប់ច្បាប់អនុញ្ញាត';

  @override
  String get allowRegexAllowRulesDescription =>
      'បើកដំណើរការច្បាប់អនុញ្ញាតផ្អែកលើ regex';

  @override
  String get allowRegexBlockRules => 'អនុញ្ញាតច្បាប់ Regex ទប់ស្កាត់';

  @override
  String get allowRegexBlockRulesDesc =>
      'បើកដំណើរការការផ្គូផ្គងលំនាំ regex សម្រាប់ច្បាប់ទប់ស្កាត់';

  @override
  String get allowRegexBlockRulesDescription =>
      'បើកដំណើរការច្បាប់ទប់ស្កាត់ផ្អែកលើ regex';

  @override
  String get allowRule => 'ច្បាប់អនុញ្ញាត';

  @override
  String get allowRules => 'ច្បាប់អនុញ្ញាត';

  @override
  String get allowWhitelistedNumbers => 'អនុញ្ញាតលេខទូរស័ព្ទក្នុងបញ្ជីស';

  @override
  String get allowWhitelistedNumbersDescription =>
      'អនុញ្ញាតលេខទូរស័ព្ទទាំងអស់ក្នុងបញ្ជីស';

  @override
  String get allPermissionsGranted => 'បានផ្តល់សិទ្ធិទាំងអស់';

  @override
  String get allSettingsCompleted => 'បានបញ្ចប់ការកំណត់ទាំងអស់។';

  @override
  String allUpdateSuccess(Object count) {
    return 'បានបញ្ចប់ការអាប់ដេតទាំងអស់ ($count ច្បាប់)';
  }

  @override
  String get answerThenHangup => 'ឆ្លើយតប រួចផ្ដាច់';

  @override
  String get appLegalese => '© 2023 Your Call Your Rule. រក្សាសិទ្ធិគ្រប់យ៉ាង។';

  @override
  String get applicationSoftware => 'កម្មវិធី';

  @override
  String get apply => 'អនុវត្ត';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'ការអនុញ្ញាតបរាជ័យ៖ សូមពិនិត្យមើល Client ID និង Key';

  @override
  String get authorizationFailedMessage => 'ការអនុញ្ញាតបរាជ័យ';

  @override
  String get authorizationSuccessMessage => 'ការអនុញ្ញាតជោគជ័យ';

  @override
  String get authorizeLoginButton => 'អនុញ្ញាតការចូល';

  @override
  String get automotiveIndustry => 'ឧស្សាហកម្មរថយន្ត';

  @override
  String get autoSyncLabel => 'ធ្វើសមកាលកម្មដោយស្វ័យប្រវត្តិ';

  @override
  String get autoUpdate => 'ធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិ';

  @override
  String get autoUpdateDescription =>
      'កំណត់ចន្លោះពេលធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិសម្រាប់ការជាវ ឬធ្វើបច្ចុប្បន្នភាពដោយដៃ';

  @override
  String get autoUpdateSettings => 'ការកំណត់ធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិ';

  @override
  String get autoUpdateSettingsSubtitle =>
      'គ្រប់គ្រងការធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិសម្រាប់ច្បាប់ និងកម្មវិធីបន្ថែម';

  @override
  String get autoUpdateSettingsTitle =>
      'ការកំណត់ធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិ';

  @override
  String get autoUpdateSubtitle =>
      'គ្រប់គ្រងការធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិសម្រាប់ច្បាប់ និងកម្មវិធីបន្ថែម';

  @override
  String get autoUpdateTitle => 'ធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិ';

  @override
  String get avatarBorderColor => 'ពណ៌ព្រំដែនរូបតំណាង';

  @override
  String get avatarBorderSize => 'ទំហំព្រំដែនរូបតំណាង';

  @override
  String get avatarIconSizesSetting => 'ទំហំរូបតំណាង និងរូបសញ្ញា';

  @override
  String get avatarPosition => 'ទីតាំងរូបតំណាង';

  @override
  String get avatarSize => 'ទំហំរូបតំណាង';

  @override
  String axisPosition(Object axis) {
    return 'ទីតាំង $axis';
  }

  @override
  String get backgroundGradientSetting => 'ការកំណត់ជម្រាលផ្ទៃខាងក្រោយ';

  @override
  String get backup => 'បម្រុងទុក';

  @override
  String get backupAndRestore => 'បម្រុងទុក និងស្ដារឡើងវិញ';

  @override
  String get backupAndRestoreSubtitle =>
      'បម្រុងទុក ឬស្ដារទិន្នន័យកម្មវិធីឡើងវិញ';

  @override
  String get backupAndRestoreTitle => 'បម្រុងទុក និងស្ដារឡើងវិញ';

  @override
  String get backupFailed => 'ការបម្រុងទុកបរាជ័យ';

  @override
  String get backupFailedMessage => 'ការបម្រុងទុកបរាជ័យ';

  @override
  String backupFailedWithError(Object error) {
    return 'ការបម្រុងទុកបរាជ័យ៖ $error';
  }

  @override
  String get backupRestoreSubtitle => 'បម្រុងទុក ឬស្ដារទិន្នន័យកម្មវិធីឡើងវិញ';

  @override
  String get backupRestoreTitle => 'បម្រុងទុក និងស្ដារឡើងវិញ';

  @override
  String get backupSectionTitle => 'បម្រុងទុក';

  @override
  String get backupSettings => 'ការកំណត់ការបម្រុងទុក';

  @override
  String get backupSettingsDialogTitle => 'ការកំណត់ការបម្រុងទុក';

  @override
  String get backupSettingsTitle => 'ការកំណត់ការបម្រុងទុក';

  @override
  String get backupSuccessMessage => 'បានបម្រុងទុកទៅពពកដោយជោគជ័យ';

  @override
  String backupSuccessToLocal(Object path) {
    return 'ការបម្រុងទុកជោគជ័យទៅ៖ $path';
  }

  @override
  String get backupToCloud => 'បម្រុងទុកទៅពពក';

  @override
  String get backupToCloudDescription =>
      'បម្រុងទុកការកំណត់ និងច្បាប់ទៅកន្លែងផ្ទុកពពក';

  @override
  String backupToCloudFailed(Object error) {
    return 'បរាជ័យក្នុងការបម្រុងទុកទៅពពក៖ $error';
  }

  @override
  String get backupToCloudLabel => 'បម្រុងទុកទៅពពក';

  @override
  String get backupToCloudSuccess => 'បានបម្រុងទុកទៅពពកដោយជោគជ័យ';

  @override
  String get backupToCloudTitle => 'បម្រុងទុកទៅពពក';

  @override
  String get backupToLocalLabel => 'បម្រុងទុកទៅក្នុងម៉ាស៊ីន';

  @override
  String get bank => 'ធនាគារ';

  @override
  String get basicInfo => 'ព័ត៌មានមូលដ្ឋាន';

  @override
  String get basicRuleFilter => 'តម្រងច្បាប់មូលដ្ឋាន';

  @override
  String get basicRuleFiltering => 'ការត្រងច្បាប់មូលដ្ឋាន';

  @override
  String get basicRuleFilteringExplanation =>
      '• ការត្រងច្បាប់មូលដ្ឋាន៖ ត្រងច្បាប់ដោយផ្អែកលើបញ្ជីខ្មៅ បញ្ជីស និង regex';

  @override
  String get basicRuleFilterSettings => 'ការកំណត់តម្រងច្បាប់មូលដ្ឋាន';

  @override
  String get basicRuleFilterSubtitle =>
      'ត្រងការហៅទូរស័ព្ទដោយប្រើបញ្ជីខ្មៅ/បញ្ជីស និងកន្សោមធម្មតា';

  @override
  String get batchDeleteContacts => 'លុបទំនាក់ទំនងជាបាច់';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'តើអ្នកប្រាកដថាអ្នកចង់លុបទំនាក់ទំនងដែលបានជ្រើសរើស $count ដែរឬទេ?';
  }

  @override
  String get batchDeleteFailed => 'ការលុបជាបាច់បរាជ័យ';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'តើអ្នកប្រាកដថាអ្នកចង់លុបស្លាក $count ដែរឬទេ?';
  }

  @override
  String get blacklist => 'បញ្ជីខ្មៅ';

  @override
  String get blacklistingAndWhitelisting => 'ការដាក់ក្នុងបញ្ជីខ្មៅ និងបញ្ជីស';

  @override
  String get blacklistLabel => 'បញ្ជីខ្មៅ';

  @override
  String get blackWhiteList => 'បញ្ជីខ្មៅ/ស';

  @override
  String get block => 'ទប់ស្កាត់';

  @override
  String get blockCalls => 'ទប់ស្កាត់ការហៅទូរស័ព្ទ';

  @override
  String get blocked => 'បានទប់ស្កាត់';

  @override
  String get blockedCallAction => 'សកម្មភាពការហៅដែលបានទប់ស្កាត់';

  @override
  String get blockedCalls => 'ការហៅដែលបានទប់ស្កាត់';

  @override
  String get blockedCallsTitle => 'ការហៅដែលបានទប់ស្កាត់';

  @override
  String get blockedCommunications => 'ទំនាក់ទំនងដែលបានទប់ស្កាត់';

  @override
  String get blockedPhoneLabel => 'ការហៅដែលបានទប់ស្កាត់';

  @override
  String get blockedSpamCalls => 'ការហៅទូរស័ព្ទសារឥតបានការដែលបានទប់ស្កាត់';

  @override
  String get blockingTrend => 'និន្នាការទប់ស្កាត់';

  @override
  String get blockInternationalCalls => 'ផ្គូផ្គងលេខដែលមិនចាប់ផ្តើមដោយ + ឬ 00';

  @override
  String get blockInternationalCallsTitle => 'ទប់ស្កាត់ការហៅអន្តរជាតិ';

  @override
  String get blockLandlineNumbersTitle => 'ទប់ស្កាត់លេខទូរស័ព្ទលើគោក';

  @override
  String get blockMobileNumbers => 'ផ្គូផ្គងលេខដែលមិនចាប់ផ្តើមដោយ 13-19';

  @override
  String get blockMobileNumbersTitle => 'ទប់ស្កាត់លេខទូរស័ព្ទចល័ត';

  @override
  String get blockPremiumRateNumbers =>
      'ផ្គូផ្គងលេខដែលមិនចាប់ផ្តើមដោយ 118 ឬ 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'ទប់ស្កាត់លេខគិតតម្លៃពិសេស';

  @override
  String get blockRule => 'ច្បាប់ទប់ស្កាត់';

  @override
  String get blockRules => 'ច្បាប់ទប់ស្កាត់';

  @override
  String get blockSpecificAreaCodes =>
      'ផ្គូផ្គងលេខដែលចាប់ផ្តើមដោយ 0 + 2-3 ខ្ទង់';

  @override
  String get blockSpecificAreaCodesTitle => 'ទប់ស្កាត់លេខកូដតំបន់ជាក់លាក់៖';

  @override
  String get blockTypeAnalysisTitle => 'ការវិភាគប្រភេទនៃការទប់ស្កាត់';

  @override
  String get both => 'ទាំងពីរ';

  @override
  String get bulkDelete => 'លុបជាបាច់ទំនាក់ទំនង';

  @override
  String get bulkDeleteContacts => 'លុបទំនាក់ទំនងជាបាច់';

  @override
  String get bulkDeleteLabels => 'លុបស្លាបជាបាច់';

  @override
  String get call => 'ហៅ';

  @override
  String get callback => 'ហៅត្រឡប់';

  @override
  String callbackTo(String number) {
    return 'ហៅត្រឡប់ទៅ $number';
  }

  @override
  String get callBlocking => 'ការទប់ស្កាត់ការហៅ';

  @override
  String get callerIdApp => 'កម្មវិធី Caller ID';

  @override
  String get callerIdCustomizationTitle => 'ប្ដូរតាមបំណង Caller ID';

  @override
  String get callerIdDialogTitle => 'ព័ត៌មាន Caller ID';

  @override
  String get callerIdDisplayMode => 'របៀបបង្ហាញអត្តសញ្ញាណអ្នកហៅ';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'សម្គាល់ដោយ $count';
  }

  @override
  String get callerIdPreview => 'ទិដ្ឋភាព​ជា​មុន​អត្តសញ្ញាណ​អ្នក​ហៅ';

  @override
  String get callFilter => 'តម្រង​ការ​ហៅ';

  @override
  String get callFilterDescription =>
      'នៅពេល​បើក​ដំណើរការ ការ​ហៅ​ចូល​នឹង​ត្រូវ​បាន​ត្រួតពិនិត្យ​ប្រឆាំង​នឹង​បញ្ជី​ច្បាប់​ខាងក្រោម។ ច្បាប់​តម្រង​ការ​ហៅ​មិន​ត្រូវ​បាន​ធ្វើ​សមកាលកម្ម​រវាង​ឧបករណ៍​តាម​លំនាំដើម​ទេ។';

  @override
  String get callFilterRules => 'ច្បាប់​តម្រង​ការ​ហៅ';

  @override
  String get callFilterRulesDescription =>
      'កំណត់​ច្បាប់​ជា​មូលដ្ឋាន​សម្រាប់​តម្រង​ការ​ហៅ';

  @override
  String get callFilterSettings => 'ការ​កំណត់​តម្រង​ការ​ហៅ';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'កំណត់​ដែន​កំណត់​ប្រេកង់​ការ​ហៅ និង​ច្បាប់​ទប់ស្កាត់';

  @override
  String get callFrequencyInterceptionTitle => 'ការ​ទប់ស្កាត់​ប្រេកង់​ការ​ហៅ';

  @override
  String get callHistory => 'ប្រវត្តិ​ការ​ហៅ';

  @override
  String get callHistoryInfoDesc =>
      'នៅ​ទីនេះ​បង្ហាញ​ប្រវត្តិ​ការ​ហៅ​របស់​អ្នក រួម​ទាំង​ការ​ហៅ​ចូល ការ​ហៅ​ចេញ និង​ការ​ហៅ​ខកខាន។';

  @override
  String get callHistoryInfoTitle => 'ប្រវត្តិ​ការ​ហៅ';

  @override
  String callHistoryInitFailed(Object error) {
    return 'មិន​អាច​ចាប់ផ្ដើម​ប្រវត្តិ​ការ​ហៅ​បាន​ទេ៖ $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'មិន​អាច​ធ្វើ​បច្ចុប្បន្នភាព​ប្រវត្តិ​ការ​ហៅ​បាន​ទេ៖ $error';
  }

  @override
  String get callHistoryTab => 'ប្រវត្តិ​ការ​ហៅ';

  @override
  String get callHistoryTimelineEarlier => 'មុន​នេះ';

  @override
  String get callHistoryTimelineToday => 'ថ្ងៃ​នេះ';

  @override
  String get callHistoryTimelineYesterday => 'ម្សិលមិញ';

  @override
  String get callScreeningPermission => 'ការ​អនុញ្ញាត​ត្រួត​ពិនិត្យ​ការ​ហៅ';

  @override
  String get callScreeningPermissionDescription =>
      'ប្រើ​ដើម្បី​ត្រួត​ពិនិត្យ និង​ទប់ស្កាត់​ការ​ហៅ​សារ​ឥត​បាន​ការ។';

  @override
  String get callScreeningPermissionNotGranted =>
      'មិន​បាន​ផ្ដល់​ការ​អនុញ្ញាត​ត្រួត​ពិនិត្យ​ការ​ហៅ​ទេ វា​អាច​ប៉ះពាល់​ដល់​មុខងារ​របស់​កម្មវិធី។';

  @override
  String get callSettingsSubtitle =>
      'ការ​កំណត់​អត្តសញ្ញាណ​អ្នក​ហៅ ការ​តម្រង និង​ការ​ទប់ស្កាត់';

  @override
  String get callSettingsTitle => 'ការ​កំណត់​ការ​ហៅ';

  @override
  String get callStatistics => 'ស្ថិតិ​ការ​ហៅ';

  @override
  String get callTypeAnswered => 'បាន​ឆ្លើយ';

  @override
  String get callTypeBlocked => 'បាន​ទប់ស្កាត់';

  @override
  String get callTypeIconColor => 'ពណ៌​រូប​តំណាង​ប្រភេទ​ការ​ហៅ';

  @override
  String get callTypeMissed => 'ការ​ហៅ​ខកខាន';

  @override
  String get callTypeOutgoing => 'ការ​ហៅ​ចេញ';

  @override
  String get callTypePosition => 'ទីតាំង​ប្រភេទ​ការ​ហៅ';

  @override
  String get callTypeUnknown => 'មិន​ស្គាល់';

  @override
  String get cancelButton => 'បោះបង់';

  @override
  String get carRental => 'ជួល​រថយន្ត';

  @override
  String get carrier => 'ក្រុមហ៊ុន​ដឹក​ជញ្ជូន';

  @override
  String get carrierColor => 'ពណ៌​ក្រុមហ៊ុន​ដឹក​ជញ្ជូន';

  @override
  String get carrierFontSize => 'ទំហំ​អក្សរ​ក្រុមហ៊ុន​ដឹក​ជញ្ជូន';

  @override
  String get carrierPosition => 'ទីតាំង​ក្រុមហ៊ុន​ដឹក​ជញ្ជូន';

  @override
  String get changeLabel => 'ផ្លាស់ប្ដូរ​ស្លាក';

  @override
  String changePluginStatusFailed(Object error) {
    return 'មិន​អាច​ផ្លាស់ប្ដូរ​ស្ថានភាព​កម្មវិធី​ជំនួយ​បាន​ទេ៖ $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'មិន​អាច​ផ្លាស់ប្ដូរ​ស្ថានភាព​ការ​ជាវ​បាន​ទេ៖ $error';
  }

  @override
  String get changeTag => 'ផ្លាស់ប្ដូរ​ស្លាក';

  @override
  String get charity => 'អង្គការ​សប្បុរសធម៌';

  @override
  String chartMonthFormat(int month) {
    return 'ខែ $month';
  }

  @override
  String get chartOneDayAgo => '១ ថ្ងៃ​មុន';

  @override
  String get chartOneMonthAgo => '១ ខែ​មុន';

  @override
  String get chartOneWeekAgo => '១ សប្តាហ៍​មុន';

  @override
  String get chartTenDaysAgo => '១០ ថ្ងៃ​មុន';

  @override
  String get chartThreeDaysAgo => '៣ ថ្ងៃ​មុន';

  @override
  String get chartToday => 'ថ្ងៃ​នេះ';

  @override
  String get checkFileFormat => 'សូម​ពិនិត្យ​ទ្រង់ទ្រាយ​ឯកសារ ឬ​ការ​អនុញ្ញាត';

  @override
  String checkPermissionFailed(Object error) {
    return 'មិន​អាច​ត្រួត​ពិនិត្យ​ការ​អនុញ្ញាត​បាន​ទេ៖ $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'ជ្រើសរើស​សកម្មភាព​ទប់ស្កាត់​លំនាំដើម';

  @override
  String get clearAllData => 'លុប​ទិន្នន័យ​ទាំងអស់';

  @override
  String get clearAllDataConfirmation =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ទិន្នន័យ​កម្មវិធី​ទាំងអស់? សកម្មភាព​នេះ​មិន​អាច​យក​មក​វិញ​បាន​ទេ។';

  @override
  String get clearAllDataDescription => 'លុប​ទិន្នន័យ​កម្មវិធី​ទាំងអស់';

  @override
  String get clearAllDataLabel => 'លុប​ទិន្នន័យ​ទាំងអស់';

  @override
  String get clearFilter => 'លុប​តម្រង';

  @override
  String get clearLabelFilter => 'លុប​តម្រង​ស្លាក';

  @override
  String get clearLabelFilterButton => 'លុប​តម្រង​ស្លាក';

  @override
  String get closeButton => 'បិទ';

  @override
  String get cloudSync => 'ការ​ធ្វើ​សមកាលកម្ម​ពពក';

  @override
  String get cloudSyncAndBackupTitle =>
      'ការ​ធ្វើ​សមកាលកម្ម & ការ​បម្រុង​ទុក​ពពក';

  @override
  String get cloudSyncSettingsSubtitle =>
      'កំណត់​រចនាសម្ព័ន្ធ WebDAV, OneDrive និង Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'ការ​កំណត់​ការ​ធ្វើ​សមកាលកម្ម​ពពក';

  @override
  String get cloudSyncTitle => 'ការ​ធ្វើ​សមកាលកម្ម​ពពក';

  @override
  String get collapseLabelSelector => 'បង្រួម​អ្នក​ជ្រើសរើស​ស្លាក';

  @override
  String get collection => 'ការ​ប្រមូល​បំណុល';

  @override
  String get colorPickerTitle => 'ជ្រើសរើស​ពណ៌';

  @override
  String get configManagement => 'ការ​គ្រប់គ្រង​ការ​កំណត់​រចនាសម្ព័ន្ធ';

  @override
  String get configUpdated =>
      'ការ​កំណត់​រចនាសម្ព័ន្ធ​ត្រូវ​បាន​ធ្វើ​បច្ចុប្បន្នភាព';

  @override
  String get configurationAdvice =>
      'តាម​រយៈ​ការ​កំណត់​រចនាសម្ព័ន្ធ​ត្រឹមត្រូវ អ្នក​អាច​កំណត់​យុទ្ធសាស្ត្រ​តម្រង​ផ្សេងៗ​គ្នា​សម្រាប់​ស៊ីម​កាត​ការងារ និង​ស៊ីម​កាត​ផ្ទាល់ខ្លួន។';

  @override
  String get configureBackupOptions => 'កំណត់​រចនាសម្ព័ន្ធ​ជម្រើស​បម្រុង​ទុក';

  @override
  String get configureBackupOptionsSubtitle =>
      'កំណត់​រចនាសម្ព័ន្ធ​ជម្រើស​បម្រុង​ទុក';

  @override
  String get configureCloudSyncService =>
      'កំណត់​រចនាសម្ព័ន្ធ​សេវា​ធ្វើ​សមកាលកម្ម​ពពក';

  @override
  String get configureCloudSyncServiceHint =>
      'សូម​កំណត់​រចនាសម្ព័ន្ធ​សេវា​ធ្វើ​សមកាលកម្ម​ពពក​ដើម្បី​បើក​ដំណើរការ​ការ​ធ្វើ​សមកាលកម្ម​ច្រើន​ឧបករណ៍។';

  @override
  String get configureCloudSyncServiceMessage =>
      'សូម​កំណត់​រចនាសម្ព័ន្ធ​សេវា​ធ្វើ​សមកាលកម្ម​ពពក​ដើម្បី​បើក​ដំណើរការ​ការ​ធ្វើ​សមកាលកម្ម​ច្រើន​ឧបករណ៍។';

  @override
  String get configureSimCardFilterRules =>
      'កំណត់​រចនាសម្ព័ន្ធ​ច្បាប់​តម្រង​ស៊ីម​កាត';

  @override
  String get configureSyncServiceHint =>
      'សូម​កំណត់​រចនាសម្ព័ន្ធ​សេវា​ធ្វើ​សមកាលកម្ម​ក្នុង​ការ​កំណត់​ការ​ធ្វើ​សមកាលកម្ម​ពពក​ជាមុន​សិន';

  @override
  String get confirm => 'បញ្ជាក់';

  @override
  String get confirmBatchDeleteContacts =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ការ​ជ្រើសរើស';

  @override
  String get confirmButton => 'បញ្ជាក់';

  @override
  String get confirmDelete => 'បញ្ជាក់​ការ​លុប';

  @override
  String get confirmDeleteContact => 'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប';

  @override
  String get confirmDeleteContactName => 'បញ្ជាក់​ការ​លុប?';

  @override
  String get confirmDeleteFilter =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​តម្រង​នេះ?';

  @override
  String confirmDeleteLabel(Object name) {
    return 'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ស្លាក \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​កម្មវិធី​ជំនួយ \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​កម្មវិធី​ជំនួយ $count នេះ?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ច្បាប់​នេះ? សកម្មភាព​នេះ​មិន​អាច​យក​មក​វិញ​បាន​ទេ។';

  @override
  String get confirmDeleteSelectedContacts =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ទំនាក់ទំនង​ដែល​បាន​ជ្រើសរើស?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ច្បាប់​តម្រង SMS នេះ?';

  @override
  String get confirmDeleteSmsRule =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ច្បាប់ SMS នេះ?';

  @override
  String get confirmDeleteSubscription =>
      'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប​ការ​ជាវ​នេះ?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'តើ​អ្នក​ប្រាកដ​ទេ​ថា​អ្នក​ចង់​លុប $name?';
  }

  @override
  String get confirmPassword => 'បញ្ជាក់​ពាក្យ​សម្ងាត់';

  @override
  String get confirmPasswordLabel => 'បញ្ជាក់​ពាក្យ​សម្ងាត់';

  @override
  String get connectedStatus => 'បាន​ភ្ជាប់';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'ការ​តភ្ជាប់​បរាជ័យ៖ សូម​ពិនិត្យ​អាសយដ្ឋាន​ម៉ាស៊ីន​បម្រើ ឈ្មោះ​អ្នក​ប្រើ និង​ពាក្យ​សម្ងាត់';

  @override
  String get connectionFailedMessage => 'ការ​តភ្ជាប់​បរាជ័យ';

  @override
  String get connectionStatusLabel => 'ស្ថានភាព';

  @override
  String get connectionSuccessMessage => 'ការតភ្ជាប់ជោគជ័យ';

  @override
  String get contactAddSuccess => 'ទំនាក់ទំនងត្រូវបានបន្ថែមដោយជោគជ័យ';

  @override
  String get contactDeleted => 'ទំនាក់ទំនងត្រូវបានលុប';

  @override
  String get contactEditDialog => 'ការសន្ទនាបកស្រាយទំនាក់ទំនង';

  @override
  String get contactNameHint => 'បញ្ចូលឈ្មោះទំនាក់ទំនង (ជាជម្រើស)';

  @override
  String get contactNameLabel => 'ឈ្មោះ';

  @override
  String get contactNameOptional => 'ឈ្មោះទំនាក់ទំនង (ជាជម្រើស)';

  @override
  String get contactNotFound => 'រកមិនឃើញទំនាក់ទំនង';

  @override
  String get contacts => 'ទំនាក់ទំនង';

  @override
  String contactsDeleted(Object count) {
    return 'បានលុបទំនាក់ទំនង $count';
  }

  @override
  String get contactSettingsSubtitle =>
      'ការគ្រប់គ្រងទំនាក់ទំនង និងការកំណត់ស្លាក';

  @override
  String get contactSettingsTitle => 'ការកំណត់ទំនាក់ទំនង';

  @override
  String contactsLoadingFailed(Object error) {
    return 'មិនអាចផ្ទុកទំនាក់ទំនង៖ $error';
  }

  @override
  String get contactsManagement => 'ការគ្រប់គ្រងទំនាក់ទំនង';

  @override
  String get contactsManagementPageTitle => 'ទំព័រគ្រប់គ្រងទំនាក់ទំនង';

  @override
  String get contactsPageTitle => 'ការគ្រប់គ្រងទំនាក់ទំនង';

  @override
  String get contactsPermission => 'ការអនុញ្ញាតទំនាក់ទំនង';

  @override
  String get contactsPermissionDescription =>
      'ប្រើដើម្បីកំណត់អត្តសញ្ញាណការហៅទូរស័ព្ទទំនាក់ទំនង។';

  @override
  String get contactsTab => 'ទំនាក់ទំនង';

  @override
  String get contactSubscriptionDescription =>
      'ជាវបញ្ជីទំនាក់ទំនងតាមរយៈ URL អាប់ដេតព័ត៌មានទំនាក់ទំនង និងស្លាកដោយស្វ័យប្រវត្តិ។ គាំទ្រទិន្នន័យទ្រង់ទ្រាយ JSON។';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'មិនអាចផ្ទុកការជាវទំនាក់ទំនង៖ $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'ការជាវទំនាក់ទំនង';

  @override
  String get contactUpdateSuccess => 'ទំនាក់ទំនងត្រូវបានអាប់ដេតដោយជោគជ័យ';

  @override
  String get contactUs => 'ទាក់ទងមកយើង';

  @override
  String get content => 'ខ្លឹមសារ';

  @override
  String get contentRegex => 'ខ្លឹមសារ Regex';

  @override
  String get countColor => 'ពណ៌ចំនួន';

  @override
  String get countFontSize => 'ទំហំពុម្ពអក្សរចំនួន';

  @override
  String get countPosition => 'ទីតាំងចំនួន';

  @override
  String get country => 'ប្រទេស';

  @override
  String get countryNameColor => 'ពណ៌ឈ្មោះប្រទេស';

  @override
  String get countryNameFontSize => 'ទំហំពុម្ពអក្សរឈ្មោះប្រទេស';

  @override
  String get countryRegionNamePosition => 'ទីតាំងឈ្មោះប្រទេស/តំបន់';

  @override
  String get countrySelectionDialog => 'ការសន្ទនាជ្រើសរើសប្រទេស';

  @override
  String get countrySelectionDialogDescription =>
      'ប្រើដើម្បីជ្រើសរើសប្រទេសដើម្បីស្វែងរកព័ត៌មានអត្តសញ្ញាណអ្នកទូរស័ព្ទ';

  @override
  String get countThresholdDescription =>
      'កំណត់ចំនួនអប្បបរមាដែលទាមទារដើម្បីបង្កឱ្យមានសកម្មភាពត្រង';

  @override
  String get countThresholdLabel => 'ដែនកំណត់ចំនួន';

  @override
  String get countThresholdSettings => 'ការកំណត់ដែនកំណត់ចំនួន';

  @override
  String countThresholdValue(Object count) {
    return 'ដែនកំណត់ចំនួន៖ $count';
  }

  @override
  String get createdRules => 'ច្បាប់ដែលបានបង្កើត';

  @override
  String get csvFormat => 'ទ្រង់ទ្រាយ CSV';

  @override
  String get currentDeviceChip => 'បច្ចុប្បន្ន';

  @override
  String get currentDeviceLabel => 'ស្លាប៊ rekordឧបករណ៍បច្ចុប្បន្ន';

  @override
  String get currentDeviceTitle => 'ឧបករណ៍បច្ចុប្បន្ន';

  @override
  String get currentLabels => 'ស្លាប៊ rekordបច្ចុប្បន្ន៖';

  @override
  String get currentLanguage => 'ភាសា​បច្ចុប្បន្ន';

  @override
  String get currentPasswordLabel => 'ពាក្យសម្ងាត់បច្ចុប្បន្ន';

  @override
  String get customerService => 'សេវាកម្មអតិថិជន';

  @override
  String get customRange => 'ជួរផ្ទាល់ខ្លួន';

  @override
  String get dailyStatistics => 'ស្ថិតិប្រចាំថ្ងៃ';

  @override
  String get dailyStatisticsDesc =>
      'ទទួលបានស្ថិតិប្រចាំថ្ងៃអំពីការហៅ និងសារដែលត្រូវបានទប់ស្កាត់';

  @override
  String get dashboardTab => 'ផ្ទាំងគ្រប់គ្រង';

  @override
  String get dataAnalysis => 'ការវិភាគទិន្នន័យ';

  @override
  String get dataAnalysisDashboardPage =>
      'ទំព័រផ្ទាំងគ្រប់គ្រងការវិភាគទិន្នន័យ';

  @override
  String get dataExport => 'ការនាំចេញទិន្នន័យ';

  @override
  String dataLoadFailure(Object error) {
    return 'មិនអាចផ្ទុកទិន្នន័យ៖ $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'មិនអាចផ្ទុកទិន្នន័យ៖ $error';
  }

  @override
  String get dataMigration => 'ការផ្លាស់ទីលំនៅទិន្នន័យ';

  @override
  String get dataMigrationDescription =>
      'មុខងារនេះអនុញ្ញាតឱ្យអ្នកផ្ទេរទិន្នន័យទាំងអស់របស់អ្នករវាងឧបករណ៍។ បច្ចុប្បន្នអ្នកអាចប្រើមុខងារបម្រុងទុក និងស្តារឡើងវិញដើម្បីផ្លាស់ទីលំនៅទិន្នន័យរបស់អ្នកដោយដៃ។';

  @override
  String get dataMigrationDialogContent =>
      'មុខងារនេះអនុញ្ញាតឱ្យអ្នកផ្ទេរទិន្នន័យទាំងអស់របស់អ្នករវាងឧបករណ៍។ បច្ចុប្បន្នអ្នកអាចប្រើមុខងារបម្រុងទុក និងស្តារឡើងវិញដើម្បីផ្លាស់ទីលំនៅទិន្នន័យរបស់អ្នកដោយដៃ។';

  @override
  String get dataMigrationDialogTitle => 'ការផ្លាស់ទីលំនៅទិន្នន័យ';

  @override
  String get dataMigrationSectionTitle => 'ការផ្លាស់ទីលំនៅទិន្នន័យ';

  @override
  String get dataSourceReminder => 'ការរំលឹកប្រភពទិន្នន័យ';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ថ្ងៃ',
      one: '1 ថ្ងៃ',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days ថ្ងៃ VIP';
  }

  @override
  String get debtCollection => 'ការប្រមូលបំណុល';

  @override
  String get defaultPeriod => 'សប្តាហ៍';

  @override
  String get delete => 'លុប';

  @override
  String get deleteButton => 'លុប';

  @override
  String get deleteContact => 'លុបទំនាក់ទំនង';

  @override
  String deleteContactConfirm(Object name) {
    return 'តើអ្នកប្រាកដថាអ្នកចង់លុប $name?';
  }

  @override
  String get deleteContactConfirmation => 'តើអ្នកប្រាកដថាអ្នកចង់លុបទំនាក់ទំនង';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return 'តើអ្នកប្រាកដថាអ្នកចង់លុប $deviceName?';
  }

  @override
  String get deleteDeviceDialogTitle => 'លុបឧបករណ៍';

  @override
  String deleteFailed(Object error) {
    return 'លុបរងការខាតបង់៖ $error';
  }

  @override
  String get deleteFilter => 'លុបតម្រង';

  @override
  String get deleteLabel => 'លុបស្លាប៊ rekord';

  @override
  String deleteLabelFailed(Object error) {
    return 'មិនអាចលុបស្លាប៊ rekord៖ $error';
  }

  @override
  String get deletePlugin => 'លុបកម្មវិធីបន្ថែម';

  @override
  String deletePluginFailed(Object error) {
    return 'មិនអាចលុបកម្មវិធីបន្ថែម៖ $error';
  }

  @override
  String get deletePlugins => 'លុបកម្មវិធីបន្ថែម';

  @override
  String deletePluginsFailed(Object error) {
    return 'មិនអាចលុបកម្មវិធីបន្ថែម៖ $error';
  }

  @override
  String get deleteRule => 'លុបច្បាប់';

  @override
  String deleteRuleFailed(Object error) {
    return 'លុបរងការខាតបង់៖ $error';
  }

  @override
  String get deleteSelected => 'លុបដែលបានជ្រើសរើស';

  @override
  String get deleteSmsRule => 'លុបច្បាប់ SMS';

  @override
  String get deleteSubscription => 'លុបការជាវ';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'តើអ្នកប្រាកដថាអ្នកចង់លុបការជាវ \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'មិនអាចលុបការជាវ៖ $error';
  }

  @override
  String get deleteSuccess => 'លុបជោគជ័យ';

  @override
  String get delivery => 'ការដឹកជញ្ជូន';

  @override
  String get deviceDeletedSuccessfully => 'ឧបករណ៍ត្រូវបានលុបដោយជោគជ័យ';

  @override
  String get deviceDeletedSuccessfullyMessage => 'ឧបករណ៍ត្រូវបានលុបដោយជោគជ័យ';

  @override
  String get deviceIdLabel => 'លេខសម្គាល់ឧបករណ៍';

  @override
  String get deviceIDLabel => 'លេខសម្គាល់ឧបករណ៍';

  @override
  String get deviceManagementSubtitle => 'គ្រប់គ្រងការធ្វើសមកាលកម្មឧបករណ៍ច្រើន';

  @override
  String get deviceManagementTitle => 'ការគ្រប់គ្រងឧបករណ៍';

  @override
  String get deviceModelLabel => 'ម៉ូដែលឧបករណ៍';

  @override
  String get deviceName => 'ឈ្មោះឧបករណ៍';

  @override
  String get deviceNameCannotBeEmpty => 'ឈ្មោះឧបករណ៍មិនអាចទទេបាន';

  @override
  String get deviceNameHint => 'សូមបញ្ចូលឈ្មោះឧបករណ៍';

  @override
  String get deviceNameLabel => 'ឈ្មោះឧបករណ៍';

  @override
  String get deviceRenamedSuccessfully => 'បានប្តូរឈ្មោះឧបករណ៍ដោយជោគជ័យ';

  @override
  String get deviceRenamedSuccessfullyMessage => 'បានប្តូរឈ្មោះឧបករណ៍ដោយជោគជ័យ';

  @override
  String get devicesSyncedSuccessfully => 'បានធ្វើសមកាលកម្មឧបករណ៍ដោយជោគជ័យ';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'បានធ្វើសមកាលកម្មឧបករណ៍ដោយជោគជ័យ';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'បានធ្វើសមកាលកម្មឧបករណ៍ដោយជោគជ័យ';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'បានលុបការចុះឈ្មោះឧបករណ៍ដោយជោគជ័យ';

  @override
  String get dialogTitle => 'ការពន្យល់គំរូ Regex';

  @override
  String get differentFromLocalCounter =>
      'មុខងារនេះខុសពីតម្រងរាប់ក្នុងមូលដ្ឋាន ដោយសារវាកផ្តោតលើលំនាំការហៅទូរស័ព្ទដែលកើតឡើងម្តងហើយម្តងទៀតក្នុងរយៈពេលខ្លី ជាជាងចំនួនកំណត់ចំណាំរយៈពេលវែង។';

  @override
  String get disabled => 'បានបិទ';

  @override
  String get disabledStatus => 'បានបិទ';

  @override
  String get disableGlobalPlugins => 'បិទកម្មវិធីជំនួយសកល';

  @override
  String get disableSubscriptionSuccessfully => 'បានបិទការជាវដោយជោគជ័យ';

  @override
  String get disconnectButton => 'ផ្តាច់';

  @override
  String get disconnectedMessage => 'បានផ្តាច់';

  @override
  String get disconnectedStatus => 'បានផ្តាច់';

  @override
  String get disconnectFailedMessage => 'ការផ្តាច់មិនបានជោគជ័យ';

  @override
  String get done => 'រួចរាល់';

  @override
  String get dualSimAdvice =>
      'មុខងារនេះមានប្រយោជន៍ជាពិសេសសម្រាប់ទូរស័ព្ទ Dual-SIM ដើម្បីកំណត់យុទ្ធសាស្ត្រតម្រងផ្សេងៗគ្នាសម្រាប់កាត SIM ការងារ និងផ្ទាល់ខ្លួន។';

  @override
  String get earlier => 'ពីមុន';

  @override
  String get ecommerce => 'ពាណិជ្ជកម្មអេឡិចត្រូនិក';

  @override
  String get edit => 'កែសម្រួល';

  @override
  String get editContact => 'កែសម្រួលទំនាក់ទំនង';

  @override
  String get editFilter => 'កែសម្រួលតម្រង';

  @override
  String get editLabel => 'កែសម្រួលស្លាក';

  @override
  String get editPhoneRule => 'កែសម្រួលច្បាប់ទូរស័ព្ទ';

  @override
  String get editPhoneRules => 'ប្រើដើម្បីកែសម្រួលច្បាប់ទូរស័ព្ទ';

  @override
  String get editPhoneRuleTitle => 'កែសម្រួលច្បាប់ទូរស័ព្ទ';

  @override
  String get editRule => 'កែសម្រួលច្បាប់';

  @override
  String get editSmsRule => 'កែសម្រួលច្បាប់ SMS';

  @override
  String get education => 'អប់រំ';

  @override
  String get elementPositionsSetting => 'ទីតាំងធាតុ';

  @override
  String get email => 'អ៊ីមែល';

  @override
  String get emailOptional => 'អ៊ីមែល (ជាជម្រើស)';

  @override
  String get enableCallFilter => 'បើកដំណើរការតម្រងការហៅទូរស័ព្ទ';

  @override
  String get enableCallFilterDescription =>
      'នៅពេលបើកដំណើរការ ការហៅទូរស័ព្ទចូលនឹងត្រូវបានពិនិត្យដោយប្រៀបធៀបជាមួយបញ្ជីច្បាប់ខាងក្រោម។ ច្បាប់តម្រងការហៅទូរស័ព្ទមិនត្រូវបានធ្វើសមកាលកម្មរវាងឧបករណ៍ដោយលំនាំដើមទេ។';

  @override
  String get enabled => 'បានបើក';

  @override
  String get enabledStatus => 'បានបើក';

  @override
  String get enableEncryption => 'បើកការអ៊ិនគ្រីប';

  @override
  String get enableEncryptionDescription => 'អ៊ិនគ្រីបឯកសារបម្រុងទុក';

  @override
  String get enableEncryptionLabel => 'បើកការអ៊ិនគ្រីប';

  @override
  String get enableEncryptionSubtitle => 'ឯកសារបម្រុងទុកនឹងត្រូវបានអ៊ិនគ្រីប';

  @override
  String get enableEncryptionTitle => 'បើកការអ៊ិនគ្រីប';

  @override
  String get enableGlobalPlugins => 'បើកកម្មវិធីជំនួយសកល';

  @override
  String get enableLocalCountFilter => 'បើកដំណើរការតម្រងរាប់ក្នុងមូលដ្ឋាន';

  @override
  String get enableLocalCountFilterDescription =>
      'តម្រងការហៅទូរស័ព្ទឥតបានការដោយស្វ័យប្រវត្តិដោយផ្អែកលើចំនួនកំណត់ចំណាំការហៅទូរស័ព្ទ';

  @override
  String get enableLocalNotification => 'ប្រើការជូនដំណឹងក្នុងមូលដ្ឋាន';

  @override
  String get enableLocalNotificationDescription =>
      'នៅពេលបើកដំណើរការ ការជូនដំណឹងសម្រាប់សារដែលបានតម្រងនឹងត្រូវបានបង្ហាញនៅលើឧបករណ៍';

  @override
  String get enableLocationSummary => 'ទីតាំង';

  @override
  String get enableMuteRules => 'បើកដំណើរការច្បាប់បិទសំឡេង';

  @override
  String get enableMuteRulesDesc =>
      'អនុវត្តការកំណត់រចនាសម្ព័ន្ធច្បាប់ទប់ស្កាត់ការបិទសំឡេង';

  @override
  String get enableNoneActionRules => 'បើកដំណើរការច្បាប់គ្មានសកម្មភាព';

  @override
  String get enableNoneActionRulesDesc =>
      'អនុញ្ញាតការកំណត់រចនាសម្ព័ន្ធច្បាប់ដោយគ្មានសកម្មភាពទប់ស្កាត់';

  @override
  String get enableNotifications => 'បើកដំណើរការការជូនដំណឹង';

  @override
  String get enableRemoteNumberFilter => 'បើកដំណើរការតម្រងលេខពីចម្ងាយ';

  @override
  String get enableRemoteNumberFilterDescription =>
      'ប្រើមូលដ្ឋានទិន្នន័យពីចម្ងាយដើម្បីតម្រងលេខ';

  @override
  String get enableRule => 'បើកដំណើរការច្បាប់';

  @override
  String get enableSmsFilter => 'បើកដំណើរការតម្រង SMS';

  @override
  String get enableSmsFilterDescription =>
      'នៅពេលបើកដំណើរការ សារនឹងត្រូវបានតម្រងដោយស្វ័យប្រវត្តិដោយយោងតាមច្បាប់';

  @override
  String get enableStatisticsNotifications => 'បើកដំណើរការការជូនដំណឹងស្ថិតិ';

  @override
  String get enableSubscriptionSuccessfully => 'បានបើកការជាវដោយជោគជ័យ';

  @override
  String get enableTimeInterception => 'បើកដំណើរការការទប់ស្កាត់ពេលវេលា';

  @override
  String get enableTimeInterceptionDescription =>
      'ទប់ស្កាត់ការហៅទូរស័ព្ទម្តងហើយម្តងទៀតក្នុងរយៈពេលខ្លី';

  @override
  String get enableTimeInterceptor => 'បើកដំណើរការឧបករណ៍ទប់ស្កាត់ពេលវេលា';

  @override
  String get endCallImmediately => 'បញ្ចប់ការហៅភ្លាមៗ';

  @override
  String get endColor => 'ពណ៌បញ្ចប់';

  @override
  String get endDate => 'កាលបរិច្ឆេទបញ្ចប់';

  @override
  String get enhancedFilterInstructionsTitle =>
      'ចំណារពន្យល់ប្រព័ន្ធតម្រងកែលម្អ';

  @override
  String get enhancedFilterSettings => 'ការកំណត់ប្រព័ន្ធតម្រងកែលម្អ';

  @override
  String get enhancedFilterSettingsTitle => 'ការកំណត់ប្រព័ន្ធតម្រងកែលម្អ';

  @override
  String get enhancedFilterSystemDescription =>
      'ប្រព័ន្ធតម្រងកែលម្អគាំទ្រទាំងច្បាប់សកល និងការកំណត់រចនាសម្ព័ន្ធតម្រងក្នុងមួយកាត SIM';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'សូមបញ្ចូលទាំងលេខទូរស័ព្ទ និងគំរូ Regex';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'សូមបញ្ចូលទាំងលេខទូរស័ព្ទ និងគំរូ Regex។';

  @override
  String get enterContactName => 'សូមបញ្ចូលឈ្មោះទំនាក់ទំនង';

  @override
  String get enterCurrentPasswordHint => 'សូមបញ្ចូលពាក្យសម្ងាត់បច្ចុប្បន្ន';

  @override
  String get enterDeviceName => 'បញ្ចូលឈ្មោះឧបករណ៍';

  @override
  String get enterDeviceNameHint => 'សូមបញ្ចូលឈ្មោះឧបករណ៍';

  @override
  String get enterEmail => 'សូមបញ្ចូលអ៊ីមែល';

  @override
  String get enterEmailOptional => 'សូមបញ្ចូលអ៊ីមែល (ជាជម្រើស)';

  @override
  String get enterEncryptionPasswordHint => 'បញ្ចូលពាក្យសម្ងាត់អ៊ិនគ្រីប';

  @override
  String get enterEncryptionPasswordTitle => 'បញ្ចូលពាក្យសម្ងាត់អ៊ិនគ្រីប';

  @override
  String get enterFilterName => 'សូមបញ្ចូលឈ្មោះតម្រង';

  @override
  String get enterFilterPattern => 'សូមបញ្ចូលគំរូតម្រង';

  @override
  String get enterIconCode => 'បញ្ចូលកូដរូបតំណាង';

  @override
  String get enterName => 'បញ្ចូលឈ្មោះទំនាក់ទំនង';

  @override
  String get enterNewDeviceNameHint => 'បញ្ចូលឈ្មោះថ្មីសម្រាប់ឧបករណ៍នេះ';

  @override
  String get enterNewPasswordHint => 'សូមបញ្ចូលពាក្យសម្ងាត់ថ្មី';

  @override
  String get enterPasswordAgain => 'បញ្ចូលពាក្យសម្ងាត់ម្តងទៀត';

  @override
  String get enterPasswordHint => 'សូមបញ្ចូលពាក្យសម្ងាត់';

  @override
  String get enterPhoneNumber => 'បញ្ចូលលេខទូរស័ព្ទ';

  @override
  String get enterPhoneNumberHint => 'បញ្ចូលលេខទូរស័ព្ទដើម្បីសាកល្បង';

  @override
  String get enterPhoneNumberMultiple =>
      'សូមបញ្ចូលលេខទូរស័ព្ទ លេខជាច្រើនបំបែកដោយសញ្ញាក្បៀស';

  @override
  String get enterPhoneNumberToStartSearch =>
      'បញ្ចូលលេខទូរស័ព្ទដើម្បីចាប់ផ្តើមស្វែងរក';

  @override
  String get enterPhoneNumberToVerify => 'បញ្ចូលលេខទូរស័ព្ទដើម្បីផ្ទៀងផ្ទាត់';

  @override
  String get enterPluginName => 'បញ្ចូលឈ្មោះកម្មវិធីជំនួយ';

  @override
  String get enterPluginUrl => 'បញ្ចូលអាសយដ្ឋាន URL របស់កម្មវិធីជំនួយ';

  @override
  String get enterRegexHint => 'បញ្ចូលគំរូ regex';

  @override
  String get enterRuleNameAndPattern => 'សូមបញ្ចូលឈ្មោះច្បាប់ និងគំរូ';

  @override
  String get enterRuleNameAndPatternMessage =>
      'សូមបញ្ចូលnému ក្បួន និងលំនាំ regex ទាំងពីរ។';

  @override
  String get enterRuleNameHint => 'បញ្ចូលឈ្មោះក្បួន';

  @override
  String get enterSearchContent => 'សូមបញ្ចូលមាតិកាស្វែងរក';

  @override
  String get enterSubscriptionName => 'បញ្ចូលឈ្មោះការជាវ';

  @override
  String get enterSubscriptionUrl => 'បញ្ចូល URL ការជាវ';

  @override
  String get enterSyncFolderNameHint =>
      'សូមបញ្ចូលឈ្មោះថតសម្រាប់ធ្វើសមកាលកម្ម (លំនាំដើម: NotificationManager)';

  @override
  String get entertainment => 'កម្សាន្ត';

  @override
  String get enterValidNameAndUrl => 'សូមបញ្ចូលឈ្មោះ និង URL ដែលត្រឹមត្រូវ';

  @override
  String get enterValidUrl => 'សូមបញ្ចូល URL ដែលត្រឹមត្រូវ';

  @override
  String get enterVersion => 'បញ្ចូលកំណែ';

  @override
  String get enterWebDAVPasswordHint => 'សូមបញ្ចូលលេខសម្ងាត់ WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'សូមបញ្ចូលអាសយដ្ឋានម៉ាស៊ីទ័រ WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'សូមបញ្ចូលឈ្មោះអ្នកប្រើ WebDAV';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'មានកំហុសក្នុងការលុបឧបករណ៍៖ $error';
  }

  @override
  String get errorLoadingPlugin => 'មានកំហុសក្នុងការផ្ទុកកម្មវិធីបន្ថែម';

  @override
  String errorOccurredMessage(Object error) {
    return 'មានកំហុសកើតឡើង៖ $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'មានកំហុសក្នុងការប្តូរឈ្មោះឧបករណ៍៖ $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'មានកំហុសក្នុងការធ្វើសមកាលកម្មឧបករណ៍៖ $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'មានកំហុសក្នុងការធ្វើសមកាលកម្មឧបករណ៍៖ $error';
  }

  @override
  String get errorText => 'កំហុស';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'មានកំហុសក្នុងការលុបការចុះឈ្មោះឧបករណ៍៖ $error';
  }

  @override
  String get exampleBlock400Prefix => 'ឧទាហរណ៍ ប្លុកលេខ 400 មុខ';

  @override
  String get exampleBlockMarketingSms => 'ឧទាហរណ៍ ប្លុក SMS ទីផ្សារ';

  @override
  String get exampleContentRegex => 'ឧទាហរណ៍, .*offer.*';

  @override
  String get exampleContentRegexHint => 'ឧទាហរណ៍ លំនាំ regex មាតិកា';

  @override
  String get exampleCouponPromotionDiscount =>
      'ឧទាហរណ៍ .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'ឧទាហរណ៍ គ្រួសារ, មិត្តភក្តិ, ល.';

  @override
  String get examplePhoneNumber => 'ឧទាហរណ៍ 10086, 12345, ល.';

  @override
  String get exampleRegex400Prefix => 'ឧទាហរណ៍ លំនាំ regex សម្រាប់លេខ 400 មុខ';

  @override
  String get exampleRegexFormat => 'ឧទាហរណ៍: ^10086\$';

  @override
  String get exampleSenderRegexHint => 'ឧទាហរណ៍';

  @override
  String get exchange => 'ផ្លាស់ប្តូរ';

  @override
  String get exchangeNow => 'ផ្លាស់ប្តូរឥឡូវនេះ';

  @override
  String get exchangeVip => 'ផ្លាស់ប្តូរ VIP';

  @override
  String get expandLabelSelector => 'ពង្រីកអ្នកជ្រើសរើសស្លាក';

  @override
  String expiryTime(Object time) {
    return 'ពេលវេលាផុតកំណត់៖ $time';
  }

  @override
  String get export => 'នាំចេញ';

  @override
  String get exportAllApplicationSettings => 'នាំចេញការកំណត់កម្មវិធីទាំងអស់';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'នាំចេញការកំណត់កម្មវិធីទាំងអស់';

  @override
  String get exportAllRuleConfigurations => 'នាំចេញការកំណត់ក្បួនទាំងអស់';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'នាំចេញការកំណត់ក្បួនទាំងអស់';

  @override
  String get exportComplete => 'ការនាំចេញបានបញ្ចប់';

  @override
  String get exportConfig => 'នាំចេញការកំណត់';

  @override
  String get exportContacts => 'នាំចេញទំនាក់ទំនង';

  @override
  String get exportData => 'នាំចេញទិន្នន័យ';

  @override
  String get exportError => 'កំហុសក្នុងការនាំចេញ';

  @override
  String get exportFailed => 'បរាជ័យក្នុងការនាំចេញ';

  @override
  String get exportFailure => 'បរាជ័យក្នុងការនាំចេញការកំណត់';

  @override
  String get exportFeatureComingSoon => 'មុខងារនាំចេញនឹងមកដល់ឆាប់ៗនេះ';

  @override
  String get exporting => 'កំពុងនាំចេញ...';

  @override
  String get exportLabels => 'នាំចេញស្លាក';

  @override
  String exportLabelsFailed(Object error) {
    return 'បរាជ័យក្នុងការនាំចេញស្លាក៖ $error';
  }

  @override
  String get exportPluginList => 'នាំចេញបញ្ជីកម្មវិធីបន្ថែម';

  @override
  String exportPluginListFailed(Object error) {
    return 'បរាជ័យក្នុងការនាំចេញបញ្ជីកម្មវិធីបន្ថែម៖ $error';
  }

  @override
  String get exportRules => 'នាំចេញក្បួន';

  @override
  String get exportRulesDialogTitle => 'នាំចេញក្បួន';

  @override
  String get exportRulesTitle => 'នាំចេញក្បួន';

  @override
  String get exportSmsRules => 'នាំចេញក្បួន SMS';

  @override
  String get exportStatisticsData => 'នាំចេញទិន្នន័យស្ថិតិ';

  @override
  String get exportSuccess => 'ការនាំចេញជោគជ័យ';

  @override
  String get exportSuccesslly => 'ការកំណត់ត្រូវបាននាំចេញដោយជោគជ័យ';

  @override
  String get failedToAddContact => 'បរាជ័យក្នុងការបន្ថែមទំនាក់ទំនង';

  @override
  String failedToAddRule(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមប��ួន៖ $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមប��ួន SMS៖ $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'បរាជ័យក្នុងការបន្ថែមការជាវ SMS៖ $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'បរាជ័យក្នុងការបម្រុងទុកការកំណត់៖ $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'បរាជ័យក្នុងការឌិកគ្រីបឯ��រ����������';

  @override
  String get failedToDeleteDevice => 'បរាជ័យក្នុងការលុបឧបករណ៍';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'បរាជ័យក្នុងការលុបប��ួន SMS៖ $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'បរាជ័យក្នុងការនាំចេញក្បួន៖ $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'បរាជ័យក្នុងការនាំចេញក្បួន SMS៖ $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'បរាជ័យក្នុងការទទួលព័����������������������';
  }

  @override
  String failedToImportRules(Object error) {
    return 'បរាជ័យក្នុងការនាំចូលក្បួន៖ $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'បរាជ័យក្នុងការនាំចូលក��������������';
  }

  @override
  String get failedToLoadContacts => 'បរាជ័យក្នុងការផ្ទុកទំនាក់ទំនង';

  @override
  String get failedToLoadPlugin => 'បរាជ័យក្នុងការផ្ទុកកម្មវិធីបន្ថែម';

  @override
  String get failedToRenameDevice => 'បរាជ័យក្នុងការប្តូរឈ្មោះឧបករណ៍';

  @override
  String get failedToRestoreSettings => 'បរាជ័យក្នុងការ������������';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'បរាជ័យក្នុងការ������������៖ $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'បរាជ័យក្នុងការកំណត់លេខសម្ងាត់៖ $error';
  }

  @override
  String get failedToSyncDevices => 'បរាជ័យក្នុងការធ្វើសមកាលកម្មឧបករណ៍';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'បរាជ័យក្នុងការប������������';
  }

  @override
  String get failedToToggleSubscriptionStatus => 'បរាជ័យក្នុងការប������������';

  @override
  String get failedToUpdateContact => 'បរាជ័យក្នុងការ����������';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'បរាជ័យក្នុងការ������������';
  }

  @override
  String get failure => 'បរាជ័យ';

  @override
  String get favoriteContacts => 'ទំនាក់ទំនងដែលចូលចិត្ត';

  @override
  String get featureAddRules => '• បន្ថែម������������';

  @override
  String get featureCenter => 'មជ្ឈមណ្ឌ����';

  @override
  String get featureEnableDisable => '• ������������';

  @override
  String get featureListTitle => 'មុខងារ៖';

  @override
  String get featureManageRules => '• ������������';

  @override
  String get features => 'មុខងារ';

  @override
  String get fetchingCallerIdInfo => 'កំព����������';

  @override
  String fileSavedTo(Object path) {
    return 'ឯ������������';
  }

  @override
  String get filter => '����������';

  @override
  String get filterByLabel => '����������';

  @override
  String get filterClear => '����������';

  @override
  String get filterControlPanelTitle => '����������';

  @override
  String get filterControlSubtitle => '����������';

  @override
  String get filterControlTitle => 'ការគ្រប់គ្រងតម្រង';

  @override
  String get filterDeleteFailed => 'លុបតម្រងមិនបានជោគជ័យ';

  @override
  String get filterDeleteSuccess => 'ល��តម្រងដោយជោគជ័យ';

  @override
  String get filterDetails => 'ព័��������������������';

  @override
  String get filtered => 'បានតម្រ����';

  @override
  String get filteredSms => 'សារ SMS ដែល��������';

  @override
  String get filteredSmsLabel => 'សារ SMS ដែល������';

  @override
  String get filterExplanation => 'ការព������������������';

  @override
  String get filterManagement => 'ការគ្រប់គ្រងតម្រ����';

  @override
  String get filterName => 'ឈ្មោះតម្រ����';

  @override
  String get filterPattern => 'គ������������������';

  @override
  String get filterPriorityNote =>
      'ចំណ���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������';

  @override
  String get filterSaveFailed => 'Filter save failed';

  @override
  String get filterSaveSuccess => 'Filter saved successfully';

  @override
  String get filterSettings => 'ការកំណត់រ������';

  @override
  String get filterSettingsTitle => 'ការកំណត់តម្រ����';

  @override
  String get filterSMS => 'តម្រ���� SMS';

  @override
  String get filterToggleInstructions =>
      'បើ����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filter: $filterName';
  }

  @override
  String get filterType => 'ប្រភេទ����';

  @override
  String get financial => 'ហ��������';

  @override
  String get flexibleCombinationFeature =>
      '• ��������������������������������������������������������';

  @override
  String get fontSizesSetting => '������������';

  @override
  String foundRules(Object count) {
    return '������ $count rules';
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
  String get globalFilterDescription =>
      'Configure global filters for all SIM cards:';

  @override
  String get globalFilterFeature =>
      '• Global Filters: Basic rules for all incoming calls';

  @override
  String get globalFilterSettings => 'Global Filter Settings';

  @override
  String get globalFilterToggleInstructions =>
      'Configure global filter settings that apply to all SIM slots:';

  @override
  String get globalSearchSubtitle =>
      'Search contacts, labels, blacklists, whitelists, etc.';

  @override
  String get globalSearchTitle => 'Global Search';

  @override
  String get globalSettings => 'Global Settings';

  @override
  String get googleAdDisplayPosition => 'Google Ad Display Position';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob ads can be integrated here';

  @override
  String get googleDriveAuthDescription =>
      'Authorize using system-configured Google Drive client ID and key';

  @override
  String get googleDriveAuthorizationHint =>
      'Authorize using system-configured Google Drive client ID and key';

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
  String get howItWorksPoint1 =>
      '• The system will automatically allow calls from the same number within the set time window';

  @override
  String get howItWorksPoint2 =>
      '• Shorter time windows result in stricter interception; longer time windows result in looser interception';

  @override
  String get howItWorksPoint3 =>
      '• The system checks call logs to determine if it\'s a repeated call';

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
  String get importRuleConfigurationsFromFile =>
      'Import Rule Configurations from File';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Import rule configurations from file';

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
  String get interceptionActionSettingsSubtitle =>
      'Set how blocked calls are handled';

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
  String get invalidLabel => 'ស្លាកដែលមិនត្រឹមត្រូវ';

  @override
  String get invalidRegexPattern => 'លំនាំ​អិច​ប្រេស​ដែល​មិន​ត្រឹមត្រូវ';

  @override
  String get invalidSenderRegex =>
      'លំនាំ​អិច​ប្រេស​អ្នក​ផ្ញើ​ដែល​មិន​ត្រឹមត្រូវ';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'ចូល Telegram 頻道和群組以獲取更多資訊';

  @override
  String get jsLogsTitle => 'កំណត់ហេតុ JS';

  @override
  String get jsonFormat => 'ទម្រង់ JSON';

  @override
  String get keepAllVersions => 'រក្សា​កំណែ​ទាំងអស់';

  @override
  String get keepAllVersionsDescription =>
      'រក្សា​កំណែ​ប្រវត្តិសាស្រ្ត​ទាំងអស់​នៃ​ការ​បម្រុង​ទុក​នីមួយៗ';

  @override
  String get keepAllVersionsLabel => 'រក្សា​កំណែ​ទាំងអស់';

  @override
  String get keepAllVersionsSubtitle =>
      'រក្សា​កំណែ​ប្រវត្តិសាស្រ្ត​នៃ​ការ​បម្រុង​ទុក​នីមួយៗ';

  @override
  String get keepAllVersionsTitle => 'រក្សា​កំណែ​ទាំងអស់';

  @override
  String get label => 'ស្លាក';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'ស្លាក \"$name\" ត្រូវបានបន្ថែមដោយជោគជ័យ';
  }

  @override
  String get labelCategories => 'ប្រភេទស្លាក';

  @override
  String get labelDeleted => 'ស្លាក​ត្រូវបាន​លុប';

  @override
  String get labelDescription =>
      'ស្លាក​ជួយ​អ្នក​គ្រប់គ្រង​ទំនាក់ទំនង​បាន​កាន់តែ​ប្រសើរ​ បន្ថែម​ស្លាក​ផ្ទាល់ខ្លួន​ទៅ​លេខ​ទូរស័ព្ទ​ដើម្បី​កំណត់​អត្តសញ្ញាណ​ការ​ហៅ​ទូរស័ព្ទ​និង​សារ​បាន​យ៉ាង​ងាយស្រួល';

  @override
  String get labelFilter => 'តម្រង​ស្លាក';

  @override
  String get labelFilterTooltip => 'តម្រង​ស្លាក';

  @override
  String get labelIconColor => 'ពណ៌​រូបតំណាង​ស្លាក';

  @override
  String get labelManagement => 'ការ​គ្រប់គ្រង​ស្លាក';

  @override
  String get labelNotFound => 'រក​មិនឃើញ​ស្លាក';

  @override
  String get labelRemoved => 'ស្លាក​ត្រូវបាន​ដកចេញ';

  @override
  String labelRemoveFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ដកចេញ​ស្លាក៖ $error';
  }

  @override
  String get labels => 'ស្លាក';

  @override
  String get labelsColor => 'ពណ៌​ស្លាក';

  @override
  String labelsDeleted(Object count) {
    return 'លុប​ស្លាក​$count';
  }

  @override
  String get labelsExportedSuccessfully => 'នាំចេញ​ស្លាក​ដោយ​ជោគជ័យ';

  @override
  String get labelsFontSize => 'ទំហំ​ពុម្ព​អក្សរ​ស្លាក';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'បាន​នាំចូល​ស្លាក​$count ដោយ​ជោគជ័យ';
  }

  @override
  String get labelsPosition => 'ទីតាំង​ស្លាក';

  @override
  String labelTag(Object labelId) {
    return 'ស្លាក៖ $labelId';
  }

  @override
  String get labelUpdated => 'ស្លាក​ត្រូវបាន​ធ្វើបច្ចុប្បន្នភាព';

  @override
  String labelUpdateFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ធ្វើបច្ចុប្បន្នភាព​ស្លាក៖ $error';
  }

  @override
  String get labelUpdateSuccess =>
      'ស្លាក \"\$labelText\" ត្រូវបាន​ធ្វើបច្ចុប្បន្នភាព​ដោយ​ជោគជ័យ';

  @override
  String get languageSettings => 'ការ​កំណត់​ភាសា';

  @override
  String get languageSettingsSubtitle => 'ផ្លាស់ប្តូរ​ភាសា​បង្ហាញ​កម្មវិធី';

  @override
  String get languageSettingsTitle => 'ការ​កំណត់​ភាសា';

  @override
  String get last30Days => '30​ថ្ងៃ​ចុងក្រោយ';

  @override
  String get last7Days => '7​ថ្ងៃ​ចុងក្រោយ';

  @override
  String get lastSyncLabel => 'ការ​ធ្វើ​សមកាលកម្ម​ចុងក្រោយ';

  @override
  String lastUpdated(Object date) {
    return 'ធ្វើបច្ចុប្បន្នភាព​ចុងក្រោយ៖ $date';
  }

  @override
  String get lifetimeMembership => 'សមាជិកភាព​ពេញ​មួយជីវិត';

  @override
  String get lifetimeMembershipDescription =>
      'ការទិញ​តែមួយ​ដង​ปลด​សោរ​មុខងារ​ពិសេស​ទាំងអស់​និង​ការ​អាប់ដេត​នាពេល​អនាគត​ជា​រៀង​រហូត';

  @override
  String loadContactsFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ទំនាក់ទំនង៖ $error';
  }

  @override
  String get loadDataFailed => 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ទិន្នន័យ';

  @override
  String get loadFailed => 'បរាជ័យ​ក្នុងការ​ផ្ទុក';

  @override
  String get loading => 'កំពុង​ផ្ទុក...';

  @override
  String get loadingData => 'កំពុង​ផ្ទុក​ទិន្នន័យ...';

  @override
  String get loadingTags => 'កំពុង​ផ្ទុក​ស្លាក...';

  @override
  String loadLabelFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ស្លាក៖ $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ស្លាក៖ $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​លេខ​ទូរស័ព្ទ​ដែល​បាន​សម្គាល់៖ $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​លេខ​ទូរស័ព្ទ​ដែល​បាន​សម្គាល់៖ $error';
  }

  @override
  String get loadMore => 'ផ្ទុក​បន្ថែម';

  @override
  String get loadPluginButton => 'ផ្ទុក​កម្មវិធី​ជំនួយ';

  @override
  String loadPluginsFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​កម្មវិធី​ជំនួយ៖ $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ការ​កំណត់៖ $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ច្បាប់ SMS៖ $error';
  }

  @override
  String get loadStatusFailedMessage => 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ស្ថានភាព';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​ផ្ទុក​ការ​ជាវ៖ $error';
  }

  @override
  String get loan => 'ប្រាក់កម្ចី';

  @override
  String get localBackupTitle => 'ការ​បម្រុង​ទុក​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCounterFilter => 'តម្រង​ឧបករណ៍​រាប់​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCounterFilterSubtitle =>
      'ស្វ័យប្រវត្តិកម្ម​ច្រោះ​ការ​ហៅ​ដែល​មិន​ចង់បាន​ដោយ​ផ្អែក​លើ​ភាពញឹកញាប់​នៃ​ការ​ហៅ';

  @override
  String get localCountFilter => 'តម្រង​ចំនួន​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilterDescription =>
      'ទប់ស្កាត់​ការ​ហៅ​ញឹកញាប់​ដោយ​ផ្អែក​លើ​ចំនួន​លេខ​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilterExplanationContent =>
      'តម្រង​ចំនួន​ក្នុង​មូលដ្ឋាន​វិភាគ​កំណត់ហេតុ​ប្រវត្តិ​ការ​ហៅ​ដើម្បី​កំណត់​អត្តសញ្ញាណ​និង​ទប់ស្កាត់​ការ​ហៅ​ដែល​មិន​ចង់បាន​ញឹកញាប់​ដោយ​ស្វ័យប្រវត្តិកម្ម';

  @override
  String get localCountFilterExplanationTitle =>
      'ការពន្យល់​អំពី​តម្រង​ចំនួន​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• កំណត់​ថាតើ​ត្រូវ​ទប់ស្កាត់​ដោយ​ផ្អែក​លើ​តម្លៃ​ចំនួន​របស់​លេខ';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• នៅពេល​ចំនួន​របស់​លេខ​លើស​ពី​ដែន​កំណត់​ អ្នក​អាច​ជ្រើសរើស​ទប់ស្កាត់​ដោយ​ស្វ័យប្រវត្តិកម្ម';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• អ្នក​អាច​ជ្រើសរើស​អនុញ្ញាត​លេខ​ដែល​មិន​លើស​ពី​ដែន​';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• អ្នក​អាច​ជ្រើសរើស​ថាតើ​ត្រូវ​កត់ត្រា​កំណត់ហេតុ​សំណួរ​ទាំងអស់';

  @override
  String get localCountFiltering => 'ការ​ច្រោះ​តាម​ចំនួន​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilteringExplanation =>
      '• ការ​ច្រោះ​តាម​ចំនួន​ក្នុង​មូលដ្ឋាន៖ ច្បាប់​ច្រោះ​ដោយ​ផ្អែក​លើ​ចំនួន​សម្គាល់​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilterSettings => 'ការ​កំណត់​តម្រង​ចំនួន​ក្នុង​មូលដ្ឋាន';

  @override
  String get localCountFilterUseCases =>
      'តម្រង​នេះ​គឺ​សមរម្យ​ជាពិសេស​សម្រាប់​ការ​កំណត់​អត្តសញ្ញាណ​ការ​ហៅ​ដែល​មិន​ចង់បាន​ដោយ​ម៉ាស៊ីន​ស្វ័យប្រវត្តិ​និង​ការ​ហៅ​ទីផ្សារ';

  @override
  String get localFilterSettings => 'ការ​កំណត់​តម្រង​ក្នុង​មូលដ្ឋាន';

  @override
  String get localNotificationDisabled =>
      'ការ​ជូនដំណឹង​ក្នុង​មូលដ្ឋាន​ត្រូវបាន​បិទ';

  @override
  String get localNotificationEnabled =>
      'ការ​ជូនដំណឹង​ក្នុង​មូលដ្ឋាន​ត្រូវបាន​បើក';

  @override
  String get localServices => 'សេវា​ក្នុង​មូលដ្ឋាន';

  @override
  String get locationColor => 'ពណ៌​ទីតាំង';

  @override
  String get locationFontSize => 'ទំហំ​ពុម្ព​អក្សរ​ទីតាំង';

  @override
  String get locationIconColor => 'ពណ៌​រូបតំណាង​ទីតាំង';

  @override
  String get locationPosition => 'ទីតាំង​ទីតាំង';

  @override
  String get logAllLocalQueries => 'កត់ត្រា​សំណួរ​ក្នុង​មូលដ្ឋាន​ទាំងអស់';

  @override
  String get logAllLocalQueriesDescription =>
      'កត់ត្រា​កំណត់ហេតុ​សម្រាប់​សំណួរ​លេខ​ក្នុង​មូលដ្ឋាន​ទាំងអស់';

  @override
  String get logAllRemoteQueries => 'កត់ត្រា​សំណួរ​ពី​ចម្ងាយ​ទាំងអស់';

  @override
  String get logAllRemoteQueriesDescription =>
      'កត់ត្រា​ប្រតិបត្តិការ​សំណួរ​លេខ​ពី​ចម្ងាយ​ទាំងអស់';

  @override
  String get manage => 'គ្រប់គ្រង';

  @override
  String get manageContacts => 'គ្រប់គ្រង​ទំនាក់ទំនង';

  @override
  String get manageFavoriteContacts => 'គ្រប់គ្រង​ទំនាក់ទំនង​ដែល​ចូលចិត្ត';

  @override
  String get manageFilterRules => 'គ្រប់គ្រង​ច្បាប់​តម្រង';

  @override
  String get manageFilterRulesDescription =>
      'បន្ថែម​ កែសម្រួល​ ឬ​លុប​ច្បាប់​តម្រង SMS';

  @override
  String get manageFrequentContacts => 'គ្រប់គ្រង​ទំនាក់ទំនង​ញឹកញាប់';

  @override
  String get markCounts => 'ចំនួន​សម្គាល់';

  @override
  String get markCount => 'ចំនួន​សម្គាល់';

  @override
  String markedByCount(Object count) {
    return 'បាន​សម្គាល់​ដោយ​$count';
  }

  @override
  String get markedPhonesList => 'បញ្ជី​លេខ​ទូរស័ព្ទ​ដែល​បាន​សម្គាល់';

  @override
  String get markExchange => 'ផ្លាស់ប្តូរ​ស្លាក';

  @override
  String get markPhone => 'សម្គាល់​លេខ​ទូរស័ព្ទ';

  @override
  String markPhoneFailed(Object error) {
    return 'បរាជ័យ​ក្នុងការ​សម្គាល់​លេខ​ទូរស័ព្ទ៖ $error';
  }

  @override
  String get markPhoneManagementSubtitle => 'ដើម្បី​សម្គាល់​លេខ​ទូរស័ព្ទ';

  @override
  String get markPhoneManagementTitle => 'ការ​គ្រប់គ្រង​សម្គាល់​លេខ​ទូរស័ព្ទ';

  @override
  String get markPhoneSuccess => 'លេខ​ទូរស័ព្ទ​ត្រូវ​បាន​សម្គាល់​ដោយ​ជោគជ័យ';

  @override
  String get matchFailed => 'ការ​ផ្គូផ្គង​បរាជ័យ!';

  @override
  String get matchFailedMessage => 'ការ​ផ្គូផ្គង​បរាជ័យ។';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'ផ្គូផ្គង​ទ្រង់ទ្រាយ​លេខ​ពិសេស';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'ផ្គូផ្គង​លេខ​ជាមួយ​តួអក្សរ​ពិសេស៖';

  @override
  String get matchSpecificDigitPatterns => 'ផ្គូផ្គង​ទ្រង់ទ្រាយ XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle => 'ផ្គូផ្គង​លំនាំ​លេខ​ជាក់លាក់៖';

  @override
  String get matchSuccessful => 'ការ​ផ្គូផ្គង​ជោគជ័យ!';

  @override
  String get matchSuccessfulMessage => 'ការ​ផ្គូផ្គង​ជោគជ័យ!';

  @override
  String get medical => 'វេជ្ជសាស្ត្រ';

  @override
  String get membershipPrivileges => 'សិទ្ធិ​ជា​សមាជិក';

  @override
  String get migrationTool => 'ឧបករណ៍​ផ្លាស់ទី​ទិន្នន័យ';

  @override
  String get migrationToolTitle => 'ឧបករណ៍​ផ្លាស់ទី​ទិន្នន័យ';

  @override
  String get minutes => 'នាទី';

  @override
  String get month => 'ខែ';

  @override
  String get monthly => 'ប្រចាំខែ';

  @override
  String get monthlyCallCount => 'ការ​ហៅ​ទូរស័ព្ទ​ប្រចាំខែ';

  @override
  String get monthlyChartTitle => 'ការ​ហៅ​ទូរស័ព្ទ​ដែល​បាន​ទប់ស្កាត់​ប្រចាំខែ';

  @override
  String get monthlyMembership => 'សមាជិកភាព​ប្រចាំខែ';

  @override
  String get monthlyMembershipDescription =>
      'ដោះសោ​លក្ខណៈ​ពិសេស​ទាំងអស់​ដែល​ជា​បុព្វលាភ​ដោយ​ស្វ័យប្រវត្តិ​បន្ត​រៀងរាល់ខែ';

  @override
  String get monthlyTotal => 'សរុប​ប្រចាំខែ';

  @override
  String get monthlyTotalLabel => 'សរុប​ប្រចាំខែ';

  @override
  String get moreOptions => 'ជម្រើស​បន្ថែម';

  @override
  String get mute => 'បិទ​សំឡេង';

  @override
  String get name => 'ឈ្មោះ';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'ឈ្មោះ និង​លេខ​ទូរស័ព្ទ​មិន​អាច​ទទេ​បាន​ទេ';

  @override
  String get nameAndPhoneNumberRequired =>
      'ឈ្មោះ និង​លេខ​ទូរស័ព្ទ​ត្រូវ​បាន​ទាមទារ';

  @override
  String get nameColor => 'ពណ៌​ឈ្មោះ';

  @override
  String get nameFontSize => 'ទំហំ​ពុម្ព​អក្សរ​ឈ្មោះ';

  @override
  String nameLabel(Object name) {
    return 'ឈ្មោះ៖ $name';
  }

  @override
  String get namePosition => 'ទីតាំង​ឈ្មោះ';

  @override
  String get nameUnknown => 'ឈ្មោះ៖ មិន​ស្គាល់';

  @override
  String nameWithValue(String name) {
    return 'ឈ្មោះ៖ $name';
  }

  @override
  String get newPasswordLabel => 'ពាក្យសម្ងាត់​ថ្មី';

  @override
  String get nextStep => 'បន្ទាប់';

  @override
  String get noAction => 'គ្មាន​សកម្មភាព';

  @override
  String get noActionRules => 'គ្មាន​ច្បាប់​សកម្មភាព';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'គ្មាន​សេវា​ធ្វើ​សមកាលកម្ម​ពពក​សកម្ម';

  @override
  String get noCallLogs => 'គ្មាន​កំណត់ត្រា​ការ​ហៅ​ទូរស័ព្ទ';

  @override
  String get noCallRecords => 'គ្មាន​កំណត់ត្រា​ការ​ហៅ​ទូរស័ព្ទ';

  @override
  String get noContacts => 'មិន​ទាន់​មាន​ទំនាក់ទំនង';

  @override
  String get noContactsYet => 'មិន​ទាន់​មាន​ទំនាក់ទំនង';

  @override
  String get noData => 'គ្មាន​ទិន្នន័យ';

  @override
  String get noDevicesRegisteredMessage => 'មិន​មាន​ឧបករណ៍​ដែល​បាន​ចុះឈ្មោះ';

  @override
  String get noDevicesRegisteredYet => 'មិន​ទាន់​មាន​ឧបករណ៍​ដែល​បាន​ចុះឈ្មោះ។';

  @override
  String get noFilters => 'មិន​ទាន់​មាន​តម្រង';

  @override
  String get noLabels => 'មិន​ទាន់​មាន​ស្លាក';

  @override
  String get noMarkedPhones => 'គ្មាន​លេខ​ទូរស័ព្ទ​ដែល​បាន​សម្គាល់';

  @override
  String get noMatchingContacts => 'គ្មាន​ទំនាក់ទំនង​ដែល​ផ្គូផ្គង';

  @override
  String get noMatchingContactsFound => 'រក​មិន​ឃើញ​ទំនាក់ទំនង​ដែល​ផ្គូផ្គង';

  @override
  String get noMatchingNumbersFound => 'រក​មិន​ឃើញ​លេខ​ដែល​ផ្គូផ្គង';

  @override
  String get noMatchingRecords =>
      'គ្មាន​កំណត់ត្រា​ការ​ហៅ​ទូរស័ព្ទ​ដែល​ផ្គូផ្គង';

  @override
  String noMatchingRules(Object ruleType) {
    return 'គ្មាន​$ruleType​ដែល​ផ្គូផ្គង';
  }

  @override
  String get none => 'គ្មាន';

  @override
  String get noneServiceType => 'គ្មាន';

  @override
  String get noPlugins => 'មិន​ទាន់​មាន​កម្មវិធី​ជំនួយ';

  @override
  String get noRecords => 'គ្មាន​កំណត់ត្រា​ការ​ហៅ​ទូរស័ព្ទ';

  @override
  String get noResultReturned => 'មិន​មាន​លទ្ធផល​ត្រឡប់​មក​វិញ';

  @override
  String get noResultReturnedLog =>
      'មិន​មាន​លទ្ធផល​ត្រឡប់​មក​ពី​កម្មវិធី​ជំនួយ';

  @override
  String noRules(Object ruleType) {
    return 'មិន​ទាន់​មាន​$ruleType';
  }

  @override
  String get noRulesPrompt => 'រក​មិន​ឃើញ​ច្បាប់ សូម​បន្ថែម​ច្បាប់';

  @override
  String get noRulesToExport => 'គ្មាន​ច្បាប់​សម្រាប់​នាំចេញ';

  @override
  String get noSmsFilterRulesYet => 'មិន​ទាន់​មាន​ច្បាប់​តម្រង SMS';

  @override
  String get noSmsRulesYet => 'មិន​ទាន់​មាន​ច្បាប់ SMS';

  @override
  String get noSubscriptions => 'គ្មាន​ការ​ជាវ';

  @override
  String get noSubscriptionsYet => 'មិន​ទាន់​មាន​ការ​ជាវ';

  @override
  String get notGranted => 'មិន​បាន​ផ្តល់';

  @override
  String get notificationModeDescription =>
      'បង្ហាញ​ព័ត៌មាន​អ្នក​ហៅ​ក្នុង​របារ​ជូន​ដំណឹង';

  @override
  String get notificationPermission => 'ការ​អនុញ្ញាត​ការ​ជូន​ដំណឹង';

  @override
  String get notificationPermissionDescription =>
      'ប្រើ​ដើម្បី​បង្ហាញ​ការ​ជូន​ដំណឹង​ការ​ហៅ​ចូល និង​សារ។';

  @override
  String get notifications => 'ការ​ជូន​ដំណឹង';

  @override
  String get notificationSettings => 'ការ​កំណត់​ការ​ជូន​ដំណឹង';

  @override
  String get notificationSettingsSaved =>
      'ការ​កំណត់​ការ​ជូន​ដំណឹង​ត្រូវ​បាន​រក្សាទុក​ដោយ​ជោគជ័យ';

  @override
  String get notSet => 'មិន​បាន​កំណត់';

  @override
  String get notVerifiedText => 'មិន​បាន​ផ្ទៀងផ្ទាត់';

  @override
  String get noValidSmsRulesFoundInFile =>
      'រក​មិន​ឃើញ​ច្បាប់ SMS ដែល​មាន​សុពលភាព​ក្នុង​ឯកសារ';

  @override
  String get number => 'លេខ';

  @override
  String get numberColor => 'ពណ៌​លេខ';

  @override
  String get numberFontSize => 'ទំហំ​ពុម្ព​អក្សរ​លេខ';

  @override
  String get numberPosition => 'ទីតាំង​លេខ';

  @override
  String get numberSearch => 'ស្វែងរក​លេខ';

  @override
  String get numberTypeColor => 'ពណ៌​ប្រភេទ​លេខ';

  @override
  String get numberTypeFontSize => 'ទំហំ​ពុម្ព​អក្សរ​ប្រភេទ​លេខ';

  @override
  String get numberTypePosition => 'ទីតាំង​ប្រភេទ​លេខ';

  @override
  String get ok => 'យល់ព្រម';

  @override
  String get okButton => 'យល់ព្រម';

  @override
  String get onboardingCompleteDescription =>
      'អ្នក​គ្រប់គ្រង​សុវត្ថិភាព​ការ​ហៅ​ទូរស័ព្ទ​របស់​អ្នក​រួចរាល់​ហើយ ចាប់ផ្តើម​រីករាយ​នឹង​បទពិសោធន៍​ការ​ហៅ​ទូរស័ព្ទ​ប្រកបដោយ​សុវត្ថិភាព!';

  @override
  String get onboardingLanguageDescription =>
      'ជ្រើសរើស​ភាសា​ដែល​អ្នក​ពេញចិត្ត​សម្រាប់​បទពិសោធន៍​ល្អ​បំផុត។';

  @override
  String get onboardingPermissionsDescription =>
      'ដើម្បី​ផ្តល់​សេវា​ពេញលេញ យើង​ត្រូវការ​ការ​អនុញ្ញាត​ដូចខាងក្រោម៖';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'ទប់ស្កាត់​ការ​ហៅ​ទូរស័ព្ទ​សារ​ឥតបានការ​ដោយ​ចុច​តែ​ម្តង ប្តូរ​ច្បាប់​ទប់ស្កាត់ ហើយ​ផ្តល់​បរិយាកាស​ស្ងប់ស្ងាត់​ដល់​អ្នក។';

  @override
  String get onboardingSmartCallerIdDescription =>
      'កំណត់​អត្តសញ្ញាណ​ការ​ហៅ​ទូរស័ព្ទ​ដែល​មិន​ស្គាល់​ដោយ​ស្វ័យប្រវត្តិ សម្គាល់​លេខ​ដែល​គួរ​ឱ្យ​សង្ស័យ ហើយ​ការពារ​សុវត្ថិភាព​ការ​ហៅ​ទូរស័ព្ទ​របស់​អ្នក។';

  @override
  String get onboardingWelcomeDescription =>
      'អ្នក​ជំនាញ​គ្រប់គ្រង​ការ​ហៅ​ទូរស័ព្ទ​របស់​អ្នក ដែល​ផ្តល់​សេវា​កំណត់​អត្តសញ្ញាណ និង​ទប់ស្កាត់​ការ​ហៅ​ទូរស័ព្ទ​គ្រប់ជ្រុងជ្រោយ។';

  @override
  String get oneDriveAuthDescription =>
      'ផ្តល់​សិទ្ធិ​ដោយ​ប្រើ​អត្តសញ្ញាណ​អតិថិជន OneDrive ដែល​បាន​កំណត់​រចនាសម្ព័ន្ធ​ប្រព័ន្ធ និង​កូនសោ';

  @override
  String get oneDriveAuthorizationHint =>
      'ផ្តល់​សិទ្ធិ​ដោយ​ប្រើ​អត្តសញ្ញាណ​អតិថិជន OneDrive ដែល​បាន​កំណត់​រចនាសម្ព័ន្ធ​ប្រព័ន្ធ និង​កូនសោ';

  @override
  String get oneDriveConfigTitle => 'ការ​កំណត់​រចនាសម្ព័ន្ធ OneDrive';

  @override
  String get oneDriveConfigurationTitle => 'ការ​កំណត់​រចនាសម្ព័ន្ធ OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'ការជាវលេខសម្គាល់អ្នកហៅចូលតាមអ៊ីនធឺណិត';

  @override
  String get openAppSettings => 'បើកការកំណត់កម្មវិធី';

  @override
  String openAppSettingsFailed(Object error) {
    return 'បរាជ័យក្នុងការបើកការកំណត់កម្មវិធី៖ $error';
  }

  @override
  String operationFailed(Object error) {
    return 'ប្រតិបត្តិការបរាជ័យ៖ $error';
  }

  @override
  String get operationFailure => 'ប្រតិបត្តិការបរាជ័យ';

  @override
  String get operationSuccess => 'ប្រតិបត្តិការបានជោគជ័យ';

  @override
  String get other => 'ផ្សេងទៀត';

  @override
  String get ourOtherApps => 'កម្មវិធីផ្សេងទៀតរបស់យើង';

  @override
  String get overlayMode => 'បង្អួចអណ្តែត';

  @override
  String get overlayModeDescription =>
      'បង្ហាញព័ត៌មានអ្នកហៅចូលក្នុងបង្អួចអណ្តែត';

  @override
  String get overlayPermission => 'ការអនុញ្ញាតបង្អួចអណ្តែត';

  @override
  String get overlayPermissionDescription => 'ប្រើដើម្បីបង្ហាញបង្អួចហៅចូល។';

  @override
  String get overview => 'ទិដ្ឋភាពទូទៅ';

  @override
  String get password => 'ពាក្យសម្ងាត់';

  @override
  String get passwordCannotBeEmpty => 'ពាក្យសម្ងាត់មិនអាចទទេបានទេ';

  @override
  String get passwordLabel => 'ពាក្យសម្ងាត់';

  @override
  String get passwordsDoNotMatch => 'ពាក្យសម្ងាត់មិនស៊ីគ្នាទេ';

  @override
  String get passwordSetSuccessfully => 'បានកំណត់ពាក្យសម្ងាត់ដោយជោគជ័យ';

  @override
  String get pattern => 'គំរូ';

  @override
  String get pendingSync => 'កំពុងរង់ចាំការធ្វើសមកាលកម្ម';

  @override
  String get periodMonth => 'ខែ';

  @override
  String get periodWeek => 'សប្តាហ៍';

  @override
  String get periodYear => 'ឆ្នាំ';

  @override
  String get permissionDenied => 'សំណើអនុញ្ញាតត្រូវបានបដិសេធ';

  @override
  String get permissionGranted => 'ការអនុញ្ញាតត្រូវបានផ្តល់ជូន';

  @override
  String get permissionManagement => 'ការគ្រប់គ្រងការអនុញ្ញាត';

  @override
  String get phoneCallsTab => 'ទូរស័ព្ទ';

  @override
  String get phoneNumber => 'លេខទូរស័ព្ទ';

  @override
  String get phoneNumberCannotBeEmpty => 'លេខទូរស័ព្ទមិនអាចទទេបានទេ';

  @override
  String get phoneNumberHintText => 'បញ្ចូលលេខទូរស័ព្ទដើម្បីបន្ថែមច្បាប់';

  @override
  String get phoneNumberLabel => 'លេខទូរស័ព្ទ';

  @override
  String get phoneNumberRegexRequired =>
      'សូមបញ្ចូលទាំងលេខទូរស័ព្ទ និងគំរូ regex';

  @override
  String get phoneNumberTypeFixedLine => 'ទូរស័ព្ទស្ថានីយ';

  @override
  String get phoneNumberTypeFixedLineOrMobile =>
      'ទូរស័ព្ទស្ថានីយ ឬទូរស័ព្ទចល័ត';

  @override
  String get phoneNumberTypeMobile => 'ទូរស័ព្ទចល័ត';

  @override
  String get phoneNumberTypePager => 'ទូរសារ';

  @override
  String get phoneNumberTypePersonalNumber => 'លេខផ្ទាល់ខ្លួន';

  @override
  String get phoneNumberTypePremiumRate => 'អត្រាបុព្វលាភ';

  @override
  String get phoneNumberTypeSharedCost => 'ការចំណាយរួមគ្នា';

  @override
  String get phoneNumberTypeTollFree => 'ឥតគិតថ្លៃ';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'មិនស្គាល់';

  @override
  String get phoneNumberTypeVoicemail => 'សារជាសំឡេង';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'ការអនុញ្ញាតទូរស័ព្ទ';

  @override
  String get phonePermissionDescription =>
      'ប្រើដើម្បីកំណត់អត្តសញ្ញាណ និងទប់ស្កាត់ការហៅចូល។';

  @override
  String get phoneRule => 'ច្បាប់ទូរស័ព្ទ';

  @override
  String get phoneRuleEditDialog => 'ប្រអប់កែសម្រួលច្បាប់ទូរស័ព្ទ';

  @override
  String get phoneRuleManagement => 'ការគ្រប់គ្រងច្បាប់ទូរស័ព្ទ';

  @override
  String get phoneRuleSubscription => 'ការជាវច្បាប់ទូរស័ព្ទ';

  @override
  String get phoneSubscription => 'ការជាវទូរស័ព្ទ';

  @override
  String get phoneSubscriptionRulesDescription =>
      'ជាវបញ្ជីច្បាប់ទូរស័ព្ទតាមរយៈ URL ដើម្បីធ្វើបច្ចុប្បន្នភាពបញ្ជីសរុប និងបញ្ជីខ្មៅដោយស្វ័យប្រវត្តិ។ គាំទ្រឯកសារច្បាប់ក្នុងទម្រង់ JSON។';

  @override
  String get phoneSubscriptionTitle => 'ការជាវច្បាប់ទូរស័ព្ទ';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'សូមជ្រើសរើសស្លាក និងបញ្ចូលលេខទូរស័ព្ទត្រឹមត្រូវ';

  @override
  String pluginAddedSuccess(Object name) {
    return 'បានបន្ថែមកម្មវិធីជំនួយ \"$name\" ដោយជោគជ័យ';
  }

  @override
  String get pluginDeleted => 'បានលុបកម្មវិធីជំនួយ';

  @override
  String get pluginLatestVersion => 'កម្មវិធីជំនួយគឺជាកំណែចុងក្រោយបំផុតហើយ';

  @override
  String get pluginListExportSuccess => 'បាននាំចេញបញ្ជីកម្មវិធីជំនួយដោយជោគជ័យ';

  @override
  String get pluginLoadedSuccessfully => 'បានផ្ទុកកម្មវិធីជំនួយដោយជោគជ័យ';

  @override
  String get pluginManagement => 'ការគ្រប់គ្រងកម្មវិធីជំនួយ';

  @override
  String get pluginManagementSubtitle =>
      'គ្រប់គ្រង និងកំណត់រចនាសម្ព័ន្ធកម្មវិធីជំនួយភាគីទីបី';

  @override
  String get pluginManagementTitle => 'ការគ្រប់គ្រងកម្មវិធីជំនួយ';

  @override
  String get pluginName => 'ឈ្មោះកម្មវិធីជំនួយ';

  @override
  String get pluginNotLoaded =>
      'កម្មវិធីជំនួយមិនទាន់ត្រូវបានផ្ទុកទេ។ សូមផ្ទុកកម្មវិធីជំនួយជាមុនសិន។';

  @override
  String pluginsDeleted(Object count) {
    return 'បានលុបកម្មវិធីជំនួយ $count ដោយជោគជ័យ។';
  }

  @override
  String get pluginService => 'សេវាកម្មកម្មវិធីជំនួយ';

  @override
  String get pluginTestPageTitle => 'ការធ្វើតេស្តកម្មវិធីជំនួយ';

  @override
  String get pluginUpdateSuccess =>
      'បានធ្វើបច្ចុប្បន្នភាពកម្មវិធីជំនួយដោយជោគជ័យ';

  @override
  String get pluginUrl => 'URL កម្មវិធីជំនួយ';

  @override
  String get pluginUrlCannotBeEmpty => 'URL កម្មវិធីជំនួយមិនអាចទទេបានទេ';

  @override
  String get pluginUrlHint => 'បញ្ចូល URL កម្មវិធីជំនួយ';

  @override
  String get pluginUrlLabel => 'URL កម្មវិធីជំនួយ';

  @override
  String get pluginVersion => 'កំណែកម្មវិធីជំនួយ';

  @override
  String get political => 'នយោបាយ';

  @override
  String get powerfulSpamBlocking => 'ការទប់ស្កាត់សារឥតបានការដ៏មានអានុភាព';

  @override
  String get previousStep => 'មុន';

  @override
  String get prioritizeRemoteAction =>
      ' prioritizing action settings from the remote database';

  @override
  String get prioritizeRemoteActionDescription =>
      ' prioritize action settings from the remote database';

  @override
  String get processing => 'កំពុងដំណើរការ...';

  @override
  String get processingOperation => 'កំពុងដំណើរការ...';

  @override
  String get purchase => 'ទិញ';

  @override
  String get quarterlyMembership => 'សមាជិកភាពប្រចាំត្រីមាស';

  @override
  String get quarterlyMembershipDescription =>
      'ដោះសោមុខងារបុព្វលាភទាំងអស់ ធ្វើបច្ចុប្បន្នភាពដោយស្វ័យប្រវត្តិរៀងរាល់ត្រីមាស';

  @override
  String get queryButton => 'ស្វែងរក';

  @override
  String get queryFailed => 'ការស្វែងរកបរាជ័យ';

  @override
  String get queryFailedLog => 'ការស្វែងរកបរាជ័យ';

  @override
  String get querying => 'កំពុងស្វែងរក...';

  @override
  String get queryingPhoneNumber => 'កំពុងស្វែងរកលេខទូរស័ព្ទ';

  @override
  String get queryResultTitle => 'លទ្ធផលស្វែងរក';

  @override
  String get ready => 'រួចរាល់!';

  @override
  String get receiveWeeklyStatistics => 'ទទួលបានស្ថិតិប្រចាំសប្តាហ៍';

  @override
  String get recruiter => 'អ្នកជ្រើសរើសបុគ្គលិក';

  @override
  String get reEnterPasswordHint => 'សូមបញ្ចូលពាក្យសម្ងាត់ឡើងវិញ';

  @override
  String get refresh => 'ធ្វើបច្ចុប្បន្នភាព';

  @override
  String get refreshPermissionStatus => 'ធ្វើបច្ចុប្បន្នភាពស្ថានភាពការអនុញ្ញាត';

  @override
  String get refreshTooltip => 'ធ្វើបច្ចុប្បន្នភាព';

  @override
  String regexError(Object error) {
    return 'កំហុស Regex៖ $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'កំហុស Regex៖ $error';
  }

  @override
  String get regexPattern => 'ទម្រង់​正则表达式';

  @override
  String get regexPatternExplanation => 'ការពន្យល់​ទម្រង់​正则表达式';

  @override
  String get regexPatternExplanationButton => 'ការពន្យល់​ទម្រង់​正则表达式';

  @override
  String get regexPatternLabel => 'ទម្រង់​正则表达式';

  @override
  String get regexPatternsExamples =>
      'ប្រើ​វេយ្យាករណ៍​正则表达式​ស្តង់ដារ​ដើម្បី​កំណត់​ទម្រង់​។ ឧទាហរណ៍​៖';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'ទម្រង់​正则表达式​សម្រាប់​ការ​ផ្គូផ្គង​លេខ​ទូរស័ព្ទ';

  @override
  String get regexRule => 'ច្បាប់​正则表达式';

  @override
  String regexRuleAddFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​បន្ថែម​ច្បាប់​正则表达式​៖ $error';
  }

  @override
  String get regexRuleAddSuccess => 'បាន​បន្ថែម​ច្បាប់​正则表达式​ដោយ​ជោគជ័យ';

  @override
  String get regexRuleManagement => 'ការ​គ្រប់គ្រង​ច្បាប់​正则表达式';

  @override
  String get regexRuleNamePatternRequired =>
      'ឈ្មោះ​ច្បាប់​និង​ទម្រង់​正则表达式​មិន​អាច​ទទេ​បាន​ទេ';

  @override
  String get regexRules => 'ច្បាប់​正则表达式';

  @override
  String get regexTesterTitle => 'ឧបករណ៍​ทดสอบ​正则表达式';

  @override
  String regexValidationFailed(Object error) {
    return 'ការ​ផ្ទៀងផ្ទាត់​正则表达式​បរាជ័យ​៖ $error';
  }

  @override
  String get regexValidationSuccess => 'ការ​ផ្ទៀងផ្ទាត់​正则表达式​ជោគជ័យ';

  @override
  String get region => 'តំបន់';

  @override
  String get registeredDevicesTitle => 'ឧបករណ៍​ដែល​បាន​ចុះបញ្ជី';

  @override
  String get rejectAllCalls => 'បដិសេធ​ការ​ហៅ​ទាំងអស់';

  @override
  String get rejectAllCallsDescription =>
      'ពេល​បើក​, ការ​ហៅ​ទាំងអស់​នឹង​ត្រូវ​បាន​បដិសេធ​ដោយ​មាន​អាទិភាព​ខ្ពស់​បំផុត';

  @override
  String get rejectAllNumbers => 'បដិសេធ​លេខ​ទាំងអស់';

  @override
  String get rejectAllNumbersDesc => 'បដិសេធ​ការ​ហៅ​ចូល​ទាំងអស់​ពេល​បើក';

  @override
  String get rejectExceededNumbers => 'បដិសេធ​លេខ​ដែល​លើស​កំណត់';

  @override
  String get rejectExceededNumbersDescription =>
      'បដិសេធ​លេខ​ដោយ​ស្វ័យ​ប្រវត្តិ​ដែល​លើស​ពី​ចំនួន​កំណត់';

  @override
  String get remoteFilterSettings => 'ការ​កំណត់​តម្រង​ពី​ចម្ងាយ';

  @override
  String get remoteFilterSettingsPageTitle => 'ការ​កំណត់​តម្រង​លេខ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilter => 'តម្រង​លេខ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'តម្រង​នេះ​ប្រើ​មូលដ្ឋាន​ទិន្នន័យ​ពី​ចម្ងាយ​ឯករាជ្យ​ដើម្បី​ទទួល​បាន​ព័ត៌មាន​លេខ​ចុងក្រោយ​បំផុត​។';

  @override
  String get remoteNumberFilterDescription =>
      'ស្ទាក់​ចាប់​ការ​ហៅ​រំខាន​ដោយ​ផ្អែក​លើ​ព័ត៌មាន​មូលដ្ឋាន​ទិន្នន័យ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilterExplanationContent =>
      'តម្រង​លេខ​ពី​ចម្ងាយ​កំណត់​អត្តសញ្ញាណ​និង​ទប់ស្កាត់​ការ​ហៅ​សារ​ឥត​បាន​ការ​ដោយ​ការ​សាកសួរ​មូលដ្ឋាន​ទិន្នន័យ​ពី​ចម្ងាយ​ដោយ​ផ្អែក​លើ​ចំនួន​លេខ​។';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'ការពន្យល់​តម្រង​លេខ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• ចំនួន​កំណត់​៖ កំណត់​ដោយ​ផ្អែក​លើ​ភាព​ញឹកញាប់​នៃ​ការ​កើតឡើង​នៃ​លេខ';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• សកម្មភាព​តម្រង​៖ កំណត់​ពី​របៀប​ដោះស្រាយ​លេខ​ដែល​លើស​ពី​កំណត់';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• ការ​កំណត់​អាទិភាព​៖ កំណត់​អាទិភាព​សម្រាប់​សកម្មភាព​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilterFeatures => 'លក្ខណៈពិសេស​៖';

  @override
  String get remoteNumberFiltering => 'ការ​กรอง​លេខ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilteringExplanation =>
      '• ការ​กรอง​លេខ​ពី​ចម្ងាយ​៖ ច្បាប់​តម្រង​ផ្អែក​លើ​ព័ត៌មាន​មូលដ្ឋាន​ទិន្នន័យ​ពី​ចម្ងាយ';

  @override
  String get remoteNumberFilterSubtitle =>
      'កំណត់​អត្តសញ្ញាណ​ការ​ហៅ​សារ​ឥត​បាន​ការ​ដោយ​ប្រើ​មូលដ្ឋាន​ទិន្នន័យ​ពពក​និង​របាយការណ៍​សហគមន៍';

  @override
  String get removeAdsDescription =>
      'លុប​ការ​ផ្សាយ​ទាំងអស់​ជា​អចិន្ត្រៃយ៍​ក្នុង​កម្មវិធី​ដើម្បី​បទពិសោធន៍​កាន់តែ​រលូន';

  @override
  String get removeAdsTitle => 'លុប​ការ​ផ្សាយ';

  @override
  String get removedFromFavoriteContacts =>
      'បាន​ដក​ចេញ​ពី​ទំនាក់ទំនង​ដែល​ចូលចិត្ត';

  @override
  String get removedFromFavorites => 'បាន​ដក​ចេញ​ពី​ទំនាក់ទំនង​ដែល​ចូលចិត្ត';

  @override
  String get removeFavorite => 'លុប​ទំនាក់ទំនង​ដែល​ចូលចិត្ត';

  @override
  String get removeFromFavorites => 'ដក​ចេញ​ពី​ទំនាក់ទំនង​ដែល​ចូលចិត្ត';

  @override
  String get renameButton => 'ប្តូរ​ឈ្មោះ';

  @override
  String get renameDeviceDialogTitle => 'ប្តូរ​ឈ្មោះ​ឧបករណ៍';

  @override
  String get renameDeviceTitle => 'ប្តូរ​ឈ្មោះ​ឧបករណ៍';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'នេះ​នឹង​ជំនួស​ការ​កំណត់​បច្ចុប្បន្ន​ទាំងអស់​របស់​អ្នក​។ តើ​អ្នក​ប្រាកដ​ថា​ចង់​បន្ត​ទេ​?';

  @override
  String get requestAllPermissions => 'ស្នើសុំ​សិទ្ធិ​ទាំងអស់';

  @override
  String get requestPermission => 'ស្នើសុំ​សិទ្ធិ';

  @override
  String requestPermissionFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ស្នើសុំ​សិទ្ធិ​៖ $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count ពិន្ទុ';
  }

  @override
  String get reset => 'កំណត់​ឡើងវិញ';

  @override
  String get restore => 'ស្តារ​ឡើងវិញ';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'ស្តារ​ការ​កំណត់​កម្មវិធី​ឡើងវិញ​ពី​ការ​បម្រុង​ទុក';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'ស្តារ​ការ​កំណត់​កម្មវិធី​ឡើងវិញ​ពី​ការ​បម្រុង​ទុក';

  @override
  String get restoreButton => 'ស្តារ​ឡើងវិញ';

  @override
  String restoreFailedWithError(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ស្តារ​ពី​ពពក​៖ $error';
  }

  @override
  String get restoreFromCloud => 'ស្តារ​ឡើងវិញ​ពី​ពពក';

  @override
  String get restoreFromCloudDescription =>
      'ស្តារ​ការ​កំណត់​និង​ច្បាប់​ឡើងវិញ​ពី​កន្លែង​ផ្ទុក​ពពក';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ស្តារ​ពី​ពពក​៖ $error';
  }

  @override
  String get restoreFromCloudLabel => 'ស្តារ​ឡើងវិញ​ពី​ពពក';

  @override
  String get restoreFromCloudSuccess => 'បាន​ស្តារ​ឡើងវិញ​ពី​ពពក​ដោយ​ជោគជ័យ';

  @override
  String get restoreFromCloudTitle => 'ស្តារ​ឡើងវិញ​ពី​ពពក';

  @override
  String get restoreFromLocal => 'ស្តារ​ឡើងវិញ​ពី​ក្នុង​ស្រុក';

  @override
  String get restorePurchases => 'ស្តារ​ការ​ទិញ​ឡើងវិញ';

  @override
  String get restoreSectionTitle => 'ស្តារ​ឡើងវិញ';

  @override
  String get restoreSettings => 'ស្តារ​ការ​កំណត់​ឡើងវិញ';

  @override
  String get restoreSettingsConfirmation =>
      'នេះ​នឹង​ជំនួស​ការ​កំណត់​បច្ចុប្បន្ន​ទាំងអស់​របស់​អ្នក​។ តើ​អ្នក​ប្រាកដ​ថា​ចង់​បន្ត​ទេ​?';

  @override
  String get restoreSettingsDialogTitle => 'ស្តារ​ការ​កំណត់​ឡើងវិញ';

  @override
  String get restoreSettingsTitle => 'ស្តារ​ការ​កំណត់​ឡើងវិញ';

  @override
  String get restoreSuccessFromLocal =>
      'បាន​ស្តារ​ឡើងវិញ​ពី​ក្នុង​ស្រុក​ដោយ​ជោគជ័យ';

  @override
  String get restoreSuccessMessage => 'បាន​ស្តារ​ឡើងវិញ​ពី​ពពក​ដោយ​ជោគជ័យ';

  @override
  String get retry => 'ព្យាយាម​ម្ដង​ទៀត';

  @override
  String get ridesharing => 'ការ​ចែករំលែក​ការ​ជិះ';

  @override
  String get risk => 'ហានិភ័យ';

  @override
  String get robocall => 'ការ​ហៅ​ robo';

  @override
  String get ruleAction => 'សកម្មភាព​ច្បាប់';

  @override
  String get ruleAddButton => 'បន្ថែម​ច្បាប់';

  @override
  String get ruleAddedSuccess => 'បាន​បន្ថែម​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String ruleAddFailure(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​បន្ថែម​ច្បាប់​៖ $error';
  }

  @override
  String get ruleAddSuccess => 'បាន​បន្ថែម​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'តើ​អ្នក​ប្រាកដ​ថា​ចង់​លុប​ $ruleType នេះ​ទេ​?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'លុប​ច្បាប់';

  @override
  String get ruleDeletedSuccess => 'បាន​លុប​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String get ruleDeletedSuccessfully => 'បាន​លុប​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String ruleDeleteFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​លុប​ច្បាប់​៖ $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​លុប​ច្បាប់​៖ $error';
  }

  @override
  String get ruleDeleteSuccess => 'បាន​លុប​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String get ruleDisabledSuccessfully => 'បាន​បិទ​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String get ruleEnabledSuccessfully => 'បាន​បើក​ច្បាប់​ដោយ​ជោគជ័យ';

  @override
  String ruleLoadFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​ច្បាប់​៖ $error';
  }

  @override
  String get ruleManagement => 'ការ​គ្រប់គ្រង​ច្បាប់';

  @override
  String get ruleManagementTitle => 'ការ​គ្រប់គ្រង​ច្បាប់';

  @override
  String get ruleName => 'ឈ្មោះ​ច្បាប់';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'ឈ្មោះ​ច្បាប់​និង​ទម្រង់​正则表达式​នៃ​ខ្លឹមសារ​មិន​អាច​ទទេ​បាន​ទេ';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'ឈ្មោះ​ច្បាប់​និង​លេខ​ទូរស័ព្ទ​មិន​អាច​ទទេ​បាន​ទេ';

  @override
  String get ruleNameHint => 'ឧទាហរណ៍​៖ គ្រួសារ​, មិត្តភក្តិ​, ល​។';

  @override
  String get ruleNameLabel => 'ឈ្មោះ​ច្បាប់';

  @override
  String get ruleNamePatternRequired => 'សូម​បញ្ចូល​ឈ្មោះ​ច្បាប់​និង​ទម្រង់​';

  @override
  String get ruleNameRequired =>
      'ឈ្មោះ​ច្បាប់​និង​លេខ​ទូរស័ព្ទ​មិន​អាច​ទទេ​បាន​ទេ';

  @override
  String get ruleNotExist => 'ច្បាប់មិនមាន ឬត្រូវបានលុបចោល';

  @override
  String ruleNotFound(Object error) {
    return 'មិនរកឃើញច្បាប់៖ $error';
  }

  @override
  String get ruleSavedSuccessfully => 'រក្សាទុកច្បាប់ដោយជោគជ័យ!';

  @override
  String get ruleSavedSuccessMessage => 'រក្សាទុកច្បាប់ដោយជោគជ័យ!';

  @override
  String ruleSaveFailed(Object error) {
    return 'រក្សាទុកមិនបានសម្រេច៖ $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'រក្សាទុកមិនបានសម្រេច៖ $error';
  }

  @override
  String get ruleSaveSuccess => 'រក្សាទុកច្បាប់ដោយជោគជ័យ!';

  @override
  String get rulesExportedSuccessfully => 'បាននាំចេញច្បាប់ដោយជោគជ័យ';

  @override
  String rulesExportedTo(Object path) {
    return 'បាននាំចេញច្បាប់ទៅ៖ $path';
  }

  @override
  String get rulesImported => 'បាននាំចូលច្បាប់ដោយជោគជ័យ';

  @override
  String rulesImportedSuccessfully(Object count) {
    return 'បាននាំចូលច្បាប់ $count ដោយជោគជ័យ';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'មិនអាចនាំចូលច្បាប់បាន៖ $error';
  }

  @override
  String get ruleStatistics => 'ស្ថិតិច្បាប់';

  @override
  String ruleStatusChanged(Object status) {
    return 'ច្បាប់ $status ដោយជោគជ័យ';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'ប្រតិបត្តិការមិនបានសម្រេច៖ $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'ច្បាប់ $status ដោយជោគជ័យ';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'មិនអាចធ្វើបច្ចុប្បន្នភាពច្បាប់បាន៖ $error';
  }

  @override
  String get ruleUpdateSuccess => 'ធ្វើបច្ចុប្បន្នភាពច្បាប់ដោយជោគជ័យ';

  @override
  String get ruleVerification => 'ការផ្ទៀងផ្ទាត់ច្បាប់';

  @override
  String get save => 'រក្សាទុក';

  @override
  String get saveButton => 'រក្សាទុក';

  @override
  String get saveButtonLabel => 'រក្សាទុក';

  @override
  String get saveButtonText => 'រក្សាទុក';

  @override
  String saveFailed(Object error) {
    return 'រក្សាទុកមិនបានសម្រេច៖ $error';
  }

  @override
  String get saveFilter => 'រក្សាទុកតម្រង';

  @override
  String get saveSettings => 'រក្សាទុកការកំណត់';

  @override
  String saveSettingsFailed(Object error) {
    return 'មិនអាចរក្សាទុកការកំណត់បាន៖ $error';
  }

  @override
  String get scamsLikely => 'លទ្ធភាពនៃការបោកប្រាស់';

  @override
  String get search => 'ស្វែងរក';

  @override
  String get searchContacts => 'ស្វែងរកទំនាក់ទំនង';

  @override
  String searchError(Object error) {
    return 'កំហុសក្នុងការស្វែងរក៖ $error';
  }

  @override
  String get searchFilters => 'តម្រងស្វែងរក';

  @override
  String get searchForContacts => 'ស្វែងរកទំនាក់ទំនង';

  @override
  String get searchHint => 'ស្វែងរក...';

  @override
  String get searchSettingsSubtitle =>
      'ស្វែងរកទំនាក់ទំនង, ការដាក់ស្លាក, បញ្ជីខ្មៅ, បញ្ជីស, ល.';

  @override
  String get searchSettingsTitle => 'ការកំណត់ស្វែងរក';

  @override
  String get securityMessage =>
      'កុំទុកចិត្តការហៅទូរស័ព្ទណាមួយ។ តែងតែផ្ទៀងផ្ទាត់លេខសេវាអតិថិជនដោយឯករាជ្យ។ កុំចែករំលែកលេខសម្ងាត់, លេខកូដផ្ទៀងផ្ទាត់, លេខកាត, ឬព័ត៌មានផ្ទាល់ខ្លួន។';

  @override
  String get selectActionToPerform =>
      'ជ្រើសរើសសកម្មភាពដែលត្រូវអនុវត្ត នៅពេលច្បាប់ត្រូវគ្នា';

  @override
  String get selectActionWhenBlockingCalls =>
      'ជ្រើសរើសសកម្មភាព នៅពេលរារាំងការហៅទូរស័ព្ទ';

  @override
  String get selectActionWhenRuleMatches =>
      'ជ្រើសរើសសកម្មភាព នៅពេលច្បាប់ត្រូវគ្នា';

  @override
  String get selectAll => 'ជ្រើសរើសទាំងអស់';

  @override
  String get selectCountry => 'ជ្រើសរើសប្រទេស';

  @override
  String get selectDateRange => 'ជ្រើសរើសជួរកាលបរិច្ឆេទ';

  @override
  String get selectedDateRange => 'ជួរកាលបរិច្ឆេទដែលបានជ្រើសរើស';

  @override
  String selectedItems(Object count) {
    return '$count អង្គភាពបានជ្រើសរើស';
  }

  @override
  String get selectedLabel => 'បានជ្រើសរើស៖';

  @override
  String get selectExportFormat => 'ជ្រើសរើសទម្រង់នាំចេញ';

  @override
  String get selectLabel => 'ជ្រើសរើសស្លាក';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'សូមជ្រើសរើសស្លាក និងបញ្ចូលលេខទូរស័ព្ទដែលមានសុពលភាព';

  @override
  String get selectLanguage => 'ជ្រើសរើសភាសា';

  @override
  String get selectMultiple => 'ជ្រើសរើសច្រើន';

  @override
  String get selectPeriod => 'ជ្រើសរើសរយៈពេល';

  @override
  String get selectSimCard => 'ជ្រើសរើសកាត SIM';

  @override
  String get selectSimSlot => 'ជ្រើសរើសរន្ធ SIM';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'ជ្រើសរើសសកម្មភាពជាក់លាក់ នៅពេលរារាំងការហៅទូរស័ព្ទ';

  @override
  String get selectTag => 'ជ្រើសរើសស្លាក';

  @override
  String get selectTags => 'ជ្រើសរើសស្លាក';

  @override
  String get selectTrustedDataSource => 'សូមជ្រើសរើសប្រភពទិន្នន័យដែលទុកចិត្ត';

  @override
  String get selectYourLanguage => 'ជ្រើសរើសភាសារបស់អ្នក';

  @override
  String get sender => 'អ្នកផ្ញើ';

  @override
  String get senderRegexOptional => 'អ្នកផ្ញើ Regex (ស្រេចចិត្ត)';

  @override
  String get serverAddressLabel => 'អាសយដ្ឋានម៉ាស៊ីនមេ';

  @override
  String get serviceTypeContact => 'ការជាវទំនាក់ទំនង';

  @override
  String get serviceTypeLabel => 'ប្រភេទសេវា';

  @override
  String get serviceTypePhone => 'ការជាវទូរស័ព្ទ';

  @override
  String get serviceTypePlugin => 'ការធ្វើបច្ចុប្បន្នភាពកម្មវិធីជំនួយ';

  @override
  String get serviceTypeSms => 'ការជាវ SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'កំណត់';

  @override
  String get setEncryptionPassword => 'កំណត់លេខសម្ងាត់ការអ៊ិនគ្រីប';

  @override
  String get setEncryptionPasswordDescription =>
      'កំណត់លេខសម្ងាត់ការអ៊ិនគ្រីបសម្រាប់ការបម្រុងទុក និងការស្ដារឡើងវិញ';

  @override
  String get setEncryptionPasswordLabel => 'កំណត់លេខសម្ងាត់ការអ៊ិនគ្រីប';

  @override
  String get setEncryptionPasswordTitle => 'កំណត់លេខសម្ងាត់ការអ៊ិនគ្រីប';

  @override
  String get setPasswordButton => 'កំណត់';

  @override
  String get settings => 'ការកំណត់';

  @override
  String settingsBackedUpTo(Object path) {
    return 'ការកំណត់ត្រូវបានបម្រុងទុកទៅ៖ $path';
  }

  @override
  String get settingsLoaded => 'ការកំណត់ត្រូវបានផ្ទុក';

  @override
  String settingsLoadFailed(Object error) {
    return 'មិនអាចផ្ទុកការកំណត់បាន៖ $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'បានស្ដារការកំណត់ដោយជោគជ័យ។ សូមចាប់ផ្ដើមកម្មវិធីឡើងវិញ ដើម្បីឲ្យការផ្លាស់ប្ដូរមានប្រសិទ្ធភាព។';

  @override
  String get settingsSaved => 'ការកំណត់ត្រូវបានរក្សាទុក';

  @override
  String settingsSaveFailed(Object error) {
    return 'មិនអាចរក្សាទុកការកំណត់បាន៖ $error';
  }

  @override
  String get settingsTab => 'ការកំណត់';

  @override
  String get settingsTitle => 'ការកំណត់';

  @override
  String get setup => 'ការរៀបចំ';

  @override
  String get showContactEditDialogStaticMethod =>
      'វិធីសាស្ត្រឋិតិវន្ត ដើម្បីបង្ហាញប្រអប់កែសម្រួលទំនាក់ទំនង';

  @override
  String get showExplanation => 'បង្ហាញការពន្យល់';

  @override
  String get silence => 'ស្ងាត់';

  @override
  String get silenceAndNoAnswer => 'ស្ងាត់ និងគ្មានចម្លើយ';

  @override
  String get silenceNoAnswer => 'ស្ងាត់គ្មានចម្លើយ';

  @override
  String get silentCallVoiceClone => 'ការក្លូនសំឡេងហៅទូរស័ព្ទស្ងាត់';

  @override
  String get silentRules => 'ច្បាប់ស្ងាត់';

  @override
  String simCard(Object simNumber) {
    return 'កាត SIM $simNumber';
  }

  @override
  String get simCardColor => 'ពណ៌កាត SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• ការកំណត់រចនាសម្ព័ន្ធកាត SIM៖ កំណត់ច្បាប់ច្រោះឯករាជ្យសម្រាប់កាត SIM នីមួយៗ';

  @override
  String get simCardFilterRules => 'ច្បាប់ច្រោះកាត SIM';

  @override
  String get simCardFilterRulesDescription =>
      'កំណត់ច្បាប់ច្រោះផ្សេងៗគ្នា ដោយផ្អែកលើរន្ធ SIM';

  @override
  String get simCardFontSize => 'ទំហំពុម្ពអក្សរកាត SIM';

  @override
  String get simCardPosition => 'ទីតាំងកាត SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'មិនអាចផ្ទុកព័ត៌មានកាត SIM បាន៖ $error';
  }

  @override
  String get simRuleInstructions =>
      'ច្បាប់​រន្ធ SIM អនុញ្ញាត​ឱ្យ​អ្នក​កំណត់​រចនាសម្ព័ន្ធ​ច្បាប់​តម្រង​ឯករាជ្យ​សម្រាប់​រន្ធ SIM នីមួយៗ។';

  @override
  String get simRuleInstructionsTitle => 'ច្បាប់​រន្ធ SIM';

  @override
  String get simRuleManagement => 'ការ​គ្រប់គ្រង​ច្បាប់​រន្ធ SIM';

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
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​ទិន្នន័យ SIM៖ $error';
  }

  @override
  String get simSlotFilterConfiguration =>
      'ការ​កំណត់​រចនាសម្ព័ន្ធ​តម្រង​រន្ធ SIM';

  @override
  String get simSlotFilterConfigurationDescription =>
      'អនុញ្ញាត​ឱ្យ​កំណត់​ច្បាប់​តម្រង​តាម​រន្ធ SIM';

  @override
  String get simSlotFilterDescription =>
      'កំណត់​រចនាសម្ព័ន្ធ​ច្បាប់​តម្រង​ឯករាជ្យ​សម្រាប់​កាត SIM នីមួយៗ៖';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'ការ​កំណត់​រចនាសម្ព័ន្ធ​តម្រង​រន្ធ SIM $slotNumber';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​រន្ធ SIM៖ $error';
  }

  @override
  String get simSlotManagement => 'ការ​គ្រប់គ្រង​រន្ធ SIM';

  @override
  String simSlotOperationFailed(Object error) {
    return 'ប្រតិបត្តិការ​រន្ធ SIM ៖ $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'ទីតាំង​រន្ធ SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM Slot Rules: Independent filtering strategies per SIM';

  @override
  String get simSlotRuleListTitle => 'បញ្ជី​ច្បាប់​រន្ធ SIM';

  @override
  String get simSlotRuleManagement => 'ច្បាប់​រន្ធ SIM';

  @override
  String get simSlotRuleManagementTitle => 'ការ​គ្រប់គ្រង​ច្បាប់';

  @override
  String get simSlotSettings => 'ការ​កំណត់​រន្ធ SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'រន្ធ SIM $slotNumber';
  }

  @override
  String get skip => 'រំលង';

  @override
  String get smartCallerId => 'ការ​កំណត់​អត្តសញ្ញាណ​អ្នក​ហៅ​ទូរសព្ទ​ឆ្លាតវៃ';

  @override
  String get sms => 'សារ SMS';

  @override
  String get smsFilterDescription =>
      'ការ​ច្រោះ​សារ SMS ជួយ​អ្នក​ច្រោះ​សារ​ឥត​បាន​ការ​ដោយ​ស្វ័យ​ប្រវត្តិ​ និង​រក្សា​បញ្ជី​សារ​របស់​អ្នក​ឱ្យ​ស្អាត។ អ្នក​អាច​កំណត់​ច្បាប់​ច្រោះ​ និង​វិធី​ជូន​ដំណឹង។';

  @override
  String get smsFilterDisabled => 'ការ​ច្រោះ​សារ SMS ៖ ៖';

  @override
  String get smsFilterEnabled => 'ការ​ច្រោះ​សារ SMS ៖ ៖';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'បាន​បន្ថែម​ច្បាប់​ច្រោះ​សារ SMS ជោគជ័យ';

  @override
  String get smsFilterRules => 'ច្បាប់​ច្រោះ​សារ SMS';

  @override
  String get smsFilterSettings => 'ការ​កំណត់​រចនាសម្ព័ន្ធ​តម្រង​សារ SMS';

  @override
  String get smsHistory => 'ប្រវត្តិ​សារ SMS';

  @override
  String get smsManagement => 'ការ​គ្រប់គ្រង​សារ SMS';

  @override
  String get smsPermission => 'ការ​អនុញ្ញាត​សារ SMS';

  @override
  String get smsPermissionDescription => 'ប្រើ​ដើម្បី​ច្រោះ​សារ​ឥត​បាន​ការ។';

  @override
  String get smsRuleAddedSuccessfully => 'បាន​បន្ថែម​ច្បាប់​សារ SMS ជោគជ័យ';

  @override
  String get smsRuleDeletedSuccessfully => 'បាន​លុប​ច្បាប់​សារ SMS ជោគជ័យ';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​ច្បាប់​សារ SMS៖ $error';
  }

  @override
  String get smsRuleManagement => 'ការ​គ្រប់គ្រង​ច្បាប់​សារ SMS';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'បាន​នាំចេញ​ច្បាប់​សារ SMS ជោគជ័យ​ទៅ `$filePath`';
  }

  @override
  String get smsRulesImportedSuccessfully => 'បាន​នាំចូល​ច្បាប់​សារ SMS ជោគជ័យ';

  @override
  String get smsRuleSubscription => 'ការ​ជាវ​ច្បាប់​សារ SMS';

  @override
  String get smsRuleUpdatedSuccessfully =>
      'បាន​ធ្វើ​បច្ចុប្បន្នភាព​ច្បាប់​សារ SMS ជោគជ័យ';

  @override
  String get smsSettingsSubtitle =>
      'ការ​ច្រោះ​សារ SMS និង​ការ​ទប់ស្កាត់​ពាក្យ​គន្លឹះ';

  @override
  String get smsSettingsTitle => 'ការ​កំណត់​សារ SMS';

  @override
  String get smsSubscription => 'ការ​ជាវ​សារ SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'បាន​បន្ថែម​ការ​ជាវ​សារ SMS ជោគជ័យ';

  @override
  String get smsSubscriptionRulesDescription =>
      'ជាវ​បញ្ជី​ច្បាប់​សារ SMS តាម​រយៈ URL ដែល​គាំទ្រ​ការ​ផ្គូផ្គង​កន្សោម​ទៀងទាត់។ អ្នក​អាច​កំណត់​សកម្មភាព​ទប់ស្កាត់​ ឬ​អនុញ្ញាត។';

  @override
  String get smsTab => 'សារ SMS';

  @override
  String get somePermissionsDenied =>
      'ការ​ស្នើសុំ​ការ​អនុញ្ញាត​មួយ​ចំនួន​ត្រូវ​បាន​បដិសេធ';

  @override
  String get spamLikely => 'ទំនង​ជា​សារ​ឥត​បាន​ការ';

  @override
  String get startColor => 'ពណ៌​ចាប់ផ្ដើម';

  @override
  String get startDate => 'កាលបរិច្ឆេទ​ចាប់ផ្ដើម';

  @override
  String get startUsing => 'ចាប់ផ្ដើម​ប្រើ';

  @override
  String get statAnswered => 'បាន​ឆ្លើយ';

  @override
  String get statBlocked => 'បាន​ទប់ស្កាត់';

  @override
  String get staticMethodShowCallerIdDialog =>
      'វិធី​សាស្ត្រ​ថេរ​ដើម្បី​បង្ហាញ​ប្រអប់​ព័ត៌មាន​អត្តសញ្ញាណ​អ្នក​ហៅ';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'វិធី​សាស្ត្រ​ថេរ​ដើម្បី​បង្ហាញ​ប្រអប់​ជ្រើសរើស​ប្រទេស';

  @override
  String get staticMethodToDisplayDialog =>
      'វិធី​សាស្ត្រ​ថេរ​ដើម្បី​បង្ហាញ​ប្រអប់';

  @override
  String get statistics => 'ស្ថិតិ';

  @override
  String get statisticsExportFeatureComingSoon =>
      'មុខងារ​នាំចេញ​ស្ថិតិ​នឹង​មក​ដល់​ឆាប់ៗ​នេះ';

  @override
  String get statisticsGrid => 'តារាង​ស្ថិតិ';

  @override
  String get statisticsPageTitle => 'ការ​វិភាគ​ទិន្នន័យ';

  @override
  String get stirColor => 'ពណ៌ STIR';

  @override
  String get stirFontSize => 'ទំហំ​ពុម្ព STIR';

  @override
  String get stirPosition => 'ទីតាំង STIR';

  @override
  String get storagePermission => 'ការ​អនុញ្ញាត​ផ្ទុក';

  @override
  String get storagePermissionDescription =>
      'ប្រើ​ដើម្បី​រក្សា​ទុក​ការ​កំណត់​ និង​ច្បាប់។';

  @override
  String get subscribe => 'ជាវ';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'បាន​បន្ថែម​ការ​ជាវ \"$name\" ជោគជ័យ';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'តើ​អ្នក​ប្រាកដ​ថា​អ្នក​ចង់​លុប​ការ​ជាវ​នេះ​ទេ?';

  @override
  String get subscriptionDeleteConfirmTitle => 'លុប​ការ​ជាវ';

  @override
  String get subscriptionDeleted => 'បាន​លុប​ការ​ជាវ';

  @override
  String get subscriptionDeletedSuccessfully => 'បាន​លុប​ការ​ជាវ​ជោគជ័យ';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​លុប​ការ​ជាវ៖ $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'បាន​លុប​ការ​ជាវ';

  @override
  String get subscriptionEmptyState => 'មិន​មាន​ការ​ជាវ​ទេ';

  @override
  String get subscriptionEmptyText => 'មិន​ទាន់​មាន​ការ​ជាវ​ទេ';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​ការ​ជាវ៖ $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្ទុក​ការ​ជាវ៖ $error';
  }

  @override
  String get subscriptionManagementTitle => 'ការ​គ្រប់គ្រង​ការ​ជាវ';

  @override
  String get subscriptionName => 'ឈ្មោះ​ការ​ជាវ';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'ឈ្មោះ​ការ​ជាវ និង URL មិន​អាច​ទទេ។';

  @override
  String get subscriptionNameHint => 'បញ្ចូល​ឈ្មោះ​ការ​ជាវ';

  @override
  String get subscriptionPageTitle => 'ការ​គ្រប់គ្រង​ការ​ជាវ';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ផ្លាស់ប្ដូរ​ស្ថានភាព​ការ​ជាវ៖ $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ប្ដូរ​ស្ថានភាព​ការ​ជាវ៖ $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'បរាជ័យ​ក្នុង​ការ​ធ្វើ​បច្ចុប្បន្នភាព​ការ​ជាវ៖ $error';
  }

  @override
  String get subscriptionUpdateSuccess =>
      'បាន​ធ្វើ​បច្ចុប្បន្នភាព​ការ​ជាវ​ជោគជ័យ';

  @override
  String get subscriptionUrl => 'URL ការ​ជាវ';

  @override
  String get subscriptionUrlHint => 'បញ្ចូល​ URL ការ​ជាវ';

  @override
  String successfullyImportedRules(Object count) {
    return 'បាន​នាំចូល​ច្បាប់ $count ជោគជ័យ';
  }

  @override
  String get supportSync => 'គាំទ្រ​ការ​ធ្វើ​សមកាលកម្ម';

  @override
  String get survey => 'ការ​ស្ទង់​មតិ';

  @override
  String get syncDevicesButton => 'ធ្វើ​សមកាលកម្ម​ឧបករណ៍';

  @override
  String get syncFailed => 'បរាជ័យ​ក្នុង​ការ​ធ្វើ​សមកាលកម្ម';

  @override
  String get syncFailedMessage => 'បរាជ័យ​ក្នុង​ការ​ធ្វើ​សមកាលកម្ម';

  @override
  String get syncFolderNameHint =>
      'សូម​បញ្ចូល​ឈ្មោះ​ថត​ធ្វើ​សមកាលកម្ម (លំនាំដើម៖ NotificationManager)';

  @override
  String get syncFolderNameLabel => 'ឈ្មោះ​ថត​ធ្វើ​សមកាលកម្ម';

  @override
  String get synchronized => 'បាន​ធ្វើ​សមកាលកម្ម';

  @override
  String get syncing => 'កំពុង​ធ្វើ​សមកាលកម្ម...';

  @override
  String get syncNow => 'ធ្វើ​សមកាលកម្ម​ឥឡូវនេះ';

  @override
  String get syncNowButton => 'ធ្វើសមកាលកម្មឥឡូវនេះ';

  @override
  String get syncStatusTitle => 'ស្ថានភាពធ្វើសមកាលកម្ម';

  @override
  String get syncStatusUpdatedMessage => 'ស្ថានភាពធ្វើសមកាលកម្មត្រូវបានអាប់ដេត';

  @override
  String get syncSuccessful => 'ធ្វើសមកាលកម្មបានជោគជ័យ';

  @override
  String get syncSuccessMessage => 'ធ្វើសមកាលកម្មបានជោគជ័យ';

  @override
  String get syncWithCloudStorage => 'ធ្វើសមកាលកម្មជាមួយ Cloud Storage';

  @override
  String get syncWithCloudStorageSubtitle => 'ធ្វើសមកាលកម្មជាមួយ Cloud Storage';

  @override
  String get systemFeatures => 'លក្ខណៈពិសេសប្រព័ន្ធ៖';

  @override
  String get systemSettingsTitle => 'ការកំណត់ប្រព័ន្ធ';

  @override
  String get tabAll => 'ទាំងអស់';

  @override
  String get tabAnswered => 'បានទទួល';

  @override
  String get tabBlocked => 'បានទប់ស្កាត់';

  @override
  String get tabMissed => 'បានខកខាន';

  @override
  String get tabOutgoing => 'ការហៅចេញ';

  @override
  String tagLabel(String tag) {
    return 'ស្លាក៖ $tag';
  }

  @override
  String get tagsUpdated => 'ស្លាកត្រូវបានអាប់ដេត';

  @override
  String get takeaway => 'ចំណុចសំខាន់';

  @override
  String get telecommunication => 'ទូរគមនាគមន៍';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'ទីផ្សារទូរស័ព្ទ';

  @override
  String get testButton => 'សាកល្បង';

  @override
  String get testButtonLabel => 'សាកល្បង';

  @override
  String get testConnectionButton => 'សាកល្បងការតភ្ជាប់';

  @override
  String get textColorsSetting => 'ពណ៌អក្សរ និងស្លាក';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'This app is a powerful caller ID tool that allows you to identify and block unwanted calls.';

  @override
  String get thisWeek => 'សប្តាហ៍នេះ';

  @override
  String get timeInterceptor => 'ការស្ទាក់ចាប់តាមពេលវេលា';

  @override
  String get timeInterceptorDescription =>
      'ស្ទាក់ចាប់/អនុញ្ញាតការហៅទូរសព្ទដោយស្វ័យប្រវត្តិដោយផ្អែកលើភាពញឹកញាប់នៃការហៅទូរសព្ទ';

  @override
  String get timeInterceptorExplanation =>
      '• ឧបករណ៍ស្ទាក់ចាប់ពេលវេលា៖ ស្ទាក់ចាប់/អនុញ្ញាតការហៅទូរសព្ទដដែលៗក្នុងរយៈពេលខ្លី';

  @override
  String get timeInterceptorExplanationContent =>
      'មុខងារស្ទាក់ចាប់ភាពញឹកញាប់នៃការហៅទូរសព្ទ វិភាគភាពញឹកញាប់នៃការហៅទូរសព្ទ ដើម្បីកំណត់អត្តសញ្ញាណ និងស្ទាក់ចាប់/អនុញ្ញាតការហៅទូរសព្ទសារឥតបានការញឹកញាប់ដោយស្វ័យប្រវត្តិ។';

  @override
  String get timeInterceptorExplanationTitle =>
      'ការពន្យល់អំពីការស្ទាក់ចាប់ភាពញឹកញាប់នៃការហៅទូរសព្ទ';

  @override
  String get timeInterceptorSettingsTitle =>
      'ការកំណត់ការស្ទាក់ចាប់ភាពញឹកញាប់នៃការហៅទូរសព្ទ';

  @override
  String get timeInterceptorSubtitle =>
      'ស្ទាក់ចាប់ការហៅទូរសព្ទសារឥតបានការដែលមានសក្តានុពលដោយស្វ័យប្រវត្តិដោយផ្អែកលើភាពញឹកញាប់នៃការហៅទូរសព្ទ';

  @override
  String get timeInterceptorTitle => 'បើកការស្ទាក់ចាប់ភាពញឹកញាប់នៃការហៅទូរសព្ទ';

  @override
  String get timeWindowDescription =>
      'កំណត់ទំហំបង្អួចពេលវេលាសម្រាប់ការអនុញ្ញាតការហៅទូរសព្ទដដែលៗ។ ការហៅទូរសព្ទពីលេខដដែលៗក្នុងបង្អួចនេះនឹងត្រូវបានអនុញ្ញាត';

  @override
  String timeWindowLabel(int minutes) {
    return 'បង្អួចពេលវេលាស្ទាក់ចាប់ (នាទី)៖ $minutes';
  }

  @override
  String get timeWindowSetting =>
      'កំណត់ទំហំបង្អួចពេលវេលាសម្រាប់ការអនុញ្ញាតការហៅទូរសព្ទដដែលៗ។ ការហៅទូរសព្ទពីលេខដដែលៗក្នុងបង្អួចនេះនឹងត្រូវបានអនុញ្ញាត';

  @override
  String get today => 'ថ្ងៃនេះ';

  @override
  String get total => 'សរុប';

  @override
  String get totalBlocked => 'សរុបដែលបានទប់ស្កាត់';

  @override
  String get totalFiltered => 'សរុបដែលបានត្រង';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'ផ្ទេរទិន្នន័យរវាងឧបករណ៍ ឬវេទិកា';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'ផ្ទេរទិន្នន័យរវាងឧបករណ៍ ឬវេទិកា';

  @override
  String get travelTicketing => 'សំបុត្រធ្វើដំណើរ';

  @override
  String get trend => 'និន្នាការ';

  @override
  String get trendChart => 'គំនូសតាងនិន្នាការ';

  @override
  String get tutorial => 'ការបង្រៀន';

  @override
  String get type => 'ប្រភេទ';

  @override
  String get unassignedSIMCard => 'ស៊ីមកាតដែលមិនបានកំណត់';

  @override
  String get unknown => 'មិនស្គាល់';

  @override
  String get unknownLabel => 'ស្លាកមិនស្គាល់';

  @override
  String get unknownTag => 'ស្លាក៖ មិនស្គាល់';

  @override
  String get unregisterButton => 'លុបការចុះឈ្មោះ';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'តើអ្នកប្រាកដថាចង់លុបការចុះឈ្មោះ $deviceName ដែរឬទេ?';
  }

  @override
  String get unregisterDeviceTitle => 'លុបការចុះឈ្មោះឧបករណ៍';

  @override
  String get unsupportedFileFormat => 'ទម្រង់ឯកសារមិនត្រូវបានគាំទ្រ';

  @override
  String get update => 'អាប់ដេត';

  @override
  String get updateAllNow => 'អាប់ដេតទាំងអស់ឥឡូវនេះ';

  @override
  String get updateCallFilterConfig =>
      'អាប់ដេតការកំណត់រចនាសម្ព័ន្ធតម្រងការហៅទូរសព្ទ';

  @override
  String updateContactFailed(Object error) {
    return 'មិនអាចអាប់ដេតទំនាក់ទំនងបានទេ៖ $error';
  }

  @override
  String get updateFavoriteStatus => 'អាប់ដេតស្ថានភាពដែលពេញចិត្ត';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'មិនអាចអាប់ដេតស្ថានភាពដែលពេញចិត្តបានទេ៖ $error';
  }

  @override
  String get updateInterval => 'ចន្លោះពេលអាប់ដេត';

  @override
  String get updateLabelFailed => 'មិនអាចអាប់ដេតស្លាកបានទេ';

  @override
  String get updateNow => 'អាប់ដេតឥឡូវនេះ';

  @override
  String get updatePlugin => 'អាប់ដេត Plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'មិនអាចអាប់ដេត Plugin បានទេ៖ $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'មិនអាចអាប់ដេតក្បួនបានទេ៖ $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'មិនអាចអាប់ដេតការជាវបានទេ៖ $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service ត្រូវបានអាប់ដេតដោយជោគជ័យ ($count ក្បួន)';
  }

  @override
  String get updateTags => 'អាប់ដេតស្លាក';

  @override
  String get useCasesPoint1 =>
      '• កំណត់អត្តសញ្ញាណការហៅទូរសព្ទសារឥតបានការដែលហៅត្រឡប់ដោយស្វ័យប្រវត្តិ';

  @override
  String get useCasesPoint2 =>
      '• ស្ទាក់ចាប់ការហៅទូរសព្ទទីផ្សារដែលហៅច្រើនដងក្នុងរយៈពេលខ្លី';

  @override
  String get useCasesPoint3 =>
      '• ការពារការទម្លាក់គ្រាប់បែកតាមទូរស័ព្ទ និងការយាយី';

  @override
  String get useCasesTitle => 'ករណីប្រើប្រាស់៖';

  @override
  String get useGlobalSettings => 'ប្រើការកំណត់សកល';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'ឈ្មោះអ្នកប្រើប្រាស់';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'ប្រើវាក្យសម្ព័ន្ធ regex ស្តង់ដារដើម្បីកំណត់លំនាំ។ ឧទាហរណ៍៖';

  @override
  String get validateRegex => 'ផ្ទៀងផ្ទាត់ Regex';

  @override
  String get verificationFailedText => 'បរាជ័យ';

  @override
  String get verifiedText => 'បានផ្ទៀងផ្ទាត់';

  @override
  String get verify => 'ផ្ទៀងផ្ទាត់';

  @override
  String version(Object version) {
    return 'កំណែ៖ $version';
  }

  @override
  String get vipExchangeDescription =>
      'ប្ដូរសមាជិកភាព VIP ជាមួយនឹងចំនួនសម្គាល់លេខទូរសព្ទ';

  @override
  String get vipExchangeTitle => 'ប្តូរសម្គាល់ VIP';

  @override
  String get watchAd => 'មើលពាណិជ្ជកម្ម';

  @override
  String get watchAdForTemp => 'មើលពាណិជ្ជកម្មសម្រាប់ឯកសិទ្ធិបណ្ដោះអាសន្ន';

  @override
  String get watchAdForTempDescription =>
      'មើលពាណិជ្ជកម្មខ្លីមួយដើម្បីដោះសោមុខងារពិសេសមួយចំនួនជាបណ្ដោះអាសន្ន';

  @override
  String get webDAVConfigTitle => 'ការកំណត់រចនាសម្ព័ន្ធ WebDAV';

  @override
  String get webdavConfigurationTitle => 'ការកំណត់រចនាសម្ព័ន្ធ WebDAV';

  @override
  String get webdavPasswordHint => 'សូមបញ្ចូលពាក្យសម្ងាត់ WebDAV';

  @override
  String get webdavServerAddressHint => 'សូមបញ្ចូលអាសយដ្ឋានម៉ាស៊ីនមេ WebDAV';

  @override
  String get webdavUsernameHint => 'សូមបញ្ចូលឈ្មោះអ្នកប្រើប្រាស់ WebDAV';

  @override
  String get week => 'សប្តាហ៍';

  @override
  String get weekly => 'ប្រចាំសប្តាហ៍';

  @override
  String get weeklyBlockedCallsSummary =>
      'សេចក្តីសង្ខេបការហៅទូរសព្ទដែលបានទប់ស្កាត់ប្រចាំសប្តាហ៍';

  @override
  String get weeklyChartTitle => 'ការហៅទូរសព្ទដែលបានទប់ស្កាត់ប្រចាំសប្តាហ៍';

  @override
  String get weeklyReport => 'របាយការណ៍ប្រចាំសប្តាហ៍';

  @override
  String get weeklyReportDesc =>
      'ទទួលរបាយការណ៍សង្ខេបប្រចាំសប្តាហ៍អំពីសកម្មភាពទប់ស្កាត់ការហៅទូរសព្ទ';

  @override
  String get welcome => 'សូមស្វាគមន៍';

  @override
  String get whitelist => 'បញ្ជីអនុញ្ញាត';

  @override
  String get whitelistLabel => 'បញ្ជីអនុញ្ញាត';

  @override
  String get width => 'ទទឹង';

  @override
  String get wildcardMatchingDescription =>
      'ប្រើ \'.\' ដើម្បីផ្គូផ្គងតួអក្សរណាមួយ (ឧទាហរណ៍ \'123.456\' ផ្គូផ្គង 123-456)';

  @override
  String get wildcardMatchingTitle => 'ការផ្គូផ្គងវ៉ាយខាត:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'ការគាំទ្រវ៉ាយខាតសម្រាប់ការត្រងបត់បែន';

  @override
  String get windowSizeSetting => 'ទំហំបង្អួច';

  @override
  String get year => 'ឆ្នាំ';

  @override
  String get yearly => 'ប្រចាំឆ្នាំ';

  @override
  String get yearlyChartTitle => 'ការហៅទូរសព្ទដែលបានបិទប្រចាំឆ្នាំ';

  @override
  String get noSimCardsDetected => 'មិនបានរកឃើញស៊ីមកាតទេ';

  @override
  String get filterManagementDescription => 'កំណត់តម្រងការហៅទូរសព្ទ';

  @override
  String get callerIdCustomizationSubtitle =>
      'ប្ដូររូបរាង Caller ID តាមចំណង់ចំណូលចិត្ត';

  @override
  String get fraudAlerSettingTitle => 'ការកំណត់ការជូនដំណឹងក្លែងក្លាយ';

  @override
  String get fraudAlerSettingSubtitle => 'ដើម្បីកំណត់ការជូនដំណឹងក្លែងក្លាយ';

  @override
  String get enableFraudAlert => 'បើកការជូនដំណឹងក្លែងក្លាយ';

  @override
  String get enableFraudAlertDescription =>
      'ជូនដំណឹងសម្រាប់ការហៅទូរសព្ទដែលសង្ស័យថាជាការបោកប្រាស់';

  @override
  String get enableVibration => 'បើកការរំញ័រ';

  @override
  String get enableVibrationDescription =>
      'រំញ័រនៅពេលហៅទូរសព្ទដែលសង្ស័យថាជាការបោកប្រាស់';

  @override
  String get notificationSettingsTitle => 'ការកំណត់ការជូនដំណឹង';

  @override
  String get useLocalNotification => 'ប្រើការជូនដំណឹងក្នុងមូលដ្ឋាន';

  @override
  String get useLocalNotificationDescription =>
      'បើកការជូនដំណឹងក្នុងមូលដ្ឋានសម្រាប់ការហៅចូល';

  @override
  String get cancelLocalNotification => 'បិទការជូនដំណឹងក្នុងមូលដ្ឋាន';

  @override
  String get useStirNotification => 'ប្រើការជូនដំណឹងពី STIR';

  @override
  String get useStirNotificationDescription =>
      'បើកការជូនដំណឹង STIR សម្រាប់ការហៅចូល';

  @override
  String get cancelLocalNotificationDescription =>
      'បិទការជូនដំណឹងក្នុងមូលដ្ឋានដោយស្វ័យប្រវត្តិ';

  @override
  String get callerIdSettingsTitle => 'ការកំណត់ Caller ID';

  @override
  String get callerIdSettingsSubtitle =>
      'ដើម្បីកំណត់ការជូនដំណឹងការហៅចូល & របៀបបង្ហាញ';

  @override
  String get purchaseTitle => 'ទិញ';

  @override
  String get purchaseSubtitle => 'ដើម្បីទិញសេវាកម្ម';

  @override
  String get callerIdNotificationTitle => 'ព័ត៌មានការហៅចូល';

  @override
  String callerIdBody(String phoneNumber) {
    return 'លេខទូរសព្ទ: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'ការហៅដែលបានបិទ';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'ការហៅដែលបានបិទពី $phoneNumber';
  }

  @override
  String get stirVerified => 'បានផ្ទៀងផ្ទាត់';

  @override
  String get stirNotVerified => 'មិនបានផ្ទៀងផ្ទាត់';

  @override
  String get stirFailed => 'ការផ្ទៀងផ្ទាត់បរាជ័យ';

  @override
  String get stirUnknown => 'ស្ថានភាពផ្ទៀងផ្ទាត់មិនស្គាល់';

  @override
  String get stirVerificationTitle => 'ការផ្ទៀងផ្ទាត់ STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage សម្រាប់លេខ $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings => 'ការកំណត់សារសុវត្ថិភាពរំកិល';

  @override
  String get messageColor => 'ពណ៌សារ';

  @override
  String get messageFontSize => 'ទំហំអក្សរសារ';

  @override
  String get messagePosition => 'ទីតាំងសារ';

  @override
  String get containerWidth => 'ទទឹងប្រអប់';

  @override
  String get scrollSpeed => 'ល្បឿនរំកិល';

  @override
  String get enableSecurityMessage => 'បើកសារសុវត្ថិភាព';

  @override
  String get fraudAlertTitle => 'ការជូនដំណឹងក្លែងក្លាយ';

  @override
  String fraudAlertBody(String phoneNumber) {
    return 'ការហៅក្លែងក្លាយដែលសង្ស័យពី $phoneNumber';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'បរាជ័យក្នុងការផ្ទុកច្បាប់: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'បរាជ័យក្នុងការផ្ទុកកំណត់ហេតុការហៅ: $error';
  }

  @override
  String get noBlockedTypeData => 'គ្មានទិន្នន័យប្រភេទដែលបានបិទទេ';

  @override
  String importEntity(Object entityTypeName) {
    return 'នាំចូល $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName បាននាំចូលដោយជោគជ័យ សរុប $count កំណត់ត្រាបាននាំចូល';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'បរាជ័យក្នុងការនាំចូល $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'នាំចេញ $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName បាននាំចេញដោយជោគជ័យ';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'បរាជ័យក្នុងការនាំចេញ $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'សេវាកម្មធ្វើសមកាលកម្មពពក';

  @override
  String get membershipCenter => 'មជ្ឈមណ្ឌលសមាជិកភាព';

  @override
  String get redeemVipWithMarks => 'ប្តូរ VIP ដោយប្រើ Marks';

  @override
  String get currentMarkCount => 'ចំនួន Marks បច្ចុប្បន្ន';

  @override
  String get markMoreNumbersForMore =>
      'សម្គាល់លេខបន្ថែមដើម្បីទទួលបាន Marks បន្ថែម';

  @override
  String get noAds => 'គ្មានពាណិជ្ជកម្ម';

  @override
  String get cloudBackup => 'បម្រុងទុកពពក';

  @override
  String get callerIdEnhancement => 'ការពង្រឹង Caller ID';

  @override
  String get voiceRecognition => 'ការសម្គាល់សំឡេង';

  @override
  String get feature => 'លក្ខណៈពិសេស';

  @override
  String get normalUser => 'អ្នកប្រើប្រាស់ធម្មតា';

  @override
  String get vipUser => 'អ្នកប្រើប្រាស់ VIP';

  @override
  String get temporaryVip => 'VIP បណ្តោះអាសន្ន';

  @override
  String get removeAds => 'លុបពាណិជ្ជកម្ម';

  @override
  String get unknownAction => 'សកម្មភាពមិនស្គាល់';

  @override
  String get settingsBackup => 'ការបម្រុងទុកការកំណត់';

  @override
  String get allServicesStatusTitle => 'ស្ថានភាពសេវាកម្មបច្ចុប្បន្ន';

  @override
  String get allServicesStatusSubtitle =>
      'ស្ថានភាពបច្ចុប្បន្ននៃសេវាកម្មពពកនីមួយៗ';

  @override
  String get redirect => 'ប្តូរទិស';

  @override
  String get notify => 'ជូនដំណឹង';

  @override
  String get log => 'កំណត់ហេតុ';

  @override
  String get custom => 'ផ្ទាល់ខ្លួន';

  @override
  String get allowActionDescription =>
      'ការហៅទូរសព្ទនឹងត្រូវបានអនុញ្ញាត ទោះបីជាលេខនោះស្ថិតនៅក្នុងបញ្ជីបិទក៏ដោយ។';

  @override
  String get blockActionDescription =>
      'ការហៅទូរសព្ទនឹងត្រូវបានបិទ និងបង្ហាញនៅក្នុងកំណត់ហេតុការហៅ។';

  @override
  String get silenceActionDescription =>
      'ការហៅទូរសព្ទនឹងត្រូវបានបិទសំឡេង ប៉ុន្តែបង្ហាញនៅក្នុងកំណត់ហេតុការហៅ។';

  @override
  String get noneActionDescription =>
      'គ្មានសកម្មភាពពិសេសណាមួយនឹងត្រូវធ្វើសម្រាប់ការហៅទូរសព្ទនោះទេ។';

  @override
  String get redirectActionDescription =>
      'ប្តូរទិសការហៅទៅកាន់លេខដែលបានបញ្ជាក់។';

  @override
  String get labelActionDescription =>
      'បន្ថែមស្លាកទៅការហៅសម្រាប់ការកំណត់អត្តសញ្ញាណងាយស្រួល។';

  @override
  String get notifyActionDescription =>
      'ផ្ញើការជូនដំណឹងនៅពេលទទួលបានការហៅទូរសព្ទ។';

  @override
  String get logActionDescription =>
      'កត់ត្រាព័ត៌មានការហៅដោយមិនធ្វើសកម្មភាពផ្សេងទៀត។';

  @override
  String get customActionDescription => 'អនុវត្តសកម្មភាពផ្ទាល់ខ្លួន។';

  @override
  String get synced => 'ធ្វើសមកាលកម្មហើយ';

  @override
  String get needVipAccess => 'អ្នកត្រូវការសិទ្ធិ VIP ដើម្បីប្រើលក្ខណៈពិសេសនេះ';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'នាំចូល ឬនាំចេញទិន្នន័យ $entityTypeName';
  }

  @override
  String get importExportTitle => 'នាំចូល/នាំចេញ';

  @override
  String get noPhoneRules => 'មិនបានរកឃើញច្បាប់ទូរសព្ទទេ';

  @override
  String get noRegexRules => 'មិនបានរកឃើញច្បាប់ regex ទេ';

  @override
  String get noAllowedBlockedRules => 'មិនបានរកឃើញច្បាប់អនុញ្ញាត/បិទទេ';

  @override
  String get importExport => 'នាំចូល/នាំចេញ';

  @override
  String get filterByAction => 'ត្រងតាមសកម្មភាព';

  @override
  String get upgradeToVip => 'ដំឡើងទៅ VIP';

  @override
  String get batteryOptimizationPermission => 'ការបង្កើនប្រសិទ្ធភាពថ្ម';

  @override
  String get batteryOptimizationPermissionDescription =>
      'អនុញ្ញាតឱ្យកម្មវិធីដំណើរការក្នុងផ្ទៃខាងក្រោយដើម្បីផ្តល់សេវាកម្មដូចជា caller ID។';

  @override
  String get permissionTitle => 'សិទ្ធិពិសេស';

  @override
  String get permissionSubtitle =>
      'គ្រប់គ្រងសិទ្ធិត្រួតលើ និងការបង្កើនប្រសិទ្ធភាពថ្ម';

  @override
  String get themeSettingsTitle => 'ការកំណត់រូបរាង';

  @override
  String get themeSettingsSubtitle => 'ជ្រើសរើសរូបរាងដែលអ្នកចូលចិត្ត';

  @override
  String get databaseSyncTitle => 'ការធ្វើសមកាលកម្មមូលដ្ឋានទិន្នន័យ';

  @override
  String get countrySyncSettingsTitle =>
      'ការកំណត់ការធ្វើសមកាលកម្មមូលដ្ឋានទិន្នន័យតាមប្រទេស';

  @override
  String get countrySyncSettingsSubtitle =>
      'ជ្រើសរើសប្រទេសសម្រាប់ការធ្វើសមកាលកម្មទិន្នន័យ';

  @override
  String get countryDataDisclaimer =>
      'សូមចំណាំ៖ មូលដ្ឋានទិន្នន័យអាចមិនរួមបញ្ចូលទិន្នន័យសម្រាប់ប្រទេស ឬតំបន់ជាក់លាក់ទាំងអស់នោះទេ។';

  @override
  String get editSubscription => 'កែសម្រួលការជាវ';

  @override
  String get searchByNameOrPhoneNumber => 'ស្វែងរកតាមឈ្មោះ ឬលេខទូរស័ព្ទ';

  @override
  String get allowedBlockedRulesInfo =>
      'ច្បាប់អនុញ្ញាត/ទប់ស្កាត់ត្រូវបានប្រើដើម្បីផ្គូផ្គងការហៅទូរសព្ទទៅលេខទូរសព្ទជាក់លាក់ ដែលមានអាទិភាពខ្ពស់បំផុត។';

  @override
  String get searchPhoneRulesHint => 'ស្វែងរកច្បាប់ទូរស័ព្ទ';

  @override
  String get phoneRulesInfo =>
      'ច្បាប់ទូរស័ព្ទត្រូវបានប្រើដើម្បីផ្គូផ្គងការហៅទូរសព្ទទៅលេខទូរសព្ទជាក់លាក់ ដែលមានអាទិភាពទាបជាង។ មួយចំនួនបានមកពីការជាវ phoneRule';

  @override
  String get searchSubscriptionsHint => 'ស្វែងរកការជាវ';

  @override
  String get searchPluginsHint => 'ស្វែងរកកម្មវិធីជំនួយ';

  @override
  String get searchLabelsHint => 'ស្វែងរកស្លាក';

  @override
  String get pluginDescription => 'ការពិពណ៌នាកម្មវិធីជំនួយ';

  @override
  String get enterPluginDescription => 'បញ្ចូលការពិពណ៌នាកម្មវិធីជំនួយ';

  @override
  String get searchRegexRulesHint => 'ស្វែងរកច្បាប់ Regex';

  @override
  String get regexRulesInfo =>
      'ច្បាប់ Regex ត្រូវបានប្រើដើម្បីច្រោះការហៅទូរសព្ទដោយផ្អែកលើលំនាំ Regex។';

  @override
  String get searchMarkedPhonesHint => 'ស្វែងរកលេខទូរស័ព្ទដែលបានសម្គាល់';

  @override
  String get searchContactSubscriptionsHint => 'ស្វែងរកការជាវទំនាក់ទំនង';

  @override
  String get showAllContacts => 'បង្ហាញទំនាក់ទំនងទាំងអស់';

  @override
  String get showFavorites => 'បង្ហាញចំណូលចិត្ត';

  @override
  String get manualEntry => 'ព័ត៌មានបញ្ចូលដោយដៃ';

  @override
  String get scriptSaved => 'ស្គ្រីបត្រូវបានរក្សាទុក';

  @override
  String editScriptFor(String pluginName) {
    return 'កែសម្រួលស្គ្រីបសម្រាប់ $pluginName';
  }

  @override
  String get saveScript => 'រក្សាទុកស្គ្រីប';

  @override
  String get testPlugin => 'សាកល្បងកម្មវិធីជំនួយ';

  @override
  String get description => 'ការពិពណ៌នា';

  @override
  String get accessTargetUrl => 'ចូលប្រើ URL គោលដៅ';

  @override
  String get result => 'លទ្ធផល';

  @override
  String get editScript => 'កែសម្រួលស្គ្រីប';

  @override
  String get numberFormat => 'ទម្រង់លេខ';

  @override
  String get nationalNumber => 'លេខជាតិ';

  @override
  String get e164Number => 'លេខ E164';

  @override
  String get pluginRulesInfo =>
      'សម្រាប់សុវត្ថិភាព សូមប្រើកម្មវិធីជំនួយពីប្រភពដែលគួរឱ្យទុកចិត្តតែប៉ុណ្ណោះ។ មានអារម្មណ៍សេរីក្នុងការប្រើប្រាស់គំរូរបស់យើងដើម្បីបង្កើតកម្មវិធីជំនួយផ្ទាល់ខ្លួនរបស់អ្នក!';

  @override
  String get advancedMode => 'របៀបកម្រិតខ្ពស់';

  @override
  String get pleaseEnterAtLeastOneNumber => 'សូមបញ្ចូលយ៉ាងហោចណាស់មួយលេខ។';

  @override
  String get openInWebView => 'បើកក្នុង WebView';

  @override
  String get pluginLabel => 'ស្លាកកម្មវិធីជំនួយ';

  @override
  String get pluginID => 'លេខសម្គាល់';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'ពណ៌ផ្ទៃខាងក្រោយសារ';

  @override
  String get clearAllCallLogs => 'សម្អាតកំណត់ហេតុការហៅទូរសព្ទទាំងអស់';

  @override
  String get clearAllCallLogsConfirmation =>
      'បញ្ជាក់ដើម្បីសម្អាតកំណត់ហេតុការហៅទូរសព្ទទាំងអស់';

  @override
  String get allCallLogsCleared => 'កំណត់ហេតុការហៅទូរសព្ទទាំងអស់ត្រូវបានសម្អាត';

  @override
  String get unblocked => 'បានដោះប្លុក';

  @override
  String get blockNumber => 'ទប់ស្កាត់លេខ';

  @override
  String get blockNumberSuccess => 'ការទប់ស្កាត់លេខបានជោគជ័យ';

  @override
  String get blockNumberFailed => 'ការទប់ស្កាត់លេខបរាជ័យ';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'តើអ្នកប្រាកដថាចង់ដោះប្លុក $phoneNumber មែនទេ?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return 'កំពុងហៅទូរស័ព្ទ $phoneNumber...';
  }

  @override
  String get viewDetails => 'មើលលម្អិត';

  @override
  String get unblock => 'ដោះប្លុក';

  @override
  String get unblockNumber => 'ដោះប្លុកលេខ';

  @override
  String get unblockNumberSuccess => 'លេខត្រូវបានដោះប្លុកដោយជោគជ័យ';

  @override
  String get unblockNumberFailed => 'ការដោះប្លុកលេខបរាជ័យ';

  @override
  String get serviceNotAvailable => 'សេវាកម្មមិនមានទេ';

  @override
  String get callingNumberFailed => 'ការហៅទូរស័ព្ទបរាជ័យ';

  @override
  String get listView => 'ទិដ្ឋភាពបញ្ជី';

  @override
  String get timelineView => 'ទិដ្ឋភាពបន្ទាត់ពេលវេលា';

  @override
  String get nameCannotBeEmpty => 'ឈ្មោះមិនអាចទទេបានទេ';

  @override
  String get selectAction => 'ជ្រើសរើសសកម្មភាព';

  @override
  String get selectTargetService => 'ជ្រើសរើសសេវាកម្មគោលដៅ';

  @override
  String get callDetails => 'ព័ត៌មានលម្អិតនៃការហៅទូរស័ព្ទ';

  @override
  String get callType => 'ប្រភេទនៃការហៅទូរស័ព្ទ';

  @override
  String get callTime => 'ពេលវេលាហៅទូរស័ព្ទ';

  @override
  String get numberInvalidFormat => 'ទម្រង់លេខមិនត្រឹមត្រូវ';

  @override
  String get membershipFeature => 'មុខងារសមាជិកភាព';

  @override
  String get medium => 'មធ្យម';

  @override
  String get finalRisk => 'ហានិភ័យចុងក្រោយ';

  @override
  String get simState => 'ស្ថានភាពស៊ីម';

  @override
  String get ipCountry => 'ប្រទេស IP';

  @override
  String get simCountry => 'ប្រទេសស៊ីម';

  @override
  String get isRoaming => 'រ៉ូមីង';

  @override
  String get isNumberMatch => 'ផ្គូផ្គងលេខ';

  @override
  String get support => 'ជំនួយ';

  @override
  String get rewardedAdService => 'សេវាកម្មផ្សាយពាណិជ្ជកម្មដែលទទួលបានរង្វាន់';

  @override
  String get hasVipPrivilegeExceptAds =>
      'អ្នកមានសិទ្ធិ VIP រួចហើយ (លើកលែងតែការផ្សាយពាណិជ្ជកម្ម)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'អ្នកមានសិទ្ធិបណ្ដោះអាសន្នរួចហើយ ថ្ងៃផុតកំណត់៖ $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'អ្នកត្រូវមើលការផ្សាយពាណិជ្ជកម្ម $count បន្ថែមទៀតដើម្បីទទួលបានសិទ្ធិ VIP បណ្ដោះអាសន្ន';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'អ្នកត្រូវបានផ្តល់សិទ្ធិទិញបណ្ដោះអាសន្ន $days ថ្ងៃ។ ថ្ងៃផុតកំណត់៖ $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'សិទ្ធិទិញបណ្ដោះអាសន្នបានផុតកំណត់';

  @override
  String get loadingAd => 'កំពុងផ្ទុកការផ្សាយពាណិជ្ជកម្ម...';

  @override
  String get earnedTempVip => 'ទទួលបាន VIP បណ្ដោះអាសន្ន';

  @override
  String get vipExchangeService => 'សេវាកម្មប្តូរ VIP';

  @override
  String get marksInsufficient => 'ពិន្ទុមិនគ្រប់គ្រាន់ដើម្បីប្តូរ';

  @override
  String get invalidExchangeRule => 'ច្បាប់ប្តូរមិនត្រឹមត្រូវ';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'បានប្តូរជោគជ័យសម្រាប់ $description ថ្ងៃផុតកំណត់៖ $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'ការប្តូរបរាជ័យ៖ $error';
  }

  @override
  String get vip3DaysWithAds =>
      'VIP 3 ថ្ងៃជាមួយការផ្សាយពាណិជ្ជកម្ម (ធ្វើសមកាលកម្មតែប៉ុណ្ណោះ)';

  @override
  String get vip5DaysNoAds => 'VIP 5 ថ្ងៃពេញលេញគ្មានការផ្សាយពាណិជ្ជកម្ម';

  @override
  String get vip7DaysNoAds => 'VIP 7 ថ្ងៃពេញលេញគ្មានការផ្សាយពាណិជ្ជកម្ម';

  @override
  String get noNotifications => 'គ្មានការជូនដំណឹង';

  @override
  String get clearAllNotifications => 'សម្អាតការជូនដំណឹងទាំងអស់';

  @override
  String get clearAllNotificationsConfirmation =>
      'បញ្ជាក់ដើម្បីសម្អាតការជូនដំណឹងទាំងអស់';

  @override
  String get allNotificationsCleared => 'ការជូនដំណឹងទាំងអស់ត្រូវបានជម្រះ';

  @override
  String get clearButton => 'ជម្រះ';

  @override
  String get justNow => 'ឥឡូវនេះ';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count នាទីមុន',
      one: '1 នាទីមុន',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ម៉ោងមុន',
      one: '1 ម៉ោងមុន',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ថ្ងៃមុន',
      one: '1 ថ្ងៃមុន',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'ម្សិលមិញ';

  @override
  String get deletionProposal => 'សំណើលុប';

  @override
  String get createProposal => 'បង្កើតសំណើ';

  @override
  String get createProposalTitle => 'បង្កើតសំណើលុប';

  @override
  String get reason => 'មូលហេតុ';

  @override
  String get reasonOutdated => 'លេខហួសសម័យ';

  @override
  String get reasonPrivacy => 'បញ្ហាឯកជនភាព';

  @override
  String get reasonNotInService => 'មិនដំណើរការ';

  @override
  String get reasonWronglyIdentified => 'កំណត់អត្តសញ្ញាណខុស';

  @override
  String get reasonInaccurateInfo => 'ព័ត៌មានមិនត្រឹមត្រូវ';

  @override
  String get reasonWrongMarked => 'សម្គាល់ខុស';

  @override
  String get reasonOther => 'ផ្សេងៗ';

  @override
  String get submit => 'ដាក់ស្នើ';

  @override
  String get cancel => 'បោះបង់';

  @override
  String get proposalStatus => 'ស្ថានភាព';

  @override
  String get statusPending => 'កំពុងរង់ចាំ';

  @override
  String get statusActive => 'សកម្ម';

  @override
  String get statusCompleted => 'បានបញ្ចប់';

  @override
  String get statusExpired => 'ផុតកំណត់';

  @override
  String get riskLevel => 'កម្រិតហានិភ័យ';

  @override
  String get riskLevelVerified => 'បានផ្ទៀងផ្ទាត់';

  @override
  String get riskLevelLow => 'ទាប';

  @override
  String get riskLevelHigh => 'ខ្ពស់';

  @override
  String get riskLevelUnknown => 'មិនស្គាល់';

  @override
  String get votingProgress => 'វឌ្ឍនភាពនៃការបោះឆ្នោត';

  @override
  String agreeVotes(int count) {
    return 'យល់ព្រម: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'មិនយល់ព្រម: $count';
  }

  @override
  String totalVotes(int count) {
    return 'សរុប: $count';
  }

  @override
  String get voteAgree => 'យល់ព្រម';

  @override
  String get voteDisagree => 'មិនយល់ព្រម';

  @override
  String createdAt(String date) {
    return 'បានបង្កើត: $date';
  }

  @override
  String get verificationReport => 'របាយការណ៍ផ្ទៀងផ្ទាត់';

  @override
  String get showReport => 'បង្ហាញរបាយការណ៍';

  @override
  String get hideReport => 'លាក់របាយការណ៍';

  @override
  String get proposalStatistics => 'ស្ថិតិសំណើ';

  @override
  String get totalProposals => 'សំណើសរុប';

  @override
  String get activeProposals => 'សំណើសកម្ម';

  @override
  String get completedProposals => 'សំណើបានបញ្ចប់';

  @override
  String get myVotes => 'ការបោះឆ្នោតរបស់ខ្ញុំ';

  @override
  String get proposalCreated => 'សំណើត្រូវបានបង្កើតដោយជោគជ័យ';

  @override
  String get proposalCreateFailed => 'បរាជ័យក្នុងការបង្កើតសំណើ';

  @override
  String get voteSubmitted => 'ការបោះឆ្នោតត្រូវបានដាក់ស្នើដោយជោគជ័យ';

  @override
  String get voteSubmitFailed => 'បរាជ័យក្នុងការដាក់ស្នើការបោះឆ្នោត';

  @override
  String get noProposalsFound => 'មិនមានសំណើទេ';

  @override
  String get loadingProposals => 'កំពុងផ្ទុកសំណើ...';

  @override
  String get refreshProposals => 'ធ្វើបច្ចុប្បន្នភាពសំណើ';

  @override
  String get totalPendingProposals => 'សំណើកំពុងរង់ចាំសរុប';

  @override
  String get highRisk => 'ហានិភ័យខ្ពស់';

  @override
  String get mediumRisk => 'ហានិភ័យមធ្យម';

  @override
  String get lowRisk => 'ហានិភ័យទាប';

  @override
  String get communityImpact => 'ផលប៉ះពាល់សហគមន៍';

  @override
  String get criticalIssues => 'បញ្ហាសំខាន់';

  @override
  String get communityParticipation => 'ការចូលរួមសហគមន៍';

  @override
  String get noActivity => 'គ្មានសកម្មភាព';

  @override
  String get low => 'ទាប';

  @override
  String get moderate => 'មធ្យម';

  @override
  String get high => 'ខ្ពស់';

  @override
  String get veryHigh => 'ខ្ពស់ខ្លាំង';

  @override
  String get voted => 'បានបោះឆ្នោត';

  @override
  String get communityVotes => 'ការបោះឆ្នោតសហគមន៍';

  @override
  String get waitingForMoreVotes => 'កំពុងរង់ចាំការបោះឆ្នោតសហគមន៍បន្ថែម';

  @override
  String get proposalProcessed => 'សំណើនេះត្រូវបានដំណើរការហើយ';

  @override
  String get supported => 'បានគាំទ្រ';

  @override
  String get opposed => 'បានប្រឆាំង';

  @override
  String get approved => 'បានអនុម័ត';

  @override
  String get rejected => 'បានបដិសេធ';

  @override
  String get completed => 'បានបញ្ចប់';

  @override
  String get pending => 'កំពុងរង់ចាំ';

  @override
  String get critical => 'សំខាន់';

  @override
  String get oppose => 'ប្រឆាំង';

  @override
  String get veryLow => 'ទាបខ្លាំង';

  @override
  String get deletionProposals => 'សំណើលុប';

  @override
  String get deletionProposalNotificationDescription =>
      'ការជូនដំណឹងអំពីលទ្ធផលបោះឆ្នោតសំណើលុប និងការអាប់ដេត។';

  @override
  String get deletionProposalCreated => 'សំណើលុបត្រូវបានបង្កើត';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'សំណើលុបរបស់អ្នកសម្រាប់ $phoneNumber ត្រូវបានដាក់ស្នើសម្រាប់ការពិនិត្យសហគមន៍។';
  }

  @override
  String get proposalApproved => 'សំណើត្រូវបានអនុម័ត ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'សំណើលុបសម្រាប់ $phoneNumber ត្រូវបានអនុម័តដោយសហគមន៍ ($supportPercentage% គាំទ្រ, $totalVotes សន្លឹកឆ្នោត)។';
  }

  @override
  String get proposalRejected => 'សំណើត្រូវបានបដិសេធ ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'សំណើលុបសម្រាប់ $phoneNumber ត្រូវបានបដិសេធដោយសហគមន៍ ($supportPercentage% គាំទ្រ, $totalVotes សន្លឹកឆ្នោត)។';
  }

  @override
  String get communityVotingStarted => 'ការបោះឆ្នោតសហគមន៍បានចាប់ផ្តើម';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'សំណើលុបថ្មីសម្រាប់ $phoneNumber ឥឡូវនេះបើកសម្រាប់ការបោះឆ្នោតសហគមន៍ហើយ។';
  }

  @override
  String get votingCompleted => 'ការបោះឆ្នោតបានបញ្ចប់';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'ការបោះឆ្នោតសហគមន៍សម្រាប់ $phoneNumber បានបញ្ចប់។ លទ្ធផល៖ $result ($supportPercentage% គាំទ្រ)។';
  }

  @override
  String get newVoteReceived => 'បានទទួលសន្លឹកឆ្នោតថ្មី';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'នរណាម្នាក់បានបោះឆ្នោត $voteType ការលុប $phoneNumber។ សន្លឹកឆ្នោតបច្ចុប្បន្ន៖ $totalVotes។';
  }

  @override
  String get loadVoteCountFailed => 'បរាជ័យក្នុងការផ្ទុកចំនួនសន្លឹកឆ្នោត';

  @override
  String get voteCount => 'ចំនួនសន្លឹកឆ្នោត';

  @override
  String get deletionProposalInfo => 'ព័ត៌មានសំណើលុប';

  @override
  String get deletionProposalDescription =>
      'ស្នើសុំលេខសម្រាប់លុបដែលបំពានគោលការណ៍ណែនាំសហគមន៍។ ការចូលរួមរបស់អ្នកជួយរក្សាវេទិកាឱ្យមានសុវត្ថិភាព។';

  @override
  String get voteToEarnVip => 'បោះឆ្នោតលើសំណើដើម្បីទទួលបានសិទ្ធិ VIP!';

  @override
  String get voteFailed => 'ការបោះឆ្នោតបរាជ័យ';

  @override
  String get searchProposals => 'ស្វែងរកសំណើ';

  @override
  String get defaultNotifications => 'ការជូនដំណឹងលំនាំដើម';

  @override
  String get defaultNotificationsDescription =>
      'ឆានែលជូនដំណឹងលំនាំដើមសម្រាប់កម្មវិធី។';

  @override
  String get blockedCallNotifications => 'ការជូនដំណឹងការហៅទូរសព្ទដែលបានបិទ';

  @override
  String get blockedCallNotificationsDescription =>
      'បង្ហាញព័ត៌មានអំពីការហៅទូរសព្ទដែលបានបិទ។';

  @override
  String get stirVerification => 'ការផ្ទៀងផ្ទាត់ STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'បង្ហាញលទ្ធផលផ្ទៀងផ្ទាត់ STIR/SHAKEN សម្រាប់លេខទូរសព្ទ។';

  @override
  String get fraudAlerts => 'ការជូនដំណឹងអំពីការបន្លំ';

  @override
  String get fraudAlertsDescription =>
      'បង្ហាញការព្រមានសម្រាប់ការហៅទូរសព្ទដែលអាចបោកប្រាស់បាន។';

  @override
  String get notificationFrequencyDescription =>
      'ជ្រើសរើសភាពញឹកញាប់នៃការទទួលការជូនដំណឹងអំពីសំណើលុបថ្មី។ អ្នកអាចទទួលវាភ្លាមៗ ជាបាច់ ឬតាមចន្លោះពេលផ្ទាល់ខ្លួន។';

  @override
  String get notificationMode => 'របៀប​ជូន​ដំណឹង';

  @override
  String get immediateNotifications => 'ភ្លាមៗ';

  @override
  String get immediateNotificationsDescription =>
      'ទទួលការជូនដំណឹងភ្លាមៗនៅពេលសំណើត្រូវបានបង្កើតឡើង។';

  @override
  String get batchNotifications => 'ជាបាច់';

  @override
  String get batchNotificationsDescription =>
      'ទទួលសេចក្តីសង្ខេបនៃការជូនដំណឹងតាមកាលកំណត់។';

  @override
  String get customNotifications => 'ផ្ទាល់ខ្លួន';

  @override
  String get customNotificationsDescription =>
      'កំណត់ចន្លោះពេលផ្ទាល់ខ្លួនរបស់អ្នកសម្រាប់ការទទួលការជូនដំណឹង។';

  @override
  String get customFrequency => 'ភាពញឹកញាប់ផ្ទាល់ខ្លួន';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes នាទី';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours ម៉ោង';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours ម៉ោង $minutes នាទី';
  }

  @override
  String get pendingProposals => 'សំណើដែលកំពុងរង់ចាំ';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count សំណើដែលកំពុងរង់ចាំ',
      one: 'សំណើដែលកំពុងរង់ចាំ ១',
      zero: 'គ្មានសំណើដែលកំពុងរង់ចាំ',
    );
    return 'អ្នកមាន $_temp0។';
  }

  @override
  String get guidelinesLabel => 'គោលការណ៍ណែនាំ';

  @override
  String get riskLevelLabel => 'កម្រិតហានិភ័យ';

  @override
  String get riskLevelDescription => 'កម្រិតហានិភ័យនៃលេខ';

  @override
  String get phoneNumberMinDigits => 'លេខទូរសព្ទត្រូវតែមានយ៉ាងហោចណាស់ ៧ ខ្ទង់';

  @override
  String get provideDetailedExplanation =>
      'ផ្ដល់ការពន្យល់លម្អិត (យ៉ាងហោចណាស់ ១០ តួអក្សរ)';

  @override
  String get reasonMinCharacters => 'ហេតុផលត្រូវតែមានយ៉ាងហោចណាស់ ១០ តួអក្សរ';

  @override
  String get countryCodeTwoLetters => 'លេខកូដប្រទេស (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'លេខកូដប្រទេស (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'ឧទាហរណ៍៖ US, CN, GB';

  @override
  String get countryCodeRequired => 'លេខកូដប្រទេសត្រូវបានទាមទារ';

  @override
  String get countryCodeLengthError => 'លេខកូដប្រទេសត្រូវតែមាន ២ តួអក្សរ';

  @override
  String get phoneNumberHint => 'បញ្ចូលលេខទូរស័ព្ទ';

  @override
  String get phoneNumberRequired => 'លេខទូរស័ព្ទត្រូវបានទាមទារ';

  @override
  String get phoneNumberLengthError =>
      'លេខទូរសព្ទត្រូវតែមានយ៉ាងហោចណាស់ ៧ ខ្ទង់';

  @override
  String get reasonHint => 'ផ្ដល់ការពន្យល់លម្អិត (យ៉ាងហោចណាស់ ១០ តួអក្សរ)';

  @override
  String get reasonRequired => 'ហេតុផលត្រូវបានទាមទារ';

  @override
  String get reasonLengthError => 'ហេតុផលត្រូវតែមានយ៉ាងហោចណាស់ ១០ តួអក្សរ';

  @override
  String get guidelinesTitle => 'គោលការណ៍ណែនាំ';

  @override
  String get guidelinesText =>
      '• រាយការណ៍តែលេខដែលពិតជាមានបញ្ហា\n• ផ្ដល់ហេតុផលត្រឹមត្រូវ និងលម្អិត\n• ជ្រើសរើសកម្រិតហានិភ័យសមស្របដោយផ្អែកលើភាពធ្ងន់ធ្ងរ\n• ការរាយការណ៍មិនពិតអាចបណ្ដាលឱ្យមានការរឹតបន្តឹងគណនី';

  @override
  String get riskLevelCritical => 'ធ្ងន់ធ្ងរ';

  @override
  String get riskLevelMedium => 'មធ្យម';

  @override
  String get riskLevelVeryLow => 'ទាបបំផុត';

  @override
  String get riskDescriptionVeryLow =>
      'ទាបបំផុត - ការរំខានបន្តិចបន្តួច ការហៅទូរសព្ទមិនញឹកញាប់';

  @override
  String get riskDescriptionLow => 'ទាប - ការហៅទូរសព្ទដែលមិនចង់បានម្តងម្កាល';

  @override
  String get riskDescriptionMedium =>
      'មធ្យម - សារឥតបានការទៀងទាត់ ឬការលក់តាមទូរសព្ទ';

  @override
  String get riskDescriptionHigh =>
      'ខ្ពស់ - ការយាយីជាប់លាប់ ឬការប៉ុនប៉ងបោកប្រាស់';

  @override
  String get riskDescriptionCritical =>
      'ធ្ងន់ធ្ងរ - ការបោកប្រាស់គ្រោះថ្នាក់ ឬការគំរាមកំហែង';

  @override
  String get notificationFrequencyTitle => 'ភាពញឹកញាប់នៃការជូនដំណឹង';

  @override
  String get notificationFrequencyLabel => 'ភាពញឹកញាប់នៃការជូនដំណឹង (ម៉ោង)';

  @override
  String errorMessage(String error) {
    return 'កំហុស៖ $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'ការបោះឆ្នោត៖ $totalVotes ($supportPercentage% គាំទ្រ)';
  }

  @override
  String get timeJustNow => 'ទើបតែឥឡូវនេះ';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes នាទីមុន';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours ម៉ោងមុន';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days ថ្ងៃមុន';
  }

  @override
  String get reportingGuidelines =>
      '• រាយការណ៍តែលេខដែលពិតជាមានបញ្ហា\n• ផ្ដល់ហេតុផលត្រឹមត្រូវ និងលម្អិត\n• ជ្រើសរើសកម្រិតហានិភ័យសមស្របដោយផ្អែកលើភាពធ្ងន់ធ្ងរ\n• ការរាយការណ៍មិនពិតអាចបណ្ដាលឱ្យមានការរឹតបន្តឹងគណនី';

  @override
  String get notificationFrequencyHours => 'ភាពញឹកញាប់នៃការជូនដំណឹង (ម៉ោង)';

  @override
  String supportCount(int supportCount) {
    return 'គាំទ្រ ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'ប្រឆាំង ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes សំឡេងឆ្នោត ($supportPercentage% គាំទ្រ)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ម៉ោង',
      one: '1 ម៉ោង',
      zero: '0 ម៉ោង',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'សេចក្តីជូនដំណឹងសំខាន់';

  @override
  String get dataSourceDisclaimer =>
      'លេខត្រូវបានដកស្រង់ចេញពីអ៊ីនធឺណិត និងការដាក់ស្នើរបស់អ្នកប្រើប្រាស់។ យើងមិនអាចធានាថាលេខមួយនៅពេលដែលត្រូវបានលុបនឹងមិនត្រូវបានដាក់ស្នើឡើងវិញដោយអ្នកប្រើប្រាស់ ឬប្រភពផ្សេងទៀតទេ។ សូមស្វែងរក និងផ្ទៀងផ្ទាត់ព័ត៌មានយ៉ាងសកម្ម។';

  @override
  String get avatar => 'រូបតំណាង';

  @override
  String get location => 'ទីតាំង';

  @override
  String get simCardTitle => 'កាត SIM';

  @override
  String get liveActivitiesSettingsTitle => 'ការកំណត់សកម្មភាពបន្តផ្ទាល់';

  @override
  String get elementsSettingsTitle => 'ការកំណត់ធាតុ';

  @override
  String get liveActivityMode => 'សកម្មភាពបន្តផ្ទាល់';

  @override
  String get liveActivityModeDescription =>
      'បង្ហាញព័ត៌មានការហៅទូរសព្ទជាការជូនដំណឹងជាប់លាប់នៅលើអេក្រង់ចាក់សោ និងនៅក្នុង Dynamic Island (iOS)។';

  @override
  String get phoneNumberType => 'ប្រភេទលេខទូរសព្ទ';

  @override
  String get liveActivitiesTestEndActivity => 'បញ្ចប់សកម្មភាព';

  @override
  String get liveActivitiesTestSendNewActivity => 'ផ្ញើសកម្មភាពថ្មី';

  @override
  String get liveActivitiesTestUpdateActivity => 'អាប់ដេតសកម្មភាព';

  @override
  String get liveActivityControlsTitle => 'ការត្រួតពិនិត្យសកម្មភាពបន្តផ្ទាល់';

  @override
  String get liveActivitiesTestTitle => 'ការសាកល្បងសកម្មភាពបន្តផ្ទាល់';

  @override
  String get liveActivitiesTestSubtitle =>
      'សាកល្បងការជូនដំណឹងសកម្មភាពបន្តផ្ទាល់។';

  @override
  String get liveNotificationCustomizationTitle =>
      'ការប្ដូរតាមបំណងការជូនដំណឹងបន្តផ្ទាល់';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'ប្ដូរតាមបំណងរូបរាងនៃការជូនដំណឹងបន្តផ្ទាល់។';

  @override
  String get notification_instructions =>
      'វិធីណែនាំ៖\n1. ចុច \"SEND\" ដើម្បីបង្កើត ឬអាប់ដេតការជូនដំណឹង។\n2. ចូលទៅកាន់អេក្រង់ដើមរបស់អ្នក ឬទាញថាសការជូនដំណឹងចុះក្រោមដើម្បីមើលលទ្ធផល។\n3. ចុច \"END\" ដើម្បីបិទការជូនដំណឹង។';

  @override
  String get autoCancelNotification => 'ការលុបការជូនដំណឹងដោយស្វ័យប្រវត្តិ';

  @override
  String get autoCancelNotificationDescription =>
      'ប្រសិនបើធីក ការជូនដំណឹងនឹងត្រូវបានបិទដោយស្វ័យប្រវត្តិនៅពេលអ្នកប្រើប្រាស់ចុចលើវា។';

  @override
  String get setDelayTime => 'កំណត់ពេលវេលាពន្យារពេល';

  @override
  String get proposalDetails => 'ព័ត៌មានលម្អិតសំណើ';

  @override
  String get filterByStatus => 'ចម្រោះតាមស្ថានភាព';

  @override
  String get proposalNotFound => 'រកមិនឃើញសំណើ';

  @override
  String get processed => 'បានដំណើរការ';

  @override
  String get showAll => 'បង្ហាញទាំងអស់';

  @override
  String get filterAndSortTitle => 'ចម្រោះ និងតម្រៀប';

  @override
  String get filterVerifiedOwner => 'ចម្រោះម្ចាស់ដែលបានផ្ទៀងផ្ទាត់';

  @override
  String get filterBy => 'ចម្រោះតាម';

  @override
  String get sortOldest => 'តម្រៀបចាស់ជាងគេ';

  @override
  String get sortNewest => 'តម្រៀបថ្មីជាងគេ';

  @override
  String get sortMostPopular => 'តម្រៀបពេញនិយមបំផុត';

  @override
  String get sortLeastPopular => 'តម្រៀបពេញនិយមតិចបំផុត';

  @override
  String get sortBy => 'តម្រៀបតាម';

  @override
  String get simRulesNotFound => 'រកមិនឃើញច្បាប់ SIM';

  @override
  String get simSlotRules => 'ច្បាប់រន្ធ SIM';

  @override
  String get noSimCardDetected => 'រកមិនឃើញកាត SIM';

  @override
  String get invalidSimData => 'ទិន្នន័យ SIM មិនត្រឹមត្រូវ';

  @override
  String get simCardData => 'ទិន្នន័យកាត SIM';

  @override
  String get simSlot => 'រន្ធ SIM';

  @override
  String get enableFiltering => 'បើកការចម្រោះ';

  @override
  String get detailedSettingsTitle => 'ការកំណត់លម្អិត';

  @override
  String get entryPointViewTitle => 'ទិដ្ឋភាពចំណុចចូល';

  @override
  String get callTypeRejected => 'បដិសេធ';

  @override
  String get callTypeSilenced => 'បិទសំឡេង';

  @override
  String get callTypeVoicemail => 'សារសំឡេង';

  @override
  String get callTypeUnknownIntercept => 'ការស្ទាក់ចាប់ដែលមិនស្គាល់';

  @override
  String andMoreItems(int count) {
    return 'និង $count ធាតុផ្សេងទៀត';
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
}
