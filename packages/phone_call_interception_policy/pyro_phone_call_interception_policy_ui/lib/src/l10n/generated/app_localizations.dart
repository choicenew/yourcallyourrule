import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
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

  /// No description provided for @actionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get actionAllow;

  /// No description provided for @actionAnswerThenHangup.
  ///
  /// In en, this message translates to:
  /// **'Answer & Hangup'**
  String get actionAnswerThenHangup;

  /// No description provided for @actionSilence.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get actionSilence;

  /// No description provided for @actionEndCall.
  ///
  /// In en, this message translates to:
  /// **'End Call'**
  String get actionEndCall;

  /// No description provided for @labelPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Label Interception Rules'**
  String get labelPolicyTitle;

  /// No description provided for @labelPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Execute custom interception actions based on caller identity tags'**
  String get labelPolicySubtitle;

  /// No description provided for @noConfiguredLabels.
  ///
  /// In en, this message translates to:
  /// **'No custom label actions configured. Global default action will apply.'**
  String get noConfiguredLabels;

  /// No description provided for @deleteRuleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete this rule'**
  String get deleteRuleTooltip;

  /// No description provided for @addLabelRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Label Action Rule'**
  String get addLabelRuleTitle;

  /// No description provided for @selectExistingLabel.
  ///
  /// In en, this message translates to:
  /// **'Select existing tag:'**
  String get selectExistingLabel;

  /// No description provided for @pleaseSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Please select a tag'**
  String get pleaseSelectLabel;

  /// No description provided for @customLabelName.
  ///
  /// In en, this message translates to:
  /// **'Custom Tag Name'**
  String get customLabelName;

  /// No description provided for @customLabelHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Spam, Telemarketing, Delivery, Support'**
  String get customLabelHint;

  /// No description provided for @selectActionPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select action when tag matches:'**
  String get selectActionPrompt;

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

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @emergencyExemptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Exemption Guard'**
  String get emergencyExemptionTitle;

  /// No description provided for @emergencyExemptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Temporarily allow all incoming calls unconditionally after calling emergency services'**
  String get emergencyExemptionSubtitle;

  /// No description provided for @emergencyExemptionActiveWithTime.
  ///
  /// In en, this message translates to:
  /// **'Emergency exemption active ({minutes} min remaining)'**
  String emergencyExemptionActiveWithTime(int minutes);

  /// No description provided for @emergencyExemptionActive.
  ///
  /// In en, this message translates to:
  /// **'Emergency exemption active. Incoming calls will connect unconditionally.'**
  String get emergencyExemptionActive;

  /// No description provided for @durationTitle.
  ///
  /// In en, this message translates to:
  /// **'Exemption Duration Window'**
  String get durationTitle;

  /// No description provided for @durationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Time window to keep allowing incoming calls after emergency dial'**
  String get durationSubtitle;

  /// No description provided for @duration15Min.
  ///
  /// In en, this message translates to:
  /// **'15 minutes'**
  String get duration15Min;

  /// No description provided for @duration30Min.
  ///
  /// In en, this message translates to:
  /// **'30 minutes (Recommended)'**
  String get duration30Min;

  /// No description provided for @duration1Hour.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get duration1Hour;

  /// No description provided for @duration2Hours.
  ///
  /// In en, this message translates to:
  /// **'2 hours'**
  String get duration2Hours;

  /// No description provided for @customEmergencyNumbers.
  ///
  /// In en, this message translates to:
  /// **'Custom Emergency Numbers ({count})'**
  String customEmergencyNumbers(int count);

  /// No description provided for @customEmergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add local EMS, community security, family emergency numbers'**
  String get customEmergencySubtitle;

  /// No description provided for @addEmergencyNumberButton.
  ///
  /// In en, this message translates to:
  /// **'Add Number'**
  String get addEmergencyNumberButton;

  /// No description provided for @addEmergencyNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Emergency Number'**
  String get addEmergencyNumberTitle;

  /// No description provided for @addEmergencyNumberDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter local emergency contact numbers (community rescue, station, dispatch, etc.):'**
  String get addEmergencyNumberDesc;

  /// No description provided for @emergencyPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency Phone Number'**
  String get emergencyPhoneLabel;

  /// No description provided for @emergencyPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 911, 112, 999, 120'**
  String get emergencyPhoneHint;

  /// No description provided for @noCustomEmergencyNumbers.
  ///
  /// In en, this message translates to:
  /// **'No custom emergency numbers added yet. Tap top right to add.'**
  String get noCustomEmergencyNumbers;

  /// No description provided for @viewGlobalPresetNumbers.
  ///
  /// In en, this message translates to:
  /// **'View Global Built-in Emergency Directory ({count})'**
  String viewGlobalPresetNumbers(int count);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
