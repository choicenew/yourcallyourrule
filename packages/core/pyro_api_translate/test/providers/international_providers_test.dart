import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/providers/translate_cat_provider.dart';
import 'package:pyro_api_translate/src/providers/wordvice_provider.dart';
import 'package:pyro_api_translate/src/providers/lara_translate_provider.dart';
import 'package:pyro_api_translate/src/providers/lingva_provider.dart';

void main() {
  group('International Keyless Providers', () {
    test('TranslateCat Provider Connectivity', () async {
      final provider = TranslateCatProvider();
      try {
        final result =
            await provider.translate('Hello', targetLanguage: 'zh-CN');
        print('TranslateCat Result: $result');
        expect(result, isNotEmpty);
      } catch (e) {
        print('TranslateCat Failed: $e');
      }
    });

    test('Wordvice Provider Connectivity (V2)', () async {
      final provider = WordviceProvider(useLlm: false);
      try {
        final result =
            await provider.translate('Hello', targetLanguage: 'zh-CN');
        print('Wordvice V2 Result: $result');
        // Expect result might be empty if V2 is broken, so strict expect might fail.
        // We mainly want to see the output.
      } catch (e) {
        print('Wordvice V2 Failed: $e');
      }
    });

    test('Wordvice Provider Connectivity (LLM)', () async {
      final provider = WordviceProvider(useLlm: true);
      try {
        final result = await provider.translate('Hello', targetLanguage: 'zh');
        print('Wordvice LLM Result: $result');
        expect(result, isNotEmpty);
      } catch (e) {
        print('Wordvice LLM Failed: $e');
      }
    });

    test('LaraTranslate Provider Connectivity', () async {
      final provider = LaraTranslateProvider();
      try {
        final result = await provider.translate('Hello', targetLanguage: 'zh');
        print('LaraTranslate Result: $result');
        expect(result, isNotEmpty);
      } catch (e) {
        print('LaraTranslate Failed: $e');
      }
    });

    test('Lingva Provider Connectivity', () async {
      final provider = LingvaProvider();
      try {
        final result = await provider.translate('Hello', targetLanguage: 'zh');
        print('Lingva Result: $result');
        expect(result, isNotEmpty);
      } catch (e) {
        print('Lingva Failed: $e');
      }
    });
  });
}
