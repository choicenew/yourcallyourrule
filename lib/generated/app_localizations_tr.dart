// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get aboutContactSubscription => 'İletişim Aboneliği Hakkında';

  @override
  String get aboutLabels => 'Etiketler Hakkında';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Telefon Abonelik Kuralları Hakkında';

  @override
  String get aboutPhoneSubscriptions => 'Telefon Abonelikleri Hakkında';

  @override
  String get aboutPhoneSubscriptionsDesc =>
      'URL aracılığıyla telefon kural listelerine abone olun, kuralları otomatik olarak güncelleyin. JSON, CSV formatında kural dosyalarını destekler.';

  @override
  String get aboutSmsFilter => 'SMS Filtreleme Hakkında';

  @override
  String get aboutSmsSubscriptionRules => 'SMS Abonelik Kuralları Hakkında';

  @override
  String get aboutSubtitle => 'Uygulama sürümü ve yasal bilgiler';

  @override
  String get aboutTitle => 'Hakkında';

  @override
  String get action => 'Eylem';

  @override
  String get actionAll => 'Tümü';

  @override
  String get actionAllow => 'İzin Ver';

  @override
  String get actionBlock => 'Engelle';

  @override
  String get actionFilterAll => 'Tüm Filtre';

  @override
  String get actionFilterTitle => 'Eylem Türüne Göre Filtrele';

  @override
  String get actionFilterTooltip => 'Eylem Filtresi';

  @override
  String get actionNone => 'Eylem Yok';

  @override
  String get actionSilence => 'Sessize Al';

  @override
  String actionTag(Object actionType) {
    return 'Eylem: $actionType';
  }

  @override
  String get actionType => 'Eylem Türü';

  @override
  String get actionUnknown => 'Bilinmiyor';

  @override
  String get add => 'Ekle';

  @override
  String get addAllowedBlockedRule => 'İzin Ver/Engelle Kuralı Ekle';

  @override
  String get addAllowSubscription => 'İzin Ver Aboneliği Ekle';

  @override
  String get addBlockSubscription => 'Engelle Aboneliği Ekle';

  @override
  String get addContactButton => 'Kişi Ekle';

  @override
  String addContactFailed(Object error) {
    return 'Kişi eklenemedi: $error';
  }

  @override
  String get addedToAllowedRules => 'İzin Verilen Kurallara Eklendi';

  @override
  String get addedToBlacklist => 'Engellenenler Listesine Eklendi';

  @override
  String get addedToBlockedRules => 'Engellenen Kurallara Eklendi';

  @override
  String get addedToFavoriteContacts => 'Favori kişilere eklendi';

  @override
  String get addedToFavorites => 'Favorilere eklendi';

  @override
  String get addedToWhitelist => 'Beyaz Listeye Eklendi';

  @override
  String get addFavorite => 'Favori Ekle';

  @override
  String get addFilter => 'Filtre Ekle';

  @override
  String get addLabel => 'Etiket Ekle';

  @override
  String get addLabelButton => 'Etiket Ekle';

  @override
  String addLabelFailed(Object error) {
    return 'Etiket eklenemedi: $error';
  }

  @override
  String get addLabelToCall => 'Çağrı Kaydına Etiket Ekle';

  @override
  String get addName => 'Ad Ekle';

  @override
  String get addNoneSubscription => 'Yok Aboneliği Ekle';

  @override
  String get addOrEditContactInfo =>
      'Kişi bilgilerini eklemek veya düzenlemek için kullanılır';

  @override
  String get addPhoneMark => 'Telefon İşareti Ekle';

  @override
  String get addPhoneNumberRule => 'Telefon Numarası Kuralı Ekle';

  @override
  String get addPlugin => 'Eklenti Ekle';

  @override
  String get addPluginFailed => 'Eklenti eklenemedi';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Eklenti eklenemedi: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Yerel Dosyadan Eklenti Ekle';

  @override
  String get addPluginFromUrl => 'URL\'den Eklenti Ekle';

  @override
  String get addRegexRule => 'Regex Kuralı Ekle';

  @override
  String get addRule => 'Kural Ekle';

  @override
  String get addRuleButton => 'Kural Ekle';

  @override
  String addRuleFailed(Object error) {
    return 'Kural eklenemedi: $error';
  }

  @override
  String get addRuleTooltip => 'Kural Ekle';

  @override
  String get addSilenceSubscription => 'Sessize Alma Aboneliği Ekle';

  @override
  String get addSimRuleButton => 'SIM Kuralı Ekle';

  @override
  String get addSmsFilterRule => 'SMS Filtre Kuralı Ekle';

  @override
  String get addSmsRule => 'SMS Kuralı Ekle';

  @override
  String get addSmsSubscription => 'SMS Aboneliği Ekle';

  @override
  String get addSubscription => 'Abonelik Ekle';

  @override
  String get addSubscriptionButton => 'Abonelik Ekle';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Abonelik eklenemedi: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Abonelik Ekle';

  @override
  String get addToAllowedRules => 'İzin Verilen Kurallara Ekle';

  @override
  String get addToBlacklist => 'Engellenenler Listesine Ekle';

  @override
  String get addToBlockedRules => 'Engellenen Kurallara Ekle';

  @override
  String get addToFavoriteContacts => 'Favori Kişilere Ekle';

  @override
  String get addToFavorites => 'Favorilere Ekle';

  @override
  String get addToRules => 'Kurallara Ekle';

  @override
  String get addToWhitelist => 'Beyaz Listeye Ekle';

  @override
  String get adPlaceholder => 'Reklam Yer Tutucusu';

  @override
  String get agent => 'Aracı';

  @override
  String get all => 'Tümü';

  @override
  String get allCallsTab => 'Tümü';

  @override
  String get allDataClearedSuccessfully => 'Tüm veriler başarıyla temizlendi';

  @override
  String get allow => 'İzin Ver';

  @override
  String get allowAllAllowRules => 'Tüm İzin Kurallarını İzin Ver';

  @override
  String get allowAllAllowRulesDesc =>
      'İzin kurallarından gelen çağrılara izin ver';

  @override
  String get allowAllBlacklistedNumbers => 'Tüm Engellenen Numaralara İzin Ver';

  @override
  String get allowAllBlacklistedNumbersDesc =>
      'Engellenenler listesinden gelen çağrılara izin ver';

  @override
  String get allowAllBlockRules => 'Tüm Engelleme Kurallarını İzin Ver';

  @override
  String get allowAllBlockRulesDesc =>
      'Engelleme kurallarından gelen çağrılara izin ver';

  @override
  String get allowAllowedNumbers => 'İzin Verilen Numaralara İzin Ver';

  @override
  String get allowAllowedNumbersDesc =>
      'Beyaz listeden gelen çağrılara izin ver';

  @override
  String get allowBlock => 'İzin Ver/Engelle';

  @override
  String get allowBlockedNumbers => 'Engellenen Numaralara İzin Ver';

  @override
  String get allowBlockedNumbersDesc =>
      'Engellenenler listesinden gelen çağrılara izin ver';

  @override
  String get allowedBlockedRule => 'İzin Ver/Engelle Kuralı';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'İzin Ver/Engelle Kuralını Düzenle';

  @override
  String get allowedBlockedRuleManagement => 'İzin Ver/Engelle Kuralı Yönetimi';

  @override
  String get allowNonExceededNumbers =>
      'Aşılan Sayıların Dışındakilere İzin Ver';

  @override
  String get allowNonExceededNumbersDescription =>
      'Sayı eşiğini aşmayan numaralara otomatik olarak izin ver';

  @override
  String get allowRegexAllowRules => 'Regex İzin Kurallarına İzin Ver';

  @override
  String get allowRegexAllowRulesDesc =>
      'İzin kuralları için regex deseni eşleştirmeyi etkinleştir';

  @override
  String get allowRegexAllowRulesDescription =>
      'Regex tabanlı izin kurallarını etkinleştir';

  @override
  String get allowRegexBlockRules => 'Regex Engelleme Kurallarına İzin Ver';

  @override
  String get allowRegexBlockRulesDesc =>
      'Engelleme kuralları için regex deseni eşleştirmeyi etkinleştir';

  @override
  String get allowRegexBlockRulesDescription =>
      'Regex tabanlı engelleme kurallarını etkinleştir';

  @override
  String get allowRule => 'İzin Ver Kuralı';

  @override
  String get allowRules => 'İzin Ver Kuralları';

  @override
  String get allowWhitelistedNumbers => 'İzin Verilen Numaralara İzin Ver';

  @override
  String get allowWhitelistedNumbersDescription =>
      'İzin verilen listedeki tüm numaralara izin ver';

  @override
  String get allPermissionsGranted => 'Tüm izinler verildi';

  @override
  String get allSettingsCompleted => 'Tüm ayarlar tamamlandı.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Tüm güncellemeler tamamlandı ($count kural)';
  }

  @override
  String get answerThenHangup => 'Yanıtla sonra kapat';

  @override
  String get appLegalese =>
      '© 2023 Senin Çağrın Senin Kuralın. Tüm hakları saklıdır.';

  @override
  String get applicationSoftware => 'Uygulama Yazılımı';

  @override
  String get apply => 'Uygula';

  @override
  String get appName => 'Senin Çağrın Senin Kuralın';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Yetkilendirme başarısız: Lütfen istemci kimliğini ve anahtarını kontrol edin';

  @override
  String get authorizationFailedMessage => 'Yetkilendirme başarısız';

  @override
  String get authorizationSuccessMessage => 'Yetkilendirme başarılı';

  @override
  String get authorizeLoginButton => 'Girişi Yetkilendir';

  @override
  String get automotiveIndustry => 'Otomotiv Sektörü';

  @override
  String get autoSyncLabel => 'Otomatik Eşitleme';

  @override
  String get autoUpdate => 'Otomatik Güncelleme';

  @override
  String get autoUpdateDescription =>
      'Abonelikler için otomatik güncelleme aralıkları ayarlayın veya manuel olarak güncelleyin';

  @override
  String get autoUpdateSettings => 'Otomatik Güncelleme Ayarları';

  @override
  String get autoUpdateSettingsSubtitle =>
      'Kuralların ve eklentilerin otomatik güncellemelerini yönetin';

  @override
  String get autoUpdateSettingsTitle => 'Otomatik Güncelleme Ayarları';

  @override
  String get autoUpdateSubtitle =>
      'Kuralların ve eklentilerin otomatik güncellemelerini yönetin';

  @override
  String get autoUpdateTitle => 'Otomatik Güncelleme';

  @override
  String get avatarBorderColor => 'Avatar Kenarlık Rengi';

  @override
  String get avatarBorderSize => 'Avatar Kenarlık Boyutu';

  @override
  String get avatarIconSizesSetting => 'Avatar ve Simge Boyutları';

  @override
  String get avatarPosition => 'Avatar Konumu';

  @override
  String get avatarSize => 'Avatar Boyutu';

  @override
  String axisPosition(Object axis) {
    return '$axis Konumu';
  }

  @override
  String get backgroundGradientSetting => 'Arka Plan Gradyan Ayarı';

  @override
  String get backup => 'Yedekle';

  @override
  String get backupAndRestore => 'Yedekle ve Geri Yükle';

  @override
  String get backupAndRestoreSubtitle =>
      'Uygulama verilerini yedekle veya geri yükle';

  @override
  String get backupAndRestoreTitle => 'Yedekle ve Geri Yükle';

  @override
  String get backupFailed => 'Yedekleme başarısız';

  @override
  String get backupFailedMessage => 'Yedekleme başarısız';

  @override
  String backupFailedWithError(Object error) {
    return 'Yedekleme başarısız: $error';
  }

  @override
  String get backupRestoreSubtitle =>
      'Uygulama verilerini yedekle veya geri yükle';

  @override
  String get backupRestoreTitle => 'Yedekle ve Geri Yükle';

  @override
  String get backupSectionTitle => 'Yedekle';

  @override
  String get backupSettings => 'Yedekleme Ayarları';

  @override
  String get backupSettingsDialogTitle => 'Yedekleme Ayarları';

  @override
  String get backupSettingsTitle => 'Yedekleme Ayarları';

  @override
  String get backupSuccessMessage => 'Buluta başarıyla yedeklendi';

  @override
  String backupSuccessToLocal(Object path) {
    return 'Yerel olarak başarıyla yedeklendi: $path';
  }

  @override
  String get backupToCloud => 'Buluta Yedekle';

  @override
  String get backupToCloudDescription =>
      'Ayarları ve kuralları bulut depolama alanına yedekleyin';

  @override
  String backupToCloudFailed(Object error) {
    return 'Buluta yedekleme başarısız: $error';
  }

  @override
  String get backupToCloudLabel => 'Buluta Yedekle';

  @override
  String get backupToCloudSuccess => 'Buluta başarıyla yedeklendi';

  @override
  String get backupToCloudTitle => 'Buluta Yedekle';

  @override
  String get backupToLocalLabel => 'Yerel Olarak Yedekle';

  @override
  String get bank => 'Banka';

  @override
  String get basicInfo => 'Temel Bilgiler';

  @override
  String get basicRuleFilter => 'Temel Kural Filtresi';

  @override
  String get basicRuleFiltering => 'Temel Kural Filtreleme';

  @override
  String get basicRuleFilteringExplanation =>
      '• Temel Kural Filtreleme: Kara liste, izin verilenler listesi ve regex\'e göre kuralları filtreleme';

  @override
  String get basicRuleFilterSettings => 'Temel Kural Filtre Ayarları';

  @override
  String get basicRuleFilterSubtitle =>
      'Kara listeyi/izin verilenleri ve düzenli ifadeleri kullanarak çağrıları filtreleyin';

  @override
  String get batchDeleteContacts => 'Toplu İletişim Sil';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Seçilen $count kişiyi silmek istediğinizden emin misiniz?';
  }

  @override
  String get batchDeleteFailed => 'Toplu silme başarısız';

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Seçilen $count etiketi silmek istediğinizden emin misiniz?';
  }

  @override
  String get blacklist => 'Kara Liste';

  @override
  String get blacklistingAndWhitelisting =>
      'Kara Listeye Alma ve İzin Verilenlere Ekleme';

  @override
  String get blacklistLabel => 'Kara Liste';

  @override
  String get blackWhiteList => 'Kara/İzin Listesi';

  @override
  String get block => 'Engelle';

  @override
  String get blockCalls => 'Çağrıları Engelle';

  @override
  String get blocked => 'Engellendi';

  @override
  String get blockedCallAction => 'Engellenen Çağrı Eylemi';

  @override
  String get blockedCalls => 'Engellenen Çağrılar';

  @override
  String get blockedCallsTitle => 'Engellenen Çağrılar';

  @override
  String get blockedCommunications => 'Engellenen İletişimler';

  @override
  String get blockedPhoneLabel => 'Engellenen Çağrılar';

  @override
  String get blockedSpamCalls => 'Engellenen Spam Çağrıları';

  @override
  String get blockingTrend => 'Engelleme Eğilimi';

  @override
  String get blockInternationalCalls =>
      '+ veya 00 ile başlamayan numaralarla eşleşir';

  @override
  String get blockInternationalCallsTitle => 'Uluslararası Çağrıları Engelle';

  @override
  String get blockLandlineNumbersTitle => 'Sabit Hat Numaralarını Engelle';

  @override
  String get blockMobileNumbers => '13-19 ile başlamayan numaralarla eşleşir';

  @override
  String get blockMobileNumbersTitle => 'Mobil Numaraları Engelle';

  @override
  String get blockPremiumRateNumbers =>
      '118 veya 120-190 ile başlamayan numaralarla eşleşir';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Premium Ücretli Numaraları Engelle';

  @override
  String get blockRule => 'Engelleme Kuralı';

  @override
  String get blockRules => 'Engelleme Kuralları';

  @override
  String get blockSpecificAreaCodes =>
      '0 + 2-3 haneli ile başlayan numaralarla eşleşir';

  @override
  String get blockSpecificAreaCodesTitle => 'Belirli alan kodlarını engelle:';

  @override
  String get blockTypeAnalysisTitle => 'Engelleme Türü Analizi';

  @override
  String get both => 'Her ikisi de';

  @override
  String get bulkDelete => 'Toplu İletişim Sil';

  @override
  String get bulkDeleteContacts => 'Toplu İletişim Sil';

  @override
  String get bulkDeleteLabels => 'Toplu Etiket Sil';

  @override
  String get call => 'Çağrı';

  @override
  String get callback => 'Geri Çağır';

  @override
  String callbackTo(String number) {
    return '$number numarasına geri çağır';
  }

  @override
  String get callBlocking => 'Çağrı Engelleme';

  @override
  String get callerIdApp => 'Arayan Kimliği Uygulaması';

  @override
  String get callerIdCustomizationTitle => 'Arayan Kimliğini Özelleştir';

  @override
  String get callerIdDialogTitle => 'Arayan Kimliği Bilgisi';

  @override
  String get callerIdDisplayMode => 'Arayan Kimliği Görüntüleme Modu';

  @override
  String callerIdMarkedByCount(Object count) {
    return '$count Tarafından İşaretlendi';
  }

  @override
  String get callerIdPreview => 'Arayan Kimliği Önizlemesi';

  @override
  String get callFilter => 'Çağrı Filtresi';

  @override
  String get callFilterDescription =>
      'Etkinleştirildiğinde, gelen aramalar aşağıdaki kural listesine karşı kontrol edilir. Çağrı filtreleme kuralları varsayılan olarak cihazlar arasında eşitlenmez.';

  @override
  String get callFilterRules => 'Çağrı Filtresi Kuralları';

  @override
  String get callFilterRulesDescription =>
      'Çağrı filtreleme için temel kurallar belirleyin';

  @override
  String get callFilterSettings => 'Çağrı Filtresi Ayarları';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Çağrı frekansı sınırlarını ve engelleme kurallarını ayarlayın';

  @override
  String get callFrequencyInterceptionTitle => 'Çağrı Frekansı Engellemesi';

  @override
  String get callHistory => 'Çağrı Geçmişi';

  @override
  String get callHistoryInfoDesc =>
      'Gelen, giden ve cevapsız çağrıları içeren çağrı geçmişiniz burada gösterilir.';

  @override
  String get callHistoryInfoTitle => 'Çağrı Geçmişi';

  @override
  String callHistoryInitFailed(Object error) {
    return 'Çağrı geçmişi başlatılamadı: $error';
  }

  @override
  String callHistoryRefreshFailed(Object error) {
    return 'Çağrı geçmişi yenilenemedi: $error';
  }

  @override
  String get callHistoryTab => 'Çağrı Geçmişi';

  @override
  String get callHistoryTimelineEarlier => 'Daha Önce';

  @override
  String get callHistoryTimelineToday => 'Bugün';

  @override
  String get callHistoryTimelineYesterday => 'Dün';

  @override
  String get callScreeningPermission => 'Çağrı Tarama İzni';

  @override
  String get callScreeningPermissionDescription =>
      'İstenmeyen aramaları taramak ve engellemek için kullanılır.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Çağrı tarama izni verilmedi, uygulama işlevselliğini etkileyebilir.';

  @override
  String get callSettingsSubtitle =>
      'Arayan Kimliği, filtreleme ve engelleme ayarları';

  @override
  String get callSettingsTitle => 'Çağrı Ayarları';

  @override
  String get callStatistics => 'Çağrı İstatistikleri';

  @override
  String get callTypeAnswered => 'Cevaplandı';

  @override
  String get callTypeBlocked => 'Engellendi';

  @override
  String get callTypeIconColor => 'Çağrı Tipi Simge Rengi';

  @override
  String get callTypeMissed => 'Cevapsız Çağrı';

  @override
  String get callTypeOutgoing => 'Giden';

  @override
  String get callTypePosition => 'Çağrı Tipi Konumu';

  @override
  String get callTypeUnknown => 'Bilinmeyen';

  @override
  String get cancelButton => 'İptal';

  @override
  String get carRental => 'Araba Kiralama';

  @override
  String get carrier => 'Operatör';

  @override
  String get carrierColor => 'Operatör Rengi';

  @override
  String get carrierFontSize => 'Operatör Yazı Tipi Boyutu';

  @override
  String get carrierPosition => 'Operatör Konumu';

  @override
  String get changeLabel => 'Etiketi Değiştir';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Eklenti durumu değiştirilemedi: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Abonelik durumu değiştirilemedi: $error';
  }

  @override
  String get changeTag => 'Etiketi Değiştir';

  @override
  String get charity => 'Bağış';

  @override
  String chartMonthFormat(int month) {
    return 'Ay $month';
  }

  @override
  String get chartOneDayAgo => '1 gün önce';

  @override
  String get chartOneMonthAgo => '1 ay önce';

  @override
  String get chartOneWeekAgo => '1 hafta önce';

  @override
  String get chartTenDaysAgo => '10 gün önce';

  @override
  String get chartThreeDaysAgo => '3 gün önce';

  @override
  String get chartToday => 'Bugün';

  @override
  String get checkFileFormat =>
      'Lütfen dosya biçimini veya izinleri kontrol edin';

  @override
  String checkPermissionFailed(Object error) {
    return 'İzinler kontrol edilemedi: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Varsayılan engelleme eylemini seçin';

  @override
  String get clearAllData => 'Tüm Verileri Temizle';

  @override
  String get clearAllDataConfirmation =>
      'Tüm uygulama verilerini temizlemek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get clearAllDataDescription => 'Tüm uygulama verilerini temizle';

  @override
  String get clearAllDataLabel => 'Tüm Verileri Temizle';

  @override
  String get clearFilter => 'Filtreyi Temizle';

  @override
  String get clearLabelFilter => 'Etiket Filtresini Temizle';

  @override
  String get clearLabelFilterButton => 'Etiket Filtresini Temizle';

  @override
  String get closeButton => 'Kapat';

  @override
  String get cloudSync => 'Bulut Senkronizasyonu';

  @override
  String get cloudSyncAndBackupTitle => 'Bulut Senkronizasyonu ve Yedekleme';

  @override
  String get cloudSyncSettingsSubtitle =>
      'WebDAV, OneDrive ve Google Drive\'ı yapılandırın';

  @override
  String get cloudSyncSettingsTitle => 'Bulut Senkronizasyonu Ayarları';

  @override
  String get cloudSyncTitle => 'Bulut Senkronizasyonu';

  @override
  String get collapseLabelSelector => 'Etiket Seçiciyi Daralt';

  @override
  String get collection => 'Borç Tahsilatı';

  @override
  String get colorPickerTitle => 'Renk Seçin';

  @override
  String get configManagement => 'Yapılandırma Yönetimi';

  @override
  String get configUpdated => 'Yapılandırma güncellendi';

  @override
  String get configurationAdvice =>
      'Doğru yapılandırma ile iş ve kişisel SIM kartlar için farklı filtreleme stratejileri belirleyebilirsiniz.';

  @override
  String get configureBackupOptions => 'Yedekleme Seçeneklerini Yapılandır';

  @override
  String get configureBackupOptionsSubtitle =>
      'Yedekleme seçeneklerini yapılandırın';

  @override
  String get configureCloudSyncService =>
      'Bulut Senkronizasyon Hizmetini Yapılandır';

  @override
  String get configureCloudSyncServiceHint =>
      'Çoklu cihaz senkronizasyonunu etkinleştirmek için lütfen bir bulut senkronizasyon hizmeti yapılandırın.';

  @override
  String get configureCloudSyncServiceMessage =>
      'Çoklu cihaz senkronizasyonunu etkinleştirmek için lütfen bir bulut senkronizasyon hizmeti yapılandırın.';

  @override
  String get configureSimCardFilterRules =>
      'SIM Kart Filtre Kurallarını Yapılandırın';

  @override
  String get configureSyncServiceHint =>
      'Lütfen önce bulut senkronizasyonu ayarlarında senkronizasyon hizmetini yapılandırın';

  @override
  String get confirm => 'Onayla';

  @override
  String get confirmBatchDeleteContacts =>
      'Seçilenleri silmek istediğinizden emin misiniz';

  @override
  String get confirmButton => 'Onayla';

  @override
  String get confirmDelete => 'Silmeyi Onayla';

  @override
  String get confirmDeleteContact => 'Silmek istediğinizden emin misiniz';

  @override
  String get confirmDeleteContactName => 'Silmeyi onayla?';

  @override
  String get confirmDeleteFilter =>
      'Bu filtreyi silmek istediğinizden emin misiniz?';

  @override
  String confirmDeleteLabel(Object name) {
    return '\"$name\" etiketini silmek istediğinizden emin misiniz';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return '\"$name\" eklentisini silmek istediğinizden emin misiniz?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return '$count eklentiyi silmek istediğinizden emin misiniz?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Bu kuralı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get confirmDeleteSelectedContacts =>
      'Seçilen kişileri silmek istediğinizden emin misiniz?';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Bu SMS filtre kuralını silmek istediğinizden emin misiniz?';

  @override
  String get confirmDeleteSmsRule =>
      'Bu SMS kuralını silmek istediğinizden emin misiniz?';

  @override
  String get confirmDeleteSubscription =>
      'Bu aboneliği silmek istediğinizden emin misiniz?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return '\"$name\" silmek istediğinizden emin misiniz?';
  }

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get confirmPasswordLabel => 'Şifreyi Onayla';

  @override
  String get connectedStatus => 'Bağlandı';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Bağlantı başarısız: Lütfen sunucu adresini, kullanıcı adını ve şifreyi kontrol edin';

  @override
  String get connectionFailedMessage => 'Bağlantı başarısız';

  @override
  String get connectionStatusLabel => 'Bağlantı Durumu';

  @override
  String get connectionSuccessMessage => 'Bağlantı başarılı';

  @override
  String get contactAddSuccess => 'Kişi başarıyla eklendi';

  @override
  String get contactDeleted => 'Kişi silindi';

  @override
  String get contactEditDialog => 'Kişi Düzenleme Diyaloğu';

  @override
  String get contactNameHint => 'Kişi adı girin (isteğe bağlı)';

  @override
  String get contactNameLabel => 'Ad';

  @override
  String get contactNameOptional => 'Kişi adı (isteğe bağlı)';

  @override
  String get contactNotFound => 'Kişi bulunamadı';

  @override
  String get contacts => 'Kişiler';

  @override
  String contactsDeleted(Object count) {
    return '$count kişi silindi';
  }

  @override
  String get contactSettingsSubtitle => 'Kişi yönetimi ve etiket ayarları';

  @override
  String get contactSettingsTitle => 'Kişi Ayarları';

  @override
  String contactsLoadingFailed(Object error) {
    return 'Kişiler yüklenemedi: $error';
  }

  @override
  String get contactsManagement => 'Kişiler Yönetimi';

  @override
  String get contactsManagementPageTitle => 'Kişiler Yönetimi Sayfası';

  @override
  String get contactsPageTitle => 'Kişiler Yönetimi';

  @override
  String get contactsPermission => 'Kişi İzni';

  @override
  String get contactsPermissionDescription =>
      'Arayan kişileri tanımlamak için kullanılır.';

  @override
  String get contactsTab => 'Kişiler';

  @override
  String get contactSubscriptionDescription =>
      'URL aracılığıyla kişi listelerine abone olun, kişi bilgilerini ve etiketlerini otomatik olarak güncelleyin. JSON formatındaki verileri destekler.';

  @override
  String contactSubscriptionLoadingFailed(Object error) {
    return 'Kişi abonelikleri yüklenemedi: $error';
  }

  @override
  String get contactSubscriptionPageTitle => 'Kişi Abonelikleri';

  @override
  String get contactUpdateSuccess => 'Kişi başarıyla güncellendi';

  @override
  String get contactUs => 'Bize Ulaşın';

  @override
  String get content => 'İçerik';

  @override
  String get contentRegex => 'İçerik Regex\'i';

  @override
  String get countColor => 'Sayım Rengi';

  @override
  String get countFontSize => 'Sayım Yazı Tipi Boyutu';

  @override
  String get countPosition => 'Sayım Konumu';

  @override
  String get country => 'Ülke';

  @override
  String get countryNameColor => 'Ülke Adı Rengi';

  @override
  String get countryNameFontSize => 'Ülke Adı Yazı Tipi Boyutu';

  @override
  String get countryRegionNamePosition => 'Ülke/Bölge Adı Konumu';

  @override
  String get countrySelectionDialog => 'Ülke Seçim Diyaloğu';

  @override
  String get countrySelectionDialogDescription =>
      'Arayan kimliği bilgilerini sorgulamak için bir ülke seçmek için kullanılır';

  @override
  String get countThresholdDescription =>
      'Filtreleme eylemlerini tetiklemek için gereken minimum sayım eşiğini ayarlayın';

  @override
  String get countThresholdLabel => 'Sayım Eşiği';

  @override
  String get countThresholdSettings => 'Sayım Eşiği Ayarları';

  @override
  String countThresholdValue(Object count) {
    return 'Sayım Eşiği: $count';
  }

  @override
  String get createdRules => 'Oluşturulan Kurallar';

  @override
  String get csvFormat => 'CSV Formatı';

  @override
  String get currentDeviceChip => 'Mevcut';

  @override
  String get currentDeviceLabel => 'Mevcut Cihaz Etiketi';

  @override
  String get currentDeviceTitle => 'Mevcut Cihaz';

  @override
  String get currentLabels => 'Mevcut Etiketler:';

  @override
  String get currentLanguage => 'Mevcut Dil';

  @override
  String get currentPasswordLabel => 'Mevcut Parola';

  @override
  String get customerService => 'Müşteri Hizmetleri';

  @override
  String get customRange => 'Özel Aralık';

  @override
  String get dailyStatistics => 'Günlük İstatistikler';

  @override
  String get dailyStatisticsDesc =>
      'Engellenen aramalar ve mesajlar hakkında günlük istatistikler alın';

  @override
  String get dashboardTab => 'Kontrol Paneli';

  @override
  String get dataAnalysis => 'Veri Analizi';

  @override
  String get dataAnalysisDashboardPage => 'Veri Analizi Kontrol Paneli Sayfası';

  @override
  String get dataExport => 'Veri Dışa Aktarma';

  @override
  String dataLoadFailure(Object error) {
    return 'Veri yükleme başarısız oldu: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Veri yüklenemedi: $error';
  }

  @override
  String get dataMigration => 'Veri Taşıma';

  @override
  String get dataMigrationDescription =>
      'Bu özellik, tüm verilerinizi cihazlar arasında aktarmanıza olanak tanır. Şu anda, verilerinizi manuel olarak taşımak için yedekleme ve geri yükleme özelliklerini kullanabilirsiniz.';

  @override
  String get dataMigrationDialogContent =>
      'Bu özellik, tüm verilerinizi cihazlar arasında aktarmanıza olanak tanır. Şu anda, verilerinizi manuel olarak taşımak için yedekleme ve geri yükleme özelliklerini kullanabilirsiniz.';

  @override
  String get dataMigrationDialogTitle => 'Veri Taşıma';

  @override
  String get dataMigrationSectionTitle => 'Veri Taşıma';

  @override
  String get dataSourceReminder => 'Veri Kaynağı Hatırlatıcısı';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün',
      one: '1 gün',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Gün VIP';
  }

  @override
  String get debtCollection => 'Borç Tahsilatı';

  @override
  String get defaultPeriod => 'Hafta';

  @override
  String get delete => 'Sil';

  @override
  String get deleteButton => 'Sil';

  @override
  String get deleteContact => 'Kişiyi Sil';

  @override
  String deleteContactConfirm(Object name) {
    return '$name kişisini silmek istediğinizden emin misiniz?';
  }

  @override
  String get deleteContactConfirmation =>
      'Kişiyi silmek istediğinizden emin misiniz';

  @override
  String deleteDeviceConfirmation(Object deviceName) {
    return '$deviceName cihazını silmek istediğinizden emin misiniz?';
  }

  @override
  String get deleteDeviceDialogTitle => 'Cihazı Sil';

  @override
  String deleteFailed(Object error) {
    return 'Silme başarısız oldu: $error';
  }

  @override
  String get deleteFilter => 'Filtreyi Sil';

  @override
  String get deleteLabel => 'Etiketi Sil';

  @override
  String deleteLabelFailed(Object error) {
    return 'Etiket silme başarısız oldu: $error';
  }

  @override
  String get deletePlugin => 'Eklentiyi Sil';

  @override
  String deletePluginFailed(Object error) {
    return 'Eklenti silme başarısız oldu: $error';
  }

  @override
  String get deletePlugins => 'Eklentileri Sil';

  @override
  String deletePluginsFailed(Object error) {
    return 'Eklentiler silme başarısız oldu: $error';
  }

  @override
  String get deleteRule => 'Kuralı Sil';

  @override
  String deleteRuleFailed(Object error) {
    return 'Silme başarısız oldu: $error';
  }

  @override
  String get deleteSelected => 'Seçilenleri Sil';

  @override
  String get deleteSmsRule => 'SMS Kuralını Sil';

  @override
  String get deleteSubscription => 'Aboneliği Sil';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return '\"$name\" aboneliğini silmek istediğinizden emin misiniz?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Abonelik silme başarısız oldu: $error';
  }

  @override
  String get deleteSuccess => 'Silme başarılı';

  @override
  String get delivery => 'Teslimat';

  @override
  String get deviceDeletedSuccessfully => 'Cihaz başarıyla silindi';

  @override
  String get deviceDeletedSuccessfullyMessage => 'Cihaz başarıyla silindi';

  @override
  String get deviceIdLabel => 'Cihaz Kimliği';

  @override
  String get deviceIDLabel => 'Cihaz Kimliği';

  @override
  String get deviceManagementSubtitle =>
      'Çoklu cihaz senkronizasyonunu yönetin';

  @override
  String get deviceManagementTitle => 'Cihaz Yönetimi';

  @override
  String get deviceModelLabel => 'Cihaz Modeli';

  @override
  String get deviceName => 'Cihaz Adı';

  @override
  String get deviceNameCannotBeEmpty => 'Cihaz adı boş olamaz';

  @override
  String get deviceNameHint => 'Lütfen cihaz adını girin';

  @override
  String get deviceNameLabel => 'Cihaz Adı';

  @override
  String get deviceRenamedSuccessfully =>
      'Cihaz başarıyla yeniden adlandırıldı';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Cihaz başarıyla yeniden adlandırıldı';

  @override
  String get devicesSyncedSuccessfully =>
      'Cihazlar başarıyla senkronize edildi';

  @override
  String get devicesSyncedSuccessfullyMessage =>
      'Cihazlar başarıyla senkronize edildi';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Cihazlar başarıyla senkronize edildi';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Cihaz başarıyla kayıttan çıkarıldı';

  @override
  String get dialogTitle => 'Regex Deseni Açıklaması';

  @override
  String get differentFromLocalCounter =>
      'Bu özellik, uzun vadeli işaretleme sayımları yerine kısa sürede tekrarlanan arama kalıplarına odaklandığı için yerel sayaç filtresinden farklıdır.';

  @override
  String get disabled => 'Devre Dışı';

  @override
  String get disabledStatus => 'Devre Dışı';

  @override
  String get disableGlobalPlugins => 'Genel eklentileri devre dışı bırak';

  @override
  String get disableSubscriptionSuccessfully =>
      'Abonelik başarıyla devre dışı bırakıldı';

  @override
  String get disconnectButton => 'Bağlantıyı Kes';

  @override
  String get disconnectedMessage => 'Bağlantı Kesildi';

  @override
  String get disconnectedStatus => 'Bağlantı Kesildi';

  @override
  String get disconnectFailedMessage => 'Bağlantı kesme başarısız oldu';

  @override
  String get done => 'Bitti';

  @override
  String get dualSimAdvice =>
      'Bu özellik, çift SIM\'li telefonlar için iş ve kişisel SIM kartlar için farklı filtreleme stratejileri belirlemek üzere özellikle kullanışlıdır.';

  @override
  String get earlier => 'Daha Önce';

  @override
  String get ecommerce => 'E-ticaret';

  @override
  String get edit => 'Düzenle';

  @override
  String get editContact => 'Kişiyi Düzenle';

  @override
  String get editFilter => 'Filtreyi Düzenle';

  @override
  String get editLabel => 'Etiketi Düzenle';

  @override
  String get editPhoneRule => 'Telefon Kuralını Düzenle';

  @override
  String get editPhoneRules => 'Telefon kurallarını düzenlemek için kullanılır';

  @override
  String get editPhoneRuleTitle => 'Telefon Kuralını Düzenle';

  @override
  String get editRule => 'Kuralı Düzenle';

  @override
  String get editSmsRule => 'SMS Kuralını Düzenle';

  @override
  String get education => 'Eğitim';

  @override
  String get elementPositionsSetting => 'Öğe Konumları';

  @override
  String get email => 'E-posta';

  @override
  String get emailOptional => 'E-posta (İsteğe Bağlı)';

  @override
  String get enableCallFilter => 'Arama Filtresini Etkinleştir';

  @override
  String get enableCallFilterDescription =>
      'Etkinleştirildiğinde, gelen aramalar aşağıdaki kural listesine göre kontrol edilir. Arama filtreleme kuralları varsayılan olarak cihazlar arasında eşitlenmez.';

  @override
  String get enabled => 'Etkin';

  @override
  String get enabledStatus => 'Etkin';

  @override
  String get enableEncryption => 'Şifrelemeyi Etkinleştir';

  @override
  String get enableEncryptionDescription => 'Yedekleme dosyalarını şifrele';

  @override
  String get enableEncryptionLabel => 'Şifrelemeyi Etkinleştir';

  @override
  String get enableEncryptionSubtitle => 'Yedekleme dosyaları şifrelenecektir';

  @override
  String get enableEncryptionTitle => 'Şifrelemeyi Etkinleştir';

  @override
  String get enableGlobalPlugins => 'Genel eklentileri etkinleştir';

  @override
  String get enableLocalCountFilter => 'Yerel Sayım Filtresini Etkinleştir';

  @override
  String get enableLocalCountFilterDescription =>
      'Arama işaretleme sayısına göre spam aramaları otomatik olarak filtrele';

  @override
  String get enableLocalNotification => 'Yerel Bildirim Kullan';

  @override
  String get enableLocalNotificationDescription =>
      'Etkinleştirildiğinde, filtrelenmiş mesajlar için bildirimler cihazda görüntülenecektir';

  @override
  String get enableLocationSummary => 'Konum';

  @override
  String get enableMuteRules => 'Sessiz Kuralları Etkinleştir';

  @override
  String get enableMuteRulesDesc =>
      'Sessiz engelleme kuralları yapılandırmasını uygula';

  @override
  String get enableNoneActionRules => 'Hiçbir Eylem Kuralı Yok Etkinleştir';

  @override
  String get enableNoneActionRulesDesc =>
      'Hiçbir engelleme eylemi olmayan kural yapılandırmalarına izin ver';

  @override
  String get enableNotifications => 'Bildirimleri Etkinleştir';

  @override
  String get enableRemoteNumberFilter => 'Uzak Numara Filtresini Etkinleştir';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Numaraları filtrelemek için uzak veritabanını kullan';

  @override
  String get enableRule => 'Kuralı Etkinleştir';

  @override
  String get enableSmsFilter => 'SMS Filtrelemeyi Etkinleştir';

  @override
  String get enableSmsFilterDescription =>
      'Etkinleştirildiğinde, mesajlar kurallara göre otomatik olarak filtrelenecektir';

  @override
  String get enableStatisticsNotifications =>
      'İstatistik Bildirimlerini Etkinleştir';

  @override
  String get enableSubscriptionSuccessfully =>
      'Abonelik başarıyla etkinleştirildi';

  @override
  String get enableTimeInterception => 'Zaman Engellemeyi Etkinleştir';

  @override
  String get enableTimeInterceptionDescription =>
      'Kısa bir süre içinde tekrarlanan aramaları engelle';

  @override
  String get enableTimeInterceptor => 'Zaman Engelleyiciyi Etkinleştir';

  @override
  String get endCallImmediately => 'Çağrıyı Hemen Sonlandır';

  @override
  String get endColor => 'Bitiş Rengi';

  @override
  String get endDate => 'Bitiş Tarihi';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Gelişmiş Filtre Sistemi Talimatları';

  @override
  String get enhancedFilterSettings => 'Gelişmiş Filtre Ayarları';

  @override
  String get enhancedFilterSettingsTitle => 'Gelişmiş Filtre Ayarları';

  @override
  String get enhancedFilterSystemDescription =>
      'Gelişmiş filtre sistemi, hem genel kuralları hem de SIM kart başına filtreleme yapılandırmalarını destekler.';

  @override
  String get enterBothPhoneNumberAndRegexPattern =>
      'Lütfen hem telefon numarasını hem de regex desenini girin';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Lütfen hem telefon numarasını hem de regex desenini girin.';

  @override
  String get enterContactName => 'Lütfen kişi adını girin';

  @override
  String get enterCurrentPasswordHint => 'Lütfen mevcut şifreyi girin';

  @override
  String get enterDeviceName => 'Cihaz Adını Girin';

  @override
  String get enterDeviceNameHint => 'Lütfen cihaz adını girin';

  @override
  String get enterEmail => 'Lütfen e-postayı girin';

  @override
  String get enterEmailOptional => 'Lütfen e-postayı girin (isteğe bağlı)';

  @override
  String get enterEncryptionPasswordHint => 'Şifreleme şifresini girin';

  @override
  String get enterEncryptionPasswordTitle => 'Şifreleme Şifresini Girin';

  @override
  String get enterFilterName => 'Lütfen filtre adını girin';

  @override
  String get enterFilterPattern => 'Lütfen filtre desenini girin';

  @override
  String get enterIconCode => 'Simge kodunu girin';

  @override
  String get enterName => 'Lütfen kişi adını girin';

  @override
  String get enterNewDeviceNameHint => 'Bu cihaza yeni bir ad girin';

  @override
  String get enterNewPasswordHint => 'Lütfen yeni şifreyi girin';

  @override
  String get enterPasswordAgain => 'Şifreyi Tekrar Girin';

  @override
  String get enterPasswordHint => 'Lütfen şifreyi girin';

  @override
  String get enterPhoneNumber => 'Telefon Numarasını Girin';

  @override
  String get enterPhoneNumberHint => 'Test etmek için telefon numarasını girin';

  @override
  String get enterPhoneNumberMultiple =>
      'Lütfen telefon numarasını girin, birden fazla numara virgülle ayrılır';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Aramayı başlatmak için telefon numarasını girin';

  @override
  String get enterPhoneNumberToVerify =>
      'Doğrulamak için telefon numarasını girin';

  @override
  String get enterPluginName => 'Eklenti Adını Girin';

  @override
  String get enterPluginUrl => 'Eklenti URL adresini girin';

  @override
  String get enterRegexHint => 'Regex desenini girin';

  @override
  String get enterRuleNameAndPattern => 'Lütfen kural adını ve desenini girin';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Lütfen hem kural adı hem de regex deseni girin.';

  @override
  String get enterRuleNameHint => 'Kural adı girin';

  @override
  String get enterSearchContent => 'Lütfen arama içeriğini girin';

  @override
  String get enterSubscriptionName => 'Abonelik adı girin';

  @override
  String get enterSubscriptionUrl => 'Abonelik URL\'sini girin';

  @override
  String get enterSyncFolderNameHint =>
      'Lütfen senkronizasyon klasörü adını girin (varsayılan: NotificationManager)';

  @override
  String get entertainment => 'Eğlence';

  @override
  String get enterValidNameAndUrl => 'Lütfen geçerli bir ad ve URL girin';

  @override
  String get enterValidUrl => 'Lütfen geçerli bir URL girin';

  @override
  String get enterVersion => 'Sürümü girin';

  @override
  String get enterWebDAVPasswordHint => 'Lütfen WebDAV parolasını girin';

  @override
  String get enterWebDAVServerAddressHint =>
      'Lütfen WebDAV sunucu adresini girin';

  @override
  String get enterWebDAVUsernameHint => 'Lütfen WebDAV kullanıcı adını girin';

  @override
  String errorDeletingDeviceMessage(Object error) {
    return 'Cihaz silinirken hata oluştu: $error';
  }

  @override
  String get errorLoadingPlugin => 'Eklenti yüklenirken hata oluştu';

  @override
  String errorOccurredMessage(Object error) {
    return 'Bir hata oluştu: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Cihaz yeniden adlandırılırken hata oluştu: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Cihazların senkronizasyonunda hata oluştu: $error';
  }

  @override
  String errorSyncingDevicesMessage(Object error) {
    return 'Cihazların senkronizasyonunda hata oluştu: $error';
  }

  @override
  String get errorText => 'Hata';

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Cihaz kaydı kaldırılırken hata oluştu: $error';
  }

  @override
  String get exampleBlock400Prefix => 'Örn. 400 önek numaralarını engelle';

  @override
  String get exampleBlockMarketingSms => 'Örn. Pazarlama SMS\'lerini engelle';

  @override
  String get exampleContentRegex => 'Örn., .*teklif.*';

  @override
  String get exampleContentRegexHint => 'Örnek İçerik Regex';

  @override
  String get exampleCouponPromotionDiscount =>
      'Örn. .*(kupon|promosyon|indirim).*';

  @override
  String get exampleFamilyFriends => 'Örn. Aile, Arkadaşlar vb.';

  @override
  String get examplePhoneNumber => 'Örn. 10086, 12345 vb.';

  @override
  String get exampleRegex400Prefix => '400 öneki için örnek regex';

  @override
  String get exampleRegexFormat => 'Örnek: ^10086\$ formatı';

  @override
  String get exampleSenderRegexHint => 'Örnek';

  @override
  String get exchange => 'Takas';

  @override
  String get exchangeNow => 'Şimdi Takas Et';

  @override
  String get exchangeVip => 'VIP Takas';

  @override
  String get expandLabelSelector => 'Etiket Seçiciyi Genişlet';

  @override
  String expiryTime(Object time) {
    return 'Süre sonu zamanı: $time';
  }

  @override
  String get export => 'Dışa Aktar';

  @override
  String get exportAllApplicationSettings =>
      'Tüm uygulama ayarlarını dışa aktar';

  @override
  String get exportAllApplicationSettingsSubtitle =>
      'Tüm uygulama ayarlarını dışa aktar';

  @override
  String get exportAllRuleConfigurations =>
      'Tüm kural yapılandırmalarını dışa aktar';

  @override
  String get exportAllRuleConfigurationsSubtitle =>
      'Tüm kural yapılandırmalarını dışa aktar';

  @override
  String get exportComplete => 'Dışa Aktarma Tamamlandı';

  @override
  String get exportConfig => 'Yapılandırmayı Dışa Aktar';

  @override
  String get exportContacts => 'Kişileri Dışa Aktar';

  @override
  String get exportData => 'Verileri Dışa Aktar';

  @override
  String get exportError => 'Dışa Aktarma Hatası';

  @override
  String get exportFailed => 'Dışa Aktarma Başarısız';

  @override
  String get exportFailure => 'Yapılandırma dışa aktarılamadı';

  @override
  String get exportFeatureComingSoon => 'Dışa aktarma özelliği yakında gelecek';

  @override
  String get exporting => 'Dışa Aktarılıyor...';

  @override
  String get exportLabels => 'Etiketleri Dışa Aktar';

  @override
  String exportLabelsFailed(Object error) {
    return 'Etiketler dışa aktarılamadı: $error';
  }

  @override
  String get exportPluginList => 'Eklenti Listesini Dışa Aktar';

  @override
  String exportPluginListFailed(Object error) {
    return 'Eklenti listesi dışa aktarılamadı: $error';
  }

  @override
  String get exportRules => 'Kuralları Dışa Aktar';

  @override
  String get exportRulesDialogTitle => 'Kuralları Dışa Aktar';

  @override
  String get exportRulesTitle => 'Kuralları Dışa Aktar';

  @override
  String get exportSmsRules => 'SMS Kurallarını Dışa Aktar';

  @override
  String get exportStatisticsData => 'İstatistik Verilerini Dışa Aktar';

  @override
  String get exportSuccess => 'Dışa Aktarma Başarılı';

  @override
  String get exportSuccesslly => 'Yapılandırma başarıyla dışa aktarıldı';

  @override
  String get failedToAddContact => 'Kişi eklenemedi';

  @override
  String failedToAddRule(Object error) {
    return 'Kural eklenemedi: $error';
  }

  @override
  String failedToAddSmsRule(Object error) {
    return 'SMS kuralı eklenemedi: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'SMS aboneliği eklenemedi: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Ayarlar yedeklenemedi: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Yedekleme dosyası şifresi çözülemedi';

  @override
  String get failedToDeleteDevice => 'Cihaz silinemedi';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'SMS kuralı silinemedi: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Kurallar dışa aktarılamadı: $error';
  }

  @override
  String failedToExportSmsRules(Object error) {
    return 'SMS kuralları dışa aktarılamadı: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Arayan kimliği bilgileri alınamadı: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Kurallar içe aktarılamadı: $error';
  }

  @override
  String failedToImportSmsRules(Object error) {
    return 'SMS kuralları içe aktarılamadı: $error';
  }

  @override
  String get failedToLoadContacts => 'Kişiler yüklenemedi';

  @override
  String get failedToLoadPlugin => 'Eklenti yüklenemedi';

  @override
  String get failedToRenameDevice => 'Cihaz yeniden adlandırılamadı';

  @override
  String get failedToRestoreSettings => 'Ayarlar geri yüklenemedi';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Ayarlar geri yüklenemedi: $error';
  }

  @override
  String failedToSetPassword(Object error) {
    return 'Parola ayarlanamadı: $error';
  }

  @override
  String get failedToSyncDevices => 'Cihazlar senkronize edilemedi';

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Kural durumu değiştirilemedi: $error';
  }

  @override
  String get failedToToggleSubscriptionStatus =>
      'Abonelik durumu değiştirilemedi';

  @override
  String get failedToUpdateContact => 'Kişi güncellenemedi';

  @override
  String failedToUpdateSmsRule(Object error) {
    return 'SMS kuralı güncellenemedi: $error';
  }

  @override
  String get failure => 'Başarısızlık';

  @override
  String get favoriteContacts => 'Favori Kişiler';

  @override
  String get featureAddRules => '• Numaraya özel kurallar ekleme';

  @override
  String get featureCenter => 'Özellik Merkezi';

  @override
  String get featureEnableDisable =>
      '• SIM başına farklı filtreleri etkinleştirme/devre dışı bırakma';

  @override
  String get featureListTitle => 'Özellikler:';

  @override
  String get featureManageRules => '• SIM başına kural listelerini yönetme';

  @override
  String get features => 'Özellikler';

  @override
  String get fetchingCallerIdInfo => 'Arayan kimliği bilgileri alınıyor...';

  @override
  String fileSavedTo(Object path) {
    return 'Dosya şuraya kaydedildi: $path';
  }

  @override
  String get filter => 'Filtrele';

  @override
  String get filterByLabel => 'Etikete Göre Filtrele';

  @override
  String get filterClear => 'Filtreyi Temizle';

  @override
  String get filterControlPanelTitle => 'Filtre Kontrol Paneli';

  @override
  String get filterControlSubtitle =>
      'Tüm filtrelerin açık/kapalı durumunu yönetin';

  @override
  String get filterControlTitle => 'Filtre Kontrolü';

  @override
  String get filterDeleteFailed => 'Filtre silme başarısız';

  @override
  String get filterDeleteSuccess => 'Filtre başarıyla silindi';

  @override
  String get filterDetails => 'Filtre Detayları';

  @override
  String get filtered => 'Filtrelenmiş';

  @override
  String get filteredSms => 'Filtrelenmiş SMS';

  @override
  String get filteredSmsLabel => 'Filtrelenmiş SMS';

  @override
  String get filterExplanation => 'Filtre Açıklaması';

  @override
  String get filterManagement => 'Filtre Yönetimi';

  @override
  String get filterName => 'Filtre Adı';

  @override
  String get filterPattern => 'Filtre Deseni';

  @override
  String get filterPriorityNote =>
      'Not: Filtreler arasında öncelik ilişkileri vardır, detaylar için yardım belgelerine bakınız.';

  @override
  String get filterSaveFailed => 'Filtre kaydetme başarısız';

  @override
  String get filterSaveSuccess => 'Filtre başarıyla kaydedildi';

  @override
  String get filterSettings => 'Filtre Ayarları';

  @override
  String get filterSettingsTitle => 'Filtre Ayarları';

  @override
  String get filterSMS => 'SMS Filtrele';

  @override
  String get filterToggleInstructions =>
      'Bu SIM yuvası için filtreleri etkinleştirin veya devre dışı bırakın:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return '$status filtre: $filterName';
  }

  @override
  String get filterType => 'Filtre Türü';

  @override
  String get financial => 'Finansal';

  @override
  String get flexibleCombinationFeature =>
      '• Esnek Kombinasyonlar: SIM yuvası başına filtreleri etkinleştir/devre dışı bırak';

  @override
  String get fontSizesSetting => 'Yazı Tipi Boyutları';

  @override
  String foundRules(Object count) {
    return '$count kural bulundu';
  }

  @override
  String foundRulesDoYouWantToImport(Object count) {
    return '$count kural bulundu. İçe aktarmak ister misiniz?';
  }

  @override
  String foundRulesToImport(Object count) {
    return '$count kural bulundu. İçe aktarmak ister misiniz?';
  }

  @override
  String get fraudAlert => 'DOLANDIRICILIK UYARISI - Aramayı kapatın';

  @override
  String get fraudScamLikely => 'Dolandırıcılık Olasılığı Yüksek';

  @override
  String get free => 'Ücretsiz';

  @override
  String get functionSettingsTitle => 'Fonksiyon Ayarları';

  @override
  String generalUpdateFailure(Object error) {
    return 'Güncelleme başarısız: $error';
  }

  @override
  String get getFree => 'Ücretsiz Al';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Tüm SIM kartlar için global filtreleri yapılandırın:';

  @override
  String get globalFilterFeature =>
      '• Global Filtreler: Tüm gelen aramalar için temel kurallar';

  @override
  String get globalFilterSettings => 'Global Filtre Ayarları';

  @override
  String get globalFilterToggleInstructions =>
      'Tüm SIM yuvalarına uygulanan global filtre ayarlarını yapılandırın:';

  @override
  String get globalSearchSubtitle =>
      'Kişileri, etiketleri, kara listeleri, beyaz listeleri vb. arayın.';

  @override
  String get globalSearchTitle => 'Global Arama';

  @override
  String get globalSettings => 'Global Ayarlar';

  @override
  String get googleAdDisplayPosition => 'Google Reklam Görüntülenme Konumu';

  @override
  String get googleAdMobIntegrationText =>
      'Google AdMob reklamları buraya entegre edilebilir';

  @override
  String get googleDriveAuthDescription =>
      'Sistemde yapılandırılmış Google Drive istemci kimliği ve anahtarı kullanarak yetkilendirin';

  @override
  String get googleDriveAuthorizationHint =>
      'Sistemde yapılandırılmış Google Drive istemci kimliği ve anahtarı kullanarak yetkilendirin';

  @override
  String get googleDriveConfigTitle => 'Google Drive Yapılandırması';

  @override
  String get googleDriveConfigurationTitle => 'Google Drive Yapılandırması';

  @override
  String get government => 'Devlet';

  @override
  String get granted => 'Verildi';

  @override
  String get grantNecessaryPermissions => 'Gerekli İzinleri Verin';

  @override
  String get grantPermissions => 'İzin Ver';

  @override
  String get headhunter => 'Avcı';

  @override
  String get height => 'Yükseklik';

  @override
  String get homePageTitle => 'Ana Sayfa';

  @override
  String get homeTab => 'Ana Sayfa';

  @override
  String get howItWorksPoint1 =>
      '• Sistem, belirlenen zaman penceresi içinde aynı numaradan gelen çağrıları otomatik olarak kabul edecektir.';

  @override
  String get howItWorksPoint2 =>
      '• Daha kısa zaman pencereleri daha sıkı engelleme, daha uzun zaman pencereleri daha gevşek engelleme ile sonuçlanır.';

  @override
  String get howItWorksPoint3 =>
      '• Sistem, tekrar eden bir çağrı olup olmadığını belirlemek için çağrı günlüklerini kontrol eder.';

  @override
  String get howItWorksTitle => 'Nasıl Çalışır:';

  @override
  String get iconCodeOptional => 'Simge Kodu (İsteğe Bağlı)';

  @override
  String get iconSize => 'Simge Boyutu';

  @override
  String get import => 'İçe Aktar';

  @override
  String get important => 'Önemli';

  @override
  String get importButton => 'İçe Aktar';

  @override
  String get importConfig => 'Yapılandırmayı İçe Aktar';

  @override
  String get importContacts => 'Kişileri İçe Aktar';

  @override
  String get importExportContacts => 'Kişileri İçe/Dışa Aktar';

  @override
  String get importExportContactsTooltip => 'Kişileri İçe/Dışa Aktar';

  @override
  String get importExportRules => 'Kuralları İçe/Dışa Aktar';

  @override
  String importFailed(Object error) {
    return 'İçe aktarma başarısız: $error';
  }

  @override
  String get importFailure => 'Yapılandırma içe aktarılamadı';

  @override
  String get importFeatureComingSoon => 'İçe aktarma özelliği yakında geliyor';

  @override
  String get importLabels => 'Etiketleri İçe Aktar';

  @override
  String importLabelsFailed(Object error) {
    return 'Etiketleri içe aktarma başarısız: $error';
  }

  @override
  String get importPluginList => 'Eklenti Listesini İçe Aktar';

  @override
  String importPluginListFailed(Object error) {
    return 'Eklenti listesini içe aktarma başarısız: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '$count eklenti başarıyla içe aktarıldı';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Kural Yapılandırmalarını Dosyadan İçe Aktar';

  @override
  String get importRuleConfigurationsFromFileSubtitle =>
      'Kural yapılandırmalarını dosyadan içe aktarın';

  @override
  String get importRules => 'Kuralları İçe Aktar';

  @override
  String get importRulesButton => 'Kuralları İçe Aktar';

  @override
  String get importRulesDialogTitle => 'Kuralları İçe Aktar';

  @override
  String importRulesError(Object error) {
    return 'Kuralları içe aktarma başarısız: $error';
  }

  @override
  String get importRulesInstructions =>
      'Kuralları bir CSV dosyasından içe aktarın';

  @override
  String get importRulesSuccess => 'Kurallar başarıyla içe aktarıldı';

  @override
  String get importRulesTitle => 'Kuralları İçe Aktar';

  @override
  String get importSuccess => 'İçe aktarma başarılı';

  @override
  String get incomingCallInterceptAction => 'Gelen Çağrı Engelleme Eylemi';

  @override
  String get incomingCallNotification => 'Gelen Çağrı Bildirimi';

  @override
  String get incorrectPassword => 'Yanlış şifre';

  @override
  String get initializing => 'Başlatılıyor';

  @override
  String get installed => 'Yüklü';

  @override
  String get insufficientMarks => 'Yetersiz İşaret';

  @override
  String get insurance => 'Sigorta';

  @override
  String get interceptAction => 'Engelleme Eylemi';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Engellenen çağrıların nasıl ele alınacağını ayarlayın';

  @override
  String get interceptionActionSettingsTitle => 'Engelleme Eylemi Ayarları';

  @override
  String get interceptionTimeInterval => 'Engelleme Zaman Aralığı';

  @override
  String get internet => 'İnternet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return '$service güncelleme aralığı $days güne ayarlandı';
  }

  @override
  String get invalidContentRegex => 'Geçersiz içerik regex';

  @override
  String get invalidLabel => 'Geçersiz etiket';

  @override
  String get invalidRegexPattern => 'Geçersiz regex deseni';

  @override
  String get invalidSenderRegex => 'Geçersiz gönderen regexi';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Daha Fazla Bilgi İçin Telegram Kanalı ve Grubuna Katılın';

  @override
  String get jsLogsTitle => 'JS Kayıtları';

  @override
  String get jsonFormat => 'JSON Biçimi';

  @override
  String get keepAllVersions => 'Tüm Sürümleri Sakla';

  @override
  String get keepAllVersionsDescription =>
      'Her yedeğin tüm geçmiş sürümlerini saklayın';

  @override
  String get keepAllVersionsLabel => 'Tüm Sürümleri Sakla';

  @override
  String get keepAllVersionsSubtitle =>
      'Her yedeğin geçmiş sürümlerini saklayın';

  @override
  String get keepAllVersionsTitle => 'Tüm Sürümleri Sakla';

  @override
  String get label => 'Etiket';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Etiket \"$name\" başarıyla eklendi';
  }

  @override
  String get labelCategories => 'Etiket Kategorileri';

  @override
  String get labelDeleted => 'Etiket silindi';

  @override
  String get labelDescription =>
      'Etiketler, kişileri daha iyi yönetmenize yardımcı olur, aramaları ve mesajları kolayca tanımlamak için telefon numaralarına özel etiketler ekleyin.';

  @override
  String get labelFilter => 'Etiket Filtresi';

  @override
  String get labelFilterTooltip => 'Etiket Filtresi';

  @override
  String get labelIconColor => 'Etiket Simge Rengi';

  @override
  String get labelManagement => 'Etiket Yönetimi';

  @override
  String get labelNotFound => 'Etiket bulunamadı';

  @override
  String get labelRemoved => 'Etiket kaldırıldı';

  @override
  String labelRemoveFailed(Object error) {
    return 'Etiket kaldırılamadı: $error';
  }

  @override
  String get labels => 'Etiketler';

  @override
  String get labelsColor => 'Etiket Rengi';

  @override
  String labelsDeleted(Object count) {
    return '$count etiket silindi';
  }

  @override
  String get labelsExportedSuccessfully => 'Etiketler başarıyla dışa aktarıldı';

  @override
  String get labelsFontSize => 'Etiketler Yazı Tipi Boyutu';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count etiket başarıyla içe aktarıldı';
  }

  @override
  String get labelsPosition => 'Etiket Konumu';

  @override
  String labelTag(Object labelId) {
    return 'Etiket: $labelId';
  }

  @override
  String get labelUpdated => 'Etiket güncellendi';

  @override
  String labelUpdateFailed(Object error) {
    return 'Etiket güncellenemedi: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Etiket \"\$labelText\" başarıyla güncellendi';

  @override
  String get languageSettings => 'Dil Ayarları';

  @override
  String get languageSettingsSubtitle =>
      'Uygulama görüntüleme dilini değiştirin';

  @override
  String get languageSettingsTitle => 'Dil Ayarları';

  @override
  String get last30Days => 'Son 30 Gün';

  @override
  String get last7Days => 'Son 7 Gün';

  @override
  String get lastSyncLabel => 'Son Senkronizasyon';

  @override
  String lastUpdated(Object date) {
    return 'Son güncelleme: $date';
  }

  @override
  String get lifetimeMembership => 'Ömür Boyu Üyelik';

  @override
  String get lifetimeMembershipDescription =>
      'Tek seferlik satın alma, tüm premium özellikleri ve gelecekteki güncellemeleri kalıcı olarak açın';

  @override
  String loadContactsFailed(Object error) {
    return 'Kişiler yüklenemedi: $error';
  }

  @override
  String get loadDataFailed => 'Veri yüklenemedi';

  @override
  String get loadFailed => 'Yükleme Başarısız';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get loadingData => 'Veriler Yükleniyor...';

  @override
  String get loadingTags => 'Etiketler yükleniyor...';

  @override
  String loadLabelFailed(Object error) {
    return 'Etiketler yüklenemedi: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Etiketler yüklenemedi: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'İşaretli telefon numaraları yüklenemedi: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'İşaretli telefonlar yüklenemedi: $error';
  }

  @override
  String get loadMore => 'Daha Fazla Yükle';

  @override
  String get loadPluginButton => 'Eklentiyi Yükle';

  @override
  String loadPluginsFailed(Object error) {
    return 'Eklentiler yüklenemedi: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Ayarlar yüklenemedi: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'SMS kuralları yüklenemedi: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Durum yüklenemedi';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Abonelikler yüklenemedi: $error';
  }

  @override
  String get loan => 'Kredi';

  @override
  String get localBackupTitle => 'Yerel Yedekleme';

  @override
  String get localCounterFilter => 'Yerel Sayaç Filtresi';

  @override
  String get localCounterFilterSubtitle =>
      'Arama sıklığına göre spam aramaları otomatik olarak filtreleyin';

  @override
  String get localCountFilter => 'Yerel Sayım Filtresi';

  @override
  String get localCountFilterDescription =>
      'Yerel numara sayımlarına göre sık gelen aramaları engelle';

  @override
  String get localCountFilterExplanationContent =>
      'Yerel sayım filtresi, sık gelen spam aramaları otomatik olarak tanımlamak ve engellemek için arama geçmişi kayıtlarını analiz eder.';

  @override
  String get localCountFilterExplanationTitle =>
      'Yerel Sayım Filtresi Açıklaması';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Numaranın sayım değerine göre engellenip engellenmeyeceğine karar verin';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Bir numaranın sayımı belirlenen eşiği aştığında, otomatik olarak engellemeyi seçebilirsiniz';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Eşiği aşmayan numaralara seçici olarak izin verebilirsiniz';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Tüm sorgu günlüklerinin kaydedilip kaydedilmeyeceğini seçebilirsiniz';

  @override
  String get localCountFiltering => 'Yerel Sayım Filtrelemesi';

  @override
  String get localCountFilteringExplanation =>
      '• Yerel Sayım Filtrelemesi: Yerel işaretleme sayımına dayalı filtreleme kuralları';

  @override
  String get localCountFilterSettings => 'Yerel Sayım Filtresi Ayarları';

  @override
  String get localCountFilterUseCases =>
      'Bu filtre, otomatik aranan spam aramaları ve pazarlama aramalarını tanımlamak için özellikle uygundur.';

  @override
  String get localFilterSettings => 'Yerel Filtre Ayarları';

  @override
  String get localNotificationDisabled => 'Yerel bildirim devre dışı bırakıldı';

  @override
  String get localNotificationEnabled => 'Yerel bildirim etkinleştirildi';

  @override
  String get localServices => 'Yerel Hizmetler';

  @override
  String get locationColor => 'Konum Rengi';

  @override
  String get locationFontSize => 'Konum Yazı Tipi Boyutu';

  @override
  String get locationIconColor => 'Konum Simge Rengi';

  @override
  String get locationPosition => 'Konum Konumu';

  @override
  String get logAllLocalQueries => 'Tüm Yerel Sorguları Kaydet';

  @override
  String get logAllLocalQueriesDescription =>
      'Tüm yerel numara sorguları için günlükleri kaydet';

  @override
  String get logAllRemoteQueries => 'Tüm Uzak Sorguları Kaydet';

  @override
  String get logAllRemoteQueriesDescription =>
      'Tüm uzak numara sorgulama işlemlerini kaydet';

  @override
  String get manage => 'Kişileri Yönet';

  @override
  String get manageContacts => 'Yönet';

  @override
  String get manageFavoriteContacts => 'Favori Kişileri Yönet';

  @override
  String get manageFilterRules => 'Filtre Kurallarını Yönet';

  @override
  String get manageFilterRulesDescription =>
      'SMS filtre kurallarını ekle, düzenle veya sil';

  @override
  String get manageFrequentContacts => 'Sık Kişileri Yönet';

  @override
  String get markCounts => 'İşaret Sayımları';

  @override
  String get markCount => 'İşaret Sayısı';

  @override
  String markedByCount(Object count) {
    return '$count kişi tarafından işaretlendi';
  }

  @override
  String get markedPhonesList => 'İşaretli Telefon Numaraları';

  @override
  String get markExchange => 'İşaret Değişimi';

  @override
  String get markPhone => 'Telefon Numarasını İşaretle';

  @override
  String markPhoneFailed(Object error) {
    return 'Telefon numarası işaretlenemedi: $error';
  }

  @override
  String get markPhoneManagementSubtitle =>
      'Telefon Numaralarını İşaretlemek İçin';

  @override
  String get markPhoneManagementTitle => 'Telefon İşaretleme Yönetimi';

  @override
  String get markPhoneSuccess => 'Telefon numarası başarıyla işaretlendi';

  @override
  String get matchFailed => 'Eşleşme başarısız oldu!';

  @override
  String get matchFailedMessage => 'Eşleşme başarısız oldu.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'belirli sayı formatıyla eşleşir';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Özel karakterli numaraları eşleştir:';

  @override
  String get matchSpecificDigitPatterns => 'XXX-XXXX-XXXX formatıyla eşleşir';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Belirli basamak kalıplarını eşleştir:';

  @override
  String get matchSuccessful => 'Eşleşme başarılı!';

  @override
  String get matchSuccessfulMessage => 'Eşleşme başarılı!';

  @override
  String get medical => 'Tıbbi';

  @override
  String get membershipPrivileges => 'Üyelik Ayrıcalıkları';

  @override
  String get migrationTool => 'Geçiş Aracı';

  @override
  String get migrationToolTitle => 'Geçiş Aracı';

  @override
  String get minutes => 'dakika';

  @override
  String get month => 'Ay';

  @override
  String get monthly => 'Aylık';

  @override
  String get monthlyCallCount => 'Aylık Aramalar';

  @override
  String get monthlyChartTitle => 'Aylık Engellenen Aramalar';

  @override
  String get monthlyMembership => 'Aylık Üyelik';

  @override
  String get monthlyMembershipDescription =>
      'Tüm premium özelliklerin kilidini açın, aylık otomatik yenilenir';

  @override
  String get monthlyTotal => 'Aylık Toplam';

  @override
  String get monthlyTotalLabel => 'Aylık Toplam';

  @override
  String get moreOptions => 'Daha Fazla Seçenek';

  @override
  String get mute => 'Sessize Al';

  @override
  String get name => 'Ad';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Ad ve telefon numarası boş bırakılamaz';

  @override
  String get nameAndPhoneNumberRequired =>
      'Ad ve telefon numarası boş bırakılamaz';

  @override
  String get nameColor => 'Ad Rengi';

  @override
  String get nameFontSize => 'Ad Yazı Boyutu';

  @override
  String nameLabel(Object name) {
    return 'Ad: $name';
  }

  @override
  String get namePosition => 'Ad Konumu';

  @override
  String get nameUnknown => 'Ad: Bilinmiyor';

  @override
  String nameWithValue(String name) {
    return 'Ad: $name';
  }

  @override
  String get newPasswordLabel => 'Yeni Şifre';

  @override
  String get nextStep => 'İleri';

  @override
  String get noAction => 'Eylem Yok';

  @override
  String get noActionRules => 'Eylem Yok Kuralları';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Aktif bulut senkronizasyon servisi yok';

  @override
  String get noCallLogs => 'Arama Kaydı Yok';

  @override
  String get noCallRecords => 'Arama kaydı yok';

  @override
  String get noContacts => 'Henüz kişi yok';

  @override
  String get noContactsYet => 'Henüz kişi yok';

  @override
  String get noData => 'Veri Yok';

  @override
  String get noDevicesRegisteredMessage => 'Kayıtlı cihaz yok';

  @override
  String get noDevicesRegisteredYet => 'Henüz kayıtlı cihaz yok.';

  @override
  String get noFilters => 'Henüz filtre yok';

  @override
  String get noLabels => 'Henüz etiket yok';

  @override
  String get noMarkedPhones => 'İşaretli telefon numarası yok';

  @override
  String get noMatchingContacts => 'Eşleşen kişi yok';

  @override
  String get noMatchingContactsFound => 'Eşleşen kişi bulunamadı';

  @override
  String get noMatchingNumbersFound => 'Eşleşen numara bulunamadı';

  @override
  String get noMatchingRecords => 'Eşleşen arama kaydı yok';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Eşleşen $ruleType yok';
  }

  @override
  String get none => 'Yok';

  @override
  String get noneServiceType => 'Yok';

  @override
  String get noPlugins => 'Henüz eklenti yok';

  @override
  String get noRecords => 'Arama kaydı yok';

  @override
  String get noResultReturned => 'Sonuç döndürülmedi';

  @override
  String get noResultReturnedLog => 'Eklentiden sonuç döndürülmedi';

  @override
  String noRules(Object ruleType) {
    return 'Henüz $ruleType yok';
  }

  @override
  String get noRulesPrompt => 'Kural bulunamadı, lütfen kural ekleyin';

  @override
  String get noRulesToExport => 'Dışa aktarılacak kural yok';

  @override
  String get noSmsFilterRulesYet => 'Henüz SMS filtreleme kuralı yok';

  @override
  String get noSmsRulesYet => 'Henüz SMS kuralı yok';

  @override
  String get noSubscriptions => 'Abonelik yok';

  @override
  String get noSubscriptionsYet => 'Henüz Abonelik Yok';

  @override
  String get notGranted => 'Verilmedi';

  @override
  String get notificationMode => 'Bildirim Modu';

  @override
  String get notificationModeDescription =>
      'Arayan bilgilerini bildirim çubuğunda göster';

  @override
  String get notificationPermission => 'Bildirim İzni';

  @override
  String get notificationPermissionDescription =>
      'Gelen arama ve mesaj bildirimlerini görüntülemek için kullanılır.';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get notificationSettings => 'Bildirim Ayarları';

  @override
  String get notificationSettingsSaved =>
      'Bildirim ayarları başarıyla kaydedildi';

  @override
  String get notSet => 'Ayarlanmadı';

  @override
  String get notVerifiedText => 'Doğrulanmadı';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Dosyada geçerli SMS kuralı bulunamadı';

  @override
  String get number => 'Numara';

  @override
  String get numberColor => 'Numara Rengi';

  @override
  String get numberFontSize => 'Numara Yazı Boyutu';

  @override
  String get numberPosition => 'Numara Konumu';

  @override
  String get numberSearch => 'Numara Arama';

  @override
  String get numberTypeColor => 'Numara Türü Rengi';

  @override
  String get numberTypeFontSize => 'Numara Türü Yazı Boyutu';

  @override
  String get numberTypePosition => 'Numara Türü Konumu';

  @override
  String get ok => 'Tamam';

  @override
  String get okButton => 'Tamam';

  @override
  String get onboardingCompleteDescription =>
      'Arama güvenlik yöneticiniz hazır, güvenli bir arama deneyiminin keyfini çıkarmaya başlayın!';

  @override
  String get onboardingLanguageDescription =>
      'En iyi deneyim için tercih ettiğiniz dili seçin.';

  @override
  String get onboardingPermissionsDescription =>
      'Tam hizmet sunmak için aşağıdaki izinlere ihtiyacımız var:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'İstenmeyen arama ve mesajları tek tıkla engelleme, engelleme kurallarını özelleştirme ve size sessiz bir ortam sunma.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Bilinmeyen aramaları otomatik olarak tanımlama, şüpheli numaraları işaretleme ve arama güvenliğinizi koruma.';

  @override
  String get onboardingWelcomeDescription =>
      'Kapsamlı arama tanımlama ve engelleme hizmetleri sunan arama yönetimi uzmanınız.';

  @override
  String get oneDriveAuthDescription =>
      'Sistem tarafından yapılandırılmış OneDrive istemci kimliği ve anahtarı kullanarak yetkilendirin';

  @override
  String get oneDriveAuthorizationHint =>
      'Sistem tarafından yapılandırılmış OneDrive istemci kimliği ve anahtarı kullanarak yetkilendirin';

  @override
  String get oneDriveConfigTitle => 'OneDrive Yapılandırması';

  @override
  String get oneDriveConfigurationTitle => 'OneDrive Yapılandırması';

  @override
  String get onlineCallerIdSubscription => 'Çevrimiçi Arayan Kimliği Aboneliği';

  @override
  String get openAppSettings => 'Uygulama ayarlarını aç';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Uygulama ayarları açılamadı: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'İşlem başarısız oldu: $error';
  }

  @override
  String get operationFailure => 'İşlem başarısız oldu';

  @override
  String get operationSuccess => 'İşlem başarılı oldu';

  @override
  String get other => 'Diğer';

  @override
  String get ourOtherApps => 'Diğer Uygulamalarımız';

  @override
  String get overlayMode => 'Kayan Pencere';

  @override
  String get overlayModeDescription =>
      'Arayan bilgilerini kayan bir pencerede göster';

  @override
  String get overlayPermission => 'Kayan Pencere İzni';

  @override
  String get overlayPermissionDescription =>
      'Gelen çağrı kayan penceresini göstermek için kullanılır.';

  @override
  String get overview => 'Genel Bakış';

  @override
  String get password => 'Şifre';

  @override
  String get passwordCannotBeEmpty => 'Şifre boş olamaz';

  @override
  String get passwordLabel => 'Şifre';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get passwordSetSuccessfully => 'Şifre başarıyla ayarlandı';

  @override
  String get pattern => 'Desen';

  @override
  String get pendingSync => 'Bekleyen Senkronizasyon';

  @override
  String get periodMonth => 'Ay';

  @override
  String get periodWeek => 'Hafta';

  @override
  String get periodYear => 'Yıl';

  @override
  String get permissionDenied => 'İzin isteği reddedildi';

  @override
  String get permissionGranted => 'İzin verildi';

  @override
  String get permissionManagement => 'İzin Yönetimi';

  @override
  String get phoneCallsTab => 'Telefon';

  @override
  String get phoneNumber => 'Telefon Numarası';

  @override
  String get phoneNumberCannotBeEmpty => 'Telefon numarası boş olamaz';

  @override
  String get phoneNumberHint => 'Telefon numarasını girin';

  @override
  String get phoneNumberHintText =>
      'Kural eklemek için telefon numarasını girin';

  @override
  String get phoneNumberLabel => 'Telefon Numarası';

  @override
  String get phoneNumberRegexRequired =>
      'Lütfen hem telefon numarasını hem de regex desenini girin';

  @override
  String get phoneNumberRequired => 'Telefon numarası gerekli';

  @override
  String get phoneNumberTypeFixedLine => 'Sabit hat';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Sabit hat veya mobil';

  @override
  String get phoneNumberTypeMobile => 'Mobil';

  @override
  String get phoneNumberTypePager => 'Çağrı cihazı';

  @override
  String get phoneNumberTypePersonalNumber => 'Kişisel numara';

  @override
  String get phoneNumberTypePremiumRate => 'Premium ücretli';

  @override
  String get phoneNumberTypeSharedCost => 'Paylaşılan maliyet';

  @override
  String get phoneNumberTypeTollFree => 'Ücretsiz';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Bilinmeyen';

  @override
  String get phoneNumberTypeVoicemail => 'Sesli posta';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Telefon İzni';

  @override
  String get phonePermissionDescription =>
      'Gelen çağrıları tanımlamak ve engellemek için kullanılır.';

  @override
  String get phoneRule => 'Telefon Kuralı';

  @override
  String get phoneRuleEditDialog => 'Telefon Kuralı Düzenleme Penceresi';

  @override
  String get phoneRuleManagement => 'Telefon Kuralı Yönetimi';

  @override
  String get phoneRuleSubscription => 'Telefon Kuralı Aboneliği';

  @override
  String get phoneSubscription => 'Telefon Aboneliği';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Beyaz liste ve kara liste kurallarını otomatik olarak güncellemek için URL üzerinden telefon kuralı listelerine abone olun. JSON formatındaki kural dosyalarını destekler.';

  @override
  String get phoneSubscriptionTitle => 'Telefon Kuralı Abonelikleri';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Lütfen bir etiket seçin ve geçerli bir telefon numarası girin';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Eklenti \"$name\" başarıyla eklendi';
  }

  @override
  String get pluginDeleted => 'Eklenti silindi';

  @override
  String get pluginLatestVersion => 'Eklenti zaten en son sürümde';

  @override
  String get pluginListExportSuccess =>
      'Eklenti listesi başarıyla dışa aktarıldı';

  @override
  String get pluginLoadedSuccessfully => 'Eklenti başarıyla yüklendi';

  @override
  String get pluginManagement => 'Eklenti Yönetimi';

  @override
  String get pluginManagementSubtitle =>
      'Üçüncü taraf eklentileri yönetin ve yapılandırın';

  @override
  String get pluginManagementTitle => 'Eklenti Yönetimi';

  @override
  String get pluginName => 'Eklenti Adı';

  @override
  String get pluginNotLoaded =>
      'Eklenti henüz yüklenmedi. Lütfen önce eklentiyi yükleyin.';

  @override
  String pluginsDeleted(Object count) {
    return '$count eklenti başarıyla silindi.';
  }

  @override
  String get pluginService => 'Eklenti Hizmeti';

  @override
  String get pluginTestPageTitle => 'Eklenti Testi';

  @override
  String get pluginUpdateSuccess => 'Eklenti başarıyla güncellendi';

  @override
  String get pluginUrl => 'Eklenti URL\'si';

  @override
  String get pluginUrlCannotBeEmpty => 'Eklenti URL\'si boş olamaz';

  @override
  String get pluginUrlHint => 'Eklenti URL\'sini girin';

  @override
  String get pluginUrlLabel => 'Eklenti URL\'si';

  @override
  String get pluginVersion => 'Eklenti Sürümü';

  @override
  String get political => 'Siyasi';

  @override
  String get powerfulSpamBlocking => 'Güçlü İstenmeyen Çağrı Engelleme';

  @override
  String get previousStep => 'Geri';

  @override
  String get prioritizeRemoteAction => 'Uzak Eylem Ayarlarını Önceliklendir';

  @override
  String get prioritizeRemoteActionDescription =>
      'Uzak veritabanındaki eylem ayarlarını önceliklendir';

  @override
  String get processing => 'İşleniyor...';

  @override
  String get processingOperation => 'İşleniyor...';

  @override
  String get purchase => 'Satın Al';

  @override
  String get quarterlyMembership => 'Üç Aylık Üyelik';

  @override
  String get quarterlyMembershipDescription =>
      'Tüm premium özellikleri açın, üç ayda bir otomatik yenilenir';

  @override
  String get queryButton => 'Sorgula';

  @override
  String get queryFailed => 'Sorgu başarısız oldu';

  @override
  String get queryFailedLog => 'Sorgu başarısız oldu';

  @override
  String get querying => 'Sorgulanıyor...';

  @override
  String get queryingPhoneNumber => 'Telefon numarası sorgulanıyor';

  @override
  String get queryResultTitle => 'Sorgu Sonucu';

  @override
  String get ready => 'Hazır!';

  @override
  String get receiveWeeklyStatistics => 'Haftalık istatistik al';

  @override
  String get recruiter => 'İşe Alımcı';

  @override
  String get reEnterPasswordHint => 'Lütfen şifreyi tekrar girin';

  @override
  String get refresh => 'Yenile';

  @override
  String get refreshPermissionStatus => 'İzin durumunu yenile';

  @override
  String get refreshTooltip => 'Yenile';

  @override
  String regexError(Object error) {
    return 'Regex hatası: $error';
  }

  @override
  String regexErrorMessage(Object error) {
    return 'Regex hatası: $error';
  }

  @override
  String get regexPattern => 'Regex Kalıbı';

  @override
  String get regexPatternExplanation => 'Regex Kalıbı Açıklaması';

  @override
  String get regexPatternExplanationButton => 'Regex Kalıbı Açıklaması';

  @override
  String get regexPatternLabel => 'Regex Kalıbı';

  @override
  String get regexPatternsExamples =>
      'Kalıpları tanımlamak için standart regex sözdizimini kullanın. Örnekler:';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Telefon Numarası Eşleştirmesi için Regex Kalıpları';

  @override
  String get regexRule => 'Regex Kuralı';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Regex kuralı eklenemedi: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regex kuralı başarıyla eklendi';

  @override
  String get regexRuleManagement => 'Regex Kuralı Yönetimi';

  @override
  String get regexRuleNamePatternRequired =>
      'Kural adı ve regex kalıbı boş olamaz';

  @override
  String get regexRules => 'Regex Kuralları';

  @override
  String get regexTesterTitle => 'Regex Test Cihazı';

  @override
  String regexValidationFailed(Object error) {
    return 'Regex doğrulama başarısız oldu: $error';
  }

  @override
  String get regexValidationSuccess => 'Regex doğrulama başarılı';

  @override
  String get region => 'Bölge';

  @override
  String get registeredDevicesTitle => 'Kayıtlı Cihazlar';

  @override
  String get rejectAllCalls => 'Tüm Çağrıları Reddet';

  @override
  String get rejectAllCallsDescription =>
      'Etkinleştirildiğinde, tüm çağrılar en yüksek öncelikle reddedilecektir';

  @override
  String get rejectAllNumbers => 'Tüm Numaraları Reddet';

  @override
  String get rejectAllNumbersDesc =>
      'Etkinleştirildiğinde gelen tüm çağrıları reddet';

  @override
  String get rejectExceededNumbers => 'Aşan Numaraları Reddet';

  @override
  String get rejectExceededNumbersDescription =>
      'Sayı eşiğini aşan numaraları otomatik olarak reddet';

  @override
  String get remoteFilterSettings => 'Uzak Filtre Ayarları';

  @override
  String get remoteFilterSettingsPageTitle => 'Uzak Numara Filtresi Ayarları';

  @override
  String get remoteNumberFilter => 'Uzak Numara Filtresi';

  @override
  String get remoteNumberFilterDatabaseInfo =>
      'Bu filtre, en güncel numara bilgisini almak için bağımsız bir uzak veritabanı kullanır.';

  @override
  String get remoteNumberFilterDescription =>
      'Uzak veritabanı bilgilerine dayanarak rahatsız edici çağrıları engelle';

  @override
  String get remoteNumberFilterExplanationContent =>
      'Uzak numara filtresi, numara sayısına dayalı olarak uzak bir veritabanını sorgulayarak spam çağrılarını tanımlar ve engeller.';

  @override
  String get remoteNumberFilterExplanationTitle =>
      'Uzak Numara Filtresi Açıklaması';

  @override
  String get remoteNumberFilterFeatureCountThreshold =>
      '• Sayı Eşiği: Numara oluş sıklığına göre belirleme';

  @override
  String get remoteNumberFilterFeatureFilterAction =>
      '• Filtre Eylemleri: Eşiği aşan numaraların nasıl ele alınacağını yapılandırma';

  @override
  String get remoteNumberFilterFeaturePriority =>
      '• Öncelik Ayarları: Uzak eylemler için öncelik belirleme';

  @override
  String get remoteNumberFilterFeatures => 'Özellikler:';

  @override
  String get remoteNumberFiltering => 'Uzak Numara Filtreleme';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Uzak Numara Filtreleme: Uzak veritabanı bilgilerine dayalı filtreleme kuralları';

  @override
  String get remoteNumberFilterSubtitle =>
      'Bulut veritabanı ve topluluk raporlarını kullanarak spam çağrılarını belirle';

  @override
  String get removeAdsDescription =>
      'Daha akıcı bir deneyim için uygulamadaki tüm reklamları kalıcı olarak kaldırın';

  @override
  String get removeAdsTitle => 'Reklamları Kaldır';

  @override
  String get removedFromFavoriteContacts => 'Favori kişilerden kaldırıldı';

  @override
  String get removedFromFavorites => 'Favori kişilerden kaldırıldı';

  @override
  String get removeFavorite => 'Favorilerden Kaldır';

  @override
  String get removeFromFavorites => 'Favorilerden Kaldır';

  @override
  String get renameButton => 'Yeniden Adlandır';

  @override
  String get renameDeviceDialogTitle => 'Cihazı Yeniden Adlandır';

  @override
  String get renameDeviceTitle => 'Cihazı Yeniden Adlandır';

  @override
  String get replaceCurrentSettingsConfirmation =>
      'Bu, mevcut tüm ayarlarınızın yerine geçecektir. Devam etmek istediğinizden emin misiniz?';

  @override
  String get requestAllPermissions => 'Tüm İzinleri İste';

  @override
  String get requestPermission => 'İzin İste';

  @override
  String requestPermissionFailed(Object error) {
    return 'İzin isteme başarısız oldu: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count İşaret';
  }

  @override
  String get reset => 'Sıfırla';

  @override
  String get restore => 'Geri Yükle';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Uygulama Ayarlarını Yedekten Geri Yükle';

  @override
  String get restoreApplicationSettingsFromBackupSubtitle =>
      'Uygulama ayarlarını yedekten geri yükle';

  @override
  String get restoreButton => 'Geri Yükle';

  @override
  String restoreFailedWithError(Object error) {
    return 'Buluttan geri yükleme başarısız oldu: $error';
  }

  @override
  String get restoreFromCloud => 'Buluttan Geri Yükle';

  @override
  String get restoreFromCloudDescription =>
      'Ayarları ve kuralları bulut depolamadan geri yükle';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Buluttan geri yükleme başarısız oldu: $error';
  }

  @override
  String get restoreFromCloudLabel => 'Buluttan Geri Yükle';

  @override
  String get restoreFromCloudSuccess => 'Buluttan başarıyla geri yüklendi';

  @override
  String get restoreFromCloudTitle => 'Buluttan Geri Yükle';

  @override
  String get restoreFromLocal => 'Yerelden Geri Yükle';

  @override
  String get restorePurchases => 'Satın Almaları Geri Yükle';

  @override
  String get restoreSectionTitle => 'Geri Yükleme';

  @override
  String get restoreSettings => 'Ayarları Geri Yükle';

  @override
  String get restoreSettingsConfirmation =>
      'Bu, mevcut tüm ayarlarınızın yerine geçecektir. Devam etmek istediğinizden emin misiniz?';

  @override
  String get restoreSettingsDialogTitle => 'Ayarları Geri Yükle';

  @override
  String get restoreSettingsTitle => 'Ayarları Geri Yükle';

  @override
  String get restoreSuccessFromLocal => 'Yerelden başarıyla geri yüklendi';

  @override
  String get restoreSuccessMessage => 'Buluttan başarıyla geri yüklendi';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get ridesharing => 'Araç Paylaşımı';

  @override
  String get risk => 'Risk';

  @override
  String get robocall => 'Robot Çağrı';

  @override
  String get ruleAction => 'Kural Eylemi';

  @override
  String get ruleAddButton => 'Kural Ekle';

  @override
  String get ruleAddedSuccess => 'Kural başarıyla eklendi';

  @override
  String ruleAddFailure(Object error) {
    return 'Kural eklenemedi: $error';
  }

  @override
  String get ruleAddSuccess => 'Kural başarıyla eklendi';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Bu $ruleType silmek istediğinizden emin misiniz?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Kuralı Sil';

  @override
  String get ruleDeletedSuccess => 'Kural başarıyla silindi';

  @override
  String get ruleDeletedSuccessfully => 'Kural başarıyla silindi';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Kural silinemedi: $error';
  }

  @override
  String ruleDeleteFailure(Object error) {
    return 'Kural silinemedi: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Kural başarıyla silindi';

  @override
  String get ruleDisabledSuccessfully => 'Kural başarıyla devre dışı bırakıldı';

  @override
  String get ruleEnabledSuccessfully => 'Kural başarıyla etkinleştirildi';

  @override
  String ruleLoadFailed(Object error) {
    return 'Kurallar yüklenemedi: $error';
  }

  @override
  String get ruleManagement => 'Kural Yönetimi';

  @override
  String get ruleManagementTitle => 'Kural Yönetimi';

  @override
  String get ruleName => 'Kural Adı';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Kural adı ve içerik regex\'i boş olamaz';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Kural adı ve telefon numarası boş olamaz';

  @override
  String get ruleNameHint => 'örn., Aile, Arkadaşlar, vb.';

  @override
  String get ruleNameLabel => 'Kural Adı';

  @override
  String get ruleNamePatternRequired => 'Lütfen kural adı ve kalıbı girin';

  @override
  String get ruleNameRequired => 'Kural adı ve telefon numarası boş olamaz';

  @override
  String get ruleNotExist => 'Kural mevcut değil veya silinmiş';

  @override
  String ruleNotFound(Object error) {
    return 'Kural bulunamadı: $error';
  }

  @override
  String get ruleSavedSuccessfully => 'Kural başarıyla kaydedildi!';

  @override
  String get ruleSavedSuccessMessage => 'Kural başarıyla kaydedildi!';

  @override
  String ruleSaveFailed(Object error) {
    return 'Kaydetme başarısız oldu: $error';
  }

  @override
  String ruleSaveFailedMessage(Object error) {
    return 'Kaydetme başarısız oldu: $error';
  }

  @override
  String get ruleSaveSuccess => 'Kural başarıyla kaydedildi!';

  @override
  String get rulesExportedSuccessfully => 'Kurallar başarıyla dışa aktarıldı';

  @override
  String rulesExportedTo(Object path) {
    return 'Kurallar şuraya dışa aktarıldı: $path';
  }

  @override
  String get rulesImported => 'Kurallar başarıyla içe aktarıldı';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count kural başarıyla içe aktarıldı';
  }

  @override
  String rulesImportFailed(Object error) {
    return 'Kurallar içe aktarılamadı: $error';
  }

  @override
  String get ruleStatistics => 'Kural İstatistikleri';

  @override
  String ruleStatusChanged(Object status) {
    return 'Kural başarıyla $status oldu';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'İşlem başarısız oldu: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Kural başarıyla $status oldu';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Kural güncellenemedi: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Kural başarıyla güncellendi';

  @override
  String get ruleVerification => 'Kural Doğrulaması';

  @override
  String get save => 'Kaydet';

  @override
  String get saveButton => 'Kaydet';

  @override
  String get saveButtonLabel => 'KAYDET';

  @override
  String get saveButtonText => 'Kaydet';

  @override
  String saveFailed(Object error) {
    return 'Kaydetme başarısız oldu: $error';
  }

  @override
  String get saveFilter => 'Filtreyi Kaydet';

  @override
  String get saveSettings => 'Ayarları Kaydet';

  @override
  String saveSettingsFailed(Object error) {
    return 'Ayarlar kaydedilemedi: $error';
  }

  @override
  String get scamsLikely => 'Dolandırıcılık Olası';

  @override
  String get search => 'Ara';

  @override
  String get searchContacts => 'Kişileri Ara';

  @override
  String searchError(Object error) {
    return 'Arama hatası: $error';
  }

  @override
  String get searchFilters => 'Arama Filtreleri';

  @override
  String get searchForContacts => 'Kişi Ara';

  @override
  String get searchHint => 'Ara...';

  @override
  String get searchSettingsSubtitle =>
      'Kişileri, etiketleri, kara listeleri, beyaz listeleri vb. ara.';

  @override
  String get searchSettingsTitle => 'Arama Ayarları';

  @override
  String get securityMessage =>
      'Hiçbir telefon görüşmesine güvenmeyin. Müşteri hizmetleri numaralarını her zaman bağımsız olarak doğrulayın. Asla şifreleri, doğrulama kodlarını, kart numaralarını veya kişisel bilgileri paylaşmayın.';

  @override
  String get selectActionToPerform =>
      'Kural eşleştiğinde gerçekleştirilecek eylemi seçin';

  @override
  String get selectActionWhenBlockingCalls =>
      'Çağrıları engellerken eylem seçin';

  @override
  String get selectActionWhenRuleMatches => 'Kural eşleştiğinde eylem seçin';

  @override
  String get selectAll => 'Hepsini Seç';

  @override
  String get selectCountry => 'Ülke Seç';

  @override
  String get selectDateRange => 'Tarih Aralığı Seç';

  @override
  String get selectedDateRange => 'Seçilen tarih aralığı';

  @override
  String selectedItems(Object count) {
    return '$count öğe seçildi';
  }

  @override
  String get selectedLabel => 'Seçilen:';

  @override
  String get selectExportFormat => 'Dışa Aktarma Biçimini Seçin';

  @override
  String get selectLabel => 'Etiket Seç';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Lütfen bir etiket seçin ve geçerli bir telefon numarası girin';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get selectMultiple => 'Birden Fazla Seç';

  @override
  String get selectPeriod => 'Dönem Seç';

  @override
  String get selectSimCard => 'SIM Kart Seç';

  @override
  String get selectSimSlot => 'SIM Yuvası Seç';

  @override
  String get selectSpecificActionForBlockedCalls =>
      'Çağrıları engellerken gerçekleştirilecek belirli eylemi seçin';

  @override
  String get selectTag => 'Etiket Seç';

  @override
  String get selectTags => 'Etiketleri Seç';

  @override
  String get selectTrustedDataSource =>
      'Lütfen güvenilir veri kaynaklarını seçin';

  @override
  String get selectYourLanguage => 'Dilinizi Seçin';

  @override
  String get sender => 'Gönderen';

  @override
  String get senderRegexOptional => 'Gönderen Regex (Opsiyonel)';

  @override
  String get serverAddressLabel => 'Sunucu Adresi';

  @override
  String get serviceTypeContact => 'Kişi Aboneliği';

  @override
  String get serviceTypeLabel => 'Hizmet Türü';

  @override
  String get serviceTypePhone => 'Telefon Aboneliği';

  @override
  String get serviceTypePlugin => 'Eklenti Güncellemesi';

  @override
  String get serviceTypeSms => 'SMS Aboneliği';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setButton => 'Ayarla';

  @override
  String get setEncryptionPassword => 'Şifreleme Parolası Belirle';

  @override
  String get setEncryptionPasswordDescription =>
      'Yedekleme ve geri yükleme için şifreleme parolası belirleyin';

  @override
  String get setEncryptionPasswordLabel => 'Şifreleme Parolası Belirle';

  @override
  String get setEncryptionPasswordTitle => 'Şifreleme Parolası Belirle';

  @override
  String get setPasswordButton => 'Ayarla';

  @override
  String get settings => 'Ayarlar';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Ayarlar şuraya yedeklendi: $path';
  }

  @override
  String get settingsLoaded => 'Ayarlar yüklendi';

  @override
  String settingsLoadFailed(Object error) {
    return 'Ayarlar yüklenemedi: $error';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Ayarlar başarıyla geri yüklendi. Değişikliklerin etkili olması için lütfen uygulamayı yeniden başlatın.';

  @override
  String get settingsSaved => 'Ayarlar kaydedildi';

  @override
  String settingsSaveFailed(Object error) {
    return 'Ayarlar kaydedilemedi: $error';
  }

  @override
  String get settingsTab => 'Ayarlar';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get setup => 'Kurulum';

  @override
  String get showContactEditDialogStaticMethod =>
      'Kişi düzenleme iletişim kutusunu görüntülemek için statik yöntem';

  @override
  String get showExplanation => 'Açıklamayı Göster';

  @override
  String get silence => 'Sessize Al';

  @override
  String get silenceAndNoAnswer => 'Sessize Al ve Cevaplama';

  @override
  String get silenceNoAnswer => 'Sessize Al Cevaplama';

  @override
  String get silentCallVoiceClone => 'Sessiz Çağrı Ses Klonu';

  @override
  String get silentRules => 'Sessiz Kurallar';

  @override
  String simCard(Object simNumber) {
    return 'SIM Kart $simNumber';
  }

  @override
  String get simCardColor => 'SIM Kart Rengi';

  @override
  String get simCardConfigurationExplanation =>
      '• SIM Kart Yapılandırması: Her SIM kart için bağımsız filtreleme kuralları ayarlayın';

  @override
  String get simCardFilterRules => 'SIM Kart Filtre Kuralları';

  @override
  String get simCardFilterRulesDescription =>
      'SIM kart yuvalarına göre farklı filtreleme kuralları ayarlayın';

  @override
  String get simCardFontSize => 'SIM Kart Yazı Tipi Boyutu';

  @override
  String get simCardPosition => 'SIM Kart Konumu';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String simInfoLoadFailure(Object error) {
    return 'SIM kart bilgileri yüklenemedi: $error';
  }

  @override
  String get simRuleInstructions =>
      'SIM yuvası kuralları, her bir SIM yuvası için bağımsız filtreleme kuralları yapılandırmanıza olanak tanır.';

  @override
  String get simRuleInstructionsTitle => 'SIM Yuvası Kuralları';

  @override
  String get simRuleManagement => 'SIM Yuvası Kural Yönetimi';

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
    return 'SIM verileri yüklenemedi: $error';
  }

  @override
  String get simSlotFilterConfiguration => 'SIM Yuvası Filtre Yapılandırması';

  @override
  String get simSlotFilterConfigurationDescription =>
      'SIM yuvasına göre filtre kuralları ayarlamaya izin verir';

  @override
  String get simSlotFilterDescription =>
      'Her bir SIM kart için bağımsız filtreleme kuralları yapılandırın:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'SIM Yuvası $slotNumber Filtre Ayarları';
  }

  @override
  String simSlotLoadFailed(Object error) {
    return 'SIM yuvaları yüklenemedi: $error';
  }

  @override
  String get simSlotManagement => 'SIM Yuvası Yönetimi';

  @override
  String simSlotOperationFailed(Object error) {
    return 'SIM yuvası işlemi başarısız oldu: $error';
  }

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'SIM Yuvası Konumu $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• SIM Yuvası Kuralları: SIM başına bağımsız filtreleme stratejileri';

  @override
  String get simSlotRuleListTitle => 'SIM Yuvası Kuralları Listesi';

  @override
  String get simSlotRuleManagement => 'SIM Yuvası Kuralları';

  @override
  String get simSlotRuleManagementTitle => 'Kural Yönetimi';

  @override
  String get simSlotSettings => 'SIM Yuvası Ayarları';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'SIM Yuvası $slotNumber';
  }

  @override
  String get skip => 'Atla';

  @override
  String get smartCallerId => 'Akıllı Arama Tanımlama';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'SMS filtreleme, spam mesajlarını otomatik olarak filtrelemenize ve mesaj listenizi temiz tutmanıza yardımcı olur. Filtre kurallarını ve bildirim yöntemlerini ayarlayabilirsiniz.';

  @override
  String get smsFilterDisabled => 'SMS filtreleme devre dışı';

  @override
  String get smsFilterEnabled => 'SMS filtreleme etkin';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'SMS filtre kuralı başarıyla eklendi';

  @override
  String get smsFilterRules => 'SMS Filtre Kuralları';

  @override
  String get smsFilterSettings => 'SMS Filtre Ayarları';

  @override
  String get smsHistory => 'SMS Geçmişi';

  @override
  String get smsManagement => 'SMS Yönetimi';

  @override
  String get smsPermission => 'SMS İzni';

  @override
  String get smsPermissionDescription =>
      'Spam mesajlarını filtrelemek için kullanılır.';

  @override
  String get smsRuleAddedSuccessfully => 'SMS kuralı başarıyla eklendi';

  @override
  String get smsRuleDeletedSuccessfully => 'SMS kuralı başarıyla silindi';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'SMS kuralları yüklenemedi: $error';
  }

  @override
  String get smsRuleManagement => 'SMS Kural Yönetimi';

  @override
  String smsRulesExportedSuccessfully(Object filePath) {
    return 'SMS kuralları başarıyla $filePath konumuna dışa aktarıldı';
  }

  @override
  String get smsRulesImportedSuccessfully =>
      'SMS kuralları başarıyla içe aktarıldı';

  @override
  String get smsRuleSubscription => 'SMS Kuralı Aboneliği';

  @override
  String get smsRuleUpdatedSuccessfully => 'SMS kuralı başarıyla güncellendi';

  @override
  String get smsSettingsSubtitle =>
      'SMS filtreleme ve anahtar kelime engelleme';

  @override
  String get smsSettingsTitle => 'SMS Ayarları';

  @override
  String get smsSubscription => 'SMS Aboneliği';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'SMS aboneliği başarıyla eklendi';

  @override
  String get smsSubscriptionRulesDescription =>
      'URL üzerinden SMS kural listelerine abone olun, normal ifade eşleştirmesini destekler. Engelleme veya izin verme eylemleri ayarlayabilirsiniz.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied => 'Bazı izin istekleri reddedildi';

  @override
  String get spamLikely => 'Spam Olasılığı Yüksek';

  @override
  String get startColor => 'Başlangıç Rengi';

  @override
  String get startDate => 'Başlangıç Tarihi';

  @override
  String get startUsing => 'Başlayın';

  @override
  String get statAnswered => 'Cevaplandı';

  @override
  String get statBlocked => 'Engellendi';

  @override
  String get staticMethodShowCallerIdDialog =>
      'Arayan Kimliği Bilgi İletişim Kutusunu göstermek için statik yöntem';

  @override
  String get staticMethodToDisplayCountrySelectionDialog =>
      'Ülke seçimi iletişim kutusunu göstermek için statik yöntem';

  @override
  String get staticMethodToDisplayDialog =>
      'İletişim kutusunu göstermek için statik yöntem';

  @override
  String get statistics => 'İstatistikler';

  @override
  String get statisticsExportFeatureComingSoon =>
      'İstatistik dışa aktarma özelliği yakında geliyor';

  @override
  String get statisticsGrid => 'İstatistikler Tablosu';

  @override
  String get statisticsPageTitle => 'Veri Analizi';

  @override
  String get stirColor => 'STIR Rengi';

  @override
  String get stirFontSize => 'STIR Yazı Tipi Boyutu';

  @override
  String get stirPosition => 'STIR Konumu';

  @override
  String get storagePermission => 'Depolama İzni';

  @override
  String get storagePermissionDescription =>
      'Ayarları ve kuralları kaydetmek için kullanılır.';

  @override
  String get subscribe => 'Abone Ol';

  @override
  String subscriptionAddSuccess(Object name) {
    return '\"$name\" aboneliği başarıyla eklendi';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Bu aboneliği silmek istediğinizden emin misiniz?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Aboneliği Sil';

  @override
  String get subscriptionDeleted => 'Abonelik silindi';

  @override
  String get subscriptionDeletedSuccessfully => 'Abonelik başarıyla silindi';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Abonelik silinemedi: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonelik silindi';

  @override
  String get subscriptionEmptyState => 'Abonelik mevcut değil';

  @override
  String get subscriptionEmptyText => 'Henüz abonelik yok';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Abonelikler yüklenemedi: $error';
  }

  @override
  String subscriptionLoadingFailed(Object error) {
    return 'Abonelikler yüklenemedi: $error';
  }

  @override
  String get subscriptionManagementTitle => 'Abonelik Yönetimi';

  @override
  String get subscriptionName => 'Abonelik Adı';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Abonelik adı ve URL boş olamaz';

  @override
  String get subscriptionNameHint => 'Abonelik adı girin';

  @override
  String get subscriptionPageTitle => 'Abonelik Yönetimi';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Abonelik durumu değiştirilemedi: $error';
  }

  @override
  String subscriptionToggleFailed(Object error) {
    return 'Abonelik durumu değiştirilemedi: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Abonelik güncellenemedi: $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonelik başarıyla güncellendi';

  @override
  String get subscriptionUrl => 'Abonelik URL\'si';

  @override
  String get subscriptionUrlHint => 'Abonelik URL\'si girin';

  @override
  String successfullyImportedRules(Object count) {
    return '$count kural başarıyla içe aktarıldı';
  }

  @override
  String get supportSync => 'Senkronizasyonu Destekle';

  @override
  String get survey => 'Anket';

  @override
  String get syncDevicesButton => 'Cihazları Senkronize Et';

  @override
  String get syncFailed => 'Senkronizasyon başarısız oldu';

  @override
  String get syncFailedMessage => 'Senkronizasyon başarısız oldu';

  @override
  String get syncFolderNameHint =>
      'Lütfen senkronizasyon klasör adını girin (varsayılan: NotificationManager)';

  @override
  String get syncFolderNameLabel => 'Senkronizasyon Klasör Adı';

  @override
  String get synchronized => 'Senkronize Edildi';

  @override
  String get syncing => 'Senkronize ediliyor...';

  @override
  String get syncNow => 'Şimdi Senkronize Et';

  @override
  String get syncNowButton => 'Şimdi Senkronize Et';

  @override
  String get syncStatusTitle => 'Senkronizasyon Durumu';

  @override
  String get syncStatusUpdatedMessage => 'Senkronizasyon durumu güncellendi';

  @override
  String get syncSuccessful => 'Senkronizasyon başarılı';

  @override
  String get syncSuccessMessage => 'Senkronizasyon başarılı';

  @override
  String get syncWithCloudStorage => 'Bulut Depolama ile Senkronize Et';

  @override
  String get syncWithCloudStorageSubtitle => 'Bulut depolama ile senkronize et';

  @override
  String get systemFeatures => 'Sistem Özellikleri:';

  @override
  String get systemSettingsTitle => 'Sistem Ayarları';

  @override
  String get tabAll => 'Tümü';

  @override
  String get tabAnswered => 'Cevaplanan';

  @override
  String get tabBlocked => 'Engellenen';

  @override
  String get tabMissed => 'Cevapsız';

  @override
  String get tabOutgoing => 'Giden';

  @override
  String tagLabel(String tag) {
    return 'Etiket: $tag';
  }

  @override
  String get tagsUpdated => 'Etiketler güncellendi';

  @override
  String get takeaway => 'Çıkarım';

  @override
  String get telecommunication => 'Telekomünikasyon';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telepazarlama';

  @override
  String get testButton => 'TEST';

  @override
  String get testButtonLabel => 'TEST';

  @override
  String get testConnectionButton => 'Bağlantıyı Test Et';

  @override
  String get textColorsSetting => 'Metin ve Etiket Renkleri';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Bu uygulama, istenmeyen aramaları tanımlamanıza ve engellemenize olanak tanıyan güçlü bir arayan kimliği aracıdır.';

  @override
  String get thisWeek => 'Bu Hafta';

  @override
  String get timeInterceptor => 'Zaman Engelleyici';

  @override
  String get timeInterceptorDescription =>
      'Arama sıklığına göre potansiyel aramaları otomatik olarak engelle/izin ver';

  @override
  String get timeInterceptorExplanation =>
      '• Zaman Engelleyici: Kısa sürede tekrarlanan aramaları engelle/izin ver';

  @override
  String get timeInterceptorExplanationContent =>
      'Arama sıklığı engelleme özelliği, sık aranan spam aramaları otomatik olarak tanımlamak ve engellemek/izin vermek için arama sıklığını analiz eder.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Arama Sıklığı Engelleme Açıklaması';

  @override
  String get timeInterceptorSettingsTitle => 'Arama Sıklığı Engelleme Ayarları';

  @override
  String get timeInterceptorSubtitle =>
      'Arama sıklığına göre potansiyel spam aramaları otomatik olarak engelle';

  @override
  String get timeInterceptorTitle => 'Arama Sıklığı Engellemeyi Etkinleştir';

  @override
  String get timeWindowDescription =>
      'Tekrarlanan aramalara izin vermek için zaman penceresi boyutunu ayarlayın. Bu pencere içindeki aynı numaradan gelen aramalara izin verilecektir';

  @override
  String timeWindowLabel(int minutes) {
    return 'Engelleme Zaman Penceresi (dakika): $minutes';
  }

  @override
  String get timeWindowSetting =>
      'Tekrarlanan aramalara izin vermek için zaman penceresi boyutunu ayarlayın. Bu pencere içindeki aynı numaradan gelen aramalara izin verilecektir';

  @override
  String get today => 'Bugün';

  @override
  String get total => 'Toplam';

  @override
  String get totalBlocked => 'Toplam Engellenen';

  @override
  String get totalFiltered => 'Toplam Filtrelenen';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Verileri cihazlar veya platformlar arasında aktar';

  @override
  String get transferDataBetweenDevicesOrPlatformsSubtitle =>
      'Verileri cihazlar veya platformlar arasında aktar';

  @override
  String get travelTicketing => 'Seyahat Biletleme';

  @override
  String get trend => 'Trend';

  @override
  String get trendChart => 'Trend Grafiği';

  @override
  String get tutorial => 'Eğitim';

  @override
  String get type => 'Tür';

  @override
  String get unassignedSIMCard => 'Atanmamış SIM Kart';

  @override
  String get unknown => 'Bilinmeyen';

  @override
  String get unknownLabel => 'Bilinmeyen Etiket';

  @override
  String get unknownTag => 'Etiket: Bilinmeyen';

  @override
  String get unregisterButton => 'Kaydı Sil';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return '$deviceName kaydını silmek istediğinizden emin misiniz?';
  }

  @override
  String get unregisterDeviceTitle => 'Cihaz Kaydını Sil';

  @override
  String get unsupportedFileFormat => 'Desteklenmeyen dosya formatı';

  @override
  String get update => 'Güncelle';

  @override
  String get updateAllNow => 'Hepsini Şimdi Güncelle';

  @override
  String get updateCallFilterConfig =>
      'Arama Filtresi Yapılandırmasını Güncelle';

  @override
  String updateContactFailed(Object error) {
    return 'Kişi güncellenemedi: $error';
  }

  @override
  String get updateFavoriteStatus => 'Favori Durumunu Güncelle';

  @override
  String updateFavoriteStatusFailed(Object error) {
    return 'Favori durumu güncellenemedi: $error';
  }

  @override
  String get updateInterval => 'Güncelleme Aralığı';

  @override
  String get updateLabelFailed => 'Etiket güncellenemedi';

  @override
  String get updateNow => 'Şimdi Güncelle';

  @override
  String get updatePlugin => 'Eklentiyi Güncelle';

  @override
  String updatePluginFailed(Object error) {
    return 'Eklenti güncellenemedi: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Kural güncellenemedi: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Abonelik güncellenemedi: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service başarıyla güncellendi ($count kural)';
  }

  @override
  String get updateTags => 'Etiketleri Güncelle';

  @override
  String get useCasesPoint1 =>
      '• Otomatik yeniden arama spam aramalarını belirle';

  @override
  String get useCasesPoint2 =>
      '• Kısa sürede birden çok kez arayan pazarlama aramalarını engelle';

  @override
  String get useCasesPoint3 => '• Telefon bombardımanını ve tacizi önle';

  @override
  String get useCasesTitle => 'Kullanım Durumları:';

  @override
  String get useGlobalSettings => 'Genel Ayarları Kullan';

  @override
  String get userEmail => 'user@example.com';

  @override
  String get usernameLabel => 'Kullanıcı Adı';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Desenleri tanımlamak için standart regex sözdizimini kullanın. Örnekler:';

  @override
  String get validateRegex => 'Regex Doğrula';

  @override
  String get verificationFailedText => 'Başarısız';

  @override
  String get verifiedText => 'Doğrulandı';

  @override
  String get verify => 'Doğrula';

  @override
  String version(Object version) {
    return 'Sürüm: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Telefon numarası işaretleme sayılarıyla VIP üyeliğini değiştir';

  @override
  String get vipExchangeTitle => 'İşaret Takası VIP';

  @override
  String get watchAd => 'Reklam İzle';

  @override
  String get watchAdForTemp => 'Geçici Ayrıcalıklar için Reklam İzle';

  @override
  String get watchAdForTempDescription =>
      'Bazı premium özellikleri geçici olarak açmak için kısa bir reklam izleyin';

  @override
  String get webDAVConfigTitle => 'WebDAV Yapılandırması';

  @override
  String get webdavConfigurationTitle => 'WebDAV Yapılandırması';

  @override
  String get webdavPasswordHint => 'Lütfen WebDAV şifresini girin';

  @override
  String get webdavServerAddressHint => 'Lütfen WebDAV sunucu adresini girin';

  @override
  String get webdavUsernameHint => 'Lütfen WebDAV kullanıcı adını girin';

  @override
  String get week => 'Hafta';

  @override
  String get weekly => 'Haftalık';

  @override
  String get weeklyBlockedCallsSummary => 'Haftalık Engellenen Aramalar Özeti';

  @override
  String get weeklyChartTitle => 'Haftalık Engellenen Aramalar';

  @override
  String get weeklyReport => 'Haftalık Rapor';

  @override
  String get weeklyReportDesc =>
      'Arama engelleme etkinliğinin haftalık özet raporunu al';

  @override
  String get welcome => 'Hoş Geldiniz';

  @override
  String get whitelist => 'Beyaz Liste';

  @override
  String get whitelistLabel => 'Beyaz Liste';

  @override
  String get width => 'Genişlik';

  @override
  String get wildcardMatchingDescription =>
      'Herhangi bir karakterle eşleştirmek için \'.\' kullanın (örneğin \'123.456\', 123-456 ile eşleşir)';

  @override
  String get wildcardMatchingTitle => 'Joker karakter eşleştirme:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Esnek Filtreleme için Joker Karakter Desteği';

  @override
  String get windowSizeSetting => 'Pencere Boyutu';

  @override
  String get year => 'Yıl';

  @override
  String get yearly => 'Yıllık';

  @override
  String get yearlyChartTitle => 'Yıllık Engellenen Aramalar';

  @override
  String get noSimCardsDetected => 'SIM kart algılanmadı';

  @override
  String get filterManagementDescription => 'Arama Filtrelerini Ayarlayın';

  @override
  String get callerIdCustomizationSubtitle =>
      'Arayan Kimliği Düzenini Özelleştirme';

  @override
  String get fraudAlerSettingTitle => 'Dolandırıcılık Uyarısı Ayarı';

  @override
  String get fraudAlerSettingSubtitle =>
      'Dolandırıcılık Uyarısını Ayarlamak İçin';

  @override
  String get enableFraudAlert => 'Dolandırıcılık Uyarısını Etkinleştir';

  @override
  String get enableFraudAlertDescription =>
      'Şüpheli dolandırıcılık aramaları için uyarı';

  @override
  String get enableVibration => 'Titreşimi Etkinleştir';

  @override
  String get enableVibrationDescription =>
      'Arama şüpheli dolandırıcılık olduğunda titre';

  @override
  String get notificationSettingsTitle => 'Bildirim Ayarları';

  @override
  String get useLocalNotification => 'Yerel Bildirimleri Kullan';

  @override
  String get useLocalNotificationDescription =>
      'Gelen aramalar için yerel bildirimleri etkinleştir';

  @override
  String get cancelLocalNotification => 'Yerel Bildirimleri Kapat';

  @override
  String get useStirNotification => 'STIR Bildirimini Kullan';

  @override
  String get useStirNotificationDescription =>
      'Gelen aramalar için STIR bildirimlerini etkinleştir';

  @override
  String get cancelLocalNotificationDescription =>
      'Yerel Bildirimleri Otomatik Kapat';

  @override
  String get callerIdSettingsTitle => 'Arayan Kimliği Ayarları';

  @override
  String get callerIdSettingsSubtitle =>
      'Gelen Arama Bildirimi ve Görüntüleme Modunu Ayarlamak İçin';

  @override
  String get purchaseTitle => 'Satın Al';

  @override
  String get purchaseSubtitle => 'Hizmeti Satın Almak İçin';

  @override
  String get callerIdNotificationTitle => 'Gelen Arama Bilgisi';

  @override
  String callerIdBody(String phoneNumber) {
    return 'Numara: $phoneNumber';
  }

  @override
  String get blockedCallTitle => 'Engellenen Arama';

  @override
  String blockedCallBody(String phoneNumber) {
    return '$phoneNumber numarasından engellenen arama';
  }

  @override
  String get stirVerified => 'Doğrulandı';

  @override
  String get stirNotVerified => 'Doğrulanmadı';

  @override
  String get stirFailed => 'Doğrulama Başarısız';

  @override
  String get stirUnknown => 'Bilinmeyen Doğrulama Durumu';

  @override
  String get stirVerificationTitle => 'STIR/SHAKEN Doğrulaması';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$phoneNumber numarası için $stirResultMessage';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Kaydırma Güvenlik Mesajı Ayarları';

  @override
  String get messageColor => 'Mesaj Rengi';

  @override
  String get messageFontSize => 'Mesaj Yazı Tipi Boyutu';

  @override
  String get messagePosition => 'Mesaj Konumu';

  @override
  String get containerWidth => 'Kapsayıcı Genişliği';

  @override
  String get scrollSpeed => 'Kaydırma Hızı';

  @override
  String get enableSecurityMessage => 'Güvenlik Mesajını Etkinleştir';

  @override
  String get fraudAlertTitle => 'Dolandırıcılık Uyarısı';

  @override
  String fraudAlertBody(String phoneNumber) {
    return '$phoneNumber numarasından potansiyel dolandırıcılık araması';
  }

  @override
  String loadRulesFailed(Object error) {
    return 'Kurallar yüklenemedi: $error';
  }

  @override
  String loadCallLogFailed(Object error) {
    return 'Arama kaydı yüklenemedi: $error';
  }

  @override
  String get noBlockedTypeData => 'Engellenen tür verisi mevcut değil';

  @override
  String importEntity(Object entityTypeName) {
    return '$entityTypeName İçe Aktar';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName başarıyla içe aktarıldı, toplam $count kayıt içe aktarıldı';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName içe aktarılamadı: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return '$entityTypeName Dışa Aktar';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName başarıyla dışa aktarıldı';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return '$entityTypeName dışa aktarılamadı: $error';
  }

  @override
  String get cloudSyncService => 'Bulut Senkronizasyon Hizmeti';

  @override
  String get membershipCenter => 'Üyelik Merkezi';

  @override
  String get redeemVipWithMarks => 'İşaretlerle VIP Kullan';

  @override
  String get currentMarkCount => 'Mevcut İşaret Sayısı';

  @override
  String get markMoreNumbersForMore =>
      'Daha fazla işaret için daha fazla numara işaretle';

  @override
  String get noAds => 'Reklamsız';

  @override
  String get cloudBackup => 'Bulut Yedekleme';

  @override
  String get callerIdEnhancement => 'Arayan Kimliği İyileştirmesi';

  @override
  String get voiceRecognition => 'Ses Tanıma';

  @override
  String get feature => 'Özellik';

  @override
  String get normalUser => 'Normal Kullanıcı';

  @override
  String get vipUser => 'VIP Kullanıcı';

  @override
  String get temporaryVip => 'Geçici VIP';

  @override
  String get removeAds => 'Reklamları Kaldır';

  @override
  String get unknownAction => 'Bilinmeyen Eylem';

  @override
  String get settingsBackup => 'Ayarlar Yedekleme';

  @override
  String get allServicesStatusTitle => 'Mevcut Hizmet Durumu';

  @override
  String get allServicesStatusSubtitle => 'Her Bulut Hizmetinin Mevcut Durumu';

  @override
  String get redirect => 'Yönlendir';

  @override
  String get notify => 'Bildir';

  @override
  String get log => 'Kaydet';

  @override
  String get custom => 'Özel';

  @override
  String get allowActionDescription =>
      'Numara engellenenler listesinde olsa bile aramalar izin verilecektir.';

  @override
  String get blockActionDescription =>
      'Aramalar engellenecek ve arama kaydında gösterilecektir.';

  @override
  String get silenceActionDescription =>
      'Aramalar sessize alınacak ancak arama kaydında gösterilecektir.';

  @override
  String get noneActionDescription =>
      'Arama için özel bir işlem yapılmayacaktır.';

  @override
  String get redirectActionDescription =>
      'Aramayı belirli bir numaraya yönlendir.';

  @override
  String get labelActionDescription =>
      'Kolay tanımlama için aramaya bir etiket ekle.';

  @override
  String get notifyActionDescription =>
      'Bir arama alındığında bildirim gönder.';

  @override
  String get logActionDescription =>
      'Başka bir işlem yapmadan arama bilgilerini kaydet.';

  @override
  String get customActionDescription => 'Özel bir eylem gerçekleştir.';

  @override
  String get synced => 'Senkronize Edildi';

  @override
  String get needVipAccess =>
      'Bu özelliği kullanmak için VIP erişimine ihtiyacınız var';

  @override
  String importExportDescription(Object entityTypeName) {
    return '$entityTypeName verilerini içe veya dışa aktar';
  }

  @override
  String get importExportTitle => 'İçe/Dışa Aktar';

  @override
  String get noPhoneRules => 'Telefon kuralı bulunamadı';

  @override
  String get noRegexRules => 'Regex kuralı bulunamadı';

  @override
  String get noAllowedBlockedRules =>
      'İzin verilen/engellenen kuralı bulunamadı';

  @override
  String get importExport => 'İçe/Dışa Aktar';

  @override
  String get filterByAction => 'Eyleme Göre Filtrele';

  @override
  String get upgradeToVip => 'VIP\'e Yükselt';

  @override
  String get batteryOptimizationPermission => 'Pil Optimizasyonu';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Arayan kimliği gibi hizmetleri sağlamak için uygulamanın arka planda çalışmasına izin verin.';

  @override
  String get permissionTitle => 'Özel İzinler';

  @override
  String get permissionSubtitle =>
      'Yer paylaşımı ve pil optimizasyonu izinlerini yönetin';

  @override
  String get themeSettingsTitle => 'Tema Ayarları';

  @override
  String get themeSettingsSubtitle => 'Favori temanızı seçin';

  @override
  String get databaseSyncTitle => 'Veritabanı Senkronizasyonu';

  @override
  String get countrySyncSettingsTitle =>
      'Ülke Bazlı Veritabanı Senkronizasyon Ayarları';

  @override
  String get countrySyncSettingsSubtitle =>
      'Veri senkronizasyonu için ülkeleri seçin';

  @override
  String get countryDataDisclaimer =>
      'Lütfen dikkat: Veritabanı tüm belirli ülkeler veya bölgeler için veri içermeyebilir.';

  @override
  String get editSubscription => 'Aboneliği Düzenle';

  @override
  String get searchByNameOrPhoneNumber =>
      'İsim veya Telefon Numarasına Göre Ara';

  @override
  String get allowedBlockedRulesInfo =>
      'İzin verilen/engellenen kurallar, en yüksek önceliğe sahip belirli telefon numaralarıyla çağrıları eşleştirmek için kullanılır.';

  @override
  String get searchPhoneRulesHint => 'Telefon kurallarını ara';

  @override
  String get phoneRulesInfo =>
      'Telefon kuralları, daha düşük önceliğe sahip belirli telefon numaralarıyla çağrıları eşleştirmek için kullanılır. Bazıları phoneRule aboneliklerinden gelir';

  @override
  String get searchSubscriptionsHint => 'Abonelikleri ara';

  @override
  String get searchPluginsHint => 'Eklentileri ara';

  @override
  String get searchLabelsHint => 'Etiketleri ara';

  @override
  String get pluginDescription => 'Eklenti açıklaması';

  @override
  String get enterPluginDescription => 'Eklenti açıklamasını girin';

  @override
  String get searchRegexRulesHint => 'Regex kurallarını ara';

  @override
  String get regexRulesInfo =>
      'Regex kuralları, çağrıları Regex Desenlerine göre filtrelemek için kullanılır.';

  @override
  String get searchMarkedPhonesHint => 'İşaretlenmiş telefonları ara';

  @override
  String get searchContactSubscriptionsHint => 'Kişi aboneliklerini ara';

  @override
  String get showAllContacts => 'Tüm Kişileri Göster';

  @override
  String get showFavorites => 'Favorileri Göster';

  @override
  String get manualEntry => 'Manuel Giriş Bilgisi';

  @override
  String get scriptSaved => 'Betik kaydedildi';

  @override
  String editScriptFor(String pluginName) {
    return '$pluginName için betiği düzenle';
  }

  @override
  String get saveScript => 'Betiği Kaydet';

  @override
  String get testPlugin => 'Eklentiyi Test Et';

  @override
  String get description => 'Açıklama';

  @override
  String get accessTargetUrl => 'Hedef URL\'ye Eriş';

  @override
  String get result => 'Sonuç';

  @override
  String get editScript => 'Betiği Düzenle';

  @override
  String get numberFormat => 'Numara Biçimi';

  @override
  String get nationalNumber => 'Ulusal Numara';

  @override
  String get e164Number => 'E164 Numara';

  @override
  String get pluginRulesInfo =>
      'Güvenlik için lütfen yalnızca güvenilir kaynaklardan eklentileri kullanın. Kendi özel eklentilerinizi oluşturmak için şablonlarımızı kullanmaktan çekinmeyin!';

  @override
  String get advancedMode => 'Gelişmiş Mod';

  @override
  String get pleaseEnterAtLeastOneNumber => 'Lütfen en az bir numara girin.';

  @override
  String get openInWebView => 'WebView\'da Aç';

  @override
  String get pluginLabel => 'Eklenti Etiketi';

  @override
  String get pluginID => 'Kimlik';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Mesaj Arka Plan Rengi';

  @override
  String get clearAllCallLogs => 'Tüm Çağrı Kayıtlarını Temizle';

  @override
  String get clearAllCallLogsConfirmation =>
      'Tüm çağrı kayıtlarını temizlemeyi onayla';

  @override
  String get allCallLogsCleared => 'Tüm çağrı kayıtları temizlendi';

  @override
  String get unblocked => 'Engeli kaldırıldı';

  @override
  String get blockNumber => 'Numarayı Engelle';

  @override
  String get blockNumberSuccess => 'Numara engelleme başarılı';

  @override
  String get blockNumberFailed => 'Numara engelleme başarısız';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return '$phoneNumber engelini kaldırmak istediğinizden emin misiniz?';
  }

  @override
  String callingNumber(String phoneNumber) {
    return '$phoneNumber aranıyor...';
  }

  @override
  String get viewDetails => 'Detayları Görüntüle';

  @override
  String get unblock => 'Engeli Kaldır';

  @override
  String get unblockNumber => 'Numaranın Engelini Kaldır';

  @override
  String get unblockNumberSuccess => 'Numaranın engeli başarıyla kaldırıldı';

  @override
  String get unblockNumberFailed => 'Numaranın engeli kaldırılamadı';

  @override
  String get serviceNotAvailable => 'Hizmet mevcut değil';

  @override
  String get callingNumberFailed => 'Numara arama başarısız oldu';

  @override
  String get listView => 'Liste Görünümü';

  @override
  String get timelineView => 'Zaman Çizelgesi Görünümü';

  @override
  String get nameCannotBeEmpty => 'İsim boş olamaz';

  @override
  String get selectAction => 'Eylemi seçin';

  @override
  String get selectTargetService => 'Hedef hizmeti seçin';

  @override
  String get callDetails => 'Çağrı Detayları';

  @override
  String get callType => 'Çağrı Türü';

  @override
  String get callTime => 'Çağrı Saati';

  @override
  String get numberInvalidFormat => 'Numara geçersiz biçimde';

  @override
  String get membershipFeature => 'Üyelik Özelliği';

  @override
  String get medium => 'Orta';

  @override
  String get verificationReport => 'Doğrulama Raporu';

  @override
  String get finalRisk => 'Nihai Risk';

  @override
  String get simState => 'SIM Durumu';

  @override
  String get ipCountry => 'IP Ülkesi';

  @override
  String get simCountry => 'SIM Ülkesi';

  @override
  String get isRoaming => 'Dolaşım';

  @override
  String get isNumberMatch => 'Numara Eşleşmesi';

  @override
  String get support => 'Destek';

  @override
  String get rewardedAdService => 'Ödüllü Reklam Hizmeti';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Zaten VIP ayrıcalıklarına sahipsiniz (reklamlar hariç)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Zaten geçici ayrıcalıklara sahipsiniz, son kullanma tarihi: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Geçici VIP ayrıcalıklarını almak için $count reklam daha izlemeniz gerekiyor';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return '$days günlük geçici satın alma ayrıcalıkları verildi. Son kullanma tarihi: $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Geçici satın alma ayrıcalığı sona erdi';

  @override
  String get loadingAd => 'Reklam Yükleniyor...';

  @override
  String get earnedTempVip => 'Geçici VIP kazanıldı';

  @override
  String get vipExchangeService => 'VIP Takas Hizmeti';

  @override
  String get marksInsufficient => 'Takas için yetersiz işaret';

  @override
  String get invalidExchangeRule => 'Geçersiz takas kuralı';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return '$description ile başarıyla takas edildi, son kullanma tarihi: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Takas başarısız: $error';
  }

  @override
  String get vip3DaysWithAds =>
      'Reklamlı 3 günlük VIP (yalnızca senkronizasyon)';

  @override
  String get vip5DaysNoAds => '5 günlük tam özellikli reklamsız VIP';

  @override
  String get vip7DaysNoAds => '7 günlük tam özellikli reklamsız VIP';

  @override
  String get noNotifications => 'Bildirim yok';

  @override
  String get clearAllNotifications => 'Tüm Bildirimleri Temizle';

  @override
  String get clearAllNotificationsConfirmation =>
      'Tüm bildirimleri temizlemeyi onayla';

  @override
  String get allNotificationsCleared => 'Tüm bildirimler temizlendi';

  @override
  String get clearButton => 'Temizle';

  @override
  String get justNow => 'Şimdi';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dakika önce',
      one: '1 dakika önce',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saat önce',
      one: '1 saat önce',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gün önce',
      one: '1 gün önce',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Dün';

  @override
  String get deletionProposal => 'Silme Teklifi';

  @override
  String get deletionProposals => 'Silme Teklifleri';

  @override
  String get createProposal => 'Teklif Oluştur';

  @override
  String get createProposalTitle => 'Silme Teklifi Oluştur';

  @override
  String get reason => 'Sebep';

  @override
  String get reasonOutdated => 'Eski Numara';

  @override
  String get reasonPrivacy => 'Gizlilik Endişesi';

  @override
  String get reasonNotInService => 'Kullanımda Değil';

  @override
  String get reasonWronglyIdentified => 'Yanlış Tanımlanmış';

  @override
  String get reasonInaccurateInfo => 'Hatalı Bilgi';

  @override
  String get reasonWrongMarked => 'Yanlış İşaretlenmiş';

  @override
  String get reasonOther => 'Diğer';

  @override
  String get submit => 'Gönder';

  @override
  String get cancel => 'İptal';

  @override
  String get proposalStatus => 'Durum';

  @override
  String get statusPending => 'Beklemede';

  @override
  String get statusActive => 'Aktif';

  @override
  String get statusCompleted => 'Tamamlandı';

  @override
  String get statusExpired => 'Süresi Dolmuş';

  @override
  String get riskLevel => 'Risk Seviyesi';

  @override
  String get riskLevelVerified => 'Doğrulanmış';

  @override
  String get riskLevelLow => 'Düşük';

  @override
  String get riskLevelHigh => 'Yüksek';

  @override
  String get riskLevelUnknown => 'Bilinmiyor';

  @override
  String get votingProgress => 'Oylama İlerlemesi';

  @override
  String agreeVotes(int count) {
    return 'Katılıyor: $count';
  }

  @override
  String disagreeVotes(int count) {
    return 'Katılmıyor: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Toplam: $count';
  }

  @override
  String get voteAgree => 'Katılıyorum';

  @override
  String get voteDisagree => 'Katılmıyorum';

  @override
  String createdAt(String date) {
    return 'Oluşturulma Tarihi: $date';
  }

  @override
  String get showReport => 'Raporu Göster';

  @override
  String get hideReport => 'Raporu Gizle';

  @override
  String get proposalStatistics => 'Teklif İstatistikleri';

  @override
  String get totalProposals => 'Toplam Teklifler';

  @override
  String get activeProposals => 'Aktif Teklifler';

  @override
  String get completedProposals => 'Tamamlanmış Teklifler';

  @override
  String get myVotes => 'Oylarım';

  @override
  String get proposalCreated => 'Teklif başarıyla oluşturuldu';

  @override
  String get proposalCreateFailed => 'Teklif oluşturulamadı';

  @override
  String get voteSubmitted => 'Oy başarıyla gönderildi';

  @override
  String get voteSubmitFailed => 'Oy gönderme başarısız oldu';

  @override
  String get noProposalsFound => 'Teklif bulunamadı';

  @override
  String get loadingProposals => 'Teklifler yükleniyor...';

  @override
  String get refreshProposals => 'Teklifleri Yenile';

  @override
  String get totalPendingProposals => 'Toplam Bekleyen Teklifler';

  @override
  String get highRisk => 'Yüksek Risk';

  @override
  String get mediumRisk => 'Orta Risk';

  @override
  String get lowRisk => 'Düşük Risk';

  @override
  String get communityImpact => 'Topluluk Etkisi';

  @override
  String get criticalIssues => 'Kritik Sorunlar';

  @override
  String get communityParticipation => 'Topluluk Katılımı';

  @override
  String get noActivity => 'Etkinlik Yok';

  @override
  String get low => 'Düşük';

  @override
  String get moderate => 'Orta';

  @override
  String get high => 'Yüksek';

  @override
  String get veryHigh => 'Çok Yüksek';

  @override
  String get voted => 'Oy Verildi';

  @override
  String get communityVotes => 'Topluluk oyları';

  @override
  String get waitingForMoreVotes => 'Daha fazla topluluk oyu bekleniyor';

  @override
  String get proposalProcessed => 'Bu teklif işlendi';

  @override
  String get supported => 'DESTEKLENİYOR';

  @override
  String get opposed => 'KARŞI ÇIKILDI';

  @override
  String get approved => 'ONAYLANDI';

  @override
  String get rejected => 'REDDEDİLDİ';

  @override
  String get completed => 'TAMAMLANDI';

  @override
  String get pending => 'BEKLEMEDE';

  @override
  String get critical => 'Kritik';

  @override
  String get oppose => 'Karşı Çık';

  @override
  String get veryLow => 'Çok Düşük';

  @override
  String get deletionProposalNotificationDescription =>
      'Silme teklifi oylama sonuçları ve güncellemeleri hakkında bildirimler.';

  @override
  String get deletionProposalCreated => 'Silme Teklifi Oluşturuldu';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return '$phoneNumber numarası için silme teklifiniz topluluk incelemesine sunulmuştur.';
  }

  @override
  String get proposalApproved => 'Teklif Onaylandı ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber numarası için silme teklifi topluluk tarafından onaylandı (%$supportPercentage destek, $totalVotes oy).';
  }

  @override
  String get proposalRejected => 'Teklif Reddedildi ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return '$phoneNumber numarası için silme teklifi topluluk tarafından reddedildi (%$supportPercentage destek, $totalVotes oy).';
  }

  @override
  String get communityVotingStarted => 'Topluluk Oylaması Başladı';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return '$phoneNumber numarası için yeni bir silme teklifi topluluk oylamasına açıldı.';
  }

  @override
  String get votingCompleted => 'Oylama Tamamlandı';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return '$phoneNumber için topluluk oylaması sona erdi. Sonuç: $result (%$supportPercentage destek).';
  }

  @override
  String get newVoteReceived => 'Yeni Oy Alındı';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Biri $phoneNumber silinmesi teklifine $voteType oy kullandı. Mevcut oylar: $totalVotes.';
  }

  @override
  String get loadVoteCountFailed => 'Oy sayısı yüklenemedi';

  @override
  String get voteCount => 'Oy Sayısı';

  @override
  String get deletionProposalInfo => 'Silme Teklifi Bilgileri';

  @override
  String get deletionProposalDescription =>
      'Topluluk kurallarını ihlal eden numaralar için silme teklifi oluşturun. Katılımınız platformun güvenli kalmasına yardımcı olur.';

  @override
  String get voteToEarnVip =>
      'VIP ayrıcalıkları kazanmak için teklifleri oylayın!';

  @override
  String get voteFailed => 'Oy verme başarısız oldu';

  @override
  String get searchProposals => 'Teklif Ara';

  @override
  String get defaultNotifications => 'Varsayılan Bildirimler';

  @override
  String get defaultNotificationsDescription =>
      'Uygulama için varsayılan bildirim kanalı.';

  @override
  String get blockedCallNotifications => 'Engellenen Çağrı Bildirimleri';

  @override
  String get blockedCallNotificationsDescription =>
      'Engellenen aramalar hakkında bilgi görüntüler.';

  @override
  String get stirVerification => 'STIR/SHAKEN Doğrulaması';

  @override
  String get stirVerificationDescription =>
      'Numaralar için STIR/SHAKEN doğrulama sonuçlarını görüntüler.';

  @override
  String get fraudAlerts => 'Dolandırıcılık Uyarıları';

  @override
  String get fraudAlertsDescription =>
      'Olası dolandırıcılık aramaları için uyarıları görüntüler.';

  @override
  String get notificationFrequencyDescription =>
      'Yeni silme önerileri hakkında ne sıklıkta bildirim alacağınızı seçin. Bildirimleri anında, toplu olarak veya özel bir aralıkta alabilirsiniz.';

  @override
  String get immediateNotifications => 'Anında';

  @override
  String get immediateNotificationsDescription =>
      'Bir öneri oluşturulur oluşturulmaz bildirim alın.';

  @override
  String get batchNotifications => 'Toplu';

  @override
  String get batchNotificationsDescription =>
      'Bildirimlerin özetini periyodik olarak alın.';

  @override
  String get customNotifications => 'Özel';

  @override
  String get customNotificationsDescription =>
      'Bildirim almak için kendi aralığınızı tanımlayın.';

  @override
  String get customFrequency => 'Özel Sıklık';

  @override
  String notificationFrequencyDurationMinutes(int minutes) {
    return '$minutes dk';
  }

  @override
  String notificationFrequencyDurationHours(int hours) {
    return '$hours s';
  }

  @override
  String notificationFrequencyDurationHoursAndMinutes(int hours, int minutes) {
    return '$hours s $minutes dk';
  }

  @override
  String get pendingProposals => 'Bekleyen Öneriler';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count öneri',
      one: '1 öneri',
      zero: 'öneriniz yok',
    );
    return 'Bekleyen $_temp0 var.';
  }

  @override
  String get guidelinesLabel => 'Yönergeler';

  @override
  String get reportingGuidelines =>
      '• Yalnızca gerçekten sorunlu numaraları bildirin\n• Doğru ve ayrıntılı nedenler belirtin\n• Ciddiyete göre uygun risk seviyesini seçin\n• Yanlış bildirimler hesap kısıtlamalarına yol açabilir';

  @override
  String get riskLevelLabel => 'Risk Seviyesi';

  @override
  String get riskLevelDescription => 'Numaranın risk seviyesi';

  @override
  String get phoneNumberMinDigits =>
      'Telefon numarası en az 7 haneli olmalıdır';

  @override
  String get provideDetailedExplanation =>
      'Ayrıntılı açıklama sağlayın (minimum 10 karakter)';

  @override
  String get reasonMinCharacters => 'Neden en az 10 karakter olmalıdır';

  @override
  String get countryCodeTwoLetters => 'Ülke Kodu (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Ülke Kodu (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'örn., US, CN, GB';

  @override
  String get countryCodeRequired => 'Ülke kodu zorunludur';

  @override
  String get countryCodeLengthError => 'Ülke kodu 2 harf olmalıdır';

  @override
  String get phoneNumberLengthError =>
      'Telefon numarası en az 7 haneli olmalıdır';

  @override
  String get reasonHint => 'Ayrıntılı açıklama sağlayın (minimum 10 karakter)';

  @override
  String get reasonRequired => 'Neden zorunludur';

  @override
  String get reasonLengthError => 'Neden en az 10 karakter olmalıdır';

  @override
  String get guidelinesTitle => 'Yönergeler';

  @override
  String get guidelinesText =>
      '• Yalnızca gerçekten sorunlu numaraları bildirin\n• Doğru ve ayrıntılı nedenler belirtin\n• Ciddiyete göre uygun risk seviyesini seçin\n• Yanlış bildirimler hesap kısıtlamalarına yol açabilir';

  @override
  String get riskLevelCritical => 'Kritik';

  @override
  String get riskLevelMedium => 'Orta';

  @override
  String get riskLevelVeryLow => 'Çok Düşük';

  @override
  String get riskDescriptionVeryLow =>
      'Çok Düşük - Hafif rahatsızlık, seyrek aramalar';

  @override
  String get riskDescriptionLow => 'Düşük - Ara sıra istenmeyen aramalar';

  @override
  String get riskDescriptionMedium => 'Orta - Düzenli spam veya tele pazarlama';

  @override
  String get riskDescriptionHigh =>
      'Yüksek - Sürekli taciz veya dolandırıcılık girişimleri';

  @override
  String get riskDescriptionCritical =>
      'Kritik - Tehlikeli dolandırıcılık veya tehditler';

  @override
  String get notificationFrequencyTitle => 'Bildirim Sıklığı';

  @override
  String get notificationFrequencyLabel => 'Bildirim Sıklığı (saat)';

  @override
  String errorMessage(String error) {
    return 'Hata: $error';
  }

  @override
  String votesStatistics(int totalVotes, int supportPercentage) {
    return 'Oylar: $totalVotes (%$supportPercentage destek)';
  }

  @override
  String supportCount(int supportCount) {
    return 'Destek ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Karşı Çık ($opposeCount)';
  }

  @override
  String get timeJustNow => 'Şimdi';

  @override
  String timeMinutesAgo(int minutes) {
    return '$minutes dakika önce';
  }

  @override
  String timeHoursAgo(int hours) {
    return '$hours saat önce';
  }

  @override
  String timeDaysAgo(int days) {
    return '$days gün önce';
  }

  @override
  String get notificationFrequencyHours => 'Bildirim Sıklığı (Saat)';

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes oy (%$supportPercentage destek)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saat',
      one: '1 saat',
      zero: '0 saat',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Önemli Uyarı';

  @override
  String get dataSourceDisclaimer =>
      'Numaralar internetten ve kullanıcı gönderimlerinden alınmıştır. Bir numaranın silindikten sonra diğer kullanıcılar veya kaynaklar tarafından yeniden gönderilmeyeceğini garanti edemeyiz. Lütfen bilgileri aktif olarak arayın ve doğrulayın.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Konum';

  @override
  String get simCardTitle => 'SIM Kart';

  @override
  String get liveActivitiesSettingsTitle => 'Canlı Etkinlikler Ayarları';

  @override
  String get elementsSettingsTitle => 'Öğe Ayarları';

  @override
  String get liveActivityMode => 'Canlı Etkinlik';

  @override
  String get liveActivityModeDescription =>
      'Arama bilgilerini kilit ekranında ve Dinamik Ada\'da (iOS) kalıcı bir bildirim olarak görüntüler.';

  @override
  String get phoneNumberType => 'Telefon Numarası Türü';

  @override
  String get liveActivitiesTestEndActivity => 'Etkinliği Sonlandır';

  @override
  String get liveActivitiesTestSendNewActivity => 'Yeni Etkinlik Gönder';

  @override
  String get liveActivitiesTestUpdateActivity => 'Etkinliği Güncelle';

  @override
  String get liveActivityControlsTitle => 'Canlı Etkinlik Kontrolleri';

  @override
  String get liveActivitiesTestTitle => 'Canlı Etkinlikler Testi';

  @override
  String get liveActivitiesTestSubtitle =>
      'Canlı etkinlik bildirimini test edin.';

  @override
  String get liveNotificationCustomizationTitle =>
      'Canlı Bildirim Özelleştirmesi';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Canlı bildirimlerin görünümünü özelleştirin.';

  @override
  String get notification_instructions =>
      'Talimatlar:\n1. Bildirim oluşturmak veya güncellemek için \"GÖNDER\"e dokunun.\n2. Sonucu görmek için ana ekranınıza gidin veya bildirim çekmecesini aşağı kaydırın.\n3. Bildirimi kapatmak için \"SONLANDIR\"a dokunun.';

  @override
  String get autoCancelNotification => 'Otomatik İptal Bildirimi';

  @override
  String get autoCancelNotificationDescription =>
      'İşaretlenirse, kullanıcı dokunduğunda bildirim otomatik olarak kapatılır.';

  @override
  String get setDelayTime => 'Gecikme Süresini Ayarla';

  @override
  String get proposalDetails => 'Öneri Detayları';

  @override
  String get filterByStatus => 'Duruma Göre Filtrele';

  @override
  String get proposalNotFound => 'Öneri bulunamadı';

  @override
  String get processed => 'İşlendi';

  @override
  String get showAll => 'Tümünü Göster';

  @override
  String get filterAndSortTitle => 'Filtrele ve Sırala';

  @override
  String get filterVerifiedOwner => 'Doğrulanmış Sahibi Filtrele';

  @override
  String get filterBy => 'Filtrele';

  @override
  String get sortOldest => 'En Eskiye Göre Sırala';

  @override
  String get sortNewest => 'En Yeniye Göre Sırala';

  @override
  String get sortMostPopular => 'En Popülere Göre Sırala';

  @override
  String get sortLeastPopular => 'En Az Popülere Göre Sırala';

  @override
  String get sortBy => 'Sırala';

  @override
  String get simRulesNotFound => 'SIM Kuralları bulunamadı';

  @override
  String get simSlotRules => 'SIM Yuvası Kuralları';

  @override
  String get noSimCardDetected => 'SIM kart algılanmadı';

  @override
  String get invalidSimData => 'Geçersiz SIM verisi';

  @override
  String get simCardData => 'SIM Kart Verileri';

  @override
  String get simSlot => 'SIM Yuvası';

  @override
  String get enableFiltering => 'Filtrelemeyi Etkinleştir';

  @override
  String get detailedSettingsTitle => 'Ayrıntılı Ayarlar';

  @override
  String get entryPointViewTitle => 'Giriş Noktası Görünümü';

  @override
  String get callTypeRejected => 'Reddedildi';

  @override
  String get callTypeSilenced => 'Sessize Alındı';

  @override
  String get callTypeVoicemail => 'Sesli Mesaj';

  @override
  String get callTypeUnknownIntercept => 'Bilinmeyen Kesme';

  @override
  String andMoreItems(int count) {
    return 've $count öğe daha';
  }

  @override
  String get ruleType => 'Rule Type';

  @override
  String get localDatabaseSyncTitle => 'Local Database Sync';

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
  String get lastSync => 'Last Sync';
}
