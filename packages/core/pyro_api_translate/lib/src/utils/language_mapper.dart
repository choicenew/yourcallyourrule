import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

/// Represents a language supported by the translation engine.
class SupportedLanguage {
  /// Primary standard ISO or generic code (e.g. 'zh', 'en', 'ja', 'ko', 'fr', 'de')
  final String code;

  /// Human readable localized display name (e.g. '中文', '英语', '日本語')
  final String name;

  /// Mapping from provider name to provider-specific code
  final Map<String, String> providerCodes;

  const SupportedLanguage({
    required this.code,
    required this.name,
    this.providerCodes = const {},
  });
}

class LanguageMapper {
  static Map<String, Map<String, String>> _parsedMap = {};
  static final List<SupportedLanguage> _supportedLanguages = [];
  static final Map<String, String> _codeToName = {};
  static final Set<String> _autoSupportedProviders = {};
  static bool _isInitialized = false;

  /// Ensures the language map is loaded from assets.
  static Future<void> ensureInitialized() async {
    if (_isInitialized) return;

    String? jsonString;
    try {
      jsonString = await rootBundle.loadString(
          'packages/pyro_api_translate/assets/supported_languages.json');
    } catch (_) {
      // Fallback for non-Flutter environment (e.g. pure Dart tests)
      try {
        var file =
            File('packages/pyro_api_translate/assets/supported_languages.json');
        if (!file.existsSync()) {
          file = File('assets/supported_languages.json');
        }
        if (file.existsSync()) {
          jsonString = await file.readAsString();
        }
      } catch (e) {
        print('LanguageMapper: File fallback failed: $e');
      }
    }

    if (jsonString != null) {
      try {
        final dynamic jsonData = jsonDecode(jsonString);
        _parsedMap = {};
        _supportedLanguages.clear();
        _codeToName.clear();
        _autoSupportedProviders.clear();

        if (jsonData is List) {
          for (var item in jsonData) {
            if (item is Map) {
              if (item.containsKey('_meta')) continue;

              final String? name = item['Value']?.toString();
              if (name == null) continue;

              if (name == '自动' || name == 'auto') {
                item.forEach((k, v) {
                  if (k != 'Value' && v != null && v.toString().isNotEmpty) {
                    _autoSupportedProviders.add(k.toString().toLowerCase());
                  }
                });
                continue;
              }

              final rowMap = <String, String>{};
              item.forEach((k, v) {
                if (v != null && v.toString().isNotEmpty) {
                  rowMap[k.toString()] = v.toString();
                }
              });

              // Extract primary code for this language entry
              final String primaryCode = _determinePrimaryCode(rowMap);

              // Register language info
              final langInfo = SupportedLanguage(
                code: primaryCode,
                name: name,
                providerCodes: rowMap,
              );
              _supportedLanguages.add(langInfo);

              // Ensure primary code has highest priority mapping for this entry
              final String lowerPrimary = primaryCode.toLowerCase();
              _parsedMap[lowerPrimary] = rowMap;
              _codeToName[lowerPrimary] = name;

              // Index each provider code without overwriting primary bindings
              rowMap.forEach((key, val) {
                if (key == 'Value') return;
                final lowerCode = val.toLowerCase();
                if (!_parsedMap.containsKey(lowerCode)) {
                  _parsedMap[lowerCode] = rowMap;
                }
                if (!_codeToName.containsKey(lowerCode)) {
                  _codeToName[lowerCode] = name;
                }
              });
            }
          }
        }
        _isInitialized = true;
      } catch (e) {
        print('Error parsing language map: $e');
      }
    } else {
      print('LanguageMapper: Could not load json data.');
    }
  }

  /// Determines a representative standard code for a language entry.
  static String _determinePrimaryCode(Map<String, String> rowMap) {
    // Priority order for standard code extraction
    final preferredProviders = ['google', 'alibaba', 'deepl', 'baidu', 'bing'];
    for (var p in preferredProviders) {
      if (rowMap.containsKey(p)) {
        final val = rowMap[p]!;
        if (val.equalsIgnoreCase('zh-CN') || val.equalsIgnoreCase('zh-Hans')) {
          return 'zh';
        }
        if (val.equalsIgnoreCase('en-US') || val.equalsIgnoreCase('en-GB')) {
          return 'en';
        }
        return val.toLowerCase();
      }
    }
    // Fallback to first code value found in the row
    for (var entry in rowMap.entries) {
      if (entry.key != 'Value') {
        return entry.value.toLowerCase();
      }
    }
    return 'en';
  }

  /// Returns the list of all supported languages with display names and primary codes.
  static List<SupportedLanguage> getSupportedLanguages() {
    return List.unmodifiable(_supportedLanguages);
  }

  /// Returns the human readable display name for a language code (e.g., 'zh' -> '中文').
  static String getLanguageName(String code) {
    final lower = code.trim().toLowerCase();
    if (_codeToName.containsKey(lower)) {
      return _codeToName[lower]!;
    }
    return code.toUpperCase();
  }

  /// Returns whether the provider supports 'auto' source language detection.
  /// Individual [TranslationProvider.supportsAuto] instances maintain source-of-truth.
  static bool supportsAuto(String providerCsvKey) {
    return true;
  }

  static String getCode(String providerName, String languageCode) {
    if (!_isInitialized) {
      print(
          'Warning: LanguageMapper not initialized when getCode called for $languageCode');
    }

    final lowerCode = languageCode.toLowerCase();
    if (_parsedMap.containsKey(lowerCode)) {
      final row = _parsedMap[lowerCode];
      if (row != null) {
        final pKey = providerName.toLowerCase();
        if (row.containsKey(pKey)) {
          return row[pKey]!;
        }
        if (row.containsKey(providerName)) {
          return row[providerName]!;
        }
      }
    }
    return languageCode;
  }
}

extension on String {
  bool equalsIgnoreCase(String other) => toLowerCase() == other.toLowerCase();
}
