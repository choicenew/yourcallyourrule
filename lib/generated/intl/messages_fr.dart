// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(permissionName) =>
      "L\'autorisation ${permissionName} n\'a pas été accordée.";

  static String m1(listType) => "Ajouter à ${listType}";

  static String m2(listType) => "Ajouter à ${listType}";

  static String m3(permissionName) =>
      "Vous devez désactiver manuellement l\'autorisation ${permissionName} dans les paramètres de l\'application.";

  static String m4(listType) => "Supprimer ${listType}";

  static String m5(listType) => "Supprimer ${listType}";

  static String m6(permissionName) =>
      "Vous devez désactiver manuellement l\'autorisation ${permissionName} dans les paramètres de l\'application.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("À propos"),
        "accept": MessageLookupByLibrary.simpleMessage("Accepter"),
        "adEnabled":
            MessageLookupByLibrary.simpleMessage("Publicité activée :"),
        "add": MessageLookupByLibrary.simpleMessage("Ajouter"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page d\'entrée autorisée"),
        "addBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page de liste noire"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("Ajouter une page bloquée"),
        "addContact":
            MessageLookupByLibrary.simpleMessage("Ajouter un contact"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page d\'abonnement aux contacts"),
        "addLabelPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page d\'étiquette"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Ajouter une page de plugin"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Ajouter une page Regex"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page de liste noire SMS"),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page d\'abonnement SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page de liste noire de texte SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter des pages de listes blanches de texte SMS"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page de liste blanche SMS"),
        "addSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter une page d\'abonnement"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Ajouter aux autorisés"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Ajouter aux bloqués"),
        "addToBlockedtype": m2,
        "addToLabel":
            MessageLookupByLibrary.simpleMessage("Ajouter à l\'étiquette"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Ajouter des pages de listes blanches"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("ajouté avec succès"),
        "all": MessageLookupByLibrary.simpleMessage("Tous"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Autoriser tous les numéros autorisés"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Autoriser tous les numéros de la liste noire"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Autoriser tous les numéros de la liste blanche"),
        "allowBlockedNumbers": MessageLookupByLibrary.simpleMessage(
            "Autoriser les numéros bloqués"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Autoriser les modèles de liste noire Regex"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Autoriser les modèles de liste blanche Regex"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Autoriser les appels entrants répétés"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Autoriser cette application à afficher l\'identification de l\'appelant"),
        "allowed": MessageLookupByLibrary.simpleMessage("Autorisé"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Page d\'entrée autorisée"),
        "allowedpageview":
            MessageLookupByLibrary.simpleMessage("Vue de la page autorisée"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Répondre puis raccrocher"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Êtes-vous sûr de vouloir supprimer l\'élément"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Êtes-vous sûr de vouloir supprimer ce contact ?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Fermeture automatique de la notification locale"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Mise à jour automatique désactivée"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Mise à jour automatique activée"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes": MessageLookupByLibrary.simpleMessage(
            "Tailles des avatars et des icônes"),
        "avatarBorderColor": MessageLookupByLibrary.simpleMessage(
            "Couleur de la bordure de l\'avatar"),
        "avatarBorderSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la bordure de l\'avatar"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Position de l\'avatar"),
        "avatarSize":
            MessageLookupByLibrary.simpleMessage("Taille de l\'avatar"),
        "avatarUrlOrPath": MessageLookupByLibrary.simpleMessage(
            "URL ou chemin d\'accès de l\'avatar"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Dégradé d\'arrière-plan"),
        "backup": MessageLookupByLibrary.simpleMessage("Sauvegarde"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Sauvegarde et restauration"),
        "bank": MessageLookupByLibrary.simpleMessage("Banque"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Optimisation de la batterie"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Liste noire"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Page de liste noire"),
        "blacklistingAndWhitelisting": MessageLookupByLibrary.simpleMessage(
            "Listes noires et listes blanches"),
        "blacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste noire"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Bloquer les appels provenant d\'indicatifs régionaux spécifiques :"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Bloquer les appels internationaux :"),
        "blocked": MessageLookupByLibrary.simpleMessage("Bloqué"),
        "blockedCallAction":
            MessageLookupByLibrary.simpleMessage("Action d\'appel bloqué"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Notification d\'appel bloqué"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Statistiques des appels bloqués"),
        "blockedPage": MessageLookupByLibrary.simpleMessage("Page bloquée"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("Vue de la page bloquée"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Notification de l\'application d\'appel d\'origine et notification locale"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Notification SMS d\'origine et notification locale"),
        "call": MessageLookupByLibrary.simpleMessage("Appel"),
        "callHistory":
            MessageLookupByLibrary.simpleMessage("Historique des appels"),
        "callLog": MessageLookupByLibrary.simpleMessage("Journal des appels"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Autorisation du journal des appels refusée"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Échec de la demande de rôle de filtrage des appels !"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Demande de rôle de filtrage des appels réussie !"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage(
            "Application d\'identification de l\'appelant"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle": MessageLookupByLibrary.simpleMessage(
            "Style d\'identification de l\'appelant"),
        "callerIdStyleContent": MessageLookupByLibrary.simpleMessage(
            "Contenu du style d\'identification de l\'appelant"),
        "calltypeIconColor": MessageLookupByLibrary.simpleMessage(
            "Couleur de l\'icône de type d\'appel"),
        "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Opérateur :"),
        "carrierColor":
            MessageLookupByLibrary.simpleMessage("Couleur de l\'opérateur"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police de l\'opérateur"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Position de l\'opérateur"),
        "charity": MessageLookupByLibrary.simpleMessage("Charité"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Choisir un avatar (local ou réseau) :"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Choisir dans la galerie"),
        "chooseOnlyLinkOrFile": MessageLookupByLibrary.simpleMessage(
            "Choisissez uniquement un lien ou un fichier"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Choisir l\'action d\'interception par défaut"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Choisissez votre langue"),
        "clientId": MessageLookupByLibrary.simpleMessage("ID client"),
        "close": MessageLookupByLibrary.simpleMessage("Fermer"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "Nom du répertoire de sauvegarde dans le cloud"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "La sauvegarde dans le cloud nécessite une sauvegarde automatique"),
        "cloudServices": MessageLookupByLibrary.simpleMessage("Services cloud"),
        "collection": MessageLookupByLibrary.simpleMessage("Recouvrement"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Configuration exportée vers un fichier !"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Configuration importée"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Configuration importée avec succès"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Configuration enregistrée !"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Confirmer la suppression"),
        "contactFile":
            MessageLookupByLibrary.simpleMessage("Fichier de contact"),
        "contactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Page d\'abonnement aux contacts"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Nous contacter"),
        "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Contacts exportés avec succès"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Contacts importés avec succès"),
        "contactsPage":
            MessageLookupByLibrary.simpleMessage("Page des contacts"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("Contacts avec le numéro"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview": MessageLookupByLibrary.simpleMessage(
            "Liste des abonnements aux contacts"),
        "countColor":
            MessageLookupByLibrary.simpleMessage("Couleur du compteur"),
        "countFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police du compteur"),
        "countPosition":
            MessageLookupByLibrary.simpleMessage("Position du compteur"),
        "country": MessageLookupByLibrary.simpleMessage("Pays :"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Couleur du nom du pays"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police du nom du pays"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Position du nom du pays"),
        "cropAvatar":
            MessageLookupByLibrary.simpleMessage("Recadrer l\'avatar"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Service client"),
        "customizeCallerId": MessageLookupByLibrary.simpleMessage(
            "Personnaliser l\'identification de l\'appelant"),
        "dark": MessageLookupByLibrary.simpleMessage("Sombre"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Mode sombre"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "deleteContact":
            MessageLookupByLibrary.simpleMessage("Supprimer le contact"),
        "deleted": MessageLookupByLibrary.simpleMessage("Supprimé"),
        "delivery": MessageLookupByLibrary.simpleMessage("Livraison"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Vous avez refusé l\'autorisation. Vous pouvez activer manuellement l\'autorisation dans les paramètres."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Désactiver la notification d\'appel bloqué"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Désactiver l\'autorisation"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Désactiver la notification SMS locale"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Désactiver cette application pour afficher l\'identification de l\'appelant"),
        "disabled": MessageLookupByLibrary.simpleMessage("Désactivé"),
        "ecommerce":
            MessageLookupByLibrary.simpleMessage("Commerce électronique"),
        "edit": MessageLookupByLibrary.simpleMessage("Modifier"),
        "editAvatar":
            MessageLookupByLibrary.simpleMessage("Modifier l\'avatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Modifier le code"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Modifier le contact"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Modifier le code du plugin"),
        "education": MessageLookupByLibrary.simpleMessage("Éducation"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Positions des éléments"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Activer la notification d\'appel bloqué"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Activer le mode sombre en fonction de l\'heure"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "Activer l\'autorisation de superposition"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Activer la notification SMS locale"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Activer pour supprimer les publicités"),
        "enabled": MessageLookupByLibrary.simpleMessage("Activé"),
        "endColor": MessageLookupByLibrary.simpleMessage("Couleur de fin"),
        "endcall": MessageLookupByLibrary.simpleMessage("Raccrocher"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Saisir l\'URL de l\'image"),
        "enterPluginCodeHere": MessageLookupByLibrary.simpleMessage(
            "Saisir le code du plugin ici"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Saisir l\'URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Entrée"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Entrée ajoutée avec succès"),
        "error": MessageLookupByLibrary.simpleMessage("Erreur"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "Erreur lors de l\'exportation des contacts :"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Erreur lors de l\'obtention du statut de l\'autorisation"),
        "errorImporting": MessageLookupByLibrary.simpleMessage(
            "Erreur lors de l\'importation"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Erreur lors de la demande de rôle de filtrage des appels :"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Exporter"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Exporter la page d\'entrée autorisée"),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Exporter au format CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Exporter au format JSON"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Exporter au format VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Exporter au format YAML"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Exporter la page de liste noire"),
        "exportBlockedPage":
            MessageLookupByLibrary.simpleMessage("Exporter la page bloquée"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Exporter la page d\'abonnement aux contacts"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Exporter les contacts"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Échec de l\'exportation"),
        "exportFormat":
            MessageLookupByLibrary.simpleMessage("Format d\'exportation :"),
        "exportLabelPage": MessageLookupByLibrary.simpleMessage(
            "Exporter la page d\'étiquette"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Exporter la page du plugin"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Exporter la page Regex"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages de listes noires SMS"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Exporter la page d\'abonnement SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages de listes noires de texte SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages de listes blanches de texte SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages de listes blanches SMS"),
        "exportSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages d\'abonnements"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Exportation réussie"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Exporter les pages de listes blanches"),
        "failed": MessageLookupByLibrary.simpleMessage("Échoué"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Échec de l\'ajout :"),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage(
            "Échec de l\'ajout de l\'entrée :"),
        "feature": MessageLookupByLibrary.simpleMessage("Fonctionnalité"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription": MessageLookupByLibrary.simpleMessage(
            "Description de la fonctionnalité"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages":
            MessageLookupByLibrary.simpleMessage("Filtrer les SMS entrants"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Filtrer les appels entrants répétés"),
        "financial": MessageLookupByLibrary.simpleMessage("Financier"),
        "firstName": MessageLookupByLibrary.simpleMessage("Prénom"),
        "fraudScamLikely": MessageLookupByLibrary.simpleMessage(
            "Probablement une fraude ou une arnaque"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Commencer"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Échec de la connexion à Google Drive"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Connexion à Google Drive réussie"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Paramètres Google Drive"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Accorder l\'autorisation"),
        "group": MessageLookupByLibrary.simpleMessage("Groupe"),
        "height": MessageLookupByLibrary.simpleMessage("Hauteur"),
        "history": MessageLookupByLibrary.simpleMessage("Historique"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Taille de l\'icône"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Importer"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Importer la page d\'entrée autorisée"),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer des pages de listes noires"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Importer la page des entrées bloquées"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Importer la configuration"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Importer des contacts"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage(
            "Importer depuis un fichier CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Importer depuis un fichier"),
        "importFromJson": MessageLookupByLibrary.simpleMessage(
            "Importer depuis un fichier JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Importer depuis une URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage(
            "Importer depuis un fichier VCF"),
        "importFromYaml": MessageLookupByLibrary.simpleMessage(
            "Importer depuis un fichier YAML"),
        "importLabelPage": MessageLookupByLibrary.simpleMessage(
            "Importer la page d\'étiquette"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Importer la page du plugin"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Importer la page Regex"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Importer la page d\'abonnement SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer les pages de listes noires de texte SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer les pages de listes blanches de texte SMS"),
        "importSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Importer les pages d\'abonnements"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importer des pages de listes blanches"),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Importé avec succès depuis l\'URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("Achats intégrés activés"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Action d\'interception des appels entrants"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Initialisation..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Initialisation de la base de données..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Saisir les identifiants OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Assurance"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Intercepter les appels entrants répétés dans la plage de temps"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Format JSON invalide"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("N\'est pas abonné"),
        "isSubscribed": MessageLookupByLibrary.simpleMessage("Est abonné"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Rejoignez la chaîne et le groupe Telegram pour plus d\'informations"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Conserver uniquement la dernière sauvegarde"),
        "keyword": MessageLookupByLibrary.simpleMessage("Mot-clé"),
        "label": MessageLookupByLibrary.simpleMessage("Étiquette"),
        "labelIconColor": MessageLookupByLibrary.simpleMessage(
            "Couleur de l\'icône d\'étiquette"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Page d\'étiquette"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Vue de la page d\'étiquette"),
        "labelsColor":
            MessageLookupByLibrary.simpleMessage("Couleur des étiquettes"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police des étiquettes"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Position des étiquettes"),
        "lastName": MessageLookupByLibrary.simpleMessage("Nom de famille"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Clair"),
        "link": MessageLookupByLibrary.simpleMessage("Lien"),
        "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
        "loan": MessageLookupByLibrary.simpleMessage("Prêt"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Répertoire de sauvegarde locale uniquement sous le dossier Téléchargements"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Carte locale 1"),
        "localCard1Content": MessageLookupByLibrary.simpleMessage(
            "Contenu de la carte locale 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Couleur de la localisation"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police de la localisation"),
        "locationIconColor": MessageLookupByLibrary.simpleMessage(
            "Couleur de l\'icône de localisation"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Position de la localisation"),
        "login": MessageLookupByLibrary.simpleMessage("Connexion"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Échec de la connexion"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Connexion Google Drive"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Connexion/Déconnexion Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Déconnexion Google Drive"),
        "manageRules": MessageLookupByLibrary.simpleMessage("Gérer les règles"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("Sauvegarde manuelle"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Marqué par"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage(
            "Faire correspondre n\'importe quel caractère :"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Faire correspondre les numéros de téléphone contenant des chiffres spécifiques :"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Faire correspondre les numéros de téléphone avec des caractères spécifiques au milieu :"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("Médical"),
        "merge": MessageLookupByLibrary.simpleMessage("Fusionner"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Fusionner les contacts"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Fusionner la sélection"),
        "message": MessageLookupByLibrary.simpleMessage("Message"),
        "mins": MessageLookupByLibrary.simpleMessage("min"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Nom"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "Le nom ne peut pas être vide"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Couleur du nom"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Taille de la police du nom"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Position du nom"),
        "next": MessageLookupByLibrary.simpleMessage("Suivant"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Aucune image sélectionnée"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Aucun filtre de SMS entrants"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Non vérifié"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "numberColor":
            MessageLookupByLibrary.simpleMessage("Couleur du numéro"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police du numéro"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Position du numéro"),
        "numberType": MessageLookupByLibrary.simpleMessage("Type de numéro"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Couleur du type de numéro"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police du type de numéro"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Position du type de numéro"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Paramètres OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Abonnement à l\'identification de l\'appelant en ligne"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Notification de l\'application d\'appel d\'origine uniquement"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Notification locale uniquement"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Utiliser uniquement la notification SMS d\'origine"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Ouvrir le dossier local"),
        "other": MessageLookupByLibrary.simpleMessage("Autre"),
        "overlay": MessageLookupByLibrary.simpleMessage("Superposition"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "L\'autorisation de superposition n\'a pas été accordée, ce qui peut affecter la fonction d\'affichage de l\'identification de l\'appelant. Vous pouvez activer l\'autorisation dans les paramètres de l\'application."),
        "page": MessageLookupByLibrary.simpleMessage("Page"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Coller le JSON"),
        "pasteJsonConfiguration": MessageLookupByLibrary.simpleMessage(
            "Coller la configuration JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Coller le JSON ici"),
        "pattern": MessageLookupByLibrary.simpleMessage("Modèle"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Autorisation refusée"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Autorisation accordée"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            " : Vous devez désactiver manuellement l\'autorisation dans les paramètres de l\'application."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "l\'autorisation dans les paramètres de l\'application."),
        "permissionWasNotGranted": MessageLookupByLibrary.simpleMessage(
            "L\'autorisation n\'a pas été accordée."),
        "permissions": MessageLookupByLibrary.simpleMessage("Autorisations"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Autorisations requises"),
        "phone": MessageLookupByLibrary.simpleMessage("Téléphone"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Ligne fixe"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Ligne fixe,Mobile"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("Mobile"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Numéro personnel"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Numéro surtaxé"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Numéro à coûts partagés"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Numéro gratuit"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Inconnu"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Messagerie vocale"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber":
            MessageLookupByLibrary.simpleMessage("Numéro de téléphone"),
        "pleaseEnter": MessageLookupByLibrary.simpleMessage("Veuillez saisir"),
        "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Veuillez saisir un numéro de téléphone"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Veuillez saisir un modèle"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Veuillez saisir une URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner un fichier ou saisir une URL"),
        "pleaseSelectALabel": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner une étiquette"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner un dossier d\'exportation"),
        "pleaseSelectAnOutputFile": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner un fichier de sortie :"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Veuillez sélectionner les entrées à exporter"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez appuyer sur « Accorder l\'autorisation » et autoriser l\'autorisation dans l\'écran suivant."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez appuyer sur « Configurer par défaut » et autoriser l\'autorisation dans l\'écran suivant."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Veuillez attendre la fin de l\'initialisation de la base de données."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Page du plugin"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugins"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Vue de la page des plugins"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Politique"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase failed:"),
        "purchaseIsBeingProcessed": MessageLookupByLibrary.simpleMessage(
            "Purchase is being processed..."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase successful!"),
        "quarterlySubscription":
            MessageLookupByLibrary.simpleMessage("Quarterly Subscription"),
        "recordbackup": MessageLookupByLibrary.simpleMessage("RecordBackup"),
        "regex": MessageLookupByLibrary.simpleMessage("Regex"),
        "regexPage": MessageLookupByLibrary.simpleMessage("Page Regex"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Explication du modèle Regex"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Les modèles Regex sont des expressions régulières utilisées pour faire correspondre les numéros de téléphone."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("Vue de la page Regex"),
        "region": MessageLookupByLibrary.simpleMessage("Région :"),
        "reject": MessageLookupByLibrary.simpleMessage("Rejeter"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Rejeter tous les numéros"),
        "remove": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Supprimer les publicités et activer la sauvegarde en ligne"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("Supprimer des autorisés"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Supprimer des bloqués"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn":
            MessageLookupByLibrary.simpleMessage("Appels bloqués répétés en"),
        "repeatedCalls": MessageLookupByLibrary.simpleMessage("Appels répétés"),
        "restoreFromGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Restaurer depuis Google Drive"),
        "restoreFromLocal": MessageLookupByLibrary.simpleMessage(
            "Restaurer depuis le stockage local"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Restaurer depuis OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Restaurer depuis WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing": MessageLookupByLibrary.simpleMessage("Covoiturage"),
        "risk": MessageLookupByLibrary.simpleMessage("Risque"),
        "robocall": MessageLookupByLibrary.simpleMessage("Appel automatique"),
        "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Rechercher des contacts"),
        "searchEntries":
            MessageLookupByLibrary.simpleMessage("Rechercher des entrées"),
        "selectALabel": MessageLookupByLibrary.simpleMessage(
            "Sélectionner une étiquette :"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Tout sélectionner"),
        "selectColor":
            MessageLookupByLibrary.simpleMessage("Sélectionner une couleur"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Sélectionner l\'indicatif de pays (facultatif)"),
        "selectEntries":
            MessageLookupByLibrary.simpleMessage("Sélectionner des entrées"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Sélectionner les entrées à exporter"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Contacts sélectionnés fusionnés avec succès"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Étiquette sélectionnée"),
        "selectingExportFolder": MessageLookupByLibrary.simpleMessage(
            "Sélection du dossier d\'exportation"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Intervalles de mise à jour du service (jours)"),
        "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Paramètres enregistrés"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Configurer par défaut"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Configurer l\'application d\'identification de l\'appelant par défaut"),
        "sharing": MessageLookupByLibrary.simpleMessage("Partage"),
        "showContactButton": MessageLookupByLibrary.simpleMessage(
            "Afficher le bouton de contact"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Afficher le bouton d\'icône de contact"),
        "showTelegram":
            MessageLookupByLibrary.simpleMessage("Afficher Telegram"),
        "showWhatsapp":
            MessageLookupByLibrary.simpleMessage("Afficher WhatsApp"),
        "showingResultsFor": MessageLookupByLibrary.simpleMessage(
            "Affichage des résultats pour"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Silence sans réponse"),
        "simCardColor":
            MessageLookupByLibrary.simpleMessage("Couleur de la carte SIM"),
        "simCardFontSize": MessageLookupByLibrary.simpleMessage(
            "Taille de la police de la carte SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Position de la carte SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("Ignorer"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Page de liste noire SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("Filtrage SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Le filtrage des SMS nécessite des autorisations SMS, de notification et de téléphone. Veuillez accorder ces autorisations pour activer cette fonctionnalité."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Notification SMS locale"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("Notification SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Page d\'abonnement SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Page de liste blanche de texte SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste noire SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Liste des abonnements SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste noire de texte SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste blanche de texte SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste blanche SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely":
            MessageLookupByLibrary.simpleMessage("Probablement du spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Couleur de début"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Plage de temps des statistiques (minutes) :"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Couleur STIR"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Taille de la police STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Position STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Stockage"),
        "subscribe": MessageLookupByLibrary.simpleMessage("S\'abonner"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Abonné"),
        "subscribedLink": MessageLookupByLibrary.simpleMessage("Lien abonné"),
        "subscriptionListPage": MessageLookupByLibrary.simpleMessage(
            "Page de la liste des abonnements"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Liste des abonnements"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("avec succès"),
        "survey": MessageLookupByLibrary.simpleMessage("Sondage"),
        "sync": MessageLookupByLibrary.simpleMessage("Synchroniser"),
        "system": MessageLookupByLibrary.simpleMessage("Système"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Plats à emporter"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("Télémarketing"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Tester"),
        "textLabelColors": MessageLookupByLibrary.simpleMessage(
            "Couleurs du texte et des étiquettes"),
        "textType": MessageLookupByLibrary.simpleMessage("Type de texte"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Cette application est un outil puissant d\'identification de l\'appelant qui vous permet d\'identifier les appelants inconnus et de bloquer les appels indésirables. Elle propose les fonctionnalités suivantes :"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Cette application a besoin d\'accéder aux informations de votre journal des appels pour fonctionner correctement. Veuillez accorder l\'autorisation."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Cette autorisation est requise pour que notre application soit l\'application d\'identification de l\'appelant par défaut."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Cette autorisation est requise pour que notre application puisse afficher des informations importantes par-dessus d\'autres applications.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Tutoriel"),
        "unknown": MessageLookupByLibrary.simpleMessage("Inconnu"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Désabonné"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect": MessageLookupByLibrary.simpleMessage(
            "Le format de l\'URL est incorrect"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Utiliser une image réseau"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Utilisez le caractère \'.\' pour faire correspondre n\'importe quel caractère unique. Par exemple, le modèle \'123.456\' correspond à \'123-456\', \'123.456\', \'123a456\', etc."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Utilisez le modèle \'^0[0-9]{2,3}\' pour faire correspondre les numéros de téléphone commençant par \'0\' suivi de 2 ou 3 chiffres, ce qui représente généralement un indicatif régional.\nUtilisez le modèle \'^010\' pour bloquer les appels provenant de l\'indicatif régional de Pékin (010).\nUtilisez le modèle \'^202\' pour bloquer les appels provenant de l\'indicatif régional de Washington (202).\nRemplacez l\'indicatif régional \'^0[0-9]{2,3}\' par celui que vous souhaitez bloquer."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Utilisez le modèle \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' pour faire correspondre les numéros de téléphone au format \'XXX-XXXX-XXXX\'. Remplacez \'X\' par les chiffres spécifiques que vous souhaitez faire correspondre."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Utilisez le modèle \'^\\+\' pour faire correspondre tous les numéros de téléphone commençant par un signe plus, qui indique généralement un numéro international."),
        "userName": MessageLookupByLibrary.simpleMessage("Nom d\'utilisateur"),
        "verified": MessageLookupByLibrary.simpleMessage("Vérifié"),
        "video": MessageLookupByLibrary.simpleMessage("Vidéo"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Paramètres WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Site web"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Liste blanche"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Page de liste blanche"),
        "whitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Vue de la page de liste blanche"),
        "width": MessageLookupByLibrary.simpleMessage("Largeur"),
        "wildcardSupportForFlexibleFiltering": MessageLookupByLibrary.simpleMessage(
            "Prise en charge des caractères génériques pour un filtrage flexible"),
        "windowSize":
            MessageLookupByLibrary.simpleMessage("Taille de la fenêtre"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Vous pouvez utiliser la syntaxe standard des expressions régulières pour définir des modèles, ou demander à l\'IA de générer le modèle pour Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Vous avez refusé l\'autorisation. Vous pouvez activer manuellement l\'autorisation dans les paramètres."),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "Vous avez activé l\'autorisation."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe": MessageLookupByLibrary.simpleMessage(
            "Vous devez désactiver manuellement"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
