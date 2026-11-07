/// Cloudflare 请求代理拦截器配置
class CloudflareProxyConfig {
  final String targetUrl;
  final Map<String, String> cookies;
  final String userAgent;

  const CloudflareProxyConfig({
    required this.targetUrl,
    required this.cookies,
    required this.userAgent,
  });

  bool get hasCfClearance => cookies.keys.any((k) => k.toLowerCase() == 'cf_clearance');
}

/// 迁移自 comic-reader 的 Cloudflare 5秒盾过白与代理拦截客户端
class CloudflareBypassClient {
  final Map<String, CloudflareProxyConfig> _cacheMap = {};

  /// 缓存经过 Headless WebView 拿到的合法 cf_clearance Cookie
  void updateProxyCookies(String domain, Map<String, String> cookies, String userAgent) {
    _cacheMap[domain] = CloudflareProxyConfig(
      targetUrl: domain,
      cookies: cookies,
      userAgent: userAgent,
    );
  }

  /// 检查特定域名是否需要或已获得 Cloudflare 过白资质
  CloudflareProxyConfig? getProxyConfig(String domain) {
    return _cacheMap[domain];
  }

  /// 将过白 Cookie 注入到普通 HTTP 请求 Header 中
  Map<String, String> mergeProxyHeaders(String domain, Map<String, String> baseHeaders) {
    final config = getProxyConfig(domain);
    if (config == null) return baseHeaders;

    final result = Map<String, String>.from(baseHeaders);
    if (config.cookies.isNotEmpty) {
      final cookieString = config.cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
      result['Cookie'] = cookieString;
    }
    result['User-Agent'] = config.userAgent;
    return result;
  }
}
