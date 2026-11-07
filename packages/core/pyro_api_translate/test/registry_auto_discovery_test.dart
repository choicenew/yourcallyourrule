import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/pyro_api_translate.dart';

class CustomDummyProvider extends TranslationProvider {
  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    return 'DUMMY_$text';
  }
}

void main() {
  group('TranslationProviderRegistry Auto Discovery Tests', () {
    test('Should automatically register builtin providers and discover new ones', () async {
      final service = TranslationService.instance;
      final initialProviders = service.availableProviders;

      expect(initialProviders, contains('Google'));
      expect(initialProviders, contains('Bing'));
      expect(initialProviders, contains('Papago'));

      // 动态注册 CustomDummy Provider
      TranslationProviderRegistry.register('CustomDummy', () => CustomDummyProvider(), csvKey: 'google');

      final instance = TranslationProviderRegistry.createByName('CustomDummy');
      expect(instance, isNotNull);
      final res = await instance!.translate('Hello', targetLanguage: 'zh');
      expect(res, equals('DUMMY_Hello'));
    });
  });
}
