import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/language/config/locale_config.dart';

import 'package:yourcallyourrule/features/language/services/locale_service.dart';

class LocaleProvider with ChangeNotifier {
  final LocaleService _localeService;
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  LocaleProvider(this._localeService) {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final config = await _localeService.loadConfig();
    _locale = config.locale;
    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
      await _localeService.saveConfig(LocaleConfig(
        languageCode: newLocale.languageCode,
        countryCode: newLocale.countryCode ?? 'US',
      ));
    }
  }
}

