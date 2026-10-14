// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get aboutContactSubscription => 'Informazioni su Abbonamento Contatto';

  @override
  String get aboutLabels => 'Informazioni Etichette';

  @override
  String get aboutPhoneSubscriptionRules =>
      'Informazioni Regole Abbonamento Telefono';

  @override
  String get aboutSmsFilter => 'Informazioni Filtro SMS';

  @override
  String get aboutSmsSubscriptionRules => 'Informazioni Regole Abbonamento SMS';

  @override
  String get aboutSubtitle =>
      'Informazioni legali e sulla versione dell\'applicazione';

  @override
  String get aboutTitle => 'Informazioni';

  @override
  String get action => 'Azione';

  @override
  String get actionAll => 'Tutto';

  @override
  String get actionAllow => 'Consenti';

  @override
  String get actionBlock => 'Blocca';

  @override
  String get actionFilterTitle => 'Filtra per Tipo di Azione';

  @override
  String get actionFilterTooltip => 'Filtro Azione';

  @override
  String get actionNone => 'Nessuna Azione';

  @override
  String get actionSilence => 'Silenzia';

  @override
  String actionTag(Object actionType) {
    return 'Azione: $actionType';
  }

  @override
  String get actionType => 'Tipo di Azione';

  @override
  String get actionUnknown => 'Sconosciuto';

  @override
  String get add => 'Aggiungi';

  @override
  String get addAllowedBlockedRule => 'Aggiungi Regola Consenti/Blocca';

  @override
  String get addAllowSubscription => 'Aggiungi Abbonamento Consenti';

  @override
  String get addBlockSubscription => 'Aggiungi Abbonamento Blocca';

  @override
  String get addContactButton => 'Aggiungi Contatto';

  @override
  String addContactFailed(Object error) {
    return 'Impossibile aggiungere contatto: $error';
  }

  @override
  String get addedToFavorites => 'Aggiunto ai preferiti';

  @override
  String get addLabel => 'Aggiungi Etichetta';

  @override
  String get addLabelButton => 'Aggiungi Etichetta';

  @override
  String addLabelFailed(Object error) {
    return 'Impossibile aggiungere etichetta: $error';
  }

  @override
  String get addName => 'Aggiungi Nome';

  @override
  String get addNoneSubscription => 'Aggiungi Abbonamento Nessuno';

  @override
  String get addPhoneMark => 'Aggiungi Segnalibro Telefonico';

  @override
  String get addPhoneNumberRule => 'Aggiungi Regola Numero di Telefono';

  @override
  String get addPlugin => 'Aggiungi Plugin';

  @override
  String get addPluginFailed => 'Impossibile aggiungere plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Impossibile aggiungere plugin: $error';
  }

  @override
  String get addPluginFromLocalFile => 'Aggiungi Plugin da File Locale';

  @override
  String get addPluginFromUrl => 'Aggiungi Plugin da URL';

  @override
  String get addRegexRule => 'Aggiungi Regola Regex';

  @override
  String get addRule => 'Aggiungi Regola';

  @override
  String addRuleFailed(Object error) {
    return 'Impossibile aggiungere regola: $error';
  }

  @override
  String get addRuleTooltip => 'Aggiungi Regola';

  @override
  String get addSilenceSubscription => 'Aggiungi Abbonamento Silenzioso';

  @override
  String get addSmsFilterRule => 'Aggiungi Regola Filtro SMS';

  @override
  String get addSmsRule => 'Aggiungi Regola SMS';

  @override
  String get addSmsSubscription => 'Aggiungi Abbonamento SMS';

  @override
  String get addSubscription => 'Aggiungi Abbonamento';

  @override
  String get addSubscriptionButton => 'Aggiungi Abbonamento';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Impossibile aggiungere abbonamento: $error';
  }

  @override
  String get addSubscriptionTooltip => 'Aggiungi Abbonamento';

  @override
  String get addToBlacklist => 'Aggiungi alla Blacklist';

  @override
  String get addToFavorites => 'Aggiungi ai Preferiti';

  @override
  String get addToRules => 'Aggiungi alle Regole';

  @override
  String get addToWhitelist => 'Aggiungi alla Whitelist';

  @override
  String get agent => 'Agente';

  @override
  String get all => 'Tutto';

  @override
  String get allCallsTab => 'Tutte';

  @override
  String get allow => 'Consenti';

  @override
  String get allowAllAllowRules => 'Abilita tutte le regole di autorizzazione';

  @override
  String get allowAllAllowRulesDesc =>
      'Interruttore principale per applicare tutte le regole di autorizzazione configurate';

  @override
  String get allowAllBlacklistedNumbers =>
      'Consenti Tutti i Numeri nella Blacklist';

  @override
  String get allowAllBlockRules => 'Abilita tutte le regole di blocco';

  @override
  String get allowAllBlockRulesDesc =>
      'Interruttore principale per applicare tutte le regole di blocco configurate';

  @override
  String get allowAllowedNumbers => 'Consenti tutti i numeri approvati';

  @override
  String get allowAllowedNumbersDesc =>
      'Consenti tutte le chiamate in arrivo da numeri nella tua lista consentiti';

  @override
  String get allowBlock => 'Consenti/Blocca';

  @override
  String get allowBlockedNumbers => 'Sospendi blocco lista nera';

  @override
  String get allowBlockedNumbersDesc =>
      'Consenti temporaneamente chiamate da numeri nella lista di blocco';

  @override
  String get allowedBlockedRule => 'Regola Consenti/Blocca';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Modifica Regola Consenti/Blocca';

  @override
  String get allowedBlockedRuleManagement => 'Gestione Regole Consenti/Blocca';

  @override
  String get allowNonExceededNumbers => 'Consenti Numeri Non Superati';

  @override
  String get allowNonExceededNumbersDescription =>
      'Consenti automaticamente i numeri che non superano la soglia di conteggio';

  @override
  String get allowRegexAllowRules => 'Abilita regole di autorizzazione Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'Abilita la corrispondenza de modelli di espressioni regolari per le regole di autorizzazione';

  @override
  String get allowRegexAllowRulesDescription =>
      'Abilita regole di consenso basate su regex';

  @override
  String get allowRegexBlockRules => 'Abilita regole di blocco Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'Abilita la corrispondenza de modelli di espressioni regolari per le regole di blocco';

  @override
  String get allowRegexBlockRulesDescription =>
      'Abilita regole di blocco basate su regex';

  @override
  String get allowRule => 'Regola di Consenso';

  @override
  String get allowRules => 'Regole di Consenso';

  @override
  String get allPermissionsGranted => 'Tutte le autorizzazioni concesse';

  @override
  String get allSettingsCompleted => 'Tutte le impostazioni completate.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Tutti gli aggiornamenti completati ($count regole)';
  }

  @override
  String get answerThenHangup => 'Rispondi e poi riaggancia';

  @override
  String get applicationSoftware => 'Software dell\'applicazione';

  @override
  String get apply => 'Applica';

  @override
  String get appName => 'La Tua Chiamata La Tua Regola';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'Autorizzazione fallita: controlla ID client e chiave';

  @override
  String get authorizationFailedMessage => 'Autorizzazione fallita';

  @override
  String get authorizationSuccessMessage => 'Autorizzazione riuscita';

  @override
  String get authorizeLoginButton => 'Autorizza Login';

  @override
  String get automotiveIndustry => 'Industria automobilistica';

  @override
  String get autoSyncLabel => 'Sincronizzazione automatica';

  @override
  String get autoUpdate => 'Aggiornamento automatico';

  @override
  String get autoUpdateDescription =>
      'Imposta intervalli di aggiornamento automatico per gli abbonamenti o aggiorna manualmente';

  @override
  String get autoUpdateSettings => 'Impostazioni di aggiornamento automatico';

  @override
  String get autoUpdateSubtitle =>
      'Gestisci gli aggiornamenti automatici per regole e plugin';

  @override
  String get autoUpdateTitle => 'Aggiornamento automatico';

  @override
  String get avatarBorderColor => 'Colore bordo avatar';

  @override
  String get avatarBorderSize => 'Dimensione bordo avatar';

  @override
  String get avatarIconSizesSetting => 'Dimensioni avatar e icone';

  @override
  String get avatarPosition => 'Posizione avatar';

  @override
  String get avatarSize => 'Dimensione avatar';

  @override
  String axisPosition(Object axis) {
    return 'Posizione $axis';
  }

  @override
  String get backgroundGradientSetting => 'Gradiente di sfondo';

  @override
  String get backup => 'Backup';

  @override
  String get backupAndRestore => 'Backup e Ripristino';

  @override
  String get backupAndRestoreSubtitle =>
      'Esegui il backup o ripristina i dati dell\'applicazione';

  @override
  String get backupAndRestoreTitle => 'Backup e Ripristino';

  @override
  String get backupFailed => 'Backup fallito';

  @override
  String get backupSettings => 'Impostazioni di backup';

  @override
  String get backupToCloud => 'Backup su Cloud';

  @override
  String backupToCloudFailed(Object error) {
    return 'Impossibile eseguire il backup sul cloud: $error';
  }

  @override
  String get backupToCloudSuccess => 'Backup riuscito sul cloud';

  @override
  String get bank => 'Banca';

  @override
  String get basicInfo => 'Informazioni di base';

  @override
  String get basicRuleFilter => 'Filtro regole di base';

  @override
  String get basicRuleFiltering => 'Filtraggio regole di base';

  @override
  String get basicRuleFilteringExplanation =>
      '• Filtro regole di base: Filtra le regole in base a blacklist, whitelist e regex';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtra le chiamate utilizzando blacklist/whitelist ed espressioni regolari';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Sei sicuro di voler eliminare $count contatti selezionati?';
  }

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Sei sicuro di voler eliminare $count etichette?';
  }

  @override
  String get blacklist => 'Blacklist';

  @override
  String get blacklistingAndWhitelisting => 'Blacklist e Whitelist';

  @override
  String get blackWhiteList => 'Lista Nera/Bianca';

  @override
  String get block => 'Blocca';

  @override
  String get blockCalls => 'Blocca chiamate';

  @override
  String get blocked => 'Bloccato';

  @override
  String get blockedCalls => 'Chiamate bloccate';

  @override
  String get blockedCallsTitle => 'Chiamate bloccate';

  @override
  String get blockedSpamCalls => 'Chiamate spam bloccate';

  @override
  String get blockingTrend => 'Tendenza blocco';

  @override
  String get blockInternationalCalls =>
      'corrisponde a numeri che non iniziano con + o 00';

  @override
  String get blockInternationalCallsTitle => 'Blocca chiamate internazionali';

  @override
  String get blockMobileNumbers =>
      'corrisponde a numeri che non iniziano con 13-19';

  @override
  String get blockMobileNumbersTitle => 'Blocca numeri mobili';

  @override
  String get blockPremiumRateNumbers =>
      'corrisponde a numeri che non iniziano con 118 o 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Blocca numeri a tariffa maggiorata';

  @override
  String get blockRule => 'Regola di blocco';

  @override
  String get blockRules => 'Regole di blocco';

  @override
  String get blockSpecificAreaCodes =>
      'corrisponde a numeri che iniziano con 0 + 2-3 cifre';

  @override
  String get blockSpecificAreaCodesTitle => 'Blocca codici di zona specifici:';

  @override
  String get blockTypeAnalysisTitle => 'Analisi tipo di blocco';

  @override
  String get both => 'Entrambi';

  @override
  String get bulkDelete => 'Elimina in blocco contatti';

  @override
  String get bulkDeleteContacts => 'Elimina contatti in blocco';

  @override
  String get bulkDeleteLabels => 'Elimina etichette in blocco';

  @override
  String get call => 'Chiama';

  @override
  String get callback => 'Richiama';

  @override
  String get callBlocking => 'Blocco chiamate';

  @override
  String get callerIdApp => 'App ID chiamante';

  @override
  String get callerIdCustomizationTitle => 'Personalizza ID chiamante';

  @override
  String get callerIdDisplayMode => 'Modalità visualizzazione ID chiamante';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Segnalato da $count';
  }

  @override
  String get callerIdPreview => 'Anteprima ID chiamante';

  @override
  String get callFilterRules => 'Regole filtro chiamate';

  @override
  String get callFilterRulesDescription =>
      'Imposta regole di base per il filtraggio delle chiamate';

  @override
  String get callFilterSettings => 'Impostazioni filtro chiamate';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Imposta limiti di frequenza delle chiamate e regole di blocco';

  @override
  String get callFrequencyInterceptionTitle =>
      'Intercettazione frequenza chiamate';

  @override
  String get callHistory => 'Cronologia chiamate';

  @override
  String get callHistoryInfoDesc =>
      'Qui viene mostrata la cronologia delle tue chiamate, incluse chiamate in entrata, in uscita e perse.';

  @override
  String get callHistoryInfoTitle => 'Cronologia chiamate';

  @override
  String get callHistoryTab => 'Cronologia chiamate';

  @override
  String get callScreeningPermission => 'Autorizzazione screening chiamate';

  @override
  String get callScreeningPermissionDescription =>
      'Utilizzato per lo screening e il blocco delle chiamate di spam.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Autorizzazione screening chiamate non concessa, potrebbe influire sulla funzionalità dell\'app.';

  @override
  String get callStatistics => 'Statistiche chiamate';

  @override
  String get callTypeAnswered => 'Risposta';

  @override
  String get callTypeBlocked => 'Bloccato';

  @override
  String get callTypeIconColor => 'Colore icona tipo chiamata';

  @override
  String get callTypeMissed => 'Chiamata persa';

  @override
  String get callTypeOutgoing => 'In uscita';

  @override
  String get callTypePosition => 'Posizione tipo chiamata';

  @override
  String get callTypeUnknown => 'Sconosciuto';

  @override
  String get cancelButton => 'Annulla';

  @override
  String get carRental => 'Noleggio auto';

  @override
  String get carrier => 'Operatore';

  @override
  String get carrierColor => 'Colore operatore';

  @override
  String get carrierFontSize => 'Dimensione carattere operatore';

  @override
  String get carrierPosition => 'Posizione operatore';

  @override
  String get changeLabel => 'Cambia etichetta';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Impossibile cambiare stato plugin: $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Impossibile cambiare stato abbonamento: $error';
  }

  @override
  String get charity => 'Beneficenza';

  @override
  String get chartOneWeekAgo => '1 settimana fa';

  @override
  String get chartThreeDaysAgo => '3 giorni fa';

  @override
  String get chartToday => 'Oggi';

  @override
  String get checkFileFormat =>
      'Controlla il formato o le autorizzazioni del file';

  @override
  String checkPermissionFailed(Object error) {
    return 'Impossibile controllare le autorizzazioni: $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Scegli l\'azione di intercettazione predefinita';

  @override
  String get clearFilter => 'Cancella filtro';

  @override
  String get clearLabelFilterButton => 'Cancella filtro etichette';

  @override
  String get closeButton => 'Chiudi';

  @override
  String get cloudSync => 'Sincronizzazione cloud';

  @override
  String get cloudSyncAndBackupTitle => 'Sincronizzazione e backup cloud';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Configura WebDAV, OneDrive e Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Impostazioni sincronizzazione cloud';

  @override
  String get cloudSyncTitle => 'Sincronizzazione cloud';

  @override
  String get collection => 'Recupero crediti';

  @override
  String get colorPickerTitle => 'Scegli colore';

  @override
  String get configManagement => 'Gestione configurazione';

  @override
  String get configUpdated => 'Configurazione aggiornata';

  @override
  String get configurationAdvice =>
      'Attraverso una corretta configurazione, puoi impostare diverse strategie di filtraggio per le schede SIM personali e di lavoro.';

  @override
  String get configureBackupOptions => 'Configura opzioni di backup';

  @override
  String get configureCloudSyncService =>
      'Configura servizio di sincronizzazione cloud';

  @override
  String get configureCloudSyncServiceMessage =>
      'Configura un servizio di sincronizzazione cloud per abilitare la sincronizzazione multi-dispositivo.';

  @override
  String get configureSimCardFilterRules => 'Configura regole filtro SIM Card';

  @override
  String get confirm => 'Conferma';

  @override
  String get confirmButton => 'Conferma';

  @override
  String get confirmDelete => 'Conferma eliminazione';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Sei sicuro di voler eliminare l\'etichetta \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Sei sicuro di voler eliminare il plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Sei sicuro di voler eliminare $count plugin?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Sei sicuro di voler eliminare questa regola? Questa azione non può essere annullata.';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Sei sicuro di voler eliminare questa regola filtro SMS?';

  @override
  String get confirmDeleteSmsRule =>
      'Sei sicuro di voler eliminare questa regola SMS?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Sei sicuro di voler eliminare $name?';
  }

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get connectedStatus => 'Connesso';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Connessione fallita: Controlla l\'indirizzo del server, il nome utente e la password';

  @override
  String get connectionFailedMessage => 'Connessione fallita';

  @override
  String get connectionStatusLabel => 'Stato della connessione';

  @override
  String get connectionSuccessMessage => 'Connessione riuscita';

  @override
  String get contactAddSuccess => 'Contatto aggiunto con successo';

  @override
  String get contactDeleted => 'Contatto eliminato';

  @override
  String get contactNameLabel => 'Nome';

  @override
  String get contactNotFound => 'Contatto non trovato';

  @override
  String get contacts => 'Contatti';

  @override
  String contactsDeleted(Object count) {
    return 'Eliminati $count contatti';
  }

  @override
  String get contactsManagement => 'Gestione contatti';

  @override
  String get contactsPermission => 'Autorizzazione contatti';

  @override
  String get contactsPermissionDescription =>
      'Utilizzato per identificare le chiamate dai contatti.';

  @override
  String get contactsTab => 'Contatti';

  @override
  String get contactSubscriptionDescription =>
      'Iscriviti alle liste di contatti tramite URL, aggiorna automaticamente le informazioni sui contatti e le etichette. Supporta dati in formato JSON.';

  @override
  String get contactUpdateSuccess => 'Contatto aggiornato con successo';

  @override
  String get contactUs => 'Contattaci';

  @override
  String get content => 'Contenuto';

  @override
  String get contentRegex => 'Regex contenuto';

  @override
  String get countColor => 'Colore conteggio';

  @override
  String get countFontSize => 'Dimensione font conteggio';

  @override
  String get countPosition => 'Posizione conteggio';

  @override
  String get country => 'Paese';

  @override
  String get countryNameColor => 'Colore nome paese';

  @override
  String get countryNameFontSize => 'Dimensione font nome paese';

  @override
  String get countryRegionNamePosition => 'Posizione nome paese/regione';

  @override
  String get countThresholdDescription =>
      'Imposta la soglia minima di conteggio richiesta per attivare le azioni di filtraggio';

  @override
  String get countThresholdLabel => 'Soglia di conteggio';

  @override
  String get createdRules => 'Regole create';

  @override
  String get csvFormat => 'Formato CSV';

  @override
  String get currentDeviceLabel => 'Etichetta dispositivo corrente';

  @override
  String get currentDeviceTitle => 'Dispositivo corrente';

  @override
  String get currentLanguage => 'Lingua corrente';

  @override
  String get customerService => 'Servizio clienti';

  @override
  String get dashboardTab => 'Cruscotto';

  @override
  String get dataAnalysis => 'Analisi dati';

  @override
  String dataLoadFailure(Object error) {
    return 'Caricamento dati fallito: $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Impossibile caricare i dati: $error';
  }

  @override
  String get dataMigration => 'Migrazione dati';

  @override
  String get dataMigrationDescription =>
      'Questa funzionalità ti consente di trasferire tutti i tuoi dati tra dispositivi. Attualmente, puoi utilizzare le funzionalità di backup e ripristino per migrare manualmente i tuoi dati.';

  @override
  String get dataSourceReminder => 'Promemoria sorgente dati';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '1 giorno',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Giorni VIP';
  }

  @override
  String get debtCollection => 'Recupero crediti';

  @override
  String get delete => 'Elimina';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get deleteContact => 'Elimina contatto';

  @override
  String deleteContactConfirm(Object name) {
    return 'Sei sicuro di voler eliminare $name?';
  }

  @override
  String deleteFailed(Object error) {
    return 'Eliminazione fallita: $error';
  }

  @override
  String get deleteLabel => 'Elimina etichetta';

  @override
  String deleteLabelFailed(Object error) {
    return 'Impossibile eliminare etichetta: $error';
  }

  @override
  String get deletePlugin => 'Elimina plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Impossibile eliminare plugin: $error';
  }

  @override
  String get deletePlugins => 'Elimina plugin';

  @override
  String deletePluginsFailed(Object error) {
    return 'Impossibile eliminare plugin: $error';
  }

  @override
  String get deleteRule => 'Elimina regola';

  @override
  String deleteRuleFailed(Object error) {
    return 'Eliminazione fallita: $error';
  }

  @override
  String get deleteSelected => 'Elimina selezionati';

  @override
  String get deleteSubscription => 'Elimina iscrizione';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Sei sicuro di voler eliminare l\'iscrizione \"$name\"?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Impossibile eliminare iscrizione: $error';
  }

  @override
  String get deleteSuccess => 'Eliminazione riuscita';

  @override
  String get delivery => 'Consegna';

  @override
  String get deviceIDLabel => 'ID dispositivo';

  @override
  String get deviceManagementSubtitle =>
      'Gestisci la sincronizzazione multi-dispositivo';

  @override
  String get deviceManagementTitle => 'Gestione dispositivi';

  @override
  String get deviceModelLabel => 'Modello dispositivo';

  @override
  String get deviceName => 'Nome dispositivo';

  @override
  String get deviceNameLabel => 'Nome del dispositivo';

  @override
  String get deviceRenamedSuccessfullyMessage =>
      'Dispositivo rinominato con successo';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Dispositivi sincronizzati con successo';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Dispositivo non registrato con successo';

  @override
  String get dialogTitle => 'Spiegazione del modello Regex';

  @override
  String get differentFromLocalCounter =>
      'Questa funzionalità è diversa dal filtro contatore locale, in quanto si concentra sui modelli di chiamata ripetuta in breve tempo piuttosto che sul conteggio a lungo termine dei contrassegni.';

  @override
  String get disabled => 'Disabilitato';

  @override
  String get disabledStatus => 'Disabilitato';

  @override
  String get disableGlobalPlugins => 'Disabilita plugin globali';

  @override
  String get disconnectButton => 'Disconnetti';

  @override
  String get disconnectedMessage => 'Disconnesso';

  @override
  String get disconnectedStatus => 'Disconnesso';

  @override
  String get disconnectFailedMessage => 'Disconnessione fallita';

  @override
  String get done => 'Fatto';

  @override
  String get dualSimAdvice =>
      'Questa funzionalità è particolarmente utile per i telefoni dual-SIM per impostare diverse strategie di filtraggio per le schede SIM di lavoro e personali.';

  @override
  String get earlier => 'Prima';

  @override
  String get ecommerce => 'E-commerce';

  @override
  String get edit => 'Modifica';

  @override
  String get editContact => 'Modifica contatto';

  @override
  String get editLabel => 'Modifica etichetta';

  @override
  String get editPhoneRule => 'Modifica regola telefono';

  @override
  String get editRule => 'Modifica regola';

  @override
  String get education => 'Educazione';

  @override
  String get elementPositionsSetting => 'Posizioni degli elementi';

  @override
  String get email => 'Email';

  @override
  String get enableCallFilter => 'Abilita filtro chiamate';

  @override
  String get enableCallFilterDescription =>
      'Quando abilitate, le chiamate in arrivo vengono controllate rispetto all\'elenco di regole sottostante. Le regole di filtraggio delle chiamate non vengono sincronizzate tra i dispositivi per impostazione predefinita.';

  @override
  String get enabled => 'Abilitato';

  @override
  String get enabledStatus => 'Abilitato';

  @override
  String get enableEncryption => 'Abilita crittografia';

  @override
  String get enableEncryptionDescription => 'Crittografa i file di backup';

  @override
  String get enableGlobalPlugins => 'Abilita plugin globali';

  @override
  String get enableLocalCountFilter =>
      'Abilita protezione soglia segnalazioni locali';

  @override
  String get enableLocalCountFilterDescription =>
      'Blocca le chiamate in arrivo quando il conteggio delle segnalazioni locali supera la soglia';

  @override
  String get enableLocalNotification => 'Usa notifica locale';

  @override
  String get enableLocalNotificationDescription =>
      'Quando abilitato, le notifiche per i messaggi filtrati verranno visualizzate sul dispositivo';

  @override
  String get enableLocationSummary => 'Posizione';

  @override
  String get enableMuteRules => 'Silenzia chiamate intercettate';

  @override
  String get enableMuteRulesDesc =>
      'Silenzia la suoneria per le chiamate intercettate invece di rifiutarle';

  @override
  String get enableNoneActionRules =>
      'Solo registra e contrassegna (Nessun blocco)';

  @override
  String get enableNoneActionRulesDesc =>
      'Registra e contrassegna le chiamate corrispondenti senza eseguire alcuna azione di blocco';

  @override
  String get enableRemoteNumberFilter =>
      'Abilita protezione soglia query cloud';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Blocca le chiamate in arrivo quando il conteggio delle segnalazioni cloud supera la soglia';

  @override
  String get enableRule => 'Abilita regola';

  @override
  String get enableSmsFilter => 'Abilita filtro SMS';

  @override
  String get enableSmsFilterDescription =>
      'Quando abilitato, i messaggi verranno filtrati automaticamente in base alle regole';

  @override
  String get enableTimeInterception => 'Abilita intercettazione temporale';

  @override
  String get enableTimeInterceptionDescription =>
      'Blocca chiamate ripetute dallo stesso numero in breve tempo';

  @override
  String get enableTimeInterceptor => 'Abilita intercettatore temporale';

  @override
  String get endCallImmediately => 'Blocca immediatamente';

  @override
  String get endColor => 'Colore finale';

  @override
  String get endDate => 'Data fine';

  @override
  String get enhancedFilterInstructionsTitle =>
      'Titolo istruzioni filtro avanzato';

  @override
  String get enhancedFilterSettings => 'Impostazioni filtro avanzato';

  @override
  String get enhancedFilterSettingsTitle => 'Impostazioni filtro avanzato';

  @override
  String get enhancedFilterSystemDescription =>
      'Il sistema di filtri avanzato supporta sia le regole globali che le configurazioni di filtraggio per singola scheda SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Inserisci sia il numero di telefono che il modello Regex.';

  @override
  String get enterContactName => 'Inserisci nome contatto';

  @override
  String get enterDeviceName => 'Inserisci nome dispositivo';

  @override
  String get enterEmailOptional => 'Inserisci email (opzionale)';

  @override
  String get enterEncryptionPasswordHint =>
      'Inserisci password di crittografia';

  @override
  String get enterIconCode => 'Inserisci codice icona';

  @override
  String get enterName => 'Inserisci nome contatto';

  @override
  String get enterNewDeviceNameHint =>
      'Inserisci un nuovo nome per questo dispositivo';

  @override
  String get enterPasswordAgain => 'Inserisci di nuovo la password';

  @override
  String get enterPhoneNumber => 'Inserisci numero di telefono';

  @override
  String get enterPhoneNumberHint => 'Inserisci numero di telefono da testare';

  @override
  String get enterPhoneNumberMultiple =>
      'Inserisci numero di telefono, numeri multipli separati da virgole';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Inserisci numero di telefono per iniziare la ricerca';

  @override
  String get enterPhoneNumberToVerify =>
      'Inserisci numero di telefono da verificare';

  @override
  String get enterPluginName => 'Inserisci nome plugin';

  @override
  String get enterPluginUrl => 'Inserisci indirizzo URL del plugin';

  @override
  String get enterRegexHint => 'Inserisci modello regex';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Inserisci sia il nome della regola che il pattern regex.';

  @override
  String get enterRuleNameHint => 'Inserisci il nome della regola';

  @override
  String get enterSearchContent => 'Inserisci il contenuto da cercare';

  @override
  String get enterSubscriptionName => 'Inserisci il nome dell\'abbonamento';

  @override
  String get enterSubscriptionUrl => 'Inserisci l\'URL dell\'abbonamento';

  @override
  String get enterSyncFolderNameHint =>
      'Inserisci il nome della cartella di sincronizzazione (predefinito: NotificationManager)';

  @override
  String get entertainment => 'Intrattenimento';

  @override
  String get enterValidNameAndUrl => 'Inserisci nome e URL validi';

  @override
  String get enterValidUrl => 'Inserisci un URL valido';

  @override
  String get enterVersion => 'Inserisci la versione';

  @override
  String get enterWebDAVPasswordHint => 'Inserisci la password WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Inserisci l\'indirizzo del server WebDAV';

  @override
  String get enterWebDAVUsernameHint => 'Inserisci il nome utente WebDAV';

  @override
  String errorOccurredMessage(Object error) {
    return 'Si è verificato un errore: $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Errore durante la ridenominazione del dispositivo: $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Errore durante la sincronizzazione dei dispositivi: $error';
  }

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Errore durante la deregistrazione del dispositivo: $error';
  }

  @override
  String get exampleBlock400Prefix => 'es. Blocca numeri prefisso 400';

  @override
  String get exampleBlockMarketingSms => 'es. Blocca SMS di marketing';

  @override
  String get exampleContentRegexHint => 'Esempio Regex Contenuto';

  @override
  String get exampleCouponPromotionDiscount =>
      'es. .*(coupon|promozione|sconto).*';

  @override
  String get exampleFamilyFriends => 'es. Famiglia, Amici, ecc.';

  @override
  String get examplePhoneNumber => 'es. 10086, 12345, ecc.';

  @override
  String get exampleRegex400Prefix => 'Esempio di regex per prefisso 400';

  @override
  String get exampleSenderRegexHint => 'Esempio';

  @override
  String get exchange => 'Scambia';

  @override
  String get exchangeNow => 'Scambia Ora';

  @override
  String get exchangeVip => 'Scambia VIP';

  @override
  String expiryTime(Object time) {
    return 'Ora di scadenza: $time';
  }

  @override
  String get export => 'Esporta';

  @override
  String get exportAllApplicationSettings =>
      'Esporta tutte le impostazioni dell\'applicazione';

  @override
  String get exportAllRuleConfigurations =>
      'Esporta tutte le configurazioni delle regole';

  @override
  String get exportConfig => 'Esporta configurazione';

  @override
  String get exportContacts => 'Esporta contatti';

  @override
  String get exportData => 'Esporta dati';

  @override
  String get exportFailed => 'Esportazione fallita';

  @override
  String get exportFailure => 'Impossibile esportare la configurazione';

  @override
  String get exportFeatureComingSoon =>
      'Funzionalità di esportazione in arrivo';

  @override
  String get exportLabels => 'Esporta etichette';

  @override
  String exportLabelsFailed(Object error) {
    return 'Impossibile esportare le etichette: $error';
  }

  @override
  String get exportPluginList => 'Esporta elenco plugin';

  @override
  String exportPluginListFailed(Object error) {
    return 'Impossibile esportare l\'elenco dei plugin: $error';
  }

  @override
  String get exportRules => 'Esporta regole';

  @override
  String get exportSmsRules => 'Esporta regole SMS';

  @override
  String get exportStatisticsData => 'Esporta dati statistici';

  @override
  String get exportSuccesslly => 'Configurazione esportata con successo';

  @override
  String failedToAddRule(Object error) {
    return 'Impossibile aggiungere la regola: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Impossibile aggiungere l\'abbonamento SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Impossibile eseguire il backup delle impostazioni: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Impossibile decrittografare il file di backup';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Impossibile eliminare la regola SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Impossibile esportare le regole: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Impossibile ottenere le informazioni sull\'ID chiamante: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Impossibile importare le regole: $error';
  }

  @override
  String get failedToRestoreSettings =>
      'Impossibile ripristinare le impostazioni';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Impossibile ripristinare le impostazioni: $error';
  }

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Impossibile attivare/disattivare lo stato della regola: $error';
  }

  @override
  String get favoriteContacts => 'Contatti preferiti';

  @override
  String get featureAddRules =>
      '• Aggiungi regole specifiche per numero di telefono';

  @override
  String get featureCenter => 'Centro funzionalità';

  @override
  String get featureEnableDisable =>
      '• Abilita/disabilita diversi filtri per SIM';

  @override
  String get featureListTitle => 'Funzionalità:';

  @override
  String get featureManageRules => '• Gestisci elenchi di regole per SIM';

  @override
  String get features => 'Funzionalità';

  @override
  String get fetchingCallerIdInfo =>
      'Recupero informazioni sull\'ID chiamante...';

  @override
  String fileSavedTo(Object path) {
    return 'File salvato in: $path';
  }

  @override
  String get filter => 'Filtra';

  @override
  String get filterByLabel => 'Filtra per etichetta';

  @override
  String get filterControlPanelTitle => 'Pannello di controllo filtro';

  @override
  String get filterControlSubtitle =>
      'Gestisci lo stato di attivazione/disattivazione di tutti i filtri';

  @override
  String get filterControlTitle => 'Controllo filtro';

  @override
  String get filtered => 'Filtrato';

  @override
  String get filterExplanation => 'Spiegazione filtro';

  @override
  String get filterManagement => 'Gestione filtri';

  @override
  String get filterName => 'Nome filtro';

  @override
  String get filterPriorityNote =>
      'Nota: Esistono relazioni di priorità tra i filtri, fare riferimento alla documentazione di aiuto per i dettagli';

  @override
  String get filterSettings => 'Impostazioni filtro';

  @override
  String get filterSettingsTitle => 'Impostazioni filtro';

  @override
  String get filterSMS => 'Filtra SMS';

  @override
  String get filterToggleInstructions =>
      'Abilita o disabilita i filtri per questo slot SIM:';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Filtro $status: $filterName';
  }

  @override
  String get filterType => 'Tipo filtro';

  @override
  String get financial => 'Finanziario';

  @override
  String get flexibleCombinationFeature =>
      '• Combinazioni flessibili: Abilita/disabilita filtri per slot SIM';

  @override
  String get fontSizesSetting => 'Dimensioni carattere';

  @override
  String foundRules(Object count) {
    return 'Trovate $count regole';
  }

  @override
  String get fraudAlert => 'ALLARME FRODE - Riaggancia la chiamata';

  @override
  String get fraudScamLikely => 'Probabile frode o truffa';

  @override
  String get free => 'Gratis';

  @override
  String get functionSettingsTitle => 'Impostazioni funzione';

  @override
  String generalUpdateFailure(Object error) {
    return 'Aggiornamento fallito: $error';
  }

  @override
  String get getFree => 'Ottieni gratis';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Configura filtri globali per tutte le schede SIM:';

  @override
  String get globalFilterFeature =>
      '• Filtri Globali: Regole di base per tutte le chiamate in arrivo';

  @override
  String get globalFilterSettings => 'Impostazioni filtro globali';

  @override
  String get globalSettings => 'Impostazioni globali';

  @override
  String get googleDriveAuthDescription =>
      'Autorizza utilizzando l\'ID client e la chiave di Google Drive configurati nel sistema';

  @override
  String get googleDriveConfigTitle => 'Configurazione Google Drive';

  @override
  String get government => 'Governo';

  @override
  String get granted => 'Concesso';

  @override
  String get grantNecessaryPermissions => 'Concedi autorizzazioni necessarie';

  @override
  String get grantPermissions => 'Concedi autorizzazioni';

  @override
  String get headhunter => 'Cacciatore di teste';

  @override
  String get height => 'Altezza';

  @override
  String get homeTab => 'Home';

  @override
  String get howItWorksPoint1 =>
      '• Il sistema consentirà automaticamente le chiamate dallo stesso numero entro la finestra temporale impostata';

  @override
  String get howItWorksPoint2 =>
      '• Finestre temporali più brevi comportano un\'intercettazione più rigorosa; finestre temporali più lunghe comportano un\'intercettazione più flessibile';

  @override
  String get howItWorksPoint3 =>
      '• Il sistema controlla i registri delle chiamate per determinare se si tratta di una chiamata ripetuta';

  @override
  String get howItWorksTitle => 'Come funziona:';

  @override
  String get iconCodeOptional => 'Codice icona (Opzionale)';

  @override
  String get iconSize => 'Dimensione icona';

  @override
  String get import => 'Importa';

  @override
  String get important => 'Importante';

  @override
  String get importConfig => 'Importa configurazione';

  @override
  String get importContacts => 'Importa contatti';

  @override
  String get importExportContacts => 'Importa/Esporta contatti';

  @override
  String get importExportContactsTooltip => 'Importa/Esporta contatti';

  @override
  String get importExportRules => 'Importa/Esporta regole';

  @override
  String importFailed(Object error) {
    return 'Importazione fallita: $error';
  }

  @override
  String get importFailure => 'Impossibile importare la configurazione';

  @override
  String get importFeatureComingSoon =>
      'Funzionalità di importazione in arrivo';

  @override
  String get importLabels => 'Importa etichette';

  @override
  String importLabelsFailed(Object error) {
    return 'Impossibile importare le etichette: $error';
  }

  @override
  String get importPluginList => 'Importa elenco plugin';

  @override
  String importPluginListFailed(Object error) {
    return 'Impossibile importare l\'elenco dei plugin: $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return 'Importati correttamente $count plugin';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importa configurazioni regole da file';

  @override
  String get importRules => 'Importa regole';

  @override
  String get importSuccess => 'Importazione riuscita';

  @override
  String get incomingCallInterceptAction =>
      'Azione di intercettazione chiamata in arrivo';

  @override
  String get incorrectPassword => 'Password errata';

  @override
  String get initializing => 'Inizializzazione';

  @override
  String get installed => 'Installato';

  @override
  String get insufficientMarks => 'Marchi insufficienti';

  @override
  String get insurance => 'Assicurazione';

  @override
  String get interceptAction => 'Azione di intercettazione';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Imposta come vengono gestite le chiamate bloccate';

  @override
  String get interceptionActionSettingsTitle =>
      'Impostazioni azione di intercettazione';

  @override
  String get interceptionTimeInterval =>
      'Intervallo di tempo di intercettazione';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Intervallo di aggiornamento $service impostato su $days giorni';
  }

  @override
  String get invalidContentRegex => 'Regex contenuto non valido';

  @override
  String get invalidLabel => 'Etichetta non valida';

  @override
  String get invalidRegexPattern => 'Modello regex non valido';

  @override
  String get invalidSenderRegex => 'Regex mittente non valido';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Unisciti al Canale e Gruppo Telegram per maggiori informazioni';

  @override
  String get jsonFormat => 'Formato JSON';

  @override
  String get keepAllVersions => 'Mantieni tutte le versioni';

  @override
  String get keepAllVersionsDescription =>
      'Mantieni tutte le versioni storiche di ogni backup';

  @override
  String get label => 'Etichetta';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Etichetta \"$name\" aggiunta con successo';
  }

  @override
  String get labelCategories => 'Categorie Etichette';

  @override
  String get labelDeleted => 'Etichetta eliminata';

  @override
  String get labelDescription =>
      'Le etichette ti aiutano a gestire meglio i contatti, aggiungi etichette personalizzate ai numeri di telefono per una facile identificazione di chiamate e messaggi.';

  @override
  String get labelFilterTooltip => 'Filtro Etichette';

  @override
  String get labelIconColor => 'Colore Icona Etichetta';

  @override
  String get labelManagement => 'Gestione Etichette';

  @override
  String get labelNotFound => 'Etichetta non trovata';

  @override
  String get labels => 'Etichette';

  @override
  String get labelsColor => 'Colore Etichette';

  @override
  String labelsDeleted(Object count) {
    return '$count etichette eliminate';
  }

  @override
  String get labelsExportedSuccessfully => 'Etichette esportate con successo';

  @override
  String get labelsFontSize => 'Dimensione Font Etichette';

  @override
  String labelsImportedSuccessfully(Object count) {
    return 'Importate con successo $count etichette';
  }

  @override
  String get labelsPosition => 'Posizione Etichette';

  @override
  String labelTag(Object labelId) {
    return 'Etichetta: $labelId';
  }

  @override
  String labelUpdateFailed(Object error) {
    return 'Impossibile aggiornare l\'etichetta: $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Etichetta \"\$labelText\" aggiornata con successo';

  @override
  String get languageSettings => 'Impostazioni Lingua';

  @override
  String get languageSettingsSubtitle =>
      'Cambia la lingua di visualizzazione dell\'applicazione';

  @override
  String get languageSettingsTitle => 'Impostazioni Lingua';

  @override
  String get lastSyncLabel => 'Ultima Sincronizzazione';

  @override
  String lastUpdated(Object date) {
    return 'Ultimo aggiornamento: $date';
  }

  @override
  String get lifetimeMembership => 'Abbonamento a Vita';

  @override
  String get lifetimeMembershipDescription =>
      'Acquisto unico, sblocca permanentemente tutte le funzionalità premium e gli aggiornamenti futuri';

  @override
  String loadContactsFailed(Object error) {
    return 'Impossibile caricare i contatti: $error';
  }

  @override
  String get loadDataFailed => 'Impossibile caricare i dati';

  @override
  String get loading => 'Caricamento...';

  @override
  String get loadingTags => 'Caricamento tag...';

  @override
  String loadLabelFailed(Object error) {
    return 'Impossibile caricare le etichette: $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Impossibile caricare le etichette: $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Impossibile caricare i numeri di telefono contrassegnati: $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Impossibile caricare i telefoni contrassegnati: $error';
  }

  @override
  String loadPluginsFailed(Object error) {
    return 'Impossibile caricare i plugin: $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Impossibile caricare le impostazioni: $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Impossibile caricare le regole SMS: $error';
  }

  @override
  String get loadStatusFailedMessage => 'Impossibile caricare lo stato';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Impossibile caricare gli abbonamenti: $error';
  }

  @override
  String get loan => 'Prestito';

  @override
  String get localCounterFilter => 'Filtro Contatore Locale';

  @override
  String get localCounterFilterSubtitle =>
      'Filtra automaticamente le chiamate spam in base alla frequenza delle chiamate';

  @override
  String get localCountFilter => 'Protezione soglia segnalazioni locali';

  @override
  String get localCountFilterDescription =>
      'Blocca automaticamente le chiamate che superano la soglia di segnalazione locale';

  @override
  String get localCountFilterExplanationContent =>
      'Il filtro conteggio locale analizza i registri della cronologia chiamate per identificare e bloccare automaticamente le chiamate spam frequenti.';

  @override
  String get localCountFilterExplanationTitle =>
      'Spiegazione Filtro Conteggio Locale';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Determina se bloccare in base al valore del conteggio del numero';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Quando il conteggio di un numero supera la soglia impostata, è possibile scegliere di bloccarlo automaticamente';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• È possibile consentire selettivamente i numeri che non superano la soglia';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• È possibile scegliere se registrare tutti i log di query';

  @override
  String get localCountFiltering => 'Filtraggio Conteggio Locale';

  @override
  String get localCountFilteringExplanation =>
      '• Filtraggio Conteggio Locale: Regole di filtraggio basate sul conteggio di marcatura locale';

  @override
  String get localCountFilterSettings => 'Impostazioni Filtro Conteggio Locale';

  @override
  String get localCountFilterUseCases =>
      'Questo filtro è particolarmente adatto per identificare chiamate spam effettuate automaticamente e chiamate di marketing.';

  @override
  String get localFilterSettings => 'Impostazioni Filtro Locale';

  @override
  String get localNotificationDisabled => 'Notifica locale disabilitata';

  @override
  String get localNotificationEnabled => 'Notifica locale abilitata';

  @override
  String get localServices => 'Servizi Locali';

  @override
  String get locationColor => 'Colore Posizione';

  @override
  String get locationFontSize => 'Dimensione Font Posizione';

  @override
  String get locationIconColor => 'Colore Icona Posizione';

  @override
  String get locationPosition => 'Posizione Posizione';

  @override
  String get logAllLocalQueries => 'Registra Tutte le Query Locali';

  @override
  String get logAllLocalQueriesDescription =>
      'Registra i log per tutte le query sui numeri locali';

  @override
  String get logAllRemoteQueries => 'Registra Tutte le Query Remote';

  @override
  String get logAllRemoteQueriesDescription =>
      'Registra tutte le operazioni di query sui numeri remoti';

  @override
  String get manage => 'Gestisci Contatti';

  @override
  String get manageFavoriteContacts => 'Gestisci Contatti Preferiti';

  @override
  String get manageFilterRules => 'Gestisci Regole Filtro';

  @override
  String get manageFilterRulesDescription =>
      'Aggiungi, modifica o elimina regole filtro SMS';

  @override
  String get markCounts => 'Conteggi Marcatura';

  @override
  String get markCount => 'Conteggio Marcatura';

  @override
  String markedByCount(Object count) {
    return 'Contrassegnato da $count';
  }

  @override
  String get markedPhonesList => 'Numeri di Telefono Contrassegnati';

  @override
  String get markExchange => 'Scambio Marcatura';

  @override
  String get markPhone => 'Contrassegna Numero di Telefono';

  @override
  String markPhoneFailed(Object error) {
    return 'Impossibile contrassegnare il numero di telefono: $error';
  }

  @override
  String get markPhoneManagementTitle => 'Gestione numeri contrassegnati';

  @override
  String get markPhoneSuccess =>
      'Numero di telefono contrassegnato con successo';

  @override
  String get matchFailedMessage => 'Corrispondenza fallita.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'corrisponde a un formato numerico specifico';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Corrisponde a numeri con caratteri speciali:';

  @override
  String get matchSpecificDigitPatterns =>
      'corrisponde al formato XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Corrisponde a modelli di cifre specifici:';

  @override
  String get matchSuccessfulMessage => 'Corrispondenza riuscita!';

  @override
  String get medical => 'Medico';

  @override
  String get membershipPrivileges => 'Vantaggi dell\'abbonamento';

  @override
  String get migrationTool => 'Strumento di migrazione';

  @override
  String get minutes => 'minuti';

  @override
  String get month => 'Mese';

  @override
  String get monthly => 'Mensile';

  @override
  String get monthlyCallCount => 'Chiamate mensili';

  @override
  String get monthlyMembership => 'Abbonamento mensile';

  @override
  String get monthlyMembershipDescription =>
      'Sblocca tutte le funzionalità premium, rinnovo automatico mensile';

  @override
  String get monthlyTotal => 'Totale mensile';

  @override
  String get moreOptions => 'Altre opzioni';

  @override
  String get mute => 'Muto';

  @override
  String get name => 'Nome';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Nome e numero di telefono non possono essere vuoti';

  @override
  String get nameColor => 'Colore del nome';

  @override
  String get nameFontSize => 'Dimensione del carattere del nome';

  @override
  String get namePosition => 'Posizione del nome';

  @override
  String get nameUnknown => 'Nome: Sconosciuto';

  @override
  String get nextStep => 'Avanti';

  @override
  String get noAction => 'Nessuna azione';

  @override
  String get noActionRules => 'Nessuna regola di azione';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Nessun servizio di sincronizzazione cloud attivo';

  @override
  String get noCallRecords => 'Nessun record di chiamate';

  @override
  String get noContactsYet => 'Nessun contatto ancora';

  @override
  String get noData => 'Nessun dato';

  @override
  String get noDevicesRegisteredMessage => 'Nessun dispositivo registrato';

  @override
  String get noLabels => 'Nessuna etichetta ancora';

  @override
  String get noMarkedPhones => 'Nessun numero di telefono contrassegnato';

  @override
  String get noMatchingContactsFound =>
      'Nessun contatto corrispondente trovato';

  @override
  String get noMatchingNumbersFound => 'Nessun numero corrispondente trovato';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Nessuna regola $ruleType corrispondente';
  }

  @override
  String get none => 'Nessuno';

  @override
  String get noneServiceType => 'Nessuno';

  @override
  String get noPlugins => 'Nessun plugin ancora';

  @override
  String noRules(Object ruleType) {
    return 'Nessuna regola $ruleType ancora';
  }

  @override
  String get noRulesPrompt =>
      'Nessuna regola trovata, si prega di aggiungere regole';

  @override
  String get noRulesToExport => 'Nessuna regola da esportare';

  @override
  String get noSmsFilterRulesYet => 'Nessuna regola di filtro SMS ancora';

  @override
  String get noSmsRulesYet => 'Nessuna regola SMS ancora';

  @override
  String get noSubscriptions => 'Nessun abbonamento';

  @override
  String get notGranted => 'Non concesso';

  @override
  String get notificationModeDescription =>
      'Mostra le informazioni sul chiamante nella barra delle notifiche';

  @override
  String get notificationPermission => 'Autorizzazione notifica';

  @override
  String get notificationPermissionDescription =>
      'Utilizzato per visualizzare le notifiche di chiamate e messaggi in arrivo.';

  @override
  String get notifications => 'Notifiche';

  @override
  String get notificationSettings => 'Impostazioni notifiche';

  @override
  String get notVerifiedText => 'Non verificato';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Nessuna regola SMS valida trovata nel file';

  @override
  String get number => 'Numero';

  @override
  String get numberColor => 'Colore del numero';

  @override
  String get numberFontSize => 'Dimensione del carattere del numero';

  @override
  String get numberPosition => 'Posizione del numero';

  @override
  String get numberSearch => 'Ricerca numero';

  @override
  String get numberTypeColor => 'Colore del tipo di numero';

  @override
  String get numberTypeFontSize =>
      'Dimensione del carattere del tipo di numero';

  @override
  String get numberTypePosition => 'Posizione del tipo di numero';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Il tuo gestore di sicurezza delle chiamate è pronto, inizia a goderti un\'esperienza di chiamata sicura!';

  @override
  String get onboardingLanguageDescription =>
      'Scegli la tua lingua preferita per la migliore esperienza.';

  @override
  String get onboardingPermissionsDescription =>
      'Per fornire il servizio completo, abbiamo bisogno delle seguenti autorizzazioni:';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Blocco con un clic di chiamate e messaggi spam, personalizza le regole di blocco e garantisciti un ambiente tranquillo.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identifica automaticamente le chiamate sconosciute, contrassegna i numeri sospetti e proteggi la tua sicurezza delle chiamate.';

  @override
  String get onboardingWelcomeDescription =>
      'Il tuo esperto di gestione delle chiamate, che fornisce servizi completi di identificazione e blocco delle chiamate.';

  @override
  String get oneDriveAuthDescription =>
      'Autorizza utilizzando l\'ID client e la chiave OneDrive configurati nel sistema';

  @override
  String get oneDriveConfigTitle => 'Configurazione OneDrive';

  @override
  String get onlineCallerIdSubscription => 'Abbonamento ID chiamante online';

  @override
  String get openAppSettings => 'Apri impostazioni app';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Impossibile aprire le impostazioni dell\'app: $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Operazione fallita: $error';
  }

  @override
  String get operationFailure => 'Operazione fallita';

  @override
  String get operationSuccess => 'Operazione riuscita';

  @override
  String get other => 'Altro';

  @override
  String get ourOtherApps => 'Le nostre altre app';

  @override
  String get overlayMode => 'Finestra mobile';

  @override
  String get overlayModeDescription =>
      'Mostra le informazioni sul chiamante in una finestra mobile';

  @override
  String get overlayPermission => 'Autorizzazione overlay';

  @override
  String get overlayPermissionDescription =>
      'Utilizzato per visualizzare l\'overlay della chiamata in arrivo.';

  @override
  String get overview => 'Panoramica';

  @override
  String get password => 'Password';

  @override
  String get passwordCannotBeEmpty => 'La password non può essere vuota';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get pattern => 'Modello';

  @override
  String get pendingSync => 'Sincronizzazione in sospeso';

  @override
  String get periodMonth => 'Mese';

  @override
  String get periodWeek => 'Settimana';

  @override
  String get periodYear => 'Anno';

  @override
  String get permissionDenied => 'Richiesta di autorizzazione negata';

  @override
  String get permissionGranted => 'Autorizzazione concessa';

  @override
  String get permissionManagement => 'Gestione autorizzazioni';

  @override
  String get phoneCallsTab => 'Telefono';

  @override
  String get phoneNumber => 'Numero di telefono';

  @override
  String get phoneNumberCannotBeEmpty =>
      'Il numero di telefono non può essere vuoto';

  @override
  String get phoneNumberLabel => 'Numero di telefono';

  @override
  String get phoneNumberTypeFixedLine => 'Linea fissa';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Linea fissa o mobile';

  @override
  String get phoneNumberTypeMobile => 'Mobile';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Numero personale';

  @override
  String get phoneNumberTypePremiumRate => 'Tariffazione premium';

  @override
  String get phoneNumberTypeSharedCost => 'Costo condiviso';

  @override
  String get phoneNumberTypeTollFree => 'Numero verde';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Sconosciuto';

  @override
  String get phoneNumberTypeVoicemail => 'Segreteria telefonica';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Autorizzazione telefono';

  @override
  String get phonePermissionDescription =>
      'Utilizzato per identificare e bloccare le chiamate in arrivo.';

  @override
  String get phoneRule => 'Regola telefonica';

  @override
  String get phoneRuleManagement => 'Gestione regole telefoniche';

  @override
  String get phoneRuleSubscription => 'Abbonamento regola telefonica';

  @override
  String get phoneSubscription => 'Abbonamento telefonico';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Iscriviti agli elenchi di regole telefoniche tramite URL per aggiornare automaticamente le regole della lista bianca e nera. Supporta file di regole in formato JSON.';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Seleziona un\'etichetta e inserisci un numero di telefono valido';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" aggiunto correttamente';
  }

  @override
  String get pluginDeleted => 'Plugin eliminato';

  @override
  String get pluginLatestVersion => 'Il plugin è già all\'ultima versione';

  @override
  String get pluginListExportSuccess => 'Elenco plugin esportato correttamente';

  @override
  String get pluginManagement => 'Gestione plugin';

  @override
  String get pluginManagementSubtitle =>
      'Gestisci e configura plugin di terze parti';

  @override
  String get pluginName => 'Nome plugin';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugin eliminati correttamente.';
  }

  @override
  String get pluginService => 'Servizio plugin';

  @override
  String get pluginTestPageTitle => 'Test plugin';

  @override
  String get pluginUpdateSuccess => 'Plugin aggiornato correttamente';

  @override
  String get pluginUrl => 'URL plugin';

  @override
  String get pluginVersion => 'Versione plugin';

  @override
  String get political => 'Politico';

  @override
  String get powerfulSpamBlocking => 'Potente blocco spam';

  @override
  String get previousStep => 'Precedente';

  @override
  String get prioritizeRemoteAction => 'Prioritizza impostazioni azione remota';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioritizza le impostazioni delle azioni dal database remoto';

  @override
  String get processing => 'Elaborazione...';

  @override
  String get processingOperation => 'Elaborazione...';

  @override
  String get purchase => 'Acquisto';

  @override
  String get quarterlyMembership => 'Abbonamento trimestrale';

  @override
  String get quarterlyMembershipDescription =>
      'Sblocca tutte le funzionalità premium, rinnovo automatico trimestrale';

  @override
  String get ready => 'Pronto!';

  @override
  String get recruiter => 'Recruiter';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get refreshPermissionStatus => 'Aggiorna stato autorizzazione';

  @override
  String get refreshTooltip => 'Aggiorna';

  @override
  String regexErrorMessage(Object error) {
    return 'Errore Regex: $error';
  }

  @override
  String get regexPattern => 'Modello Regex';

  @override
  String get regexPatternExplanation => 'Spiegazione Modello Regex';

  @override
  String get regexPatternExplanationButton => 'Spiegazione Modello Regex';

  @override
  String get regexPatternLabel => 'Modello Regex';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Modelli Regex per Corrispondenza Numero di Telefono';

  @override
  String get regexRule => 'Regola Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Impossibile aggiungere la regola regex: $error';
  }

  @override
  String get regexRuleAddSuccess => 'Regola regex aggiunta con successo';

  @override
  String get regexRuleManagement => 'Gestione Regole Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'Nome regola e modello regex non possono essere vuoti';

  @override
  String get regexRules => 'Regole Regex';

  @override
  String get regexTesterTitle => 'Tester Regex';

  @override
  String get region => 'Regione';

  @override
  String get registeredDevicesTitle => 'Dispositivi Registrati';

  @override
  String get rejectAllCalls => 'Rifiuta Tutte le Chiamate';

  @override
  String get rejectAllCallsDescription =>
      'Quando abilitato, tutte le chiamate verranno rifiutate con priorità più alta';

  @override
  String get rejectAllNumbers => 'Rifiuta tutte le chiamate in arrivo';

  @override
  String get rejectAllNumbersDesc =>
      'Rifiuta tutte le chiamate in arrivo con la massima priorità';

  @override
  String get rejectExceededNumbers => 'Rifiuta Numeri Eccedenti';

  @override
  String get rejectExceededNumbersDescription =>
      'Rifiuta automaticamente i numeri che superano la soglia di conteggio';

  @override
  String get remoteFilterSettings => 'Impostazioni Filtro Remoto';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Impostazioni Filtro Numeri Remoto';

  @override
  String get remoteNumberFilter => 'Protezione soglia query cloud';

  @override
  String get remoteNumberFilterDescription =>
      'Blocca automaticamente le chiamate che superano la soglia di segnalazione cloud';

  @override
  String get remoteNumberFiltering => 'Filtraggio Numeri Remoto';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Filtraggio Numeri Remoto: Regole di filtraggio basate su informazioni del database remoto';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifica chiamate spam utilizzando database cloud e segnalazioni della community';

  @override
  String get removeAdsDescription =>
      'Rimuovi permanentemente tutte le pubblicità nell\'app per un\'esperienza più fluida';

  @override
  String get removeAdsTitle => 'Rimuovi Pubblicità';

  @override
  String get removedFromFavorites => 'Rimosso dai contatti preferiti';

  @override
  String get removeFromFavorites => 'Rimuovi dai Preferiti';

  @override
  String get renameDeviceTitle => 'Rinomina Dispositivo';

  @override
  String get requestAllPermissions => 'Richiedi Tutte le Autorizzazioni';

  @override
  String get requestPermission => 'Richiedi Autorizzazione';

  @override
  String requestPermissionFailed(Object error) {
    return 'Impossibile richiedere l\'autorizzazione: $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Marchi';
  }

  @override
  String get reset => 'Ripristina';

  @override
  String get restore => 'Ripristina';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Ripristina Impostazioni Applicazione da Backup';

  @override
  String get restoreFromCloud => 'Ripristina da Cloud';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Impossibile ripristinare da cloud: $error';
  }

  @override
  String get restoreFromCloudSuccess => 'Ripristinato con successo da cloud';

  @override
  String get restorePurchases => 'Ripristina Acquisti';

  @override
  String get restoreSettings => 'Ripristina Impostazioni';

  @override
  String get restoreSettingsConfirmation =>
      'Questo sostituirà tutte le tue impostazioni attuali. Sei sicuro di voler continuare?';

  @override
  String get retry => 'Riprova';

  @override
  String get ridesharing => 'Ride-sharing';

  @override
  String get risk => 'Rischio';

  @override
  String get robocall => 'Robocall';

  @override
  String get ruleAction => 'Azione Regola';

  @override
  String get ruleAddedSuccess => 'Regola aggiunta con successo';

  @override
  String get ruleAddSuccess => 'Regola aggiunta con successo';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Sei sicuro di voler eliminare questo $ruleType?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Elimina Regola';

  @override
  String get ruleDeletedSuccessfully => 'Regola eliminata con successo';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Impossibile eliminare la regola: $error';
  }

  @override
  String get ruleDeleteSuccess => 'Regola eliminata con successo';

  @override
  String get ruleDisabledSuccessfully => 'Regola disabilitata con successo';

  @override
  String get ruleEnabledSuccessfully => 'Regola abilitata con successo';

  @override
  String ruleLoadFailed(Object error) {
    return 'Impossibile caricare le regole: $error';
  }

  @override
  String get ruleManagement => 'Gestione Regole';

  @override
  String get ruleName => 'Nome Regola';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Nome regola ed espressione regolare del contenuto non possono essere vuoti';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Nome regola e numero di telefono non possono essere vuoti';

  @override
  String get ruleNameHint => 'es. Famiglia, Amici, ecc.';

  @override
  String get ruleNameLabel => 'Nome Regola';

  @override
  String get ruleNameRequired =>
      'Nome regola e numero di telefono non possono essere vuoti';

  @override
  String get ruleNotExist => 'Regola non esistente o eliminata';

  @override
  String ruleNotFound(Object error) {
    return 'Regola non trovata: $error';
  }

  @override
  String get ruleSavedSuccessMessage => 'Regola salvata con successo!';

  @override
  String get rulesExportedSuccessfully => 'Regole esportate con successo';

  @override
  String rulesExportedTo(Object path) {
    return 'Regole esportate in: $path';
  }

  @override
  String get rulesImported => 'Regole importate con successo';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count regole importate con successo';
  }

  @override
  String ruleStatusChanged(Object status) {
    return 'Regola $status con successo';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Operazione fallita: $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Regola $status con successo';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Impossibile aggiornare la regola: $error';
  }

  @override
  String get ruleUpdateSuccess => 'Regola aggiornata con successo';

  @override
  String get ruleVerification => 'Verifica regola';

  @override
  String get save => 'Salva';

  @override
  String get saveButton => 'Salva';

  @override
  String get saveButtonText => 'Salva';

  @override
  String saveFailed(Object error) {
    return 'Salvataggio fallito: $error';
  }

  @override
  String get saveSettings => 'Salva Impostazioni';

  @override
  String get scamsLikely => 'Probabili Truffe';

  @override
  String get search => 'Cerca';

  @override
  String get searchContacts => 'Cerca Contatti';

  @override
  String searchError(Object error) {
    return 'Errore di ricerca: $error';
  }

  @override
  String get searchHint => 'Cerca...';

  @override
  String get securityMessage =>
      'Non fidarti di nessuna chiamata. Verifica sempre autonomamente i numeri del servizio clienti. Non condividere mai password, codici di verifica, numeri di carta o informazioni personali.';

  @override
  String get selectActionWhenBlockingCalls =>
      'Seleziona l\'azione quando blocchi le chiamate';

  @override
  String get selectActionWhenRuleMatches =>
      'Seleziona l\'azione quando la regola corrisponde';

  @override
  String get selectAll => 'Seleziona Tutto';

  @override
  String get selectCountry => 'Seleziona Paese';

  @override
  String selectedItems(Object count) {
    return '$count elementi selezionati';
  }

  @override
  String get selectedLabel => 'Selezionato:';

  @override
  String get selectExportFormat => 'Seleziona Formato di Esportazione';

  @override
  String get selectLabel => 'Seleziona Etichetta';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Seleziona un\'etichetta e inserisci un numero di telefono valido';

  @override
  String get selectLanguage => 'Seleziona Lingua';

  @override
  String get selectMultiple => 'Seleziona Più';

  @override
  String get selectSimCard => 'Seleziona Scheda SIM';

  @override
  String get selectTags => 'Seleziona Tag';

  @override
  String get selectTrustedDataSource => 'Seleziona origini dati attendibili';

  @override
  String get selectYourLanguage => 'Seleziona la Tua Lingua';

  @override
  String get sender => 'Mittente';

  @override
  String get senderRegexOptional => 'Regex Mittente (Opzionale)';

  @override
  String get serverAddressLabel => 'Indirizzo Server';

  @override
  String get serviceTypeContact => 'Abbonamento Contatto';

  @override
  String get serviceTypeLabel => 'Tipo Servizio';

  @override
  String get serviceTypePhone => 'Abbonamento Telefono';

  @override
  String get serviceTypePlugin => 'Aggiornamento Plugin';

  @override
  String get serviceTypeSms => 'Abbonamento SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setEncryptionPassword => 'Imposta Password di Crittografia';

  @override
  String get settings => 'Impostazioni';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Impostazioni sottoposte a backup in: $path';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Impostazioni ripristinate con successo. Riavvia l\'app affinché le modifiche abbiano effetto.';

  @override
  String get settingsSaved => 'Impostazioni salvate';

  @override
  String settingsSaveFailed(Object error) {
    return 'Impossibile salvare le impostazioni: $error';
  }

  @override
  String get settingsTab => 'Impostazioni';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get setup => 'Configurazione';

  @override
  String get silence => 'Silenzia';

  @override
  String get silenceAndNoAnswer => 'Silenzia suoneria';

  @override
  String get silenceNoAnswer => 'Silenzia Nessuna Risposta';

  @override
  String get silentCallVoiceClone => 'Clonazione Voce Chiamata Silenziosa';

  @override
  String get silentRules => 'Regole Silenziose';

  @override
  String simCard(Object simNumber) {
    return 'SIM Card $simNumber';
  }

  @override
  String get simCardColor => 'Colore Scheda SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Configurazione Scheda SIM: Imposta regole di filtro indipendenti per ogni scheda SIM';

  @override
  String get simCardFilterRules => 'Regole Filtro Scheda SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Imposta regole di filtro diverse in base agli slot della scheda SIM';

  @override
  String get simCardFontSize => 'Dimensione Font Scheda SIM';

  @override
  String get simCardPosition => 'Posizione Scheda SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String get simRuleInstructions =>
      'Le regole dello slot SIM consentono di configurare regole di filtraggio indipendenti per ogni slot SIM.';

  @override
  String get simRuleInstructionsTitle => 'Regole Slot SIM';

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
      'Configura regole di filtraggio indipendenti per ogni scheda SIM:';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Impostazioni Filtro Slot SIM $slotNumber';
  }

  @override
  String get simSlotManagement => 'Gestione Slot SIM';

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Posizione Slot SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Regole Slot SIM: Strategie di filtraggio indipendenti per SIM';

  @override
  String get simSlotRuleListTitle => 'Elenco Regole Slot SIM';

  @override
  String get simSlotRuleManagement => 'Regole Slot SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Slot SIM $slotNumber';
  }

  @override
  String get skip => 'Salta';

  @override
  String get smartCallerId => 'Identificazione Chiamante Intelligente';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Il filtraggio SMS ti aiuta a filtrare automaticamente i messaggi di spam e a mantenere pulita la tua lista messaggi. Puoi impostare regole di filtro e metodi di notifica.';

  @override
  String get smsFilterDisabled => 'Filtraggio SMS disabilitato';

  @override
  String get smsFilterEnabled => 'Filtraggio SMS abilitato';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Regola filtro SMS aggiunta con successo';

  @override
  String get smsFilterRules => 'Regole Filtro SMS';

  @override
  String get smsFilterSettings => 'Impostazioni Filtro SMS';

  @override
  String get smsManagement => 'Gestione SMS';

  @override
  String get smsPermission => 'Permesso SMS';

  @override
  String get smsPermissionDescription =>
      'Utilizzato per filtrare messaggi di spam.';

  @override
  String get smsRuleAddedSuccessfully => 'Regola SMS aggiunta con successo';

  @override
  String get smsRuleDeletedSuccessfully => 'Regola SMS eliminata con successo';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Impossibile caricare le regole SMS: $error';
  }

  @override
  String get smsRuleManagement => 'Gestione Regole SMS';

  @override
  String get smsRuleSubscription => 'Sottoscrizione Regola SMS';

  @override
  String get smsSubscription => 'Sottoscrizione SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Sottoscrizione SMS aggiunta con successo';

  @override
  String get smsSubscriptionRulesDescription =>
      'Iscriviti agli elenchi di regole SMS tramite URL, supportando la corrispondenza con espressioni regolari. Puoi impostare azioni di blocco o consentimento.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied =>
      'Alcune richieste di autorizzazione negate';

  @override
  String get spamLikely => 'Probabile Spam';

  @override
  String get startColor => 'Colore Iniziale';

  @override
  String get startDate => 'Data Inizio';

  @override
  String get startUsing => 'Inizia';

  @override
  String get statAnswered => 'Risposto';

  @override
  String get statBlocked => 'Bloccato';

  @override
  String get statistics => 'Statistiche';

  @override
  String get statisticsPageTitle => 'Analisi Dati';

  @override
  String get stirColor => 'Colore STIR';

  @override
  String get stirFontSize => 'Dimensione Font STIR';

  @override
  String get stirPosition => 'Posizione STIR';

  @override
  String get storagePermission => 'Permesso di Archiviazione';

  @override
  String get storagePermissionDescription =>
      'Utilizzato per salvare impostazioni e regole.';

  @override
  String get subscribe => 'Iscriviti';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Sottoscrizione \"$name\" aggiunta con successo';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Sei sicuro di voler eliminare questa sottoscrizione?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Elimina Sottoscrizione';

  @override
  String get subscriptionDeleted => 'Sottoscrizione eliminata';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Impossibile eliminare la sottoscrizione: $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Sottoscrizione eliminata';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Impossibile caricare le sottoscrizioni: $error';
  }

  @override
  String get subscriptionName => 'Nome Sottoscrizione';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Il nome della sottoscrizione e l\'URL non possono essere vuoti';

  @override
  String get subscriptionNameHint => 'Inserisci il nome della sottoscrizione';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Impossibile modificare lo stato della sottoscrizione: $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Impossibile aggiornare la sottoscrizione: $error';
  }

  @override
  String get subscriptionUpdateSuccess =>
      'Sottoscrizione aggiornata con successo';

  @override
  String get subscriptionUrl => 'URL Sottoscrizione';

  @override
  String get subscriptionUrlHint => 'Inserisci l\'URL della sottoscrizione';

  @override
  String successfullyImportedRules(Object count) {
    return 'Importate con successo $count regole';
  }

  @override
  String get supportSync => 'Supporta Sincronizzazione';

  @override
  String get survey => 'Sondaggio';

  @override
  String get syncDevicesButton => 'Sincronizza Dispositivi';

  @override
  String get syncFailed => 'Sincronizzazione fallita';

  @override
  String get syncFailedMessage => 'Sincronizzazione fallita';

  @override
  String get syncFolderNameLabel => 'Nome Cartella Sincronizzazione';

  @override
  String get synchronized => 'Sincronizzato';

  @override
  String get syncing => 'Sincronizzazione in corso...';

  @override
  String get syncNow => 'Sincronizza Ora';

  @override
  String get syncNowButton => 'Sincronizza ora';

  @override
  String get syncStatusTitle => 'Stato sincronizzazione';

  @override
  String get syncStatusUpdatedMessage => 'Stato sincronizzazione aggiornato';

  @override
  String get syncSuccessMessage => 'Sincronizzazione riuscita';

  @override
  String get syncWithCloudStorage => 'Sincronizza con archiviazione cloud';

  @override
  String get systemFeatures => 'Funzionalità di sistema:';

  @override
  String get systemSettingsTitle => 'Impostazioni di sistema';

  @override
  String get tabAll => 'Tutto';

  @override
  String get tabAnswered => 'Risposte';

  @override
  String get tabBlocked => 'Bloccate';

  @override
  String get tabMissed => 'Perse';

  @override
  String get tabOutgoing => 'In uscita';

  @override
  String tagLabel(String tag) {
    return 'Tag: $tag';
  }

  @override
  String get takeaway => 'Asporto';

  @override
  String get telecommunication => 'Telecomunicazioni';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Telemarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testConnectionButton => 'Test Connessione';

  @override
  String get textColorsSetting => 'Colori testo ed etichette';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Questa app è un potente strumento di identificazione chiamante che ti permette di identificare e bloccare chiamate indesiderate.';

  @override
  String get thisWeek => 'Questa settimana';

  @override
  String get timeInterceptor => 'Protezione chiamate frequenti';

  @override
  String get timeInterceptorDescription =>
      'Blocca chiamate ripetute dallo stesso numero in breve tempo';

  @override
  String get timeInterceptorExplanation =>
      '• Intercettazione oraria: Intercetta/consenti chiamate ripetute in un breve lasso di tempo';

  @override
  String get timeInterceptorExplanationContent =>
      'La funzione di intercettazione della frequenza delle chiamate analizza la frequenza delle chiamate per identificare e intercettare/consentire automaticamente chiamate spam frequenti.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Spiegazione intercettazione frequenza chiamate';

  @override
  String get timeInterceptorSettingsTitle =>
      'Impostazioni intercettazione frequenza chiamate';

  @override
  String get timeWindowDescription =>
      'Imposta la dimensione della finestra temporale per consentire chiamate ripetute. Le chiamate dallo stesso numero all\'interno di questa finestra verranno consentite.';

  @override
  String timeWindowLabel(int minutes) {
    return 'Finestra di tempo intercettazione (minuti): $minutes';
  }

  @override
  String get today => 'Oggi';

  @override
  String get total => 'Totale';

  @override
  String get totalBlocked => 'Totale bloccate';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Trasferisci dati tra dispositivi o piattaforme';

  @override
  String get travelTicketing => 'Biglietteria viaggi';

  @override
  String get tutorial => 'Tutorial';

  @override
  String get type => 'Tipo';

  @override
  String get unassignedSIMCard => 'Scheda SIM non assegnata';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get unknownTag => 'Tag: Sconosciuto';

  @override
  String get unregisterButton => 'Annulla registrazione';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Sei sicuro di voler annullare la registrazione di $deviceName?';
  }

  @override
  String get unregisterDeviceTitle => 'Annulla registrazione dispositivo';

  @override
  String get unsupportedFileFormat => 'Formato file non supportato';

  @override
  String get update => 'Aggiorna';

  @override
  String get updateAllNow => 'Aggiorna tutto ora';

  @override
  String updateContactFailed(Object error) {
    return 'Impossibile aggiornare il contatto: $error';
  }

  @override
  String get updateFavoriteStatus => 'Aggiorna stato preferito';

  @override
  String get updateInterval => 'Intervallo di aggiornamento';

  @override
  String get updateNow => 'Aggiorna ora';

  @override
  String get updatePlugin => 'Aggiorna plugin';

  @override
  String updatePluginFailed(Object error) {
    return 'Impossibile aggiornare il plugin: $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Impossibile aggiornare la regola: $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Impossibile aggiornare l\'abbonamento: $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service aggiornato correttamente ($count regole)';
  }

  @override
  String get useCasesPoint1 =>
      '• Identifica chiamate spam di richiamata automatica';

  @override
  String get useCasesPoint2 =>
      '• Intercetta chiamate di marketing che chiamano più volte in un breve periodo';

  @override
  String get useCasesPoint3 => '• Prevenire chiamate indesiderate e molestie';

  @override
  String get useCasesTitle => 'Casi d\'uso:';

  @override
  String get useGlobalSettings => 'Utilizza impostazioni globali';

  @override
  String get usernameLabel => 'Nome utente';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Utilizza la sintassi regex standard per definire i pattern. Esempi:';

  @override
  String get verificationFailedText => 'Fallito';

  @override
  String get verifiedText => 'Verificato';

  @override
  String get verify => 'Verifica';

  @override
  String version(Object version) {
    return 'Versione: $version';
  }

  @override
  String get vipExchangeDescription =>
      'Scambia l\'iscrizione VIP con conteggi di marcatura del numero di telefono';

  @override
  String get vipExchangeTitle => 'Scambia VIP di marcatura';

  @override
  String get watchAd => 'Guarda annuncio';

  @override
  String get watchAdForTemp => 'Guarda annuncio per privilegi temporanei';

  @override
  String get watchAdForTempDescription =>
      'Guarda un breve annuncio per sbloccare temporaneamente alcune funzionalità premium';

  @override
  String get webDAVConfigTitle => 'Configurazione WebDAV';

  @override
  String get week => 'Settimana';

  @override
  String get welcome => 'Benvenuto';

  @override
  String get whitelist => 'Whitelist';

  @override
  String get width => 'Larghezza';

  @override
  String get wildcardMatchingDescription =>
      'Usa \'.\' per corrispondere a qualsiasi carattere (es. \'123.456\' corrisponde a 123-456)';

  @override
  String get wildcardMatchingTitle => 'Corrispondenza wildcard:';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Supporto wildcard per filtri flessibili';

  @override
  String get windowSizeSetting => 'Dimensione finestra';

  @override
  String get year => 'Anno';

  @override
  String get noSimCardsDetected => 'Nessuna scheda SIM rilevata';

  @override
  String get filterManagementDescription => 'Imposta filtri chiamate';

  @override
  String get callerIdCustomizationSubtitle =>
      'Personalizza il layout dell\'ID chiamante';

  @override
  String get fraudAlerSettingTitle => 'Impostazioni avviso frode';

  @override
  String get fraudAlerSettingSubtitle => 'Per impostare avvisi frode';

  @override
  String get enableFraudAlert => 'Abilita avviso frode';

  @override
  String get enableFraudAlertDescription => 'Avvisa per sospette chiamate scam';

  @override
  String get enableVibration => 'Abilita vibrazione';

  @override
  String get enableVibrationDescription =>
      'Vibra quando una chiamata è sospettata di essere una truffa';

  @override
  String get notificationSettingsTitle => 'Impostazioni notifiche';

  @override
  String get useLocalNotification => 'Usa notifiche locali';

  @override
  String get useLocalNotificationDescription =>
      'Abilita notifiche locali per chiamate in arrivo';

  @override
  String get cancelLocalNotification => 'Chiudi notifiche locali';

  @override
  String get useStirNotification => 'Usa notifiche da STIR';

  @override
  String get cancelLocalNotificationDescription =>
      'Chiudi notifiche locali automaticamente';

  @override
  String get callerIdSettingsTitle => 'Impostazioni ID chiamante';

  @override
  String get callerIdSettingsSubtitle =>
      'Per impostare la notifica e la modalità di visualizzazione delle chiamate in arrivo';

  @override
  String get purchaseTitle => 'Acquisto';

  @override
  String get purchaseSubtitle => 'Per acquistare il servizio';

  @override
  String get callerIdNotificationTitle => 'Informazioni chiamata in arrivo';

  @override
  String get blockedCallTitle => 'Chiamata bloccata';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Chiamata bloccata da $phoneNumber';
  }

  @override
  String get stirVerified => 'Verificato';

  @override
  String get stirNotVerified => 'Non verificato';

  @override
  String get stirFailed => 'Verifica fallita';

  @override
  String get stirUnknown => 'Stato verifica sconosciuto';

  @override
  String get stirVerificationTitle => 'Verifica STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage per il numero $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Impostazioni messaggio di sicurezza scorrevole';

  @override
  String get messageColor => 'Colore messaggio';

  @override
  String get messageFontSize => 'Dimensione font messaggio';

  @override
  String get messagePosition => 'Posizione messaggio';

  @override
  String get containerWidth => 'Larghezza contenitore';

  @override
  String get scrollSpeed => 'Velocità scorrimento';

  @override
  String get enableSecurityMessage => 'Abilita messaggio di sicurezza';

  @override
  String get fraudAlertTitle => 'Avviso frode';

  @override
  String get noBlockedTypeData => 'Nessun dato sul tipo di blocco disponibile';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importa $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName importato con successo, totali $count record importati';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Importazione $entityTypeName fallita: $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Esporta $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName esportato con successo';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Esportazione $entityTypeName fallita: $error';
  }

  @override
  String get cloudSyncService => 'Servizio di sincronizzazione cloud';

  @override
  String get membershipCenter => 'Centro abbonamenti';

  @override
  String get redeemVipWithMarks => 'Riscatta VIP con Punti';

  @override
  String get currentMarkCount => 'Conteggio Punti attuale';

  @override
  String get markMoreNumbersForMore =>
      'Segnala più numeri per ottenere più punti';

  @override
  String get noAds => 'Nessuna pubblicità';

  @override
  String get cloudBackup => 'Backup cloud';

  @override
  String get callerIdEnhancement => 'Miglioramento ID chiamante';

  @override
  String get voiceRecognition => 'Riconoscimento vocale';

  @override
  String get feature => 'Funzionalità';

  @override
  String get normalUser => 'Utente normale';

  @override
  String get vipUser => 'Utente VIP';

  @override
  String get temporaryVip => 'VIP temporaneo';

  @override
  String get removeAds => 'Rimuovi pubblicità';

  @override
  String get settingsBackup => 'Backup impostazioni ';

  @override
  String get allServicesStatusTitle => 'Stato attuale dei servizi';

  @override
  String get allServicesStatusSubtitle =>
      'Stato attuale di ogni servizio cloud';

  @override
  String get redirect => 'Reindirizza';

  @override
  String get notify => 'Notifica';

  @override
  String get log => 'Registra';

  @override
  String get custom => 'Personalizzato';

  @override
  String get allowActionDescription =>
      'Le chiamate verranno consentite, anche se il numero è nella blocklist.';

  @override
  String get blockActionDescription =>
      'Le chiamate verranno bloccate e mostrate nel registro chiamate.';

  @override
  String get silenceActionDescription =>
      'Le chiamate verranno silenziate ma mostrate nel registro chiamate.';

  @override
  String get noneActionDescription =>
      'Nessuna azione speciale verrà intrapresa per la chiamata.';

  @override
  String get redirectActionDescription =>
      'Reindirizza la chiamata a un numero specificato.';

  @override
  String get labelActionDescription =>
      'Aggiungi un\'etichetta alla chiamata per una facile identificazione.';

  @override
  String get notifyActionDescription =>
      'Invia una notifica quando una chiamata viene ricevuta.';

  @override
  String get logActionDescription =>
      'Registra le informazioni della chiamata senza intraprendere altre azioni.';

  @override
  String get customActionDescription => 'Esegui un\'azione personalizzata.';

  @override
  String get synced => 'Sincronizzato';

  @override
  String get needVipAccess =>
      'È necessario l\'accesso VIP per utilizzare questa funzionalità';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importa o esporta i dati di $entityTypeName';
  }

  @override
  String get importExportTitle => 'Importa/Esporta';

  @override
  String get noPhoneRules => 'Nessuna regola telefonica trovata';

  @override
  String get noRegexRules => 'Nessuna regola regex trovata';

  @override
  String get noAllowedBlockedRules =>
      'Nessuna regola consentita/bloccata trovata';

  @override
  String get importExport => 'Importa/Esporta';

  @override
  String get filterByAction => 'Filtra per azione';

  @override
  String get upgradeToVip => 'Aggiorna a VIP';

  @override
  String get batteryOptimizationPermission => 'Ottimizzazione batteria';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Consenti all\'app di funzionare in background per fornire servizi come l\'ID chiamante.';

  @override
  String get permissionTitle => 'Permessi Speciali';

  @override
  String get permissionSubtitle =>
      'Gestisci i permessi di sovrapposizione e ottimizzazione batteria';

  @override
  String get themeSettingsTitle => 'Impostazioni Tema';

  @override
  String get themeSettingsSubtitle => 'Scegli il tuo tema preferito';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeSystem => 'Predefinito di sistema';

  @override
  String get databaseSyncTitle => 'Sincronizzazione Database';

  @override
  String get countrySyncSettingsTitle =>
      'Impostazioni Sincronizzazione Database per Paese';

  @override
  String get countrySyncSettingsSubtitle =>
      'Seleziona i paesi per la sincronizzazione dei dati';

  @override
  String get countryDataDisclaimer =>
      'Nota: Il database potrebbe non includere dati per tutti i paesi o regioni specifici.';

  @override
  String get editSubscription => 'Modifica Abbonamento';

  @override
  String get searchByNameOrPhoneNumber => 'Cerca per Nome o Numero di Telefono';

  @override
  String get allowedBlockedRulesInfo =>
      'Le regole consentite/bloccate vengono utilizzate per associare chiamate a numeri di telefono specifici, che hanno la massima priorità.';

  @override
  String get searchPhoneRulesHint => 'Cerca regole telefoniche';

  @override
  String get phoneRulesInfo =>
      'Le regole telefoniche vengono utilizzate per associare chiamate a numeri di telefono specifici, che hanno una priorità inferiore. Alcune provengono dagli abbonamenti phoneRule.';

  @override
  String get searchSubscriptionsHint => 'Cerca abbonamenti';

  @override
  String get searchPluginsHint => 'Cerca plugin';

  @override
  String get searchLabelsHint => 'Cerca etichette';

  @override
  String get pluginDescription => 'Descrizione plugin';

  @override
  String get enterPluginDescription => 'Inserisci descrizione plugin';

  @override
  String get searchRegexRulesHint => 'Cerca regole regex';

  @override
  String get regexRulesInfo =>
      'Le regole Regex vengono utilizzate per filtrare le chiamate in base ai modelli Regex.';

  @override
  String get searchMarkedPhonesHint => 'Cerca numeri contrassegnati';

  @override
  String get searchContactSubscriptionsHint => 'Cerca abbonamenti contatti';

  @override
  String get showAllContacts => 'Mostra tutti i Contatti';

  @override
  String get showFavorites => 'Mostra Preferiti';

  @override
  String get manualEntry => 'Informazioni Immissione Manuale';

  @override
  String get scriptSaved => 'Script salvato';

  @override
  String editScriptFor(String pluginName) {
    return 'Modifica script per $pluginName';
  }

  @override
  String get saveScript => 'Salva Script';

  @override
  String get testPlugin => 'Testa Plugin';

  @override
  String get description => 'Descrizione';

  @override
  String get accessTargetUrl => 'Accedi URL di destinazione';

  @override
  String get result => 'Risultato';

  @override
  String get editScript => 'Modifica Script';

  @override
  String get numberFormat => 'Formato Numero';

  @override
  String get nationalNumber => 'Numero Nazionale';

  @override
  String get e164Number => 'Numero E164';

  @override
  String get pluginRulesInfo =>
      'Per sicurezza, utilizza solo plugin da fonti attendibili. Sentiti libero di utilizzare i nostri modelli per creare i tuoi plugin personalizzati!';

  @override
  String get advancedMode => 'Modalità Avanzata';

  @override
  String get pleaseEnterAtLeastOneNumber => 'Inserisci almeno un numero.';

  @override
  String get openInWebView => 'Apri in WebView';

  @override
  String get pluginLabel => 'Etichetta Plugin';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Colore Sfondo Messaggio';

  @override
  String get clearAllCallLogs => 'Cancella tutti i registri chiamate';

  @override
  String get clearAllCallLogsConfirmation =>
      'Conferma per cancellare tutti i registri chiamate';

  @override
  String get allCallLogsCleared =>
      'Tutti i registri chiamate sono stati cancellati';

  @override
  String get unblocked => 'Sbloccato';

  @override
  String get blockNumber => 'Blocca Numero';

  @override
  String get blockNumberSuccess => 'Numero bloccato con successo';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Sei sicuro di voler sbloccare $phoneNumber?';
  }

  @override
  String get viewDetails => 'Visualizza Dettagli';

  @override
  String get unblock => 'Sblocca';

  @override
  String get unblockNumber => 'Sblocca Numero';

  @override
  String get unblockNumberSuccess => 'Numero sbloccato con successo';

  @override
  String get unblockNumberFailed => 'Sblocco numero fallito';

  @override
  String get callingNumberFailed => 'Chiamata numero fallita';

  @override
  String get listView => 'Vista Elenco';

  @override
  String get timelineView => 'Vista Timeline';

  @override
  String get nameCannotBeEmpty => 'Il nome non può essere vuoto';

  @override
  String get selectAction => 'Seleziona l\'azione';

  @override
  String get selectTargetService => 'Seleziona il servizio di destinazione';

  @override
  String get callDetails => 'Dettagli Chiamata';

  @override
  String get callType => 'Tipo Chiamata';

  @override
  String get callTime => 'Ora Chiamata';

  @override
  String get numberInvalidFormat => 'Formato numero non valido';

  @override
  String get medium => 'Medium';

  @override
  String get finalRisk => 'Rischio Finale';

  @override
  String get simState => 'Stato SIM';

  @override
  String get ipCountry => 'Paese IP';

  @override
  String get simCountry => 'Paese SIM';

  @override
  String get isRoaming => 'Roaming';

  @override
  String get isNumberMatch => 'Corrispondenza Numero';

  @override
  String get support => 'Supporto';

  @override
  String get rewardedAdService => 'Servizio Annunci Premiati';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Hai già privilegi VIP (eccetto annunci)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Hai già privilegi temporanei, data di scadenza: $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Devi guardare ancora $count annunci per ottenere privilegi VIP temporanei';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Ti sono stati concessi $days giorni di privilegi di acquisto temporanei. Data di scadenza: $expiryDate';
  }

  @override
  String get tempPurchaseExpired =>
      'Il privilegio di acquisto temporaneo è scaduto';

  @override
  String get loadingAd => 'Caricamento Annuncio...';

  @override
  String get earnedTempVip => 'VIP temporaneo guadagnato';

  @override
  String get vipExchangeService => 'Servizio Scambio VIP';

  @override
  String get marksInsufficient => 'Marchi insufficienti per lo scambio';

  @override
  String get invalidExchangeRule => 'Regola di scambio non valida';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Scambiato con successo per $description, data di scadenza: $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Scambio fallito: $error';
  }

  @override
  String get vip3DaysWithAds =>
      'VIP di 3 giorni con annunci (solo sincronizzazione)';

  @override
  String get vip5DaysNoAds => 'VIP completo senza pubblicità di 5 giorni';

  @override
  String get vip7DaysNoAds => 'VIP completo senza pubblicità di 7 giorni';

  @override
  String get noNotifications => 'Nessuna notifica';

  @override
  String get clearAllNotifications => 'Cancella tutte le notifiche';

  @override
  String get clearAllNotificationsConfirmation =>
      'Conferma per cancellare tutte le notifiche';

  @override
  String get clearButton => 'Cancella';

  @override
  String get justNow => 'Ora';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti fa',
      one: '1 minuto fa',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore fa',
      one: '1 ora fa',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni fa',
      one: '1 giorno fa',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Ieri';

  @override
  String get deletionProposal => 'Proposta di eliminazione';

  @override
  String get createProposal => 'Crea Proposta';

  @override
  String get createProposalTitle => 'Crea Proposta di Eliminazione';

  @override
  String get reason => 'Motivo';

  @override
  String get reasonOutdated => 'Numero Obsoleto';

  @override
  String get reasonPrivacy => 'Preoccupazione per la Privacy';

  @override
  String get reasonNotInService => 'Non in Servizio';

  @override
  String get reasonWronglyIdentified => 'Identificato Erroneamente';

  @override
  String get reasonInaccurateInfo => 'Informazioni Inaccurate';

  @override
  String get reasonOther => 'Altro';

  @override
  String get submit => 'Invia';

  @override
  String get cancel => 'Annulla';

  @override
  String get riskLevel => 'Livello di Rischio';

  @override
  String get riskLevelLow => 'Basso';

  @override
  String get riskLevelHigh => 'Alto';

  @override
  String agreeVotes(int count) {
    return 'Favorevoli: $count';
  }

  @override
  String totalVotes(int count) {
    return 'Totale: $count';
  }

  @override
  String get voteAgree => 'Favorevole';

  @override
  String get voteDisagree => 'Contrario';

  @override
  String createdAt(String date) {
    return 'Creato: $date';
  }

  @override
  String get verificationReport => 'Report di Verifica';

  @override
  String get proposalStatistics => 'Statistiche Proposte';

  @override
  String get totalProposals => 'Proposte Totali';

  @override
  String get activeProposals => 'Proposte Attive';

  @override
  String get proposalCreated => 'Proposta creata con successo';

  @override
  String get voteSubmitted => 'Voto inviato con successo';

  @override
  String get noProposalsFound => 'Nessuna proposta trovata';

  @override
  String get refreshProposals => 'Aggiorna Proposte';

  @override
  String get totalPendingProposals => 'Proposte in attesa totali';

  @override
  String get highRisk => 'Rischio Alto';

  @override
  String get mediumRisk => 'Rischio Medio';

  @override
  String get lowRisk => 'Rischio Basso';

  @override
  String get communityImpact => 'Impatto sulla Community';

  @override
  String get criticalIssues => 'Problemi Critici';

  @override
  String get communityParticipation => 'Partecipazione Community';

  @override
  String get noActivity => 'Nessuna Attività';

  @override
  String get low => 'Basso';

  @override
  String get moderate => 'Moderato';

  @override
  String get high => 'Alto';

  @override
  String get veryHigh => 'Molto Alto';

  @override
  String get voted => 'Votato';

  @override
  String get communityVotes => 'Voti della community';

  @override
  String get waitingForMoreVotes => 'In attesa di più voti dalla community';

  @override
  String get proposalProcessed => 'Questa proposta è stata elaborata';

  @override
  String get supported => 'SUPPORTATO';

  @override
  String get opposed => 'OPPOSTO';

  @override
  String get approved => 'APPROVATO';

  @override
  String get rejected => 'RIFIUTATO';

  @override
  String get completed => 'COMPLETATO';

  @override
  String get pending => 'IN ATTESA';

  @override
  String get critical => 'Critico';

  @override
  String get oppose => 'Opporsi';

  @override
  String get veryLow => 'Molto Basso';

  @override
  String get deletionProposals => 'Proposte di eliminazione';

  @override
  String get deletionProposalNotificationDescription =>
      'Notifiche sui risultati e sugli aggiornamenti delle votazioni per le proposte di eliminazione.';

  @override
  String get deletionProposalCreated => 'Proposta di Eliminazione Creata';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'La tua proposta di eliminazione per $phoneNumber è stata inviata per la revisione della community.';
  }

  @override
  String get proposalApproved => 'Proposta Approvata ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La proposta di eliminazione per $phoneNumber è stata approvata dalla community ($supportPercentage% di supporto, $totalVotes voti).';
  }

  @override
  String get proposalRejected => 'Proposta Rifiutata ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La proposta di eliminazione per $phoneNumber è stata rifiutata dalla community ($supportPercentage% di supporto, $totalVotes voti).';
  }

  @override
  String get communityVotingStarted => 'Votazione Community Iniziata';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Una nuova proposta di eliminazione per $phoneNumber è ora aperta per la votazione della community.';
  }

  @override
  String get votingCompleted => 'Votazione Completata';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'La votazione della community per $phoneNumber è terminata. Risultato: $result ($supportPercentage% di supporto).';
  }

  @override
  String get newVoteReceived => 'Nuovo Voto Ricevuto';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Qualcuno ha votato per $voteType l\'eliminazione di $phoneNumber. Voti attuali: $totalVotes.';
  }

  @override
  String get voteCount => 'Conteggio Voti';

  @override
  String get deletionProposalDescription =>
      'Proponi numeri da eliminare che violano le linee guida della community. La tua partecipazione aiuta a mantenere la piattaforma sicura.';

  @override
  String get searchProposals => 'Cerca Proposte';

  @override
  String get defaultNotifications => 'Notifiche Predefinite';

  @override
  String get defaultNotificationsDescription =>
      'Canale di notifica predefinito per l\'app.';

  @override
  String get blockedCallNotifications => 'Notifiche Chiamate Bloccate';

  @override
  String get blockedCallNotificationsDescription =>
      'Visualizza informazioni sulle chiamate bloccate.';

  @override
  String get stirVerification => 'Verifica STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Visualizza i risultati della verifica STIR/SHAKEN per i numeri.';

  @override
  String get fraudAlerts => 'Avvisi frode';

  @override
  String get fraudAlertsDescription =>
      'Visualizza avvisi per potenziali chiamate fraudolente.';

  @override
  String get notificationMode => 'Modalità notifica';

  @override
  String get pendingProposals => 'Proposte in sospeso';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count proposte in sospeso',
      one: '1 proposta in sospeso',
      zero: 'nessuna proposta in sospeso',
    );
    return 'Hai $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Linee guida';

  @override
  String get riskLevelLabel => 'Livello di rischio';

  @override
  String get phoneNumberMinDigits =>
      'Il numero di telefono deve avere almeno 7 cifre';

  @override
  String get provideDetailedExplanation =>
      'Fornisci una spiegazione dettagliata (minimo 10 caratteri)';

  @override
  String get reasonMinCharacters =>
      'La ragione deve contenere almeno 10 caratteri';

  @override
  String get countryCodeTwoLetters => 'Codice Paese (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Codice Paese (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'es. IT, FR, DE';

  @override
  String get countryCodeRequired => 'Il codice paese è obbligatorio';

  @override
  String get phoneNumberHint => 'Inserisci numero di telefono';

  @override
  String get phoneNumberRequired => 'È richiesto il numero di telefono';

  @override
  String get reasonRequired => 'La ragione è obbligatoria';

  @override
  String get riskLevelCritical => 'Critico';

  @override
  String get riskLevelMedium => 'Medio';

  @override
  String get riskLevelVeryLow => 'Molto basso';

  @override
  String get notificationFrequencyTitle => 'Frequenza notifiche';

  @override
  String errorMessage(String error) {
    return 'Errore: $error';
  }

  @override
  String get reportingGuidelines =>
      '• Segnala solo numeri che sono veramente problematici\n• Fornisci ragioni accurate e dettagliate\n• Scegli il livello di rischio appropriato in base alla gravità\n• Segnalazioni false potrebbero comportare restrizioni dell\'account';

  @override
  String get notificationFrequencyHours => 'Frequenza notifiche (Ore)';

  @override
  String supportCount(int supportCount) {
    return 'Supporto ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Contrari ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes voti ($supportPercentage% di supporto)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore',
      one: '1 ora',
      zero: '0 ore',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Avviso Importante';

  @override
  String get dataSourceDisclaimer =>
      'I numeri sono reperiti da Internet e da invii degli utenti. Non possiamo garantire che un numero, una volta eliminato, non venga nuovamente inserito da altri utenti o fonti. Si prega di cercare e verificare attivamente le informazioni.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Località';

  @override
  String get simCardTitle => 'Scheda SIM';

  @override
  String get liveActivitiesSettingsTitle => 'Impostazioni Attività Live';

  @override
  String get elementsSettingsTitle => 'Impostazioni Elementi';

  @override
  String get liveActivityMode => 'Attività Live';

  @override
  String get liveActivityModeDescription =>
      'Visualizza le informazioni sulla chiamata come notifica persistente sulla schermata di blocco e nell\'Isola Dinamica (iOS).';

  @override
  String get phoneNumberType => 'Tipo di numero di telefono';

  @override
  String get liveActivitiesTestEndActivity => 'Termina Attività';

  @override
  String get liveActivitiesTestSendNewActivity => 'Invia Nuova Attività';

  @override
  String get liveActivitiesTestUpdateActivity => 'Aggiorna Attività';

  @override
  String get liveActivityControlsTitle => 'Controlli Attività Live';

  @override
  String get liveActivitiesTestTitle => 'Test Attività Live';

  @override
  String get liveNotificationCustomizationTitle =>
      'Personalizzazione Notifiche Live';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Personalizza l\'aspetto delle notifiche live.';

  @override
  String get notification_instructions =>
      'Istruzioni:\n1. Tocca \"INVIA\" per creare o aggiornare una notifica.\n2. Vai alla schermata principale o scorri verso il basso per vedere il risultato.\n3. Tocca \"TERMINA\" per chiudere la notifica.';

  @override
  String get autoCancelNotification => 'Annulla automaticamente notifica';

  @override
  String get autoCancelNotificationDescription =>
      'Se selezionato, la notifica verrà automaticamente chiusa quando l\'utente la tocca.';

  @override
  String get setDelayTime => 'Imposta tempo di ritardo';

  @override
  String get proposalDetails => 'Dettagli proposta';

  @override
  String get proposalNotFound => 'Proposta non trovata';

  @override
  String get processed => 'Elaborato';

  @override
  String get filterAndSortTitle => 'Filtra e ordina';

  @override
  String get filterVerifiedOwner => 'Filtra proprietario verificato';

  @override
  String get filterBy => 'Filtra per';

  @override
  String get sortOldest => 'Ordina più vecchi';

  @override
  String get sortNewest => 'Ordina più recenti';

  @override
  String get sortMostPopular => 'Ordina più popolari';

  @override
  String get sortLeastPopular => 'Ordina meno popolari';

  @override
  String get sortBy => 'Ordina per';

  @override
  String get simRulesNotFound => 'Regole SIM non trovate';

  @override
  String get simSlotRules => 'Regole slot SIM';

  @override
  String get noSimCardDetected => 'Nessuna scheda SIM rilevata';

  @override
  String get invalidSimData => 'Dati SIM non validi';

  @override
  String get simSlot => 'Slot SIM';

  @override
  String get enableFiltering => 'Abilita filtraggio';

  @override
  String get detailedSettingsTitle => 'Impostazioni dettagliate';

  @override
  String get entryPointViewTitle => 'Vista Punto di Ingresso';

  @override
  String get callTypeRejected => 'Rifiutata';

  @override
  String get callTypeSilenced => 'Silenziosa';

  @override
  String andMoreItems(int count) {
    return 'e altri $count elementi';
  }

  @override
  String get ruleType => 'Tipo di regola';

  @override
  String get localDatabaseSyncTitle => 'Sincronizzazione database locale';

  @override
  String get localDatabaseSyncSubtitle => 'Sincronizza dati tra dispositivi';

  @override
  String get supabaseProjectUrl => 'URL del progetto Supabase';

  @override
  String get supabaseAnonKey => 'Chiave anonima';

  @override
  String get supabaseAnonKeyHint => 'API Key, chiave pubblica anonima';

  @override
  String get connectionString => 'Stringa di connessione (URI)';

  @override
  String get connectionStringHelper =>
      'Necessario solo per \'Inizializza database\'';

  @override
  String get syncCallHistory => 'Sincronizza cronologia chiamate';

  @override
  String get syncCallHistorySubtitle =>
      'Includi i registri delle chiamate private nella sincronizzazione';

  @override
  String get requiredField => 'Obbligatorio';

  @override
  String get requiredInitField => 'Obbligatorio per l\'inizializzazione';

  @override
  String get initDbButton => 'Inizializza database';

  @override
  String get dbInitSuccess => 'Database inizializzato con successo!';

  @override
  String syncSuccess(int pushed, int pulled) {
    return 'Sincronizzazione completata. Inviati: $pushed, Ricevuti: $pulled';
  }

  @override
  String get errorPrefix => 'Errore';

  @override
  String get errorLoadingSettings =>
      'Errore durante il caricamento delle impostazioni';

  @override
  String get statusLabel => 'Stato';

  @override
  String get statusConnected => 'Connesso / Configurato';

  @override
  String get statusNotConfigured => 'Non configurato';

  @override
  String get configSaved => 'Configurazione salvata!';

  @override
  String get masterDeviceLabel => 'Dispositivo principale (Admin)';

  @override
  String get masterDeviceHelp =>
      'Solo il dispositivo principale può inizializzare la struttura del database.';

  @override
  String get syncIntervalLabel => 'Intervallo di sincronizzazione automatica';

  @override
  String syncIntervalValue(int hours) {
    return 'Ogni $hours ore';
  }

  @override
  String get leaveEmptyToUseDefault =>
      'Lascia vuoto per usare il valore predefinito';

  @override
  String get vipAccessSubtitle => 'Guarda gli annunci gratis o acquista VIP';

  @override
  String failedToLoadSettingsSchema(String error) {
    return 'Impossibile caricare lo schema delle impostazioni: $error';
  }

  @override
  String get fieldIsRequired => 'Il campo è obbligatorio';

  @override
  String get answerThenHangupDescription =>
      'Rispondi prima alla chiamata, poi riaggancia immediatamente.';

  @override
  String get initialSetupTitle => 'Configurazione della libreria di regole';

  @override
  String get initialSetupDesc =>
      'Seleziona le librerie di regole regionali che desideri bloccare. Queste regole ti aiutano a bloccare automaticamente le chiamate di vendita e truffa comuni nella tua regione.';

  @override
  String get initialSetupRetry => 'Riprova';

  @override
  String get initialSetupSkip => 'Salta';

  @override
  String get initialSetupSave => 'Configurazione selezionata con un clic';

  @override
  String get initialSetupSaving => 'Salvataggio in corso...';

  @override
  String get initialSetupSaveSuccess =>
      '✅ Configurazione salvata con successo, le regole verranno recuperate automaticamente a breve';

  @override
  String initialSetupSaveFailed(String error) {
    return 'Impossibile salvare la configurazione: $error';
  }

  @override
  String get initialSetupGetFailed => 'Impossibile ottenere la configurazione';

  @override
  String get initialSetupSourceTitle => 'Fonte del database delle regole';

  @override
  String get initialSetupSourceGithub => 'Fonte ufficiale GitHub';

  @override
  String get initialSetupSourceCdn => 'Fonte di accelerazione CDN mirror';

  @override
  String get initialSetupSourceCustom => 'Fonte mirror personalizzata';

  @override
  String get initialSetupCustomUrlHint =>
      'Inserisci l\'URL di configurazione JSON mirror';

  @override
  String get initialSetupCustomUrlLoad => 'Carica configurazione';

  @override
  String get initialSetupDetectedLocation => 'Posizione rilevata';

  @override
  String deepLinkImportTitle(String type) {
    return 'Importa configurazione';
  }

  @override
  String get deepLinkTypePlugin => 'Plugin';

  @override
  String get deepLinkTypeSubscription => 'Abbonamento';

  @override
  String get deepLinkDefaultPluginName => 'Plugin importato';

  @override
  String get deepLinkDefaultSubName => 'Abbonamento importato';

  @override
  String get deepLinkDetectedTitle => 'Rilevato collegamento profondo';

  @override
  String deepLinkNameLabel(String name) {
    return 'Nome';
  }

  @override
  String deepLinkTypeLabel(String type) {
    return 'Tipo';
  }

  @override
  String deepLinkUrlLabel(String url) {
    return 'URL';
  }

  @override
  String get deepLinkConfirmButton => 'Conferma importazione';

  @override
  String get deepLinkEmptyUrlError => 'L\'URL non può essere vuoto';

  @override
  String deepLinkPluginDownloadFailed(Object error) {
    return 'Impossibile scaricare il plugin: $error';
  }

  @override
  String get deepLinkImportSuccess => 'Importato con successo';

  @override
  String deepLinkImportFailed(String error) {
    return 'Importazione fallita: $error';
  }

  @override
  String get initialSetupSettingsHint =>
      'Suggerimento: puoi riaprire questa pagina di configurazione in qualsiasi momento nelle Impostazioni.';

  @override
  String get initialSetupGoToSettings => 'Vai alle Impostazioni';

  @override
  String get separateSims => 'SIM Separate';

  @override
  String get separateSimsDesc =>
      'Abilita regole di filtraggio separate per ciascuna scheda SIM';

  @override
  String get masterAndOverrides => 'Controlli Principali';

  @override
  String get masterAndOverridesDesc => 'Impostazioni delle regole globali';
}
