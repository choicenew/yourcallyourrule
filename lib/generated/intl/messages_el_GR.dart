// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a el_GR locale. All the
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
  String get localeName => 'el_GR';

  static String m0(permissionName) =>
      "Η άδεια ${permissionName} δεν χορηγήθηκε.";

  static String m1(listType) => "Προσθήκη σε ${listType}";

  static String m2(listType) => "Προσθήκη σε ${listType}";

  static String m3(permissionName) =>
      "Πρέπει να απενεργοποιήσετε χειροκίνητα την άδεια ${permissionName} στις ρυθμίσεις της εφαρμογής.";

  static String m4(listType) => "Αφαίρεση ${listType}";

  static String m5(listType) => "Αφαίρεση ${listType}";

  static String m6(permissionName) =>
      "Πρέπει να απενεργοποιήσετε χειροκίνητα την άδεια ${permissionName} στις ρυθμίσεις της εφαρμογής.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("Σχετικά"),
        "accept": MessageLookupByLibrary.simpleMessage("Αποδοχή"),
        "adEnabled":
            MessageLookupByLibrary.simpleMessage("Ενεργοποίηση διαφημίσεων:"),
        "add": MessageLookupByLibrary.simpleMessage("Προσθήκη"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας επιτρεπόμενης καταχώρησης"),
        "addBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας μαύρης λίστας"),
        "addBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας αποκλεισμένων"),
        "addContact": MessageLookupByLibrary.simpleMessage("Προσθήκη επαφής"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας εγγραφής επαφής"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σελίδας ετικέτας"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σελίδας plugin"),
        "addRegexPage":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σελίδας regex"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας μαύρης λίστας SMS"),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας εγγραφής SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας μαύρης λίστας κειμένου SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδων λευκής λίστας κειμένου SMS"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδας λευκής λίστας SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σελίδας εγγραφής"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σε επιτρεπόμενα"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σε αποκλεισμένα"),
        "addToBlockedtype": m2,
        "addToLabel":
            MessageLookupByLibrary.simpleMessage("Προσθήκη σε ετικέτα"),
        "addWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Προσθήκη σελίδων λευκής λίστας"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("προστέθηκε επιτυχώς"),
        "all": MessageLookupByLibrary.simpleMessage("Όλα"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται όλοι οι επιτρεπόμενοι αριθμοί"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται όλοι οι αριθμοί μαύρης λίστας"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται όλοι οι αριθμοί λευκής λίστας"),
        "allowBlockedNumbers": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται οι αποκλεισμένοι αριθμοί"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται τα πρότυπα μαύρης λίστας Regex"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται τα πρότυπα λευκής λίστας Regex"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπονται επαναλαμβανόμενες εισερχόμενες κλήσεις"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Να επιτρέπεται σε αυτήν την εφαρμογή να εμφανίζει ID καλούντος"),
        "allowed": MessageLookupByLibrary.simpleMessage("Επιτρέπεται"),
        "allowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Σελίδα επιτρεπόμενης καταχώρησης"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή επιτρεπόμενης σελίδας"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Απάντηση και τερματισμός"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Είστε βέβαιοι ότι θέλετε να διαγράψετε το στοιχείο"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Είστε βέβαιοι ότι θέλετε να διαγράψετε αυτήν την επαφή;"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Αυτόματος τερματισμός τοπικής ειδοποίησης"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Απενεργοποιημένη αυτόματη ενημέρωση"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποιημένη αυτόματη ενημέρωση"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatarAndIconSizes": MessageLookupByLibrary.simpleMessage(
            "Μεγέθη Avatar και Εικονιδίων"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Περιγράμματος Avatar"),
        "avatarBorderSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Περιγράμματος Avatar"),
        "avatarPosition": MessageLookupByLibrary.simpleMessage("Θέση Avatar"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Μέγεθος Avatar"),
        "avatarUrlOrPath":
            MessageLookupByLibrary.simpleMessage("URL ή διαδρομή Avatar"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Διαβάθμιση Φόντου"),
        "backup": MessageLookupByLibrary.simpleMessage("Backup"),
        "backupAndRestore":
            MessageLookupByLibrary.simpleMessage("Backup και επαναφορά"),
        "bank": MessageLookupByLibrary.simpleMessage("Τράπεζα"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Βελτιστοποίηση μπαταρίας"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Μαύρη Λίστα"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα μαύρης λίστας"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("Μαύρη και λευκή λίστα"),
        "blacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας μαύρης λίστας"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Αποκλεισμός κλήσεων από συγκεκριμένους κωδικούς περιοχής:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Αποκλεισμός διεθνών κλήσεων:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Αποκλεισμένο"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage(
            "Ενέργεια για αποκλεισμένες κλήσεις"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Ειδοποίηση αποκλεισμένης κλήσης"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Στατιστικά Αποκλεισμένων Κλήσεων"),
        "blockedPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα αποκλεισμένων"),
        "blockedpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας αποκλεισμένων"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Ειδοποίηση από την αρχική εφαρμογή κλήσεων & τοπική ειδοποίηση"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Αρχική ειδοποίηση SMS & τοπική ειδοποίηση"),
        "call": MessageLookupByLibrary.simpleMessage("Κλήση"),
        "callHistory": MessageLookupByLibrary.simpleMessage("Ιστορικό κλήσεων"),
        "callLog": MessageLookupByLibrary.simpleMessage("Ιστορικό κλήσεων"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Άρνηση άδειας ιστορικού κλήσεων"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Αποτυχία αιτήματος ρόλου φιλτραρίσματος κλήσεων!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Επιτυχής αίτημα ρόλου φιλτραρίσματος κλήσεων!"),
        "callerIdApp":
            MessageLookupByLibrary.simpleMessage("Εφαρμογή ID καλούντος"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Στυλ ID καλούντος"),
        "callerIdStyleContent": MessageLookupByLibrary.simpleMessage(
            "περιεχόμενο στυλ ID καλούντος"),
        "calltypeIconColor": MessageLookupByLibrary.simpleMessage(
            "Χρώμα Εικονιδίου Τύπου Κλήσης"),
        "cancel": MessageLookupByLibrary.simpleMessage("Ακύρωση"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Φορέας:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("Χρώμα Φορέα"),
        "carrierFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Φορέα"),
        "carrierPosition": MessageLookupByLibrary.simpleMessage("Θέση Φορέα"),
        "charity": MessageLookupByLibrary.simpleMessage("Φιλανθρωπία"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Επιλέξτε Avatar (Τοπικό ή Δικτύου):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Επιλογή από Συλλογή"),
        "chooseOnlyLinkOrFile": MessageLookupByLibrary.simpleMessage(
            "Επιλέξτε μόνο σύνδεσμο ή αρχείο"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Επιλέξτε την προεπιλεγμένη ενέργεια αποτροπής"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Επιλέξτε τη γλώσσα σας"),
        "clientId": MessageLookupByLibrary.simpleMessage("ID πελάτη"),
        "close": MessageLookupByLibrary.simpleMessage("Κλείσιμο"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "Όνομα καταλόγου cloud backup"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Το cloud backup απαιτεί αυτόματο backup"),
        "cloudServices":
            MessageLookupByLibrary.simpleMessage("Υπηρεσίες cloud"),
        "collection": MessageLookupByLibrary.simpleMessage("Συλλογή"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή ρυθμίσεων σε αρχείο!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή ρυθμίσεων"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Επιτυχής Εισαγωγή Ρυθμίσεων"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Αποθήκευση Ρυθμίσεων!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Επιβεβαίωση διαγραφής"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Αρχείο επαφής"),
        "contactSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα εγγραφής επαφής"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Επικοινωνία"),
        "contacts": MessageLookupByLibrary.simpleMessage("Επαφές"),
        "contactsExportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Επιτυχής εξαγωγή επαφών"),
        "contactsImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Επιτυχής εισαγωγή επαφών"),
        "contactsPage": MessageLookupByLibrary.simpleMessage("Σελίδα επαφών"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("επαφές με αριθμό"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Λίστα εγγραφών επαφής"),
        "countColor": MessageLookupByLibrary.simpleMessage("Χρώμα Μετρητή"),
        "countFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Μετρητή"),
        "countPosition": MessageLookupByLibrary.simpleMessage("Θέση Μετρητή"),
        "country": MessageLookupByLibrary.simpleMessage("Χώρα:"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Ονόματος Χώρας"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Ονόματος Χώρας"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Θέση Ονόματος Χώρας"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Κοπή Avatar"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Εξυπηρέτηση πελατών"),
        "customizeCallerId":
            MessageLookupByLibrary.simpleMessage("Προσαρμογή ID καλούντος"),
        "dark": MessageLookupByLibrary.simpleMessage("Σκούρο"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Σκοτεινή Λειτουργία"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Διαγραφή"),
        "deleteContact":
            MessageLookupByLibrary.simpleMessage("Διαγραφή επαφής"),
        "deleted": MessageLookupByLibrary.simpleMessage("Διαγράφηκε"),
        "delivery": MessageLookupByLibrary.simpleMessage("Παράδοση"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Έχετε αρνηθεί την άδεια. Μπορείτε να ενεργοποιήσετε χειροκίνητα την άδεια στις Ρυθμίσεις."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Απενεργοποίηση ειδοποίησης αποκλεισμένης κλήσης"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Απενεργοποίηση άδειας"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Απενεργοποίηση τοπικής ειδοποίησης SMS"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Να μην επιτρέπεται σε αυτήν την εφαρμογή να εμφανίζει ID καλούντος"),
        "disabled": MessageLookupByLibrary.simpleMessage("Απενεργοποιημένο"),
        "ecommerce":
            MessageLookupByLibrary.simpleMessage("Ηλεκτρονικό εμπόριο"),
        "edit": MessageLookupByLibrary.simpleMessage("Επεξεργασία"),
        "editAvatar":
            MessageLookupByLibrary.simpleMessage("Επεξεργασία Avatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Επεξεργασία κώδικα"),
        "editContact":
            MessageLookupByLibrary.simpleMessage("Επεξεργασία επαφής"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Επεξεργασία κώδικα Plugin"),
        "education": MessageLookupByLibrary.simpleMessage("Εκπαίδευση"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Θέσεις Στοιχείων"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποίηση ειδοποίησης αποκλεισμένης κλήσης"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποίηση σκοτεινής λειτουργίας βάσει ώρας"),
        "enableOverlayPermission": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποίηση άδειας επικάλυψης"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποίηση τοπικής ειδοποίησης SMS"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποιήστε για να αφαιρέσετε τις διαφημίσεις"),
        "enabled": MessageLookupByLibrary.simpleMessage("Ενεργοποιημένο"),
        "endColor": MessageLookupByLibrary.simpleMessage("Χρώμα Λήξης"),
        "endcall": MessageLookupByLibrary.simpleMessage("Τερματισμός κλήσης"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Εισαγάγετε URL εικόνας"),
        "enterPluginCodeHere": MessageLookupByLibrary.simpleMessage(
            "Εισαγάγετε τον κώδικα του plugin εδώ"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Εισαγάγετε URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Καταχώρηση"),
        "entryAddedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "επιτυχής προσθήκη καταχώρησης"),
        "error": MessageLookupByLibrary.simpleMessage("Σφάλμα"),
        "errorExportingContacts": MessageLookupByLibrary.simpleMessage(
            "Σφάλμα κατά την εξαγωγή επαφών:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Σφάλμα κατά την ανάκτηση κατάστασης άδειας"),
        "errorImporting":
            MessageLookupByLibrary.simpleMessage("Σφάλμα κατά την εισαγωγή"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Σφάλμα κατά την αίτηση ρόλου φιλτραρίσματος κλήσεων:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Εξαγωγή"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδας επιτρεπόμενης καταχώρησης"),
        "exportAsCsv": MessageLookupByLibrary.simpleMessage("Εξαγωγή ως CSV"),
        "exportAsJson": MessageLookupByLibrary.simpleMessage("Εξαγωγή ως JSON"),
        "exportAsVcf": MessageLookupByLibrary.simpleMessage("Εξαγωγή ως VCF"),
        "exportAsYaml": MessageLookupByLibrary.simpleMessage("Εξαγωγή ως YAML"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδας μαύρης λίστας"),
        "exportBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδας αποκλεισμένων"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδας εγγραφής επαφής"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Εξαγωγή επαφών"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Αποτυχία εξαγωγής"),
        "exportFormat": MessageLookupByLibrary.simpleMessage("μορφή εξαγωγής:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("Εξαγωγή σελίδας ετικέτας"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Εξαγωγή σελίδας plugin"),
        "exportRegexPage":
            MessageLookupByLibrary.simpleMessage("Εξαγωγή σελίδας regex"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδων μαύρης λίστας SMS"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδας εγγραφής SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδων μαύρης λίστας κειμένου SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδων λευκής λίστας κειμένου SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδων λευκής λίστας SMS"),
        "exportSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Εξαγωγή σελίδων εγγραφών"),
        "exportSuccessful":
            MessageLookupByLibrary.simpleMessage("Επιτυχής εξαγωγή"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Εξαγωγή σελίδων λευκής λίστας"),
        "failed": MessageLookupByLibrary.simpleMessage("Αποτυχημένο"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Αποτυχία προσθήκης:"),
        "failedToAddEntry": MessageLookupByLibrary.simpleMessage(
            "Αποτυχία προσθήκης καταχώρησης:"),
        "feature": MessageLookupByLibrary.simpleMessage("Χαρακτηριστικό"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("περιγραφή χαρακτηριστικού"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Φιλτράρισμα εισερχόμενων μηνυμάτων SMS"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Φιλτράρισμα επαναλαμβανόμενων εισερχόμενων κλήσεων"),
        "financial": MessageLookupByLibrary.simpleMessage("Οικονομικά"),
        "firstName": MessageLookupByLibrary.simpleMessage("Όνομα"),
        "fraudScamLikely": MessageLookupByLibrary.simpleMessage("Πιθανή απάτη"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Ξεκινήστε"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Αποτυχία σύνδεσης Google Drive"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Επιτυχής σύνδεση Google Drive"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Ρυθμίσεις Google Drive"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Χορήγηση Άδειας"),
        "group": MessageLookupByLibrary.simpleMessage("Ομάδα"),
        "height": MessageLookupByLibrary.simpleMessage("Ύψος"),
        "history": MessageLookupByLibrary.simpleMessage("Ιστορικό"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Μέγεθος Εικονιδίου"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Εισαγωγή"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδας επιτρεπόμενης καταχώρησης"),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδων μαύρης λίστας"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδας αποκλεισμένων καταχωρήσεων"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή Ρυθμίσεων"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή επαφών"),
        "importFromCsv":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από Αρχείο"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από URL"),
        "importFromVcf":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή από YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή σελίδας ετικέτας"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή σελίδας plugin"),
        "importRegexPage":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή σελίδας regex"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδας εγγραφής SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδων μαύρης λίστας κειμένου SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδων λευκής λίστας κειμένου SMS"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Εισαγωγή σελίδων εγγραφών"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή σελίδων λευκής λίστας"),
        "importedSuccessfullyFromUrl":
            MessageLookupByLibrary.simpleMessage("Επιτυχής εισαγωγή από URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled": MessageLookupByLibrary.simpleMessage(
            "Ενεργοποιημένες αγορές εντός εφαρμογής"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Ενέργεια αποτροπής εισερχόμενης κλήσης"),
        "initializing": MessageLookupByLibrary.simpleMessage("Εκκίνηση..."),
        "initializingDatabase":
            MessageLookupByLibrary.simpleMessage("Εκκίνηση βάσης δεδομένων..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Εισαγωγή διαπιστευτηρίων OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Ασφάλιση"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Αποτροπή επαναλαμβανόμενων εισερχόμενων κλήσεων εντός του χρονικού διαστήματος"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Μη έγκυρη μορφή JSON"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("Δεν είναι εγγεγραμμένο"),
        "isSubscribed":
            MessageLookupByLibrary.simpleMessage("Είναι εγγεγραμμένο"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Εγγραφείτε στο κανάλι και την ομάδα Telegram για περισσότερες πληροφορίες"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Διατήρηση μόνο του πιο πρόσφατου αντιγράφου ασφαλείας"),
        "keyword": MessageLookupByLibrary.simpleMessage("Λέξη-κλειδί"),
        "label": MessageLookupByLibrary.simpleMessage("Ετικέτα"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Εικονιδίου Ετικέτας"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Σελίδα ετικέτας"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Προβολή σελίδας ετικέτας"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Χρώμα Ετικετών"),
        "labelsFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Ετικετών"),
        "labelsPosition": MessageLookupByLibrary.simpleMessage("Θέση Ετικετών"),
        "lastName": MessageLookupByLibrary.simpleMessage("Επώνυμο"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Ανοιχτό"),
        "link": MessageLookupByLibrary.simpleMessage("Σύνδεσμος"),
        "loading": MessageLookupByLibrary.simpleMessage("Φόρτωση..."),
        "loan": MessageLookupByLibrary.simpleMessage("Δάνειο"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Τοπικός κατάλογος αντιγράφων ασφαλείας μόνο στον φάκελο Λήψεις"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Τοπική Κάρτα 1"),
        "localCard1Content": MessageLookupByLibrary.simpleMessage(
            "περιεχόμενο τοπικής κάρτας 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Τοποθεσίας"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Τοποθεσίας"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Εικονιδίου Τοποθεσίας"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Θέση Τοποθεσίας"),
        "login": MessageLookupByLibrary.simpleMessage("Σύνδεση"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Αποτυχία σύνδεσης"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Σύνδεση Google Drive"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Σύνδεση/Αποσύνδεση Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Αποσύνδεση Google Drive"),
        "manageRules":
            MessageLookupByLibrary.simpleMessage("Διαχείριση Κανόνων"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("Χειροκίνητο backup"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Σημειώθηκε από"),
        "matchAnyCharacter": MessageLookupByLibrary.simpleMessage(
            "Αντιστοίχιση οποιουδήποτε χαρακτήρα:"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Αντιστοίχιση αριθμών τηλεφώνου που περιέχουν συγκεκριμένα ψηφία:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Αντιστοίχιση αριθμών τηλεφώνου με συγκεκριμένους χαρακτήρες στη μέση:"),
        "medical": MessageLookupByLibrary.simpleMessage("Ιατρική"),
        "merge": MessageLookupByLibrary.simpleMessage("Συγχώνευση"),
        "mergeContacts":
            MessageLookupByLibrary.simpleMessage("Συγχώνευση επαφών"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Συγχώνευση επιλεγμένων"),
        "message": MessageLookupByLibrary.simpleMessage("Μήνυμα"),
        "mins": MessageLookupByLibrary.simpleMessage("λεπτά"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Όνομα"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "Το όνομα δεν μπορεί να είναι κενό"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Χρώμα Ονόματος"),
        "nameFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Ονόματος"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Θέση Ονόματος"),
        "next": MessageLookupByLibrary.simpleMessage("Επόμενο"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Δεν έχει επιλεγεί εικόνα"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Χωρίς φίλτρο εισερχόμενων μηνυμάτων SMS"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Μη Επαληθευμένο"),
        "notifications": MessageLookupByLibrary.simpleMessage("Ειδοποιήσεις"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Χρώμα Αριθμού"),
        "numberFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Αριθμού"),
        "numberPosition": MessageLookupByLibrary.simpleMessage("Θέση Αριθμού"),
        "numberType": MessageLookupByLibrary.simpleMessage("Τύπος αριθμού"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Τύπου Αριθμού"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Τύπου Αριθμού"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Θέση Τύπου Αριθμού"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Ρυθμίσεις OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription":
            MessageLookupByLibrary.simpleMessage("Online εγγραφή ID καλούντος"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Μόνο ειδοποίηση από την αρχική εφαρμογή κλήσεων"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Μόνο ήχος τοπικής ειδοποίησης"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Χρήση μόνο της αρχικής ειδοποίησης SMS"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Άνοιγμα τοπικού φακέλου"),
        "other": MessageLookupByLibrary.simpleMessage("Άλλο"),
        "overlay": MessageLookupByLibrary.simpleMessage("Επικάλυψη"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Η άδεια επικάλυψης δεν χορηγήθηκε, γεγονός που μπορεί να επηρεάσει τη λειτουργία εμφάνισης ID καλούντος. Μπορείτε να ενεργοποιήσετε την άδεια στις ρυθμίσεις της εφαρμογής."),
        "page": MessageLookupByLibrary.simpleMessage("Σελίδα"),
        "password": MessageLookupByLibrary.simpleMessage("Κωδικός πρόσβασης"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Επικόλληση JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Επικόλληση Ρυθμίσεων JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Επικολλήστε το JSON εδώ"),
        "pattern": MessageLookupByLibrary.simpleMessage("Πρότυπο"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Άδεια Απαγορεύτηκε"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Χορήγηση άδειας"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Πρέπει να απενεργοποιήσετε χειροκίνητα την άδεια στις ρυθμίσεις της εφαρμογής."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "άδεια στις ρυθμίσεις της εφαρμογής."),
        "permissionWasNotGranted":
            MessageLookupByLibrary.simpleMessage("η άδεια δεν χορηγήθηκε."),
        "permissions": MessageLookupByLibrary.simpleMessage("Άδειες"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Απαιτούμενες άδειες"),
        "phone": MessageLookupByLibrary.simpleMessage("Τηλέφωνο"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Σταθερό"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage("Σταθερό ή κινητό"),
        "phoneNumberTypeMobile": MessageLookupByLibrary.simpleMessage("Κινητό"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Προσωπικός αριθμός"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Υψηλής χρέωσης"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Κοινόχρηστο κόστος"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Δωρεάν"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Άγνωστο"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Φωνητικό ταχυδρομείο"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber":
            MessageLookupByLibrary.simpleMessage("Αριθμός τηλεφώνου"),
        "pleaseEnter":
            MessageLookupByLibrary.simpleMessage("Παρακαλώ εισάγετε"),
        "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ εισάγετε έναν αριθμό τηλεφώνου"),
        "pleaseEnterAnPattern": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ εισάγετε ένα πρότυπο"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Παρακαλώ εισάγετε ένα URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ επιλέξτε ένα αρχείο ή εισάγετε ένα URL"),
        "pleaseSelectALabel": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ επιλέξτε μια ετικέτα"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ επιλέξτε έναν φάκελο εξαγωγής"),
        "pleaseSelectAnOutputFile": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ επιλέξτε ένα αρχείο εξόδου:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Παρακαλώ επιλέξτε καταχωρήσεις για εξαγωγή"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Πατήστε \"Χορήγηση Άδειας\" και επιτρέψτε την άδεια στην επόμενη οθόνη."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Πατήστε \"Ορισμός ως Προεπιλογή\" και επιτρέψτε την άδεια στην επόμενη οθόνη."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Παρακαλώ περιμένετε να ολοκληρωθεί η εκκίνηση της βάσης δεδομένων."),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Σελίδα Plugin"),
        "plugins": MessageLookupByLibrary.simpleMessage("Plugins"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Προβολή σελίδων plugin"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Πολιτικό"),
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
        "regexPage": MessageLookupByLibrary.simpleMessage("Σελίδα Regex"),
        "regexPatternExplanation":
            MessageLookupByLibrary.simpleMessage("Επεξήγηση προτύπου Regex"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Τα πρότυπα Regex είναι κανονικές εκφράσεις που χρησιμοποιούνται για την αντιστοίχιση αριθμών τηλεφώνου."),
        "regexpageview":
            MessageLookupByLibrary.simpleMessage("Προβολή σελίδας regex"),
        "region": MessageLookupByLibrary.simpleMessage("Περιοχή:"),
        "reject": MessageLookupByLibrary.simpleMessage("Απόρριψη"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Απόρριψη όλων των αριθμών"),
        "remove": MessageLookupByLibrary.simpleMessage("Αφαίρεση"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Αφαίρεση διαφημίσεων και ενεργοποίηση online backup"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("Αφαίρεση από επιτρεπόμενα"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Αφαίρεση από αποκλεισμένα"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Επαναλαμβανόμενες αποκλεισμένες κλήσεις σε"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Επαναλαμβανόμενες κλήσεις"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Επαναφορά από Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Επαναφορά από τοπικό"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Επαναφορά από OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Επαναφορά από WebDAV"),
        "ridesharing":
            MessageLookupByLibrary.simpleMessage("Κοινή χρήση οχήματος"),
        "risk": MessageLookupByLibrary.simpleMessage("Κίνδυνος"),
        "robocall": MessageLookupByLibrary.simpleMessage("Αυτόματη κλήση"),
        "save": MessageLookupByLibrary.simpleMessage("Αποθήκευση"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Αναζήτηση επαφών"),
        "searchEntries":
            MessageLookupByLibrary.simpleMessage("Αναζήτηση καταχωρήσεων"),
        "selectALabel":
            MessageLookupByLibrary.simpleMessage("Επιλέξτε μια ετικέτα:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Επιλογή όλων"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Επιλογή Χρώματος"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Επιλέξτε κωδικό χώρας (προαιρετικά)"),
        "selectEntries":
            MessageLookupByLibrary.simpleMessage("Επιλογή καταχωρήσεων"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Επιλέξτε καταχωρήσεις για εξαγωγή"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Επιτυχής συγχώνευση επιλεγμένων επαφών"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Επιλεγμένη Ετικέτα"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("επιλογή φακέλου εξαγωγής"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Διαστήματα ενημέρωσης υπηρεσίας (ημέρες)"),
        "settings": MessageLookupByLibrary.simpleMessage("Ρυθμίσεις"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Αποθήκευση ρυθμίσεων"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Ορισμός ως Προεπιλογή"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Ορισμός ως προεπιλεγμένη εφαρμογή ID καλούντος"),
        "sharing": MessageLookupByLibrary.simpleMessage("Κοινοποίηση"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Εμφάνιση κουμπιού επαφής"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Εμφάνιση κουμπιού εικονιδίου επαφής"),
        "showTelegram":
            MessageLookupByLibrary.simpleMessage("Εμφάνιση Telegram"),
        "showWhatsapp":
            MessageLookupByLibrary.simpleMessage("Εμφάνιση WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Εμφάνιση αποτελεσμάτων για"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Σίγαση χωρίς απάντηση"),
        "simCardColor":
            MessageLookupByLibrary.simpleMessage("Χρώμα Κάρτας SIM"),
        "simCardFontSize": MessageLookupByLibrary.simpleMessage(
            "Μέγεθος Γραμματοσειράς Κάρτας SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Θέση Κάρτας SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("Παράλειψη"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα μαύρης λίστας SMS"),
        "smsFiltering": MessageLookupByLibrary.simpleMessage("Φιλτράρισμα SMS"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Το φιλτράρισμα SMS απαιτεί άδειες SMS, ειδοποιήσεων και τηλεφώνου. Παρακαλώ χορηγήστε αυτές τις άδειες για να ενεργοποιήσετε αυτήν τη λειτουργία."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Τοπική ειδοποίηση SMS"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("Ειδοποίηση SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα εγγραφής SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Σελίδα λευκής λίστας κειμένου SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας μαύρης λίστας SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Λίστα εγγραφών SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας μαύρης λίστας κειμένου SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας λευκής λίστας κειμένου SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας λευκής λίστας SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely": MessageLookupByLibrary.simpleMessage("Πιθανό spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Χρώμα Έναρξης"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Χρονικό διάστημα στατιστικών (λεπτά):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Χρώμα STIR"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Μέγεθος Γραμματοσειράς STIR"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Θέση STIR"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Αποθήκευση"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Εγγραφή"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Εγγεγραμμένο"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Σύνδεσμος εγγραφής"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα λίστας εγγραφών"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Λίστα εγγραφών"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successfully": MessageLookupByLibrary.simpleMessage("επιτυχώς"),
        "survey": MessageLookupByLibrary.simpleMessage("Έρευνα"),
        "sync": MessageLookupByLibrary.simpleMessage("Συγχρονισμός"),
        "system": MessageLookupByLibrary.simpleMessage("Σύστημα"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Παραλαβή"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("Τηλεπωλήσεις"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Δοκιμή"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Χρώματα Κειμένου & Ετικετών"),
        "textType": MessageLookupByLibrary.simpleMessage("Τύπος κειμένου"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Αυτή η εφαρμογή είναι ένα ισχυρό εργαλείο ID καλούντος που σας επιτρέπει να αναγνωρίζετε άγνωστους καλούντες και να αποκλείετε ανεπιθύμητες κλήσεις. Διαθέτει:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Αυτή η εφαρμογή χρειάζεται πρόσβαση στις πληροφορίες του ιστορικού κλήσεων σας για να λειτουργήσει σωστά. Παρακαλώ χορηγήστε την άδεια."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "Αυτή η άδεια απαιτείται για να γίνει η εφαρμογή μας η προεπιλεγμένη εφαρμογή ID καλούντος."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "Αυτή η άδεια απαιτείται για να εμφανίζει η εφαρμογή μας σημαντικές πληροφορίες πάνω από άλλες εφαρμογές.\\n\\n"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Εκμάθηση"),
        "unknown": MessageLookupByLibrary.simpleMessage("Άγνωστο"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed": MessageLookupByLibrary.simpleMessage("Μη εγγεγραμμένο"),
        "url": MessageLookupByLibrary.simpleMessage("URL"),
        "urlFormatIsIncorrect":
            MessageLookupByLibrary.simpleMessage("Μη έγκυρη μορφή URL"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Χρήση Εικόνας Δικτύου"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Χρησιμοποιήστε τον χαρακτήρα \'.\' για να αντιστοιχίσετε οποιονδήποτε μεμονωμένο χαρακτήρα. Για παράδειγμα, το πρότυπο \'123.456\' αντιστοιχίζει \'123-456\', \'123.456\', \'123a456\', κ.λπ."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Χρησιμοποιήστε το πρότυπο \'^0[0-9]{2,3}\' για να αντιστοιχίσετε αριθμούς τηλεφώνου που ξεκινούν με \'0\' ακολουθούμενο από 2 ή 3 ψηφία, το οποίο συνήθως αντιπροσωπεύει έναν κωδικό περιοχής.\nΧρησιμοποιήστε το πρότυπο \'^010\' για να αποκλείσετε κλήσεις από τον κωδικό περιοχής του Πεκίνου (010).\nΧρησιμοποιήστε το πρότυπο \'^202\' για να αποκλείσετε κλήσεις από τον κωδικό περιοχής της Ουάσιγκτον (202).\nΑντικαταστήστε τον κωδικό περιοχής \'^0[0-9]{2,3}\' με τον συγκεκριμένο που θέλετε να αποκλείσετε."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Χρησιμοποιήστε το πρότυπο \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' για να αντιστοιχίσετε αριθμούς τηλεφώνου με τη μορφή \'XXX-XXXX-XXXX\'. Αντικαταστήστε το \'X\' με τα συγκεκριμένα ψηφία που θέλετε να αντιστοιχίσετε."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Χρησιμοποιήστε το πρότυπο \'^\\+\' για να αντιστοιχίσετε όλους τους αριθμούς τηλεφώνου που ξεκινούν με σύμβολο συν, το οποίο συνήθως υποδεικνύει διεθνή αριθμό."),
        "userName": MessageLookupByLibrary.simpleMessage("Όνομα χρήστη"),
        "verified": MessageLookupByLibrary.simpleMessage("Επαληθευμένο"),
        "video": MessageLookupByLibrary.simpleMessage("Βίντεο"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Ρυθμίσεις WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Ιστοσελίδα"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Λευκή Λίστα"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Σελίδα λευκής λίστας"),
        "whitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Προβολή σελίδας λευκής λίστας"),
        "width": MessageLookupByLibrary.simpleMessage("Πλάτος"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Υποστήριξη wildcard για ευέλικτο φιλτράρισμα"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Μέγεθος Παραθύρου"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Μπορείτε να χρησιμοποιήσετε τυπική σύνταξη κανονικών εκφράσεων για να ορίσετε πρότυπα, ή να ζητήσετε από την AI να δημιουργήσει το πρότυπο για το Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Έχετε αρνηθεί την άδεια. Μπορείτε να ενεργοποιήσετε χειροκίνητα την άδεια στις Ρυθμίσεις."),
        "youHaveEnabledThePermission": MessageLookupByLibrary.simpleMessage(
            "Έχετε ενεργοποιήσει την άδεια."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe": MessageLookupByLibrary.simpleMessage(
            "Πρέπει να απενεργοποιήσετε χειροκίνητα την"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
