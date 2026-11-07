import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/utils/language_mapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LanguageMapper Unit Tests', () {
    setUp(() async {
      await LanguageMapper.ensureInitialized();
    });

    test(
        'Primary language codes and names map correctly without Taiwan overwriting zh',
        () {
      // 1. Check Chinese Simplified ('zh')
      expect(LanguageMapper.getLanguageName('zh'), equals('中文'));
      expect(LanguageMapper.getLanguageName('zh-cn'), equals('中文'));
      expect(LanguageMapper.getLanguageName('zh-hans'), equals('中文'));

      // 2. Check Chinese Traditional ('zh-tw')
      expect(LanguageMapper.getLanguageName('zh-tw'), equals('中文(台湾)'));

      // 3. Check English, Japanese, Korean, French, German
      expect(LanguageMapper.getLanguageName('en-GB'), equals('en-gb'));
      expect(LanguageMapper.getLanguageName('ja'), equals('日语'));
      expect(LanguageMapper.getLanguageName('ko'), equals('韩语'));
      expect(LanguageMapper.getLanguageName('fr'), equals('法语'));
      expect(LanguageMapper.getLanguageName('de'), equals('德语'));
    });

    test('Provider code mappings work accurately for all translation engines',
        () {
      // Google Translate
      expect(LanguageMapper.getCode('google', 'zh'), equals('zh-CN'));
      expect(LanguageMapper.getCode('google', 'zh-tw'), equals('zh-TW'));
      expect(LanguageMapper.getCode('google', 'en'), equals('en'));
      expect(LanguageMapper.getCode('google', 'ja'), equals('ja'));

      // Bing Translate
      expect(LanguageMapper.getCode('bing', 'zh'), equals('zh-Hans'));
      expect(LanguageMapper.getCode('bing', 'zh-tw'), equals('zh-Hant'));
      expect(LanguageMapper.getCode('bing', 'de'), equals('de'));

      // DeepL Translate
      expect(LanguageMapper.getCode('deepl', 'zh'), equals('zh'));
      expect(LanguageMapper.getCode('deepl', 'ja'), equals('ja'));

      // Alibaba Translate
      expect(LanguageMapper.getCode('alibaba', 'zh'), equals('zh'));
      expect(LanguageMapper.getCode('alibaba', 'zh-tw'), equals('zh-tw'));
    });

    test('Supported languages list contains expected standard entries', () {
      final langs = LanguageMapper.getSupportedLanguages();
      expect(langs.isNotEmpty, isTrue);

      final zh = langs.firstWhere((l) => l.code == 'zh');
      expect(zh.name, equals('中文'));
      expect(zh.providerCodes['google'], equals('zh-CN'));

      final zhTw = langs.firstWhere((l) => l.code == 'zh-tw');
      expect(zhTw.name, equals('中文(台湾)'));
      expect(zhTw.providerCodes['google'], equals('zh-TW'));
    });
  });
}
