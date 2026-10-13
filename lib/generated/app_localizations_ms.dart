// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get aboutContactSubscription => 'Mengenai Langganan Kenalan';

  @override
  String get aboutLabels => 'Mengenai Label';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Mengenai Peraturan Langganan Telefon';

  @override
  String get aboutSmsFilter => 'Mengenai Penapisan SMS';

  @override
  String get aboutSmsSubscriptionRules => 'Mengenai Peraturan Langganan SMS';

  @override
  String get aboutSubtitle => 'Versi aplikasi dan maklumat undang-undang';

  @override
  String get aboutTitle => 'Mengenai';

  @override
  String get action => 'Tindakan';

  @override
  String get actionAll => 'Semua';

  @override
  String get actionAllow => 'Benar';

  @override
  String get actionBlock => 'Sekat';

  @override
  String get actionFilterTitle => 'Tapis mengikut Jenis Tindakan';

  @override
  String get actionFilterTooltip => 'Penapis Tindakan';

  @override
  String get actionNone => 'Tiada Tindakan';

  @override
  String get actionSilence => 'Senyap';

  @override
  String actionTag(Object actionType) {
    return 'Tindakan: $actionType';
  }

  @override
  String get actionType => 'Jenis Tindakan';

  @override
  String get actionUnknown => 'Tidak Diketahui';

  @override
  String get add => 'Tambah';

  @override
  String get addAllowedBlockedRule => 'Tambah Peraturan Benar/Sekat';

  @override
  String get addAllowSubscription => 'Tambah Langganan Benar';

  @override
  String get addBlockSubscription => 'Tambah Langganan Sekat';

  @override
  String get addContactButton => 'Tambah Kenalan';

  @override
  String addContactFailed(Object error) {
    return 'Gagal menambah kenalan: $error';
  }

  @override
  String get addedToFavorites => 'Ditambah kepada kenalan kegemaran';

  @override
  String get addLabel => 'Tambah Label';

  @override
  String get addLabelButton => 'Tambah Label';

  @override
  String addLabelFailed(Object error) {
    return 'Gagal menambah label: $error';
  }

  @override
  String get addName => 'Tambah Nama';

  @override
  String get addNoneSubscription => 'Tambah Langganan Tiada';

  @override
  String get addPhoneMark => 'Tambah Tanda Telefon';

  @override
  String get addPhoneNumberRule => 'Tambah Peraturan Nombor Telefon';

  @override
  String get addPlugin => 'Tambah Plugin';

  @override
  String get addPluginFailed => 'Gagal menambah plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Gagal menambah plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Tambah Plugin dari Fail Tempatan';

  @override
  String get addPluginFromUrl => 'Tambah Plugin dari URL';

  @override
  String get addRegexRule => 'Tambah Peraturan Regex';

  @override
  String get addRule => 'Tambah Peraturan';

  @override
  String addRuleFailed(Object error) {
    return 'Gagal menambah peraturan: $error';
  }

  @override
  String get addRuleTooltip => 'Tambah Peraturan';

  @override
  String get addSilenceSubscription => 'Tambah Langganan Senyap';

  @override
  String get addSmsFilterRule => 'Tambah Peraturan Penapis SMS';

  @override
  String get addSmsRule => 'Tambah Peraturan SMS';

  @override
  String get addSmsSubscription => 'Tambah Langganan SMS';

  @override
  String get addSubscription => 'Tambah Langganan';

  @override
  String get addSubscriptionButton => 'Tambah Langganan';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Gagal menambah langganan: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Tambah Langganan';

  @override
  String get addToBlacklist => 'Tambah ke Senarai Hitam';

  @override
  String get addToFavorites => 'Tambah ke Kegemaran';

  @override
  String get addToRules => 'Tambah ke Peraturan';

  @override
  String get addToWhitelist => 'Tambah ke Senarai Putih';

  @override
  String get agent => 'Ejen';

  @override
  String get all => 'Semua';

  @override
  String get allCallsTab => 'Semua';

  @override
  String get allow => 'Benarkan';

  @override
  String get allowAllAllowRules => 'Benarkan Semua Peraturan Benarkan';

  @override
  String get allowAllAllowRulesDesc =>
      'Benarkan panggilan daripada peraturan benarkan';

  @override
  String get allowAllBlacklistedNumbers =>
      'Benarkan Semua Nombor Senarai Hitam';

  @override
  String get allowAllBlockRules => 'Benarkan Semua Peraturan Sekat';

  @override
  String get allowAllBlockRulesDesc =>
      'Benarkan panggilan daripada peraturan sekat';

  @override
  String get allowAllowedNumbers => 'Benarkan Nombor Dibenarkan';

  @override
  String get allowAllowedNumbersDesc =>
      'Benarkan panggilan daripada senarai benarkan';

  @override
  String get allowBlock => 'Benarkan/Sekat';

  @override
  String get allowBlockedNumbers => 'Benarkan Nombor Disekat';

  @override
  String get allowBlockedNumbersDesc =>
      'Benarkan panggilan daripada senarai sekat';

  @override
  String get allowedBlockedRule => 'Peraturan Benarkan/Sekat';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Edit Peraturan Benarkan/Sekat';

  @override
  String get allowedBlockedRuleManagement =>
      'Pengurusan Peraturan Benarkan/Sekat';

  @override
  String get allowNonExceededNumbers => 'Benarkan Nombor Tidak Melebihi';

  @override
  String get allowNonExceededNumbersDescription =>
      'Secara automatik membenarkan nombor yang tidak melebihi ambang kiraan';

  @override
  String get allowRegexAllowRules => 'Benarkan Peraturan Benarkan Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'Dayakan padanan corak regex untuk peraturan benarkan';

  @override
  String get allowRegexAllowRulesDescription =>
      'Dayakan peraturan benarkan berasaskan regex';

  @override
  String get allowRegexBlockRules => 'Benarkan Peraturan Sekat Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'Dayakan padanan corak regex untuk peraturan sekat';

  @override
  String get allowRegexBlockRulesDescription =>
      'Dayakan peraturan sekat berasaskan regex';

  @override
  String get allowRule => 'Peraturan Benarkan';

  @override
  String get allowRules => 'Peraturan Benarkan';

  @override
  String get allPermissionsGranted => 'Semua kebenaran diberikan';

  @override
  String get allSettingsCompleted => 'Semua tetapan selesai.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Semua kemas kini selesai ($count peraturan)';
  }

  @override
  String get answerThenHangup => 'Jawab kemudian letak telefon';

  @override
  String get applicationSoftware => 'Perisian Aplikasi';

  @override
  String get apply => 'Guna';

  @override
  String get appName => 'Your Call Your Rule';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Kebenaran gagal: Sila semak ID dan kunci klien';

  @override
  String get authorizationFailedMessage => 'Kebenaran gagal';

  @override
  String get authorizationSuccessMessage => 'Kebenaran berjaya';

  @override
  String get authorizeLoginButton => 'Benarkan Log Masuk';

  @override
  String get automotiveIndustry => 'Industri Automotif';

  @override
  String get autoSyncLabel => 'Auto Selar';

  @override
  String get autoUpdate => 'Kemas Kini Automatik';

  @override
  String get autoUpdateDescription =>
      'Tetapkan selang kemas kini automatik untuk langganan atau kemas kini secara manual';

  @override
  String get autoUpdateSettings => 'Tetapan Kemas Kini Automatik';

  @override
  String get autoUpdateSubtitle =>
      'Urus kemas kini automatik untuk peraturan dan plugin';

  @override
  String get autoUpdateTitle => 'Kemas Kini Automatik';

  @override
  String get avatarBorderColor => 'Warna Sempadan Avatar';

  @override
  String get avatarBorderSize => 'Saiz Sempadan Avatar';

  @override
  String get avatarIconSizesSetting => 'Saiz Avatar & Ikon';

  @override
  String get avatarPosition => 'Kedudukan Avatar';

  @override
  String get avatarSize => 'Saiz Avatar';

  @override
  String axisPosition(Object axis) {
    return 'Kedudukan $axis';
  }

  @override
  String get backgroundGradientSetting => 'Gradien Latar Belakang';

  @override
  String get backup => 'Sandaran';

  @override
  String get backupAndRestore => 'Sandaran dan Pulihkan';

  @override
  String get backupAndRestoreSubtitle => 'Sandar atau pulihkan data aplikasi';

  @override
  String get backupAndRestoreTitle => 'Sandaran & Pulihkan';

  @override
  String get backupFailed => 'Sandaran gagal';

  @override
  String get backupSettings => 'Tetapan Sandaran';

  @override
  String get backupToCloud => 'Sandar ke Awan';

  @override
  String backupToCloudFailed(Object error) {
    return 'Gagal membuat sandaran ke awan: $error';
  }

  @override
  String get backupToCloudSuccess => 'Berjaya membuat sandaran ke awan';

  @override
  String get bank => 'Bank';

  @override
  String get basicInfo => 'Maklumat Asas';

  @override
  String get basicRuleFilter => 'Penapis Peraturan Asas';

  @override
  String get basicRuleFiltering => 'Penapisan Peraturan Asas';

  @override
  String get basicRuleFilteringExplanation =>
      '• Penapisan Peraturan Asas: Menapis peraturan berdasarkan senarai hitam, senarai putih, dan regex';

  @override
  String get basicRuleFilterSubtitle =>
      'Tapis panggilan menggunakan senarai hitam/putih dan ungkapan biasa';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Adakah anda pasti mahu memadam $count kenalan yang dipilih?';
  }

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Adakah anda pasti mahu memadam $count label?';
  }

  @override
  String get blacklist => 'Senarai Hitam';

  @override
  String get blacklistingAndWhitelisting => 'Senarai Hitam dan Senarai Putih';

  @override
  String get blackWhiteList => 'Senarai Hitam/Putih';

  @override
  String get block => 'Sekat';

  @override
  String get blockCalls => 'Sekat Panggilan';

  @override
  String get blocked => 'Disekat';

  @override
  String get blockedCalls => 'Panggilan Disekat';

  @override
  String get blockedCallsTitle => 'Panggilan Disekat';

  @override
  String get blockedSpamCalls => 'Panggilan Spam Disekat';

  @override
  String get blockingTrend => 'Trend Penyekatan';

  @override
  String get blockInternationalCalls =>
      'padankan nombor yang tidak bermula dengan + atau 00';

  @override
  String get blockInternationalCallsTitle => 'Sekat Panggilan Antarabangsa';

  @override
  String get blockMobileNumbers =>
      'padankan nombor yang tidak bermula dengan 13-19';

  @override
  String get blockMobileNumbersTitle => 'Sekat Nombor Mudah Alih';

  @override
  String get blockPremiumRateNumbers =>
      'padankan nombor yang tidak bermula dengan 118 atau 120-190';

  @override
  String get blockPremiumRateNumbersTitle => 'Sekat Nombor Kadar Premium';

  @override
  String get blockRule => 'Peraturan Sekat';

  @override
  String get blockRules => 'Peraturan Sekat';

  @override
  String get blockSpecificAreaCodes =>
      'padankan nombor yang bermula dengan 0 + 2-3 digit';

  @override
  String get blockSpecificAreaCodesTitle => 'Sekat kod kawasan tertentu:';

  @override
  String get blockTypeAnalysisTitle => 'Analisis Jenis Sekat';

  @override
  String get both => 'Kedua-duanya';

  @override
  String get bulkDelete => 'Padam Kelompok Kenalan';

  @override
  String get bulkDeleteContacts => 'Padam Kelompok Kenalan';

  @override
  String get bulkDeleteLabels => 'Padam Kelompok Label';

  @override
  String get call => 'Panggil';

  @override
  String get callback => 'Panggil Balik';

  @override
  String get callBlocking => 'Penyekatan Panggilan';

  @override
  String get callerIdApp => 'Aplikasi ID Pemanggil';

  @override
  String get callerIdCustomizationTitle => 'Sesuaikan ID Pemanggil';

  @override
  String get callerIdDisplayMode => 'Mod Paparan ID Pemanggil';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Ditanda oleh $count';
  }

  @override
  String get callerIdPreview => 'Pratonton ID Pemanggil';

  @override
  String get callFilterRules => 'Peraturan Penapis Panggilan';

  @override
  String get callFilterRulesDescription =>
      'Tetapkan peraturan asas untuk penapisan panggilan';

  @override
  String get callFilterSettings => 'Tetapan Penapis Panggilan';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Tetapkan had kekerapan panggilan dan peraturan penyekatan';

  @override
  String get callFrequencyInterceptionTitle => 'Pintas Kekerapan Panggilan';

  @override
  String get callHistory => 'Sejarah Panggilan';

  @override
  String get callHistoryInfoDesc =>
      'Di sini menunjukkan sejarah panggilan anda, termasuk panggilan masuk, keluar dan terlepas.';

  @override
  String get callHistoryInfoTitle => 'Sejarah Panggilan';

  @override
  String get callHistoryTab => 'Sejarah Panggilan';

  @override
  String get callScreeningPermission => 'Kebenaran Saringan Panggilan';

  @override
  String get callScreeningPermissionDescription =>
      'Digunakan untuk menyaring dan menyekat panggilan spam.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Kebenaran saringan panggilan tidak diberikan, mungkin menjejaskan fungsi aplikasi.';

  @override
  String get callStatistics => 'Statistik Panggilan';

  @override
  String get callTypeAnswered => 'Dijawab';

  @override
  String get callTypeBlocked => 'Disekat';

  @override
  String get callTypeIconColor => 'Warna Ikon Jenis Panggilan';

  @override
  String get callTypeMissed => 'Panggilan Terlepas';

  @override
  String get callTypeOutgoing => 'Keluar';

  @override
  String get callTypePosition => 'Kedudukan Jenis Panggilan';

  @override
  String get callTypeUnknown => 'Tidak Diketahui';

  @override
  String get cancelButton => 'Batal';

  @override
  String get carRental => 'Sewa Kereta';

  @override
  String get carrier => 'Pembawa';

  @override
  String get carrierColor => 'Warna Pembawa';

  @override
  String get carrierFontSize => 'Saiz Fon Pembawa';

  @override
  String get carrierPosition => 'Kedudukan Pembawa';

  @override
  String get changeLabel => 'Tukar Label';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Gagal menukar status plugin: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Gagal menukar status langganan: $error';
  }

  @override
  String get charity => 'Kebajikan';

  @override
  String get chartOneWeekAgo => '1 minggu yang lalu';

  @override
  String get chartThreeDaysAgo => '3 hari yang lalu';

  @override
  String get chartToday => 'Hari Ini';

  @override
  String get checkFileFormat => 'Sila periksa format fail atau kebenaran';

  @override
  String checkPermissionFailed(Object error) {
    return 'Gagal memeriksa kebenaran: $error';
  }

  @override
  String get chooseDefaultInterceptAction => 'Pilih tindakan pintas lalai';

  @override
  String get clearFilter => 'Kosongkan Penapis';

  @override
  String get clearLabelFilterButton => 'Kosongkan Penapis Label';

  @override
  String get closeButton => 'Tutup';

  @override
  String get cloudSync => 'Penyegerakan Awan';

  @override
  String get cloudSyncAndBackupTitle => 'Penyegerakan & Sandaran Awan';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Konfigurasi WebDAV, OneDrive dan Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Tetapan Penyegerakan Awan';

  @override
  String get cloudSyncTitle => 'Penyegerakan Awan';

  @override
  String get collection => 'Pengumpulan Hutang';

  @override
  String get colorPickerTitle => 'Pilih Warna';

  @override
  String get configManagement => 'Pengurusan Konfigurasi';

  @override
  String get configUpdated => 'Konfigurasi dikemas kini';

  @override
  String get configurationAdvice =>
      'Melalui konfigurasi yang betul, anda boleh menetapkan strategi penapisan yang berbeza untuk kad SIM kerja dan peribadi.';

  @override
  String get configureBackupOptions => 'Konfigurasi Pilihan Sandaran';

  @override
  String get configureCloudSyncService =>
      'Konfigurasi Perkhidmatan Penyegerakan Awan';

  @override
  String get configureCloudSyncServiceMessage =>
      'Sila konfigurasikan perkhidmatan penyegerakan awan untuk membolehkan penyegerakan berbilang peranti.';

  @override
  String get configureSimCardFilterRules =>
      'Konfigurasi Peraturan Penapis Kad SIM';

  @override
  String get confirm => 'Sahkan';

  @override
  String get confirmButton => 'Sahkan';

  @override
  String get confirmDelete => 'Sahkan Padam';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Adakah anda pasti mahu memadam label \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Adakah anda pasti mahu memadam plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Adakah anda pasti mahu memadam $count plugin?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Adakah anda pasti mahu memadam peraturan ini? Tindakan ini tidak boleh dibatalkan.';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Adakah anda pasti mahu memadam peraturan penapis SMS ini?';

  @override
  String get confirmDeleteSmsRule =>
      'Adakah anda pasti mahu memadam peraturan SMS ini?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Adakah anda pasti mahu memadam $name?';
  }

  @override
  String get confirmPassword => 'Sahkan Kata Laluan';

  @override
  String get connectedStatus => 'Bersambung';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Sambungan gagal: Sila semak alamat pelayan, nama pengguna, dan kata laluan';

  @override
  String get connectionFailedMessage => 'Sambungan gagal';

  @override
  String get connectionStatusLabel => 'Status Sambungan';

  @override
  String get connectionSuccessMessage => 'Sambungan berjaya';

  @override
  String get contactAddSuccess => 'Kenalan berjaya ditambah';

  @override
  String get contactDeleted => 'Kenalan dipadam';

  @override
  String get contactNameLabel => 'Nama';

  @override
  String get contactNotFound => 'Kenalan tidak dijumpai';

  @override
  String get contacts => 'kenalan';

  @override
  String contactsDeleted(Object count) {
    return 'Memadam $count kenalan';
  }

  @override
  String get contactsManagement => 'Pengurusan Kenalan';

  @override
  String get contactsPermission => 'Kebenaran Kenalan';

  @override
  String get contactsPermissionDescription =>
      'Digunakan untuk mengenal pasti panggilan kenalan.';

  @override
  String get contactsTab => 'Kenalan';

  @override
  String get contactSubscriptionDescription =>
      'Langgan senarai kenalan melalui URL, kemas kini maklumat kenalan dan label secara automatik. Menyokong data format JSON.';

  @override
  String get contactUpdateSuccess => 'Kenalan berjaya dikemas kini';

  @override
  String get contactUs => 'Hubungi Kami';

  @override
  String get content => 'Kandungan';

  @override
  String get contentRegex => 'Regex Kandungan';

  @override
  String get countColor => 'Warna Kiraan';

  @override
  String get countFontSize => 'Saiz Fon Kiraan';

  @override
  String get countPosition => 'Kedudukan Kiraan';

  @override
  String get country => 'Negara';

  @override
  String get countryNameColor => 'Warna Nama Negara';

  @override
  String get countryNameFontSize => 'Saiz Fon Nama Negara';

  @override
  String get countryRegionNamePosition => 'Kedudukan Nama Negara/Wilayah';

  @override
  String get countThresholdDescription =>
      'Tetapkan ambang kiraan minimum yang diperlukan untuk mencetuskan tindakan penapisan';

  @override
  String get countThresholdLabel => 'Ambang Kiraan';

  @override
  String get createdRules => 'Peraturan Dicipta';

  @override
  String get csvFormat => 'Format CSV';

  @override
  String get currentDeviceLabel => 'Label Peranti Semasa';

  @override
  String get currentDeviceTitle => 'Peranti Semasa';

  @override
  String get currentLanguage => 'Bahasa Semasa';

  @override
  String get customerService => 'Khidmat Pelanggan';

  @override
  String get dashboardTab => 'Papan Pemuka';

  @override
  String get dataAnalysis => 'Analisis Data';

  @override
  String dataLoadFailure(Object error) {
    return 'Kegagalan memuatkan data: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Gagal memuatkan data: $error';
  }

  @override
  String get dataMigration => 'Migrasi Data';

  @override
  String get dataMigrationDescription =>
      'Ciri ini membolehkan anda memindahkan semua data anda antara peranti. Pada masa ini, anda boleh menggunakan ciri sandaran dan pemulihan untuk memindahkan data anda secara manual.';

  @override
  String get dataSourceReminder => 'Peringatan Sumber Data';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
      one: '1 hari',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return 'VIP $days Hari';
  }

  @override
  String get debtCollection => 'Kutipan Hutang';

  @override
  String get delete => 'Padam';

  @override
  String get deleteButton => 'Padam';

  @override
  String get deleteContact => 'Padam Kenalan';

  @override
  String deleteContactConfirm(Object name) {
    return 'Adakah anda pasti mahu memadam $name?';
  }

  @override
  String deleteFailed(Object error) {
    return 'Padam gagal: $error';
  }

  @override
  String get deleteLabel => 'Padam Label';

  @override
  String deleteLabelFailed(Object error) {
    return 'Gagal memadam label: $error';
  }

  @override
  String get deletePlugin => 'Padam Plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Gagal memadam plugin: $error';
  }

  @override
  String get deletePlugins => 'Padam Plugin';

  @override
  String deletePluginsFailed(Object error) {
    return 'Gagal memadam plugin: $error';
  }

  @override
  String get deleteRule => 'Padam Peraturan';

  @override
  String deleteRuleFailed(Object error) {
    return 'Padam gagal: $error';
  }

  @override
  String get deleteSelected => 'Padam Terpilih';

  @override
  String get deleteSubscription => 'Padam Langganan';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Adakah anda pasti mahu memadam langganan \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Gagal memadam langganan: $error';
  }

  @override
  String get deleteSuccess => 'Padam berjaya';

  @override
  String get delivery => 'Penghantaran';

  @override
  String get deviceIDLabel => 'ID Peranti';

  @override
  String get deviceManagementSubtitle => 'Urus penyegerakan berbilang peranti';

  @override
  String get deviceManagementTitle => 'Pengurusan Peranti';

  @override
  String get deviceModelLabel => 'Model Peranti';

  @override
  String get deviceName => 'Nama Peranti';

  @override
  String get deviceNameLabel => 'Nama Peranti';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Peranti dinamakan semula berjaya';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Peranti disegerakkan berjaya';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Peranti tidak berdaftar berjaya';

  @override
  String get dialogTitle => 'Penjelasan Corak Regex';

  @override
  String get differentFromLocalCounter =>
      'Ciri ini berbeza daripada penapis pembilang tempatan, kerana ia memberi tumpuan kepada corak panggilan berulang dalam masa yang singkat dan bukannya mengira penanda jangka panjang.';

  @override
  String get disabled => 'Dilumpuhkan';

  @override
  String get disabledStatus => 'Dilumpuhkan';

  @override
  String get disableGlobalPlugins => 'Lumpuhkan plugin global';

  @override
  String get disconnectButton => 'Putuskan sambungan';

  @override
  String get disconnectedMessage => 'Tersambung';

  @override
  String get disconnectedStatus => 'Tersambung';

  @override
  String get disconnectFailedMessage => 'Gagal memutuskan sambungan';

  @override
  String get done => 'Selesai';

  @override
  String get dualSimAdvice =>
      'Ciri ini amat berguna untuk telefon SIM dwi untuk menetapkan strategi penapisan yang berbeza untuk kad SIM kerja dan peribadi.';

  @override
  String get earlier => 'Terdahulu';

  @override
  String get ecommerce => 'E-dagang';

  @override
  String get edit => 'Edit';

  @override
  String get editContact => 'Edit Kenalan';

  @override
  String get editLabel => 'Edit Label';

  @override
  String get editPhoneRule => 'Edit Peraturan Telefon';

  @override
  String get editRule => 'Edit Peraturan';

  @override
  String get education => 'Pendidikan';

  @override
  String get elementPositionsSetting => 'Kedudukan Elemen';

  @override
  String get email => 'E-mel';

  @override
  String get enableCallFilter => 'Dayakan Penapis Panggilan';

  @override
  String get enableCallFilterDescription =>
      'Apabila didayakan, panggilan masuk akan disemak terhadap senarai peraturan di bawah. Peraturan penapisan panggilan tidak disegerakkan antara peranti secara lalai.';

  @override
  String get enabled => 'Didayakan';

  @override
  String get enabledStatus => 'Didayakan';

  @override
  String get enableEncryption => 'Dayakan Penyulitan';

  @override
  String get enableEncryptionDescription => 'Sulitkan fail sandaran';

  @override
  String get enableGlobalPlugins => 'Dayakan plugin global';

  @override
  String get enableLocalCountFilter => 'Dayakan Penapis Kiraan Tempatan';

  @override
  String get enableLocalCountFilterDescription =>
      'Tapis panggilan spam secara automatik berdasarkan kiraan penanda panggilan';

  @override
  String get enableLocalNotification => 'Gunakan Pemberitahuan Tempatan';

  @override
  String get enableLocalNotificationDescription =>
      'Apabila didayakan, pemberitahuan untuk mesej yang ditapis akan dipaparkan pada peranti';

  @override
  String get enableLocationSummary => 'Lokasi';

  @override
  String get enableMuteRules => 'Dayakan Peraturan Bisukan';

  @override
  String get enableMuteRulesDesc =>
      'Gunakan konfigurasi peraturan pintasan bisu';

  @override
  String get enableNoneActionRules => 'Dayakan Peraturan Tiada Tindakan';

  @override
  String get enableNoneActionRulesDesc =>
      'Benarkan konfigurasi peraturan tanpa tindakan pintasan';

  @override
  String get enableRemoteNumberFilter => 'Dayakan Penapis Nombor Jauh';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Gunakan pangkalan data jauh untuk menapis nombor';

  @override
  String get enableRule => 'Dayakan Peraturan';

  @override
  String get enableSmsFilter => 'Dayakan Penapisan SMS';

  @override
  String get enableSmsFilterDescription =>
      'Apabila didayakan, mesej akan ditapis secara automatik mengikut peraturan';

  @override
  String get enableTimeInterception => 'Dayakan Pintasan Masa';

  @override
  String get enableTimeInterceptionDescription =>
      'Pintas panggilan berulang dalam masa yang singkat';

  @override
  String get enableTimeInterceptor => 'Dayakan Pengintip Masa';

  @override
  String get endCallImmediately => 'Tamatkan panggilan serta-merta';

  @override
  String get endColor => 'Warna Tamat';

  @override
  String get endDate => 'Tarikh Tamat';

  @override
  String get enhancedFilterInstructionsTitle => 'Sistem Penapis Dipertingkat';

  @override
  String get enhancedFilterSettings => 'Tetapan Penapis Dipertingkat';

  @override
  String get enhancedFilterSettingsTitle => 'Tetapan Penapis Dipertingkat';

  @override
  String get enhancedFilterSystemDescription =>
      'Sistem penapis yang dipertingkat menyokong kedua-dua peraturan global dan konfigurasi penapisan per-kad SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Sila masukkan kedua-dua nombor telefon dan corak regex.';

  @override
  String get enterContactName => 'Sila masukkan nama kenalan';

  @override
  String get enterDeviceName => 'Masukkan Nama Peranti';

  @override
  String get enterEmailOptional => 'Masukkan e-mel (pilihan)';

  @override
  String get enterEncryptionPasswordHint => 'Masukkan kata laluan penyulitan';

  @override
  String get enterIconCode => 'Masukkan kod ikon';

  @override
  String get enterName => 'Masukkan nama kenalan';

  @override
  String get enterNewDeviceNameHint => 'Masukkan nama baharu untuk peranti ini';

  @override
  String get enterPasswordAgain => 'Masukkan Semula Kata Laluan';

  @override
  String get enterPhoneNumber => 'Masukkan nombor telefon';

  @override
  String get enterPhoneNumberHint => 'Masukkan nombor telefon untuk diuji';

  @override
  String get enterPhoneNumberMultiple =>
      'Sila masukkan nombor telefon, beberapa nombor dipisahkan dengan koma';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Masukkan nombor telefon untuk memulakan carian';

  @override
  String get enterPhoneNumberToVerify =>
      'Masukkan nombor telefon untuk mengesahkan';

  @override
  String get enterPluginName => 'Masukkan Nama Pemalam';

  @override
  String get enterPluginUrl => 'Masukkan alamat URL pemalam';

  @override
  String get enterRegexHint => 'Masukkan corak regex';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Sila masukkan nama peraturan dan corak regex.';

  @override
  String get enterRuleNameHint => 'Masukkan nama peraturan';

  @override
  String get enterSearchContent => 'Sila masukkan kandungan carian';

  @override
  String get enterSubscriptionName => 'Masukkan nama langganan';

  @override
  String get enterSubscriptionUrl => 'Masukkan URL langganan';

  @override
  String get enterSyncFolderNameHint =>
      'Sila masukkan nama folder penyegerakan (lalai: NotificationManager)';

  @override
  String get entertainment => 'Hiburan';

  @override
  String get enterValidNameAndUrl => 'Sila masukkan nama dan URL yang sah';

  @override
  String get enterValidUrl => 'Sila masukkan URL yang sah';

  @override
  String get enterVersion => 'Masukkan Versi';

  @override
  String get enterWebDAVPasswordHint => 'Sila masukkan kata laluan WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Sila masukkan alamat pelayan WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'Sila masukkan nama pengguna WebDAV';

  @override
  String errorOccurredMessage(Object error) {
    return 'Ralat berlaku: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Ralat menukar nama peranti: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Ralat menyegerakkan peranti: $error';
  }

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Ralat membatalkan pendaftaran peranti: $error';
  }

  @override
  String get exampleBlock400Prefix => 'cth. Sekat nombor awalan 400';

  @override
  String get exampleBlockMarketingSms => 'cth. Sekat SMS pemasaran';

  @override
  String get exampleContentRegexHint => 'Contoh Regex Kandungan';

  @override
  String get exampleCouponPromotionDiscount =>
      'cth. .*(kupon|promosi|diskaun).*';

  @override
  String get exampleFamilyFriends => 'cth. Keluarga, Rakan, dll.';

  @override
  String get examplePhoneNumber => 'cth. 10086, 12345, dll.';

  @override
  String get exampleRegex400Prefix => 'Contoh regex untuk awalan 400';

  @override
  String get exampleSenderRegexHint => 'Contoh';

  @override
  String get exchange => 'Pertukaran';

  @override
  String get exchangeNow => 'Tukar Sekarang';

  @override
  String get exchangeVip => 'Tukar VIP';

  @override
  String expiryTime(Object time) {
    return 'Masa tamat tempoh: $time';
  }

  @override
  String get export => 'Eksport';

  @override
  String get exportAllApplicationSettings => 'Eksport semua tetapan aplikasi';

  @override
  String get exportAllRuleConfigurations =>
      'Eksport Semua Konfigurasi Peraturan';

  @override
  String get exportConfig => 'Konfigurasi Eksport';

  @override
  String get exportContacts => 'Eksport Kenalan';

  @override
  String get exportData => 'Eksport Data';

  @override
  String get exportFailed => 'Eksport gagal';

  @override
  String get exportFailure => 'Gagal mengeksport konfigurasi';

  @override
  String get exportFeatureComingSoon => 'Ciri eksport akan datang';

  @override
  String get exportLabels => 'Eksport Label';

  @override
  String exportLabelsFailed(Object error) {
    return 'Gagal mengeksport label: $error';
  }

  @override
  String get exportPluginList => 'Eksport Senarai Plugin';

  @override
  String exportPluginListFailed(Object error) {
    return 'Gagal mengeksport senarai plugin: $error';
  }

  @override
  String get exportRules => 'Eksport Peraturan';

  @override
  String get exportSmsRules => 'Eksport Peraturan SMS';

  @override
  String get exportStatisticsData => 'Eksport Data Statistik';

  @override
  String get exportSuccesslly => 'Konfigurasi dieksport dengan jayanya';

  @override
  String failedToAddRule(Object error) {
    return 'Gagal menambah peraturan: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Gagal menambah langganan SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Gagal membuat sandaran tetapan: $error';
  }

  @override
  String get failedToDecryptBackupFile => 'Gagal menyahsulit fail sandaran';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Gagal memadam peraturan SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Gagal mengeksport peraturan: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Gagal mendapatkan maklumat ID pemanggil: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Gagal mengimport peraturan: $error';
  }

  @override
  String get failedToRestoreSettings => 'Gagal memulihkan tetapan';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Gagal memulihkan tetapan: $error';
  }

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Gagal menogol status peraturan: $error';
  }

  @override
  String get favoriteContacts => 'Kenalan Kegemaran';

  @override
  String get featureAddRules => '• Tambah peraturan khusus nombor telefon';

  @override
  String get featureCenter => 'Pusat Ciri';

  @override
  String get featureEnableDisable =>
      '• Dayakan/lumpuhkan penapis yang berbeza setiap SIM';

  @override
  String get featureListTitle => 'Ciri:';

  @override
  String get featureManageRules => '• Urus senarai peraturan setiap SIM';

  @override
  String get features => 'Ciri-ciri';

  @override
  String get fetchingCallerIdInfo => 'Mendapatkan maklumat ID pemanggil...';

  @override
  String fileSavedTo(Object path) {
    return 'Fail disimpan ke: $path';
  }

  @override
  String get filter => 'Penapis';

  @override
  String get filterByLabel => 'Tapis mengikut Label';

  @override
  String get filterControlPanelTitle => 'Panel Kawalan Penapis';

  @override
  String get filterControlSubtitle => 'Urus status hidup/mati semua penapis';

  @override
  String get filterControlTitle => 'Kawalan Penapis';

  @override
  String get filtered => 'Ditapis';

  @override
  String get filterExplanation => 'Penjelasan Penapis';

  @override
  String get filterManagement => 'Pengurusan Penapis';

  @override
  String get filterName => 'Nama Penapis';

  @override
  String get filterPriorityNote =>
      'Nota: Terdapat hubungan keutamaan antara penapis, sila rujuk dokumentasi bantuan untuk butiran';

  @override
  String get filterSettings => 'Tetapan Penapis';

  @override
  String get filterSettingsTitle => 'Tetapan Penapis';

  @override
  String get filterSMS => 'SMS Penapis';

  @override
  String get filterToggleInstructions =>
      'Dayakan atau lumpuhkan penapis untuk slot SIM ini:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Penapis $status: $filterName';
  }

  @override
  String get filterType => 'Jenis Penapis';

  @override
  String get financial => 'Kewangan';

  @override
  String get flexibleCombinationFeature =>
      '• Gabungan Fleksibel: Dayakan/lumpuhkan penapis setiap slot SIM';

  @override
  String get fontSizesSetting => 'Saiz Fon';

  @override
  String foundRules(Object count) {
    return 'Menemui $count peraturan';
  }

  @override
  String get fraudAlert => 'AMARAN PENIPUAN - Tutup panggilan';

  @override
  String get fraudScamLikely => 'Penipuan Mungkin';

  @override
  String get free => 'Percuma';

  @override
  String get functionSettingsTitle => 'Tetapan Fungsi';

  @override
  String generalUpdateFailure(Object error) {
    return 'Kemas kini gagal: $error';
  }

  @override
  String get getFree => 'Dapatkan Percuma';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Konfigurasikan penapis global untuk semua kad SIM:';

  @override
  String get globalFilterFeature =>
      '• Penapis Global: Peraturan asas untuk semua panggilan masuk';

  @override
  String get globalFilterSettings => 'Tetapan Penapis Global';

  @override
  String get globalSettings => 'Tetapan Global';

  @override
  String get googleDriveAuthDescription =>
      'Berikan kebenaran menggunakan ID dan kunci pelanggan Google Drive yang dikonfigurasi sistem';

  @override
  String get googleDriveConfigTitle => 'Konfigurasi Google Drive';

  @override
  String get government => 'Kerajaan';

  @override
  String get granted => 'Diberikan';

  @override
  String get grantNecessaryPermissions => 'Berikan Kebenaran yang Diperlukan';

  @override
  String get grantPermissions => 'Berikan Kebenaran';

  @override
  String get headhunter => 'Pemburu Kepala';

  @override
  String get height => 'Ketinggian';

  @override
  String get homeTab => 'Laman Utama';

  @override
  String get howItWorksPoint1 =>
      '• Sistem akan membenarkan panggilan secara automatik daripada nombor yang sama dalam tetingkap masa yang ditetapkan';

  @override
  String get howItWorksPoint2 =>
      '• Tetingkap masa yang lebih pendek mengakibatkan pemintasan yang lebih ketat; tetingkap masa yang lebih lama mengakibatkan pemintasan yang lebih longgar';

  @override
  String get howItWorksPoint3 =>
      '• Sistem menyemak log panggilan untuk menentukan sama ada ia adalah panggilan berulang';

  @override
  String get howItWorksTitle => 'Cara Ia Berfungsi:';

  @override
  String get iconCodeOptional => 'Kod Ikon (Pilihan)';

  @override
  String get iconSize => 'Saiz Ikon';

  @override
  String get import => 'Import';

  @override
  String get important => 'Penting';

  @override
  String get importConfig => 'Import Konfigurasi';

  @override
  String get importContacts => 'Import Kenalan';

  @override
  String get importExportContacts => 'Import/Eksport Kenalan';

  @override
  String get importExportContactsTooltip => 'Import/Eksport Kenalan';

  @override
  String get importExportRules => 'Import/Eksport Peraturan';

  @override
  String importFailed(Object error) {
    return 'Import gagal: $error';
  }

  @override
  String get importFailure => 'Gagal mengimport konfigurasi';

  @override
  String get importFeatureComingSoon => 'Ciri import akan datang';

  @override
  String get importLabels => 'Import Label';

  @override
  String importLabelsFailed(Object error) {
    return 'Gagal mengimport label: $error';
  }

  @override
  String get importPluginList => 'Import Senarai Plugin';

  @override
  String importPluginListFailed(Object error) {
    return 'Gagal mengimport senarai plugin: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Berjaya mengimport $count plugin';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Import Konfigurasi Peraturan daripada Fail';

  @override
  String get importRules => 'Import Peraturan';

  @override
  String get importSuccess => 'Import berjaya';

  @override
  String get incomingCallInterceptAction => 'Tindakan Pintasan Panggilan Masuk';

  @override
  String get incorrectPassword => 'Kata laluan salah';

  @override
  String get initializing => 'Memulakan';

  @override
  String get installed => 'Dipasang';

  @override
  String get insufficientMarks => 'Markah Tidak Mencukupi';

  @override
  String get insurance => 'Insurans';

  @override
  String get interceptAction => 'Tindakan Pintasan';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Tetapkan cara panggilan yang disekat dikendalikan';

  @override
  String get interceptionActionSettingsTitle => 'Tetapan Tindakan Pintasan';

  @override
  String get interceptionTimeInterval => 'Selang Masa Pemintasan';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Selang kemas kini $service ditetapkan kepada $days hari';
  }

  @override
  String get invalidContentRegex => 'Regex kandungan tidak sah';

  @override
  String get invalidLabel => 'Label tidak sah';

  @override
  String get invalidRegexPattern => 'Corak regex tidak sah';

  @override
  String get invalidSenderRegex => 'Regex pengirim tidak sah';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Sertai Saluran dan Kumpulan Telegram untuk Maklumat Lanjut';

  @override
  String get jsonFormat => 'Format JSON';

  @override
  String get keepAllVersions => 'Simpan Semua Versi';

  @override
  String get keepAllVersionsDescription =>
      'Simpan semua versi sejarah setiap sandaran';

  @override
  String get label => 'Label';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Label \"$name\" berjaya ditambah';
  }

  @override
  String get labelCategories => 'Kategori Label';

  @override
  String get labelDeleted => 'Label dipadam';

  @override
  String get labelDescription =>
      'Label membantu anda mengurus kenalan dengan lebih baik, tambahkan label tersuai pada nombor telefon untuk pengenalan panggilan dan mesej yang mudah.';

  @override
  String get labelFilterTooltip => 'Penapis Label';

  @override
  String get labelIconColor => 'Warna Ikon Label';

  @override
  String get labelManagement => 'Pengurusan Label';

  @override
  String get labelNotFound => 'Label tidak ditemui';

  @override
  String get labels => 'Label';

  @override
  String get labelsColor => 'Warna Label';

  @override
  String labelsDeleted(Object count) {
    return '$count label dipadam';
  }

  @override
  String get labelsExportedSuccessfully => 'Label dieksport dengan jayanya';

  @override
  String get labelsFontSize => 'Saiz Font Label';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Berjaya mengimport $count label';
  }

  @override
  String get labelsPosition => 'Kedudukan Label';

  @override
  String labelTag(Object labelId) {
    return 'Label: $labelId';
  }

  @override
  String labelUpdateFailed(Object error) {
    return 'Gagal mengemas kini label: $error';
  }

  @override
  String get labelUpdateSuccess => 'Label \"\$labelText\" berjaya dikemas kini';

  @override
  String get languageSettings => 'Tetapan Bahasa';

  @override
  String get languageSettingsSubtitle => 'Tukar bahasa paparan aplikasi';

  @override
  String get languageSettingsTitle => 'Tetapan Bahasa';

  @override
  String get lastSyncLabel => 'Penyegerakan Terakhir';

  @override
  String lastUpdated(Object date) {
    return 'Dikemas kini terakhir: $date';
  }

  @override
  String get lifetimeMembership => 'Keahlian Seumur Hidup';

  @override
  String get lifetimeMembershipDescription =>
      'Pembelian sekali, buka kunci semua ciri premium dan kemas kini masa depan secara kekal';

  @override
  String loadContactsFailed(Object error) {
    return 'Gagal memuatkan kenalan: $error';
  }

  @override
  String get loadDataFailed => 'Gagal memuatkan data';

  @override
  String get loading => 'Memuatkan...';

  @override
  String get loadingTags => 'Memuatkan tag...';

  @override
  String loadLabelFailed(Object error) {
    return 'Gagal memuatkan label: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Gagal memuat label: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Gagal memuat nombor telefon yang ditandai: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Gagal memuat nombor telefon yang ditandai: $error';
  }

  @override
  String loadPluginsFailed(Object error) {
    return 'Gagal memuatkan plugin: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Gagal memuatkan tetapan: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Gagal memuatkan peraturan SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Gagal memuat status';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Gagal memuatkan langganan: $error';
  }

  @override
  String get loan => 'Pinjaman';

  @override
  String get localCounterFilter => 'Penapis Kaunter Tempatan';

  @override
  String get localCounterFilterSubtitle =>
      'Secara automatik menapis panggilan spam berdasarkan kekerapan panggilan';

  @override
  String get localCountFilter => 'Penapis Kiraan Tempatan';

  @override
  String get localCountFilterDescription =>
      'Menahan panggilan kerap berdasarkan kiraan nombor tempatan';

  @override
  String get localCountFilterExplanationContent =>
      'Penapis kiraan tempatan menganalisis rekod sejarah panggilan untuk mengenal pasti dan menyekat panggilan spam yang kerap secara automatik.';

  @override
  String get localCountFilterExplanationTitle =>
      'Penjelasan Penapis Kiraan Tempatan';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Tentukan sama ada untuk menyekat berdasarkan nilai kiraan nombor';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Apabila kiraan nombor melebihi ambang yang ditetapkan, anda boleh memilih untuk menyekatnya secara automatik';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Anda boleh memilih untuk membenarkan nombor yang tidak melebihi ambang';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Anda boleh memilih sama ada untuk merekod semua log pertanyaan';

  @override
  String get localCountFiltering => 'Penapisan Kiraan Tempatan';

  @override
  String get localCountFilteringExplanation =>
      '• Penapisan Kiraan Tempatan: Peraturan penapisan berdasarkan kiraan tanda tempatan';

  @override
  String get localCountFilterSettings => 'Tetapan Penapis Kiraan Tempatan';

  @override
  String get localCountFilterUseCases =>
      'Penapis ini amat sesuai untuk mengenal pasti panggilan spam dail automatik dan panggilan pemasaran.';

  @override
  String get localFilterSettings => 'Tetapan Penapis Tempatan';

  @override
  String get localNotificationDisabled => 'Pemberitahuan tempatan dilumpuhkan';

  @override
  String get localNotificationEnabled => 'Pemberitahuan tempatan didayakan';

  @override
  String get localServices => 'Perkhidmatan Tempatan';

  @override
  String get locationColor => 'Warna Lokasi';

  @override
  String get locationFontSize => 'Saiz Fon Lokasi';

  @override
  String get locationIconColor => 'Warna Ikon Lokasi';

  @override
  String get locationPosition => 'Kedudukan Lokasi';

  @override
  String get logAllLocalQueries => 'Log Semua Pertanyaan Tempatan';

  @override
  String get logAllLocalQueriesDescription =>
      'Rakam log untuk semua pertanyaan nombor tempatan';

  @override
  String get logAllRemoteQueries => 'Log Semua Pertanyaan Jauh';

  @override
  String get logAllRemoteQueriesDescription =>
      'Rakam semua operasi pertanyaan nombor jauh';

  @override
  String get manage => 'Urus Kenalan';

  @override
  String get manageFavoriteContacts => 'Urus Kenalan Kegemaran';

  @override
  String get manageFilterRules => 'Urus Peraturan Penapis';

  @override
  String get manageFilterRulesDescription =>
      'Tambah, edit, atau padam peraturan penapis SMS';

  @override
  String get markCounts => 'Kiraan Tanda';

  @override
  String get markCount => 'Kiraan Tanda';

  @override
  String markedByCount(Object count) {
    return 'Ditandai oleh $count';
  }

  @override
  String get markedPhonesList => 'Nombor Telefon Bertanda';

  @override
  String get markExchange => 'Tukar Tanda';

  @override
  String get markPhone => 'Tanda Nombor Telefon';

  @override
  String markPhoneFailed(Object error) {
    return 'Gagal menandakan nombor telefon: $error';
  }

  @override
  String get markPhoneManagementTitle => 'Pengurusan Penandaan Telefon';

  @override
  String get markPhoneSuccess => 'Nombor telefon ditanda berjaya';

  @override
  String get matchFailedMessage => 'Padanan gagal.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'padankan format nombor khusus';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Padankan nombor dengan aksara khas:';

  @override
  String get matchSpecificDigitPatterns => 'padankan format XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Padankan corak digit tertentu:';

  @override
  String get matchSuccessfulMessage => 'Padanan berjaya!';

  @override
  String get medical => 'Perubatan';

  @override
  String get membershipPrivileges => 'Keahlian Istimewa';

  @override
  String get migrationTool => 'Alat Migrasi';

  @override
  String get minutes => 'minit';

  @override
  String get month => 'Bulan';

  @override
  String get monthly => 'Bulanan';

  @override
  String get monthlyCallCount => 'Panggilan Bulanan';

  @override
  String get monthlyMembership => 'Keahlian Bulanan';

  @override
  String get monthlyMembershipDescription =>
      'Buka kunci semua ciri premium, pembaharuan automatik bulanan';

  @override
  String get monthlyTotal => 'Jumlah Bulanan';

  @override
  String get moreOptions => 'Pilihan Lanjut';

  @override
  String get mute => 'Senyap';

  @override
  String get name => 'Nama';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Nama dan nombor telefon tidak boleh kosong';

  @override
  String get nameColor => 'Warna Nama';

  @override
  String get nameFontSize => 'Saiz Fon Nama';

  @override
  String get namePosition => 'Kedudukan Nama';

  @override
  String get nameUnknown => 'Nama: Tidak Diketahui';

  @override
  String get nextStep => 'Seterusnya';

  @override
  String get noAction => 'Tiada Tindakan';

  @override
  String get noActionRules => 'Tiada Peraturan Tindakan';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Tiada perkhidmatan penyegerakan awan aktif';

  @override
  String get noCallRecords => 'Tiada rekod panggilan';

  @override
  String get noContactsYet => 'Tiada kenalan lagi';

  @override
  String get noData => 'Tiada Data';

  @override
  String get noDevicesRegisteredMessage => 'Tiada peranti didaftarkan';

  @override
  String get noLabels => 'Tiada label lagi';

  @override
  String get noMarkedPhones => 'Tiada nombor telefon yang ditanda';

  @override
  String get noMatchingContactsFound => 'Tiada kenalan yang sepadan ditemui';

  @override
  String get noMatchingNumbersFound => 'Tiada nombor yang sepadan ditemui';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Tiada $ruleType yang sepadan';
  }

  @override
  String get none => 'Tiada';

  @override
  String get noneServiceType => 'Tiada';

  @override
  String get noPlugins => 'Tiada plugin lagi';

  @override
  String noRules(Object ruleType) {
    return 'Tiada $ruleType lagi';
  }

  @override
  String get noRulesPrompt =>
      'Tiada peraturan ditemui, sila tambahkan peraturan';

  @override
  String get noRulesToExport => 'Tiada peraturan untuk dieksport';

  @override
  String get noSmsFilterRulesYet => 'Tiada peraturan penapis SMS lagi';

  @override
  String get noSmsRulesYet => 'Tiada peraturan SMS lagi';

  @override
  String get noSubscriptions => 'Tiada langganan';

  @override
  String get notGranted => 'Tidak Diberikan';

  @override
  String get notificationModeDescription =>
      'Tunjukkan maklumat pemanggil dalam bar pemberitahuan';

  @override
  String get notificationPermission => 'Kebenaran Pemberitahuan';

  @override
  String get notificationPermissionDescription =>
      'Digunakan untuk memaparkan pemberitahuan panggilan dan mesej masuk.';

  @override
  String get notifications => 'Pemberitahuan';

  @override
  String get notificationSettings => 'Tetapan Pemberitahuan';

  @override
  String get notVerifiedText => 'Tidak Disahkan';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Tiada peraturan SMS yang sah ditemui dalam fail';

  @override
  String get number => 'Nombor';

  @override
  String get numberColor => 'Warna Nombor';

  @override
  String get numberFontSize => 'Saiz Fon Nombor';

  @override
  String get numberPosition => 'Kedudukan Nombor';

  @override
  String get numberSearch => 'Carian Nombor';

  @override
  String get numberTypeColor => 'Warna Jenis Nombor';

  @override
  String get numberTypeFontSize => 'Saiz Fon Jenis Nombor';

  @override
  String get numberTypePosition => 'Kedudukan Jenis Nombor';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Pengurus keselamatan panggilan anda sudah bersedia, mula menikmati pengalaman panggilan yang selamat!';

  @override
  String get onboardingLanguageDescription =>
      'Pilih bahasa pilihan anda untuk pengalaman terbaik.';

  @override
  String get onboardingPermissionsDescription =>
      'Untuk menyediakan perkhidmatan penuh, kami memerlukan kebenaran berikut:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Sekat panggilan dan mesej spam dengan satu klik, sesuaikan peraturan penyekatan, dan berikan anda persekitaran yang tenang.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Kenal pasti panggilan yang tidak diketahui secara automatik, tandai nombor yang mencurigakan, dan lindungi keselamatan panggilan anda.';

  @override
  String get onboardingWelcomeDescription =>
      'Pakar pengurusan panggilan anda, menyediakan pengenalan panggilan dan perkhidmatan penyekatan yang komprehensif.';

  @override
  String get oneDriveAuthDescription =>
      'Benarkan menggunakan ID dan kunci pelanggan OneDrive yang dikonfigurasi sistem';

  @override
  String get oneDriveConfigTitle => 'Konfigurasi OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Langganan ID Pemanggil Dalam Talian';

  @override
  String get openAppSettings => 'Buka tetapan aplikasi';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Gagal membuka tetapan aplikasi: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operasi gagal: $error';
  }

  @override
  String get operationFailure => 'Operasi gagal';

  @override
  String get operationSuccess => 'Operasi berjaya';

  @override
  String get other => 'Lain-lain';

  @override
  String get ourOtherApps => 'Apl Kami Yang Lain';

  @override
  String get overlayMode => 'Tetingkap Terapung';

  @override
  String get overlayModeDescription =>
      'Tunjukkan maklumat pemanggil dalam tetingkap terapung';

  @override
  String get overlayPermission => 'Kebenaran Bertindih';

  @override
  String get overlayPermissionDescription =>
      'Digunakan untuk memaparkan tindihan panggilan masuk.';

  @override
  String get overview => 'Gambaran Keseluruhan';

  @override
  String get password => 'Kata Laluan';

  @override
  String get passwordCannotBeEmpty => 'Kata laluan tidak boleh kosong';

  @override
  String get passwordLabel => 'Kata Laluan';

  @override
  String get passwordsDoNotMatch => 'Kata laluan tidak sepadan';

  @override
  String get pattern => 'Corak';

  @override
  String get pendingSync => 'Penyegerakan Tertunda';

  @override
  String get periodMonth => 'Bulan';

  @override
  String get periodWeek => 'Minggu';

  @override
  String get periodYear => 'Tahun';

  @override
  String get permissionDenied => 'Permintaan kebenaran ditolak';

  @override
  String get permissionGranted => 'Kebenaran diberikan';

  @override
  String get permissionManagement => 'Pengurusan Kebenaran';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Nombor Telefon';

  @override
  String get phoneNumberCannotBeEmpty => 'Nombor telefon tidak boleh kosong';

  @override
  String get phoneNumberLabel => 'Nombor Telefon';

  @override
  String get phoneNumberTypeFixedLine => 'Talian Tetap';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Talian tetap atau mudah alih';

  @override
  String get phoneNumberTypeMobile => 'Mudah Alih';

  @override
  String get phoneNumberTypePager => 'Pencari';

  @override
  String get phoneNumberTypePersonalNumber => 'Nombor peribadi';

  @override
  String get phoneNumberTypePremiumRate => 'Kadar Premium';

  @override
  String get phoneNumberTypeSharedCost => 'Kos Dikongsi';

  @override
  String get phoneNumberTypeTollFree => 'Bebas Tol';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Tidak Diketahui';

  @override
  String get phoneNumberTypeVoicemail => 'Mel suara';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Kebenaran Telefon';

  @override
  String get phonePermissionDescription =>
      'Digunakan untuk mengenal pasti dan menyekat panggilan masuk.';

  @override
  String get phoneRule => 'Peraturan Telefon';

  @override
  String get phoneRuleManagement => 'Pengurusan Peraturan Telefon';

  @override
  String get phoneRuleSubscription => 'Langganan Peraturan Telefon';

  @override
  String get phoneSubscription => 'Langganan Telefon';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Langgan senarai peraturan telefon melalui URL untuk mengemas kini peraturan senarai putih dan senarai hitam secara automatik. Menyokong fail peraturan format JSON.';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Sila pilih label dan masukkan nombor telefon yang sah';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" berjaya ditambah';
  }

  @override
  String get pluginDeleted => 'Plugin dipadam';

  @override
  String get pluginLatestVersion => 'Plugin sudah versi terkini';

  @override
  String get pluginListExportSuccess => 'Senarai plugin berjaya dieksport';

  @override
  String get pluginManagement => 'Pengurusan Plugin';

  @override
  String get pluginManagementSubtitle =>
      'Urus dan konfigurasikan plugin pihak ketiga';

  @override
  String get pluginName => 'Nama Plugin';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugin berjaya dipadam.';
  }

  @override
  String get pluginService => 'Perkhidmatan Plugin';

  @override
  String get pluginTestPageTitle => 'Ujian Plugin';

  @override
  String get pluginUpdateSuccess => 'Plugin berjaya dikemas kini';

  @override
  String get pluginUrl => 'URL Plugin';

  @override
  String get pluginVersion => 'Versi Plugin';

  @override
  String get political => 'Politik';

  @override
  String get powerfulSpamBlocking => 'Penghalang Spam Berkuasa';

  @override
  String get previousStep => 'Sebelumnya';

  @override
  String get prioritizeRemoteAction => 'Utamakan Tetapan Tindakan Jauh';

  @override
  String get prioritizeRemoteActionDescription =>
      'Utamakan tetapan tindakan daripada pangkalan data jauh';

  @override
  String get processing => 'Memproses...';

  @override
  String get processingOperation => 'Memproses...';

  @override
  String get purchase => 'Beli';

  @override
  String get quarterlyMembership => 'Keahlian Suku Tahunan';

  @override
  String get quarterlyMembershipDescription =>
      'Buka kunci semua ciri premium, auto-perbaharui setiap suku tahun';

  @override
  String get ready => 'Sedia!';

  @override
  String get recruiter => 'Perekrut';

  @override
  String get refresh => 'Segarkan';

  @override
  String get refreshPermissionStatus => 'Segarkan status kebenaran';

  @override
  String get refreshTooltip => 'Segarkan';

  @override
  String regexErrorMessage(Object error) {
    return 'Ralat Regex: $error';
  }

  @override
  String get regexPattern => 'Corak Regex';

  @override
  String get regexPatternExplanation => 'Penjelasan Corak Regex';

  @override
  String get regexPatternExplanationButton => 'Penjelasan Corak Regex';

  @override
  String get regexPatternLabel => 'Corak Regex';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Corak Regex untuk Padanan Nombor Telefon';

  @override
  String get regexRule => 'Peraturan Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Gagal menambah peraturan regex: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Peraturan regex berjaya ditambah';

  @override
  String get regexRuleManagement => 'Pengurusan Peraturan Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'Nama peraturan dan corak regex tidak boleh kosong';

  @override
  String get regexRules => 'Peraturan Regex';

  @override
  String get regexTesterTitle => 'Penguji Regex';

  @override
  String get region => 'Wilayah';

  @override
  String get registeredDevicesTitle => 'Peranti Berdaftar';

  @override
  String get rejectAllCalls => 'Tolak Semua Panggilan';

  @override
  String get rejectAllCallsDescription =>
      'Apabila didayakan, semua panggilan akan ditolak dengan keutamaan tertinggi';

  @override
  String get rejectAllNumbers => 'Tolak Semua Nombor';

  @override
  String get rejectAllNumbersDesc =>
      'Tolak semua panggilan masuk apabila didayakan';

  @override
  String get rejectExceededNumbers => 'Tolak Nombor yang Melebihi Had';

  @override
  String get rejectExceededNumbersDescription =>
      'Tolak nombor secara automatik yang melebihi ambang kiraan';

  @override
  String get remoteFilterSettings => 'Tetapan Penapis Jauh';

  @override
  String get remoteFilterSettingsPageTitle => 'Tetapan Penapis Nombor Jauh';

  @override
  String get remoteNumberFilter => 'Penapis Nombor Jauh';

  @override
  String get remoteNumberFilterDescription =>
      'Pintas panggilan mengganggu berdasarkan maklumat pangkalan data jauh';

  @override
  String get remoteNumberFiltering => 'Penapisan Nombor Jauh';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Penapisan Nombor Jauh: Peraturan penapisan berdasarkan maklumat pangkalan data jauh';

  @override
  String get remoteNumberFilterSubtitle =>
      'Kenal pasti panggilan spam menggunakan pangkalan data awan dan laporan komuniti';

  @override
  String get removeAdsDescription =>
      'Keluarkan semua iklan dalam apl secara kekal untuk pengalaman yang lebih lancar';

  @override
  String get removeAdsTitle => 'Keluarkan Iklan';

  @override
  String get removedFromFavorites => 'Dialih keluar daripada kegemaran';

  @override
  String get removeFromFavorites => 'Alih Keluar Daripada Kegemaran';

  @override
  String get renameDeviceTitle => 'Namakan Semula Peranti';

  @override
  String get requestAllPermissions => 'Minta Semua Kebenaran';

  @override
  String get requestPermission => 'Minta Kebenaran';

  @override
  String requestPermissionFailed(Object error) {
    return 'Gagal meminta kebenaran: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Markah';
  }

  @override
  String get reset => 'Set Semula';

  @override
  String get restore => 'Pulihkan';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Pulihkan Tetapan Aplikasi daripada Sandaran';

  @override
  String get restoreFromCloud => 'Pulihkan daripada Awan';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Gagal memulihkan daripada awan: $error';
  }

  @override
  String get restoreFromCloudSuccess => 'Berjaya dipulihkan daripada awan';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get restoreSettings => 'Pulihkan Tetapan';

  @override
  String get restoreSettingsConfirmation =>
      'Ini akan menggantikan semua tetapan semasa anda. Adakah anda pasti mahu meneruskan?';

  @override
  String get retry => 'Cuba Lagi';

  @override
  String get ridesharing => 'Perkongsian Tunggangan';

  @override
  String get risk => 'Risiko';

  @override
  String get robocall => 'Panggilan Robot';

  @override
  String get ruleAction => 'Tindakan Peraturan';

  @override
  String get ruleAddedSuccess => 'Peraturan berjaya ditambahkan';

  @override
  String get ruleAddSuccess => 'Peraturan berjaya ditambahkan';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Adakah anda pasti mahu memadam $ruleType ini?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Padam Peraturan';

  @override
  String get ruleDeletedSuccessfully => 'Peraturan berjaya dipadam';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Gagal memadam peraturan: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Peraturan berjaya dipadam';

  @override
  String get ruleDisabledSuccessfully => 'Peraturan berjaya dilumpuhkan';

  @override
  String get ruleEnabledSuccessfully => 'Peraturan berjaya didayakan';

  @override
  String ruleLoadFailed(Object error) {
    return 'Gagal memuatkan peraturan: $error';
  }

  @override
  String get ruleManagement => 'Pengurusan Peraturan';

  @override
  String get ruleName => 'Nama Peraturan';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Nama peraturan dan ungkapan biasa kandungan tidak boleh dikosongkan';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Nama peraturan dan nombor telefon tidak boleh dikosongkan';

  @override
  String get ruleNameHint => 'cth., Keluarga, Rakan, dll.';

  @override
  String get ruleNameLabel => 'Nama Peraturan';

  @override
  String get ruleNameRequired =>
      'Nama peraturan dan nombor telefon tidak boleh dikosongkan';

  @override
  String get ruleNotExist => 'Peraturan tidak wujud atau telah dipadam';

  @override
  String ruleNotFound(Object error) {
    return 'Peraturan tidak ditemui: $error';
  }

  @override
  String get ruleSavedSuccessMessage => 'Peraturan berjaya disimpan!';

  @override
  String get rulesExportedSuccessfully => 'Peraturan berjaya dieksport';

  @override
  String rulesExportedTo(Object path) {
    return 'Peraturan dieksport ke: $path';
  }

  @override
  String get rulesImported => 'Peraturan berjaya diimport';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count peraturan berjaya diimport';
  }

  @override
  String ruleStatusChanged(Object status) {
    return 'Peraturan berjaya $status';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operasi gagal: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Peraturan berjaya $status';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Gagal mengemas kini peraturan: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Peraturan berjaya dikemas kini';

  @override
  String get ruleVerification => 'Pengesahan Peraturan';

  @override
  String get save => 'Simpan';

  @override
  String get saveButton => 'Simpan';

  @override
  String get saveButtonText => 'Simpan';

  @override
  String saveFailed(Object error) {
    return 'Penyimpanan gagal: $error';
  }

  @override
  String get saveSettings => 'Simpan Tetapan';

  @override
  String get scamsLikely => 'Kemungkinan Penipuan';

  @override
  String get search => 'Cari';

  @override
  String get searchContacts => 'Cari Kenalan';

  @override
  String searchError(Object error) {
    return 'Ralat carian: $error';
  }

  @override
  String get searchHint => 'Cari...';

  @override
  String get securityMessage =>
      'Jangan percaya panggilan telefon. Sentiasa sahkan nombor khidmat pelanggan secara bebas. Jangan sesekali berkongsi kata laluan, kod pengesahan, nombor kad atau maklumat peribadi.';

  @override
  String get selectActionWhenBlockingCalls =>
      'Pilih tindakan semasa menyekat panggilan';

  @override
  String get selectActionWhenRuleMatches =>
      'Pilih tindakan apabila peraturan dipadankan';

  @override
  String get selectAll => 'Pilih Semua';

  @override
  String get selectCountry => 'Pilih Negara';

  @override
  String selectedItems(Object count) {
    return '$count item dipilih';
  }

  @override
  String get selectedLabel => 'Dipilih:';

  @override
  String get selectExportFormat => 'Pilih Format Eksport';

  @override
  String get selectLabel => 'Pilih Label';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Sila pilih label dan masukkan nombor telefon yang sah';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get selectMultiple => 'Pilih Pelbagai';

  @override
  String get selectSimCard => 'Pilih Kad SIM';

  @override
  String get selectTags => 'Pilih Tag';

  @override
  String get selectTrustedDataSource =>
      'Sila pilih sumber data yang dipercayai';

  @override
  String get selectYourLanguage => 'Pilih Bahasa Anda';

  @override
  String get sender => 'Pengirim';

  @override
  String get senderRegexOptional => 'Ungkapan Regex Pengirim (Pilihan)';

  @override
  String get serverAddressLabel => 'Alamat Pelayan';

  @override
  String get serviceTypeContact => 'Langganan Kenalan';

  @override
  String get serviceTypeLabel => 'Jenis Perkhidmatan';

  @override
  String get serviceTypePhone => 'Langganan Telefon';

  @override
  String get serviceTypePlugin => 'Kemas Kini Plugin';

  @override
  String get serviceTypeSms => 'Langganan SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setEncryptionPassword => 'Tetapkan Kata Laluan Penyulitan';

  @override
  String get settings => 'Tetapan';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Tetapan telah disandarkan ke: $path';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Tetapan berjaya dipulihkan. Sila mulakan semula aplikasi agar perubahan berkuatkuasa.';

  @override
  String get settingsSaved => 'Tetapan disimpan';

  @override
  String settingsSaveFailed(Object error) {
    return 'Gagal menyimpan tetapan: $error';
  }

  @override
  String get settingsTab => 'Tetapan';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get setup => 'Persediaan';

  @override
  String get silence => 'Senyap';

  @override
  String get silenceAndNoAnswer => 'Senyap dan Tiada Jawapan';

  @override
  String get silenceNoAnswer => 'Senyap Tiada Jawapan';

  @override
  String get silentCallVoiceClone => 'Klon Suara Panggilan Senyap';

  @override
  String get silentRules => 'Peraturan Senyap';

  @override
  String simCard(Object simNumber) {
    return 'Kad SIM $simNumber';
  }

  @override
  String get simCardColor => 'Warna Kad SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Konfigurasi Kad SIM: Tetapkan peraturan penapisan bebas untuk setiap kad SIM';

  @override
  String get simCardFilterRules => 'Peraturan Penapis Kad SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Tetapkan peraturan penapisan berbeza berdasarkan slot kad SIM';

  @override
  String get simCardFontSize => 'Saiz Fon Kad SIM';

  @override
  String get simCardPosition => 'Kedudukan Kad SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String get simRuleInstructions =>
      'Peraturan slot SIM membolehkan anda mengkonfigurasi peraturan penapisan bebas untuk setiap slot SIM.';

  @override
  String get simRuleInstructionsTitle => 'Peraturan Slot SIM';

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
      'Konfigurasi peraturan penapisan bebas untuk setiap kad SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Tetapan Penapis Slot SIM $slotNumber';
  }

  @override
  String get simSlotManagement => 'Pengurusan Slot SIM';

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Kedudukan Slot SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Peraturan Slot SIM: Strategi penapisan bebas setiap SIM';

  @override
  String get simSlotRuleListTitle => 'Senarai Peraturan Slot SIM';

  @override
  String get simSlotRuleManagement => 'Peraturan Slot SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Slot SIM $slotNumber';
  }

  @override
  String get skip => 'Langkau';

  @override
  String get smartCallerId => 'Identifikasi Panggilan Pintar';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Penapisan SMS membantu anda menapis mesej spam secara automatik dan menjaga senarai mesej anda bersih. Anda boleh menetapkan peraturan penapisan dan kaedah pemberitahuan.';

  @override
  String get smsFilterDisabled => 'Penapisan SMS dilumpuhkan';

  @override
  String get smsFilterEnabled => 'Penapisan SMS didayakan';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Peraturan penapis SMS berjaya ditambah';

  @override
  String get smsFilterRules => 'Peraturan Penapis SMS';

  @override
  String get smsFilterSettings => 'Tetapan Penapis SMS';

  @override
  String get smsManagement => 'Pengurusan SMS';

  @override
  String get smsPermission => 'Kebenaran SMS';

  @override
  String get smsPermissionDescription => 'Digunakan untuk menapis mesej spam.';

  @override
  String get smsRuleAddedSuccessfully => 'Peraturan SMS berjaya ditambah';

  @override
  String get smsRuleDeletedSuccessfully => 'Peraturan SMS berjaya dipadam';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Gagal memuatkan peraturan SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Pengurusan Peraturan SMS';

  @override
  String get smsRuleSubscription => 'Langganan Peraturan SMS';

  @override
  String get smsSubscription => 'Langganan SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Langganan SMS berjaya ditambah';

  @override
  String get smsSubscriptionRulesDescription =>
      'Langgan senarai peraturan SMS melalui URL, menyokong padanan ungkapan biasa. Anda boleh menetapkan tindakan sekat atau benarkan.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Beberapa permintaan kebenaran ditolak';

  @override
  String get spamLikely => 'Kemungkinan Spam';

  @override
  String get startColor => 'Warna Mula';

  @override
  String get startDate => 'Tarikh Mula';

  @override
  String get startUsing => 'Mula Menggunakan';

  @override
  String get statAnswered => 'Dijawab';

  @override
  String get statBlocked => 'Disekat';

  @override
  String get statistics => 'Statistik';

  @override
  String get statisticsPageTitle => 'Analisis Data';

  @override
  String get stirColor => 'Warna STIR';

  @override
  String get stirFontSize => 'Saiz Fon STIR';

  @override
  String get stirPosition => 'Kedudukan STIR';

  @override
  String get storagePermission => 'Kebenaran Storan';

  @override
  String get storagePermissionDescription =>
      'Digunakan untuk menyimpan tetapan dan peraturan.';

  @override
  String get subscribe => 'Langgan';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Langganan \"$name\" berjaya ditambah';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Adakah anda pasti anda mahu memadam langganan ini?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Padam Langganan';

  @override
  String get subscriptionDeleted => 'Langganan dipadam';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Gagal memadam langganan: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Langganan dipadam';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Gagal memuatkan langganan: $error';
  }

  @override
  String get subscriptionName => 'Nama Langganan';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Nama langganan dan URL tidak boleh kosong';

  @override
  String get subscriptionNameHint => 'Masukkan nama langganan';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Gagal menukar status langganan: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Gagal mengemas kini langganan: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Langganan berjaya dikemas kini';

  @override
  String get subscriptionUrl => 'URL Langganan';

  @override
  String get subscriptionUrlHint => 'Masukkan URL langganan';

  @override
  String successfullyImportedRules(Object count) {
    return 'Berjaya mengimport $count peraturan';
  }

  @override
  String get supportSync => 'Sokong Sinci';

  @override
  String get survey => 'Tinjauan';

  @override
  String get syncDevicesButton => 'Sinci Peranti';

  @override
  String get syncFailed => 'Sinci gagal';

  @override
  String get syncFailedMessage => 'Sinci gagal';

  @override
  String get syncFolderNameLabel => 'Nama Folder Sinci';

  @override
  String get synchronized => 'Disincci';

  @override
  String get syncing => 'Menyinci...';

  @override
  String get syncNow => 'Sinci Sekarang';

  @override
  String get syncNowButton => 'Sinci Sekarang';

  @override
  String get syncStatusTitle => 'Status Sinci';

  @override
  String get syncStatusUpdatedMessage => 'Status sinci dikemas kini';

  @override
  String get syncSuccessMessage => 'Sinci berjaya';

  @override
  String get syncWithCloudStorage => 'Sinci dengan Storan Awan';

  @override
  String get systemFeatures => 'Ciri Sistem:';

  @override
  String get systemSettingsTitle => 'Tetapan Sistem';

  @override
  String get tabAll => 'Semua';

  @override
  String get tabAnswered => 'Dijawab';

  @override
  String get tabBlocked => 'Disekat';

  @override
  String get tabMissed => 'Terlepas';

  @override
  String get tabOutgoing => 'Keluar';

  @override
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get takeaway => 'Ambil';

  @override
  String get telecommunication => 'Telekomunikasi';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'UJIAN';

  @override
  String get testConnectionButton => 'Uji Sambungan';

  @override
  String get textColorsSetting => 'Warna Teks & Label';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Aplikasi ini ialah alat ID Pemanggil yang berkuasa yang membolehkan anda mengenal pasti dan menyekat panggilan yang tidak diingini.';

  @override
  String get thisWeek => 'Minggu Ini';

  @override
  String get timeInterceptor => 'Pintas Masa';

  @override
  String get timeInterceptorDescription =>
      'Pintas/benarkan panggilan yang berpotensi secara automatik berdasarkan kekerapan panggilan';

  @override
  String get timeInterceptorExplanation =>
      '• Pintas Masa: Pintas/benarkan panggilan berulang dalam masa yang singkat';

  @override
  String get timeInterceptorExplanationContent =>
      'Ciri pintas kekerapan panggilan menganalisis kekerapan panggilan untuk mengenal pasti dan memintas/membenarkan panggilan spam yang kerap secara automatik.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Penjelasan Pintasan Kekerapan Panggilan';

  @override
  String get timeInterceptorSettingsTitle =>
      'Tetapan Pintasan Kekerapan Panggilan';

  @override
  String get timeWindowDescription =>
      'Tetapkan saiz tetingkap masa untuk membenarkan panggilan berulang. Panggilan daripada nombor yang sama dalam tetingkap ini akan dibenarkan';

  @override
  String timeWindowLabel(int minutes) {
    return 'Tetingkap Masa Pintasan (minit): $minutes';
  }

  @override
  String get today => 'Hari Ini';

  @override
  String get total => 'Jumlah';

  @override
  String get totalBlocked => 'Jumlah Disekat';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Pindahkan data antara peranti atau platform';

  @override
  String get travelTicketing => 'Penetapan Tiket Perjalanan';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Jenis';

  @override
  String get unassignedSIMCard => 'Kad SIM Tidak Ditugaskan';

  @override
  String get unknown => 'Tidak Diketahui';

  @override
  String get unknownTag => 'Tag: Tidak Diketahui';

  @override
  String get unregisterButton => 'Nyahdaftar';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Adakah anda pasti mahu nyahdaftar $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Nyahdaftar Peranti';

  @override
  String get unsupportedFileFormat => 'Format fail tidak disokong';

  @override
  String get update => 'Kemas kini';

  @override
  String get updateAllNow => 'Kemas Kini Semua Sekarang';

  @override
  String updateContactFailed(Object error) {
    return 'Gagal mengemas kini kenalan: $error';
  }

  @override
  String get updateFavoriteStatus => 'Kemas Kini Status Kegemaran';

  @override
  String get updateInterval => 'Kekerapan Kemas Kini';

  @override
  String get updateNow => 'Kemas Kini Sekarang';

  @override
  String get updatePlugin => 'Kemas Kini Plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Gagal mengemas kini plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Gagal mengemas kini peraturan: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Gagal mengemas kini langganan: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service dikemas kini dengan jayanya ($count peraturan)';
  }

  @override
  String get useCasesPoint1 =>
      '• Kenal pasti panggilan spam dail semula secara automatik';

  @override
  String get useCasesPoint2 =>
      '• Pintas panggilan pemasaran yang mendail berulang kali dalam tempoh singkat';

  @override
  String get useCasesPoint3 => '• Elakkan gangguan telefon dan gangguan';

  @override
  String get useCasesTitle => 'Kes Penggunaan:';

  @override
  String get useGlobalSettings => 'Gunakan Tetapan Global';

  @override
  String get usernameLabel => 'Nama Pengguna';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Gunakan sintaks regex standard untuk mentakrifkan corak. Contoh:';

  @override
  String get verificationFailedText => 'Gagal';

  @override
  String get verifiedText => 'Disahkan';

  @override
  String get verify => 'Sahkan';

  @override
  String version(Object version) {
    return 'Versi: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Tukar keahlian VIP dengan jumlah penandaan nombor telefon';

  @override
  String get vipExchangeTitle => 'Tukar VIP Tandakan';

  @override
  String get watchAd => 'Tonton Iklan';

  @override
  String get watchAdForTemp => 'Tonton Iklan untuk Keistimewaan Sementara';

  @override
  String get watchAdForTempDescription =>
      'Tonton iklan pendek untuk membuka kunci ciri premium untuk sementara waktu';

  @override
  String get webDAVConfigTitle => 'Konfigurasi WebDAV';

  @override
  String get week => 'Minggu';

  @override
  String get welcome => 'Selamat Datang';

  @override
  String get whitelist => 'Senarai Putih';

  @override
  String get width => 'Lebar';

  @override
  String get wildcardMatchingDescription =>
      'Gunakan \'.\' untuk memadankan mana-mana aksara (cth. \'123.456\' memadankan 123-456)';

  @override
  String get wildcardMatchingTitle => 'Padanan wildcard:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Sokongan Wildcard untuk Penapisan Fleksibel';

  @override
  String get windowSizeSetting => 'Tetapan Saiz Jendela';

  @override
  String get year => 'Tahun';

  @override
  String get noSimCardsDetected => 'Tiada kad SIM dikesan';

  @override
  String get filterManagementDescription => 'Tetapkan Penapis Panggilan';

  @override
  String get callerIdCustomizationSubtitle =>
      'Sesuaikan Tata Letak ID Pemanggil';

  @override
  String get fraudAlerSettingTitle => 'Tetapan Makluman Penipuan';

  @override
  String get fraudAlerSettingSubtitle => 'Untuk Tetapkan Makluman Penipuan';

  @override
  String get enableFraudAlert => 'Dayakan Makluman Penipuan';

  @override
  String get enableFraudAlertDescription =>
      'Makluman untuk panggilan penipuan yang disyaki';

  @override
  String get enableVibration => 'Dayakan Getaran';

  @override
  String get enableVibrationDescription =>
      'Bergetar apabila panggilan disyaki panggilan penipuan';

  @override
  String get notificationSettingsTitle => 'Tetapan Pemberitahuan';

  @override
  String get useLocalNotification => 'Gunakan Pemberitahuan Tempatan';

  @override
  String get useLocalNotificationDescription =>
      'Dayakan pemberitahuan tempatan untuk panggilan masuk';

  @override
  String get cancelLocalNotification => 'Tutup Pemberitahuan Tempatan';

  @override
  String get useStirNotification => 'Gunakan Pemberitahuan daripada STIR';

  @override
  String get cancelLocalNotificationDescription =>
      'Tutup Pemberitahuan Tempatan Secara Automatik';

  @override
  String get callerIdSettingsTitle => 'Tetapan ID Pemanggil';

  @override
  String get callerIdSettingsSubtitle =>
      'Untuk Tetapkan Pemberitahuan Panggilan Masuk & Mod Paparan';

  @override
  String get purchaseTitle => 'Pembelian';

  @override
  String get purchaseSubtitle => 'Untuk Membeli Perkhidmatan';

  @override
  String get callerIdNotificationTitle => 'Maklumat Panggilan Masuk';

  @override
  String get blockedCallTitle => 'Panggilan Disekat';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Panggilan disekat daripada $phoneNumber';
  }

  @override
  String get stirVerified => 'Disahkan';

  @override
  String get stirNotVerified => 'Tidak Disahkan';

  @override
  String get stirFailed => 'Sahkan Gagal';

  @override
  String get stirUnknown => 'Status Pengesahan Tidak Diketahui';

  @override
  String get stirVerificationTitle => 'Pengesahan STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage untuk nombor $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Tetapan Mesej Keselamatan Skroll';

  @override
  String get messageColor => 'Warna Mesej';

  @override
  String get messageFontSize => 'Saiz Fon Mesej';

  @override
  String get messagePosition => 'Kedudukan Mesej';

  @override
  String get containerWidth => 'Lebar Bekas';

  @override
  String get scrollSpeed => 'Kelajuan Skroll';

  @override
  String get enableSecurityMessage => 'Dayakan Mesej Keselamatan';

  @override
  String get fraudAlertTitle => 'Makluman Penipuan';

  @override
  String get noBlockedTypeData => 'Tiada data jenis disekat tersedia';

  @override
  String importEntity(Object entityTypeName) {
    return 'Import $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName berjaya diimport, jumlah $count rekod diimport';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Gagal mengimport $entityTypeName: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Export $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName berjaya dieksport';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Gagal mengeksport $entityTypeName: $error';
  }

  @override
  String get cloudSyncService => 'Perkhidmatan Sandaran Awan';

  @override
  String get membershipCenter => 'Pusat Keahlian';

  @override
  String get redeemVipWithMarks => 'Tebus VIP dengan Markah';

  @override
  String get currentMarkCount => 'Jumlah Markah Semasa';

  @override
  String get markMoreNumbersForMore =>
      'Tandai lebih banyak nombor untuk mendapatkan lebih banyak markah';

  @override
  String get noAds => 'Tiada Iklan';

  @override
  String get cloudBackup => 'Sandaran Awan';

  @override
  String get callerIdEnhancement => 'Peningkatan ID Pemanggil';

  @override
  String get voiceRecognition => 'Pengecaman Suara';

  @override
  String get feature => 'Ciri';

  @override
  String get normalUser => 'Pengguna Biasa';

  @override
  String get vipUser => 'Pengguna VIP';

  @override
  String get temporaryVip => 'VIP Sementara';

  @override
  String get removeAds => 'Alihkan Iklan';

  @override
  String get settingsBackup => 'Sandaran Tetapan ';

  @override
  String get allServicesStatusTitle => 'Status Perkhidmatan Semasa';

  @override
  String get allServicesStatusSubtitle =>
      'Status Semasa Setiap Perkhidmatan Awan';

  @override
  String get redirect => 'Alihkan';

  @override
  String get notify => 'Maklumkan';

  @override
  String get log => 'Log';

  @override
  String get custom => 'Kustom';

  @override
  String get allowActionDescription =>
      'Panggilan akan dibenarkan, walaupun nombor tersebut berada dalam senarai sekatan.';

  @override
  String get blockActionDescription =>
      'Panggilan akan disekat dan ditunjukkan dalam log panggilan.';

  @override
  String get silenceActionDescription =>
      'Panggilan akan dibisukan tetapi ditunjukkan dalam log panggilan.';

  @override
  String get noneActionDescription =>
      'Tiada tindakan khas akan diambil untuk panggilan tersebut.';

  @override
  String get redirectActionDescription =>
      'Alihkan panggilan ke nombor yang ditentukan.';

  @override
  String get labelActionDescription =>
      'Tambah label pada panggilan untuk pengenalan yang mudah.';

  @override
  String get notifyActionDescription =>
      'Hantar pemberitahuan apabila panggilan diterima.';

  @override
  String get logActionDescription =>
      'Log maklumat panggilan tanpa mengambil sebarang tindakan lain.';

  @override
  String get customActionDescription => 'Lakukan tindakan kustom.';

  @override
  String get synced => 'Disandarkan';

  @override
  String get needVipAccess =>
      'Anda memerlukan akses VIP untuk menggunakan ciri ini';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Import atau eksport data $entityTypeName';
  }

  @override
  String get importExportTitle => 'Import/Eksport';

  @override
  String get noPhoneRules => 'Tiada peraturan telefon ditemui';

  @override
  String get noRegexRules => 'Tiada peraturan regex ditemui';

  @override
  String get noAllowedBlockedRules =>
      'Tiada peraturan dibenarkan/disekat ditemui';

  @override
  String get importExport => 'Import/Eksport';

  @override
  String get filterByAction => 'Tapis mengikut Tindakan';

  @override
  String get upgradeToVip => 'Naik taraf kepada VIP';

  @override
  String get batteryOptimizationPermission => 'Pengoptimuman Bateri';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Benarkan apl berjalan di latar belakang untuk menyediakan perkhidmatan seperti ID pemanggil.';

  @override
  String get permissionTitle => 'Kebenaran Khas';

  @override
  String get permissionSubtitle =>
      'Urus kebenaran tindihan dan pengoptimuman bateri';

  @override
  String get themeSettingsTitle => 'Tetapan Tema';

  @override
  String get themeSettingsSubtitle => 'Pilih tema kegemaran anda';

  @override
  String get databaseSyncTitle => 'Sandaran Pangkalan Data';

  @override
  String get countrySyncSettingsTitle =>
      'Tetapan Sandaran Pangkalan Data Berdasarkan Negara';

  @override
  String get countrySyncSettingsSubtitle =>
      'Pilih negara untuk penyegerakan data';

  @override
  String get countryDataDisclaimer =>
      'Sila ambil perhatian: Pangkalan data mungkin tidak mengandungi data untuk semua negara atau wilayah tertentu.';

  @override
  String get editSubscription => 'Edit Langganan';

  @override
  String get searchByNameOrPhoneNumber =>
      'Cari Mengikut Nama atau Nombor Telefon';

  @override
  String get allowedBlockedRulesInfo =>
      'Peraturan dibenarkan/disekat digunakan untuk memadankan panggilan ke nombor telefon tertentu, yang mempunyai keutamaan tertinggi.';

  @override
  String get searchPhoneRulesHint => 'Cari peraturan telefon';

  @override
  String get phoneRulesInfo =>
      'Peraturan telefon digunakan untuk memadankan panggilan ke nombor telefon tertentu, yang mempunyai keutamaan lebih rendah. Sesetengahnya datang daripada langganan phoneRule';

  @override
  String get searchSubscriptionsHint => 'Cari langganan';

  @override
  String get searchPluginsHint => 'Cari plugin';

  @override
  String get searchLabelsHint => 'Cari label';

  @override
  String get pluginDescription => 'Penerangan plugin';

  @override
  String get enterPluginDescription => 'Masukkan penerangan plugin';

  @override
  String get searchRegexRulesHint => 'Cari peraturan regex';

  @override
  String get regexRulesInfo =>
      'Peraturan Regex digunakan untuk menapis panggilan berdasarkan Corak Regex.';

  @override
  String get searchMarkedPhonesHint => 'Cari nombor yang ditandai';

  @override
  String get searchContactSubscriptionsHint => 'Cari langganan kenalan';

  @override
  String get showAllContacts => 'Tunjukkan Semua Kenalan';

  @override
  String get showFavorites => 'Tunjukkan Kegemaran';

  @override
  String get manualEntry => 'Maklumat Kemasukan Manual';

  @override
  String get scriptSaved => 'Skrip disimpan';

  @override
  String editScriptFor(String pluginName) {
    return 'Edit skrip untuk $pluginName';
  }

  @override
  String get saveScript => 'Simpan Skrip';

  @override
  String get testPlugin => 'Uji Plugin';

  @override
  String get description => 'Penerangan';

  @override
  String get accessTargetUrl => 'Akses URL Sasaran';

  @override
  String get result => 'Keputusan';

  @override
  String get editScript => 'Edit Skrip';

  @override
  String get numberFormat => 'Format Nombor';

  @override
  String get nationalNumber => 'Nombor Kebangsaan';

  @override
  String get e164Number => 'Nombor E164';

  @override
  String get pluginRulesInfo =>
      'Untuk keselamatan, sila gunakan plugin daripada sumber yang dipercayai sahaja. Jangan teragak-agak untuk menggunakan templat kami untuk mencipta plugin tersuai anda sendiri!';

  @override
  String get advancedMode => 'Mod Lanjutan';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Sila masukkan sekurang-kurangnya satu nombor.';

  @override
  String get openInWebView => 'Buka dalam WebView';

  @override
  String get pluginLabel => 'Label Plugin';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Warna Latar Belakang Mesej';

  @override
  String get clearAllCallLogs => 'Padam Semua Log Panggilan';

  @override
  String get clearAllCallLogsConfirmation =>
      'Sahkan untuk memadam semua log panggilan';

  @override
  String get allCallLogsCleared => 'Semua log panggilan dipadam';

  @override
  String get unblocked => 'Tidak Disekat';

  @override
  String get blockNumber => 'Nombor Blok';

  @override
  String get blockNumberSuccess => 'Nombor blok berjaya';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Adakah anda pasti anda mahu nyahsekat $phoneNumber?';
  }

  @override
  String get viewDetails => 'Lihat Butiran';

  @override
  String get unblock => 'Nyahsekat';

  @override
  String get unblockNumber => 'Nyahsekat Nombor';

  @override
  String get unblockNumberSuccess => 'Nombor berjaya dinyahsekat';

  @override
  String get unblockNumberFailed => 'Gagal nyahsekat nombor';

  @override
  String get callingNumberFailed => 'Gagal memanggil nombor';

  @override
  String get listView => 'Paparan Senarai';

  @override
  String get timelineView => 'Paparan Garis Masa';

  @override
  String get nameCannotBeEmpty => 'Nama tidak boleh kosong';

  @override
  String get selectAction => 'Pilih tindakan';

  @override
  String get selectTargetService => 'Pilih perkhidmatan sasaran';

  @override
  String get callDetails => 'Butiran Panggilan';

  @override
  String get callType => 'Jenis Panggilan';

  @override
  String get callTime => 'Masa Panggilan';

  @override
  String get numberInvalidFormat => 'Format nombor tidak sah';

  @override
  String get medium => 'Medium';

  @override
  String get finalRisk => 'Risiko Akhir';

  @override
  String get simState => 'Status SIM';

  @override
  String get ipCountry => 'Negara IP';

  @override
  String get simCountry => 'Negara SIM';

  @override
  String get isRoaming => 'Perayauan';

  @override
  String get isNumberMatch => 'Padanan Nombor';

  @override
  String get support => 'Sokongan';

  @override
  String get rewardedAdService => 'Perkhidmatan Iklan Ganjaran';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Anda sudah mempunyai keistimewaan VIP (kecuali iklan)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Anda sudah mempunyai keistimewaan sementara, tarikh luput: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Anda perlu menonton $count lagi iklan untuk mendapatkan keistimewaan VIP sementara';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Anda telah dianugerahkan $days hari keistimewaan pembelian sementara. Tarikh luput: $expiryDate';
  }

  @override
  String get tempPurchaseExpired =>
      'Keistimewaan pembelian sementara telah tamat tempoh';

  @override
  String get loadingAd => 'Memuatkan Iklan...';

  @override
  String get earnedTempVip => 'Mendapat VIP sementara';

  @override
  String get vipExchangeService => 'Perkhidmatan Pertukaran VIP';

  @override
  String get marksInsufficient => 'Tanda tidak mencukupi untuk ditukar';

  @override
  String get invalidExchangeRule => 'Aturan pertukaran tidak sah';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Berjaya ditukar untuk $description, tarikh luput: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Pertukaran gagal: $error';
  }

  @override
  String get vip3DaysWithAds => 'VIP 3 hari dengan iklan (sync sahaja)';

  @override
  String get vip5DaysNoAds => 'VIP 5 hari penuh tanpa iklan';

  @override
  String get vip7DaysNoAds => 'VIP 7 hari penuh tanpa iklan';

  @override
  String get noNotifications => 'Tiada pemberitahuan';

  @override
  String get clearAllNotifications => 'Kosongkan Semua Pemberitahuan';

  @override
  String get clearAllNotificationsConfirmation =>
      'Sahkan untuk mengosongkan semua pemberitahuan';

  @override
  String get clearButton => 'Kosongkan';

  @override
  String get justNow => 'Baru sahaja';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minit lalu',
      one: '1 minit lalu',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jam lalu',
      one: '1 jam lalu',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari lalu',
      one: '1 hari lalu',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Semalam';

  @override
  String get deletionProposal => 'Cadangan Pemadaman';

  @override
  String get createProposal => 'Cipta Cadangan';

  @override
  String get createProposalTitle => 'Cipta Cadangan Pemadaman';

  @override
  String get reason => 'Sebab';

  @override
  String get reasonOutdated => 'Nombor Usang';

  @override
  String get reasonPrivacy => 'Kebimbangan Privasi';

  @override
  String get reasonNotInService => 'Tidak Dalam Perkhidmatan';

  @override
  String get reasonWronglyIdentified => 'Dikenal Pasti Salah';

  @override
  String get reasonInaccurateInfo => 'Maklumat Tidak Tepat';

  @override
  String get reasonOther => 'Lain-lain';

  @override
  String get submit => 'Hantar';

  @override
  String get cancel => 'Batal';

  @override
  String get riskLevel => 'Tahap Risiko';

  @override
  String get riskLevelLow => 'Rendah';

  @override
  String get riskLevelHigh => 'Tinggi';

  @override
  String agreeVotes(int count) {
    return 'Setuju: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Jumlah: $count';
  }

  @override
  String get voteAgree => 'Setuju';

  @override
  String get voteDisagree => 'Tidak Setuju';

  @override
  String createdAt(String date) {
    return 'Dibuat: $date';
  }

  @override
  String get verificationReport => 'Laporan Pengesahan';

  @override
  String get proposalStatistics => 'Statistik Cadangan';

  @override
  String get totalProposals => 'Jumlah Cadangan';

  @override
  String get activeProposals => 'Cadangan Aktif';

  @override
  String get proposalCreated => 'Cadangan berjaya dicipta';

  @override
  String get voteSubmitted => 'Undian berjaya dihantar';

  @override
  String get noProposalsFound => 'Tiada cadangan ditemui';

  @override
  String get refreshProposals => 'Segarkan Cadangan';

  @override
  String get totalPendingProposals => 'Jumlah Cadangan Tertunda';

  @override
  String get highRisk => 'Risiko Tinggi';

  @override
  String get mediumRisk => 'Risiko Sederhana';

  @override
  String get lowRisk => 'Risiko Rendah';

  @override
  String get communityImpact => 'Dampak Komunitas';

  @override
  String get criticalIssues => 'Isu Kritis';

  @override
  String get communityParticipation => 'Partisipasi Komunitas';

  @override
  String get noActivity => 'Tidak Ada Aktivitas';

  @override
  String get low => 'Rendah';

  @override
  String get moderate => 'Sederhana';

  @override
  String get high => 'Tinggi';

  @override
  String get veryHigh => 'Sangat Tinggi';

  @override
  String get voted => 'Telah Memilih';

  @override
  String get communityVotes => 'Undian Komunitas';

  @override
  String get waitingForMoreVotes => 'Menunggu lebih banyak undian komunitas';

  @override
  String get proposalProcessed => 'Cadangan ini telah diproses';

  @override
  String get supported => 'DISOKONG';

  @override
  String get opposed => 'DITENTANG';

  @override
  String get approved => 'DILULUSKAN';

  @override
  String get rejected => 'DITOLAK';

  @override
  String get completed => 'SELESAI';

  @override
  String get pending => 'Tertunda';

  @override
  String get critical => 'Kritis';

  @override
  String get oppose => 'Menentang';

  @override
  String get veryLow => 'Sangat Rendah';

  @override
  String get deletionProposals => 'Cadangan Pemadaman';

  @override
  String get deletionProposalNotificationDescription =>
      'Pemberitahuan tentang hasil pemungutan suara cadangan penghapusan dan pembaruan.';

  @override
  String get deletionProposalCreated => 'Cadangan Penghapusan Dibuat';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Cadangan penghapusan Anda untuk $phoneNumber telah diajukan untuk tinjauan komunitas.';
  }

  @override
  String get proposalApproved => 'Cadangan Diluluskan ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Cadangan penghapusan untuk $phoneNumber telah diluluskan oleh komunitas ($supportPercentage% sokongan, $totalVotes undian).';
  }

  @override
  String get proposalRejected => 'Cadangan Ditolak ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'Cadangan penghapusan untuk $phoneNumber telah ditolak oleh komunitas ($supportPercentage% sokongan, $totalVotes undian).';
  }

  @override
  String get communityVotingStarted => 'Pemungutan Suara Komunitas Dimulai';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Cadangan penghapusan baru untuk $phoneNumber kini dibuka untuk pemungutan suara komunitas.';
  }

  @override
  String get votingCompleted => 'Pemungutan Suara Selesai';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Pemungutan suara komunitas untuk $phoneNumber telah berakhir. Keputusan: $result ($supportPercentage% sokongan).';
  }

  @override
  String get newVoteReceived => 'Undian Baru Diterima';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Seseorang mengundi untuk $voteType penghapusan $phoneNumber. Undian semasa: $totalVotes.';
  }

  @override
  String get voteCount => 'Jumlah Undian';

  @override
  String get deletionProposalDescription =>
      'Cadangkan nombor untuk dihapus yang melanggar garis panduan komuniti. Penyertaan anda membantu menjaga keselamatan platform.';

  @override
  String get searchProposals => 'Cari Cadangan';

  @override
  String get defaultNotifications => 'Pemberitahuan Lalai';

  @override
  String get defaultNotificationsDescription =>
      'Saluran pemberitahuan lalai untuk aplikasi.';

  @override
  String get blockedCallNotifications => 'Pemberitahuan Panggilan Disekat';

  @override
  String get blockedCallNotificationsDescription =>
      'Memaparkan maklumat tentang panggilan yang disekat.';

  @override
  String get stirVerification => 'Pengesahan STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Memaparkan hasil pengesahan STIR/SHAKEN untuk nombor.';

  @override
  String get fraudAlerts => 'Peringatan Penipuan';

  @override
  String get fraudAlertsDescription =>
      'Memaparkan amaran untuk panggilan penipuan yang berpotensi.';

  @override
  String get notificationMode => 'Mod Pemberitahuan';

  @override
  String get pendingProposals => 'Cadangan Tertunda';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cadangan tertunda',
      one: '1 cadangan tertunda',
      zero: 'tiada cadangan tertunda',
    );
    return 'Anda mempunyai $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Garis Panduan';

  @override
  String get riskLevelLabel => 'Tahap Risiko';

  @override
  String get phoneNumberMinDigits =>
      'Nombor telefon mestilah sekurang-kurangnya 7 digit';

  @override
  String get provideDetailedExplanation =>
      'Berikan penjelasan terperinci (minimum 10 aksara)';

  @override
  String get reasonMinCharacters =>
      'Sebab mestilah sekurang-kurangnya 10 aksara';

  @override
  String get countryCodeTwoLetters => 'Kod Negara (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Kod Negara (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'Contohnya, US, CN, GB';

  @override
  String get countryCodeRequired => 'Kod negara diperlukan';

  @override
  String get phoneNumberHint => 'Masukkan nombor telefon';

  @override
  String get phoneNumberRequired => 'Nombor telefon diperlukan';

  @override
  String get reasonRequired => 'Sebab diperlukan';

  @override
  String get riskLevelCritical => 'Kritis';

  @override
  String get riskLevelMedium => 'Sederhana';

  @override
  String get riskLevelVeryLow => 'Sangat Rendah';

  @override
  String get notificationFrequencyTitle => 'Kekerapan Pemberitahuan';

  @override
  String errorMessage(String error) {
    return 'Ralat: $error';
  }

  @override
  String get reportingGuidelines =>
      '• Hanya laporkan nombor yang benar-benar bermasalah\n• Berikan sebab yang tepat dan terperinci\n• Pilih tahap risiko yang sesuai berdasarkan keterukan\n• Laporan palsu boleh mengakibatkan sekatan akaun';

  @override
  String get notificationFrequencyHours => 'Kekerapan Pemberitahuan (Jam)';

  @override
  String supportCount(int supportCount) {
    return 'Sokongan ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Tentangan ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes undian ($supportPercentage% sokongan)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jam',
      one: '1 jam',
      zero: '0 jam',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Notis Penting';

  @override
  String get dataSourceDisclaimer =>
      'Angka diperoleh daripada internet dan penyerahan pengguna. Kami tidak dapat menjamin bahawa nombor, setelah dipadam, tidak akan diserahkan semula oleh pengguna atau sumber lain. Sila cari dan sahkan maklumat secara aktif.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Lokasi';

  @override
  String get simCardTitle => 'Kad SIM';

  @override
  String get liveActivitiesSettingsTitle => 'Tetapan Aktiviti Langsung';

  @override
  String get elementsSettingsTitle => 'Tetapan Elemen';

  @override
  String get liveActivityMode => 'Aktiviti Langsung';

  @override
  String get liveActivityModeDescription =>
      'Memaparkan maklumat panggilan sebagai pemberitahuan berterusan pada skrin kunci dan dalam Dynamic Island (iOS).';

  @override
  String get phoneNumberType => 'Jenis Nombor Telefon';

  @override
  String get liveActivitiesTestEndActivity => 'Tamatkan Aktiviti';

  @override
  String get liveActivitiesTestSendNewActivity => 'Hantar Aktiviti Baharu';

  @override
  String get liveActivitiesTestUpdateActivity => 'Kemas kini Aktiviti';

  @override
  String get liveActivityControlsTitle => 'Kawalan Aktiviti Langsung';

  @override
  String get liveActivitiesTestTitle => 'Ujian Aktiviti Langsung';

  @override
  String get liveNotificationCustomizationTitle =>
      'Penyesuaian Pemberitahuan Langsung';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Sesuaikan penampilan pemberitahuan langsung.';

  @override
  String get notification_instructions =>
      'Arahan:\n1. Ketik \"HANTAR\" untuk mencipta atau mengemas kini pemberitahuan.\n2. Pergi ke skrin utama anda atau tarik dulang pemberitahuan ke bawah untuk melihat hasil.\n3. Ketik \"TAMAT\" untuk menutup pemberitahuan.';

  @override
  String get autoCancelNotification => 'Auto Batal Pemberitahuan';

  @override
  String get autoCancelNotificationDescription =>
      'Jika dipilih, pemberitahuan akan ditutup secara automatik apabila pengguna mengetiknya.';

  @override
  String get setDelayTime => 'Tetapkan Masa Tunda';

  @override
  String get proposalDetails => 'Butiran Cadangan';

  @override
  String get proposalNotFound => 'Cadangan tidak ditemui';

  @override
  String get processed => 'Diproses';

  @override
  String get filterAndSortTitle => 'Tapis dan Susun';

  @override
  String get filterVerifiedOwner => 'Tapis Pemilik yang Disahkan';

  @override
  String get filterBy => 'Tapis Mengikut';

  @override
  String get sortOldest => 'Susun Terlama';

  @override
  String get sortNewest => 'Susun Terkini';

  @override
  String get sortMostPopular => 'Susun Paling Popular';

  @override
  String get sortLeastPopular => 'Susun Paling Kurang Popular';

  @override
  String get sortBy => 'Susun Mengikut';

  @override
  String get simRulesNotFound => 'Peraturan SIM tidak ditemui';

  @override
  String get simSlotRules => 'Peraturan Slot SIM';

  @override
  String get noSimCardDetected => 'Tiada kad SIM dikesan';

  @override
  String get invalidSimData => 'Data SIM tidak sah';

  @override
  String get simSlot => 'Slot SIM';

  @override
  String get enableFiltering => 'Dayakan Penapisan';

  @override
  String get detailedSettingsTitle => 'Tetapan Terperinci';

  @override
  String get entryPointViewTitle => 'Pandangan Titik Masuk';

  @override
  String get callTypeRejected => 'Ditolak';

  @override
  String get callTypeSilenced => 'Dibisukan';

  @override
  String andMoreItems(int count) {
    return 'dan $count item lagi';
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
  String get deepLinkPluginDownloadFailed =>
      'Failed to download or parse plugin script';

  @override
  String get deepLinkImportSuccess => '✅ Imported successfully';

  @override
  String deepLinkImportFailed(String error) {
    return 'Import failed: $error';
  }
}
