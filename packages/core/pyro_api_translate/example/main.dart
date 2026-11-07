import 'package:pyro_api_translate/pyro_api_translate.dart';

void main() async {
  print('Initializing Translation Service...');

  // Configuration with a dummy DeepLX URL for testing logic flow
  final config = TranslationConfig(deepLxUrl: 'http://localhost:1188');
  final service = TranslationService(config: config);

  try {
    print('Translating "Hello World" to Chinese (Simplified)...');

    // This might fail if Google is blocked and we have no other valid providers fully configured/working in this environment.
    // GoogleProvider should work if network allows.
    // MyMemory should work if network allows.

    final result =
        await service.translate('Hello World', targetLanguage: 'zh-cn');
    print('Translation Result: $result');
  } catch (e) {
    print('Translation failed: $e');
  }
}
