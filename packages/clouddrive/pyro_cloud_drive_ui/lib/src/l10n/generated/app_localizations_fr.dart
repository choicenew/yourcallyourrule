// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get cloudSettingsTitle => 'Paramètres Cloud & Synchro';

  @override
  String get encryptionTitle => 'Chiffrement de bout en bout (E2EE)';

  @override
  String get encryptionSubtitle =>
      'Chiffrer toutes les sauvegardes avec AES-256 avant le téléchargement';

  @override
  String get encryptionEnabled => 'Activé (AES-256)';

  @override
  String get encryptionDisabled => 'Désactivé';

  @override
  String get configuredDrives => 'Disques cloud configurés';

  @override
  String get noDrivesRegistered => 'Aucun disque cloud connecté';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get saveAndEnable => 'Enregistrer & Activer';

  @override
  String get setPasswordTitle => 'Définir le mot de passe maître E2EE';

  @override
  String get setPasswordDescription =>
      'Vos sauvegardes seront chiffrées avec AES-256 avant l\'upload.';

  @override
  String get masterPasswordLabel => 'Mot de passe maître';

  @override
  String get passwordEmptyError => 'Le mot de passe ne peut pas être vide';

  @override
  String get syncNow => 'Synchroniser';

  @override
  String get settings => 'Paramètres';

  @override
  String get connected => 'Connecté';

  @override
  String get disconnected => 'Déconnecté';

  @override
  String lastSynced(String time) {
    return 'Dernière synchro : $time';
  }
}
