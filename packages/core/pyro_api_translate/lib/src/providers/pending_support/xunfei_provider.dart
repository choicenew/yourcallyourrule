import '../translation_provider.dart';

/// 待支持/待密钥归档：科大讯飞 (Xunfei)
/// 官方公开 API 需申请并配置 AppID/APIKey/APISecret
class XunfeiProvider extends TranslationProvider {
  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    throw UnimplementedError('Xunfei requires AppID and Secret configuration.');
  }
}
