import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';

// Debug script to diagnose why specific providers failed in the stress test.
// We suspect:
// 1. Language Code Mismatch (Yandex needs 'zh' not 'zh-CN'?)
// 2. Unsupported 'auto' source (Lingvanex, TranslateCom?)
// 3. Connectivity Issues (Google)

void main() {
  test('Debug Failed Providers', () async {
    print('================================================');
    print('🔍 Debugging Failed Translation Providers 🔍');
    print('================================================');

    final service = TranslationService();
    // Use a simple word
    final text = 'Hello';
    final targetLang = 'zh-CN'; // The code used in the app

    // 1. Yandex
    // Error: 501 The specified translation direction is not supported
    // Hypothesis: 'zh-CN' is not valid for Yandex. It might want 'zh'.
    print('\n--- Debugging Yandex ---');
    try {
      // Trying "zh-CN" (App Behavior)
      print('Attempt 1: Yandex with target="zh-CN"');
      final r1 = await service.translate(text,
          targetLanguage: 'zh-CN', useProvider: 'Yandex');
      print('✅ Success (zh-CN): $r1');
    } catch (e) {
      print('❌ Failed (zh-CN): $e');
    }

    // 2. Lingvanex
    // Error: "Unsupported source lang code for translate: 'auto'"
    // Hypothesis: Needs explicit source 'en'.
    print('\n--- Debugging Lingvanex ---');
    try {
      print('Attempt 1: Lingvanex with source="auto"');
      final r1 = await service.translate(text,
          targetLanguage: 'zh-CN', useProvider: 'Lingvanex');
      print('✅ Success (auto): $r1');
    } catch (e) {
      print('❌ Failed (auto): $e');

      try {
        print('Attempt 2: Lingvanex with source="en"');
        final r2 = await service.translate(text,
            sourceLanguage: 'en',
            targetLanguage: 'zh-CN',
            useProvider: 'Lingvanex');
        print('✅ Success (en): $r2');
      } catch (e2) {
        print('❌ Failed (en): $e2');
      }
    }

    // 3. TranslateCom
    // Error: Empty result
    print('\n--- Debugging TranslateCom ---');
    try {
      final r1 = await service.translate(text,
          targetLanguage: 'zh-CN', useProvider: 'TranslateCom');
      print('✅ Success: $r1');
    } catch (e) {
      print('❌ Failed: $e');
    }

    // 4. Apertium
    // Error: Pair not installed
    print('\n--- Debugging Apertium ---');
    try {
      // Apertium has limited pairs. Likely doesn't support en-zh.
      final r1 = await service.translate(text,
          targetLanguage: 'zh-CN', useProvider: 'Apertium');
      print('✅ Success (zh-CN): $r1');
    } catch (e) {
      print('❌ Failed (zh-CN): $e');
      // Try en-es which should work
      try {
        final r2 = await service.translate(text,
            targetLanguage: 'es', useProvider: 'Apertium');
        print('✅ Success (es): $r2');
      } catch (e2) {
        print('❌ Failed (es): $e2');
      }
    }

    print('================================================');
  }, timeout: Timeout(Duration(minutes: 2)));
}
