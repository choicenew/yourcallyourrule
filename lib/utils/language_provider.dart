import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final asyncPrefs = SharedPreferencesAsync();
    final savedLanguageCode = await asyncPrefs.getString('languageCode');
    final savedCountryCode = await asyncPrefs.getString('countryCode');
    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode, savedCountryCode);
      notifyListeners();
    }
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();

      final asyncPrefs = SharedPreferencesAsync();
      await asyncPrefs.setString('languageCode', newLocale.languageCode);
      await asyncPrefs.setString('countryCode', newLocale.countryCode ?? ''); // Save empty string if countryCode is null
    }
  }
}

