// import 'package:flutter/foundation.dart'; // Cannot use flutter package in pure dart script
import 'package:pyro_api_translate/src/providers/google_provider.dart';
import 'package:pyro_api_translate/src/providers/bing_provider.dart';
import 'package:pyro_api_translate/src/providers/deeplx_provider.dart';
import 'package:pyro_api_translate/src/providers/yandex_provider.dart';
import 'package:pyro_api_translate/src/providers/sogou_provider.dart';
import 'package:pyro_api_translate/src/providers/alibaba_provider.dart';
import 'package:pyro_api_translate/src/providers/translate_com_provider.dart';
import 'package:pyro_api_translate/src/providers/lingvanex_provider.dart';
import 'package:pyro_api_translate/src/providers/papago_provider.dart';
import 'package:pyro_api_translate/src/providers/modern_mt_provider.dart';
import 'package:pyro_api_translate/src/providers/itranslate_provider.dart';
import 'package:pyro_api_translate/src/providers/systran_provider.dart';
import 'package:pyro_api_translate/src/providers/argos_provider.dart';
import 'package:pyro_api_translate/src/providers/apertium_provider.dart';
import 'package:pyro_api_translate/src/providers/translate_me_provider.dart';
import 'package:pyro_api_translate/src/providers/tilde_provider.dart';
import 'package:pyro_api_translate/src/providers/judic_provider.dart';
import 'package:pyro_api_translate/src/providers/mirai_provider.dart';

// ignore: avoid_relative_lib_imports
// Importing relative to test file location might be tricky if not in lib, but example folder usually works with package: imports if pubspec is set right.
// If running from root: dart packages/translation_engine/example/test_providers.dart

void main() async {
  print('=== Testing Translation Providers ===\n');

  final text = 'Hello World';
  final target =
      'zh-Hans'; // Standardize target code slightly for broader compat if needed, or stick to 'zh-cn'

  // 1. Google
  print('--- Testing GoogleProvider ---');
  try {
    final google = GoogleProvider();
    final res = await google.translate(text,
        targetLanguage: 'zh-cn'); // 'zh-cn' for translator package
    print('SUCCESS: $res');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing BingProvider (Scraper) ---');
  try {
    final bing = BingProvider();
    final res = await bing.translate(text,
        targetLanguage: 'zh-Hans'); // Bing often uses zh-Hans
    print('SUCCESS: $res');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing DeepLXProvider (Dart Port) ---');
  try {
    final deeplx = DeepLXProvider();
    final res =
        await deeplx.translate(text, targetLanguage: 'ZH'); // DeepL uses 'ZH'
    print('SUCCESS: $res');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing YandexProvider (V2 Browser API) ---');
  try {
    final yandex = YandexProvider();
    final result =
        await yandex.translate(text, targetLanguage: 'zh'); // Yandex uses 'zh'
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing SogouProvider (Ported) ---');
  try {
    // Note: Importing valid source_lang is important for signing
    // Sogou auto-detect is 'auto', target is 'zh-CHS' usually but let's try 'zh' (mapped internally if needed?)
    // Reference code maps 'zh' to 'zh-CHS'. I might need to map it in provider.
    // Let's assume standard codes for now.
    final sogou = SogouProvider();
    final result = await sogou.translate(text, targetLanguage: 'zh-CHS');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing AlibabaProvider (V2) ---');
  try {
    final alibaba = AlibabaProvider();
    final result = await alibaba.translate(text, targetLanguage: 'zh');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing TranslateComProvider (Keyless) ---');
  try {
    final tcom = TranslateComProvider();
    final result =
        await tcom.translate(text, sourceLanguage: 'en', targetLanguage: 'zh');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing LingvanexProvider (V2 Token Scrape) ---');
  try {
    final ling = LingvanexProvider();
    final result = await ling.translate(text,
        sourceLanguage: 'en',
        targetLanguage: 'zh-Hans_CN'); // Code from reference code
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing PapagoProvider (HMAC Auth) ---');
  try {
    final papago = PapagoProvider();
    final result = await papago.translate(text,
        sourceLanguage: 'en', targetLanguage: 'zh-CN');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing ModernMtProvider (MD5 Signed) ---');
  try {
    final mmt = ModernMtProvider();
    final result = await mmt.translate(text,
        sourceLanguage: 'en', targetLanguage: 'zh-CN');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing ItranslateProvider (Key Scrape) ---');
  try {
    final itrans = ItranslateProvider();
    final result = await itrans.translate(text,
        sourceLanguage: 'en-US', targetLanguage: 'zh-CN'); // Explicit locales
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing SysTranProvider (OAuth2) ---');
  try {
    final sys = SysTranProvider();
    final result =
        await sys.translate(text, sourceLanguage: 'en', targetLanguage: 'zh');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing ArgosProvider (LibreTranslate / Scraped Secret) ---');
  try {
    final argos = ArgosProvider();
    final result =
        await argos.translate(text, sourceLanguage: 'en', targetLanguage: 'zh');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing ApertiumProvider (Open API / Pair-based) ---');
  try {
    final aper = ApertiumProvider();
    // Apertium usually supports eng|spa, maybe not en|zh.
    // Let's try eng|spa for verify, then we can see if zh works.
    // If fail, we know it's pair issue.
    print('Testing en->es (Spanish)...');
    final result =
        await aper.translate(text, sourceLanguage: 'en', targetLanguage: 'es');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing TranslateMeProvider (WP Ajax) ---');
  try {
    final tme = TranslateMeProvider();
    final result = await tme.translate(text,
        sourceLanguage: 'en', targetLanguage: 'Chinese'); // Using Name
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing TildeProvider (Config Based) ---');
  try {
    final tilde = TildeProvider();
    // Tilde needs pair. Checking english to latvian (classic tilde) or something supported?
    // Ref code uses 'lv'. Let's try 'en' to 'lv'.
    print('Testing en->lv...');
    final result = await tilde.translate('Hello',
        sourceLanguage: 'en', targetLanguage: 'lv');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing JudicProvider (Limited Pairs) ---');
  try {
    final judic = JudicProvider();
    // Judic: en, de, fr, nl
    print('Testing nl->en...');
    final result = await judic.translate('Hallo Wereld',
        sourceLanguage: 'nl', targetLanguage: 'en');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }

  print('\n--- Testing MiraiProvider (Scraped Key) ---');
  try {
    final mirai = MiraiProvider();
    print('Testing en->ja...');
    final result = await mirai.translate('Hello World',
        sourceLanguage: 'en', targetLanguage: 'ja');
    print('SUCCESS: $result');
  } catch (e) {
    print('FAILURE: $e');
  }
}
