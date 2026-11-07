import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/providers/google_provider.dart';

void main() {
  group('GoogleProvider (GTX Web API) Connectivity & Translation Tests', () {
    late GoogleProvider provider;

    setUp(() {
      provider = GoogleProvider();
    });

    test('English to Chinese Translation (auto -> zh-CN)', () async {
      const text = 'Hello world, welcome to PyroMagma AI Reader!';
      final result = await provider.translate(
        text,
        targetLanguage: 'zh-CN',
        sourceLanguage: 'auto',
      );
      print('🌐 [Test Output] EN -> zh-CN: "$text" -> "$result"');
      expect(result, isNotEmpty);
      expect(result.contains('你好') || result.contains('欢迎'), isTrue);
    });

    test('Chinese to English Translation (auto -> en)', () async {
      const text = '神经网络与人工智能研究论文';
      final result = await provider.translate(
        text,
        targetLanguage: 'en',
        sourceLanguage: 'auto',
      );
      print('🌐 [Test Output] ZH -> EN: "$text" -> "$result"');
      expect(result, isNotEmpty);
      expect(result.toLowerCase().contains('neural') || result.toLowerCase().contains('artificial'), isTrue);
    });

    test('Same Language Input (zh -> zh)', () async {
      const text = '不需要翻译的中文文本';
      final result = await provider.translate(
        text,
        targetLanguage: 'zh',
        sourceLanguage: 'zh',
      );
      print('🌐 [Test Output] Same Lang: "$text" -> "$result"');
      expect(result, equals(text));
    });

    test('Multi-sentence Long Text Translation', () async {
      const text =
          'Parameter changes in neural networks directly impact model accuracy and training efficiency. '
          'Deep neural networks require careful hyperparameter tuning for optimal performance.';
      final result = await provider.translate(
        text,
        targetLanguage: 'zh-CN',
        sourceLanguage: 'auto',
      );
      print('🌐 [Test Output] Long Text EN -> zh-CN:\n"$result"');
      expect(result, isNotEmpty);
      expect(result.contains('神经网络') || result.contains('模型'), isTrue);
    });
  });
}
