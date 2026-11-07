import 'package:translate_text/translate_text.dart';
import 'translation_provider.dart';

class MyMemoryProvider extends TranslationProvider {
  final TranslateTextBase _translator = TranslateTextBase();

  @override
  bool get supportsAuto => false;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      final result =
          await _translator.translateText(text, sourceLanguage, targetLanguage);
      if (result.contains('PLEASE SELECT TWO DISTINCT LANGUAGES') ||
          result.startsWith('MYMEMORY WARNING') ||
          result.contains('INVALID LANGUAGE')) {
        throw Exception('MyMemory translation error: $result');
      }
      return result;
    } catch (e) {
      throw Exception('MyMemory translation failed: $e');
    }
  }
}
