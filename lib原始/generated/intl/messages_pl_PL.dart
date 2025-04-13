// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl_PL locale. All the
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
  String get localeName => 'pl_PL';

  static String m0(permissionName) =>
      "Uprawnienie ${permissionName} nie zostało udzielone.";

  static String m1(listType) => "Dodaj do ${listType}";

  static String m2(listType) => "Dodaj do ${listType}";

  static String m3(permissionName) =>
      "Musisz ręcznie wyłączyć uprawnienie ${permissionName} w ustawieniach aplikacji.";

  static String m4(listType) => "Usuń ${listType}";

  static String m5(listType) => "Usuń ${listType}";

  static String m6(permissionName) =>
      "Musisz ręcznie wyłączyć uprawnienie ${permissionName} w ustawieniach aplikacji.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "PermissionWasNotGranted": m0,
        "about": MessageLookupByLibrary.simpleMessage("O aplikacji"),
        "accept": MessageLookupByLibrary.simpleMessage("Akceptuj"),
        "adEnabled": MessageLookupByLibrary.simpleMessage("Reklamy włączone:"),
        "add": MessageLookupByLibrary.simpleMessage("Dodaj"),
        "addAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę dozwolonych wpisów"),
        "addBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Dodaj stronę czarnej listy"),
        "addBlockedPage":
            MessageLookupByLibrary.simpleMessage("Dodaj stronę zablokowanych"),
        "addContact": MessageLookupByLibrary.simpleMessage("Dodaj kontakt"),
        "addContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę subskrypcji kontaktów"),
        "addLabelPage":
            MessageLookupByLibrary.simpleMessage("Dodaj stronę etykiet"),
        "addPluginPage":
            MessageLookupByLibrary.simpleMessage("Dodaj stronę wtyczek"),
        "addRegexPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę wyrażeń regularnych"),
        "addSmsBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę czarnej listy SMS"),
        "addSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę subskrypcji SMS"),
        "addSmsTextBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę czarnej listy tekstów SMS"),
        "addSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj strony białej listy tekstów SMS"),
        "addSmsWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Dodaj stronę białej listy SMS"),
        "addSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Dodaj stronę subskrypcji"),
        "addToAllowed":
            MessageLookupByLibrary.simpleMessage("Dodaj do dozwolonych"),
        "addToAllowedtype": m1,
        "addToBlocked":
            MessageLookupByLibrary.simpleMessage("Dodaj do zablokowanych"),
        "addToBlockedtype": m2,
        "addToLabel": MessageLookupByLibrary.simpleMessage("Dodaj do etykiety"),
        "addWhitelistsPage":
            MessageLookupByLibrary.simpleMessage("Dodaj strony białej listy"),
        "addedSuccessfully":
            MessageLookupByLibrary.simpleMessage("dodano pomyślnie"),
        "agent": MessageLookupByLibrary.simpleMessage("Agent"),
        "all": MessageLookupByLibrary.simpleMessage("Wszystkie"),
        "allowAllAllowedNumbers": MessageLookupByLibrary.simpleMessage(
            "Zezwól na wszystkie dozwolone numery"),
        "allowAllBlacklistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Zezwól na wszystkie numery z czarnej listy"),
        "allowAllWhitelistedNumbers": MessageLookupByLibrary.simpleMessage(
            "Zezwól na wszystkie numery z białej listy"),
        "allowBlockedNumbers": MessageLookupByLibrary.simpleMessage(
            "Zezwól na zablokowane numery"),
        "allowOtherNumbers":
            MessageLookupByLibrary.simpleMessage("Allow Other Numbers"),
        "allowRegexBlacklistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Zezwól na wzorce z czarnej listy wyrażeń regularnych"),
        "allowRegexWhitelistedPatterns": MessageLookupByLibrary.simpleMessage(
            "Zezwól na wzorce z białej listy wyrażeń regularnych"),
        "allowRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Zezwól na powtarzane połączenia przychodzące"),
        "allowThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Zezwól tej aplikacji na wyświetlanie identyfikacji rozmówcy"),
        "allowed": MessageLookupByLibrary.simpleMessage("Dozwolone"),
        "allowedEntryPage":
            MessageLookupByLibrary.simpleMessage("Strona dozwolonych wpisów"),
        "allowedpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony dozwolonych wpisów"),
        "answerthenhangup":
            MessageLookupByLibrary.simpleMessage("Odbierz i rozłącz"),
        "areYouSureYouWantToDeleteTheItem":
            MessageLookupByLibrary.simpleMessage(
                "Czy na pewno chcesz usunąć element"),
        "areYouSureYouWantToDeleteThisContact":
            MessageLookupByLibrary.simpleMessage(
                "Czy na pewno chcesz usunąć ten kontakt?"),
        "autoCloseLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Automatycznie zamykaj powiadomienia lokalne"),
        "autoUpdateDisabled": MessageLookupByLibrary.simpleMessage(
            "Automatyczna aktualizacja wyłączona"),
        "autoUpdateEnabled": MessageLookupByLibrary.simpleMessage(
            "Automatyczna aktualizacja włączona"),
        "autobackup": MessageLookupByLibrary.simpleMessage("AutoBackup"),
        "avatar": MessageLookupByLibrary.simpleMessage("Avatar"),
        "avatarAndIconSizes":
            MessageLookupByLibrary.simpleMessage("Rozmiary awatarów i ikon"),
        "avatarBorderColor":
            MessageLookupByLibrary.simpleMessage("Kolor obramowania awatara"),
        "avatarBorderSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar obramowania awatara"),
        "avatarPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja awatara"),
        "avatarSize": MessageLookupByLibrary.simpleMessage("Rozmiar awatara"),
        "avatarUrlOrPath": MessageLookupByLibrary.simpleMessage(
            "Adres URL lub ścieżka awatara"),
        "backgroundGradient":
            MessageLookupByLibrary.simpleMessage("Gradient tła"),
        "backup": MessageLookupByLibrary.simpleMessage("Kopia zapasowa"),
        "backupAndRestore": MessageLookupByLibrary.simpleMessage(
            "Kopia zapasowa i przywracanie"),
        "bank": MessageLookupByLibrary.simpleMessage("Bank"),
        "batteryOptimization":
            MessageLookupByLibrary.simpleMessage("Optymalizacja baterii"),
        "blacklist": MessageLookupByLibrary.simpleMessage("Czarna lista"),
        "blacklistPage":
            MessageLookupByLibrary.simpleMessage("Strona czarnej listy"),
        "blacklistingAndWhitelisting":
            MessageLookupByLibrary.simpleMessage("Czarna i biała lista"),
        "blacklistpageview":
            MessageLookupByLibrary.simpleMessage("Widok strony czarnej listy"),
        "blockCallsFromSpecificAreaCodes": MessageLookupByLibrary.simpleMessage(
            "Blokuj połączenia z określonych numerów kierunkowych:"),
        "blockInternationalCalls": MessageLookupByLibrary.simpleMessage(
            "Blokuj połączenia międzynarodowe:"),
        "blocked": MessageLookupByLibrary.simpleMessage("Zablokowane"),
        "blockedCallAction": MessageLookupByLibrary.simpleMessage(
            "Akcja dla zablokowanego połączenia"),
        "blockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Powiadomienie o zablokowanym połączeniu"),
        "blockedCalls": MessageLookupByLibrary.simpleMessage("Blocked Calls"),
        "blockedCallsStatistics": MessageLookupByLibrary.simpleMessage(
            "Statystyki zablokowanych połączeń"),
        "blockedPage":
            MessageLookupByLibrary.simpleMessage("Strona zablokowanych"),
        "blockedpageview":
            MessageLookupByLibrary.simpleMessage("Widok strony zablokowanych"),
        "bothOriginalCallAppLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Powiadomienie oryginalnej aplikacji połączeń i powiadomienie lokalne"),
        "bothOriginalSmsLocalNotification":
            MessageLookupByLibrary.simpleMessage(
                "Oryginalne powiadomienia SMS i powiadomienia lokalne"),
        "call": MessageLookupByLibrary.simpleMessage("Połączenie"),
        "callHistory":
            MessageLookupByLibrary.simpleMessage("Historia połączeń"),
        "callLog": MessageLookupByLibrary.simpleMessage("Dziennik połączeń"),
        "callLogPermissionDenied": MessageLookupByLibrary.simpleMessage(
            "Odmowa dostępu do dziennika połączeń"),
        "callScreeningRoleRequestFailed": MessageLookupByLibrary.simpleMessage(
            "Żądanie roli ekranowania połączeń nie powiodło się!"),
        "callScreeningRoleRequestSuccessful":
            MessageLookupByLibrary.simpleMessage(
                "Pomyślnie zażądano roli ekranowania połączeń!"),
        "callerIdApp": MessageLookupByLibrary.simpleMessage(
            "Aplikacja do identyfikacji rozmówcy"),
        "callerIdData": MessageLookupByLibrary.simpleMessage("Caller ID Data:"),
        "callerIdDataIsNotAvailable": MessageLookupByLibrary.simpleMessage(
            "Caller ID Data is not available"),
        "callerIdSimSource":
            MessageLookupByLibrary.simpleMessage("Caller ID SIM Source"),
        "callerIdStyle":
            MessageLookupByLibrary.simpleMessage("Styl identyfikacji rozmówcy"),
        "callerIdStyleContent": MessageLookupByLibrary.simpleMessage(
            "treść stylu identyfikacji rozmówcy"),
        "calltypeIconColor":
            MessageLookupByLibrary.simpleMessage("Kolor ikony typu połączenia"),
        "cancel": MessageLookupByLibrary.simpleMessage("anuluj"),
        "cannotFindItem":
            MessageLookupByLibrary.simpleMessage("Cannot find item"),
        "carrier": MessageLookupByLibrary.simpleMessage("Operator:"),
        "carrierColor": MessageLookupByLibrary.simpleMessage("Kolor operatora"),
        "carrierFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki operatora"),
        "carrierPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja operatora"),
        "charity":
            MessageLookupByLibrary.simpleMessage("Organizacja charytatywna"),
        "chooseAvatarLocalOrNetwork": MessageLookupByLibrary.simpleMessage(
            "Wybierz awatar (lokalny lub z sieci):"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Wybierz z galerii"),
        "chooseOnlyLinkOrFile":
            MessageLookupByLibrary.simpleMessage("Wybierz tylko link lub plik"),
        "chooseTheDefaultInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Wybierz domyślną akcję przechwytywania"),
        "chooseYourLanguage":
            MessageLookupByLibrary.simpleMessage("Wybierz język"),
        "clientId":
            MessageLookupByLibrary.simpleMessage("Identyfikator klienta"),
        "close": MessageLookupByLibrary.simpleMessage("Zamknij"),
        "cloudBackup": MessageLookupByLibrary.simpleMessage("Cloud Backup"),
        "cloudBackupDirectoryName": MessageLookupByLibrary.simpleMessage(
            "Nazwa katalogu kopii zapasowych w chmurze"),
        "cloudBackupRequiresAutoBackup": MessageLookupByLibrary.simpleMessage(
            "Kopia zapasowa w chmurze wymaga automatycznej kopii zapasowej"),
        "cloudServices":
            MessageLookupByLibrary.simpleMessage("Usługi w chmurze"),
        "collection": MessageLookupByLibrary.simpleMessage("Windykacja"),
        "configurationExportedToFile": MessageLookupByLibrary.simpleMessage(
            "Konfiguracja została wyeksportowana do pliku!"),
        "configurationImported":
            MessageLookupByLibrary.simpleMessage("Konfiguracja zaimportowana"),
        "configurationImportedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Konfiguracja została pomyślnie zaimportowana"),
        "configurationSaved":
            MessageLookupByLibrary.simpleMessage("Konfiguracja zapisana!"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Potwierdź usunięcie"),
        "contactFile": MessageLookupByLibrary.simpleMessage("Plik kontaktów"),
        "contactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Strona subskrypcji kontaktów"),
        "contactUs":
            MessageLookupByLibrary.simpleMessage("Skontaktuj się z nami"),
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakty"),
        "contactsExportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakty zostały pomyślnie wyeksportowane"),
        "contactsImportedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Kontakty zostały pomyślnie zaimportowane"),
        "contactsPage":
            MessageLookupByLibrary.simpleMessage("Strona kontaktów"),
        "contactsWithNumber":
            MessageLookupByLibrary.simpleMessage("kontakty z numerem"),
        "contactsubscription":
            MessageLookupByLibrary.simpleMessage("ContactSubscription"),
        "contactsubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Lista subskrypcji kontaktów"),
        "count": MessageLookupByLibrary.simpleMessage("Count"),
        "countColor": MessageLookupByLibrary.simpleMessage("Kolor licznika"),
        "countFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki licznika"),
        "countPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja licznika"),
        "country": MessageLookupByLibrary.simpleMessage("Kraj:"),
        "countryCode": MessageLookupByLibrary.simpleMessage("Country Code"),
        "countryName": MessageLookupByLibrary.simpleMessage("Country Name"),
        "countryNameColor":
            MessageLookupByLibrary.simpleMessage("Kolor nazwy kraju"),
        "countryNameFontSize": MessageLookupByLibrary.simpleMessage(
            "Rozmiar czcionki nazwy kraju"),
        "countryNamePosition":
            MessageLookupByLibrary.simpleMessage("Pozycja nazwy kraju"),
        "cropAvatar": MessageLookupByLibrary.simpleMessage("Przytnij awatar"),
        "customerService":
            MessageLookupByLibrary.simpleMessage("Obsługa klienta"),
        "customizeCallerId": MessageLookupByLibrary.simpleMessage(
            "Dostosuj identyfikację rozmówcy"),
        "dark": MessageLookupByLibrary.simpleMessage("Ciemny"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Tryb ciemny"),
        "days": MessageLookupByLibrary.simpleMessage("days"),
        "delete": MessageLookupByLibrary.simpleMessage("Usuń"),
        "deleteContact": MessageLookupByLibrary.simpleMessage("Usuń kontakt"),
        "deleted": MessageLookupByLibrary.simpleMessage("Usunięto"),
        "delivery": MessageLookupByLibrary.simpleMessage("Dostawa"),
        "deniedPermissionCanManuallyEnablePermissionInSetting":
            MessageLookupByLibrary.simpleMessage(
                "Odmówiłeś dostępu. Możesz ręcznie włączyć uprawnienia w Ustawieniach."),
        "descriptionFeature1": MessageLookupByLibrary.simpleMessage(
            "The app supports subscriptions from online links and plugins. Customize your own API or convert any website into a plugin to help you find caller ID information."),
        "descriptionFeature2": MessageLookupByLibrary.simpleMessage(
            "The app supports regular expressions (Regex), allowing you to customize patterns for blocking calls."),
        "descriptionFeature3": MessageLookupByLibrary.simpleMessage(
            "Import or export your database locally or online via WebDAV, Google Drive, or OneDrive."),
        "disableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Wyłącz powiadomienia o zablokowanych połączeniach"),
        "disablePermission":
            MessageLookupByLibrary.simpleMessage("Wyłącz uprawnienie"),
        "disableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Wyłącz lokalne powiadomienia SMS"),
        "disableStirNotification":
            MessageLookupByLibrary.simpleMessage("Disable Stir Notification"),
        "disableThisAppToShowCallerId": MessageLookupByLibrary.simpleMessage(
            "Nie zezwalaj tej aplikacji na wyświetlanie identyfikacji rozmówcy"),
        "disabled": MessageLookupByLibrary.simpleMessage("Wyłączone"),
        "ecommerce":
            MessageLookupByLibrary.simpleMessage("Handel elektroniczny"),
        "edit": MessageLookupByLibrary.simpleMessage("Edytuj"),
        "editAvatar": MessageLookupByLibrary.simpleMessage("Edytuj awatar"),
        "editCode": MessageLookupByLibrary.simpleMessage("Edytuj kod"),
        "editContact": MessageLookupByLibrary.simpleMessage("Edytuj kontakt"),
        "editPluginCode":
            MessageLookupByLibrary.simpleMessage("Edytuj kod wtyczki"),
        "education": MessageLookupByLibrary.simpleMessage("Edukacja"),
        "elementPositions":
            MessageLookupByLibrary.simpleMessage("Pozycje elementów"),
        "email": MessageLookupByLibrary.simpleMessage("E-mail"),
        "enableBlockedCallNotification": MessageLookupByLibrary.simpleMessage(
            "Włącz powiadomienia o zablokowanych połączeniach"),
        "enableDarkModeBasedOnTime": MessageLookupByLibrary.simpleMessage(
            "Włącz tryb ciemny w oparciu o czas"),
        "enableOverlayPermission":
            MessageLookupByLibrary.simpleMessage("Włącz uprawnienia nakładki"),
        "enableSmsLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Włącz lokalne powiadomienia SMS"),
        "enableSorting":
            MessageLookupByLibrary.simpleMessage("Enable sorting: "),
        "enableStirNotification":
            MessageLookupByLibrary.simpleMessage("Enable Stir Notification"),
        "enableToRemoveAds":
            MessageLookupByLibrary.simpleMessage("Włącz, aby usunąć reklamy"),
        "enabled": MessageLookupByLibrary.simpleMessage("Włączone"),
        "endColor": MessageLookupByLibrary.simpleMessage("Kolor końcowy"),
        "endcall": MessageLookupByLibrary.simpleMessage("Zakończ połączenie"),
        "enterCountryCode": MessageLookupByLibrary.simpleMessage(
            "Enter country code (e.g., US, CA)"),
        "enterImageUrl":
            MessageLookupByLibrary.simpleMessage("Wprowadź adres URL obrazu"),
        "enterPluginCodeHere":
            MessageLookupByLibrary.simpleMessage("Wprowadź kod wtyczki tutaj"),
        "enterUrl": MessageLookupByLibrary.simpleMessage("Wprowadź adres URL"),
        "entry": MessageLookupByLibrary.simpleMessage("Wpis"),
        "entryAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("wpis dodany pomyślnie"),
        "error": MessageLookupByLibrary.simpleMessage("Błąd"),
        "errorExportingContacts":
            MessageLookupByLibrary.simpleMessage("Błąd eksportu kontaktów:"),
        "errorGettingPermissionStatus": MessageLookupByLibrary.simpleMessage(
            "Błąd pobierania statusu uprawnień"),
        "errorImporting": MessageLookupByLibrary.simpleMessage("Błąd importu"),
        "errorRequestingCallScreeningRole":
            MessageLookupByLibrary.simpleMessage(
                "Błąd żądania roli ekranowania połączeń:"),
        "expirationDate":
            MessageLookupByLibrary.simpleMessage("Expiration date"),
        "expiryDate": MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "export": MessageLookupByLibrary.simpleMessage("Eksportuj"),
        "exportAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę dozwolonych wpisów"),
        "exportAsCsv":
            MessageLookupByLibrary.simpleMessage("Eksportuj jako CSV"),
        "exportAsJson":
            MessageLookupByLibrary.simpleMessage("Eksportuj jako JSON"),
        "exportAsVcf":
            MessageLookupByLibrary.simpleMessage("Eksportuj jako VCF"),
        "exportAsYaml":
            MessageLookupByLibrary.simpleMessage("Eksportuj jako YAML"),
        "exportBlacklistPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę czarnej listy"),
        "exportBlockedPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę zablokowanych"),
        "exportContactSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę subskrypcji kontaktów"),
        "exportContacts":
            MessageLookupByLibrary.simpleMessage("Eksportuj kontakty"),
        "exportFailed":
            MessageLookupByLibrary.simpleMessage("Eksport nie powiódł się"),
        "exportFormat":
            MessageLookupByLibrary.simpleMessage("format eksportu:"),
        "exportLabelPage":
            MessageLookupByLibrary.simpleMessage("Eksportuj stronę etykiet"),
        "exportPluginPage":
            MessageLookupByLibrary.simpleMessage("Eksportuj stronę wtyczek"),
        "exportRegexPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę wyrażeń regularnych"),
        "exportSmsBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony czarnej listy SMS"),
        "exportSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj stronę subskrypcji SMS"),
        "exportSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony czarnej listy tekstów SMS"),
        "exportSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony białej listy tekstów SMS"),
        "exportSmsWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony białej listy SMS"),
        "exportSubscriptionsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony subskrypcji"),
        "exportSuccessful": MessageLookupByLibrary.simpleMessage(
            "Eksport zakończony pomyślnie"),
        "exportWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Eksportuj strony białej listy"),
        "failed": MessageLookupByLibrary.simpleMessage("Nieudane"),
        "failedToAdd":
            MessageLookupByLibrary.simpleMessage("Nie udało się dodać:"),
        "failedToAddEntry":
            MessageLookupByLibrary.simpleMessage("Nie udało się dodać wpisu:"),
        "feature": MessageLookupByLibrary.simpleMessage("Funkcja"),
        "feature1":
            MessageLookupByLibrary.simpleMessage("Supporting Subscription"),
        "feature2": MessageLookupByLibrary.simpleMessage("Supporting Regex"),
        "feature3": MessageLookupByLibrary.simpleMessage("privacy"),
        "featureDescription":
            MessageLookupByLibrary.simpleMessage("opis funkcji"),
        "featureIntroduction":
            MessageLookupByLibrary.simpleMessage("Feature Introduction"),
        "filterIncomingSmsMessages": MessageLookupByLibrary.simpleMessage(
            "Filtruj przychodzące wiadomości SMS"),
        "filterRepeatedIncomingCalls": MessageLookupByLibrary.simpleMessage(
            "Filtruj powtarzane połączenia przychodzące"),
        "financial": MessageLookupByLibrary.simpleMessage("Finanse"),
        "firstName": MessageLookupByLibrary.simpleMessage("Imię"),
        "fraudScamLikely":
            MessageLookupByLibrary.simpleMessage("Prawdopodobne oszustwo"),
        "function": MessageLookupByLibrary.simpleMessage("Function"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Rozpocznij"),
        "googleDriveLoginFailed": MessageLookupByLibrary.simpleMessage(
            "Logowanie do Google Drive nie powiodło się"),
        "googleDriveLoginSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Logowanie do Google Drive powiodło się"),
        "googleDriveSetting":
            MessageLookupByLibrary.simpleMessage("Ustawienia Google Drive"),
        "grantPermission":
            MessageLookupByLibrary.simpleMessage("Udziel uprawnienia"),
        "group": MessageLookupByLibrary.simpleMessage("Grupa"),
        "headhunter": MessageLookupByLibrary.simpleMessage("Headhunter"),
        "height": MessageLookupByLibrary.simpleMessage("Wysokość"),
        "history": MessageLookupByLibrary.simpleMessage("Historia"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "iconSize": MessageLookupByLibrary.simpleMessage("Rozmiar ikony"),
        "ifThereIsAnErrorSelectACountry": MessageLookupByLibrary.simpleMessage(
            "if there is an error select a country"),
        "import": MessageLookupByLibrary.simpleMessage("Importuj"),
        "importAllowedEntryPage": MessageLookupByLibrary.simpleMessage(
            "Importuj stronę dozwolonych wpisów"),
        "importBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importuj strony czarnej listy"),
        "importBlockedentriesPage": MessageLookupByLibrary.simpleMessage(
            "Importuj stronę zablokowanych wpisów"),
        "importConfiguration":
            MessageLookupByLibrary.simpleMessage("Importuj konfigurację"),
        "importContacts":
            MessageLookupByLibrary.simpleMessage("Importuj kontakty"),
        "importFromCsv": MessageLookupByLibrary.simpleMessage("Importuj z CSV"),
        "importFromFile":
            MessageLookupByLibrary.simpleMessage("Importuj z pliku"),
        "importFromJson":
            MessageLookupByLibrary.simpleMessage("Importuj z JSON"),
        "importFromUrl":
            MessageLookupByLibrary.simpleMessage("Importuj z adresu URL"),
        "importFromVcf": MessageLookupByLibrary.simpleMessage("Importuj z VCF"),
        "importFromYaml":
            MessageLookupByLibrary.simpleMessage("Importuj z YAML"),
        "importLabelPage":
            MessageLookupByLibrary.simpleMessage("Importuj stronę etykiet"),
        "importPluginPage":
            MessageLookupByLibrary.simpleMessage("Importuj stronę wtyczek"),
        "importRegexPage": MessageLookupByLibrary.simpleMessage(
            "Importuj stronę wyrażeń regularnych"),
        "importSmsSubscriptionPage": MessageLookupByLibrary.simpleMessage(
            "Importuj stronę subskrypcji SMS"),
        "importSmsTextBlacklistsPage": MessageLookupByLibrary.simpleMessage(
            "Importuj strony czarnej listy tekstów SMS"),
        "importSmsTextWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importuj strony białej listy tekstów SMS"),
        "importSubscriptionsPage":
            MessageLookupByLibrary.simpleMessage("Importuj strony subskrypcji"),
        "importWhitelistsPage": MessageLookupByLibrary.simpleMessage(
            "Importuj strony białej listy"),
        "importedSuccessfullyFromUrl": MessageLookupByLibrary.simpleMessage(
            "Zaimportowano pomyślnie z adresu URL"),
        "inappPurchase":
            MessageLookupByLibrary.simpleMessage("In-app purchase"),
        "inappPurchasesEnabled":
            MessageLookupByLibrary.simpleMessage("Zakupy w aplikacji włączone"),
        "incomingCallInterceptAction": MessageLookupByLibrary.simpleMessage(
            "Akcja przechwytywania połączeń przychodzących"),
        "initializing":
            MessageLookupByLibrary.simpleMessage("Inicjalizacja..."),
        "initializingDatabase": MessageLookupByLibrary.simpleMessage(
            "Inicjalizacja bazy danych..."),
        "inputClientIdTenantId":
            MessageLookupByLibrary.simpleMessage("Input Client ID & Tenant ID"),
        "inputOnedriveCredentials": MessageLookupByLibrary.simpleMessage(
            "Wprowadź dane uwierzytelniające OneDrive"),
        "insurance": MessageLookupByLibrary.simpleMessage("Ubezpieczenie"),
        "interceptRepeatedIncomingCallsWithinTheTimeRange":
            MessageLookupByLibrary.simpleMessage(
                "Przechwytuj powtarzane połączenia przychodzące w określonym zakresie czasu"),
        "invalidJsonFormat":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowy format JSON"),
        "isNotSubscribed":
            MessageLookupByLibrary.simpleMessage("nie jest subskrybowany"),
        "isSubscribed":
            MessageLookupByLibrary.simpleMessage("jest subskrybowany"),
        "joinTheTelegramChannelAndGroupForMoreInfo":
            MessageLookupByLibrary.simpleMessage(
                "Dołącz do kanału i grupy Telegram, aby uzyskać więcej informacji"),
        "keepOnlyLatestBackup": MessageLookupByLibrary.simpleMessage(
            "Zachowaj tylko najnowszą kopię zapasową"),
        "keyword": MessageLookupByLibrary.simpleMessage("Słowo kluczowe"),
        "label": MessageLookupByLibrary.simpleMessage("Etykieta"),
        "labelIconColor":
            MessageLookupByLibrary.simpleMessage("Kolor ikony etykiety"),
        "labelPage": MessageLookupByLibrary.simpleMessage("Strona etykiet"),
        "labelpageview":
            MessageLookupByLibrary.simpleMessage("Widok strony etykiet"),
        "labelsColor": MessageLookupByLibrary.simpleMessage("Kolor etykiet"),
        "labelsFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki etykiet"),
        "labelsPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja etykiet"),
        "lastName": MessageLookupByLibrary.simpleMessage("Nazwisko"),
        "lifetimePurchase":
            MessageLookupByLibrary.simpleMessage("Lifetime Purchase"),
        "light": MessageLookupByLibrary.simpleMessage("Jasny"),
        "link": MessageLookupByLibrary.simpleMessage("Link"),
        "loading": MessageLookupByLibrary.simpleMessage("Ładowanie..."),
        "loan": MessageLookupByLibrary.simpleMessage("Pożyczka"),
        "localBackupDirectoryOnlyUnderDownloadFolder":
            MessageLookupByLibrary.simpleMessage(
                "Lokalny katalog kopii zapasowych tylko w folderze Pobrane"),
        "localCard1": MessageLookupByLibrary.simpleMessage("Lokalna karta 1"),
        "localCard1Content":
            MessageLookupByLibrary.simpleMessage("treść lokalnej karty 1"),
        "locationColor":
            MessageLookupByLibrary.simpleMessage("Kolor lokalizacji"),
        "locationFontSize": MessageLookupByLibrary.simpleMessage(
            "Rozmiar czcionki lokalizacji"),
        "locationIconColor":
            MessageLookupByLibrary.simpleMessage("Kolor ikony lokalizacji"),
        "locationPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja lokalizacji"),
        "login": MessageLookupByLibrary.simpleMessage("Zaloguj"),
        "loginFailed":
            MessageLookupByLibrary.simpleMessage("Logowanie nie powiodło się"),
        "loginGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Zaloguj Google Drive"),
        "loginlogoutGoogleDrive": MessageLookupByLibrary.simpleMessage(
            "Zaloguj/Wyloguj Google Drive"),
        "logoutGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Wyloguj Google Drive"),
        "manageRules":
            MessageLookupByLibrary.simpleMessage("Zarządzaj regułami"),
        "manualBackup":
            MessageLookupByLibrary.simpleMessage("Ręczna kopia zapasowa"),
        "manuallyDisablePermissionInAppSetting": m3,
        "markedBy": MessageLookupByLibrary.simpleMessage("Oznaczony przez"),
        "matchAnyCharacter":
            MessageLookupByLibrary.simpleMessage("Dopasuj dowolny znak:"),
        "matchFailed": MessageLookupByLibrary.simpleMessage("Match failed!"),
        "matchPhoneNumbersContainingSpecificDigits":
            MessageLookupByLibrary.simpleMessage(
                "Dopasuj numery telefonów zawierające określone cyfry:"),
        "matchPhoneNumbersWithSpecificCharactersInTheMiddle":
            MessageLookupByLibrary.simpleMessage(
                "Dopasuj numery telefonów z określonymi znakami w środku:"),
        "matchSuccessful":
            MessageLookupByLibrary.simpleMessage("Match successful!"),
        "medical": MessageLookupByLibrary.simpleMessage("Medycyna"),
        "merge": MessageLookupByLibrary.simpleMessage("Scal"),
        "mergeContacts": MessageLookupByLibrary.simpleMessage("Scal kontakty"),
        "mergeSelected":
            MessageLookupByLibrary.simpleMessage("Scal zaznaczone"),
        "message": MessageLookupByLibrary.simpleMessage("Wiadomość"),
        "mins": MessageLookupByLibrary.simpleMessage("min"),
        "monthlySubscription":
            MessageLookupByLibrary.simpleMessage("Monthly Subscription"),
        "moreAdsToGetTemporaryVipPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "more ads to get temporary VIP privileges."),
        "name": MessageLookupByLibrary.simpleMessage("Nazwa"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Nazwa nie może być pusta"),
        "nameColor": MessageLookupByLibrary.simpleMessage("Kolor nazwy"),
        "nameFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki nazwy"),
        "namePosition": MessageLookupByLibrary.simpleMessage("Pozycja nazwy"),
        "next": MessageLookupByLibrary.simpleMessage("Dalej"),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available."),
        "noImageSelected":
            MessageLookupByLibrary.simpleMessage("Nie wybrano obrazu"),
        "noIncomingSmsMessagesFilter": MessageLookupByLibrary.simpleMessage(
            "Brak filtru przychodzących wiadomości SMS"),
        "normalUser": MessageLookupByLibrary.simpleMessage("Normal User"),
        "notVerified": MessageLookupByLibrary.simpleMessage("Niezweryfikowany"),
        "notifications": MessageLookupByLibrary.simpleMessage("Powiadomienia"),
        "numberColor": MessageLookupByLibrary.simpleMessage("Kolor numeru"),
        "numberFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki numeru"),
        "numberPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja numeru"),
        "numberType": MessageLookupByLibrary.simpleMessage("Typ numeru"),
        "numberTypeColor":
            MessageLookupByLibrary.simpleMessage("Kolor typu numeru"),
        "numberTypeFontSize": MessageLookupByLibrary.simpleMessage(
            "Rozmiar czcionki typu numeru"),
        "numberTypePosition":
            MessageLookupByLibrary.simpleMessage("Pozycja typu numeru"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onedriveSetting":
            MessageLookupByLibrary.simpleMessage("Ustawienia OneDrive"),
        "onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture":
            MessageLookupByLibrary.simpleMessage(
                "One-time purchase to permanently unlock all advanced features and future updates."),
        "onlineCallerIdSubscription": MessageLookupByLibrary.simpleMessage(
            "Subskrypcja online identyfikacji rozmówcy"),
        "onlyForSupportedArea":
            MessageLookupByLibrary.simpleMessage("Only for supported Area"),
        "onlyOriginalCallAppNotification": MessageLookupByLibrary.simpleMessage(
            "Tylko powiadomienie oryginalnej aplikacji połączeń"),
        "onlyRingLocalNotification": MessageLookupByLibrary.simpleMessage(
            "Tylko dzwonek i powiadomienie lokalne"),
        "onlyUseOriginalSmsNotification": MessageLookupByLibrary.simpleMessage(
            "Używaj tylko oryginalnych powiadomień SMS"),
        "openLocalFolder":
            MessageLookupByLibrary.simpleMessage("Otwórz folder lokalny"),
        "other": MessageLookupByLibrary.simpleMessage("Inne"),
        "overlay": MessageLookupByLibrary.simpleMessage("Nakładka"),
        "overlayPermissionNotGrantedWhichMayAffectTheCallerId":
            MessageLookupByLibrary.simpleMessage(
                "Uprawnienia nakładki nie zostały udzielone, co może wpłynąć na funkcję wyświetlania identyfikacji rozmówcy. Możesz włączyć uprawnienie w ustawieniach aplikacji."),
        "page": MessageLookupByLibrary.simpleMessage("Strona"),
        "password": MessageLookupByLibrary.simpleMessage("Hasło"),
        "pasteJson": MessageLookupByLibrary.simpleMessage("Wklej JSON"),
        "pasteJsonConfiguration":
            MessageLookupByLibrary.simpleMessage("Wklej konfigurację JSON"),
        "pasteJsonHere":
            MessageLookupByLibrary.simpleMessage("Wklej JSON tutaj"),
        "pattern": MessageLookupByLibrary.simpleMessage("Wzorzec"),
        "permanentlyRemoveAllAdsInTheAppAndEnjoyA":
            MessageLookupByLibrary.simpleMessage(
                "Permanently remove all ads in the app and enjoy a clean user experience."),
        "permissionDenied":
            MessageLookupByLibrary.simpleMessage("Uprawnienie odrzucone"),
        "permissionGranted":
            MessageLookupByLibrary.simpleMessage("Uprawnienie udzielone"),
        "permissionInAppSetting": MessageLookupByLibrary.simpleMessage(
            ":Musisz ręcznie wyłączyć uprawnienie w ustawieniach aplikacji."),
        "permissionInTheAppSettings": MessageLookupByLibrary.simpleMessage(
            "uprawnienie w ustawieniach aplikacji."),
        "permissionWasNotGranted": MessageLookupByLibrary.simpleMessage(
            "uprawnienie nie zostało udzielone."),
        "permissions": MessageLookupByLibrary.simpleMessage("Uprawnienia"),
        "permissionsRequired":
            MessageLookupByLibrary.simpleMessage("Wymagane uprawnienia"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "phoneNumberTypeFixedLine":
            MessageLookupByLibrary.simpleMessage("Stacjonarna"),
        "phoneNumberTypeFixedLineOrMobile":
            MessageLookupByLibrary.simpleMessage(
                "Linia stacjonarna lub komórkowa"),
        "phoneNumberTypeMobile":
            MessageLookupByLibrary.simpleMessage("Komórkowa"),
        "phoneNumberTypePager": MessageLookupByLibrary.simpleMessage("Pager"),
        "phoneNumberTypePpersonalNumber":
            MessageLookupByLibrary.simpleMessage("Numer osobisty"),
        "phoneNumberTypePremiumRate":
            MessageLookupByLibrary.simpleMessage("Premium Rate"),
        "phoneNumberTypeSharedCost":
            MessageLookupByLibrary.simpleMessage("Współdzielone koszty"),
        "phoneNumberTypeTollFree":
            MessageLookupByLibrary.simpleMessage("Bezpłatna"),
        "phoneNumberTypeUan": MessageLookupByLibrary.simpleMessage("UAN"),
        "phoneNumberTypeUnknown":
            MessageLookupByLibrary.simpleMessage("Nieznany"),
        "phoneNumberTypeVoicemail":
            MessageLookupByLibrary.simpleMessage("Poczta głosowa"),
        "phoneNumberTypeVoip": MessageLookupByLibrary.simpleMessage("VoIP"),
        "phonenumber": MessageLookupByLibrary.simpleMessage("Numer telefonu"),
        "pleaseEnter":
            MessageLookupByLibrary.simpleMessage("Proszę wprowadzić"),
        "pleaseEnterAPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Proszę podać numer telefonu"),
        "pleaseEnterAPhoneNumberAndRegexPattern":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a phone number and regex pattern"),
        "pleaseEnterARegexPattern": MessageLookupByLibrary.simpleMessage(
            "Please enter a regex pattern"),
        "pleaseEnterAnPattern":
            MessageLookupByLibrary.simpleMessage("Proszę wprowadzić wzorzec"),
        "pleaseEnterAnUrl":
            MessageLookupByLibrary.simpleMessage("Proszę wprowadzić adres URL"),
        "pleaseSelectAFileOrInputAUrl": MessageLookupByLibrary.simpleMessage(
            "Proszę wybrać plik lub wprowadzić adres URL"),
        "pleaseSelectALabel":
            MessageLookupByLibrary.simpleMessage("Proszę wybrać etykietę"),
        "pleaseSelectAnExportFolder": MessageLookupByLibrary.simpleMessage(
            "Proszę wybrać folder eksportu"),
        "pleaseSelectAnOutputFile": MessageLookupByLibrary.simpleMessage(
            "Proszę wybrać plik wyjściowy:"),
        "pleaseSelectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Proszę wybrać wpisy do wyeksportowania"),
        "pleaseTapGrantPermissionAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Proszę dotknąć \"Udziel uprawnienia\" i zezwolić na uprawnienie na następnym ekranie."),
        "pleaseTapSetupDefaultAndAllowThePermissionInThe":
            MessageLookupByLibrary.simpleMessage(
                "Proszę dotknąć \"Ustaw jako domyślną\" i zezwolić na uprawnienie na następnym ekranie."),
        "pleaseWaitForDatabaseInitializationToComplete":
            MessageLookupByLibrary.simpleMessage(
                "Proszę czekać na zakończenie inicjalizacji bazy danych."),
        "pluginData": MessageLookupByLibrary.simpleMessage("Plugin Data:"),
        "pluginPage": MessageLookupByLibrary.simpleMessage("Strona wtyczek"),
        "plugins": MessageLookupByLibrary.simpleMessage("Wtyczki"),
        "pluginspageview":
            MessageLookupByLibrary.simpleMessage("Widok strony wtyczek"),
        "pluginupdate": MessageLookupByLibrary.simpleMessage("PluginUpdate"),
        "political": MessageLookupByLibrary.simpleMessage("Polityka"),
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
        "recruiter": MessageLookupByLibrary.simpleMessage("Recruiter"),
        "regex": MessageLookupByLibrary.simpleMessage("Wyrażenie regularne"),
        "regexPage":
            MessageLookupByLibrary.simpleMessage("Strona wyrażeń regularnych"),
        "regexPattern": MessageLookupByLibrary.simpleMessage("Regex Pattern"),
        "regexPatternExplanation": MessageLookupByLibrary.simpleMessage(
            "Wyjaśnienie wzorca wyrażenia regularnego"),
        "regexPatternTest":
            MessageLookupByLibrary.simpleMessage("Regex Pattern Test"),
        "regexPatternsAreRegularExpressionsUsedToMatchPhoneNumbers":
            MessageLookupByLibrary.simpleMessage(
                "Wzorce wyrażeń regularnych to wyrażenia regularne używane do dopasowywania numerów telefonów."),
        "regexPhoneNumberTest":
            MessageLookupByLibrary.simpleMessage("Regex Phone Number Test"),
        "regexpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony wyrażeń regularnych"),
        "region": MessageLookupByLibrary.simpleMessage("Region:"),
        "reject": MessageLookupByLibrary.simpleMessage("Odrzuć"),
        "rejectAllNumbers":
            MessageLookupByLibrary.simpleMessage("Odrzuć wszystkie numery"),
        "remove": MessageLookupByLibrary.simpleMessage("Usuń"),
        "removeAds": MessageLookupByLibrary.simpleMessage("Remove Ads"),
        "removeAdsAndEnableOnlineBackup": MessageLookupByLibrary.simpleMessage(
            "Usuń reklamy i włącz kopię zapasową online"),
        "removeAllowed":
            MessageLookupByLibrary.simpleMessage("Usuń z dozwolonych"),
        "removeAllowedtype": m4,
        "removeBlocked":
            MessageLookupByLibrary.simpleMessage("Usuń z zablokowanych"),
        "removeBlockedtype": m5,
        "repeatedBlockedCallsIn": MessageLookupByLibrary.simpleMessage(
            "Powtarzane zablokowane połączenia w ciągu"),
        "repeatedCalls":
            MessageLookupByLibrary.simpleMessage("Powtarzane połączenia"),
        "restoreFromGoogleDrive":
            MessageLookupByLibrary.simpleMessage("Przywróć z Google Drive"),
        "restoreFromLocal":
            MessageLookupByLibrary.simpleMessage("Przywróć z lokalizacji"),
        "restoreFromOnedrive":
            MessageLookupByLibrary.simpleMessage("Przywróć z OneDrive"),
        "restoreFromWebdav":
            MessageLookupByLibrary.simpleMessage("Przywróć z WebDAV"),
        "restorePurchase":
            MessageLookupByLibrary.simpleMessage("Restore Purchase"),
        "ridesharing":
            MessageLookupByLibrary.simpleMessage("Współdzielenie przejazdów"),
        "risk": MessageLookupByLibrary.simpleMessage("Ryzyko"),
        "robocall":
            MessageLookupByLibrary.simpleMessage("Automatyczne połączenie"),
        "save": MessageLookupByLibrary.simpleMessage("Zapisz"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchContacts":
            MessageLookupByLibrary.simpleMessage("Szukaj kontaktów"),
        "searchEntries": MessageLookupByLibrary.simpleMessage("Szukaj wpisów"),
        "selectALabel":
            MessageLookupByLibrary.simpleMessage("Wybierz etykietę:"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Zaznacz wszystko"),
        "selectColor": MessageLookupByLibrary.simpleMessage("Wybierz kolor"),
        "selectCountryCodeOptional": MessageLookupByLibrary.simpleMessage(
            "Wybierz kod kraju (opcjonalnie)"),
        "selectEntries": MessageLookupByLibrary.simpleMessage("Wybierz wpisy"),
        "selectEntriesToExport": MessageLookupByLibrary.simpleMessage(
            "Wybierz wpisy do wyeksportowania"),
        "selectedContactsMergedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Zaznaczone kontakty zostały pomyślnie scalone"),
        "selectedLabel":
            MessageLookupByLibrary.simpleMessage("Wybrana etykieta"),
        "selectingExportFolder":
            MessageLookupByLibrary.simpleMessage("wybieranie folderu eksportu"),
        "service": MessageLookupByLibrary.simpleMessage("Service"),
        "serviceUpdateIntervalsDays": MessageLookupByLibrary.simpleMessage(
            "Interwały aktualizacji usługi (dni)"),
        "settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
        "settingsSaved":
            MessageLookupByLibrary.simpleMessage("Ustawienia zapisane"),
        "setupDefault":
            MessageLookupByLibrary.simpleMessage("Ustaw jako domyślną"),
        "setupDefaultCallerIdApp": MessageLookupByLibrary.simpleMessage(
            "Ustaw domyślną aplikację do identyfikacji rozmówcy"),
        "sharing": MessageLookupByLibrary.simpleMessage("Udostępnianie"),
        "showContactButton":
            MessageLookupByLibrary.simpleMessage("Pokaż przycisk kontaktu"),
        "showContactIconButton": MessageLookupByLibrary.simpleMessage(
            "Pokaż przycisk ikony kontaktu"),
        "showTelegram": MessageLookupByLibrary.simpleMessage("Pokaż Telegram"),
        "showWhatsapp": MessageLookupByLibrary.simpleMessage("Pokaż WhatsApp"),
        "showingResultsFor":
            MessageLookupByLibrary.simpleMessage("Wyświetlanie wyników dla"),
        "showingSearchResultsFor":
            MessageLookupByLibrary.simpleMessage("Showing search results for"),
        "silencenoanswer":
            MessageLookupByLibrary.simpleMessage("Cisza bez odpowiedzi"),
        "silentCallvoiceClone":
            MessageLookupByLibrary.simpleMessage("Silent Call(Voice Clone?)"),
        "simCardColor": MessageLookupByLibrary.simpleMessage("Kolor karty SIM"),
        "simCardFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki karty SIM"),
        "simCardPosition":
            MessageLookupByLibrary.simpleMessage("Pozycja karty SIM"),
        "skip": MessageLookupByLibrary.simpleMessage("Pomiń"),
        "sms": MessageLookupByLibrary.simpleMessage("SMS"),
        "smsBlacklist": MessageLookupByLibrary.simpleMessage("SMS Blacklist"),
        "smsBlacklistPage":
            MessageLookupByLibrary.simpleMessage("Strona czarnej listy SMS"),
        "smsFiltering":
            MessageLookupByLibrary.simpleMessage("Filtrowanie SMS-ów"),
        "smsFilteringRequiresSmsNotificationAndPhonePermissionsPleaseGrant":
            MessageLookupByLibrary.simpleMessage(
                "Filtrowanie SMS-ów wymaga uprawnień do SMS-ów, powiadomień i telefonu. Proszę udzielić tych uprawnień, aby włączyć tę funkcję."),
        "smsLocalNotification":
            MessageLookupByLibrary.simpleMessage("Lokalne powiadomienie SMS"),
        "smsNotification":
            MessageLookupByLibrary.simpleMessage("Powiadomienie SMS"),
        "smsSubscribe": MessageLookupByLibrary.simpleMessage("SMS Subscribe"),
        "smsSubscriptionPage":
            MessageLookupByLibrary.simpleMessage("Strona subskrypcji SMS"),
        "smsTextBlacklist":
            MessageLookupByLibrary.simpleMessage("SMS Text Blacklist"),
        "smsTextWhitelistPage": MessageLookupByLibrary.simpleMessage(
            "Strona białej listy tekstów SMS"),
        "smsTextwhitelist":
            MessageLookupByLibrary.simpleMessage("SMS TextWhitelist"),
        "smsWhitelist": MessageLookupByLibrary.simpleMessage("SMS Whitelist"),
        "smsblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony czarnej listy SMS"),
        "smssubscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Lista subskrypcji SMS"),
        "smstextblacklistpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony czarnej listy tekstów SMS"),
        "smstextwhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony białej listy tekstów SMS"),
        "smswhitelistpageview": MessageLookupByLibrary.simpleMessage(
            "Widok strony białej listy SMS"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by: "),
        "spamLikely":
            MessageLookupByLibrary.simpleMessage("Prawdopodobny spam"),
        "startColor": MessageLookupByLibrary.simpleMessage("Kolor początkowy"),
        "statisticsTimeRangeMinutes": MessageLookupByLibrary.simpleMessage(
            "Zakres czasu statystyk (minuty):"),
        "stirColor": MessageLookupByLibrary.simpleMessage("Kolor Stir"),
        "stirFontSize":
            MessageLookupByLibrary.simpleMessage("Rozmiar czcionki Stir"),
        "stirNotification":
            MessageLookupByLibrary.simpleMessage("Stir Notification"),
        "stirPosition": MessageLookupByLibrary.simpleMessage("Pozycja Stir"),
        "stirRecognition":
            MessageLookupByLibrary.simpleMessage("STIR Recognition"),
        "storage": MessageLookupByLibrary.simpleMessage("Pamięć"),
        "subscribe": MessageLookupByLibrary.simpleMessage("Subskrybuj"),
        "subscribed": MessageLookupByLibrary.simpleMessage("Subskrybowane"),
        "subscribedLink":
            MessageLookupByLibrary.simpleMessage("Subskrybowany link"),
        "subscriptionListPage":
            MessageLookupByLibrary.simpleMessage("Strona listy subskrypcji"),
        "subscriptionValid":
            MessageLookupByLibrary.simpleMessage("Subscription valid"),
        "subscriptionlistview":
            MessageLookupByLibrary.simpleMessage("Lista subskrypcji"),
        "subscriptionmodel":
            MessageLookupByLibrary.simpleMessage("SubscriptionModel"),
        "successful": MessageLookupByLibrary.simpleMessage("Successful"),
        "successfully": MessageLookupByLibrary.simpleMessage("pomyślnie"),
        "survey": MessageLookupByLibrary.simpleMessage("Ankieta"),
        "sync": MessageLookupByLibrary.simpleMessage("Synchronizuj"),
        "system": MessageLookupByLibrary.simpleMessage("Systemowy"),
        "takeaway": MessageLookupByLibrary.simpleMessage("Na wynos"),
        "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
        "telemarketing": MessageLookupByLibrary.simpleMessage("Telemarketing"),
        "temporaryPurchasePrivilegeHasExpired":
            MessageLookupByLibrary.simpleMessage(
                "Temporary purchase privilege has expired"),
        "temporaryVipObtained":
            MessageLookupByLibrary.simpleMessage("Temporary VIP obtained"),
        "temporaryVipUser":
            MessageLookupByLibrary.simpleMessage("Temporary VIP User"),
        "tenantId": MessageLookupByLibrary.simpleMessage("Tenant ID"),
        "test": MessageLookupByLibrary.simpleMessage("Test"),
        "testCallerIdOverlay":
            MessageLookupByLibrary.simpleMessage("Test Caller ID Overlay"),
        "textLabelColors":
            MessageLookupByLibrary.simpleMessage("Kolory tekstu i etykiet"),
        "textType": MessageLookupByLibrary.simpleMessage("Typ tekstu"),
        "theTranslationIsNotYetComplete": MessageLookupByLibrary.simpleMessage(
            "The translation is not yet complete, and all translations are currently done by AI. If your language is not supported, or if you find any errors or missing translations, please click this here."),
        "thisAppIsAPowerfulCallerIdToolThatAllows":
            MessageLookupByLibrary.simpleMessage(
                "Ta aplikacja to potężne narzędzie do identyfikacji rozmówcy, które pozwala identyfikować nieznanych rozmówców i blokować niechciane połączenia. Jej funkcje to:"),
        "thisAppNeedsAccessToYourCallLogInformation":
            MessageLookupByLibrary.simpleMessage(
                "Ta aplikacja potrzebuje dostępu do informacji o dzienniku połączeń, aby działać poprawnie. Proszę udzielić uprawnienia."),
        "thisPermissionIsRequiredForOurAppToBeThe":
            MessageLookupByLibrary.simpleMessage(
                "To uprawnienie jest wymagane, aby nasza aplikacja była domyślną aplikacją do identyfikacji rozmówcy."),
        "thisPermissionIsRequiredForOurAppToDisplayImportant":
            MessageLookupByLibrary.simpleMessage(
                "To uprawnienie jest wymagane, aby nasza aplikacja mogła wyświetlać ważne informacje na wierzchu innych aplikacji.\\n\\n"),
        "toTestRules": MessageLookupByLibrary.simpleMessage("To test rules"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "translation": MessageLookupByLibrary.simpleMessage("Translation"),
        "tutorial": MessageLookupByLibrary.simpleMessage("Samouczek"),
        "unknown": MessageLookupByLibrary.simpleMessage("Nieznany"),
        "unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every month, including exclusive content and removing Ads."),
        "unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice":
            MessageLookupByLibrary.simpleMessage(
                "Unlock premium features every quarter and enjoy a better price."),
        "unsubscribed":
            MessageLookupByLibrary.simpleMessage("Niesubskrybowane"),
        "url": MessageLookupByLibrary.simpleMessage("Adres URL"),
        "urlFormatIsIncorrect": MessageLookupByLibrary.simpleMessage(
            "Nieprawidłowy format adresu URL"),
        "useNetworkImage":
            MessageLookupByLibrary.simpleMessage("Użyj obrazu z sieci"),
        "useTheCharacterToMatchAnySingleCharacterforExampleThe":
            MessageLookupByLibrary.simpleMessage(
                "Użyj znaku \'.\' do dopasowania dowolnego pojedynczego znaku. Na przykład wzorzec \'123.456\' pasuje do \'123-456\', \'123.456\', \'123a456\' itp."),
        "useThePattern0d23ToMatchPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Użyj wzorca \'^0[0-9]{2,3}\' do dopasowania numerów telefonów zaczynających się od \'0\', a następnie 2 lub 3 cyfr, co zazwyczaj reprezentuje numer kierunkowy.\nUżyj wzorca \'^010\' do zablokowania połączeń z numeru kierunkowego Pekinu (010).\nUżyj wzorca \'^202\' do zablokowania połączeń z numeru kierunkowego Waszyngtonu (202).\nZastąp numer kierunkowy \'^0[0-9]{2,3}\' konkretnym numerem, który chcesz zablokować."),
        "useThePatternD3d4d4ToMatchPhoneNumbersInThe":
            MessageLookupByLibrary.simpleMessage(
                "Użyj wzorca \'[0-9]{3}-[0-9]{4}-[0-9]{4}\' do dopasowania numerów telefonów w formacie \'XXX-XXXX-XXXX\'. Zastąp \'X\' konkretnymi cyframi, które chcesz dopasować."),
        "useThePatternD3d4d4ToMatchPhoneNumbersWithHyphens":
            MessageLookupByLibrary.simpleMessage(
                "Use the pattern \'^170 [0-9]{3} 656 [0-9]{2}\$\'to match phone numbers. ^: Matches the beginning of the string.505: Matches the literal string \'505\'. \'\' Matches a single space character. \'[0-9]{3}\': Matches exactly three digits (0-9).\'\' Matches a single space character.656: Matches the literal string \'656\'.\'[0-9]{1}\': Matches exactly one digit (0-9).\'\$\' (optional): Matches the end of the string (only if you need a full string match)."),
        "useThePatternToMatchAllPhoneNumbersStartingWith":
            MessageLookupByLibrary.simpleMessage(
                "Użyj wzorca \'^\\+\' do dopasowania wszystkich numerów telefonów zaczynających się od znaku plus, który zazwyczaj wskazuje na numer międzynarodowy."),
        "userName": MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
        "verificationPageRules":
            MessageLookupByLibrary.simpleMessage("Verification Page (Rules)"),
        "verificationResultsRules": MessageLookupByLibrary.simpleMessage(
            "Verification Results (shouldAcceptCall Rules):"),
        "verified": MessageLookupByLibrary.simpleMessage("Zweryfikowany"),
        "verify": MessageLookupByLibrary.simpleMessage("Verify"),
        "verifyPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Verify Phone Number"),
        "video": MessageLookupByLibrary.simpleMessage("Wideo"),
        "vipUser": MessageLookupByLibrary.simpleMessage("VIP User"),
        "watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures":
            MessageLookupByLibrary.simpleMessage(
                "Watch a short ad to temporarily unlock some advanced features."),
        "watchAd": MessageLookupByLibrary.simpleMessage("Watch Ad"),
        "watchAdsToGetTemporaryPrivileges":
            MessageLookupByLibrary.simpleMessage(
                "Watch Ads to Get Temporary Privileges"),
        "webdav": MessageLookupByLibrary.simpleMessage("Ustawienia WebDAV"),
        "webdavUrl": MessageLookupByLibrary.simpleMessage("Adres URL WebDAV"),
        "website": MessageLookupByLibrary.simpleMessage("Strona internetowa"),
        "weeklyBlockedCallsSummary": MessageLookupByLibrary.simpleMessage(
            "Weekly Blocked Calls Summary"),
        "whatsapp": MessageLookupByLibrary.simpleMessage("WhatsApp"),
        "whitelist": MessageLookupByLibrary.simpleMessage("Biała lista"),
        "whitelistPage":
            MessageLookupByLibrary.simpleMessage("Strona białej listy"),
        "whitelistpageview":
            MessageLookupByLibrary.simpleMessage("Widok strony białej listy"),
        "width": MessageLookupByLibrary.simpleMessage("Szerokość"),
        "wildcardSupportForFlexibleFiltering":
            MessageLookupByLibrary.simpleMessage(
                "Obsługa symboli wieloznacznych dla elastycznego filtrowania"),
        "windowSize": MessageLookupByLibrary.simpleMessage("Rozmiar okna"),
        "youAlreadyHaveTemporaryPrivilegesExpiryDate":
            MessageLookupByLibrary.simpleMessage(
                "You already have temporary privileges. Expiry date"),
        "youCanUseStandardRegularExpressionSyntaxToDefinePatterns":
            MessageLookupByLibrary.simpleMessage(
                "Możesz użyć standardowej składni wyrażeń regularnych do definiowania wzorców lub poprosić AI o wygenerowanie wzorca dla Flutter."),
        "youHaveDeniedPermissionYouCanManuallyEnablePermissionIn":
            MessageLookupByLibrary.simpleMessage(
                "Odmówiłeś dostępu. Możesz ręcznie włączyć uprawnienia w Ustawieniach."),
        "youHaveEnabledThePermission":
            MessageLookupByLibrary.simpleMessage("Włączyłeś uprawnienie."),
        "youHaveObtainedTemporaryPurchasePrivilegesFor":
            MessageLookupByLibrary.simpleMessage(
                "You have obtained temporary purchase privileges for"),
        "youHaveVipPrivilegesExceptForTurningOffAds":
            MessageLookupByLibrary.simpleMessage(
                "You have VIP privileges except for turning off ads."),
        "youNeedToManuallyDisableThe":
            MessageLookupByLibrary.simpleMessage("Musisz ręcznie wyłączyć"),
        "youNeedToManuallyDisableThePermissionnamePermissionInThe": m6,
        "youNeedToWatch":
            MessageLookupByLibrary.simpleMessage("You need to watch")
      };
}
