abstract class TranslationProvider {
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'});

  /// Whether this provider supports automatic source language detection ('auto').
  /// Defaults to true.
  bool get supportsAuto => true;
}
