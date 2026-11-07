import '../translation_provider.dart';

/// 待支持/待密钥归档：字节火山翻译 (Volcengine)
/// 官方公开 API 需申请并配置 AppID 与 Secret (HMAC-SHA256 签名)
class VolcengineProvider extends TranslationProvider {
  VolcengineProvider();

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    throw UnimplementedError('Volcengine requires AppID and Secret configuration.');
  }
}
