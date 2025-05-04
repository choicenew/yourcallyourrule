import 'package:flutter/material.dart';

class LocaleConfig {
  final String languageCode;
  final String countryCode;

  LocaleConfig({
    required this.languageCode,
    required this.countryCode,
  });

  factory LocaleConfig.fromMap(Map<String, dynamic> map) {
    return LocaleConfig(
      languageCode: map['languageCode'] ?? 'en',
      countryCode: map['countryCode'] ?? 'US',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'languageCode': languageCode,
      'countryCode': countryCode,
    };
  }

  Locale get locale => Locale(languageCode, countryCode);
}