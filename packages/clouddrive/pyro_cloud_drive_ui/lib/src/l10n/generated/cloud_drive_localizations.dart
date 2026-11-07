import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'cloud_drive_localizations_en.dart';
import 'cloud_drive_localizations_zh.dart';

export 'cloud_drive_localizations_en.dart';
export 'cloud_drive_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CloudDriveLocalizations
/// returned by `CloudDriveLocalizations.of(context)`.
///
/// Applications need to include `CloudDriveLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/cloud_drive_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CloudDriveLocalizations.localizationsDelegates,
///   supportedLocales: CloudDriveLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the CloudDriveLocalizations.supportedLocales
/// property.
abstract class CloudDriveLocalizations {
  CloudDriveLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CloudDriveLocalizations? of(BuildContext context) {
    return Localizations.of<CloudDriveLocalizations>(
        context, CloudDriveLocalizations);
  }

  static const LocalizationsDelegate<CloudDriveLocalizations> delegate =
      _CloudDriveLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @cloudSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud Drive Settings'**
  String get cloudSettingsTitle;

  /// No description provided for @encryptionTitle.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encryption'**
  String get encryptionTitle;

  /// No description provided for @encryptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Encrypt backups and sync data with master password'**
  String get encryptionSubtitle;

  /// No description provided for @encryptionEnabled.
  ///
  /// In en, this message translates to:
  /// **'End-to-end encryption enabled'**
  String get encryptionEnabled;

  /// No description provided for @encryptionDisabled.
  ///
  /// In en, this message translates to:
  /// **'Encryption disabled'**
  String get encryptionDisabled;

  /// No description provided for @configuredDrives.
  ///
  /// In en, this message translates to:
  /// **'Configured Drives'**
  String get configuredDrives;

  /// No description provided for @noDrivesRegistered.
  ///
  /// In en, this message translates to:
  /// **'No cloud drives connected yet'**
  String get noDrivesRegistered;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveAndEnable.
  ///
  /// In en, this message translates to:
  /// **'Save & Enable'**
  String get saveAndEnable;

  /// No description provided for @setPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Master Password'**
  String get setPasswordTitle;

  /// No description provided for @setPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'This password will be used to encrypt/decrypt all cloud sync backups'**
  String get setPasswordDescription;

  /// No description provided for @masterPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Master Password'**
  String get masterPasswordLabel;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordEmptyError;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// Last synced time
  ///
  /// In en, this message translates to:
  /// **'Last synced: {time}'**
  String lastSynced(String time);
}

class _CloudDriveLocalizationsDelegate
    extends LocalizationsDelegate<CloudDriveLocalizations> {
  const _CloudDriveLocalizationsDelegate();

  @override
  Future<CloudDriveLocalizations> load(Locale locale) {
    return SynchronousFuture<CloudDriveLocalizations>(
        lookupCloudDriveLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_CloudDriveLocalizationsDelegate old) => false;
}

CloudDriveLocalizations lookupCloudDriveLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return CloudDriveLocalizationsEn();
    case 'zh':
      return CloudDriveLocalizationsZh();
  }

  throw FlutterError(
      'CloudDriveLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
