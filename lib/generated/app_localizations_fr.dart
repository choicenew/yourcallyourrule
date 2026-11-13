// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get aboutContactSubscription =>
      'À propos de l\'abonnement aux contacts';

  @override
  String get aboutLabels => 'À propos des étiquettes';

  @override
  String get aboutPhoneSubscriptionRules =>
      'À propos des règles d\'abonnement téléphonique';

  @override
  String get aboutSmsFilter => 'À propos du filtrage des SMS';

  @override
  String get aboutSmsSubscriptionRules =>
      'À propos des règles d\'abonnement aux SMS';

  @override
  String get aboutSubtitle =>
      'Version de l\'application et informations légales';

  @override
  String get aboutTitle => 'À propos';

  @override
  String get action => 'Action';

  @override
  String get actionAll => 'Tous';

  @override
  String get actionAllow => 'Autoriser';

  @override
  String get actionBlock => 'Bloquer';

  @override
  String get actionFilterTitle => 'Filtrer par type d\'action';

  @override
  String get actionFilterTooltip => 'Filtre d\'action';

  @override
  String get actionNone => 'Aucune action';

  @override
  String get actionSilence => 'Silence';

  @override
  String actionTag(Object actionType) {
    return 'Action : $actionType';
  }

  @override
  String get actionType => 'Type d\'action';

  @override
  String get actionUnknown => 'Inconnu';

  @override
  String get add => 'Ajouter';

  @override
  String get addAllowedBlockedRule => 'Ajouter une règle Autoriser/Bloquer';

  @override
  String get addAllowSubscription => 'Ajouter un abonnement Autoriser';

  @override
  String get addBlockSubscription => 'Ajouter un abonnement Bloquer';

  @override
  String get addContactButton => 'Ajouter un contact';

  @override
  String addContactFailed(Object error) {
    return 'Échec de l\'ajout du contact : $error';
  }

  @override
  String get addedToFavorites => 'Ajouté aux contacts favoris';

  @override
  String get addLabel => 'Ajouter une étiquette';

  @override
  String get addLabelButton => 'Ajouter une étiquette';

  @override
  String addLabelFailed(Object error) {
    return 'Échec de l\'ajout de l\'étiquette : $error';
  }

  @override
  String get addName => 'Ajouter un nom';

  @override
  String get addNoneSubscription => 'Ajouter un abonnement Aucun';

  @override
  String get addPhoneMark => 'Ajouter une marque de téléphone';

  @override
  String get addPhoneNumberRule => 'Ajouter une règle de numéro de téléphone';

  @override
  String get addPlugin => 'Ajouter un plugin';

  @override
  String get addPluginFailed => 'Échec de l\'ajout du plugin';

  @override
  String addPluginFailedWithError(Object error) {
    return 'Échec de l\'ajout du plugin : $error';
  }

  @override
  String get addPluginFromLocalFile =>
      'Ajouter un plugin à partir d\'un fichier local';

  @override
  String get addPluginFromUrl => 'Ajouter un plugin à partir d\'une URL';

  @override
  String get addRegexRule => 'Ajouter une règle Regex';

  @override
  String get addRule => 'Ajouter une règle';

  @override
  String addRuleFailed(Object error) {
    return 'Échec de l\'ajout de la règle : $error';
  }

  @override
  String get addRuleTooltip => 'Ajouter une règle';

  @override
  String get addSilenceSubscription => 'Ajouter un abonnement au silence';

  @override
  String get addSmsFilterRule => 'Ajouter une règle de filtre SMS';

  @override
  String get addSmsRule => 'Ajouter une règle SMS';

  @override
  String get addSmsSubscription => 'Ajouter un abonnement SMS';

  @override
  String get addSubscription => 'Ajouter un abonnement';

  @override
  String get addSubscriptionButton => 'Ajouter un abonnement';

  @override
  String addSubscriptionFailed(Object error) {
    return 'Échec de l\'ajout de l\'abonnement : $error';
  }

  @override
  String get addSubscriptionTooltip => 'Ajouter un abonnement';

  @override
  String get addToBlacklist => 'Ajouter à la liste noire';

  @override
  String get addToFavorites => 'Ajouter aux favoris';

  @override
  String get addToRules => 'Ajouter aux règles';

  @override
  String get addToWhitelist => 'Ajouter à la liste blanche';

  @override
  String get agent => 'Agent';

  @override
  String get all => 'Tous';

  @override
  String get allCallsTab => 'Tous';

  @override
  String get allow => 'Autoriser';

  @override
  String get allowAllAllowRules => 'Activer toutes les règles d\'autorisation';

  @override
  String get allowAllAllowRulesDesc =>
      'Interrupteur principal pour appliquer toutes les règles d\'autorisation configurées';

  @override
  String get allowAllBlacklistedNumbers =>
      'Autoriser tous les numéros de la liste noire';

  @override
  String get allowAllBlockRules => 'Activer toutes les règles de blocage';

  @override
  String get allowAllBlockRulesDesc =>
      'Interrupteur principal pour appliquer toutes les règles de blocage configurées';

  @override
  String get allowAllowedNumbers => 'Autoriser tous les numéros approuvés';

  @override
  String get allowAllowedNumbersDesc =>
      'Autoriser tous les appels entrants provenant de numéros de votre liste d\'autorisation';

  @override
  String get allowBlock => 'Autoriser/Bloquer';

  @override
  String get allowBlockedNumbers => 'Ignorer la liste de blocage';

  @override
  String get allowBlockedNumbersDesc =>
      'Autoriser temporairement les appels des numéros de votre liste de blocage';

  @override
  String get allowedBlockedRule => 'Règle Autoriser/Bloquer';

  @override
  String get allowedBlockedRuleEditDialogTitle =>
      'Modifier la règle Autoriser/Bloquer';

  @override
  String get allowedBlockedRuleManagement =>
      'Gestion des règles Autoriser/Bloquer';

  @override
  String get allowNonExceededNumbers =>
      'Autoriser les numéros qui ne dépassent pas';

  @override
  String get allowNonExceededNumbersDescription =>
      'Autoriser automatiquement les numéros ne dépassant pas le seuil de nombre';

  @override
  String get allowRegexAllowRules =>
      'Activer les règles d\'autorisation par Regex';

  @override
  String get allowRegexAllowRulesDesc =>
      'Activer la correspondance de motifs par expression régulière pour les règles d\'autorisation';

  @override
  String get allowRegexAllowRulesDescription =>
      'Activer les règles d\'autorisation basées sur regex';

  @override
  String get allowRegexBlockRules => 'Activer les règles de blocage par Regex';

  @override
  String get allowRegexBlockRulesDesc =>
      'Activer la correspondance de motifs par expression régulière pour les règles de blocage';

  @override
  String get allowRegexBlockRulesDescription =>
      'Activer les règles de blocage basées sur regex';

  @override
  String get allowRule => 'Règle d\'autorisation';

  @override
  String get allowRules => 'Règles d\'autorisation';

  @override
  String get allPermissionsGranted => 'Toutes les permissions accordées';

  @override
  String get allSettingsCompleted => 'Tous les paramètres sont terminés.';

  @override
  String allUpdateSuccess(Object count) {
    return 'Toutes les mises à jour sont terminées ($count règles)';
  }

  @override
  String get answerThenHangup => 'Répondre puis raccrocher';

  @override
  String get applicationSoftware => 'Logiciel d\'application';

  @override
  String get apply => 'Appliquer';

  @override
  String get appName => 'Votre Appel Votre Règle';

  @override
  String get authorizationFailedCheckCredentialsMessage =>
      'L\'autorisation a échoué : veuillez vérifier l\'ID et la clé du client';

  @override
  String get authorizationFailedMessage => 'L\'autorisation a échoué';

  @override
  String get authorizationSuccessMessage => 'Autorisation réussie';

  @override
  String get authorizeLoginButton => 'Autoriser la connexion';

  @override
  String get automotiveIndustry => 'Industrie automobile';

  @override
  String get autoSyncLabel => 'Synchronisation automatique';

  @override
  String get autoUpdate => 'Mise à jour automatique';

  @override
  String get autoUpdateDescription =>
      'Définir les intervalles de mise à jour automatique pour les abonnements ou mettre à jour manuellement';

  @override
  String get autoUpdateSettings => 'Paramètres de mise à jour automatique';

  @override
  String get autoUpdateSubtitle =>
      'Gérer les mises à jour automatiques des règles et des plugins';

  @override
  String get autoUpdateTitle => 'Mise à jour automatique';

  @override
  String get avatarBorderColor => 'Couleur de la bordure de l\'avatar';

  @override
  String get avatarBorderSize => 'Taille de la bordure de l\'avatar';

  @override
  String get avatarIconSizesSetting => 'Tailles de l\'avatar et de l\'icône';

  @override
  String get avatarPosition => 'Position de l\'avatar';

  @override
  String get avatarSize => 'Taille de l\'avatar';

  @override
  String axisPosition(Object axis) {
    return 'Position de l\'axe $axis';
  }

  @override
  String get backgroundGradientSetting => 'Dégradé d\'arrière-plan';

  @override
  String get backup => 'Sauvegarde';

  @override
  String get backupAndRestore => 'Sauvegarde et restauration';

  @override
  String get backupAndRestoreSubtitle =>
      'Sauvegarder ou restaurer les données de l\'application';

  @override
  String get backupAndRestoreTitle => 'Sauvegarde et restauration';

  @override
  String get backupFailed => 'La sauvegarde a échoué';

  @override
  String get backupSettings => 'Paramètres de sauvegarde';

  @override
  String get backupToCloud => 'Sauvegarder dans le cloud';

  @override
  String backupToCloudFailed(Object error) {
    return 'Échec de la sauvegarde dans le cloud : $error';
  }

  @override
  String get backupToCloudSuccess => 'Sauvegarde réussie dans le cloud';

  @override
  String get bank => 'Banque';

  @override
  String get basicInfo => 'Informations de base';

  @override
  String get basicRuleFilter => 'Filtre de règles de base';

  @override
  String get basicRuleFiltering => 'Filtrage de règles de base';

  @override
  String get basicRuleFilteringExplanation =>
      '• Filtrage de règles de base : règles de filtrage basées sur la liste noire, la liste blanche et les expressions régulières';

  @override
  String get basicRuleFilterSubtitle =>
      'Filtrer les appels à l\'aide de la liste noire/liste blanche et des expressions régulières';

  @override
  String batchDeleteContactsConfirm(Object count) {
    return 'Êtes-vous sûr de vouloir supprimer $count contacts sélectionnés ?';
  }

  @override
  String batchDeleteLabelsConfirm(Object count) {
    return 'Êtes-vous sûr de vouloir supprimer $count étiquettes ?';
  }

  @override
  String get blacklist => 'Liste noire';

  @override
  String get blacklistingAndWhitelisting => 'Liste noire et liste blanche';

  @override
  String get blackWhiteList => 'Liste noire/liste blanche';

  @override
  String get block => 'Bloquer';

  @override
  String get blockCalls => 'Bloquer les appels';

  @override
  String get blocked => 'Bloqué';

  @override
  String get blockedCalls => 'Appels bloqués';

  @override
  String get blockedCallsTitle => 'Appels bloqués';

  @override
  String get blockedSpamCalls => 'Appels indésirables bloqués';

  @override
  String get blockingTrend => 'Tendance de blocage';

  @override
  String get blockInternationalCalls =>
      'correspond aux numéros qui ne commencent pas par + ou 00';

  @override
  String get blockInternationalCallsTitle =>
      'Bloquer les appels internationaux';

  @override
  String get blockMobileNumbers =>
      'correspond aux numéros qui ne commencent pas par 13-19';

  @override
  String get blockMobileNumbersTitle =>
      'Bloquer les numéros de téléphone mobile';

  @override
  String get blockPremiumRateNumbers =>
      'correspond aux numéros qui ne commencent pas par 118 ou 120-190';

  @override
  String get blockPremiumRateNumbersTitle =>
      'Bloquer les numéros à tarif premium';

  @override
  String get blockRule => 'Règle de blocage';

  @override
  String get blockRules => 'Règles de blocage';

  @override
  String get blockSpecificAreaCodes =>
      'correspond aux numéros commençant par 0 + 2-3 chiffres';

  @override
  String get blockSpecificAreaCodesTitle =>
      'Bloquer les indicatifs régionaux spécifiques :';

  @override
  String get blockTypeAnalysisTitle => 'Analyse du type de blocage';

  @override
  String get both => 'Les deux';

  @override
  String get bulkDelete => 'Supprimer les contacts par lots';

  @override
  String get bulkDeleteContacts => 'Supprimer les contacts par lots';

  @override
  String get bulkDeleteLabels => 'Supprimer les étiquettes en masse';

  @override
  String get call => 'Appel';

  @override
  String get callback => 'Rappeler';

  @override
  String get callBlocking => 'Blocage d\'appels';

  @override
  String get callerIdApp => 'Application d\'identification de l\'appelant';

  @override
  String get callerIdCustomizationTitle =>
      'Personnaliser l\'identification de l\'appelant';

  @override
  String get callerIdDisplayMode =>
      'Mode d\'affichage de l\'identification de l\'appelant';

  @override
  String callerIdMarkedByCount(Object count) {
    return 'Marqué par $count';
  }

  @override
  String get callerIdPreview => 'Aperçu de l\'identification de l\'appelant';

  @override
  String get callFilterRules => 'Règles de filtrage des appels';

  @override
  String get callFilterRulesDescription =>
      'Définir des règles de base pour le filtrage des appels';

  @override
  String get callFilterSettings => 'Paramètres du filtre d\'appel';

  @override
  String get callFrequencyInterceptionSubtitle =>
      'Définir les limites de fréquence d\'appel et les règles de blocage';

  @override
  String get callFrequencyInterceptionTitle =>
      'Interception de la fréquence des appels';

  @override
  String get callHistory => 'Historique des appels';

  @override
  String get callHistoryInfoDesc =>
      'Ici est affiché votre historique des appels, y compris les appels entrants, sortants et manqués.';

  @override
  String get callHistoryInfoTitle => 'Historique des appels';

  @override
  String get callHistoryTab => 'Historique des appels';

  @override
  String get callScreeningPermission => 'Autorisation de filtrage d\'appel';

  @override
  String get callScreeningPermissionDescription =>
      'Utilisé pour filtrer et bloquer les appels spam.';

  @override
  String get callScreeningPermissionNotGranted =>
      'Autorisation de filtrage d\'appel non accordée, peut affecter les fonctionnalités de l\'application.';

  @override
  String get callStatistics => 'Statistiques d\'appel';

  @override
  String get callTypeAnswered => 'Répondu';

  @override
  String get callTypeBlocked => 'Bloqué';

  @override
  String get callTypeIconColor => 'Couleur de l\'icône du type d\'appel';

  @override
  String get callTypeMissed => 'Appel manqué';

  @override
  String get callTypeOutgoing => 'Sortant';

  @override
  String get callTypePosition => 'Position du type d\'appel';

  @override
  String get callTypeUnknown => 'Inconnu';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get carRental => 'Location de voiture';

  @override
  String get carrier => 'Opérateur';

  @override
  String get carrierColor => 'Couleur de l\'opérateur';

  @override
  String get carrierFontSize => 'Taille de la police de l\'opérateur';

  @override
  String get carrierPosition => 'Position de l\'opérateur';

  @override
  String get changeLabel => 'Modifier l\'étiquette';

  @override
  String changePluginStatusFailed(Object error) {
    return 'Échec du changement de statut du plugin : $error';
  }

  @override
  String changeSubscriptionStatusFailed(Object error) {
    return 'Échec du changement de statut de l\'abonnement : $error';
  }

  @override
  String get charity => 'Association caritative';

  @override
  String get chartOneWeekAgo => 'Il y a 1 semaine';

  @override
  String get chartThreeDaysAgo => 'Il y a 3 jours';

  @override
  String get chartToday => 'Aujourd\'hui';

  @override
  String get checkFileFormat =>
      'Veuillez vérifier le format du fichier ou les permissions';

  @override
  String checkPermissionFailed(Object error) {
    return 'Échec de la vérification des permissions : $error';
  }

  @override
  String get chooseDefaultInterceptAction =>
      'Choisir l\'action d\'interception par défaut';

  @override
  String get clearFilter => 'Effacer le filtre';

  @override
  String get clearLabelFilterButton => 'Effacer le filtre de libellé';

  @override
  String get closeButton => 'Fermer';

  @override
  String get cloudSync => 'Synchronisation Cloud';

  @override
  String get cloudSyncAndBackupTitle => 'Synchronisation et sauvegarde Cloud';

  @override
  String get cloudSyncSettingsSubtitle =>
      'Configurer WebDAV, OneDrive et Google Drive';

  @override
  String get cloudSyncSettingsTitle => 'Paramètres de synchronisation Cloud';

  @override
  String get cloudSyncTitle => 'Synchronisation Cloud';

  @override
  String get collection => 'Recouvrement de créances';

  @override
  String get colorPickerTitle => 'Choisir une couleur';

  @override
  String get configManagement => 'Gestion de la configuration';

  @override
  String get configUpdated => 'Configuration mise à jour';

  @override
  String get configurationAdvice =>
      'Grâce à une configuration appropriée, vous pouvez définir différentes stratégies de filtrage pour les cartes SIM professionnelles et personnelles.';

  @override
  String get configureBackupOptions => 'Configurer les options de sauvegarde';

  @override
  String get configureCloudSyncService =>
      'Configurer le service de synchronisation Cloud';

  @override
  String get configureCloudSyncServiceMessage =>
      'Veuillez configurer un service de synchronisation cloud pour activer la synchronisation multi-appareils.';

  @override
  String get configureSimCardFilterRules =>
      'Configurer les règles de filtrage des cartes SIM';

  @override
  String get confirm => 'Confirmer';

  @override
  String get confirmButton => 'Confirmer';

  @override
  String get confirmDelete => 'Confirmer la suppression';

  @override
  String confirmDeleteLabel(Object name) {
    return 'Êtes-vous sûr de vouloir supprimer le libellé \"$name\"';
  }

  @override
  String confirmDeletePlugin(Object name) {
    return 'Êtes-vous sûr de vouloir supprimer le plugin \"$name\"?';
  }

  @override
  String confirmDeletePlugins(Object count) {
    return 'Êtes-vous sûr de vouloir supprimer $count plugins?';
  }

  @override
  String get confirmDeleteRuleMessage =>
      'Êtes-vous sûr de vouloir supprimer cette règle ? Cette action est irréversible.';

  @override
  String get confirmDeleteSmsFilterRule =>
      'Êtes-vous sûr de vouloir supprimer cette règle de filtrage SMS ?';

  @override
  String get confirmDeleteSmsRule =>
      'Êtes-vous sûr de vouloir supprimer cette règle SMS ?';

  @override
  String confirmDeleteSubscriptions(String name) {
    return 'Êtes-vous sûr de vouloir supprimer $name?';
  }

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get connectedStatus => 'Connecté';

  @override
  String get connectionFailedCheckCredentialsMessage =>
      'Échec de la connexion : Veuillez vérifier l\'adresse du serveur, le nom d\'utilisateur et le mot de passe';

  @override
  String get connectionFailedMessage => 'Échec de la connexion';

  @override
  String get connectionStatusLabel => 'État de la connexion';

  @override
  String get connectionSuccessMessage => 'Connexion réussie';

  @override
  String get contactAddSuccess => 'Contact ajouté avec succès';

  @override
  String get contactDeleted => 'Contact supprimé';

  @override
  String get contactNameLabel => 'Nom';

  @override
  String get contactNotFound => 'Contact introuvable';

  @override
  String get contacts => 'contacts';

  @override
  String contactsDeleted(Object count) {
    return '$count contacts supprimés';
  }

  @override
  String get contactsManagement => 'Gestion des contacts';

  @override
  String get contactsPermission => 'Autorisation des contacts';

  @override
  String get contactsPermissionDescription =>
      'Utilisé pour identifier les appels de contact.';

  @override
  String get contactsTab => 'Contacts';

  @override
  String get contactSubscriptionDescription =>
      'Abonnez-vous aux listes de contacts via l\'URL, mettez automatiquement à jour les informations de contact et les étiquettes. Prend en charge les données au format JSON.';

  @override
  String get contactUpdateSuccess => 'Contact mis à jour avec succès';

  @override
  String get contactUs => 'Contactez nous';

  @override
  String get content => 'Contenu';

  @override
  String get contentRegex => 'Regex du contenu';

  @override
  String get countColor => 'Couleur du nombre';

  @override
  String get countFontSize => 'Taille de la police du nombre';

  @override
  String get countPosition => 'Position du nombre';

  @override
  String get country => 'Pays';

  @override
  String get countryNameColor => 'Couleur du nom du pays';

  @override
  String get countryNameFontSize => 'Taille de la police du nom du pays';

  @override
  String get countryRegionNamePosition =>
      'Position du nom du pays/de la région';

  @override
  String get countThresholdDescription =>
      'Définissez le seuil de nombre minimum requis pour déclencher des actions de filtrage';

  @override
  String get countThresholdLabel => 'Seuil de nombre';

  @override
  String get createdRules => 'Règles créées';

  @override
  String get csvFormat => 'Format CSV';

  @override
  String get currentDeviceLabel => 'Étiquette de l\'appareil actuel';

  @override
  String get currentDeviceTitle => 'Appareil actuel';

  @override
  String get currentLanguage => 'Langue actuelle';

  @override
  String get customerService => 'Service client';

  @override
  String get dashboardTab => 'Tableau de bord';

  @override
  String get dataAnalysis => 'Analyse de données';

  @override
  String dataLoadFailure(Object error) {
    return 'Échec du chargement des données : $error';
  }

  @override
  String dataLoadingFailed(Object error) {
    return 'Échec du chargement des données : $error';
  }

  @override
  String get dataMigration => 'Migration de données';

  @override
  String get dataMigrationDescription =>
      'Cette fonctionnalité vous permet de transférer toutes vos données entre les appareils. Actuellement, vous pouvez utiliser les fonctions de sauvegarde et de restauration pour migrer manuellement vos données.';

  @override
  String get dataSourceReminder => 'Rappel de source de données';

  @override
  String days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String daysVip(Object days) {
    return '$days Jours VIP';
  }

  @override
  String get debtCollection => 'Recouvrement de créances';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get deleteContact => 'Supprimer le contact';

  @override
  String deleteContactConfirm(Object name) {
    return 'Êtes-vous sûr de vouloir supprimer $name ?';
  }

  @override
  String deleteFailed(Object error) {
    return 'Échec de la suppression : $error';
  }

  @override
  String get deleteLabel => 'Supprimer l\'étiquette';

  @override
  String deleteLabelFailed(Object error) {
    return 'Échec de la suppression de l\'étiquette : $error';
  }

  @override
  String get deletePlugin => 'Supprimer le plugin';

  @override
  String deletePluginFailed(Object error) {
    return 'Échec de la suppression du plugin : $error';
  }

  @override
  String get deletePlugins => 'Supprimer les plugins';

  @override
  String deletePluginsFailed(Object error) {
    return 'Échec de la suppression des plugins : $error';
  }

  @override
  String get deleteRule => 'Supprimer la règle';

  @override
  String deleteRuleFailed(Object error) {
    return 'Échec de la suppression : $error';
  }

  @override
  String get deleteSelected => 'Supprimer la sélection';

  @override
  String get deleteSubscription => 'Supprimer l\'abonnement';

  @override
  String deleteSubscriptionConfirm(Object name) {
    return 'Êtes-vous sûr de vouloir supprimer l\'abonnement « $name » ?';
  }

  @override
  String deleteSubscriptionFailed(Object error) {
    return 'Échec de la suppression de l\'abonnement : $error';
  }

  @override
  String get deleteSuccess => 'Suppression réussie';

  @override
  String get delivery => 'Livraison';

  @override
  String get deviceIDLabel => 'ID de l\'appareil';

  @override
  String get deviceManagementSubtitle =>
      'Gérer la synchronisation multi-appareils';

  @override
  String get deviceManagementTitle => 'Gestion des appareils';

  @override
  String get deviceModelLabel => 'Modèle d\'appareil';

  @override
  String get deviceName => 'Nom de l\'appareil';

  @override
  String get deviceNameLabel => 'Nom de l\'appareil';

  @override
  String get deviceRenamedSuccessfullyMessage => 'Appareil renommé avec succès';

  @override
  String get devicesSynchronizedSuccessfullyMessage =>
      'Appareils synchronisés avec succès';

  @override
  String get deviceUnregisteredSuccessfullyMessage =>
      'Appareil désenregistré avec succès';

  @override
  String get dialogTitle => 'Explication du modèle Regex';

  @override
  String get differentFromLocalCounter =>
      'Cette fonctionnalité est différente du filtre de compteur local, car elle se concentre sur les modèles d\'appels répétés dans un court laps de temps plutôt que sur les nombres de marquage à long terme.';

  @override
  String get disabled => 'Désactivé';

  @override
  String get disabledStatus => 'Désactivé';

  @override
  String get disableGlobalPlugins => 'Désactiver les plugins globaux';

  @override
  String get disconnectButton => 'Déconnexion';

  @override
  String get disconnectedMessage => 'Déconnecté';

  @override
  String get disconnectedStatus => 'Déconnecté';

  @override
  String get disconnectFailedMessage => 'Échec de la déconnexion';

  @override
  String get done => 'Terminé';

  @override
  String get dualSimAdvice =>
      'Cette fonctionnalité est particulièrement utile pour les téléphones à double SIM afin de définir différentes stratégies de filtrage pour les cartes SIM professionnelles et personnelles.';

  @override
  String get earlier => 'Plus tôt';

  @override
  String get ecommerce => 'Commerce électronique';

  @override
  String get edit => 'Modifier';

  @override
  String get editContact => 'Modifier le contact';

  @override
  String get editLabel => 'Modifier l\'étiquette';

  @override
  String get editPhoneRule => 'Modifier la règle de téléphone';

  @override
  String get editRule => 'Modifier la règle';

  @override
  String get education => 'Éducation';

  @override
  String get elementPositionsSetting => 'Positions des éléments';

  @override
  String get email => 'Email';

  @override
  String get enableCallFilter => 'Activer le filtre d\'appel';

  @override
  String get enableCallFilterDescription =>
      'Lorsqu\'il est activé, les appels entrants sont vérifiés par rapport à la liste de règles ci-dessous. Les règles de filtrage des appels ne sont pas synchronisées entre les appareils par défaut.';

  @override
  String get enabled => 'Activé';

  @override
  String get enabledStatus => 'Activé';

  @override
  String get enableEncryption => 'Activer le cryptage';

  @override
  String get enableEncryptionDescription =>
      'Crypter les fichiers de sauvegarde';

  @override
  String get enableGlobalPlugins => 'Activer les plugins globaux';

  @override
  String get enableLocalCountFilter =>
      'Activer la protection par seuil de signalements locaux';

  @override
  String get enableLocalCountFilterDescription =>
      'Bloquer les appels entrants lorsque le nombre de signalements locaux dépasse le seuil';

  @override
  String get enableLocalNotification => 'Utiliser la notification locale';

  @override
  String get enableLocalNotificationDescription =>
      'Lorsqu\'elle est activée, les notifications pour les messages filtrés seront affichées sur l\'appareil';

  @override
  String get enableLocationSummary => 'Position';

  @override
  String get enableMuteRules => 'Rendre muets les appels interceptés';

  @override
  String get enableMuteRulesDesc =>
      'Rendre la sonnerie muette pour les appels interceptés au lieu de les rejeter';

  @override
  String get enableNoneActionRules =>
      'Enregistrer et marquer uniquement (Sans interruption)';

  @override
  String get enableNoneActionRulesDesc =>
      'Enregistrer et marquer les appels correspondants sans prendre d\'action d\'interception';

  @override
  String get enableRemoteNumberFilter =>
      'Activer la protection par seuil de requêtes cloud';

  @override
  String get enableRemoteNumberFilterDescription =>
      'Bloquer les appels entrants lorsque le nombre de signalements cloud dépasse le seuil';

  @override
  String get enableRule => 'Activer la règle';

  @override
  String get enableSmsFilter => 'Activer le filtrage SMS';

  @override
  String get enableSmsFilterDescription =>
      'Lorsqu\'il est activé, les messages seront automatiquement filtrés selon les règles';

  @override
  String get enableTimeInterception => 'Activer l\'interception temporelle';

  @override
  String get enableTimeInterceptionDescription =>
      'Bloquer les appels répétés d\'un même numéro dans un court intervalle';

  @override
  String get enableTimeInterceptor => 'Activer l\'intercepteur temporel';

  @override
  String get endCallImmediately => 'Raccrocher immédiatement';

  @override
  String get endColor => 'Couleur de fin';

  @override
  String get endDate => 'Date de fin';

  @override
  String get enhancedFilterInstructionsTitle => 'Système de filtrage amélioré';

  @override
  String get enhancedFilterSettings => 'Paramètres de filtrage améliorés';

  @override
  String get enhancedFilterSettingsTitle => 'Paramètres de filtrage améliorés';

  @override
  String get enhancedFilterSystemDescription =>
      'Le système de filtrage amélioré prend en charge à la fois les règles globales et les configurations de filtrage par carte SIM.';

  @override
  String get enterBothPhoneNumberAndRegexPatternMessage =>
      'Veuillez entrer à la fois le numéro de téléphone et le modèle regex.';

  @override
  String get enterContactName => 'Veuillez entrer le nom du contact';

  @override
  String get enterDeviceName => 'Entrez le nom de l\'appareil';

  @override
  String get enterEmailOptional =>
      'Veuillez entrer votre adresse e-mail (facultatif)';

  @override
  String get enterEncryptionPasswordHint =>
      'Entrez le mot de passe de chiffrement';

  @override
  String get enterIconCode => 'Entrez le code de l\'icône';

  @override
  String get enterName => 'Entrez le nom du contact';

  @override
  String get enterNewDeviceNameHint =>
      'Entrez un nouveau nom pour cet appareil';

  @override
  String get enterPasswordAgain => 'Entrez le mot de passe à nouveau';

  @override
  String get enterPhoneNumber => 'Entrez le numéro de téléphone';

  @override
  String get enterPhoneNumberHint => 'Entrez le numéro de téléphone à tester';

  @override
  String get enterPhoneNumberMultiple =>
      'Veuillez entrer le numéro de téléphone, plusieurs numéros séparés par des virgules';

  @override
  String get enterPhoneNumberToStartSearch =>
      'Entrez le numéro de téléphone pour lancer la recherche';

  @override
  String get enterPhoneNumberToVerify =>
      'Entrez le numéro de téléphone à vérifier';

  @override
  String get enterPluginName => 'Entrez le nom du plugin';

  @override
  String get enterPluginUrl => 'Entrez l\'adresse URL du plugin';

  @override
  String get enterRegexHint => 'Entrez le modèle regex';

  @override
  String get enterRuleNameAndPatternMessage =>
      'Veuillez entrer à la fois le nom de la règle et le modèle regex.';

  @override
  String get enterRuleNameHint => 'Entrez le nom de la règle';

  @override
  String get enterSearchContent => 'Veuillez entrer le contenu de la recherche';

  @override
  String get enterSubscriptionName => 'Entrez le nom de l\'abonnement';

  @override
  String get enterSubscriptionUrl => 'Entrez l\'URL de l\'abonnement';

  @override
  String get enterSyncFolderNameHint =>
      'Veuillez entrer le nom du dossier de synchronisation (par défaut : NotificationManager)';

  @override
  String get entertainment => 'Divertissement';

  @override
  String get enterValidNameAndUrl =>
      'Veuillez entrer un nom et une URL valides';

  @override
  String get enterValidUrl => 'Veuillez entrer une URL valide';

  @override
  String get enterVersion => 'Entrer la version';

  @override
  String get enterWebDAVPasswordHint =>
      'Veuillez entrer le mot de passe WebDAV';

  @override
  String get enterWebDAVServerAddressHint =>
      'Veuillez entrer l\'adresse du serveur WebDAV';

  @override
  String get enterWebDAVUsernameHint =>
      'Veuillez entrer le nom d\'utilisateur WebDAV';

  @override
  String errorOccurredMessage(Object error) {
    return 'Une erreur s\'est produite : $error';
  }

  @override
  String errorRenamingDeviceMessage(Object error) {
    return 'Erreur lors du renommage de l\'appareil : $error';
  }

  @override
  String errorSynchronizingDevicesMessage(Object error) {
    return 'Erreur lors de la synchronisation des appareils : $error';
  }

  @override
  String errorUnregisteringDeviceMessage(Object error) {
    return 'Erreur lors de la désinscription de l\'appareil : $error';
  }

  @override
  String get exampleBlock400Prefix => 'par exemple, Préfixe de bloc 400';

  @override
  String get exampleBlockMarketingSms =>
      'par exemple, Bloquer les SMS marketing';

  @override
  String get exampleContentRegexHint => 'Exemple de Regex de contenu';

  @override
  String get exampleCouponPromotionDiscount =>
      'par exemple, .*(coupon|promotion|discount).*';

  @override
  String get exampleFamilyFriends => 'par exemple, Famille, Amis, etc.';

  @override
  String get examplePhoneNumber => 'par exemple, 10086, 12345, etc.';

  @override
  String get exampleRegex400Prefix => 'Exemple de regex pour le préfixe 400';

  @override
  String get exampleSenderRegexHint => 'Exemple';

  @override
  String get exchange => 'Échange';

  @override
  String get exchangeNow => 'Échanger maintenant';

  @override
  String get exchangeVip => 'Échanger VIP';

  @override
  String expiryTime(Object time) {
    return 'Heure d\'expiration : $time';
  }

  @override
  String get export => 'Exporter';

  @override
  String get exportAllApplicationSettings =>
      'Exporter tous les paramètres de l\'application';

  @override
  String get exportAllRuleConfigurations =>
      'Exporter toutes les configurations de règles';

  @override
  String get exportConfig => 'Exporter la configuration';

  @override
  String get exportContacts => 'Exporter les contacts';

  @override
  String get exportData => 'Exporter des données';

  @override
  String get exportFailed => 'L\'exportation a échoué';

  @override
  String get exportFailure => 'Échec de l\'exportation de la configuration';

  @override
  String get exportFeatureComingSoon =>
      'Fonctionnalité d\'exportation bientôt disponible';

  @override
  String get exportLabels => 'Exporter les étiquettes';

  @override
  String exportLabelsFailed(Object error) {
    return 'Échec de l\'exportation des étiquettes: $error';
  }

  @override
  String get exportPluginList => 'Exporter la liste des plugins';

  @override
  String exportPluginListFailed(Object error) {
    return 'Échec de l\'exportation de la liste des plugins: $error';
  }

  @override
  String get exportRules => 'Exporter les règles';

  @override
  String get exportSmsRules => 'Exporter les règles SMS';

  @override
  String get exportStatisticsData => 'Exporter les données statistiques';

  @override
  String get exportSuccesslly => 'Configuration exportée avec succès';

  @override
  String failedToAddRule(Object error) {
    return 'Échec de l\'ajout de la règle: $error';
  }

  @override
  String failedToAddSmsSubscription(Object error) {
    return 'Échec de l\'ajout de l\'abonnement SMS: $error';
  }

  @override
  String failedToBackupSettings(Object error) {
    return 'Échec de la sauvegarde des paramètres: $error';
  }

  @override
  String get failedToDecryptBackupFile =>
      'Échec du déchiffrement du fichier de sauvegarde';

  @override
  String failedToDeleteSmsRule(Object error) {
    return 'Échec de la suppression de la règle SMS: $error';
  }

  @override
  String failedToExportRules(Object error) {
    return 'Échec de l\'exportation des règles: $error';
  }

  @override
  String failedToGetCallerIdInfo(Object error) {
    return 'Échec de la récupération des informations de l\'identification de l\'appelant: $error';
  }

  @override
  String failedToImportRules(Object error) {
    return 'Échec de l\'importation des règles: $error';
  }

  @override
  String get failedToRestoreSettings =>
      'Échec de la restauration des paramètres';

  @override
  String failedToRestoreSettingsWithError(Object error) {
    return 'Échec de la restauration des paramètres: $error';
  }

  @override
  String failedToToggleRuleStatus(Object error) {
    return 'Échec de l\'activation/désactivation de l\'état de la règle: $error';
  }

  @override
  String get favoriteContacts => 'Contacts favoris';

  @override
  String get featureAddRules =>
      '• Ajouter des règles spécifiques au numéro de téléphone';

  @override
  String get featureCenter => 'Centre de fonctionnalités';

  @override
  String get featureEnableDisable =>
      '• Activer/désactiver différents filtres par carte SIM';

  @override
  String get featureListTitle => 'Fonctionnalités :';

  @override
  String get featureManageRules => '• Gérer les listes de règles par carte SIM';

  @override
  String get features => 'Fonctionnalités';

  @override
  String get fetchingCallerIdInfo =>
      'Récupération des informations de l\'identification de l\'appelant...';

  @override
  String fileSavedTo(Object path) {
    return 'Fichier enregistré dans : $path';
  }

  @override
  String get filter => 'Filtrer';

  @override
  String get filterByLabel => 'Filtrer par étiquette';

  @override
  String get filterControlPanelTitle => 'Panneau de configuration des filtres';

  @override
  String get filterControlSubtitle =>
      'Gérer l\'état activé/désactivé de tous les filtres';

  @override
  String get filterControlTitle => 'Contrôle des filtres';

  @override
  String get filtered => 'Filtré';

  @override
  String get filterExplanation => 'Explication du filtre';

  @override
  String get filterManagement => 'Gestion des filtres';

  @override
  String get filterName => 'Nom du filtre';

  @override
  String get filterPriorityNote =>
      'Remarque : Il existe des relations de priorité entre les filtres, veuillez consulter la documentation d\'aide pour plus de détails';

  @override
  String get filterSettings => 'Paramètres de filtre';

  @override
  String get filterSettingsTitle => 'Paramètres de filtre';

  @override
  String get filterSMS => 'Filtrer les SMS';

  @override
  String get filterToggleInstructions =>
      'Activer ou désactiver les filtres pour cet emplacement SIM :';

  @override
  String filterToggleStatus(Object status, Object filterName) {
    return 'Filtre $status : $filterName';
  }

  @override
  String get filterType => 'Type de filtre';

  @override
  String get financial => 'Financier';

  @override
  String get flexibleCombinationFeature =>
      '• Combinaisons flexibles : activer/désactiver les filtres par emplacement SIM';

  @override
  String get fontSizesSetting => 'Tailles de police';

  @override
  String foundRules(Object count) {
    return '$count règles trouvées';
  }

  @override
  String get fraudAlert => 'ALERTE À LA FRAUDE - Raccrochez';

  @override
  String get fraudScamLikely => 'Fraude/Arnaque probable';

  @override
  String get free => 'Gratuit';

  @override
  String get functionSettingsTitle => 'Paramètres de fonction';

  @override
  String generalUpdateFailure(Object error) {
    return 'Échec de la mise à jour : $error';
  }

  @override
  String get getFree => 'Obtenir gratuitement';

  @override
  String get github => 'GitHub';

  @override
  String get globalFilterDescription =>
      'Configurer les filtres globaux pour toutes les cartes SIM :';

  @override
  String get globalFilterFeature =>
      '• Filtres globaux : règles de base pour tous les appels entrants';

  @override
  String get globalFilterSettings => 'Paramètres de filtre global';

  @override
  String get globalSettings => 'Paramètres globaux';

  @override
  String get googleDriveAuthDescription =>
      'Autoriser à l\'aide de l\'ID et de la clé client Google Drive configurés par le système';

  @override
  String get googleDriveConfigTitle => 'Configuration de Google Drive';

  @override
  String get government => 'Gouvernement';

  @override
  String get granted => 'Accordé';

  @override
  String get grantNecessaryPermissions =>
      'Accorder les autorisations nécessaires';

  @override
  String get grantPermissions => 'Accorder des autorisations';

  @override
  String get headhunter => 'Chasseur de têtes';

  @override
  String get height => 'Taille';

  @override
  String get homeTab => 'Accueil';

  @override
  String get howItWorksPoint1 =>
      '• Le système autorisera automatiquement les appels provenant du même numéro pendant la période définie.';

  @override
  String get howItWorksPoint2 =>
      '• Des périodes plus courtes entraînent une interception plus stricte ; des périodes plus longues entraînent une interception plus souple.';

  @override
  String get howItWorksPoint3 =>
      '• Le système vérifie les journaux d\'appels pour déterminer s\'il s\'agit d\'un appel répété.';

  @override
  String get howItWorksTitle => 'Comment ça marche :';

  @override
  String get iconCodeOptional => 'Code d\'icône (facultatif)';

  @override
  String get iconSize => 'Taille de l\'icône';

  @override
  String get import => 'Importer';

  @override
  String get important => 'Important';

  @override
  String get importConfig => 'Importer la configuration';

  @override
  String get importContacts => 'Importer des contacts';

  @override
  String get importExportContacts => 'Importer/Exporter des contacts';

  @override
  String get importExportContactsTooltip => 'Importer/Exporter des contacts';

  @override
  String get importExportRules => 'Importer/Exporter des règles';

  @override
  String importFailed(Object error) {
    return 'Échec de l\'importation : $error';
  }

  @override
  String get importFailure => 'Échec de l\'importation de la configuration';

  @override
  String get importFeatureComingSoon =>
      'Fonction d\'importation bientôt disponible';

  @override
  String get importLabels => 'Importer des étiquettes';

  @override
  String importLabelsFailed(Object error) {
    return 'Échec de l\'importation des étiquettes : $error';
  }

  @override
  String get importPluginList => 'Importer la liste des plugins';

  @override
  String importPluginListFailed(Object error) {
    return 'Échec de l\'importation de la liste des plugins : $error';
  }

  @override
  String importPluginSuccess(Object count) {
    return '$count plugins importés avec succès';
  }

  @override
  String get importRuleConfigurationsFromFile =>
      'Importer les configurations de règles à partir d\'un fichier';

  @override
  String get importRules => 'Importer des règles';

  @override
  String get importSuccess => 'Importation réussie';

  @override
  String get incomingCallInterceptAction =>
      'Action d\'interception d\'appel entrant';

  @override
  String get incorrectPassword => 'Mot de passe incorrect';

  @override
  String get initializing => 'Initialisation';

  @override
  String get installed => 'Installé';

  @override
  String get insufficientMarks => 'Notes insuffisantes';

  @override
  String get insurance => 'Assurance';

  @override
  String get interceptAction => 'Action d\'interception';

  @override
  String get interceptionActionSettingsSubtitle =>
      'Définir la manière dont les appels bloqués sont gérés';

  @override
  String get interceptionActionSettingsTitle =>
      'Paramètres de l\'action d\'interception';

  @override
  String get interceptionTimeInterval => 'Intervalle de temps d\'interception';

  @override
  String get internet => 'Internet';

  @override
  String intervalSetSuccess(Object service, Object days) {
    return 'Intervalle de mise à jour de $service défini sur $days jours';
  }

  @override
  String get invalidContentRegex => 'Regex de contenu non valide';

  @override
  String get invalidLabel => 'Étiquette non valide';

  @override
  String get invalidRegexPattern => 'Motif regex non valide';

  @override
  String get invalidSenderRegex => 'Regex d\'expéditeur non valide';

  @override
  String get joinTheTelegramChannelAndGroupForMoreInfo =>
      'Rejoignez le canal et le groupe Telegram pour plus d\'informations';

  @override
  String get jsonFormat => 'Format JSON';

  @override
  String get keepAllVersions => 'Conserver toutes les versions';

  @override
  String get keepAllVersionsDescription =>
      'Conserver toutes les versions historiques de chaque sauvegarde';

  @override
  String get label => 'Étiquette';

  @override
  String labelAddedSuccessfully(Object name) {
    return 'Étiquette \"$name\" ajoutée avec succès';
  }

  @override
  String get labelCategories => 'Catégories d\'étiquettes';

  @override
  String get labelDeleted => 'Étiquette supprimée';

  @override
  String get labelDescription =>
      'Les étiquettes vous aident à mieux gérer les contacts, ajoutez des étiquettes personnalisées aux numéros de téléphone pour identifier facilement les appels et les messages.';

  @override
  String get labelFilterTooltip => 'Filtre d\'étiquette';

  @override
  String get labelIconColor => 'Couleur de l\'icône de l\'étiquette';

  @override
  String get labelManagement => 'Gestion des étiquettes';

  @override
  String get labelNotFound => 'Étiquette introuvable';

  @override
  String get labels => 'Étiquettes';

  @override
  String get labelsColor => 'Couleur des étiquettes';

  @override
  String labelsDeleted(Object count) {
    return '$count étiquettes supprimées';
  }

  @override
  String get labelsExportedSuccessfully => 'Étiquettes exportées avec succès';

  @override
  String get labelsFontSize => 'Taille de la police des étiquettes';

  @override
  String labelsImportedSuccessfully(Object count) {
    return '$count étiquettes importées avec succès';
  }

  @override
  String get labelsPosition => 'Position des étiquettes';

  @override
  String labelTag(Object labelId) {
    return 'Étiquette : $labelId';
  }

  @override
  String labelUpdateFailed(Object error) {
    return 'Échec de la mise à jour de l\'étiquette : $error';
  }

  @override
  String get labelUpdateSuccess =>
      'Étiquette \"\$labelText\" mise à jour avec succès';

  @override
  String get languageSettings => 'Paramètres de langue';

  @override
  String get languageSettingsSubtitle =>
      'Modifier la langue d\'affichage de l\'application';

  @override
  String get languageSettingsTitle => 'Paramètres de langue';

  @override
  String get lastSyncLabel => 'Dernière synchronisation';

  @override
  String lastUpdated(Object date) {
    return 'Dernière mise à jour : $date';
  }

  @override
  String get lifetimeMembership => 'Abonnement à vie';

  @override
  String get lifetimeMembershipDescription =>
      'Achat unique, débloquez définitivement toutes les fonctionnalités premium et les futures mises à jour';

  @override
  String loadContactsFailed(Object error) {
    return 'Échec du chargement des contacts : $error';
  }

  @override
  String get loadDataFailed => 'Échec du chargement des données';

  @override
  String get loading => 'Chargement...';

  @override
  String get loadingTags => 'Chargement des balises...';

  @override
  String loadLabelFailed(Object error) {
    return 'Échec du chargement des étiquettes : $error';
  }

  @override
  String loadLabelsFailed(Object error) {
    return 'Échec du chargement des étiquettes : $error';
  }

  @override
  String loadMarkCountFailed(Object error) {
    return 'Échec du chargement du nombre de numéros de téléphone signalés : $error';
  }

  @override
  String loadMarkedPhonesFailed(Object error) {
    return 'Échec du chargement des téléphones signalés : $error';
  }

  @override
  String loadPluginsFailed(Object error) {
    return 'Échec du chargement des plugins : $error';
  }

  @override
  String loadSettingsFailed(Object error) {
    return 'Échec du chargement des paramètres : $error';
  }

  @override
  String loadSmsRulesFailed(Object error) {
    return 'Échec du chargement des règles SMS : $error';
  }

  @override
  String get loadStatusFailedMessage => 'Échec du chargement de l\'état';

  @override
  String loadSubscriptionsFailed(Object error) {
    return 'Échec du chargement des abonnements : $error';
  }

  @override
  String get loan => 'Prêt';

  @override
  String get localCounterFilter => 'Filtre de compteur local';

  @override
  String get localCounterFilterSubtitle =>
      'Filtrer automatiquement les appels indésirables en fonction de la fréquence des appels';

  @override
  String get localCountFilter => 'Protection par seuil de signalements locaux';

  @override
  String get localCountFilterDescription =>
      'Bloquer automatiquement les appels dépassant le seuil de signalement local';

  @override
  String get localCountFilterExplanationContent =>
      'Le filtre de comptage local analyse l\'historique des appels pour identifier et bloquer automatiquement les appels indésirables fréquents.';

  @override
  String get localCountFilterExplanationTitle =>
      'Explication du filtre de comptage local';

  @override
  String get localCountFilterHowItWorksPoint1 =>
      '• Déterminer s\'il faut bloquer en fonction de la valeur de comptage du numéro';

  @override
  String get localCountFilterHowItWorksPoint2 =>
      '• Lorsqu\'un comptage de numéro dépasse le seuil défini, vous pouvez choisir de le bloquer automatiquement';

  @override
  String get localCountFilterHowItWorksPoint3 =>
      '• Vous pouvez autoriser sélectivement les numéros qui ne dépassent pas le seuil';

  @override
  String get localCountFilterHowItWorksPoint4 =>
      '• Vous pouvez choisir d\'enregistrer tous les journaux de requêtes';

  @override
  String get localCountFiltering => 'Filtrage du comptage local';

  @override
  String get localCountFilteringExplanation =>
      '• Filtrage du comptage local : règles de filtrage basées sur le nombre de signalements locaux';

  @override
  String get localCountFilterSettings =>
      'Paramètres du filtre de comptage local';

  @override
  String get localCountFilterUseCases =>
      'Ce filtre est particulièrement adapté à l\'identification des appels indésirables automatisés et des appels marketing.';

  @override
  String get localFilterSettings => 'Paramètres du filtre local';

  @override
  String get localNotificationDisabled => 'Notification locale désactivée';

  @override
  String get localNotificationEnabled => 'Notification locale activée';

  @override
  String get localServices => 'Services locaux';

  @override
  String get locationColor => 'Couleur du lieu';

  @override
  String get locationFontSize => 'Taille de la police du lieu';

  @override
  String get locationIconColor => 'Couleur de l\'icône du lieu';

  @override
  String get locationPosition => 'Position du lieu';

  @override
  String get logAllLocalQueries => 'Enregistrer toutes les requêtes locales';

  @override
  String get logAllLocalQueriesDescription =>
      'Enregistrer les journaux pour toutes les requêtes de numéros locaux';

  @override
  String get logAllRemoteQueries =>
      'Enregistrer toutes les requêtes à distance';

  @override
  String get logAllRemoteQueriesDescription =>
      'Enregistrer toutes les opérations de requête de numéros à distance';

  @override
  String get manage => 'Gérer les contacts';

  @override
  String get manageFavoriteContacts => 'Gérer les contacts favoris';

  @override
  String get manageFilterRules => 'Gérer les règles de filtre';

  @override
  String get manageFilterRulesDescription =>
      'Ajouter, modifier ou supprimer des règles de filtre SMS';

  @override
  String get markCounts => 'Nombre de signalements';

  @override
  String get markCount => 'Nombre de signalements';

  @override
  String markedByCount(Object count) {
    return 'Signalé par $count';
  }

  @override
  String get markedPhonesList => 'Numéros de téléphone signalés';

  @override
  String get markExchange => 'Échange de signalement';

  @override
  String get markPhone => 'Signaler un numéro de téléphone';

  @override
  String markPhoneFailed(Object error) {
    return 'Échec du marquage du numéro de téléphone : $error';
  }

  @override
  String get markPhoneManagementTitle => 'Gestion des numéros marqués';

  @override
  String get markPhoneSuccess => 'Numéro de téléphone marqué avec succès';

  @override
  String get matchFailedMessage => 'Échec de la correspondance.';

  @override
  String get matchNumbersWithSpecialCharacters =>
      'correspond à un format de numéro spécifique';

  @override
  String get matchNumbersWithSpecialCharactersTitle =>
      'Correspondance des nombres avec des caractères spéciaux :';

  @override
  String get matchSpecificDigitPatterns => 'correspond au format XXX-XXXX-XXXX';

  @override
  String get matchSpecificDigitPatternsTitle =>
      'Correspondance des modèles de chiffres spécifiques :';

  @override
  String get matchSuccessfulMessage => 'Correspondance réussie !';

  @override
  String get medical => 'Médical';

  @override
  String get membershipPrivileges => 'Privilèges d\'adhésion';

  @override
  String get migrationTool => 'Outil de migration';

  @override
  String get minutes => 'minutes';

  @override
  String get month => 'Mois';

  @override
  String get monthly => 'Mensuel';

  @override
  String get monthlyCallCount => 'Appels mensuels';

  @override
  String get monthlyMembership => 'Adhésion mensuelle';

  @override
  String get monthlyMembershipDescription =>
      'Débloquez toutes les fonctionnalités premium, renouvellement automatique mensuel';

  @override
  String get monthlyTotal => 'Total mensuel';

  @override
  String get moreOptions => 'Plus d\'options';

  @override
  String get mute => 'Muet';

  @override
  String get name => 'Nom';

  @override
  String get nameAndPhoneNumberCannotBeEmpty =>
      'Le nom et le numéro de téléphone ne peuvent pas être vides';

  @override
  String get nameColor => 'Couleur du nom';

  @override
  String get nameFontSize => 'Taille de la police du nom';

  @override
  String get namePosition => 'Position du nom';

  @override
  String get nameUnknown => 'Nom : Inconnu';

  @override
  String get nextStep => 'Suivant';

  @override
  String get noAction => 'Aucune action';

  @override
  String get noActionRules => 'Aucune règle d\'action';

  @override
  String get noActiveCloudSyncServiceMessage =>
      'Aucun service de synchronisation cloud actif';

  @override
  String get noCallRecords => 'Aucun enregistrement d\'appel';

  @override
  String get noContactsYet => 'Pas encore de contacts';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get noDevicesRegisteredMessage => 'Aucun appareil enregistré';

  @override
  String get noLabels => 'Pas encore d\'étiquettes';

  @override
  String get noMarkedPhones => 'Aucun numéro de téléphone marqué';

  @override
  String get noMatchingContactsFound => 'Aucun contact correspondant trouvé';

  @override
  String get noMatchingNumbersFound => 'Aucun numéro correspondant trouvé';

  @override
  String noMatchingRules(Object ruleType) {
    return 'Aucune $ruleType correspondante';
  }

  @override
  String get none => 'Aucun';

  @override
  String get noneServiceType => 'Aucun';

  @override
  String get noPlugins => 'Aucun plugin pour le moment';

  @override
  String noRules(Object ruleType) {
    return 'Aucune $ruleType pour le moment';
  }

  @override
  String get noRulesPrompt =>
      'Aucune règle trouvée, veuillez ajouter des règles';

  @override
  String get noRulesToExport => 'Aucune règle à exporter';

  @override
  String get noSmsFilterRulesYet =>
      'Aucune règle de filtrage SMS pour le moment';

  @override
  String get noSmsRulesYet => 'Aucune règle SMS pour le moment';

  @override
  String get noSubscriptions => 'Aucun abonnement';

  @override
  String get notGranted => 'Non accordé';

  @override
  String get notificationModeDescription =>
      'Afficher les informations de l\'appelant dans la barre de notification';

  @override
  String get notificationPermission => 'Autorisation de notification';

  @override
  String get notificationPermissionDescription =>
      'Utilisé pour afficher les notifications d\'appels et de messages entrants.';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationSettings => 'Paramètres de notification';

  @override
  String get notVerifiedText => 'Non vérifié';

  @override
  String get noValidSmsRulesFoundInFile =>
      'Aucune règle SMS valide trouvée dans le fichier';

  @override
  String get number => 'Numéro';

  @override
  String get numberColor => 'Couleur du numéro';

  @override
  String get numberFontSize => 'Taille de police du numéro';

  @override
  String get numberPosition => 'Position du numéro';

  @override
  String get numberSearch => 'Recherche de numéro';

  @override
  String get numberTypeColor => 'Couleur du type de numéro';

  @override
  String get numberTypeFontSize => 'Taille de police du type de numéro';

  @override
  String get numberTypePosition => 'Position du type de numéro';

  @override
  String get okButton => 'OK';

  @override
  String get onboardingCompleteDescription =>
      'Votre gestionnaire de sécurité des appels est prêt, commencez à profiter d\'une expérience d\'appel sécurisée !';

  @override
  String get onboardingLanguageDescription =>
      'Choisissez votre langue préférée pour une expérience optimale.';

  @override
  String get onboardingPermissionsDescription =>
      'Pour fournir un service complet, nous avons besoin des autorisations suivantes :';

  @override
  String get onboardingPowerfulSpamBlockingDescription =>
      'Blocage en un clic des appels et messages indésirables, personnalisation des règles de blocage et vous offrant un environnement paisible.';

  @override
  String get onboardingSmartCallerIdDescription =>
      'Identifiez automatiquement les appels inconnus, marquez les numéros suspects et protégez la sécurité de vos appels.';

  @override
  String get onboardingWelcomeDescription =>
      'Votre expert en gestion des appels, fournissant des services complets d\'identification et de blocage des appels.';

  @override
  String get oneDriveAuthDescription =>
      'Autoriser en utilisant l\'ID client et la clé OneDrive configurés par le système';

  @override
  String get oneDriveConfigTitle => 'Configuration OneDrive';

  @override
  String get onlineCallerIdSubscription =>
      'Abonnement à l\'identification de l\'appelant en ligne';

  @override
  String get openAppSettings => 'Ouvrir les paramètres de l\'application';

  @override
  String openAppSettingsFailed(Object error) {
    return 'Impossible d\'ouvrir les paramètres de l\'application : $error';
  }

  @override
  String operationFailed(Object error) {
    return 'Échec de l\'opération : $error';
  }

  @override
  String get operationFailure => 'Échec de l\'opération';

  @override
  String get operationSuccess => 'Opération réussie';

  @override
  String get other => 'Autre';

  @override
  String get ourOtherApps => 'Nos autres applications';

  @override
  String get overlayMode => 'Fenêtre flottante';

  @override
  String get overlayModeDescription =>
      'Afficher les informations de l\'appelant dans une fenêtre flottante';

  @override
  String get overlayPermission => 'Autorisation de superposition';

  @override
  String get overlayPermissionDescription =>
      'Utilisé pour afficher la superposition des appels entrants.';

  @override
  String get overview => 'Aperçu';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordCannotBeEmpty => 'Le mot de passe ne peut pas être vide';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get pattern => 'Modèle';

  @override
  String get pendingSync => 'Synchronisation en attente';

  @override
  String get periodMonth => 'Mois';

  @override
  String get periodWeek => 'Semaine';

  @override
  String get periodYear => 'Année';

  @override
  String get permissionDenied => 'Demande d\'autorisation refusée';

  @override
  String get permissionGranted => 'Autorisation accordée';

  @override
  String get permissionManagement => 'Gestion des autorisations';

  @override
  String get phoneCallsTab => 'Téléphone';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get phoneNumberCannotBeEmpty =>
      'Le numéro de téléphone ne peut pas être vide';

  @override
  String get phoneNumberLabel => 'Numéro de téléphone';

  @override
  String get phoneNumberTypeFixedLine => 'Ligne fixe';

  @override
  String get phoneNumberTypeFixedLineOrMobile => 'Ligne fixe ou mobile';

  @override
  String get phoneNumberTypeMobile => 'Mobile';

  @override
  String get phoneNumberTypePager => 'Pager';

  @override
  String get phoneNumberTypePersonalNumber => 'Numéro personnel';

  @override
  String get phoneNumberTypePremiumRate => 'Tarif majoré';

  @override
  String get phoneNumberTypeSharedCost => 'Frais partagés';

  @override
  String get phoneNumberTypeTollFree => 'Numéro vert';

  @override
  String get phoneNumberTypeUan => 'UAN';

  @override
  String get phoneNumberTypeUnknown => 'Inconnu';

  @override
  String get phoneNumberTypeVoicemail => 'Messagerie vocale';

  @override
  String get phoneNumberTypeVoip => 'VoIP';

  @override
  String get phonePermission => 'Autorisation téléphonique';

  @override
  String get phonePermissionDescription =>
      'Utilisé pour identifier et bloquer les appels entrants.';

  @override
  String get phoneRule => 'Règle téléphonique';

  @override
  String get phoneRuleManagement => 'Gestion des règles téléphoniques';

  @override
  String get phoneRuleSubscription => 'Abonnement aux règles téléphoniques';

  @override
  String get phoneSubscription => 'Abonnement téléphonique';

  @override
  String get phoneSubscriptionRulesDescription =>
      'Abonnez-vous aux listes de règles téléphoniques via une URL pour mettre à jour automatiquement les règles de liste blanche et de liste noire. Prend en charge les fichiers de règles au format JSON.';

  @override
  String get pleaseSelectLabelAndEnterValidPhone =>
      'Veuillez sélectionner une étiquette et saisir un numéro de téléphone valide';

  @override
  String pluginAddedSuccess(Object name) {
    return 'Plugin \"$name\" ajouté avec succès';
  }

  @override
  String get pluginDeleted => 'Plugin supprimé';

  @override
  String get pluginLatestVersion => 'Le plugin est déjà la dernière version';

  @override
  String get pluginListExportSuccess =>
      'Liste des plugins exportée avec succès';

  @override
  String get pluginManagement => 'Gestion des plugins';

  @override
  String get pluginManagementSubtitle =>
      'Gérer et configurer les plugins tiers';

  @override
  String get pluginName => 'Nom du plugin';

  @override
  String pluginsDeleted(Object count) {
    return '$count plugins supprimés avec succès.';
  }

  @override
  String get pluginService => 'Service de plugin';

  @override
  String get pluginTestPageTitle => 'Test du plugin';

  @override
  String get pluginUpdateSuccess => 'Plugin mis à jour avec succès';

  @override
  String get pluginUrl => 'URL du plugin';

  @override
  String get pluginVersion => 'Version du plugin';

  @override
  String get political => 'Politique';

  @override
  String get powerfulSpamBlocking => 'Blocage puissant du spam';

  @override
  String get previousStep => 'Étape précédente';

  @override
  String get prioritizeRemoteAction =>
      'Prioriser les paramètres d\'action à distance';

  @override
  String get prioritizeRemoteActionDescription =>
      'Prioriser les paramètres d\'action de la base de données distante';

  @override
  String get processing => 'Traitement en cours...';

  @override
  String get processingOperation => 'Traitement en cours...';

  @override
  String get purchase => 'Acheter';

  @override
  String get quarterlyMembership => 'Adhésion trimestrielle';

  @override
  String get quarterlyMembershipDescription =>
      'Débloquez toutes les fonctionnalités premium, renouvellement automatique trimestriel';

  @override
  String get ready => 'Prêt !';

  @override
  String get recruiter => 'Recruteur';

  @override
  String get refresh => 'Rafraîchir';

  @override
  String get refreshPermissionStatus => 'Actualiser l\'état de l\'autorisation';

  @override
  String get refreshTooltip => 'Rafraîchir';

  @override
  String regexErrorMessage(Object error) {
    return 'Erreur de regex : $error';
  }

  @override
  String get regexPattern => 'Expression régulière';

  @override
  String get regexPatternExplanation =>
      'Explication de l\'expression régulière';

  @override
  String get regexPatternExplanationButton =>
      'Explication de l\'expression régulière';

  @override
  String get regexPatternLabel => 'Expression régulière';

  @override
  String get regexPatternsForPhoneNumberMatching =>
      'Modèles d\'expressions régulières pour la correspondance des numéros de téléphone';

  @override
  String get regexRule => 'Règle Regex';

  @override
  String regexRuleAddFailed(Object error) {
    return 'Échec de l\'ajout de la règle regex : $error';
  }

  @override
  String get regexRuleAddSuccess => 'Règle regex ajoutée avec succès';

  @override
  String get regexRuleManagement => 'Gestion des règles Regex';

  @override
  String get regexRuleNamePatternRequired =>
      'Le nom de la règle et le modèle regex ne peuvent pas être vides';

  @override
  String get regexRules => 'Règles Regex';

  @override
  String get regexTesterTitle => 'Testeur Regex';

  @override
  String get region => 'Région';

  @override
  String get registeredDevicesTitle => 'Appareils enregistrés';

  @override
  String get rejectAllCalls => 'Rejeter tous les appels';

  @override
  String get rejectAllCallsDescription =>
      'Lorsqu\'il est activé, tous les appels seront rejetés avec la plus haute priorité';

  @override
  String get rejectAllNumbers => 'Rejeter tous les appels entrants';

  @override
  String get rejectAllNumbersDesc =>
      'Rejeter tous les appels entrants avec la plus haute priorité';

  @override
  String get rejectExceededNumbers => 'Rejeter les numéros dépassés';

  @override
  String get rejectExceededNumbersDescription =>
      'Rejeter automatiquement les numéros dépassant le seuil de comptage';

  @override
  String get remoteFilterSettings => 'Paramètres de filtre à distance';

  @override
  String get remoteFilterSettingsPageTitle =>
      'Paramètres de filtrage des numéros à distance';

  @override
  String get remoteNumberFilter => 'Protection par seuil de requêtes cloud';

  @override
  String get remoteNumberFilterDescription =>
      'Bloquer automatiquement les appels dépassant le seuil de signalement cloud';

  @override
  String get remoteNumberFiltering => 'Filtrage des numéros à distance';

  @override
  String get remoteNumberFilteringExplanation =>
      '• Filtrage des numéros à distance : règles de filtrage basées sur les informations de la base de données distante';

  @override
  String get remoteNumberFilterSubtitle =>
      'Identifiez les appels indésirables à l\'aide de la base de données cloud et des rapports de la communauté';

  @override
  String get removeAdsDescription =>
      'Supprimez définitivement toutes les publicités de l\'application pour une expérience plus fluide';

  @override
  String get removeAdsTitle => 'Supprimer les publicités';

  @override
  String get removedFromFavorites => 'Supprimé des favoris';

  @override
  String get removeFromFavorites => 'Supprimer des favoris';

  @override
  String get renameDeviceTitle => 'Renommer l\'appareil';

  @override
  String get requestAllPermissions => 'Demander toutes les autorisations';

  @override
  String get requestPermission => 'Demander l\'autorisation';

  @override
  String requestPermissionFailed(Object error) {
    return 'Échec de la demande d\'autorisation : $error';
  }

  @override
  String requiredMarks(Object count) {
    return '$count Marques';
  }

  @override
  String get reset => 'Réinitialiser';

  @override
  String get restore => 'Restaurer';

  @override
  String get restoreApplicationSettingsFromBackup =>
      'Restaurer les paramètres de l\'application à partir d\'une sauvegarde';

  @override
  String get restoreFromCloud => 'Restaurer depuis le Cloud';

  @override
  String restoreFromCloudFailed(Object error) {
    return 'Échec de la restauration depuis le cloud : $error';
  }

  @override
  String get restoreFromCloudSuccess => 'Restauration réussie depuis le cloud';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get restoreSettings => 'Restaurer les paramètres';

  @override
  String get restoreSettingsConfirmation =>
      'Ceci remplacera tous vos paramètres actuels. Êtes-vous sûr de vouloir continuer ?';

  @override
  String get retry => 'Réessayer';

  @override
  String get ridesharing => 'Covoiturage';

  @override
  String get risk => 'Risque';

  @override
  String get robocall => 'Appel automatique';

  @override
  String get ruleAction => 'Action de la règle';

  @override
  String get ruleAddedSuccess => 'Règle ajoutée avec succès';

  @override
  String get ruleAddSuccess => 'Règle ajoutée avec succès';

  @override
  String ruleDeleteConfirmContent(Object ruleType) {
    return 'Êtes-vous sûr de vouloir supprimer cette $ruleType ?';
  }

  @override
  String get ruleDeleteConfirmTitle => 'Supprimer la règle';

  @override
  String get ruleDeletedSuccessfully => 'Règle supprimée avec succès';

  @override
  String ruleDeleteFailed(Object error) {
    return 'Échec de la suppression de la règle : $error';
  }

  @override
  String get ruleDeleteSuccess => 'Règle supprimée avec succès';

  @override
  String get ruleDisabledSuccessfully => 'Règle désactivée avec succès';

  @override
  String get ruleEnabledSuccessfully => 'Règle activée avec succès';

  @override
  String ruleLoadFailed(Object error) {
    return 'Échec du chargement des règles : $error';
  }

  @override
  String get ruleManagement => 'Gestion des règles';

  @override
  String get ruleName => 'Nom de la règle';

  @override
  String get ruleNameAndContentRegexCannotBeEmpty =>
      'Le nom de la règle et l\'expression régulière du contenu ne peuvent pas être vides';

  @override
  String get ruleNameAndPhoneNumberCannotBeEmpty =>
      'Le nom de la règle et le numéro de téléphone ne peuvent pas être vides';

  @override
  String get ruleNameHint => 'par exemple, Famille, Amis, etc.';

  @override
  String get ruleNameLabel => 'Nom de la règle';

  @override
  String get ruleNameRequired =>
      'Le nom de la règle et le numéro de téléphone ne peuvent pas être vides';

  @override
  String get ruleNotExist => 'La règle n\'existe pas ou a été supprimée';

  @override
  String ruleNotFound(Object error) {
    return 'Règle non trouvée : $error';
  }

  @override
  String get ruleSavedSuccessMessage => 'Règle enregistrée avec succès !';

  @override
  String get rulesExportedSuccessfully => 'Règles exportées avec succès';

  @override
  String rulesExportedTo(Object path) {
    return 'Règles exportées vers : $path';
  }

  @override
  String get rulesImported => 'Règles importées avec succès';

  @override
  String rulesImportedSuccessfully(Object count) {
    return '$count règles importées avec succès';
  }

  @override
  String ruleStatusChanged(Object status) {
    return 'Règle $status avec succès';
  }

  @override
  String ruleToggleFailed(Object error) {
    return 'Échec de l\'opération : $error';
  }

  @override
  String ruleToggleSuccess(Object status) {
    return 'Règle $status avec succès';
  }

  @override
  String ruleUpdateFailed(Object error) {
    return 'Échec de la mise à jour de la règle : $error';
  }

  @override
  String get ruleUpdateSuccess => 'Règle mise à jour avec succès';

  @override
  String get ruleVerification => 'Vérification de la règle';

  @override
  String get save => 'Enregistrer';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get saveButtonText => 'Enregistrer';

  @override
  String saveFailed(Object error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get saveSettings => 'Enregistrer les paramètres';

  @override
  String get scamsLikely => 'Arnaques probables';

  @override
  String get search => 'Rechercher';

  @override
  String get searchContacts => 'Rechercher des contacts';

  @override
  String searchError(Object error) {
    return 'Erreur de recherche : $error';
  }

  @override
  String get searchHint => 'Rechercher...';

  @override
  String get securityMessage =>
      'Ne faites confiance à aucun appel téléphonique. Vérifiez toujours les numéros du service clientèle de manière indépendante. Ne partagez jamais de mots de passe, de codes de vérification, de numéros de carte ou d\'informations personnelles.';

  @override
  String get selectActionWhenBlockingCalls =>
      'Sélectionnez l\'action lors du blocage des appels';

  @override
  String get selectActionWhenRuleMatches =>
      'Sélectionnez l\'action lorsque la règle correspond';

  @override
  String get selectAll => 'Sélectionner tout';

  @override
  String get selectCountry => 'Sélectionner le pays';

  @override
  String selectedItems(Object count) {
    return '$count éléments sélectionnés';
  }

  @override
  String get selectedLabel => 'Sélectionné :';

  @override
  String get selectExportFormat => 'Sélectionner le format d\'exportation';

  @override
  String get selectLabel => 'Sélectionner une étiquette';

  @override
  String get selectLabelAndEnterPhoneNumber =>
      'Veuillez sélectionner une étiquette et saisir un numéro de téléphone valide';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get selectMultiple => 'Sélectionner plusieurs';

  @override
  String get selectSimCard => 'Sélectionner la carte SIM';

  @override
  String get selectTags => 'Sélectionner des étiquettes';

  @override
  String get selectTrustedDataSource =>
      'Veuillez sélectionner des sources de données fiables';

  @override
  String get selectYourLanguage => 'Sélectionnez votre langue';

  @override
  String get sender => 'Expéditeur';

  @override
  String get senderRegexOptional => 'Regex de l\'expéditeur (Facultatif)';

  @override
  String get serverAddressLabel => 'Adresse du serveur';

  @override
  String get serviceTypeContact => 'Abonnement Contact';

  @override
  String get serviceTypeLabel => 'Type de service';

  @override
  String get serviceTypePhone => 'Abonnement Téléphonique';

  @override
  String get serviceTypePlugin => 'Mise à jour du plugin';

  @override
  String get serviceTypeSms => 'Abonnement SMS';

  @override
  String serviceUpdateFailure(Object error) {
    return '$error';
  }

  @override
  String get setEncryptionPassword => 'Définir le mot de passe de chiffrement';

  @override
  String get settings => 'Paramètres';

  @override
  String settingsBackedUpTo(Object path) {
    return 'Paramètres sauvegardés dans : $path';
  }

  @override
  String get settingsRestoredSuccessfully =>
      'Paramètres restaurés avec succès. Veuillez redémarrer l\'application pour que les modifications prennent effet.';

  @override
  String get settingsSaved => 'Paramètres enregistrés';

  @override
  String settingsSaveFailed(Object error) {
    return 'Échec de l\'enregistrement des paramètres : $error';
  }

  @override
  String get settingsTab => 'Paramètres';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get setup => 'Configuration';

  @override
  String get silence => 'Silence';

  @override
  String get silenceAndNoAnswer => 'Rendre le sonnerie muette';

  @override
  String get silenceNoAnswer => 'Silence Pas de réponse';

  @override
  String get silentCallVoiceClone => 'Clonage vocal d\'appel silencieux';

  @override
  String get silentRules => 'Règles silencieuses';

  @override
  String simCard(Object simNumber) {
    return 'Carte SIM $simNumber';
  }

  @override
  String get simCardColor => 'Couleur de la carte SIM';

  @override
  String get simCardConfigurationExplanation =>
      '• Configuration de la carte SIM : Définir des règles de filtrage indépendantes pour chaque carte SIM';

  @override
  String get simCardFilterRules => 'Règles de filtrage de la carte SIM';

  @override
  String get simCardFilterRulesDescription =>
      'Définir différentes règles de filtrage en fonction des emplacements des cartes SIM';

  @override
  String get simCardFontSize => 'Taille de la police de la carte SIM';

  @override
  String get simCardPosition => 'Position de la carte SIM';

  @override
  String simInfo(Object slotNumber, Object countryIso) {
    return 'SIM $slotNumber - $countryIso';
  }

  @override
  String get simRuleInstructions =>
      'Les règles de slot SIM vous permettent de configurer des règles de filtrage indépendantes pour chaque slot SIM.';

  @override
  String get simRuleInstructionsTitle => 'Règles de slot SIM';

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
      'Configurez des règles de filtrage indépendantes pour chaque carte SIM :';

  @override
  String simSlotFilterSettingsTitle(Object slotNumber) {
    return 'Paramètres du filtre de slot SIM $slotNumber';
  }

  @override
  String get simSlotManagement => 'Gestion des slots SIM';

  @override
  String simSlotPosition(int slotNumber) {
    final intl.NumberFormat slotNumberNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String slotNumberString = slotNumberNumberFormat.format(slotNumber);

    return 'Position du slot SIM $slotNumberString';
  }

  @override
  String get simSlotRuleFeature =>
      '• Règles de slot SIM : stratégies de filtrage indépendantes par SIM';

  @override
  String get simSlotRuleListTitle => 'Liste des règles de slot SIM';

  @override
  String get simSlotRuleManagement => 'Règles de slot SIM';

  @override
  String simSlotTitle(Object slotNumber) {
    return 'Slot SIM $slotNumber';
  }

  @override
  String get skip => 'Ignorer';

  @override
  String get smartCallerId => 'Identification intelligente de l\'appelant';

  @override
  String get sms => 'SMS';

  @override
  String get smsFilterDescription =>
      'Le filtrage SMS vous aide à filtrer automatiquement les messages indésirables et à garder votre liste de messages propre. Vous pouvez définir des règles de filtrage et des méthodes de notification.';

  @override
  String get smsFilterDisabled => 'Filtrage SMS désactivé';

  @override
  String get smsFilterEnabled => 'Filtrage SMS activé';

  @override
  String get smsFilterRuleAddedSuccessfully =>
      'Règle de filtrage SMS ajoutée avec succès';

  @override
  String get smsFilterRules => 'Règles de filtrage SMS';

  @override
  String get smsFilterSettings => 'Paramètres de filtrage SMS';

  @override
  String get smsManagement => 'Gestion SMS';

  @override
  String get smsPermission => 'Autorisation SMS';

  @override
  String get smsPermissionDescription =>
      'Utilisé pour filtrer les messages indésirables.';

  @override
  String get smsRuleAddedSuccessfully => 'Règle SMS ajoutée avec succès';

  @override
  String get smsRuleDeletedSuccessfully => 'Règle SMS supprimée avec succès';

  @override
  String smsRuleLoadFailed(Object error) {
    return 'Échec du chargement des règles SMS : $error';
  }

  @override
  String get smsRuleManagement => 'Gestion des règles SMS';

  @override
  String get smsRuleSubscription => 'Abonnement aux règles SMS';

  @override
  String get smsSubscription => 'Abonnement SMS';

  @override
  String get smsSubscriptionAddedSuccessfully =>
      'Abonnement SMS ajouté avec succès';

  @override
  String get smsSubscriptionRulesDescription =>
      'Abonnez-vous aux listes de règles SMS via URL, en prenant en charge la correspondance d\'expressions régulières. Vous pouvez définir des actions de blocage ou d\'autorisation.';

  @override
  String get smsTab => 'SMS';

  @override
  String get somePermissionsDenied =>
      'Certaines demandes d\'autorisation ont été refusées';

  @override
  String get spamLikely => 'Probablement du spam';

  @override
  String get startColor => 'Couleur de début';

  @override
  String get startDate => 'Date de début';

  @override
  String get startUsing => 'Commencer';

  @override
  String get statAnswered => 'Répondu';

  @override
  String get statBlocked => 'Bloqué';

  @override
  String get statistics => 'Statistiques';

  @override
  String get statisticsPageTitle => 'Analyse de données';

  @override
  String get stirColor => 'Couleur STIR';

  @override
  String get stirFontSize => 'Taille de police STIR';

  @override
  String get stirPosition => 'Position STIR';

  @override
  String get storagePermission => 'Autorisation de stockage';

  @override
  String get storagePermissionDescription =>
      'Utilisé pour enregistrer les paramètres et les règles.';

  @override
  String get subscribe => 'S\'abonner';

  @override
  String subscriptionAddSuccess(Object name) {
    return 'Abonnement \"$name\" ajouté avec succès';
  }

  @override
  String get subscriptionDeleteConfirmContent =>
      'Êtes-vous sûr de vouloir supprimer cet abonnement ?';

  @override
  String get subscriptionDeleteConfirmTitle => 'Supprimer l\'abonnement';

  @override
  String get subscriptionDeleted => 'Abonnement supprimé';

  @override
  String subscriptionDeleteFailed(Object error) {
    return 'Échec de la suppression de l\'abonnement : $error';
  }

  @override
  String get subscriptionDeleteSuccess => 'Abonnement supprimé';

  @override
  String subscriptionLoadFailed(Object error) {
    return 'Échec du chargement des abonnements : $error';
  }

  @override
  String get subscriptionName => 'Nom de l\'abonnement';

  @override
  String get subscriptionNameAndUrlCannotBeEmpty =>
      'Le nom et l\'URL de l\'abonnement ne peuvent pas être vides';

  @override
  String get subscriptionNameHint => 'Saisir le nom de l\'abonnement';

  @override
  String subscriptionStatusChangeFailed(Object error) {
    return 'Échec de la modification de l\'état de l\'abonnement : $error';
  }

  @override
  String subscriptionUpdateFailed(Object error) {
    return 'Échec de la mise à jour de l\'abonnement : $error';
  }

  @override
  String get subscriptionUpdateSuccess => 'Abonnement mis à jour avec succès';

  @override
  String get subscriptionUrl => 'URL de l\'abonnement';

  @override
  String get subscriptionUrlHint => 'Saisir l\'URL de l\'abonnement';

  @override
  String successfullyImportedRules(Object count) {
    return 'Règles $count importées avec succès';
  }

  @override
  String get supportSync => 'Support de synchronisation';

  @override
  String get survey => 'Sondage';

  @override
  String get syncDevicesButton => 'Synchroniser les appareils';

  @override
  String get syncFailed => 'La synchronisation a échoué';

  @override
  String get syncFailedMessage => 'La synchronisation a échoué';

  @override
  String get syncFolderNameLabel => 'Nom du dossier de synchronisation';

  @override
  String get synchronized => 'Synchronisé';

  @override
  String get syncing => 'Synchronisation en cours...';

  @override
  String get syncNow => 'Synchroniser maintenant';

  @override
  String get syncNowButton => 'Synchroniser maintenant';

  @override
  String get syncStatusTitle => 'Statut de synchronisation';

  @override
  String get syncStatusUpdatedMessage => 'Statut de synchronisation mis à jour';

  @override
  String get syncSuccessMessage => 'Synchronisation réussie';

  @override
  String get syncWithCloudStorage => 'Synchroniser avec le stockage cloud';

  @override
  String get systemFeatures => 'Fonctionnalités du système :';

  @override
  String get systemSettingsTitle => 'Paramètres système';

  @override
  String get tabAll => 'Tous';

  @override
  String get tabAnswered => 'Répondu';

  @override
  String get tabBlocked => 'Bloqué';

  @override
  String get tabMissed => 'Manqué';

  @override
  String get tabOutgoing => 'Sortant';

  @override
  String tagLabel(String tag) {
    return 'Tag : $tag';
  }

  @override
  String get takeaway => 'À retenir';

  @override
  String get telecommunication => 'Télécommunications';

  @override
  String get telegram => 'Telegram';

  @override
  String get telemarketing => 'Télémarketing';

  @override
  String get testButton => 'TEST';

  @override
  String get testConnectionButton => 'Tester la connexion';

  @override
  String get textColorsSetting => 'Couleurs du texte et des étiquettes';

  @override
  String get thisAppIsAPowerfulCallerIdToolThatAllows =>
      'Cette application est un puissant outil d\'identification de l\'appelant qui vous permet d\'identifier et de bloquer les appels indésirables.';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get timeInterceptor => 'Protection contre les appels fréquents';

  @override
  String get timeInterceptorDescription =>
      'Bloquer les appels répétés d\'un même numéro dans un court intervalle';

  @override
  String get timeInterceptorExplanation =>
      '• Intercepteur de temps : intercepter/autoriser les appels répétés dans un court laps de temps';

  @override
  String get timeInterceptorExplanationContent =>
      'La fonction d\'interception de fréquence des appels analyse la fréquence des appels pour identifier et intercepter/autoriser automatiquement les appels spam fréquents.';

  @override
  String get timeInterceptorExplanationTitle =>
      'Explication de l\'interception de la fréquence des appels';

  @override
  String get timeInterceptorSettingsTitle =>
      'Paramètres d\'interception de la fréquence des appels';

  @override
  String get timeWindowDescription =>
      'Définissez la durée de la fenêtre temporelle pour autoriser les appels répétés. Les appels provenant du même numéro dans cette fenêtre seront autorisés';

  @override
  String timeWindowLabel(int minutes) {
    return 'Fenêtre d\'interception (minutes) : $minutes';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get total => 'Total';

  @override
  String get totalBlocked => 'Total bloqué';

  @override
  String get transferDataBetweenDevicesOrPlatforms =>
      'Transférer des données entre des appareils ou des plateformes';

  @override
  String get travelTicketing => 'Billetterie de voyage';

  @override
  String get tutorial => 'Tutoriel';

  @override
  String get type => 'Type';

  @override
  String get unassignedSIMCard => 'Carte SIM non attribuée';

  @override
  String get unknown => 'Inconnu';

  @override
  String get unknownTag => 'Tag : Inconnu';

  @override
  String get unregisterButton => 'Annuler l\'inscription';

  @override
  String unregisterDeviceConfirmationMessage(Object deviceName) {
    return 'Êtes-vous sûr de vouloir annuler l\'enregistrement de $deviceName ?';
  }

  @override
  String get unregisterDeviceTitle =>
      'Annuler l\'enregistrement de l\'appareil';

  @override
  String get unsupportedFileFormat => 'Format de fichier non pris en charge';

  @override
  String get update => 'Mettre à jour';

  @override
  String get updateAllNow => 'Tout mettre à jour maintenant';

  @override
  String updateContactFailed(Object error) {
    return 'Échec de la mise à jour du contact : $error';
  }

  @override
  String get updateFavoriteStatus => 'Mettre à jour l\'état des favoris';

  @override
  String get updateInterval => 'Intervalle de mise à jour';

  @override
  String get updateNow => 'Mettre à jour maintenant';

  @override
  String get updatePlugin => 'Mettre à jour le plug-in';

  @override
  String updatePluginFailed(Object error) {
    return 'Échec de la mise à jour du plug-in : $error';
  }

  @override
  String updateRuleFailed(Object error) {
    return 'Échec de la mise à jour de la règle : $error';
  }

  @override
  String updateSubscriptionFailed(Object error) {
    return 'Échec de la mise à jour de l\'abonnement : $error';
  }

  @override
  String updateSuccess(Object service, Object count) {
    return '$service mis à jour avec succès ($count règles)';
  }

  @override
  String get useCasesPoint1 =>
      '• Identifier les appels de spam de recomposition automatique';

  @override
  String get useCasesPoint2 =>
      '• Intercepter les appels marketing qui appellent plusieurs fois en peu de temps';

  @override
  String get useCasesPoint3 =>
      '• Empêcher le « phone bombing » et le harcèlement';

  @override
  String get useCasesTitle => 'Cas d\'utilisation :';

  @override
  String get useGlobalSettings => 'Utiliser les paramètres globaux';

  @override
  String get usernameLabel => 'Nom d\'utilisateur';

  @override
  String get useStandardRegexSyntaxToDefinePatternsExamples =>
      'Utiliser la syntaxe regex standard pour définir les modèles. Exemples :';

  @override
  String get verificationFailedText => 'Échec';

  @override
  String get verifiedText => 'Vérifié';

  @override
  String get verify => 'Vérifier';

  @override
  String version(Object version) {
    return 'Version : $version';
  }

  @override
  String get vipExchangeDescription =>
      'Échangez l\'abonnement VIP avec le nombre de marquages de numéros de téléphone';

  @override
  String get vipExchangeTitle => 'Échange VIP de marquage';

  @override
  String get watchAd => 'Regarder une publicité';

  @override
  String get watchAdForTemp =>
      'Regarder une publicité pour des privilèges temporaires';

  @override
  String get watchAdForTempDescription =>
      'Regardez une courte publicité pour débloquer temporairement certaines fonctionnalités premium';

  @override
  String get webDAVConfigTitle => 'Configuration WebDAV';

  @override
  String get week => 'Semaine';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get whitelist => 'Liste blanche';

  @override
  String get width => 'Largeur';

  @override
  String get wildcardMatchingDescription =>
      'Utilisez \'.\' pour correspondre à n\'importe quel caractère (par exemple, \'123.456\' correspond à 123-456)';

  @override
  String get wildcardMatchingTitle =>
      'Correspondance par caractère générique :';

  @override
  String get wildcardSupportForFlexibleFiltering =>
      'Prise en charge des caractères génériques pour le filtrage flexible';

  @override
  String get windowSizeSetting => 'Taille de la fenêtre';

  @override
  String get year => 'Année';

  @override
  String get noSimCardsDetected => 'Aucune carte SIM détectée';

  @override
  String get filterManagementDescription => 'Définir les filtres d\'appel';

  @override
  String get callerIdCustomizationSubtitle =>
      'Personnaliser la mise en page de l\'identification de l\'appelant';

  @override
  String get fraudAlerSettingTitle => 'Paramètre d\'alerte de fraude';

  @override
  String get fraudAlerSettingSubtitle => 'Pour configurer l\'alerte de fraude';

  @override
  String get enableFraudAlert => 'Activer l\'alerte de fraude';

  @override
  String get enableFraudAlertDescription =>
      'Alerte pour les appels suspects d\'arnaque';

  @override
  String get enableVibration => 'Activer la vibration';

  @override
  String get enableVibrationDescription =>
      'Vibrer lorsqu\'un appel est suspecté d\'être une arnaque';

  @override
  String get notificationSettingsTitle => 'Paramètres de notification';

  @override
  String get useLocalNotification => 'Utiliser les notifications locales';

  @override
  String get useLocalNotificationDescription =>
      'Activer les notifications locales pour les appels entrants';

  @override
  String get cancelLocalNotification => 'Fermer les notifications locales';

  @override
  String get useStirNotification => 'Utiliser la notification de STIR';

  @override
  String get cancelLocalNotificationDescription =>
      'Fermer automatiquement les notifications locales';

  @override
  String get callerIdSettingsTitle =>
      'Paramètres d\'identification de l\'appelant';

  @override
  String get callerIdSettingsSubtitle =>
      'Pour configurer la notification d\'appel entrant et le mode d\'affichage';

  @override
  String get purchaseTitle => 'Achat';

  @override
  String get purchaseSubtitle => 'Pour acheter le service';

  @override
  String get callerIdNotificationTitle => 'Informations sur l\'appel entrant';

  @override
  String get blockedCallTitle => 'Appel bloqué';

  @override
  String blockedCallBody(String phoneNumber) {
    return 'Appel bloqué de $phoneNumber';
  }

  @override
  String get stirVerified => 'STIR Pass';

  @override
  String get stirNotVerified => 'STIR Not Pass';

  @override
  String get stirFailed => 'Échec de la vérification';

  @override
  String get stirUnknown => 'Statut de vérification inconnu';

  @override
  String get stirVerificationTitle => 'Vérification STIR/SHAKEN';

  @override
  String stirVerificationBody(String stirResultMessage, String phoneNumber) {
    return '$stirResultMessage pour le numéro $phoneNumber';
  }

  @override
  String get scrollingSecurityMessageSettings =>
      'Paramètres du message de sécurité défilant';

  @override
  String get messageColor => 'Couleur du message';

  @override
  String get messageFontSize => 'Taille de la police du message';

  @override
  String get messagePosition => 'Position du message';

  @override
  String get containerWidth => 'Largeur du conteneur';

  @override
  String get scrollSpeed => 'Vitesse de défilement';

  @override
  String get enableSecurityMessage => 'Activer le message de sécurité';

  @override
  String get fraudAlertTitle => 'Alerte de fraude';

  @override
  String get noBlockedTypeData => 'Aucune donnée de type bloqué disponible';

  @override
  String importEntity(Object entityTypeName) {
    return 'Importer $entityTypeName';
  }

  @override
  String entityImportSuccess(Object entityTypeName, Object count) {
    return '$entityTypeName importé avec succès, total $count enregistrements importés';
  }

  @override
  String entityImportFailed(Object entityTypeName, Object error) {
    return 'Échec de l\'importation de $entityTypeName : $error';
  }

  @override
  String exportEntity(Object entityTypeName) {
    return 'Exporter $entityTypeName';
  }

  @override
  String entityExportSuccess(Object entityTypeName) {
    return '$entityTypeName exporté avec succès';
  }

  @override
  String entityExportFailed(Object entityTypeName, Object error) {
    return 'Échec de l\'exportation de $entityTypeName : $error';
  }

  @override
  String get cloudSyncService => 'Service de synchronisation cloud';

  @override
  String get membershipCenter => 'Centre d\'adhésion';

  @override
  String get redeemVipWithMarks => 'Échangez VIP avec des points';

  @override
  String get currentMarkCount => 'Nombre de points actuel';

  @override
  String get markMoreNumbersForMore =>
      'Marquez plus de numéros pour plus de points';

  @override
  String get noAds => 'Pas de publicités';

  @override
  String get cloudBackup => 'Sauvegarde cloud';

  @override
  String get callerIdEnhancement =>
      'Amélioration de l\'identification de l\'appelant';

  @override
  String get voiceRecognition => 'Reconnaissance vocale';

  @override
  String get feature => 'Fonctionnalité';

  @override
  String get normalUser => 'Utilisateur normal';

  @override
  String get vipUser => 'Utilisateur VIP';

  @override
  String get temporaryVip => 'VIP temporaire';

  @override
  String get removeAds => 'Supprimer les publicités';

  @override
  String get settingsBackup => 'Sauvegarde des paramètres';

  @override
  String get allServicesStatusTitle => 'État actuel du service';

  @override
  String get allServicesStatusSubtitle => 'État actuel de chaque service cloud';

  @override
  String get redirect => 'Rediriger';

  @override
  String get notify => 'Notifier';

  @override
  String get log => 'Journal';

  @override
  String get custom => 'Personnalisé';

  @override
  String get allowActionDescription =>
      'Les appels seront autorisés, même si le numéro est sur la liste de blocage.';

  @override
  String get blockActionDescription =>
      'Les appels seront bloqués et affichés dans le journal des appels.';

  @override
  String get silenceActionDescription =>
      'Les appels seront mis en sourdine, mais affichés dans le journal des appels.';

  @override
  String get noneActionDescription =>
      'Aucune action spéciale ne sera effectuée pour l\'appel.';

  @override
  String get redirectActionDescription =>
      'Rediriger l\'appel vers un numéro spécifié.';

  @override
  String get labelActionDescription =>
      'Ajouter une étiquette à l\'appel pour une identification facile.';

  @override
  String get notifyActionDescription =>
      'Envoyer une notification lorsqu\'un appel est reçu.';

  @override
  String get logActionDescription =>
      'Enregistrer les informations de l\'appel sans prendre d\'autre mesure.';

  @override
  String get customActionDescription => 'Effectuer une action personnalisée.';

  @override
  String get synced => 'Synchronisé';

  @override
  String get needVipAccess =>
      'Vous avez besoin d\'un accès VIP pour utiliser cette fonctionnalité';

  @override
  String importExportDescription(Object entityTypeName) {
    return 'Importer ou exporter les données $entityTypeName';
  }

  @override
  String get importExportTitle => 'Importer/Exporter';

  @override
  String get noPhoneRules => 'Aucune règle de téléphone trouvée';

  @override
  String get noRegexRules => 'Aucune règle regex trouvée';

  @override
  String get noAllowedBlockedRules => 'Aucune règle autorisée/bloquée trouvée';

  @override
  String get importExport => 'Importer/Exporter';

  @override
  String get filterByAction => 'Filtrer par action';

  @override
  String get upgradeToVip => 'Passer à VIP';

  @override
  String get batteryOptimizationPermission => 'Optimisation de la batterie';

  @override
  String get batteryOptimizationPermissionDescription =>
      'Autoriser l\'application à s\'exécuter en arrière-plan pour fournir des services comme l\'identification de l\'appelant.';

  @override
  String get permissionTitle => 'Permissions spéciales';

  @override
  String get permissionSubtitle =>
      'Gérer les permissions de superposition et d\'optimisation de la batterie';

  @override
  String get themeSettingsTitle => 'Paramètres du thème';

  @override
  String get themeSettingsSubtitle => 'Choisissez votre thème préféré';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get databaseSyncTitle => 'Synchronisation de la base de données';

  @override
  String get countrySyncSettingsTitle =>
      'Paramètres de synchronisation de la base de données par pays';

  @override
  String get countrySyncSettingsSubtitle =>
      'Sélectionnez les pays pour la synchronisation des données';

  @override
  String get countryDataDisclaimer =>
      'Veuillez noter: La base de données peut ne pas inclure de données pour tous les pays ou régions spécifiques.';

  @override
  String get editSubscription => 'Modifier l\'abonnement';

  @override
  String get searchByNameOrPhoneNumber =>
      'Rechercher par nom ou numéro de téléphone';

  @override
  String get allowedBlockedRulesInfo =>
      'Les règles autorisées/bloquées sont utilisées pour faire correspondre les appels à des numéros de téléphone spécifiques, qui ont la plus haute priorité.';

  @override
  String get searchPhoneRulesHint => 'Rechercher des règles de téléphone';

  @override
  String get phoneRulesInfo =>
      'Les règles de téléphone sont utilisées pour faire correspondre les appels à des numéros de téléphone spécifiques, qui ont une priorité inférieure. Certains proviennent des abonnements aux règles de téléphone.';

  @override
  String get searchSubscriptionsHint => 'Rechercher des abonnements';

  @override
  String get searchPluginsHint => 'Rechercher des plugins';

  @override
  String get searchLabelsHint => 'Rechercher des étiquettes';

  @override
  String get pluginDescription => 'Description du plugin';

  @override
  String get enterPluginDescription => 'Saisir la description du plugin';

  @override
  String get searchRegexRulesHint => 'Rechercher des règles regex';

  @override
  String get regexRulesInfo =>
      'Les règles Regex sont utilisées pour filtrer les appels en fonction des motifs Regex.';

  @override
  String get searchMarkedPhonesHint => 'Rechercher les téléphones marqués';

  @override
  String get searchContactSubscriptionsHint =>
      'Rechercher les abonnements de contacts';

  @override
  String get showAllContacts => 'Afficher tous les contacts';

  @override
  String get showFavorites => 'Afficher les favoris';

  @override
  String get manualEntry => 'Informations de saisie manuelle';

  @override
  String get scriptSaved => 'Script enregistré';

  @override
  String editScriptFor(String pluginName) {
    return 'Modifier le script pour $pluginName';
  }

  @override
  String get saveScript => 'Enregistrer le script';

  @override
  String get testPlugin => 'Tester le plugin';

  @override
  String get description => 'Description';

  @override
  String get accessTargetUrl => 'Accéder à l\'URL cible';

  @override
  String get result => 'Résultat';

  @override
  String get editScript => 'Modifier le script';

  @override
  String get numberFormat => 'Format de numéro';

  @override
  String get nationalNumber => 'Numéro national';

  @override
  String get e164Number => 'Numéro E164';

  @override
  String get pluginRulesInfo =>
      'Pour la sécurité, veuillez n\'utiliser que des plugins provenant de sources fiables. N\'hésitez pas à utiliser nos modèles pour créer vos propres plugins personnalisés !';

  @override
  String get advancedMode => 'Mode avancé';

  @override
  String get pleaseEnterAtLeastOneNumber =>
      'Veuillez saisir au moins un numéro.';

  @override
  String get openInWebView => 'Ouvrir dans WebView';

  @override
  String get pluginLabel => 'Étiquette du plugin';

  @override
  String get pluginID => 'ID';

  @override
  String get pluginURL => 'URL';

  @override
  String get messageBackgroundColor => 'Couleur de fond du message';

  @override
  String get clearAllCallLogs => 'Effacer tous les journaux d\'appels';

  @override
  String get clearAllCallLogsConfirmation =>
      'Confirmer pour effacer tous les journaux d\'appels';

  @override
  String get allCallLogsCleared =>
      'Tous les journaux d\'appels ont été effacés';

  @override
  String get unblocked => 'Débloqué';

  @override
  String get blockNumber => 'Numéro de bloc';

  @override
  String get blockNumberSuccess => 'Numéro de bloc réussi';

  @override
  String unblockNumberConfirmation(String phoneNumber) {
    return 'Êtes-vous sûr de vouloir débloquer $phoneNumber ?';
  }

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get unblock => 'Débloquer';

  @override
  String get unblockNumber => 'Débloquer le numéro';

  @override
  String get unblockNumberSuccess => 'Numéro débloqué avec succès';

  @override
  String get unblockNumberFailed => 'Échec du déblocage du numéro';

  @override
  String get callingNumberFailed => 'Échec de l\'appel du numéro';

  @override
  String get listView => 'Vue liste';

  @override
  String get timelineView => 'Vue chronologique';

  @override
  String get nameCannotBeEmpty => 'Le nom ne peut pas être vide';

  @override
  String get selectAction => 'Sélectionner l\'action';

  @override
  String get selectTargetService => 'Sélectionner le service cible';

  @override
  String get callDetails => 'Détails de l\'appel';

  @override
  String get callType => 'Type d\'appel';

  @override
  String get callTime => 'Heure de l\'appel';

  @override
  String get numberInvalidFormat => 'Format de numéro non valide';

  @override
  String get medium => 'Moyen';

  @override
  String get finalRisk => 'Risque final';

  @override
  String get simState => 'État de la SIM';

  @override
  String get ipCountry => 'Pays IP';

  @override
  String get simCountry => 'Pays de la SIM';

  @override
  String get isRoaming => 'Itinérance';

  @override
  String get isNumberMatch => 'Correspondance du numéro';

  @override
  String get support => 'Assistance';

  @override
  String get rewardedAdService => 'Service de publicités rémunérées';

  @override
  String get hasVipPrivilegeExceptAds =>
      'Vous disposez déjà de privilèges VIP (sauf pour les publicités)';

  @override
  String hasTempPrivilegeWithExpiry(Object expiryDate) {
    return 'Vous avez déjà des privilèges temporaires, date d\'expiration : $expiryDate';
  }

  @override
  String watchMoreAdsForTempVip(Object count) {
    return 'Vous devez regarder $count autres publicités pour obtenir des privilèges VIP temporaires';
  }

  @override
  String grantedTempPurchaseWithExpiry(Object days, Object expiryDate) {
    return 'Vous avez bénéficié de $days jours de privilèges d\'achat temporaires. Date d\'expiration : $expiryDate';
  }

  @override
  String get tempPurchaseExpired => 'Le privilège d\'achat temporaire a expiré';

  @override
  String get loadingAd => 'Chargement de la publicité...';

  @override
  String get earnedTempVip => 'VIP temporaire gagné';

  @override
  String get vipExchangeService => 'Service d\'échange VIP';

  @override
  String get marksInsufficient => 'Points insuffisants pour l\'échange';

  @override
  String get invalidExchangeRule => 'Règle d\'échange non valide';

  @override
  String exchangeSuccess(Object description, Object expiryDate) {
    return 'Échange réussi pour $description, date d\'expiration : $expiryDate';
  }

  @override
  String exchangeFailed(Object error) {
    return 'Échec de l\'échange : $error';
  }

  @override
  String get vip3DaysWithAds =>
      'VIP 3 jours avec publicités (synchronisation uniquement)';

  @override
  String get vip5DaysNoAds => 'VIP 5 jours complets sans publicité';

  @override
  String get vip7DaysNoAds => 'VIP 7 jours complets sans publicité';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get clearAllNotifications => 'Effacer toutes les notifications';

  @override
  String get clearAllNotificationsConfirmation =>
      'Confirmer pour effacer toutes les notifications';

  @override
  String get clearButton => 'Effacer';

  @override
  String get justNow => 'À l\'instant';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il y a $count minutes',
      one: 'Il y a 1 minute',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il y a $count heures',
      one: 'Il y a 1 heure',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Il y a $count jours',
      one: 'Il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get yesterday => 'Hier';

  @override
  String get deletionProposal => 'Proposition de suppression';

  @override
  String get createProposal => 'Créer une proposition';

  @override
  String get createProposalTitle => 'Créer une proposition de suppression';

  @override
  String get reason => 'Raison';

  @override
  String get reasonOutdated => 'Numéro obsolète';

  @override
  String get reasonPrivacy => 'Problème de confidentialité';

  @override
  String get reasonNotInService => 'Hors service';

  @override
  String get reasonWronglyIdentified => 'Mal identifié';

  @override
  String get reasonInaccurateInfo => 'Informations inexactes';

  @override
  String get reasonOther => 'Autre';

  @override
  String get submit => 'Soumettre';

  @override
  String get cancel => 'Annuler';

  @override
  String get riskLevel => 'Niveau de risque';

  @override
  String get riskLevelLow => 'Faible';

  @override
  String get riskLevelHigh => 'Élevé';

  @override
  String agreeVotes(int count) {
    return 'Pour : $count';
  }

  @override
  String totalVotes(int count) {
    return 'Total : $count';
  }

  @override
  String get voteAgree => 'Pour';

  @override
  String get voteDisagree => 'Contre';

  @override
  String createdAt(String date) {
    return 'Créé le : $date';
  }

  @override
  String get verificationReport => 'Rapport de vérification';

  @override
  String get proposalStatistics => 'Statistiques des propositions';

  @override
  String get totalProposals => 'Nombre total de propositions';

  @override
  String get activeProposals => 'Propositions actives';

  @override
  String get proposalCreated => 'Proposition créée avec succès';

  @override
  String get voteSubmitted => 'Vote soumis avec succès';

  @override
  String get noProposalsFound => 'Aucune proposition trouvée';

  @override
  String get refreshProposals => 'Actualiser les propositions';

  @override
  String get totalPendingProposals => 'Nombre total de propositions en attente';

  @override
  String get highRisk => 'Risque élevé';

  @override
  String get mediumRisk => 'Risque moyen';

  @override
  String get lowRisk => 'Faible risque';

  @override
  String get communityImpact => 'Impact communautaire';

  @override
  String get criticalIssues => 'Problèmes critiques';

  @override
  String get communityParticipation => 'Participation communautaire';

  @override
  String get noActivity => 'Aucune activité';

  @override
  String get low => 'Faible';

  @override
  String get moderate => 'Modéré';

  @override
  String get high => 'Élevé';

  @override
  String get veryHigh => 'Très élevé';

  @override
  String get voted => 'Voté';

  @override
  String get communityVotes => 'Votes de la communauté';

  @override
  String get waitingForMoreVotes =>
      'En attente de plus de votes de la communauté';

  @override
  String get proposalProcessed => 'Cette proposition a été traitée';

  @override
  String get supported => 'SOUTENUE';

  @override
  String get opposed => 'OPPOSÉE';

  @override
  String get approved => 'APPROUVÉE';

  @override
  String get rejected => 'REJETÉE';

  @override
  String get completed => 'TERMINÉE';

  @override
  String get pending => 'EN ATTENTE';

  @override
  String get critical => 'Critique';

  @override
  String get oppose => 'S\'opposer';

  @override
  String get veryLow => 'Très faible';

  @override
  String get deletionProposals => 'Propositions de suppression';

  @override
  String get deletionProposalNotificationDescription =>
      'Notifications concernant les résultats des votes et les mises à jour des propositions de suppression.';

  @override
  String get deletionProposalCreated => 'Proposition de suppression créée';

  @override
  String deletionProposalCreatedBody(String phoneNumber) {
    return 'Votre proposition de suppression pour $phoneNumber a été soumise à l\'examen de la communauté.';
  }

  @override
  String get proposalApproved => 'Proposition approuvée ✅';

  @override
  String proposalApprovedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La proposition de suppression pour $phoneNumber a été approuvée par la communauté (soutien de $supportPercentage%, $totalVotes votes).';
  }

  @override
  String get proposalRejected => 'Proposition rejetée ❌';

  @override
  String proposalRejectedBody(
    String phoneNumber,
    int supportPercentage,
    int totalVotes,
  ) {
    return 'La proposition de suppression pour $phoneNumber a été rejetée par la communauté (soutien de $supportPercentage%, $totalVotes votes).';
  }

  @override
  String get communityVotingStarted => 'Vote de la communauté commencé';

  @override
  String communityVotingStartedBody(String phoneNumber) {
    return 'Une nouvelle proposition de suppression pour $phoneNumber est maintenant ouverte au vote de la communauté.';
  }

  @override
  String get votingCompleted => 'Vote terminé';

  @override
  String votingCompletedBody(
    String phoneNumber,
    String result,
    int supportPercentage,
  ) {
    return 'Le vote de la communauté pour $phoneNumber est terminé. Résultat : $result (soutien de $supportPercentage%).';
  }

  @override
  String get newVoteReceived => 'Nouveau vote reçu';

  @override
  String newVoteReceivedBody(
    String voteType,
    String phoneNumber,
    int totalVotes,
  ) {
    return 'Quelqu\'un a voté pour $voteType la suppression de $phoneNumber. Votes actuels : $totalVotes.';
  }

  @override
  String get voteCount => 'Nombre de votes';

  @override
  String get deletionProposalDescription =>
      'Proposer des numéros pour suppression qui violent les règles de la communauté. Votre participation contribue à la sécurité de la plateforme.';

  @override
  String get searchProposals => 'Rechercher des propositions';

  @override
  String get defaultNotifications => 'Notifications par défaut';

  @override
  String get defaultNotificationsDescription =>
      'Canal de notification par défaut pour l\'application.';

  @override
  String get blockedCallNotifications => 'Notifications d\'appel bloqué';

  @override
  String get blockedCallNotificationsDescription =>
      'Affiche des informations sur les appels bloqués.';

  @override
  String get stirVerification => 'Vérification STIR/SHAKEN';

  @override
  String get stirVerificationDescription =>
      'Affiche les résultats de la vérification STIR/SHAKEN pour les numéros.';

  @override
  String get fraudAlerts => 'Alertes de fraude';

  @override
  String get fraudAlertsDescription =>
      'Affiche les avertissements pour les appels potentiellement frauduleux.';

  @override
  String get notificationMode => 'Mode de notification';

  @override
  String get pendingProposals => 'Propositions en attente';

  @override
  String pendingProposalsBody(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count propositions en attente',
      one: '1 proposition en attente',
      zero: 'aucune proposition en attente',
    );
    return 'Vous avez $_temp0.';
  }

  @override
  String get guidelinesLabel => 'Lignes directrices';

  @override
  String get riskLevelLabel => 'Niveau de risque';

  @override
  String get phoneNumberMinDigits =>
      'Le numéro de téléphone doit comporter au moins 7 chiffres';

  @override
  String get provideDetailedExplanation =>
      'Fournir une explication détaillée (minimum 10 caractères)';

  @override
  String get reasonMinCharacters =>
      'La raison doit comporter au moins 10 caractères';

  @override
  String get countryCodeTwoLetters => 'Code pays (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeLabel => 'Code pays (ISO 3166-1 alpha-2) *';

  @override
  String get countryCodeHint => 'ex. : US, CN, FR';

  @override
  String get countryCodeRequired => 'Le code pays est obligatoire';

  @override
  String get phoneNumberHint => 'Saisir le numéro de téléphone';

  @override
  String get phoneNumberRequired => 'Le numéro de téléphone est obligatoire';

  @override
  String get reasonRequired => 'Une raison est requise';

  @override
  String get riskLevelCritical => 'Critique';

  @override
  String get riskLevelMedium => 'Moyen';

  @override
  String get riskLevelVeryLow => 'Très faible';

  @override
  String get notificationFrequencyTitle => 'Fréquence des notifications';

  @override
  String errorMessage(String error) {
    return 'Erreur : $error';
  }

  @override
  String get reportingGuidelines =>
      '• Ne signalez que les numéros qui posent réellement problème\n• Fournissez des raisons précises et détaillées\n• Choisissez un niveau de risque approprié en fonction de la gravité\n• Les rapports erronés peuvent entraîner des restrictions de compte';

  @override
  String get notificationFrequencyHours =>
      'Fréquence des notifications (heures)';

  @override
  String supportCount(int supportCount) {
    return 'Soutien ($supportCount)';
  }

  @override
  String opposeCount(int opposeCount) {
    return 'Opposition ($opposeCount)';
  }

  @override
  String votesWithPercentage(int totalVotes, int supportPercentage) {
    return '$totalVotes votes ($supportPercentage% de soutien)';
  }

  @override
  String hoursDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '1 heure',
      zero: '0 heures',
    );
    return '$_temp0';
  }

  @override
  String get importantNoticeTitle => 'Avis important';

  @override
  String get dataSourceDisclaimer =>
      'Les chiffres proviennent d\'Internet et des soumissions des utilisateurs. Nous ne pouvons pas garantir qu\'un numéro, une fois supprimé, ne sera pas soumis à nouveau par d\'autres utilisateurs ou sources. Veuillez rechercher et vérifier activement les informations.';

  @override
  String get avatar => 'Avatar';

  @override
  String get location => 'Localisation';

  @override
  String get simCardTitle => 'Carte SIM';

  @override
  String get liveActivitiesSettingsTitle =>
      'Paramètres des activités en direct';

  @override
  String get elementsSettingsTitle => 'Paramètres des éléments';

  @override
  String get liveActivityMode => 'Activité en direct';

  @override
  String get liveActivityModeDescription =>
      'Affiche les informations d\'appel sous forme de notification permanente sur l\'écran de verrouillage et dans l\'Île dynamique (iOS).';

  @override
  String get phoneNumberType => 'Type de numéro de téléphone';

  @override
  String get liveActivitiesTestEndActivity => 'Fin de l\'activité';

  @override
  String get liveActivitiesTestSendNewActivity =>
      'Envoyer une nouvelle activité';

  @override
  String get liveActivitiesTestUpdateActivity => 'Mettre à jour l\'activité';

  @override
  String get liveActivityControlsTitle => 'Contrôles d\'activité en direct';

  @override
  String get liveActivitiesTestTitle => 'Test des activités en direct';

  @override
  String get liveNotificationCustomizationTitle =>
      'Personnalisation des notifications en direct';

  @override
  String get liveNotificationCustomizationSubtitle =>
      'Personnalisez l\'apparence des notifications en direct.';

  @override
  String get notification_instructions =>
      'Instructions :\n1. Appuyez sur \"ENVOYER\" pour créer ou mettre à jour une notification.\n2. Accédez à votre écran d\'accueil ou faites glisser le tiroir de notification vers le bas pour voir le résultat.\n3. Appuyez sur \"FIN\" pour ignorer la notification.';

  @override
  String get autoCancelNotification =>
      'Annulation automatique de la notification';

  @override
  String get autoCancelNotificationDescription =>
      'Si coché, la notification sera automatiquement ignorée lorsque l\'utilisateur appuie dessus.';

  @override
  String get setDelayTime => 'Définir le délai';

  @override
  String get proposalDetails => 'Détails de la proposition';

  @override
  String get proposalNotFound => 'Proposition non trouvée';

  @override
  String get processed => 'Traité';

  @override
  String get filterAndSortTitle => 'Filtrer et trier';

  @override
  String get filterVerifiedOwner => 'Filtrer le propriétaire vérifié';

  @override
  String get filterBy => 'Filtrer par';

  @override
  String get sortOldest => 'Trier par ancienneté';

  @override
  String get sortNewest => 'Trier par nouveauté';

  @override
  String get sortMostPopular => 'Trier par popularité';

  @override
  String get sortLeastPopular => 'Trier par moins populaire';

  @override
  String get sortBy => 'Trier par';

  @override
  String get simRulesNotFound => 'Règles SIM non trouvées';

  @override
  String get simSlotRules => 'Règles d\'emplacement SIM';

  @override
  String get noSimCardDetected => 'Aucune carte SIM détectée';

  @override
  String get invalidSimData => 'Données SIM non valides';

  @override
  String get simSlot => 'Emplacement SIM';

  @override
  String get enableFiltering => 'Activer le filtrage';

  @override
  String get detailedSettingsTitle => 'Paramètres détaillés';

  @override
  String get entryPointViewTitle => 'Vue du point d\'entrée';

  @override
  String get callTypeRejected => 'Rejeté';

  @override
  String get callTypeSilenced => 'Mis en sourdine';

  @override
  String andMoreItems(int count) {
    return 'et $count autres éléments';
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
  String get initialSetupTitle => 'Configuration de la bibliothèque de règles';

  @override
  String get initialSetupDesc =>
      'Veuillez sélectionner les bibliothèques de règles régionales que vous souhaitez bloquer. Ces règles peuvent vous aider à bloquer automatiquement les appels commerciaux et frauduleux courants dans votre région.';

  @override
  String get initialSetupRetry => 'Réessayer';

  @override
  String get initialSetupSkip => 'Ignorer';

  @override
  String get initialSetupSave => 'Configuration en un clic sélectionnée';

  @override
  String get initialSetupSaving => 'Enregistrement...';

  @override
  String get initialSetupSaveSuccess =>
      '✅ Configuration enregistrée avec succès, les règles seront récupérées automatiquement bientôt';

  @override
  String initialSetupSaveFailed(String error) {
    return 'Échec de l\'enregistrement de la configuration : $error';
  }

  @override
  String get initialSetupGetFailed =>
      'Échec de l\'obtention de la configuration';

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
  String get initialSetupSearchHint =>
      'Rechercher un ensemble de règles ou un pays...';

  @override
  String get initialSetupSelectAll => 'Tout sélectionner';

  @override
  String get initialSetupDeselectAll => 'Effacer la sélection';

  @override
  String initialSetupSelectedCount(int count) {
    return '$count sélectionné(s)';
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
  String get separateSims => 'SIM séparées';

  @override
  String get separateSimsDesc =>
      'Activer des règles de filtrage distinctes pour chaque carte SIM';

  @override
  String get masterAndOverrides => 'Commandes principales';

  @override
  String get masterAndOverridesDesc => 'Paramètres des règles globales';

  @override
  String get realtimeShieldActive => 'Realtime Shield Active';

  @override
  String get vipPrivilegeProgress => 'VIP Privilege Progress';

  @override
  String get communityThreatIntelligence => 'Community Threat Intelligence';

  @override
  String get consensusPassRate => 'Consensus Pass Rate';

  @override
  String get auditStreamLog => 'Audit Stream Log';

  @override
  String get responseLatency => 'Response Latency';

  @override
  String get scamFraud => 'Scam & Fraud';

  @override
  String get aiMarketing => 'AI Marketing';

  @override
  String get falsePositiveClean => 'False Positive Cleanup';

  @override
  String get liveStream => 'LIVE STREAM';

  @override
  String get ruleActionBreakdown => 'Rule Action Distribution';

  @override
  String get dualSimDistribution => 'Dual-SIM Interception Distribution';

  @override
  String get topTriggeredRules => 'Top Triggered Rules';

  @override
  String get peakHarassmentHours => 'Peak Harassment Hours';
}
