// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get aboutContactSubscription => 'Σχετικά με την Συνδρομή Επαφών';

  @override
  String get aboutLabels => 'Σχετικά με τις Ετικέτες';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Σχετικά με τους Κανόνες Συνδρομής Τηλεφώνου';

  @override
  String get aboutSmsFilter => 'Σχετικά με το Φιλτράρισμα SMS';

  @override
  String get aboutSmsSubscriptionRules =>
      'Σχετικά με τους Κανόνες Συνδρομής SMS';

  @override
  String get aboutSubtitle => 'Έκδοση εφαρμογής και νομικές πληροφορίες';

  @override
  String get aboutTitle => 'Σχετικά';

  @override
  String get action => 'Ενέργεια';

  @override
  String get actionAll => 'Όλα';

  @override
  String get actionAllow => 'Αποδοχή';

  @override
  String get actionBlock => 'Απόρριψη';

  @override
  String get actionFilterTitle => 'Φιλτράρισμα ανά Τύπο Ενέργειας';

  @override
  String get actionFilterTooltip => 'Φίλτρο Ενέργειας';

  @override
  String get actionNone => 'Καμία Ενέργεια';

  @override
  String get actionSilence => 'Σίγαση';

  @override
  String actionTag(Object actionType) {
    return 'Ενέργεια: $actionType';
  }

  @override
  String get actionType => 'Τύπος Ενέργειας';

  @override
  String get actionUnknown => 'Άγνωστο';

  @override
  String get add => 'Προσθήκη';

  @override
  String get addAllowedBlockedRule => 'Προσθήκη Κανόνα Αποδοχής/Απόρριψης';

  @override
  String get addAllowSubscription => 'Προσθήκη Συνδρομής Αποδοχής';

  @override
  String get addBlockSubscription => 'Προσθήκη Συνδρομής Απόρριψης';

  @override
  String get addContactButton => 'Προσθήκη Επαφής';

  @override
  String addContactFailed(Object error) {
    return 'Αποτυχία προσθήκης επαφής: $error';
  }

  @override
  String get addedToFavorites => 'Προστέθηκε στα αγαπημένα';

  @override
  String get addLabel => 'Προσθήκη Ετικέτας';

  @override
  String get addLabelButton => 'Προσθήκη Ετικέτας';

  @override
  String addLabelFailed(Object error) {
    return 'Αποτυχία προσθήκης ετικέτας: $error';
  }

  @override
  String get addName => 'Προσθήκη Ονόματος';

  @override
  String get addNoneSubscription => 'Προσθήκη Συνδρομής Καμίας Ενέργειας';

  @override
  String get addPhoneMark => 'Προσθήκη Σήμανσης Τηλεφώνου';

  @override
  String get addPhoneNumberRule => 'Προσθήκη Κανόνα Αριθμού Τηλεφώνου';

  @override
  String get addPlugin => 'Προσθήκη Πρόσθετου';

  @override
  String get addPluginFailed => 'Αποτυχία προσθήκης πρόσθετου';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Αποτυχία προσθήκης πρόσθετου: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Προσθήκη Πρόσθετου από Τοπικό Αρχείο';

  @override
  String get addPluginFromUrl => 'Προσθήκη Πρόσθετου από URL';

  @override
  String get addRegexRule => 'Προσθήκη Κανόνα Regex';

  @override
  String get addRule => 'Προσθήκη Κανόνα';

  @override
  String addRuleFailed(Object error) {
    return 'Αποτυχία προσθήκης κανόνα: $error';
  }

  @override
  String get addRuleTooltip => 'Προσθήκη Κανόνα';

  @override
  String get addSilenceSubscription => 'Προσθήκη Συνδρομής Σίγασης';

  @override
  String get addSmsFilterRule => 'Προσθήκη Κανόνα Φίλτρου SMS';

  @override
  String get addSmsRule => 'Προσθήκη Κανόνα SMS';

  @override
  String get addSmsSubscription => 'Προσθήκη Συνδρομής SMS';

  @override
  String get addSubscription => 'Προσθήκη Συνδρομής';

  @override
  String get addSubscriptionButton => 'Προσθήκη Συνδρομής';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Αποτυχία προσθήκης συνδρομής: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Προσθήκη Συνδρομής';

  @override
  String get addToBlacklist => 'Προσθήκη στη Μαύρη Λίστα';

  @override
  String get addToFavorites => 'Προσθήκη στα Αγαπημένα';

  @override
  String get addToRules => 'Προσθήκη στους κανόνες';

  @override
  String get addToWhitelist => 'Προσθήκη στη Λευκή Λίστα';

  @override
  String get agent => 'Πράκτορας';

  @override
  String get all => 'Όλα';

  @override
  String get allCallsTab => 'Όλες';

  @override
  String get allow => 'Αποδοχή';

  @override
  String get allowAllAllowRules => 'Αποδοχή Όλων των Κανόνων Αποδοχής';

  @override
  String get allowAllAllowRulesDesc => 'Αποδοχή κλήσεων από κανόνες αποδοχής';

  @override
  String get allowAllBlacklistedNumbers =>
      'Αποδοχή Όλων των Αριθμών της Μαύρης Λίστας';

  @override
  String get allowAllBlockRules => 'Αποδοχή Όλων των Κανόνων Απόρριψης';

  @override
  String get allowAllBlockRulesDesc => 'Αποδοχή κλήσεων από κανόνες απόρριψης';

  @override
  String get allowAllowedNumbers => 'Αποδοχή Επιτρεπόμενων Αριθμών';

  @override
  String get allowAllowedNumbersDesc =>
      'Αποδοχή κλήσεων από τη λίστα επιτρεπόμενων';

  @override
  String get allowBlock => 'Αποδοχή/Απόρριψη';

  @override
  String get allowBlockedNumbers => 'Αποδοχή Απορριφθέντων Αριθμών';

  @override
  String get allowBlockedNumbersDesc =>
      'Αποδοχή κλήσεων από τη λίστα απόρριψης';

  @override
  String get allowedBlockedRule => 'Κανόνας Αποδοχής/Απόρριψης';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Επεξεργασία Κανόνα Αποδοχής/Απόρριψης';

  @override
  String get allowedBlockedRuleManagement =>
      'Διαχείριση Κανόνων Αποδοχής/Απόρριψης';

  @override
  String get allowNonExceededNumbers =>
      'Αποδοχή Αριθμών που δεν Υπερβαίνουν το Όριο';

  @override
  String get allowNonExceededNumbersDescription =>
      'Αυτόματη αποδοχή αριθμών που δεν υπερβαίνουν το όριο μέτρησης';

  @override
  String get allowRegexAllowRules => 'Αποδοχή Κανόνων Regex Αποδοχής';

  @override
  String get allowRegexAllowRulesDesc =>
      'Ενεργοποίηση αντιστοίχισης μοτίβου regex για κανόνες αποδοχής';

  @override
  String get allowRegexAllowRulesDescription =>
      'Ενεργοποίηση κανόνων αποδοχής βάσει regex';

  @override
  String get allowRegexBlockRules => 'Αποδοχή Κανόνων Regex Απόρριψης';

  @override
  String get allowRegexBlockRulesDesc =>
      'Ενεργοποίηση αντιστοίχισης μοτίβου regex για κανόνες απόρριψης';

  @override
  String get allowRegexBlockRulesDescription =>
      'Ενεργοποίηση κανόνων απόρριψης βάσει regex';

  @override
  String get allowRule => 'Κανόνας Αποδοχής';

  @override
  String get allowRules => 'Κανόνες Αποδοχής';

  @override
  String get allPermissionsGranted => 'Όλες οι άδειες έχουν παραχωρηθεί';

  @override
  String get allSettingsCompleted => 'Όλες οι ρυθμίσεις ολοκληρώθηκαν.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Όλες οι ενημερώσεις ολοκληρώθηκαν ($count κανόνες)';
  }

  @override
  String get answerThenHangup => 'Απάντηση και μετά αποσύνδεση';

  @override
  String get applicationSoftware => 'Λογισμικό Εφαρμογής';

  @override
  String get apply => 'Εφαρμογή';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Η εξουσιοδότηση απέτυχε: Ελέγξτε το αναγνωριστικό πελάτη και το κλειδί';

  @override
  String get authorizationFailedMessage => 'Η εξουσιοδότηση απέτυχε';

  @override
  String get authorizationSuccessMessage => 'Η εξουσιοδότηση ήταν επιτυχής';

  @override
  String get authorizeLoginButton => 'Εξουσιοδότηση Σύνδεσης';

  @override
  String get automotiveIndustry => 'Αυτοκινητοβιομηχανία';

  @override
  String get autoSyncLabel => 'Αυτόματη Συγχρονισμός';

  @override
  String get autoUpdate => 'Αυτόματη Ενημέρωση';

  @override
  String get autoUpdateDescription =>
      'Ορίστε διαστήματα αυτόματης ενημέρωσης για συνδρομές ή ενημερώστε χειροκίνητα';

  @override
  String get autoUpdateSettings => 'Ρυθμίσεις Αυτόματης Ενημέρωσης';

  @override
  String get autoUpdateSubtitle =>
      'Διαχείριση αυτόματων ενημερώσεων για κανόνες και πρόσθετα';

  @override
  String get autoUpdateTitle => 'Αυτόματη Ενημέρωση';

  @override
  String get avatarBorderColor => 'Χρώμα Περίγραμμα Εικονιδίου';

  @override
  String get avatarBorderSize => 'Μέγεθος Περίγραμμα Εικονιδίου';

  @override
  String get avatarIconSizesSetting => 'Μέγεθος Εικονιδίων & Avatars';

  @override
  String get avatarPosition => 'Θέση Εικονιδίου';

  @override
  String get avatarSize => 'Μέγεθος Εικονιδίου';

  @override
  String axisPosition(Object axis) {
    return '$axis Θέση';
  }

  @override
  String get backgroundGradientSetting => 'Ντεγκραντέ Φόντου';

  @override
  String get backup => 'Αντίγραφο Ασφαλείας';

  @override
  String get backupAndRestore => 'Αντίγραφο Ασφαλείας και Επαναφορά';

  @override
  String get backupAndRestoreSubtitle =>
      'Αντίγραφο ασφαλείας ή επαναφορά δεδομένων εφαρμογής';

  @override
  String get backupAndRestoreTitle => 'Αντίγραφο Ασφαλείας & Επαναφορά';

  @override
  String get backupFailed => 'Το αντίγραφο ασφαλείας απέτυχε';

  @override
  String get backupSettings => 'Ρυθμίσεις Αντιγράφου Ασφαλείας';

  @override
  String get backupToCloud => 'Αντίγραφο Ασφαλείας στο Cloud';

  @override
  String backupToCloudFailed(Object error) {
    return 'Απέτυχε η δημιουργία αντιγράφου ασφαλείας στο cloud: $error';
  }

  @override
  String get backupToCloudSuccess =>
      'Επιτυχής δημιουργία αντιγράφου ασφαλείας στο cloud';

  @override
  String get bank => 'Τράπεζα';

  @override
  String get basicInfo => 'Βασικές Πληροφορίες';

  @override
  String get basicRuleFilter => 'Βασικό Φίλτρο Κανόνων';

  @override
  String get basicRuleFiltering => 'Βασική Φιλτράριση Κανόνων';

  @override
  String get basicRuleFilteringExplanation =>
      '• Βασική Φιλτράριση Κανόνων: Φιλτράρισμα κανόνων βάσει μαύρης λίστας, λίστας επιτρεπόμενων και regex';

  @override
  String get basicRuleFilterSubtitle =>
      'Φιλτράρισμα κλήσεων χρησιμοποιώντας μαύρη λίστα/λίστα επιτρεπόμενων και κανονικές εκφράσεις';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε $count επιλεγμένες επαφές;';
  }

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε $count ετικέτες;';
  }

  @override
  String get blacklist => 'Μαύρη Λίστα';

  @override
  String get blacklistingAndWhitelisting =>
      'Μαύρη Λίστα και Λίστα Επιτρεπόμενων';

  @override
  String get blackWhiteList => 'Μαύρη/Λευκή Λίστα';

  @override
  String get block => 'Αποκλεισμός';

  @override
  String get blockCalls => 'Αποκλεισμός Κλήσεων';

  @override
  String get blocked => 'Αποκλεισμένο';

  @override
  String get blockedCalls => 'Αποκλεισμένες Κλήσεις';

  @override
  String get blockedCallsTitle => 'Αποκλεισμένες Κλήσεις';

  @override
  String get blockedSpamCalls => 'Αποκλεισμένες Κλήσεις Spam';

  @override
  String get blockingTrend => 'Τάση Αποκλεισμού';

  @override
  String get blockInternationalCalls =>
      'αντιστοιχεί σε αριθμούς που δεν ξεκινούν με + ή 00';

  @override
  String get blockInternationalCallsTitle => 'Αποκλεισμός Διεθνών Κλήσεων';

  @override
  String get blockMobileNumbers =>
      'αντιστοιχεί σε αριθμούς που δεν ξεκινούν με 13-19';

  @override
  String get blockMobileNumbersTitle =>
      'Αποκλεισμός Αριθμών Κινητής Τηλεφωνίας';

  @override
  String get blockPremiumRateNumbers =>
      'αντιστοιχεί σε αριθμούς που δεν ξεκινούν με 118 ή 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Αποκλεισμός Αριθμών Υψηλής Χρέωσης';

  @override
  String get blockRule => 'Κανόνας Αποκλεισμού';

  @override
  String get blockRules => 'Κανόνες Αποκλεισμού';

  @override
  String get blockSpecificAreaCodes =>
      'αντιστοιχεί σε αριθμούς που ξεκινούν με 0 + 2-3 ψηφία';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Αποκλεισμός συγκεκριμένων κωδικών περιοχής:';

  @override
  String get blockTypeAnalysisTitle => 'Ανάλυση Τύπου Αποκλεισμού';

  @override
  String get both => 'Και τα δύο';

  @override
  String get bulkDelete => 'Μαζική Διαγραφή Επαφών';

  @override
  String get bulkDeleteContacts => 'Μαζική Διαγραφή Επαφών';

  @override
  String get bulkDeleteLabels => 'Μαζική Διαγραφή Ετικετών';

  @override
  String get call => 'Κλήση';

  @override
  String get callback => 'Επιστροφή Κλήσης';

  @override
  String get callBlocking => 'Αποκλεισμός Κλήσεων';

  @override
  String get callerIdApp => 'Εφαρμογή Αναγνώρισης Κλήσης';

  @override
  String get callerIdCustomizationTitle => 'Προσαρμογή Αναγνώρισης Κλήσης';

  @override
  String get callerIdDisplayMode => 'Λειτουργία Εμφάνισης Αναγνώρισης Κλήσης';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Σημειώθηκε από $count';
  }

  @override
  String get callerIdPreview => 'Προεπισκόπηση Αναγνώρισης Κλήσης';

  @override
  String get callFilterRules => 'Κανόνες Φίλτρου Κλήσεων';

  @override
  String get callFilterRulesDescription =>
      'Ορισμός βασικών κανόνων για το φιλτράρισμα κλήσεων';

  @override
  String get callFilterSettings => 'Ρυθμίσεις Φίλτρου Κλήσεων';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Ορισμός ορίων συχνότητας κλήσεων και κανόνων αποκλεισμού';

  @override
  String get callFrequencyInterceptionTitle => 'Παρεμπόδιση Συχνότητας Κλήσεων';

  @override
  String get callHistory => 'Ιστορικό Κλήσεων';

  @override
  String get callHistoryInfoDesc =>
      'Εδώ εμφανίζεται το ιστορικό κλήσεών σας, συμπεριλαμβανομένων των εισερχόμενων, εξερχόμενων και αναπάντητων κλήσεων.';

  @override
  String get callHistoryInfoTitle => 'Ιστορικό Κλήσεων';

  @override
  String get callHistoryTab => 'Ιστορικό Κλήσεων';

  @override
  String get callScreeningPermission => 'Άδεια Ελέγχου Κλήσεων';

  @override
  String get callScreeningPermissionDescription =>
      'Χρησιμοποιείται για τον έλεγχο και τον αποκλεισμό κλήσεων spam.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Η άδεια ελέγχου κλήσεων δεν έχει χορηγηθεί, ενδέχεται να επηρεάσει τη λειτουργικότητα της εφαρμογής.';

  @override
  String get callStatistics => 'Στατιστικά Κλήσεων';

  @override
  String get callTypeAnswered => 'Απαντημένη';

  @override
  String get callTypeBlocked => 'Αποκλεισμένη';

  @override
  String get callTypeIconColor => 'Χρώμα Εικονιδίου Τύπου Κλήσης';

  @override
  String get callTypeMissed => 'Αναπάντητη Κλήση';

  @override
  String get callTypeOutgoing => 'Εξερχόμενη';

  @override
  String get callTypePosition => 'Θέση Τύπου Κλήσης';

  @override
  String get callTypeUnknown => 'Άγνωστο';

  @override
  String get cancelButton => 'Ακύρωση';

  @override
  String get carRental => 'Ενοικίαση Αυτοκινήτου';

  @override
  String get carrier => 'Πάροχος';

  @override
  String get carrierColor => 'Χρώμα Παρόχου';

  @override
  String get carrierFontSize => 'Μέγεθος Γραμματοσειράς Παρόχου';

  @override
  String get carrierPosition => 'Θέση Παρόχου';

  @override
  String get changeLabel => 'Αλλαγή Ετικέτας';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Απέτυχε η αλλαγή κατάστασης plugin: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Απέτυχε η αλλαγή κατάστασης συνδρομής: $error';
  }

  @override
  String get charity => 'Φιλανθρωπία';

  @override
  String get chartOneWeekAgo => '1 εβδομάδα πριν';

  @override
  String get chartThreeDaysAgo => '3 ημέρες πριν';

  @override
  String get chartToday => 'Σήμερα';

  @override
  String get checkFileFormat => 'Ελέγξτε τη μορφή αρχείου ή τα δικαιώματα';

  @override
  String checkPermissionFailed(Object error) {
    return 'Απέτυχε ο έλεγχος δικαιωμάτων: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Επιλέξτε την προεπιλεγμένη ενέργεια παρεμπόδισης';

  @override
  String get clearFilter => 'Εκκαθάριση Φίλτρου';

  @override
  String get clearLabelFilterButton => 'Εκκαθάριση Φίλτρου Ετικετών';

  @override
  String get closeButton => 'Κλείσιμο';

  @override
  String get cloudSync => 'Cloud Sync';

  @override
  String get cloudSyncAndBackupTitle => 'Cloud Sync & Backup';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Ρύθμιση WebDAV, OneDrive και Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Ρυθμίσεις Cloud Sync';

  @override
  String get cloudSyncTitle => 'Cloud Sync';

  @override
  String get collection => 'Συλλογή Χρεών';

  @override
  String get colorPickerTitle => 'Επιλογή Χρώματος';

  @override
  String get configManagement => 'Διαχείριση Ρυθμίσεων';

  @override
  String get configUpdated => 'Ρυθμίσεις ενημερώθηκαν';

  @override
  String get configurationAdvice =>
      'Μέσω σωστής διαμόρφωσης, μπορείτε να ορίσετε διαφορετικές στρατηγικές φιλτραρίσματος για επαγγελματικές και προσωπικές κάρτες SIM.';

  @override
  String get configureBackupOptions =>
      'Ρύθμιση Επιλογών Δημιουργίας Αντιγράφων Ασφαλείας';

  @override
  String get configureCloudSyncService => 'Ρύθμιση Υπηρεσίας Cloud Sync';

  @override
  String get configureCloudSyncServiceMessage =>
      'Παρακαλώ ρυθμίστε μια υπηρεσία cloud sync για να ενεργοποιήσετε τον συγχρονισμό πολλαπλών συσκευών.';

  @override
  String get configureSimCardFilterRules =>
      'Ρύθμιση Κανόνων Φίλτρου Κάρτας SIM';

  @override
  String get confirm => 'Επιβεβαίωση';

  @override
  String get confirmButton => 'Επιβεβαίωση';

  @override
  String get confirmDelete => 'Επιβεβαίωση Διαγραφής';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε την ετικέτα \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε το plugin \"$name\";';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε $count plugins;';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Είστε σίγουροι ότι θέλετε να διαγράψετε αυτόν τον κανόνα; Αυτή η ενέργεια δεν μπορεί να αναιρεθεί.';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Είστε σίγουροι ότι θέλετε να διαγράψετε αυτόν τον κανόνα φίλτρου SMS;';

  @override
  String get confirmDeleteSmsRule =>
      'Είστε σίγουροι ότι θέλετε να διαγράψετε αυτόν τον κανόνα SMS;';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε $name;';
  }

  @override
  String get confirmPassword => 'Επιβεβαίωση Κωδικού';

  @override
  String get connectedStatus => 'Συνδεδεμένο';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Η σύνδεση απέτυχε: Ελέγξτε τη διεύθυνση διακομιστή, το όνομα χρήστη και τον κωδικό πρόσβασης';

  @override
  String get connectionFailedMessage => 'Η σύνδεση απέτυχε';

  @override
  String get connectionStatusLabel => 'Κατάσταση Σύνδεσης';

  @override
  String get connectionSuccessMessage => 'Η σύνδεση είναι επιτυχής';

  @override
  String get contactAddSuccess => 'Η επαφή προστέθηκε με επιτυχία';

  @override
  String get contactDeleted => 'Η επαφή διαγράφηκε';

  @override
  String get contactNameLabel => 'Όνομα';

  @override
  String get contactNotFound => 'Η επαφή δεν βρέθηκε';

  @override
  String get contacts => 'Επαφές';

  @override
  String contactsDeleted(Object count) {
    return 'Διαγράφηκαν $count επαφές';
  }

  @override
  String get contactsManagement => 'Διαχείριση Επαφών';

  @override
  String get contactsPermission => 'Άδεια Επαφών';

  @override
  String get contactsPermissionDescription =>
      'Χρησιμοποιείται για την αναγνώριση κλήσεων από επαφές.';

  @override
  String get contactsTab => 'Επαφές';

  @override
  String get contactSubscriptionDescription =>
      'Εγγραφείτε σε λίστες επαφών μέσω URL, ενημερώστε αυτόματα τα στοιχεία και τις ετικέτες των επαφών. Υποστηρίζει δεδομένα σε μορφή JSON.';

  @override
  String get contactUpdateSuccess => 'Η επαφή ενημερώθηκε με επιτυχία';

  @override
  String get contactUs => 'Επικοινωνήστε μαζί μας';

  @override
  String get content => 'Περιεχόμενο';

  @override
  String get contentRegex => 'Regex Περιεχομένου';

  @override
  String get countColor => 'Χρώμα Μετρητή';

  @override
  String get countFontSize => 'Μέγεθος Γραμματοσειράς Μετρητή';

  @override
  String get countPosition => 'Θέση Μετρητή';

  @override
  String get country => 'Χώρα';

  @override
  String get countryNameColor => 'Χρώμα Ονόματος Χώρας';

  @override
  String get countryNameFontSize => 'Μέγεθος Γραμματοσειράς Ονόματος Χώρας';

  @override
  String get countryRegionNamePosition => 'Θέση Ονόματος Χώρας/Περιοχής';

  @override
  String get countThresholdDescription =>
      'Ορίστε το ελάχιστο όριο μετρητή που απαιτείται για την ενεργοποίηση ενεργειών φιλτραρίσματος';

  @override
  String get countThresholdLabel => 'Όριο Μετρητή';

  @override
  String get createdRules => 'Δημιουργημένοι Κανόνες';

  @override
  String get csvFormat => 'Μορφή CSV';

  @override
  String get currentDeviceLabel => 'Ετικέτα Τρέχουσας Συσκευής';

  @override
  String get currentDeviceTitle => 'Τρέχουσα Συσκευή';

  @override
  String get currentLanguage => 'Τρέχουσα Γλώσσα';

  @override
  String get customerService => 'Εξυπηρέτηση Πελατών';

  @override
  String get dashboardTab => 'Πίνακας Ελέγχου';

  @override
  String get dataAnalysis => 'Ανάλυση Δεδομένων';

  @override
  String dataLoadFailure(Object error) {
    return 'Η φόρτωση δεδομένων απέτυχε: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Απέτυχε η φόρτωση δεδομένων: $error';
  }

  @override
  String get dataMigration => 'Μεταφορά Δεδομένων';

  @override
  String get dataMigrationDescription =>
      'Αυτή η λειτουργία σας επιτρέπει να μεταφέρετε όλα τα δεδομένα σας μεταξύ συσκευών. Επί του παρόντος, μπορείτε να χρησιμοποιήσετε τις λειτουργίες δημιουργίας αντιγράφων ασφαλείας και επαναφοράς για να μεταφέρετε χειροκίνητα τα δεδομένα σας.';

  @override
  String get dataSourceReminder => 'Υπενθύμιση Πηγής Δεδομένων';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες',
      one: '1 ημέρα',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Ημέρες VIP';
  }

  @override
  String get debtCollection => 'Είσπραξη Χρεών';

  @override
  String get delete => 'Διαγραφή';

  @override
  String get deleteButton => 'Διαγραφή';

  @override
  String get deleteContact => 'Διαγραφή Επαφής';

  @override
  String deleteContactConfirm(Object name) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε $name;';
  }

  @override
  String deleteFailed(Object error) {
    return 'Η διαγραφή απέτυχε: $error';
  }

  @override
  String get deleteLabel => 'Διαγραφή Ετικέτας';

  @override
  String deleteLabelFailed(Object error) {
    return 'Απέτυχε η διαγραφή ετικέτας: $error';
  }

  @override
  String get deletePlugin => 'Διαγραφή Plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Απέτυχε η διαγραφή plugin: $error';
  }

  @override
  String get deletePlugins => 'Διαγραφή Plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Απέτυχε η διαγραφή plugins: $error';
  }

  @override
  String get deleteRule => 'Διαγραφή Κανόνα';

  @override
  String deleteRuleFailed(Object error) {
    return 'Η διαγραφή απέτυχε: $error';
  }

  @override
  String get deleteSelected => 'Διαγραφή Επιλεγμένων';

  @override
  String get deleteSubscription => 'Διαγραφή Συνδρομής';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε τη συνδρομή \"$name\";';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Απέτυχε η διαγραφή συνδρομής: $error';
  }

  @override
  String get deleteSuccess => 'Η διαγραφή ήταν επιτυχής';

  @override
  String get delivery => 'Παράδοση';

  @override
  String get deviceIDLabel => 'Αναγνωριστικό Συσκευής';

  @override
  String get deviceManagementSubtitle =>
      'Διαχείριση συγχρονισμού πολλαπλών συσκευών';

  @override
  String get deviceManagementTitle => 'Διαχείριση Συσκευών';

  @override
  String get deviceModelLabel => 'Μοντέλο Συσκευής';

  @override
  String get deviceName => 'Όνομα Συσκευής';

  @override
  String get deviceNameLabel => 'Όνομα Συσκευής';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Η συσκευή μετονομάστηκε με επιτυχία';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Οι συσκευές συγχρονίστηκαν με επιτυχία';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Η συσκευή καταργήθηκε με επιτυχία';

  @override
  String get dialogTitle => 'Επεξήγηση Μοτίβου Regex';

  @override
  String get differentFromLocalCounter =>
      'Αυτή η λειτουργία διαφέρει από το φίλτρο τοπικού μετρητή, καθώς εστιάζει σε επαναλαμβανόμενα μοτίβα κλήσεων σε σύντομο χρονικό διάστημα αντί για μακροπρόθεσμες καταμετρήσεις σήμανσης.';

  @override
  String get disabled => 'Απενεργοποιημένο';

  @override
  String get disabledStatus => 'Απενεργοποιημένο';

  @override
  String get disableGlobalPlugins => 'Απενεργοποίηση καθολικών πρόσθετων';

  @override
  String get disconnectButton => 'Αποσύνδεση';

  @override
  String get disconnectedMessage => 'Αποσυνδέθηκε';

  @override
  String get disconnectedStatus => 'Αποσυνδέθηκε';

  @override
  String get disconnectFailedMessage => 'Η αποσύνδεση απέτυχε';

  @override
  String get done => 'Έγινε';

  @override
  String get dualSimAdvice =>
      'Αυτή η λειτουργία είναι ιδιαίτερα χρήσιμη για τηλέφωνα διπλής SIM για τον καθορισμό διαφορετικών στρατηγικών φιλτραρίσματος για κάρτες SIM εργασίας και προσωπικές.';

  @override
  String get earlier => 'Νωρίτερα';

  @override
  String get ecommerce => 'Ηλεκτρονικό εμπόριο';

  @override
  String get edit => 'Επεξεργασία';

  @override
  String get editContact => 'Επεξεργασία Επαφής';

  @override
  String get editLabel => 'Επεξεργασία Ετικέτας';

  @override
  String get editPhoneRule => 'Επεξεργασία Κανόνα Τηλεφώνου';

  @override
  String get editRule => 'Επεξεργασία Κανόνα';

  @override
  String get education => 'Εκπαίδευση';

  @override
  String get elementPositionsSetting => 'Θέσεις Στοιχείων';

  @override
  String get email => 'Email';

  @override
  String get enableCallFilter => 'Ενεργοποίηση Φίλτρου Κλήσεων';

  @override
  String get enableCallFilterDescription =>
      'Όταν είναι ενεργοποιημένες, οι εισερχόμενες κλήσεις ελέγχονται έναντι της λίστας κανόνων παρακάτω. Οι κανόνες φιλτραρίσματος κλήσεων δεν συγχρονίζονται μεταξύ συσκευών από προεπιλογή.';

  @override
  String get enabled => 'Ενεργοποιημένο';

  @override
  String get enabledStatus => 'Ενεργοποιημένο';

  @override
  String get enableEncryption => 'Ενεργοποίηση Κρυπτογράφησης';

  @override
  String get enableEncryptionDescription =>
      'Κρυπτογράφηση αρχείων αντιγράφων ασφαλείας';

  @override
  String get enableGlobalPlugins => 'Ενεργοποίηση καθολικών πρόσθετων';

  @override
  String get enableLocalCountFilter => 'Ενεργοποίηση Τοπικού Φίλτρου Μετρητή';

  @override
  String get enableLocalCountFilterDescription =>
      'Αυτόματη φίλτρανση κλήσεων spam βάσει του αριθμού σήμανσης κλήσεων';

  @override
  String get enableLocalNotification => 'Χρήση Τοπικής Ειδοποίησης';

  @override
  String get enableLocalNotificationDescription =>
      'Όταν είναι ενεργοποιημένες, οι ειδοποιήσεις για τα φιλτραρισμένα μηνύματα θα εμφανίζονται στη συσκευή';

  @override
  String get enableLocationSummary => 'Τοποθεσία';

  @override
  String get enableMuteRules => 'Ενεργοποίηση Κανόνων Σίγασης';

  @override
  String get enableMuteRulesDesc =>
      'Εφαρμογή ρύθμισης κανόνων παρεμβολής σίγασης';

  @override
  String get enableNoneActionRules => 'Ενεργοποίηση Κανόνων Χωρίς Ενέργεια';

  @override
  String get enableNoneActionRulesDesc =>
      'Επιτρέψτε ρυθμίσεις κανόνων χωρίς ενέργειες παρεμβολής';

  @override
  String get enableRemoteNumberFilter =>
      'Ενεργοποίηση Απομακρυσμένου Φίλτρου Αριθμών';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Χρήση απομακρυσμένης βάσης δεδομένων για φιλτράρισμα αριθμών';

  @override
  String get enableRule => 'Ενεργοποίηση Κανόνα';

  @override
  String get enableSmsFilter => 'Ενεργοποίηση Φιλτραρίσματος SMS';

  @override
  String get enableSmsFilterDescription =>
      'Όταν είναι ενεργοποιημένα, τα μηνύματα θα φιλτράρονται αυτόματα σύμφωνα με τους κανόνες';

  @override
  String get enableTimeInterception => 'Ενεργοποίηση Παρεμβολής Χρόνου';

  @override
  String get enableTimeInterceptionDescription =>
      'Παρεμβολή επαναλαμβανόμενων κλήσεων εντός σύντομου χρονικού διαστήματος';

  @override
  String get enableTimeInterceptor => 'Ενεργοποίηση Παρεμβολέα Χρόνου';

  @override
  String get endCallImmediately => 'Τερματισμός κλήσης αμέσως';

  @override
  String get endColor => 'Τελικό Χρώμα';

  @override
  String get endDate => 'Ημερομηνία Λήξης';

  @override
  String get enhancedFilterInstructionsTitle => 'Ενισχυμένο Σύστημα Φίλτρων';

  @override
  String get enhancedFilterSettings => 'Ρυθμίσεις Ενισχυμένου Φίλτρου';

  @override
  String get enhancedFilterSettingsTitle => 'Ρυθμίσεις Ενισχυμένου Φίλτρου';

  @override
  String get enhancedFilterSystemDescription =>
      'Το ενισχυμένο σύστημα φίλτρων υποστηρίζει τόσο καθολικούς κανόνες όσο και ρυθμίσεις φιλτραρίσματος ανά κάρτα SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Εισαγάγετε και τον αριθμό τηλεφώνου και το μοτίβο regex.';

  @override
  String get enterContactName => 'Εισαγάγετε όνομα επαφής';

  @override
  String get enterDeviceName => 'Εισαγωγή Ονόματος Συσκευής';

  @override
  String get enterEmailOptional => 'Εισαγάγετε email (προαιρετικό)';

  @override
  String get enterEncryptionPasswordHint => 'Εισαγάγετε κωδικό κρυπτογράφησης';

  @override
  String get enterIconCode => 'Εισαγωγή κωδικού εικονιδίου';

  @override
  String get enterName => 'Εισαγωγή ονόματος επαφής';

  @override
  String get enterNewDeviceNameHint =>
      'Εισαγάγετε ένα νέο όνομα για αυτήν τη συσκευή';

  @override
  String get enterPasswordAgain => 'Εισαγωγή Κωδικού Ξανά';

  @override
  String get enterPhoneNumber => 'Εισαγωγή αριθμού τηλεφώνου';

  @override
  String get enterPhoneNumberHint => 'Εισαγάγετε αριθμό τηλεφώνου για έλεγχο';

  @override
  String get enterPhoneNumberMultiple =>
      'Εισαγάγετε αριθμό τηλεφώνου, πολλαπλούς αριθμούς χωρισμένους με κόμματα';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Εισαγάγετε αριθμό τηλεφώνου για να ξεκινήσετε την αναζήτηση';

  @override
  String get enterPhoneNumberToVerify =>
      'Εισαγάγετε αριθμό τηλεφώνου για επαλήθευση';

  @override
  String get enterPluginName => 'Εισαγωγή ονόματος πρόσθετου';

  @override
  String get enterPluginUrl => 'Εισαγωγή διεύθυνσης URL πρόσθετου';

  @override
  String get enterRegexHint => 'Εισαγωγή μοτίβου regex';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Παρακαλώ εισάγετε όνομα κανόνα και μοτίβο regex.';

  @override
  String get enterRuleNameHint => 'Εισάγετε όνομα κανόνα';

  @override
  String get enterSearchContent => 'Παρακαλώ εισάγετε περιεχόμενο αναζήτησης';

  @override
  String get enterSubscriptionName => 'Εισάγετε όνομα συνδρομής';

  @override
  String get enterSubscriptionUrl => 'Εισάγετε URL συνδρομής';

  @override
  String get enterSyncFolderNameHint =>
      'Παρακαλώ εισάγετε όνομα φακέλου συγχρονισμού (προεπιλογή: NotificationManager)';

  @override
  String get entertainment => 'Ψυχαγωγία';

  @override
  String get enterValidNameAndUrl => 'Παρακαλώ εισάγετε έγκυρο όνομα και URL';

  @override
  String get enterValidUrl => 'Παρακαλώ εισάγετε έγκυρο URL';

  @override
  String get enterVersion => 'Εισάγετε έκδοση';

  @override
  String get enterWebDAVPasswordHint =>
      'Παρακαλώ εισάγετε κωδικό πρόσβασης WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Παρακαλώ εισάγετε διεύθυνση διακομιστή WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'Παρακαλώ εισάγετε όνομα χρήστη WebDAV';

  @override
  String errorOccurredMessage(Object error) {
    return 'Παρουσιάστηκε σφάλμα: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Σφάλμα κατά την αλλαγή ονόματος συσκευής: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Σφάλμα κατά το συγχρονισμό συσκευών: $error';
  }

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Σφάλμα κατά την αποεγγραφή συσκευής: $error';
  }

  @override
  String get exampleBlock400Prefix => 'π.χ. Αποκλεισμός αριθμών προθέματος 400';

  @override
  String get exampleBlockMarketingSms => 'π.χ. Αποκλεισμός SMS μάρκετινγκ';

  @override
  String get exampleContentRegexHint => 'Παράδειγμα Regex Περιεχομένου';

  @override
  String get exampleCouponPromotionDiscount =>
      'π.χ. .*(κουπόνι|προσφορά|έκπτωση).*';

  @override
  String get exampleFamilyFriends => 'π.χ. Οικογένεια, Φίλοι, κ.λπ.';

  @override
  String get examplePhoneNumber => 'π.χ. 10086, 12345, κ.λπ.';

  @override
  String get exampleRegex400Prefix => 'Παράδειγμα regex για πρόθεμα 400';

  @override
  String get exampleSenderRegexHint => 'Παράδειγμα';

  @override
  String get exchange => 'Ανταλλαγή';

  @override
  String get exchangeNow => 'Ανταλλαγή Τώρα';

  @override
  String get exchangeVip => 'Ανταλλαγή VIP';

  @override
  String expiryTime(Object time) {
    return 'Ώρα λήξης: $time';
  }

  @override
  String get export => 'Εξαγωγή';

  @override
  String get exportAllApplicationSettings =>
      'Εξαγωγή όλων των ρυθμίσεων εφαρμογής';

  @override
  String get exportAllRuleConfigurations =>
      'Εξαγωγή όλων των ρυθμίσεων κανόνων';

  @override
  String get exportConfig => 'Εξαγωγή Ρύθμισης';

  @override
  String get exportContacts => 'Εξαγωγή Επαφών';

  @override
  String get exportData => 'Εξαγωγή Δεδομένων';

  @override
  String get exportFailed => 'Η εξαγωγή απέτυχε';

  @override
  String get exportFailure => 'Αποτυχία εξαγωγής ρύθμισης';

  @override
  String get exportFeatureComingSoon => 'Η λειτουργία εξαγωγής έρχεται σύντομα';

  @override
  String get exportLabels => 'Εξαγωγή Ετικετών';

  @override
  String exportLabelsFailed(Object error) {
    return 'Αποτυχία εξαγωγής ετικετών: $error';
  }

  @override
  String get exportPluginList => 'Εξαγωγή Λίστας Plugins';

  @override
  String exportPluginListFailed(Object error) {
    return 'Αποτυχία εξαγωγής λίστας plugins: $error';
  }

  @override
  String get exportRules => 'Εξαγωγή Κανόνων';

  @override
  String get exportSmsRules => 'Εξαγωγή Κανόνων SMS';

  @override
  String get exportStatisticsData => 'Εξαγωγή Δεδομένων Στατιστικών';

  @override
  String get exportSuccesslly => 'Η ρύθμιση εξήχθη επιτυχώς';

  @override
  String failedToAddRule(Object error) {
    return 'Αποτυχία προσθήκης κανόνα: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Αποτυχία προσθήκης συνδρομής SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Αποτυχία δημιουργίας αντιγράφων ασφαλείας ρυθμίσεων: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Αποτυχία αποκρυπτογράφησης αρχείου αντιγράφων ασφαλείας';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Αποτυχία διαγραφής κανόνα SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Αποτυχία εξαγωγής κανόνων: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Αποτυχία λήψης πληροφοριών αναγνώρισης κλήσης: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Αποτυχία εισαγωγής κανόνων: $error';
  }

  @override
  String get failedToRestoreSettings => 'Αποτυχία επαναφοράς ρυθμίσεων';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Αποτυχία επαναφοράς ρυθμίσεων: $error';
  }

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Αποτυχία εναλλαγής κατάστασης κανόνα: $error';
  }

  @override
  String get favoriteContacts => 'Αγαπημένες Επαφές';

  @override
  String get featureAddRules =>
      '• Προσθήκη κανόνων για συγκεκριμένο αριθμό τηλεφώνου';

  @override
  String get featureCenter => 'Κέντρο Λειτουργιών';

  @override
  String get featureEnableDisable =>
      '• Ενεργοποίηση/απενεργοποίηση διαφορετικών φίλτρων ανά SIM';

  @override
  String get featureListTitle => 'Λειτουργίες:';

  @override
  String get featureManageRules => '• Διαχείριση λιστών κανόνων ανά SIM';

  @override
  String get features => 'Λειτουργίες';

  @override
  String get fetchingCallerIdInfo =>
      'Γίνεται λήψη πληροφοριών αναγνώρισης κλήσης...';

  @override
  String fileSavedTo(Object path) {
    return 'Το αρχείο αποθηκεύτηκε στο: $path';
  }

  @override
  String get filter => 'Φίλτρο';

  @override
  String get filterByLabel => 'Φιλτράρισμα κατά Ετικέτα';

  @override
  String get filterControlPanelTitle => 'Πίνακας Ελέγχου Φίλτρου';

  @override
  String get filterControlSubtitle =>
      'Διαχείριση κατάστασης ενεργοποίησης/απενεργοποίησης όλων των φίλτρων';

  @override
  String get filterControlTitle => 'Έλεγχος Φίλτρων';

  @override
  String get filtered => 'Φιλτραρισμένα';

  @override
  String get filterExplanation => 'Επεξήγηση Φίλτρου';

  @override
  String get filterManagement => 'Διαχείριση Φίλτρων';

  @override
  String get filterName => 'Όνομα Φίλτρου';

  @override
  String get filterPriorityNote =>
      'Σημείωση: Υπάρχουν σχέσεις προτεραιότητας μεταξύ των φίλτρων, ανατρέξτε στην τεκμηρίωση βοήθειας για λεπτομέρειες';

  @override
  String get filterSettings => 'Ρυθμίσεις Φίλτρου';

  @override
  String get filterSettingsTitle => 'Ρυθμίσεις Φίλτρων';

  @override
  String get filterSMS => 'Φιλτράρισμα SMS';

  @override
  String get filterToggleInstructions =>
      'Ενεργοποίηση ή απενεργοποίηση φίλτρων για αυτήν την υποδοχή SIM:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Φίλτρο $status: $filterName';
  }

  @override
  String get filterType => 'Τύπος Φίλτρου';

  @override
  String get financial => 'Οικονομικά';

  @override
  String get flexibleCombinationFeature =>
      '• Ευέλικτοι Συνδυασμοί: Ενεργοποίηση/απενεργοποίηση φίλτρων ανά υποδοχή SIM';

  @override
  String get fontSizesSetting => 'Μεγέθη Γραμματοσειράς';

  @override
  String foundRules(Object count) {
    return 'Βρέθηκαν $count κανόνες';
  }

  @override
  String get fraudAlert => 'ΕΙΔΟΠΟΙΗΣΗ ΑΠΑΤΗΣ - Κλείστε την κλήση';

  @override
  String get fraudScamLikely => 'Πιθανή Απάτη';

  @override
  String get free => 'Δωρεάν';

  @override
  String get functionSettingsTitle => 'Ρυθμίσεις Λειτουργιών';

  @override
  String generalUpdateFailure(Object error) {
    return 'Η ενημέρωση απέτυχε: $error';
  }

  @override
  String get getFree => 'Λάβετε Δωρεάν';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Ρυθμίστε καθολικά φίλτρα για όλες τις κάρτες SIM:';

  @override
  String get globalFilterFeature =>
      '• Καθολικά Φίλτρα: Βασικοί κανόνες για όλες τις εισερχόμενες κλήσεις';

  @override
  String get globalFilterSettings => 'Ρυθμίσεις Καθολικού Φίλτρου';

  @override
  String get globalSettings => 'Καθολικές Ρυθμίσεις';

  @override
  String get googleDriveAuthDescription =>
      'Εξουσιοδοτήστε χρησιμοποιώντας το αναγνωριστικό πελάτη και το κλειδί Google Drive που έχουν ρυθμιστεί στο σύστημα';

  @override
  String get googleDriveConfigTitle => 'Ρύθμιση Google Drive';

  @override
  String get government => 'Κυβέρνηση';

  @override
  String get granted => 'Επιχορηγήθηκε';

  @override
  String get grantNecessaryPermissions => 'Παραχώρηση Απαραίτητων Δικαιωμάτων';

  @override
  String get grantPermissions => 'Παραχώρηση Δικαιωμάτων';

  @override
  String get headhunter => 'Headhunter';

  @override
  String get height => 'Ύψος';

  @override
  String get homeTab => 'Αρχική';

  @override
  String get howItWorksPoint1 =>
      '• Το σύστημα θα επιτρέπει αυτόματα τις κλήσεις από τον ίδιο αριθμό εντός του καθορισμένου χρονικού παραθύρου';

  @override
  String get howItWorksPoint2 =>
      '• Μικρότερα χρονικά παράθυρα οδηγούν σε αυστηρότερη παρεμβολή. Μεγαλύτερα χρονικά παράθυρα οδηγούν σε χαλαρότερη παρεμβολή';

  @override
  String get howItWorksPoint3 =>
      '• Το σύστημα ελέγχει τα αρχεία καταγραφής κλήσεων για να προσδιορίσει αν πρόκειται για επαναλαμβανόμενη κλήση';

  @override
  String get howItWorksTitle => 'Πώς Λειτουργεί:';

  @override
  String get iconCodeOptional => 'Κωδικός Εικονιδίου (Προαιρετικό)';

  @override
  String get iconSize => 'Μέγεθος Εικονιδίου';

  @override
  String get import => 'Εισαγωγή';

  @override
  String get important => 'Σημαντικό';

  @override
  String get importConfig => 'Εισαγωγή Ρύθμισης';

  @override
  String get importContacts => 'Εισαγωγή Επαφών';

  @override
  String get importExportContacts => 'Εισαγωγή/Εξαγωγή Επαφών';

  @override
  String get importExportContactsTooltip => 'Εισαγωγή/Εξαγωγή Επαφών';

  @override
  String get importExportRules => 'Εισαγωγή/Εξαγωγή Κανόνων';

  @override
  String importFailed(Object error) {
    return 'Η εισαγωγή απέτυχε: $error';
  }

  @override
  String get importFailure => 'Αδυναμία εισαγωγής ρύθμισης';

  @override
  String get importFeatureComingSoon => 'Η λειτουργία εισαγωγής σύντομα';

  @override
  String get importLabels => 'Εισαγωγή Ετικετών';

  @override
  String importLabelsFailed(Object error) {
    return 'Αδυναμία εισαγωγής ετικετών: $error';
  }

  @override
  String get importPluginList => 'Εισαγωγή Λίστας Plugins';

  @override
  String importPluginListFailed(Object error) {
    return 'Αδυναμία εισαγωγής λίστας plugins: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Επιτυχής εισαγωγή $count plugins';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Εισαγωγή Ρυθμίσεων Κανόνων από Αρχείο';

  @override
  String get importRules => 'Εισαγωγή Κανόνων';

  @override
  String get importSuccess => 'Η εισαγωγή ολοκληρώθηκε';

  @override
  String get incomingCallInterceptAction =>
      'Ενέργεια Παρεμβολής Εισερχόμενης Κλήσης';

  @override
  String get incorrectPassword => 'Λανθασμένος κωδικός πρόσβασης';

  @override
  String get initializing => 'Αρχικοποίηση';

  @override
  String get installed => 'Εγκαταστάθηκε';

  @override
  String get insufficientMarks => 'Ανεπαρκή Σημάδια';

  @override
  String get insurance => 'Ασφάλιση';

  @override
  String get interceptAction => 'Ενέργεια Παρεμβολής';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Ορίστε πώς θα χειρίζονται οι αποκλεισμένες κλήσεις';

  @override
  String get interceptionActionSettingsTitle =>
      'Ρυθμίσεις Ενέργειας Παρεμβολής';

  @override
  String get interceptionTimeInterval => 'Χρονικό Διάστημα Παρεμβολής';

  @override
  String get internet => 'Διαδίκτυο';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Το διάστημα ενημέρωσης $service ορίστηκε σε $days ημέρες';
  }

  @override
  String get invalidContentRegex => 'Μη έγκυρο regex περιεχομένου';

  @override
  String get invalidLabel => 'Μη έγκυρη ετικέτα';

  @override
  String get invalidRegexPattern => 'Μη έγκυρο μοτίβο regex';

  @override
  String get invalidSenderRegex => 'Μη έγκυρο regex αποστολέα';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Συμμετοχή στο Κανάλι και την Ομάδα Telegram για Περισσότερες Πληροφορίες';

  @override
  String get jsonFormat => 'Μορφή JSON';

  @override
  String get keepAllVersions => 'Διατήρηση όλων των εκδόσεων';

  @override
  String get keepAllVersionsDescription =>
      'Διατηρήστε όλες τις ιστορικές εκδόσεις κάθε αντιγράφου ασφαλείας';

  @override
  String get label => 'Ετικέτα';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Η ετικέτα \"$name\" προστέθηκε επιτυχώς';
  }

  @override
  String get labelCategories => 'Κατηγορίες ετικετών';

  @override
  String get labelDeleted => 'Η ετικέτα διαγράφηκε';

  @override
  String get labelDescription =>
      'Οι ετικέτες σας βοηθούν να διαχειρίζεστε καλύτερα τις επαφές, προσθέστε προσαρμοσμένες ετικέτες σε αριθμούς τηλεφώνου για εύκολη αναγνώριση κλήσεων και μηνυμάτων.';

  @override
  String get labelFilterTooltip => 'Φίλτρο ετικέτας';

  @override
  String get labelIconColor => 'Χρώμα εικονιδίου ετικέτας';

  @override
  String get labelManagement => 'Διαχείριση ετικετών';

  @override
  String get labelNotFound => 'Η ετικέτα δεν βρέθηκε';

  @override
  String get labels => 'Ετικέτες';

  @override
  String get labelsColor => 'Χρώμα ετικετών';

  @override
  String labelsDeleted(Object count) {
    return '$count ετικέτες διαγράφηκαν';
  }

  @override
  String get labelsExportedSuccessfully => 'Οι ετικέτες εξήχθησαν με επιτυχία';

  @override
  String get labelsFontSize => 'Μέγεθος γραμματοσειράς ετικετών';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Επιτυχής εισαγωγή $count ετικετών';
  }

  @override
  String get labelsPosition => 'Θέση ετικετών';

  @override
  String labelTag(Object labelId) {
    return 'Ετικέτα: $labelId';
  }

  @override
  String labelUpdateFailed(Object error) {
    return 'Αποτυχία ενημέρωσης ετικέτας: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Η ετικέτα \"\$labelText\" ενημερώθηκε επιτυχώς';

  @override
  String get languageSettings => 'Ρυθμίσεις γλώσσας';

  @override
  String get languageSettingsSubtitle =>
      'Αλλαγή της γλώσσας εμφάνισης της εφαρμογής';

  @override
  String get languageSettingsTitle => 'Ρυθμίσεις γλώσσας';

  @override
  String get lastSyncLabel => 'Τελευταία Συγχρονισμός';

  @override
  String lastUpdated(Object date) {
    return 'Τελευταία ενημέρωση: $date';
  }

  @override
  String get lifetimeMembership => 'Εφ\' όρου ζωής συνδρομή';

  @override
  String get lifetimeMembershipDescription =>
      'Εφάπαξ αγορά, ξεκλειδώστε μόνιμα όλες τις premium λειτουργίες και τις μελλοντικές ενημερώσεις';

  @override
  String loadContactsFailed(Object error) {
    return 'Αποτυχία φόρτωσης επαφών: $error';
  }

  @override
  String get loadDataFailed => 'Αποτυχία φόρτωσης δεδομένων';

  @override
  String get loading => 'Φόρτωση...';

  @override
  String get loadingTags => 'Φόρτωση ετικετών...';

  @override
  String loadLabelFailed(Object error) {
    return 'Αποτυχία φόρτωσης ετικετών: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Αποτυχία φόρτωσης ετικετών: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Αποτυχία φόρτωσης αριθμών τηλεφώνου με σήμανση: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Αποτυχία φόρτωσης αριθμών με σήμανση: $error';
  }

  @override
  String loadPluginsFailed(Object error) {
    return 'Αποτυχία φόρτωσης πρόσθετων: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Αποτυχία φόρτωσης ρυθμίσεων: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Αποτυχία φόρτωσης κανόνων SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Αποτυχία φόρτωσης κατάστασης';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Αποτυχία φόρτωσης συνδρομών: $error';
  }

  @override
  String get loan => 'Δάνειο';

  @override
  String get localCounterFilter => 'Φίλτρο τοπικού μετρητή';

  @override
  String get localCounterFilterSubtitle =>
      'Αυτόματη φίλτρανση κλήσεων spam με βάση τη συχνότητα κλήσεων';

  @override
  String get localCountFilter => 'Φίλτρο τοπικής καταμέτρησης';

  @override
  String get localCountFilterDescription =>
      'Παρεμπόδιση συχνών κλήσεων με βάση τις τοπικές καταμετρήσεις αριθμών';

  @override
  String get localCountFilterExplanationContent =>
      'Το φίλτρο τοπικής καταμέτρησης αναλύει αρχεία ιστορικού κλήσεων για να εντοπίσει και να αποκλείσει αυτόματα συχνές κλήσεις spam.';

  @override
  String get localCountFilterExplanationTitle =>
      'Επεξήγηση Φίλτρου Τοπικής Καταμέτρησης';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Προσδιορισμός εάν θα αποκλειστεί με βάση την τιμή καταμέτρησης του αριθμού';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Όταν ο αριθμός καταμετρήσεων ενός αριθμού υπερβαίνει το καθορισμένο όριο, μπορείτε να επιλέξετε να τον αποκλείσετε αυτόματα';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Μπορείτε να επιτρέψετε επιλεκτικά αριθμούς που δεν υπερβαίνουν το όριο';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Μπορείτε να επιλέξετε αν θα καταγραφούν όλα τα αρχεία καταγραφής ερωτημάτων';

  @override
  String get localCountFiltering => 'Τοπική Καταμέτρηση Φιλτραρίσματος';

  @override
  String get localCountFilteringExplanation =>
      '• Τοπική Καταμέτρηση Φιλτραρίσματος: Κανόνες φιλτραρίσματος με βάση την τοπική καταμέτρηση σήμανσης';

  @override
  String get localCountFilterSettings =>
      'Ρυθμίσεις Φίλτρου Τοπικής Καταμέτρησης';

  @override
  String get localCountFilterUseCases =>
      'Αυτό το φίλτρο είναι ιδιαίτερα κατάλληλο για τον εντοπισμό αυτόματων κλήσεων spam και κλήσεων μάρκετινγκ.';

  @override
  String get localFilterSettings => 'Ρυθμίσεις Τοπικού Φίλτρου';

  @override
  String get localNotificationDisabled => 'Τοπική ειδοποίηση απενεργοποιημένη';

  @override
  String get localNotificationEnabled => 'Τοπική ειδοποίηση ενεργοποιημένη';

  @override
  String get localServices => 'Τοπικές Υπηρεσίες';

  @override
  String get locationColor => 'Χρώμα τοποθεσίας';

  @override
  String get locationFontSize => 'Μέγεθος γραμματοσειράς τοποθεσίας';

  @override
  String get locationIconColor => 'Χρώμα εικονιδίου τοποθεσίας';

  @override
  String get locationPosition => 'Θέση τοποθεσίας';

  @override
  String get logAllLocalQueries => 'Καταγραφή όλων των τοπικών ερωτημάτων';

  @override
  String get logAllLocalQueriesDescription =>
      'Καταγραφή όλων των ερωτημάτων τοπικών αριθμών';

  @override
  String get logAllRemoteQueries =>
      'Καταγραφή όλων των απομακρυσμένων ερωτημάτων';

  @override
  String get logAllRemoteQueriesDescription =>
      'Καταγραφή όλων των λειτουργιών ερωτημάτων απομακρυσμένων αριθμών';

  @override
  String get manage => 'Διαχείριση Επαφών';

  @override
  String get manageFavoriteContacts => 'Διαχείριση αγαπημένων επαφών';

  @override
  String get manageFilterRules => 'Διαχείριση κανόνων φίλτρου';

  @override
  String get manageFilterRulesDescription =>
      'Προσθήκη, επεξεργασία ή διαγραφή κανόνων φίλτρου SMS';

  @override
  String get markCounts => 'Μετρήσεις σήμανσης';

  @override
  String get markCount => 'Μέτρηση σήμανσης';

  @override
  String markedByCount(Object count) {
    return 'Σημασμένο από $count';
  }

  @override
  String get markedPhonesList => 'Λίστα αριθμών τηλεφώνου με σήμανση';

  @override
  String get markExchange => 'Ανταλλαγή σήμανσης';

  @override
  String get markPhone => 'Σήμανση αριθμού τηλεφώνου';

  @override
  String markPhoneFailed(Object error) {
    return 'Αποτυχία σήμανσης αριθμού τηλεφώνου: $error';
  }

  @override
  String get markPhoneManagementTitle => 'Διαχείριση Σήμανσης Αριθμών';

  @override
  String get markPhoneSuccess => 'Ο αριθμός τηλεφώνου σημάνθηκε επιτυχώς';

  @override
  String get matchFailedMessage => 'Η αντιστοίχιση απέτυχε.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'αντιστοιχεί σε συγκεκριμένη μορφή αριθμού';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Αντιστοίχιση αριθμών με ειδικούς χαρακτήρες:';

  @override
  String get matchSpecificDigitPatterns => 'αντιστοιχεί σε μορφή XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Αντιστοίχιση συγκεκριμένων μοτίβων ψηφίων:';

  @override
  String get matchSuccessfulMessage => 'Η αντιστοίχιση ήταν επιτυχής!';

  @override
  String get medical => 'Ιατρικό';

  @override
  String get membershipPrivileges => 'Προνόμια Μέλους';

  @override
  String get migrationTool => 'Εργαλείο Μετανάστευσης';

  @override
  String get minutes => 'λεπτά';

  @override
  String get month => 'Μήνας';

  @override
  String get monthly => 'Μηνιαίο';

  @override
  String get monthlyCallCount => 'Μηνιαίες Κλήσεις';

  @override
  String get monthlyMembership => 'Μηνιαία Συνδρομή';

  @override
  String get monthlyMembershipDescription =>
      'Ξεκλειδώστε όλες τις premium λειτουργίες, αυτόματη ανανέωση μηνιαίως';

  @override
  String get monthlyTotal => 'Μηνιαίο Σύνολο';

  @override
  String get moreOptions => 'Περισσότερες Επιλογές';

  @override
  String get mute => 'Σίγαση';

  @override
  String get name => 'Όνομα';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Το όνομα και ο αριθμός τηλεφώνου δεν μπορούν να είναι κενά';

  @override
  String get nameColor => 'Χρώμα Ονόματος';

  @override
  String get nameFontSize => 'Μέγεθος Γραμματοσειράς Ονόματος';

  @override
  String get namePosition => 'Θέση Ονόματος';

  @override
  String get nameUnknown => 'Όνομα: Άγνωστο';

  @override
  String get nextStep => 'Επόμενο';

  @override
  String get noAction => 'Καμία Ενέργεια';

  @override
  String get noActionRules => 'Κανόνες Καμίας Ενέργειας';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Δεν υπάρχει ενεργή υπηρεσία συγχρονισμού cloud';

  @override
  String get noCallRecords => 'Δεν υπάρχουν αρχεία κλήσεων';

  @override
  String get noContactsYet => 'Δεν υπάρχουν επαφές ακόμα';

  @override
  String get noData => 'Δεν υπάρχουν Δεδομένα';

  @override
  String get noDevicesRegisteredMessage => 'Δεν έχουν καταχωρηθεί συσκευές';

  @override
  String get noLabels => 'Δεν υπάρχουν ετικέτες ακόμα';

  @override
  String get noMarkedPhones => 'Δεν υπάρχουν σημειωμένοι αριθμοί τηλεφώνου';

  @override
  String get noMatchingContactsFound => 'Δεν βρέθηκαν αντίστοιχες επαφές';

  @override
  String get noMatchingNumbersFound => 'Δεν βρέθηκαν αντίστοιχοι αριθμοί';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Δεν υπάρχουν αντίστοιχοι $ruleType';
  }

  @override
  String get none => 'Κανένα';

  @override
  String get noneServiceType => 'Κανένα';

  @override
  String get noPlugins => 'Δεν υπάρχουν plugins ακόμα';

  @override
  String noRules(Object ruleType) {
    return 'Δεν υπάρχουν $ruleType ακόμα';
  }

  @override
  String get noRulesPrompt => 'Δεν βρέθηκαν κανόνες, προσθέστε κανόνες';

  @override
  String get noRulesToExport => 'Δεν υπάρχουν κανόνες για εξαγωγή';

  @override
  String get noSmsFilterRulesYet => 'Δεν υπάρχουν κανόνες φίλτρου SMS ακόμα';

  @override
  String get noSmsRulesYet => 'Δεν υπάρχουν κανόνες SMS ακόμα';

  @override
  String get noSubscriptions => 'Δεν υπάρχουν συνδρομές';

  @override
  String get notGranted => 'Δεν Παραχωρήθηκε';

  @override
  String get notificationModeDescription =>
      'Εμφάνιση πληροφοριών καλούντος στη γραμμή ειδοποιήσεων';

  @override
  String get notificationPermission => 'Άδεια Ειδοποίησης';

  @override
  String get notificationPermissionDescription =>
      'Χρησιμοποιείται για την εμφάνιση ειδοποιήσεων εισερχόμενων κλήσεων και μηνυμάτων.';

  @override
  String get notifications => 'Ειδοποιήσεις';

  @override
  String get notificationSettings => 'Ρυθμίσεις Ειδοποιήσεων';

  @override
  String get notVerifiedText => 'Δεν έχει Επαληθευτεί';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Δεν βρέθηκαν έγκυροι κανόνες SMS στο αρχείο';

  @override
  String get number => 'Αριθμός';

  @override
  String get numberColor => 'Χρώμα Αριθμού';

  @override
  String get numberFontSize => 'Μέγεθος Γραμματοσειράς Αριθμού';

  @override
  String get numberPosition => 'Θέση Αριθμού';

  @override
  String get numberSearch => 'Αναζήτηση Αριθμού';

  @override
  String get numberTypeColor => 'Χρώμα Τύπου Αριθμού';

  @override
  String get numberTypeFontSize => 'Μέγεθος Γραμματοσειράς Τύπου Αριθμού';

  @override
  String get numberTypePosition => 'Θέση Τύπου Αριθμού';

  @override
  String get okButton => 'Εντάξει';

  @override
  String get onboardingCompleteDescription =>
      'Ο διαχειριστής ασφάλειας κλήσεων σας είναι έτοιμος, ξεκινήστε να απολαμβάνετε μια ασφαλή εμπειρία κλήσεων!';

  @override
  String get onboardingLanguageDescription =>
      'Επιλέξτε την προτιμώμενη γλώσσα σας για την καλύτερη εμπειρία.';

  @override
  String get onboardingPermissionsDescription =>
      'Για να παρέχουμε πλήρη υπηρεσία, χρειαζόμαστε τις ακόλουθες άδειες:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Αποκλεισμός κλήσεων και μηνυμάτων spam με ένα κλικ, προσαρμογή κανόνων αποκλεισμού και παροχή ενός ήσυχου περιβάλλοντος.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Αυτόματη αναγνώριση άγνωστων κλήσεων, σήμανση ύποπτων αριθμών και προστασία της ασφάλειας των κλήσεών σας.';

  @override
  String get onboardingWelcomeDescription =>
      'Ο ειδικός διαχείρισης κλήσεων σας, παρέχει ολοκληρωμένες υπηρεσίες αναγνώρισης και αποκλεισμού κλήσεων.';

  @override
  String get oneDriveAuthDescription =>
      'Εξουσιοδοτήστε χρησιμοποιώντας το αναγνωριστικό και το κλειδί του πελάτη OneDrive που έχει ρυθμιστεί από το σύστημα';

  @override
  String get oneDriveConfigTitle => 'Ρύθμιση OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Συνδρομή Online Αναγνώρισης Κλήσεων';

  @override
  String get openAppSettings => 'Άνοιγμα ρυθμίσεων εφαρμογής';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Απέτυχε το άνοιγμα των ρυθμίσεων της εφαρμογής: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Η λειτουργία απέτυχε: $error';
  }

  @override
  String get operationFailure => 'Η λειτουργία απέτυχε';

  @override
  String get operationSuccess => 'Η λειτουργία πέτυχε';

  @override
  String get other => 'Άλλο';

  @override
  String get ourOtherApps => 'Άλλες Εφαρμογές μας';

  @override
  String get overlayMode => 'Επίπλεον Παράθυρο';

  @override
  String get overlayModeDescription =>
      'Εμφάνιση πληροφοριών καλούντος σε επίπλεον παράθυρο';

  @override
  String get overlayPermission => 'Άδεια Επίπλεον Παραθύρου';

  @override
  String get overlayPermissionDescription =>
      'Χρησιμοποιείται για την εμφάνιση επικάλυψης εισερχόμενης κλήσης.';

  @override
  String get overview => 'Επισκόπηση';

  @override
  String get password => 'Κωδικός πρόσβασης';

  @override
  String get passwordCannotBeEmpty =>
      'Ο κωδικός πρόσβασης δεν μπορεί να είναι κενός';

  @override
  String get passwordLabel => 'Κωδικός πρόσβασης';

  @override
  String get passwordsDoNotMatch => 'Οι κωδικοί πρόσβασης δεν ταιριάζουν';

  @override
  String get pattern => 'Μοτίβο';

  @override
  String get pendingSync => 'Αναμονή συγχρονισμού';

  @override
  String get periodMonth => 'Μήνας';

  @override
  String get periodWeek => 'Εβδομάδα';

  @override
  String get periodYear => 'Έτος';

  @override
  String get permissionDenied => 'Η αίτηση άδειας απορρίφθηκε';

  @override
  String get permissionGranted => 'Η άδεια χορηγήθηκε';

  @override
  String get permissionManagement => 'Διαχείριση αδειών';

  @override
  String get phoneCallsTab => 'Τηλέφωνο';

  @override
  String get phoneNumber => 'Αριθμός τηλεφώνου';

  @override
  String get phoneNumberCannotBeEmpty =>
      'Ο αριθμός τηλεφώνου δεν μπορεί να είναι κενός';

  @override
  String get phoneNumberLabel => 'Αριθμός τηλεφώνου';

  @override
  String get phoneNumberTypeFixedLine => 'Σταθερή γραμμή';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Σταθερή γραμμή ή κινητό';

  @override
  String get phoneNumberTypeMobile => 'Κινητό';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Προσωπικός αριθμός';

  @override
  String get phoneNumberTypePremiumRate => 'Premium Rate';

  @override
  String get phoneNumberTypeSharedCost => 'Κοινό κόστος';

  @override
  String get phoneNumberTypeTollFree => 'Χωρίς χρέωση';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Άγνωστο';

  @override
  String get phoneNumberTypeVoicemail => 'Φωνοτηλεφωνία';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Άδεια Τηλεφώνου';

  @override
  String get phonePermissionDescription =>
      'Χρησιμοποιείται για την αναγνώριση και τον αποκλεισμό εισερχόμενων κλήσεων.';

  @override
  String get phoneRule => 'Κανόνας Τηλεφώνου';

  @override
  String get phoneRuleManagement => 'Διαχείριση Κανόνων Τηλεφώνου';

  @override
  String get phoneRuleSubscription => 'Συνδρομή Κανόνων Τηλεφώνου';

  @override
  String get phoneSubscription => 'Συνδρομή Τηλεφώνου';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Εγγραφείτε σε λίστες κανόνων τηλεφώνου μέσω URL για αυτόματη ενημέρωση λευκών και μαύρων λιστών. Υποστηρίζει αρχεία κανόνων σε μορφή JSON.';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Παρακαλώ επιλέξτε μια ετικέτα και εισαγάγετε έναν έγκυρο αριθμό τηλεφώνου';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Το πρόσθετο \"$name\" προστέθηκε επιτυχώς';
  }

  @override
  String get pluginDeleted => 'Το πρόσθετο διαγράφηκε';

  @override
  String get pluginLatestVersion =>
      'Το πρόσθετο είναι ήδη στην τελευταία έκδοση';

  @override
  String get pluginListExportSuccess => 'Η λίστα πρόσθετων εξαγάχθηκε επιτυχώς';

  @override
  String get pluginManagement => 'Διαχείριση Πρόσθετων';

  @override
  String get pluginManagementSubtitle =>
      'Διαχειριστείτε και διαμορφώστε πρόσθετα τρίτων';

  @override
  String get pluginName => 'Όνομα Πρόσθετου';

  @override
  String pluginsDeleted(Object count) {
    return '$count πρόσθετα διαγράφηκαν επιτυχώς.';
  }

  @override
  String get pluginService => 'Υπηρεσία Πρόσθετων';

  @override
  String get pluginTestPageTitle => 'Δοκιμή Πρόσθετου';

  @override
  String get pluginUpdateSuccess => 'Το πρόσθετο ενημερώθηκε επιτυχώς';

  @override
  String get pluginUrl => 'URL Πρόσθετου';

  @override
  String get pluginVersion => 'Έκδοση Πρόσθετου';

  @override
  String get political => 'Πολιτικό';

  @override
  String get powerfulSpamBlocking => 'Ισχυρός Αποκλεισμός Spam';

  @override
  String get previousStep => 'Προηγούμενο';

  @override
  String get prioritizeRemoteAction =>
      'Προτεραιότητα Ρυθμίσεων Απομακρυσμένης Ενέργειας';

  @override
  String get prioritizeRemoteActionDescription =>
      'Προτεραιότητα ρυθμίσεων ενεργειών από την απομακρυσμένη βάση δεδομένων';

  @override
  String get processing => 'Επεξεργασία...';

  @override
  String get processingOperation => 'Επεξεργασία...';

  @override
  String get purchase => 'Αγορά';

  @override
  String get quarterlyMembership => 'Τριμηνιαία Συνδρομή';

  @override
  String get quarterlyMembershipDescription =>
      'Ξεκλειδώστε όλες τις premium λειτουργίες, αυτόματη ανανέωση ανά τρίμηνο';

  @override
  String get ready => 'Έτοιμο!';

  @override
  String get recruiter => 'Προσλήψεις';

  @override
  String get refresh => 'Ανανέωση';

  @override
  String get refreshPermissionStatus => 'Ανανέωση κατάστασης άδειας';

  @override
  String get refreshTooltip => 'Ανανέωση';

  @override
  String regexErrorMessage(Object error) {
    return 'Σφάλμα Regex: $error';
  }

  @override
  String get regexPattern => 'Μοτίβο Regex';

  @override
  String get regexPatternExplanation => 'Επεξήγηση Μοτίβου Regex';

  @override
  String get regexPatternExplanationButton => 'Επεξήγηση Μοτίβου Regex';

  @override
  String get regexPatternLabel => 'Μοτίβο Regex';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Μοτίβα Regex για Αντιστοίχιση Αριθμών Τηλεφώνου';

  @override
  String get regexRule => 'Κανόνας Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Αποτυχία προσθήκης κανόνα regex: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Ο κανόνας regex προστέθηκε επιτυχώς';

  @override
  String get regexRuleManagement => 'Διαχείριση Κανόνων Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'Το όνομα του κανόνα και το μοτίβο regex δεν μπορούν να είναι κενά';

  @override
  String get regexRules => 'Κανόνες Regex';

  @override
  String get regexTesterTitle => 'Ελεγκτής Regex';

  @override
  String get region => 'Περιοχή';

  @override
  String get registeredDevicesTitle => 'Καταχωρημένες Συσκευές';

  @override
  String get rejectAllCalls => 'Απόρριψη Όλων των Κλήσεων';

  @override
  String get rejectAllCallsDescription =>
      'Όταν είναι ενεργοποιημένο, όλες οι κλήσεις θα απορρίπτονται με την υψηλότερη προτεραιότητα';

  @override
  String get rejectAllNumbers => 'Απόρριψη Όλων των Αριθμών';

  @override
  String get rejectAllNumbersDesc =>
      'Απόρριψη όλων των εισερχόμενων κλήσεων όταν είναι ενεργοποιημένο';

  @override
  String get rejectExceededNumbers => 'Απόρριψη Υπέρβασης Αριθμών';

  @override
  String get rejectExceededNumbersDescription =>
      'Αυτόματη απόρριψη αριθμών που υπερβαίνουν το όριο του πλήθους';

  @override
  String get remoteFilterSettings => 'Ρυθμίσεις Απομακρυσμένου Φίλτρου';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Ρυθμίσεις Απομακρυσμένου Φίλτρου Αριθμών';

  @override
  String get remoteNumberFilter => 'Απομακρυσμένο Φίλτρο Αριθμών';

  @override
  String get remoteNumberFilterDescription =>
      'Αναχαίτιση ενοχλητικών κλήσεων βάσει πληροφοριών απομακρυσμένης βάσης δεδομένων';

  @override
  String get remoteNumberFiltering => 'Απομακρυσμένο Φιλτράρισμα Αριθμών';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Απομακρυσμένο Φιλτράρισμα Αριθμών: Κανόνες φιλτραρίσματος βάσει πληροφοριών απομακρυσμένης βάσης δεδομένων';

  @override
  String get remoteNumberFilterSubtitle =>
      'Αναγνωρίστε κλήσεις spam χρησιμοποιώντας βάση δεδομένων cloud και αναφορές κοινότητας';

  @override
  String get removeAdsDescription =>
      'Αφαιρέστε μόνιμα όλες τις διαφημίσεις στην εφαρμογή για μια πιο ομαλή εμπειρία';

  @override
  String get removeAdsTitle => 'Αφαίρεση Διαφημίσεων';

  @override
  String get removedFromFavorites => 'Αφαιρέθηκε από τις αγαπημένες επαφές';

  @override
  String get removeFromFavorites => 'Αφαίρεση από Αγαπημένα';

  @override
  String get renameDeviceTitle => 'Μετονομασία Συσκευής';

  @override
  String get requestAllPermissions => 'Αίτηση Όλων των Δικαιωμάτων';

  @override
  String get requestPermission => 'Αίτηση Δικαιώματος';

  @override
  String requestPermissionFailed(Object error) {
    return 'Αποτυχία αίτησης δικαιώματος: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Σημάδια';
  }

  @override
  String get reset => 'Επαναφορά';

  @override
  String get restore => 'Επαναφορά';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Επαναφορά Ρυθμίσεων Εφαρμογής από Αντίγραφο Ασφαλείας';

  @override
  String get restoreFromCloud => 'Επαναφορά από το Cloud';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Αποτυχία επαναφοράς από το cloud: $error';
  }

  @override
  String get restoreFromCloudSuccess => 'Επιτυχής επαναφορά από το cloud';

  @override
  String get restorePurchases => 'Επαναφορά Αγορών';

  @override
  String get restoreSettings => 'Επαναφορά Ρυθμίσεων';

  @override
  String get restoreSettingsConfirmation =>
      'Αυτό θα αντικαταστήσει όλες τις τρέχουσες ρυθμίσεις σας. Είστε σίγουροι ότι θέλετε να συνεχίσετε;';

  @override
  String get retry => 'Επανάληψη';

  @override
  String get ridesharing => 'Κοινή Χρήση Μετακινήσεων';

  @override
  String get risk => 'Κίνδυνος';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Ενέργεια Κανόνα';

  @override
  String get ruleAddedSuccess => 'Ο κανόνας προστέθηκε επιτυχώς';

  @override
  String get ruleAddSuccess => 'Ο κανόνας προστέθηκε επιτυχώς';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Είστε σίγουροι ότι θέλετε να διαγράψετε αυτόν τον $ruleType;';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Διαγραφή Κανόνα';

  @override
  String get ruleDeletedSuccessfully => 'Ο κανόνας διαγράφηκε επιτυχώς';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Αποτυχία διαγραφής κανόνα: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Ο κανόνας διαγράφηκε επιτυχώς';

  @override
  String get ruleDisabledSuccessfully => 'Ο κανόνας απενεργοποιήθηκε επιτυχώς';

  @override
  String get ruleEnabledSuccessfully => 'Ο κανόνας ενεργοποιήθηκε επιτυχώς';

  @override
  String ruleLoadFailed(Object error) {
    return 'Αποτυχία φόρτωσης κανόνων: $error';
  }

  @override
  String get ruleManagement => 'Διαχείριση Κανόνων';

  @override
  String get ruleName => 'Όνομα Κανόνα';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Το όνομα του κανόνα και το regex περιεχομένου δεν μπορούν να είναι κενά';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Το όνομα του κανόνα και ο αριθμός τηλεφώνου δεν μπορούν να είναι κενά';

  @override
  String get ruleNameHint => 'π.χ., Οικογένεια, Φίλοι, κ.λπ.';

  @override
  String get ruleNameLabel => 'Όνομα Κανόνα';

  @override
  String get ruleNameRequired =>
      'Το όνομα του κανόνα και ο αριθμός τηλεφώνου δεν μπορούν να είναι κενά';

  @override
  String get ruleNotExist => 'Ο κανόνας δεν υπάρχει ή έχει διαγραφεί';

  @override
  String ruleNotFound(Object error) {
    return 'Ο κανόνας δεν βρέθηκε: $error';
  }

  @override
  String get ruleSavedSuccessMessage => 'Ο κανόνας αποθηκεύτηκε με επιτυχία!';

  @override
  String get rulesExportedSuccessfully => 'Οι κανόνες εξήχθησαν με επιτυχία';

  @override
  String rulesExportedTo(Object path) {
    return 'Οι κανόνες εξήχθησαν σε: $path';
  }

  @override
  String get rulesImported => 'Οι κανόνες εισήχθησαν με επιτυχία';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count κανόνες εισήχθησαν με επιτυχία';
  }

  @override
  String ruleStatusChanged(Object status) {
    return 'Ο κανόνας $status με επιτυχία';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Η λειτουργία απέτυχε: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Ο κανόνας $status με επιτυχία';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Αποτυχία ενημέρωσης κανόνα: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Ο κανόνας ενημερώθηκε με επιτυχία';

  @override
  String get ruleVerification => 'Επαλήθευση κανόνα';

  @override
  String get save => 'Αποθήκευση';

  @override
  String get saveButton => 'Αποθήκευση';

  @override
  String get saveButtonText => 'Αποθήκευση';

  @override
  String saveFailed(Object error) {
    return 'Η αποθήκευση απέτυχε: $error';
  }

  @override
  String get saveSettings => 'Αποθήκευση ρυθμίσεων';

  @override
  String get scamsLikely => 'Πιθανές Απάτες';

  @override
  String get search => 'Αναζήτηση';

  @override
  String get searchContacts => 'Αναζήτηση επαφών';

  @override
  String searchError(Object error) {
    return 'Σφάλμα αναζήτησης: $error';
  }

  @override
  String get searchHint => 'Αναζήτηση...';

  @override
  String get securityMessage =>
      'Μην εμπιστεύεστε καμία τηλεφωνική κλήση. Επαληθεύετε πάντα τους αριθμούς εξυπηρέτησης πελατών ανεξάρτητα. Ποτέ μην μοιράζεστε κωδικούς πρόσβασης, κωδικούς επαλήθευσης, αριθμούς καρτών ή προσωπικά στοιχεία.';

  @override
  String get selectActionWhenBlockingCalls =>
      'Επιλέξτε ενέργεια κατά τον αποκλεισμό κλήσεων';

  @override
  String get selectActionWhenRuleMatches =>
      'Επιλέξτε ενέργεια όταν ο κανόνας ταιριάζει';

  @override
  String get selectAll => 'Επιλογή όλων';

  @override
  String get selectCountry => 'Επιλογή χώρας';

  @override
  String selectedItems(Object count) {
    return '$count στοιχεία επιλέχθηκαν';
  }

  @override
  String get selectedLabel => 'Επιλεγμένο:';

  @override
  String get selectExportFormat => 'Επιλογή μορφής εξαγωγής';

  @override
  String get selectLabel => 'Επιλογή ετικέτας';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Επιλέξτε μια ετικέτα και εισαγάγετε έναν έγκυρο αριθμό τηλεφώνου';

  @override
  String get selectLanguage => 'Επιλογή γλώσσας';

  @override
  String get selectMultiple => 'Επιλογή πολλαπλών';

  @override
  String get selectSimCard => 'Επιλογή κάρτας SIM';

  @override
  String get selectTags => 'Επιλογή ετικετών';

  @override
  String get selectTrustedDataSource =>
      'Παρακαλώ επιλέξτε αξιόπιστες πηγές δεδομένων';

  @override
  String get selectYourLanguage => 'Επιλέξτε τη γλώσσα σας';

  @override
  String get sender => 'Αποστολέας';

  @override
  String get senderRegexOptional => 'Κανονική έκφραση αποστολέα (Προαιρετικό)';

  @override
  String get serverAddressLabel => 'Διεύθυνση διακομιστή';

  @override
  String get serviceTypeContact => 'Συνδρομή επαφής';

  @override
  String get serviceTypeLabel => 'Τύπος υπηρεσίας';

  @override
  String get serviceTypePhone => 'Συνδρομή τηλεφώνου';

  @override
  String get serviceTypePlugin => 'Ενημέρωση plugin';

  @override
  String get serviceTypeSms => 'Συνδρομή SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setEncryptionPassword => 'Ορισμός κωδικού κρυπτογράφησης';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Οι ρυθμίσεις δημιουργήθηκαν αντίγραφο ασφαλείας σε: $path';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Οι ρυθμίσεις επαναφέρθηκαν με επιτυχία. Παρακαλώ επανεκκινήστε την εφαρμογή για να τεθούν σε ισχύ οι αλλαγές.';

  @override
  String get settingsSaved => 'Οι ρυθμίσεις αποθηκεύτηκαν';

  @override
  String settingsSaveFailed(Object error) {
    return 'Αποτυχία αποθήκευσης ρυθμίσεων: $error';
  }

  @override
  String get settingsTab => 'Ρυθμίσεις';

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get setup => 'Εγκατάσταση';

  @override
  String get silence => 'Σίγαση';

  @override
  String get silenceAndNoAnswer => 'Σίγαση και χωρίς απάντηση';

  @override
  String get silenceNoAnswer => 'Σίγαση χωρίς απάντηση';

  @override
  String get silentCallVoiceClone => 'Φωνητική κλωνοποίηση σιωπηλής κλήσης';

  @override
  String get silentRules => 'Σιωπηλοί κανόνες';

  @override
  String simCard(Object simNumber) {
    return 'Κάρτα SIM $simNumber';
  }

  @override
  String get simCardColor => 'Χρώμα κάρτας SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Διαμόρφωση κάρτας SIM: Ορισμός ανεξάρτητων κανόνων φιλτραρίσματος για κάθε κάρτα SIM';

  @override
  String get simCardFilterRules => 'Κανόνες φιλτραρίσματος κάρτας SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Ορισμός διαφορετικών κανόνων φιλτραρίσματος με βάση τις υποδοχές κάρτας SIM';

  @override
  String get simCardFontSize => 'Μέγεθος γραμματοσειράς κάρτας SIM';

  @override
  String get simCardPosition => 'Θέση κάρτας SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String get simRuleInstructions =>
      'Οι κανόνες καρτών SIM σάς επιτρέπουν να διαμορφώσετε ανεξάρτητους κανόνες φιλτραρίσματος για κάθε υποδοχή κάρτας SIM.';

  @override
  String get simRuleInstructionsTitle => 'Κανόνες Υποδοχής Κάρτας SIM';

  @override
  String simSlot1(String countryIso) {
    return 'SIM 1,-$countryIso';
  }

  @override
  String simSlot2(String countryIso) {
    return 'SIM 2,-$countryIso';
  }

  @override
  String get simSlotFilterDescription =>
      'Διαμορφώστε ανεξάρτητους κανόνες φιλτραρίσματος για κάθε κάρτα SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Ρυθμίσεις Φίλτρου Υποδοχής Κάρτας SIM $slotNumber';
  }

  @override
  String get simSlotManagement => 'Διαχείριση Υποδοχής Κάρτας SIM';

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Θέση Υποδοχής Κάρτας SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Κανόνες Υποδοχής Κάρτας SIM: Ανεξάρτητες στρατηγικές φιλτραρίσματος ανά SIM';

  @override
  String get simSlotRuleListTitle => 'Λίστα Κανόνων Υποδοχής Κάρτας SIM';

  @override
  String get simSlotRuleManagement => 'Κανόνες Υποδοχής Κάρτας SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Υποδοχή Κάρτας SIM $slotNumber';
  }

  @override
  String get skip => 'Παράλειψη';

  @override
  String get smartCallerId => 'Έξυπνη Αναγνώριση Κλήσεων';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Το φιλτράρισμα SMS σας βοηθά να φιλτράρετε αυτόματα τα ανεπιθύμητα μηνύματα και να διατηρείτε καθαρή τη λίστα μηνυμάτων σας. Μπορείτε να ορίσετε κανόνες φιλτραρίσματος και μεθόδους ειδοποίησης.';

  @override
  String get smsFilterDisabled => 'Το φιλτράρισμα SMS είναι απενεργοποιημένο';

  @override
  String get smsFilterEnabled => 'Το φιλτράρισμα SMS είναι ενεργοποιημένο';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Ο κανόνας φίλτρου SMS προστέθηκε επιτυχώς';

  @override
  String get smsFilterRules => 'Κανόνες Φίλτρου SMS';

  @override
  String get smsFilterSettings => 'Ρυθμίσεις Φίλτρου SMS';

  @override
  String get smsManagement => 'Διαχείριση SMS';

  @override
  String get smsPermission => 'Άδεια SMS';

  @override
  String get smsPermissionDescription =>
      'Χρησιμοποιείται για το φιλτράρισμα ανεπιθύμητων μηνυμάτων.';

  @override
  String get smsRuleAddedSuccessfully => 'Ο κανόνας SMS προστέθηκε επιτυχώς';

  @override
  String get smsRuleDeletedSuccessfully => 'Ο κανόνας SMS διαγράφηκε επιτυχώς';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Αποτυχία φόρτωσης κανόνων SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Διαχείριση Κανόνων SMS';

  @override
  String get smsRuleSubscription => 'Συνδρομή Κανόνων SMS';

  @override
  String get smsSubscription => 'Συνδρομή SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Η συνδρομή SMS προστέθηκε επιτυχώς';

  @override
  String get smsSubscriptionRulesDescription =>
      'Εγγραφείτε σε λίστες κανόνων SMS μέσω URL, υποστηρίζοντας αντιστοίχιση κανονικών εκφράσεων. Μπορείτε να ορίσετε ενέργειες αποκλεισμού ή αποδοχής.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Ορισμένα αιτήματα αδειών απορρίφθηκαν';

  @override
  String get spamLikely => 'Πιθανώς Spam';

  @override
  String get startColor => 'Χρώμα Έναρξης';

  @override
  String get startDate => 'Ημερομηνία Έναρξης';

  @override
  String get startUsing => 'Ξεκινήστε';

  @override
  String get statAnswered => 'Απαντήθηκαν';

  @override
  String get statBlocked => 'Αποκλείστηκαν';

  @override
  String get statistics => 'Στατιστικά';

  @override
  String get statisticsPageTitle => 'Ανάλυση Δεδομένων';

  @override
  String get stirColor => 'Χρώμα STIR';

  @override
  String get stirFontSize => 'Μέγεθος Γραμματοσειράς STIR';

  @override
  String get stirPosition => 'Θέση STIR';

  @override
  String get storagePermission => 'Άδεια Αποθήκευσης';

  @override
  String get storagePermissionDescription =>
      'Χρησιμοποιείται για την αποθήκευση ρυθμίσεων και κανόνων.';

  @override
  String get subscribe => 'Εγγραφή';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Η συνδρομή \"$name\" προστέθηκε επιτυχώς';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Είστε σίγουροι ότι θέλετε να διαγράψετε αυτήν τη συνδρομή;';

  @override
  String get subscriptionDeleteConfirmTitle => 'Διαγραφή Συνδρομής';

  @override
  String get subscriptionDeleted => 'Η συνδρομή διαγράφηκε';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Αποτυχία διαγραφής συνδρομής: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Η συνδρομή διαγράφηκε';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Αποτυχία φόρτωσης συνδρομών: $error';
  }

  @override
  String get subscriptionName => 'Όνομα Συνδρομής';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Το όνομα και η διεύθυνση URL της συνδρομής δεν μπορούν να είναι κενά';

  @override
  String get subscriptionNameHint => 'Εισάγετε όνομα συνδρομής';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Αποτυχία αλλαγής κατάστασης συνδρομής: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Αποτυχία ενημέρωσης συνδρομής: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Η συνδρομή ενημερώθηκε επιτυχώς';

  @override
  String get subscriptionUrl => 'Διεύθυνση URL Συνδρομής';

  @override
  String get subscriptionUrlHint => 'Εισάγετε διεύθυνση URL συνδρομής';

  @override
  String successfullyImportedRules(Object count) {
    return 'Επιτυχής εισαγωγή $count κανόνων';
  }

  @override
  String get supportSync => 'Υποστήριξη Συγχρονισμού';

  @override
  String get survey => 'Έρευνα';

  @override
  String get syncDevicesButton => 'Συγχρονισμός Συσκευών';

  @override
  String get syncFailed => 'Ο συγχρονισμός απέτυχε';

  @override
  String get syncFailedMessage => 'Ο συγχρονισμός απέτυχε';

  @override
  String get syncFolderNameLabel => 'Όνομα Φακέλου Συγχρονισμού';

  @override
  String get synchronized => 'Συγχρονισμένο';

  @override
  String get syncing => 'Συγχρονισμός...';

  @override
  String get syncNow => 'Συγχρονισμός τώρα';

  @override
  String get syncNowButton => 'Συγχρονισμός Τώρα';

  @override
  String get syncStatusTitle => 'Κατάσταση Συγχρονισμού';

  @override
  String get syncStatusUpdatedMessage => 'Η κατάσταση συγχρονισμού ενημερώθηκε';

  @override
  String get syncSuccessMessage => 'Ο συγχρονισμός ήταν επιτυχής';

  @override
  String get syncWithCloudStorage => 'Συγχρονισμός με Αποθηκευτικό Χώρο Cloud';

  @override
  String get systemFeatures => 'Λειτουργίες Συστήματος:';

  @override
  String get systemSettingsTitle => 'Ρυθμίσεις Συστήματος';

  @override
  String get tabAll => 'Όλα';

  @override
  String get tabAnswered => 'Απαντημένες';

  @override
  String get tabBlocked => 'Αποκλεισμένες';

  @override
  String get tabMissed => 'Αναπάντητες';

  @override
  String get tabOutgoing => 'Εξερχόμενες';

  @override
  String tagLabel(String tag) {
    return 'Ετικέτα: $tag';
  }

  @override
  String get takeaway => 'Takeaway';

  @override
  String get telecommunication => 'Τηλεπικοινωνίες';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Τηλεμάρκετινγκ';

  @override
  String get testButton => 'TEST';

  @override
  String get testConnectionButton => 'Έλεγχος Σύνδεσης';

  @override
  String get textColorsSetting => 'Χρώματα Κειμένου & Ετικετών';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Αυτή η εφαρμογή είναι ένα ισχυρό εργαλείο αναγνώρισης κλήσεων που σας επιτρέπει να αναγνωρίζετε και να αποκλείετε ανεπιθύμητες κλήσεις.';

  @override
  String get thisWeek => 'Αυτή την Εβδομάδα';

  @override
  String get timeInterceptor => 'Χρονικός Παρεμβολέας';

  @override
  String get timeInterceptorDescription =>
      'Αυτόματη παρεμβολή/αποδοχή πιθανών κλήσεων βάσει συχνότητας κλήσεων';

  @override
  String get timeInterceptorExplanation =>
      '• Χρονικός Παρεμβολέας: Παρεμβολή/αποδοχή επαναλαμβανόμενων κλήσεων σε σύντομο χρονικό διάστημα';

  @override
  String get timeInterceptorExplanationContent =>
      'Η λειτουργία παρεμβολής συχνότητας κλήσεων αναλύει τη συχνότητα κλήσεων για να αναγνωρίζει και να παρεμβαίνει/αποδέχεται αυτόματα συχνές κλήσεις spam.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Επεξήγηση Παρεμβολής Συχνότητας Κλήσεων';

  @override
  String get timeInterceptorSettingsTitle =>
      'Ρυθμίσεις Παρεμβολής Συχνότητας Κλήσεων';

  @override
  String get timeWindowDescription =>
      'Ορίστε το μέγεθος του χρονικού παραθύρου για την αποδοχή επαναλαμβανόμενων κλήσεων. Κλήσεις από τον ίδιο αριθμό εντός αυτού του παραθύρου θα γίνονται αποδεκτές';

  @override
  String timeWindowLabel(int minutes) {
    return 'Χρονικό Παράθυρο Παρεμβολής (λεπτά): $minutes';
  }

  @override
  String get today => 'Σήμερα';

  @override
  String get total => 'Σύνολο';

  @override
  String get totalBlocked => 'Σύνολο Αποκλεισμένων';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Μεταφορά δεδομένων μεταξύ συσκευών ή πλατφορμών';

  @override
  String get travelTicketing => 'Εισιτήρια Ταξιδίων';

  @override
  String get tutorial => 'Οδηγός';

  @override
  String get type => 'Τύπος';

  @override
  String get unassignedSIMCard => 'Μη ανατεθειμένη κάρτα SIM';

  @override
  String get unknown => 'Άγνωστο';

  @override
  String get unknownTag => 'Ετικέτα: Άγνωστο';

  @override
  String get unregisterButton => 'Αποεγγραφή';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Είστε σίγουροι ότι θέλετε να αποεγγράψετε τη συσκευή $deviceName;';
  }

  @override
  String get unregisterDeviceTitle => 'Αποεγγραφή Συσκευής';

  @override
  String get unsupportedFileFormat => 'Μη υποστηριζόμενη μορφή αρχείου';

  @override
  String get update => 'Ενημέρωση';

  @override
  String get updateAllNow => 'Ενημέρωση Όλων Τώρα';

  @override
  String updateContactFailed(Object error) {
    return 'Αποτυχία ενημέρωσης επαφής: $error';
  }

  @override
  String get updateFavoriteStatus => 'Ενημέρωση Κατάστασης Αγαπημένου';

  @override
  String get updateInterval => 'Διάστημα Ενημέρωσης';

  @override
  String get updateNow => 'Ενημέρωση Τώρα';

  @override
  String get updatePlugin => 'Ενημέρωση Πρόσθετου';

  @override
  String updatePluginFailed(Object error) {
    return 'Αποτυχία ενημέρωσης πρόσθετου: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Αποτυχία ενημέρωσης κανόνα: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Αποτυχία ενημέρωσης συνδρομής: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return 'Η υπηρεσία $service ενημερώθηκε με επιτυχία ($count κανόνες)';
  }

  @override
  String get useCasesPoint1 => '• Αναγνώριση αυτόματων επανακλήσεων spam';

  @override
  String get useCasesPoint2 =>
      '• Παρεμβολή διαφημιστικών κλήσεων που καλούν πολλές φορές σε σύντομο χρονικό διάστημα';

  @override
  String get useCasesPoint3 =>
      '• Αποτροπή βομβαρδισμών τηλεφώνου και παρενόχλησης';

  @override
  String get useCasesTitle => 'Περιπτώσεις Χρήσης:';

  @override
  String get useGlobalSettings => 'Χρήση Γενικών Ρυθμίσεων';

  @override
  String get usernameLabel => 'Όνομα χρήστη';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Χρησιμοποιήστε τυπική σύνταξη regex για τον ορισμό προτύπων. Παραδείγματα:';

  @override
  String get verificationFailedText => 'Απέτυχε';

  @override
  String get verifiedText => 'Επαληθεύτηκε';

  @override
  String get verify => 'Επαλήθευση';

  @override
  String version(Object version) {
    return 'Έκδοση: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Ανταλλαγή VIP συνδρομής με αριθμό κλήσεων σήμανσης';

  @override
  String get vipExchangeTitle => 'Ανταλλαγή VIP Σήμανσης';

  @override
  String get watchAd => 'Παρακολούθηση Διαφήμισης';

  @override
  String get watchAdForTemp =>
      'Παρακολούθηση Διαφήμισης για Προσωρινά Προνόμια';

  @override
  String get watchAdForTempDescription =>
      'Παρακολουθήστε μια σύντομη διαφήμιση για να ξεκλειδώσετε προσωρινά ορισμένες premium λειτουργίες';

  @override
  String get webDAVConfigTitle => 'Ρυθμίσεις WebDAV';

  @override
  String get week => 'Εβδομάδα';

  @override
  String get welcome => 'Καλώς ορίσατε';

  @override
  String get whitelist => 'Λευκή λίστα';

  @override
  String get width => 'Πλάτος';

  @override
  String get wildcardMatchingDescription =>
      'Χρησιμοποιήστε το \'.\' για να ταιριάξετε οποιονδήποτε χαρακτήρα (π.χ. το \'123.456\' ταιριάζει με 123-456)';

  @override
  String get wildcardMatchingTitle => 'Αντιστοίχιση μπαλαντέρ:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Υποστήριξη μπαλαντέρ για ευέλικτο φιλτράρισμα';

  @override
  String get windowSizeSetting => 'Μέγεθος παραθύρου';

  @override
  String get year => 'Έτος';

  @override
  String get noSimCardsDetected => 'Δεν εντοπίστηκαν κάρτες SIM';

  @override
  String get filterManagementDescription => 'Ορισμός φίλτρων κλήσεων';

  @override
  String get callerIdCustomizationSubtitle =>
      'Προσαρμογή διάταξης αναγνώρισης κλήσης';

  @override
  String get fraudAlerSettingTitle => 'Ρύθμιση ειδοποίησης απάτης';

  @override
  String get fraudAlerSettingSubtitle => 'Για ρύθμιση ειδοποίησης απάτης';

  @override
  String get enableFraudAlert => 'Ενεργοποίηση ειδοποίησης απάτης';

  @override
  String get enableFraudAlertDescription =>
      'Ειδοποίηση για ύποπτες κλήσεις απάτης';

  @override
  String get enableVibration => 'Ενεργοποίηση δόνησης';

  @override
  String get enableVibrationDescription =>
      'Δόνηση όταν η κλήση είναι ύποπτη για κλήσεις απάτης';

  @override
  String get notificationSettingsTitle => 'Ρυθμίσεις ειδοποιήσεων';

  @override
  String get useLocalNotification => 'Χρήση τοπικών ειδοποιήσεων';

  @override
  String get useLocalNotificationDescription =>
      'Ενεργοποίηση τοπικών ειδοποιήσεων για εισερχόμενες κλήσεις';

  @override
  String get cancelLocalNotification => 'Κλείσιμο τοπικών ειδοποιήσεων';

  @override
  String get useStirNotification => 'Χρήση ειδοποίησης από STIR';

  @override
  String get cancelLocalNotificationDescription =>
      'Αυτόματο κλείσιμο τοπικών ειδοποιήσεων';

  @override
  String get callerIdSettingsTitle => 'Ρυθμίσεις αναγνώρισης κλήσης';

  @override
  String get callerIdSettingsSubtitle =>
      'Για ρύθμιση εισερχόμενων ειδοποιήσεων κλήσης & λειτουργίας εμφάνισης';

  @override
  String get purchaseTitle => 'Αγορά';

  @override
  String get purchaseSubtitle => 'Για αγορά της υπηρεσίας';

  @override
  String get callerIdNotificationTitle => 'Πληροφορίες εισερχόμενης κλήσης';

  @override
  String get blockedCallTitle => 'Αποκλεισμένη κλήση';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Αποκλεισμένη κλήση από $phoneNumber';
  }

  @override
  String get stirVerified => 'Επαληθεύτηκε';

  @override
  String get stirNotVerified => 'Δεν επαληθεύτηκε';

  @override
  String get stirFailed => 'Η επαλήθευση απέτυχε';

  @override
  String get stirUnknown => 'Άγνωστη κατάσταση επαλήθευσης';

  @override
  String get stirVerificationTitle => 'Επαλήθευση STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage για τον αριθμό $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Ρυθμίσεις μηνύματος ασφαλείας κύλισης';

  @override
  String get messageColor => 'Χρώμα μηνύματος';

  @override
  String get messageFontSize => 'Μέγεθος γραμματοσειράς μηνύματος';

  @override
  String get messagePosition => 'Θέση μηνύματος';

  @override
  String get containerWidth => 'Πλάτος κοντέινερ';

  @override
  String get scrollSpeed => 'Ταχύτητα κύλισης';

  @override
  String get enableSecurityMessage => 'Ενεργοποίηση μηνύματος ασφαλείας';

  @override
  String get fraudAlertTitle => 'Ειδοποίηση απάτης';

  @override
  String get noBlockedTypeData =>
      'Δεν υπάρχουν διαθέσιμα δεδομένα τύπου αποκλεισμού';

  @override
  String importEntity(Object entityTypeName) {
    return 'Εισαγωγή $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return 'Επιτυχής εισαγωγή $entityTypeName, εισήχθησαν συνολικά $count εγγραφές';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Αποτυχία εισαγωγής $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Εξαγωγή $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return 'Επιτυχής εξαγωγή $entityTypeName';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Αποτυχία εξαγωγής $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Υπηρεσία συγχρονισμού cloud';

  @override
  String get membershipCenter => 'Κέντρο μελών';

  @override
  String get redeemVipWithMarks => 'Εξαργύρωση VIP με σήματα';

  @override
  String get currentMarkCount => 'Τρέχον πλήθος σημάτων';

  @override
  String get markMoreNumbersForMore =>
      'Σημειώστε περισσότερους αριθμούς για περισσότερα σήματα';

  @override
  String get noAds => 'Χωρίς διαφημίσεις';

  @override
  String get cloudBackup => 'Αντίγραφο ασφαλείας cloud';

  @override
  String get callerIdEnhancement => 'Βελτίωση αναγνώρισης κλήσης';

  @override
  String get voiceRecognition => 'Αναγνώριση φωνής';

  @override
  String get feature => 'Δυνατότητα';

  @override
  String get normalUser => 'Κανονικός χρήστης';

  @override
  String get vipUser => 'VIP χρήστης';

  @override
  String get temporaryVip => 'Προσωρινό VIP';

  @override
  String get removeAds => 'Κατάργηση διαφημίσεων';

  @override
  String get settingsBackup => 'Αντίγραφο ασφαλείας ρυθμίσεων ';

  @override
  String get allServicesStatusTitle => 'Τρέχουσα κατάσταση υπηρεσίας';

  @override
  String get allServicesStatusSubtitle =>
      'Τρέχουσα κατάσταση κάθε υπηρεσίας cloud';

  @override
  String get redirect => 'Ανακατεύθυνση';

  @override
  String get notify => 'Ειδοποίηση';

  @override
  String get log => 'Καταγραφή';

  @override
  String get custom => 'Προσαρμοσμένο';

  @override
  String get allowActionDescription =>
      'Οι κλήσεις θα επιτρέπονται, ακόμα κι αν ο αριθμός βρίσκεται στη λίστα αποκλεισμού.';

  @override
  String get blockActionDescription =>
      'Οι κλήσεις θα αποκλείονται και θα εμφανίζονται στο αρχείο καταγραφής κλήσεων.';

  @override
  String get silenceActionDescription =>
      'Οι κλήσεις θα σιωπούν, αλλά θα εμφανίζονται στο αρχείο καταγραφής κλήσεων.';

  @override
  String get noneActionDescription =>
      'Δεν θα πραγματοποιηθεί καμία ειδική ενέργεια για την κλήση.';

  @override
  String get redirectActionDescription =>
      'Ανακατεύθυνση της κλήσης σε έναν καθορισμένο αριθμό.';

  @override
  String get labelActionDescription =>
      'Προσθήκη ετικέτας στην κλήση για εύκολη αναγνώριση.';

  @override
  String get notifyActionDescription =>
      'Αποστολή ειδοποίησης κατά τη λήψη μιας κλήσης.';

  @override
  String get logActionDescription =>
      'Καταγραφή των πληροφοριών της κλήσης χωρίς καμία άλλη ενέργεια.';

  @override
  String get customActionDescription => 'Εκτέλεση προσαρμοσμένης ενέργειας.';

  @override
  String get synced => 'Συγχρονισμένο';

  @override
  String get needVipAccess =>
      'Χρειάζεστε πρόσβαση VIP για να χρησιμοποιήσετε αυτήν τη δυνατότητα';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Εισαγωγή ή εξαγωγή δεδομένων $entityTypeName';
  }

  @override
  String get importExportTitle => 'Εισαγωγή/Εξαγωγή';

  @override
  String get noPhoneRules => 'Δεν βρέθηκαν κανόνες τηλεφώνου';

  @override
  String get noRegexRules => 'Δεν βρέθηκαν κανόνες regex';

  @override
  String get noAllowedBlockedRules => 'Δεν βρέθηκαν κανόνες άδειας/αποκλεισμού';

  @override
  String get importExport => 'Εισαγωγή/Εξαγωγή';

  @override
  String get filterByAction => 'Φιλτράρισμα κατά ενέργεια';

  @override
  String get upgradeToVip => 'Αναβάθμιση σε VIP';

  @override
  String get batteryOptimizationPermission => 'Βελτιστοποίηση Μπαταρίας';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Επιτρέψτε στην εφαρμογή να εκτελείται στο παρασκήνιο για την παροχή υπηρεσιών όπως αναγνώριση κλήσεων.';

  @override
  String get permissionTitle => 'Ειδικές Άδειες';

  @override
  String get permissionSubtitle =>
      'Διαχείριση αδειών επικάλυψης και βελτιστοποίησης μπαταρίας';

  @override
  String get themeSettingsTitle => 'Ρυθμίσεις Θέματος';

  @override
  String get themeSettingsSubtitle => 'Επιλέξτε το αγαπημένο σας θέμα';

  @override
  String get themeLight => 'Фωτεινό';

  @override
  String get themeDark => 'Σκούρο';

  @override
  String get themeSystem => 'Προεπιλογή συστήματος';

  @override
  String get databaseSyncTitle => 'Συγχρονισμός Βάσης Δεδομένων';

  @override
  String get countrySyncSettingsTitle =>
      'Ρυθμίσεις Συγχρονισμού Βάσης Δεδομένων βάσει Χώρας';

  @override
  String get countrySyncSettingsSubtitle =>
      'Επιλέξτε χώρες για συγχρονισμό δεδομένων';

  @override
  String get countryDataDisclaimer =>
      'Σημείωση: Η βάση δεδομένων ενδέχεται να μην περιλαμβάνει δεδομένα για όλες τις συγκεκριμένες χώρες ή περιοχές.';

  @override
  String get editSubscription => 'Επεξεργασία Συνδρομής';

  @override
  String get searchByNameOrPhoneNumber => 'Αναζήτηση κατά Όνομα ή Τηλεφώνου';

  @override
  String get allowedBlockedRulesInfo =>
      'Οι κανόνες άδειας/απόρριψης χρησιμοποιούνται για την αντιστοίχιση κλήσεων με συγκεκριμένους αριθμούς τηλεφώνου, οι οποίοι έχουν την υψηλότερη προτεραιότητα.';

  @override
  String get searchPhoneRulesHint => 'Αναζήτηση κανόνων τηλεφώνου';

  @override
  String get phoneRulesInfo =>
      'Οι κανόνες τηλεφώνου χρησιμοποιούνται για την αντιστοίχιση κλήσεων με συγκεκριμένους αριθμούς τηλεφώνου, οι οποίοι έχουν χαμηλότερη προτεραιότητα. Κάποιοι προέρχονται από τις συνδρομές phoneRule.';

  @override
  String get searchSubscriptionsHint => 'Αναζήτηση συνδρομών';

  @override
  String get searchPluginsHint => 'Αναζήτηση plugins';

  @override
  String get searchLabelsHint => 'Αναζήτηση ετικετών';

  @override
  String get pluginDescription => 'Περιγραφή plugin';

  @override
  String get enterPluginDescription => 'Εισάγετε περιγραφή plugin';

  @override
  String get searchRegexRulesHint => 'Αναζήτηση κανόνων regex';

  @override
  String get regexRulesInfo =>
      'Οι κανόνες Regex χρησιμοποιούνται για το φιλτράρισμα κλήσεων με βάση τα μοτίβα Regex.';

  @override
  String get searchMarkedPhonesHint => 'Αναζήτηση σημειωμένων τηλεφώνων';

  @override
  String get searchContactSubscriptionsHint => 'Αναζήτηση συνδρομών επαφών';

  @override
  String get showAllContacts => 'Εμφάνιση Όλων Επαφών';

  @override
  String get showFavorites => 'Εμφάνιση Αγαπημένων';

  @override
  String get manualEntry => 'Πληροφορίες Χειροκίνητης Εισαγωγής';

  @override
  String get scriptSaved => 'Το σενάριο αποθηκεύτηκε';

  @override
  String editScriptFor(String pluginName) {
    return 'Επεξεργασία σεναρίου για $pluginName';
  }

  @override
  String get saveScript => 'Αποθήκευση Σεναρίου';

  @override
  String get testPlugin => 'Δοκιμή Plugin';

  @override
  String get description => 'Περιγραφή';

  @override
  String get accessTargetUrl => 'Πρόσβαση σε Διεύθυνση URL Στόχου';

  @override
  String get result => 'Αποτέλεσμα';

  @override
  String get editScript => 'Επεξεργασία Σεναρίου';

  @override
  String get numberFormat => 'Μορφή Αριθμού';

  @override
  String get nationalNumber => 'Εθνικός Αριθμός';

  @override
  String get e164Number => 'Αριθμός E164';

  @override
  String get pluginRulesInfo =>
      'Για λόγους ασφαλείας, χρησιμοποιήστε plugins μόνο από αξιόπιστες πηγές. Μη διστάσετε να χρησιμοποιήσετε τα πρότυπά μας για να δημιουργήσετε τα δικά σας προσαρμοσμένα plugins!';

  @override
  String get advancedMode => 'Προχωρημένη Λειτουργία';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Παρακαλώ εισάγετε τουλάχιστον έναν αριθμό.';

  @override
  String get openInWebView => 'Άνοιγμα σε WebView';

  @override
  String get pluginLabel => 'Ετικέτα Plugin';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Χρώμα Υποβάθρου Μηνύματος';

  @override
  String get clearAllCallLogs => 'Εκκαθάριση Όλων των Καταγραφών Κλήσεων';

  @override
  String get clearAllCallLogsConfirmation =>
      'Επιβεβαίωση εκκαθάρισης όλων των καταγραφών κλήσεων';

  @override
  String get allCallLogsCleared => 'Όλες οι καταγραφές κλήσεων εκκαθαρίστηκαν';

  @override
  String get unblocked => 'Αποκλεισμένο';

  @override
  String get blockNumber => 'Μπλοκάρισμα Αριθμού';

  @override
  String get blockNumberSuccess => 'Επιτυχία μπλοκαρίσματος αριθμού';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Είστε σίγουροι ότι θέλετε να ξεμπλοκάρετε τον αριθμό $phoneNumber;';
  }

  @override
  String get viewDetails => 'Προβολή Λεπτομερειών';

  @override
  String get unblock => 'Ξεμπλοκάρισμα';

  @override
  String get unblockNumber => 'Ξεμπλοκάρισμα Αριθμού';

  @override
  String get unblockNumberSuccess => 'Ο αριθμός ξεμπλοκαρίστηκε επιτυχώς';

  @override
  String get unblockNumberFailed => 'Αποτυχία ξεμπλοκαρίσματος αριθμού';

  @override
  String get callingNumberFailed => 'Η κλήση αριθμού απέτυχε';

  @override
  String get listView => 'Προβολή Λίστας';

  @override
  String get timelineView => 'Προβολή Χρονοδιαγράμματος';

  @override
  String get nameCannotBeEmpty => 'Το όνομα δεν μπορεί να είναι κενό';

  @override
  String get selectAction => 'Επιλέξτε την ενέργεια';

  @override
  String get selectTargetService => 'Επιλέξτε την υπηρεσία στόχο';

  @override
  String get callDetails => 'Λεπτομέρειες Κλήσης';

  @override
  String get callType => 'Τύπος Κλήσης';

  @override
  String get callTime => 'Ώρα Κλήσης';

  @override
  String get numberInvalidFormat => 'Μη έγκυρη μορφή αριθμού';

  @override
  String get medium => 'Μέσο';

  @override
  String get finalRisk => 'Τελικός Κίνδυνος';

  @override
  String get simState => 'Κατάσταση SIM';

  @override
  String get ipCountry => 'Χώρα IP';

  @override
  String get simCountry => 'Χώρα SIM';

  @override
  String get isRoaming => 'Περιαγωγή';

  @override
  String get isNumberMatch => 'Αντιστοιχία Αριθμού';

  @override
  String get support => 'Υποστήριξη';

  @override
  String get rewardedAdService => 'Υπηρεσία Διαφημίσεων με Ανταμοιβή';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Έχετε ήδη προνόμια VIP (εκτός διαφημίσεων)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Έχετε ήδη προσωρινά προνόμια, ημερομηνία λήξης: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Πρέπει να παρακολουθήσετε άλλες $count διαφημίσεις για να λάβετε προσωρινά προνόμια VIP';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Σας έχουν χορηγηθεί $days ημέρες προσωρινών προνομίων αγοράς. Ημερομηνία λήξης: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Το προσωρινό προνόμιο αγοράς έχει λήξει';

  @override
  String get loadingAd => 'Φόρτωση διαφήμισης...';

  @override
  String get earnedTempVip => 'Κερδήθηκε προσωρινό VIP';

  @override
  String get vipExchangeService => 'Υπηρεσία Ανταλλαγής VIP';

  @override
  String get marksInsufficient => 'Ανεπαρκή σημεία για ανταλλαγή';

  @override
  String get invalidExchangeRule => 'Μη έγκυρος κανόνας ανταλλαγής';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Επιτυχής ανταλλαγή για $description, ημερομηνία λήξης: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Η ανταλλαγή απέτυχε: $error';
  }

  @override
  String get vip3DaysWithAds => '3ήμερο VIP με διαφημίσεις (μόνο συγχρονισμός)';

  @override
  String get vip5DaysNoAds => '5ήμερο πλήρες VIP χωρίς διαφημίσεις';

  @override
  String get vip7DaysNoAds => '7ήμερο πλήρες VIP χωρίς διαφημίσεις';

  @override
  String get noNotifications => 'Καμία ειδοποίηση';

  @override
  String get clearAllNotifications => 'Εκκαθάριση Όλων των Ειδοποιήσεων';

  @override
  String get clearAllNotificationsConfirmation =>
      'Επιβεβαίωση εκκαθάρισης όλων των ειδοποιήσεων';

  @override
  String get clearButton => 'Εκκαθάριση';

  @override
  String get justNow => 'Τώρα';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count λεπτά πριν',
      one: '1 λεπτό πριν',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ώρες πριν',
      one: '1 ώρα πριν',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ημέρες πριν',
      one: '1 ημέρα πριν',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Χθες';

  @override
  String get deletionProposal => 'Πρόταση Διαγραφής';

  @override
  String get createProposal => 'Δημιουργία Πρότασης';

  @override
  String get createProposalTitle => 'Δημιουργία Πρότασης Διαγραφής';

  @override
  String get reason => 'Λόγος';

  @override
  String get reasonOutdated => 'Απαριθμημένος Αριθμός';

  @override
  String get reasonPrivacy => 'Ανησυχία Απορρήτου';

  @override
  String get reasonNotInService => 'Όχι σε Υπηρεσία';

  @override
  String get reasonWronglyIdentified => 'Λανθασμένη Ταυτοποίηση';

  @override
  String get reasonInaccurateInfo => 'Ανακριβείς Πληροφορίες';

  @override
  String get reasonOther => 'Άλλο';

  @override
  String get submit => 'Υποβολή';

  @override
  String get cancel => 'Ακύρωση';

  @override
  String get riskLevel => 'Επίπεδο Κινδύνου';

  @override
  String get riskLevelLow => 'Χαμηλό';

  @override
  String get riskLevelHigh => 'Υψηλό';

  @override
  String agreeVotes(int count) {
    return 'Σύμφωνοι: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Σύνολο: $count';
  }

  @override
  String get voteAgree => 'Συμφωνώ';

  @override
  String get voteDisagree => 'Διαφωνώ';

  @override
  String createdAt(String date) {
    return 'Δημιουργήθηκε: $date';
  }

  @override
  String get verificationReport => 'Έκθεση Επαλήθευσης';

  @override
  String get proposalStatistics => 'Στατιστικά Πρότασης';

  @override
  String get totalProposals => 'Σύνολο Προτάσεων';

  @override
  String get activeProposals => 'Ενεργές Προτάσεις';

  @override
  String get proposalCreated => 'Η πρόταση δημιουργήθηκε επιτυχώς';

  @override
  String get voteSubmitted => 'Η ψήφος υποβλήθηκε επιτυχώς';

  @override
  String get noProposalsFound => 'Δεν βρέθηκαν προτάσεις';

  @override
  String get refreshProposals => 'Ανανέωση Προτάσεων';

  @override
  String get totalPendingProposals => 'Σύνολο Προτάσεων σε Εκκρεμότητα';

  @override
  String get highRisk => 'Υψηλός Κίνδυνος';

  @override
  String get mediumRisk => 'Μεσαίος Κίνδυνος';

  @override
  String get lowRisk => 'Χαμηλός Κίνδυνος';

  @override
  String get communityImpact => 'Επίπτωση στην Κοινότητα';

  @override
  String get criticalIssues => 'Κρίσιμα Θέματα';

  @override
  String get communityParticipation => 'Συμμετοχή Κοινότητας';

  @override
  String get noActivity => 'Καμία Δραστηριότητα';

  @override
  String get low => 'Χαμηλό';

  @override
  String get moderate => 'Μέτριο';

  @override
  String get high => 'Υψηλό';

  @override
  String get veryHigh => 'Πολύ Υψηλό';

  @override
  String get voted => 'Ψήφισε';

  @override
  String get communityVotes => 'Ψήφοι Κοινότητας';

  @override
  String get waitingForMoreVotes =>
      'Αναμονή για περισσότερες ψήφους κοινότητας';

  @override
  String get proposalProcessed => 'Αυτή η πρόταση έχει διεκπεραιωθεί';

  @override
  String get supported => 'ΥΠΟΣΤΗΡΙΞΗ';

  @override
  String get opposed => 'ΑΝΤΙΘΕΣΗ';

  @override
  String get approved => 'ΕΓΚΡΙΘΗΚΕ';

  @override
  String get rejected => 'ΑΠΟΡΡΙΦΘΗΚΕ';

  @override
  String get completed => 'ΟΛΟΚΛΗΡΩΘΗΚΕ';

  @override
  String get pending => 'ΣΕ ΕΚΚΡΕΜΟΤΗΤΑ';

  @override
  String get critical => 'Κρίσιμο';

  @override
  String get oppose => 'Αντίθεση';

  @override
  String get veryLow => 'Πολύ Χαμηλό';

  @override
  String get deletionProposals => 'Προτάσεις Διαγραφής';

  @override
  String get deletionProposalNotificationDescription =>
      'Ειδοποιήσεις για τα αποτελέσματα και τις ενημερώσεις ψηφοφορίας προτάσεων διαγραφής.';

  @override
  String get deletionProposalCreated => 'Δημιουργήθηκε Πρόταση Διαγραφής';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Η πρότασή σας για διαγραφή του $phoneNumber υποβλήθηκε για αναθεώρηση από την κοινότητα.';
  }

  @override
  String get proposalApproved => 'Η Πρόταση Εγκρίθηκε ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Η πρόταση διαγραφής για το $phoneNumber εγκρίθηκε από την κοινότητα ($supportPercentage% υποστήριξη, $totalVotes ψήφοι).';
  }

  @override
  String get proposalRejected => 'Η Πρόταση Απορρίφθηκε ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Η πρόταση διαγραφής για το $phoneNumber απορρίφθηκε από την κοινότητα ($supportPercentage% υποστήριξη, $totalVotes ψήφοι).';
  }

  @override
  String get communityVotingStarted => 'Ξεκίνησε η Ψηφοφορία Κοινότητας';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Μια νέα πρόταση διαγραφής για το $phoneNumber είναι πλέον διαθέσιμη για ψηφοφορία από την κοινότητα.';
  }

  @override
  String get votingCompleted => 'Η Ψηφοφορία Ολοκληρώθηκε';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Η ψηφοφορία της κοινότητας για το $phoneNumber ολοκληρώθηκε. Αποτέλεσμα: $result ($supportPercentage% υποστήριξη).';
  }

  @override
  String get newVoteReceived => 'Λήφθηκε Νέα Ψήφος';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Κάποιος ψήφισε να $voteType τη διαγραφή του $phoneNumber. Τρέχουσες ψήφοι: $totalVotes.';
  }

  @override
  String get voteCount => 'Αριθμός Ψήφων';

  @override
  String get deletionProposalDescription =>
      'Προτείνετε αριθμούς για διαγραφή που παραβιάζουν τις οδηγίες της κοινότητας. Η συμμετοχή σας βοηθά να διατηρηθεί η πλατφόρμα ασφαλής.';

  @override
  String get searchProposals => 'Αναζήτηση Προτάσεων';

  @override
  String get defaultNotifications => 'Προεπιλεγμένες Ειδοποιήσεις';

  @override
  String get defaultNotificationsDescription =>
      'Προεπιλεγμένο κανάλι ειδοποιήσεων για την εφαρμογή.';

  @override
  String get blockedCallNotifications => 'Ειδοποιήσεις Αποκλεισμένων Κλήσεων';

  @override
  String get blockedCallNotificationsDescription =>
      'Εμφανίζει πληροφορίες σχετικά με τις αποκλεισμένες κλήσεις.';

  @override
  String get stirVerification => 'Επαλήθευση STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Εμφανίζει τα αποτελέσματα επαλήθευσης STIR/SHAKEN για αριθμούς.';

  @override
  String get fraudAlerts => 'Ειδοποιήσεις Απάτης';

  @override
  String get fraudAlertsDescription =>
      'Εμφανίζει προειδοποιήσεις για πιθανές δόλιες κλήσεις.';

  @override
  String get notificationMode => 'Λειτουργία Ειδοποίησης';

  @override
  String get pendingProposals => 'Εκκρεμείς Προτάσεις';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count εκκρεμείς προτάσεις',
      one: '1 εκκρεμή πρόταση',
      zero: 'καμία εκκρεμή πρόταση',
    );
    return 'Έχετε $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Οδηγίες';

  @override
  String get riskLevelLabel => 'Επίπεδο Κινδύνου';

  @override
  String get phoneNumberMinDigits =>
      'Ο αριθμός τηλεφώνου πρέπει να έχει τουλάχιστον 7 ψηφία';

  @override
  String get provideDetailedExplanation =>
      'Παρέχετε λεπτομερή εξήγηση (τουλάχιστον 10 χαρακτήρες)';

  @override
  String get reasonMinCharacters =>
      'Ο λόγος πρέπει να είναι τουλάχιστον 10 χαρακτήρες';

  @override
  String get countryCodeTwoLetters => 'Κωδικός χώρας (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Κωδικός χώρας (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'π.χ., US, CN, GB';

  @override
  String get countryCodeRequired => 'Απαιτείται κωδικός χώρας';

  @override
  String get phoneNumberHint => 'Εισαγάγετε αριθμό τηλεφώνου';

  @override
  String get phoneNumberRequired => 'Απαιτείται αριθμός τηλεφώνου';

  @override
  String get reasonRequired => 'Απαιτείται λόγος';

  @override
  String get riskLevelCritical => 'Κρίσιμο';

  @override
  String get riskLevelMedium => 'Μεσαίο';

  @override
  String get riskLevelVeryLow => 'Πολύ Χαμηλό';

  @override
  String get notificationFrequencyTitle => 'Συχνότητα Ειδοποιήσεων';

  @override
  String errorMessage(String error) {
    return 'Σφάλμα: $error';
  }

  @override
  String get reportingGuidelines =>
      '• Αναφέρετε μόνο αριθμούς που είναι πραγματικά προβληματικοί\n• Παρέχετε ακριβείς και λεπτομερείς λόγους\n• Επιλέξτε το κατάλληλο επίπεδο κινδύνου ανάλογα με τη σοβαρότητα\n• Ψευδείς αναφορές μπορεί να οδηγήσουν σε περιορισμούς λογαριασμού';

  @override
  String get notificationFrequencyHours => 'Συχνότητα Ειδοποιήσεων (Ώρες)';

  @override
  String supportCount(int supportCount) {
    return 'Υποστήριξη ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Κατά ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes ψήφοι ($supportPercentage% υποστήριξη)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ώρες',
      one: '1 ώρα',
      zero: '0 ώρες',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Σημαντική Ειδοποίηση';

  @override
  String get dataSourceDisclaimer =>
      'Οι αριθμοί προέρχονται από το διαδίκτυο και υποβολές χρηστών. Δεν μπορούμε να εγγυηθούμε ότι ένας αριθμός, μόλις διαγραφεί, δεν θα υποβληθεί ξανά από άλλους χρήστες ή πηγές. Παρακαλούμε αναζητήστε και επαληθεύστε ενεργά τις πληροφορίες.';

  @override
  String get avatar => 'Εικονίδιο';

  @override
  String get location => 'Τοποθεσία';

  @override
  String get simCardTitle => 'Κάρτα SIM';

  @override
  String get liveActivitiesSettingsTitle => 'Ρυθμίσεις Ζωντανών Δραστηριοτήτων';

  @override
  String get elementsSettingsTitle => 'Ρυθμίσεις Στοιχείων';

  @override
  String get liveActivityMode => 'Ζωντανή Δραστηριότητα';

  @override
  String get liveActivityModeDescription =>
      'Εμφανίζει πληροφορίες κλήσεων ως συνεχή ειδοποίηση στην οθόνη κλειδώματος και στο Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Τύπος Αριθμού Τηλεφώνου';

  @override
  String get liveActivitiesTestEndActivity => 'Τέλος Δραστηριότητας';

  @override
  String get liveActivitiesTestSendNewActivity =>
      'Αποστολή Νέας Δραστηριότητας';

  @override
  String get liveActivitiesTestUpdateActivity => 'Ενημέρωση Δραστηριότητας';

  @override
  String get liveActivityControlsTitle => 'Έλεγχοι Ζωντανής Δραστηριότητας';

  @override
  String get liveActivitiesTestTitle => 'Δοκιμή Ζωντανών Δραστηριοτήτων';

  @override
  String get liveNotificationCustomizationTitle =>
      'Προσαρμογή Ζωντανών Ειδοποιήσεων';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Προσαρμόστε την εμφάνιση των ζωντανών ειδοποιήσεων.';

  @override
  String get notification_instructions =>
      'Οδηγίες:\n1. Πατήστε \"ΑΠΟΣΤΟΛΗ\" για να δημιουργήσετε ή να ενημερώσετε μια ειδοποίηση.\n2. Μεταβείτε στην αρχική οθόνη ή τραβήξτε προς τα κάτω τη γραμμή ειδοποιήσεων για να δείτε το αποτέλεσμα.\n3. Πατήστε \"ΤΕΛΟΣ\" για να απορρίψετε την ειδοποίηση.';

  @override
  String get autoCancelNotification => 'Αυτόματη Απόρριψη Ειδοποίησης';

  @override
  String get autoCancelNotificationDescription =>
      'Αν επιλεγεί, η ειδοποίηση θα απορριφθεί αυτόματα όταν ο χρήστης την πατήσει.';

  @override
  String get setDelayTime => 'Ορισμός Χρόνου Καθυστέρησης';

  @override
  String get proposalDetails => 'Λεπτομέρειες Πρότασης';

  @override
  String get proposalNotFound => 'Η πρόταση δεν βρέθηκε';

  @override
  String get processed => 'Επεξεργασμένο';

  @override
  String get filterAndSortTitle => 'Φιλτράρισμα και Ταξινόμηση';

  @override
  String get filterVerifiedOwner => 'Φιλτράρισμα Επαληθευμένου Ιδιοκτήτη';

  @override
  String get filterBy => 'Φιλτράρισμα κατά';

  @override
  String get sortOldest => 'Ταξινόμηση Παλαιότερων';

  @override
  String get sortNewest => 'Ταξινόμηση Νεότερων';

  @override
  String get sortMostPopular => 'Ταξινόμηση Δημοφιλέστερων';

  @override
  String get sortLeastPopular => 'Ταξινόμηση Λιγότερο Δημοφιλών';

  @override
  String get sortBy => 'Ταξινόμηση κατά';

  @override
  String get simRulesNotFound => 'Κανόνες SIM δεν βρέθηκαν';

  @override
  String get simSlotRules => 'Κανόνες Υποδοχής SIM';

  @override
  String get noSimCardDetected => 'Δεν ανιχνεύθηκε κάρτα SIM';

  @override
  String get invalidSimData => 'Μη έγκυρα δεδομένα SIM';

  @override
  String get simSlot => 'Υποδοχή SIM';

  @override
  String get enableFiltering => 'Ενεργοποίηση Φιλτραρίσματος';

  @override
  String get detailedSettingsTitle => 'Λεπτομερείς Ρυθμίσεις';

  @override
  String get entryPointViewTitle => 'Οθόνη Σημείου Εισόδου';

  @override
  String get callTypeRejected => 'Απορρίφθηκε';

  @override
  String get callTypeSilenced => 'Σίγαση';

  @override
  String andMoreItems(int count) {
    return 'και άλλα $count στοιχεία';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

  @override
  String get localDatabaseSyncSubtitle => 'Sync data across devices';

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
  String get fieldIsRequired => 'This field is required';

  @override
  String get answerThenHangupDescription =>
      'Automatically answer the incoming call and then immediately hang up to terminate it';

  @override
  String get initialSetupTitle => 'Rule Library Setup';

  @override
  String get initialSetupDesc =>
      'Please select the regional rule libraries you want to block. These rules can help you automatically block common sales and scam calls in your region.';

  @override
  String get initialSetupRetry => 'Retry';

  @override
  String get initialSetupSkip => 'Skip';

  @override
  String get initialSetupSave => 'One-click setup selected';

  @override
  String get initialSetupSaving => 'Saving...';

  @override
  String get initialSetupSaveSuccess =>
      '✅ Configuration saved successfully, rules will be fetched automatically soon';

  @override
  String initialSetupSaveFailed(String error) {
    return 'Failed to save configuration: $error';
  }

  @override
  String get initialSetupGetFailed => 'Failed to get configuration';

  @override
  String get initialSetupSourceTitle => 'Data Source';

  @override
  String get initialSetupSourceGithub => 'GitHub (Raw)';

  @override
  String get initialSetupSourceCdn => 'CDN Mirror';

  @override
  String get initialSetupSourceCustom => 'Custom URL';

  @override
  String get initialSetupCustomUrlHint => 'Enter custom config JSON URL';

  @override
  String get initialSetupCustomUrlLoad => 'Load Config';

  @override
  String get initialSetupSearchHint => 'Αναζήτηση συνόλου κανόνων ή χώρας...';

  @override
  String get initialSetupSelectAll => 'Επιλογή όλων';

  @override
  String get initialSetupDeselectAll => 'Καθαρισμός επιλογής';

  @override
  String initialSetupSelectedCount(int count) {
    return 'Επιλέχθηκαν $count';
  }

  @override
  String get initialSetupDetectedLocation => 'Recommended for your location';

  @override
  String deepLinkImportTitle(String type) {
    return 'Import $type';
  }

  @override
  String get deepLinkTypePlugin => 'Plugin';

  @override
  String get deepLinkTypeSubscription => 'Rule Subscription';

  @override
  String get deepLinkDefaultPluginName => 'External Plugin';

  @override
  String get deepLinkDefaultSubName => 'External Rule Subscription';

  @override
  String get deepLinkDetectedTitle => 'External Import Request Detected';

  @override
  String deepLinkNameLabel(String name) {
    return 'Name: $name';
  }

  @override
  String deepLinkTypeLabel(String type) {
    return 'Type: $type';
  }

  @override
  String deepLinkUrlLabel(String url) {
    return 'URL: $url';
  }

  @override
  String get deepLinkConfirmButton => 'Confirm Import';

  @override
  String get deepLinkEmptyUrlError => 'URL is empty, cannot import';

  @override
  String deepLinkPluginDownloadFailed(Object error) {
    return 'Failed to download or parse plugin script';
  }

  @override
  String get deepLinkImportSuccess => '✅ Imported successfully';

  @override
  String deepLinkImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get initialSetupSettingsHint =>
      'Tip: You can re-open this setup page anytime in Settings.';

  @override
  String get initialSetupGoToSettings => 'Go to Settings';

  @override
  String get separateSims => 'Separate SIMs';

  @override
  String get separateSimsDesc =>
      'Enable separate filtering rules for each SIM card';

  @override
  String get masterAndOverrides => 'Master Controls';

  @override
  String get masterAndOverridesDesc => 'Global Rule Settings';
}
