/// 浏览器引擎的 URL 工具与规范化处理
class UrlUtils {
  /// 规范化并清洗 URL，不再强制转换 http 为 https（通过 AndroidManifest 允许明文传输解决），仅补齐协议头
  static String sanitizeUrl(String rawUrl) {
    final trimmed = rawUrl.trim();
    if (trimmed.isEmpty) return '';
    if (!trimmed.startsWith(RegExp(r'^https?://', caseSensitive: false))) {
      return 'https://$trimmed';
    }
    return trimmed;
  }
}
