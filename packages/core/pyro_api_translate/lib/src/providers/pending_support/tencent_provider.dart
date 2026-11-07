import '../translation_provider.dart';

/// 待支持/待修改归档：腾讯翻译君 (Tencent)
/// 网页端 WAF 防火墙防护需深度 Session 维持，暂放入待修改文件夹
class TencentProvider extends TranslationProvider {
  TencentProvider();

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    throw UnimplementedError('Tencent provider moved to pending_support.');
  }
}
