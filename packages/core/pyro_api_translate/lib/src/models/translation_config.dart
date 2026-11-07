class TranslationConfig {
  final String? deepLxUrl;
  final String? bingApiKey; // Optional, if we switch to official API
  final String? yandexApiKey; // Optional

  const TranslationConfig({
    this.deepLxUrl,
    this.bingApiKey,
    this.yandexApiKey,
  });
}
