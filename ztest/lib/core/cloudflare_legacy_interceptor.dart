// ztest/lib/core/cloudflare_legacy_interceptor.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'cloudflare_scripts.dart';

const String PROXY_SCHEME = "https";
const String PROXY_HOST = "flutter-webview-proxy.internal";
const String PROXY_PATH_FETCH = "/fetch";

/// CloudflareLegacyInterceptor - 移植自 Legacy WebViewRequestInterceptor
/// 职责：处理所有网络拦截逻辑，剥离安全头，注入劫持脚本。
class CloudflareLegacyInterceptor {
  static final CloudflareLegacyInterceptor _instance =
      CloudflareLegacyInterceptor._internal();
  factory CloudflareLegacyInterceptor() => _instance;

  final Dio _dio = Dio();

  // 跟踪会话中的原始域名，用于“泄露回收”
  final Map<String, String> _sessionOrigins = {};

  String? _userAgent; // ⭐ 保存同步过来的 UA

  CloudflareLegacyInterceptor._internal() {
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.validateStatus = (status) => true;
    _dio.httpClientAdapter = NativeAdapter(); // ⭐ 核心：使用 Native TLS 指纹
  }

  void setUserAgent(String? ua) {
    _userAgent = ua;
    print('🛡️ [Legacy-Interceptor] UA synchronized: $ua');
  }

  void registerSession(String requestId, String origin) {
    _sessionOrigins[requestId] = origin;
    print('🛡️ [Legacy-Interceptor] Session registered: $requestId -> $origin');
  }

  Future<WebResourceResponse?> handleRequest(
    InAppWebViewController controller,
    WebResourceRequest request,
  ) async {
    final uri = request.url;
    final urlStr = uri.toString();
    print('🌐 [Interceptor-Audit] WebView Request: $urlStr');

    // --- 分支 1: 处理显式代理入口 (fetch?targetUrl=...) ---
    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      final String? targetUrlStr = uri.queryParameters['targetUrl'];
      final String? requestId = uri.queryParameters['requestId'];
      if (targetUrlStr == null || requestId == null) return null;

      final Uri targetUrl = Uri.parse(targetUrlStr);

      // ⭐ 核心修复：从 targetUrl 中尝试提取嵌套的 successMarker
      // 之前的代码只从顶层 queryParameters 拿，导致嵌套在 targetUrl 里的丢失了。
      final String? successMarker =
          uri.queryParameters['successMarker'] ??
          targetUrl.queryParameters['successMarker'];

      _sessionOrigins[requestId] = targetUrl.origin;
      print(
        '🛡️ [Proxy-Entry] Fetching target: $targetUrl (Marker: $successMarker)',
      );
      return _performProxy(
        controller,
        request,
        targetUrl,
        requestId,
        successMarker,
      );
    }

    // --- 分支 2: 泄露回收 - 基于 Referer 识别活跃会话 ---
    final referer = request.headers?['Referer'] ?? request.headers?['referer'];
    if (referer != null && referer.contains(PROXY_HOST)) {
      try {
        final refererUri = Uri.parse(referer);
        final requestId = refererUri.queryParameters['requestId'];
        if (requestId != null) {
          final expectedOrigin = _sessionOrigins[requestId];
          if (expectedOrigin != null && uri.origin == expectedOrigin) {
            print('🎯 [Leak-Recovery] Recovered by Referer: $urlStr');
            return _performProxy(controller, request, uri, requestId);
          }
        }
      } catch (_) {}
    }

    // --- 分支 3: 泄露回收 - 基于活跃 Origin 保险层 ---
    if (_sessionOrigins.values.contains(uri.origin)) {
      print('🔥 [Leak-Recovery] Recovered by Origin Match: $urlStr');
      // 找出一个匹配的 requestId，如果没找到则用默认
      final requestId = _sessionOrigins.entries
          .firstWhere(
            (e) => e.value == uri.origin,
            orElse: () => MapEntry('unknown', ''),
          )
          .key;
      return _performProxy(controller, request, uri, requestId);
    }

    // --- 分支 4: 递归代理 - 强制拦截 Cloudflare 核心资源 ---
    if (_isCloudflareResource(uri)) {
      print('🛡️ [Recursive-Proxy] Forcing proxy for CF resource: $urlStr');
      // ⭐ 修復：使用活躍的 requestId 而不是 cf_recursive
      final requestId = _sessionOrigins.keys.isNotEmpty
          ? _sessionOrigins.keys.first
          : 'cf_fallback';
      return _performProxy(controller, request, uri, requestId);
    }

    // --- 默认：放行 (自然加载) ---
    return null;
  }

  bool _isCloudflareResource(Uri uri) {
    final host = uri.host.toLowerCase();
    final path = uri.path.toLowerCase();

    // ⭐ 核心修復:檢查代理 URL 的 targetUrl 參數
    if (host == PROXY_HOST.toLowerCase()) {
      final targetUrl = uri.queryParameters['targetUrl'];
      if (targetUrl != null &&
          targetUrl.toLowerCase().contains('cloudflare.com')) {
        return true;
      }
    }

    // ⭐ 通用邏輯：不再硬編碼目標域名。
    // 如果是 Cloudflare 挑戰域，或者該域名已經在活躍會話中註冊，則進行攔截。
    final bool isCFHost =
        host.contains('cloudflare.com') ||
        path.contains('/cdn-cgi/') ||
        path.contains('orchestrate');

    final bool isRegisteredOrigin = _sessionOrigins.values.any(
      (origin) => uri.origin.toLowerCase() == origin.toLowerCase(),
    );

    return isCFHost || isRegisteredOrigin;
  }

  Future<WebResourceResponse?> _performProxy(
    InAppWebViewController controller,
    WebResourceRequest request,
    Uri targetUrl,
    String requestId, [
    String? successMarker,
  ]) async {
    try {
      if (request.method == 'POST') {
        print('🛡️ [Proxy-Pass] Passing POST to WebView: $targetUrl');
        return null;
      }

      final String? rawReferer =
          request.headers?['Referer'] ?? request.headers?['referer'];
      String? forgedReferer;
      if (rawReferer != null && rawReferer.contains(PROXY_HOST)) {
        try {
          final refUri = Uri.parse(rawReferer);
          forgedReferer = refUri.queryParameters['targetUrl'];
        } catch (_) {}
      }

      final String? successMarkerFromUrl =
          targetUrl.queryParameters['successMarker'];
      final String? finalSuccessMarker = successMarker ?? successMarkerFromUrl;

      print(
        '🛡️ [Proxy-Entry] Fetching: $targetUrl (ID: $requestId, Marker: $finalSuccessMarker)',
      );

      // --- 关键增强：向前转发 WebView 的 Cookie ---
      String? webviewCookies;
      try {
        final cookies = await CookieManager.instance().getCookies(
          url: WebUri.uri(targetUrl),
        );
        if (cookies.isNotEmpty) {
          webviewCookies = cookies
              .map((c) => '${c.name}=${c.value}')
              .join('; ');
          print(
            '🔑 [Proxy-Auth] Forwarding Cookies: ${webviewCookies.substring(0, (webviewCookies.length > 50 ? 50 : webviewCookies.length))}...',
          );
        }
      } catch (e) {}

      final requestHeaders = {
        'User-Agent': _userAgent ?? '',
        if (request.headers?['Accept'] != null)
          'Accept': request.headers!['Accept'],
        if (request.headers?['Accept-Language'] != null)
          'Accept-Language': request.headers!['Accept-Language'],
        if (webviewCookies != null) 'Cookie': webviewCookies,
        'Referer': forgedReferer ?? (rawReferer ?? targetUrl.origin),
      };

      final response = await _dio.getUri(
        targetUrl,
        options: Options(
          headers: requestHeaders,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          followRedirects: true, // ⭐ 允許自動跟隨重定向到 Cloudflare 挑戰頁面
          maxRedirects: 5,
        ),
      );

      print(
        '🛡️ [Proxy-Response] Status: ${response.statusCode} | Length: ${response.data.length}',
      );

      final setCookies = response.headers['set-cookie'];
      if (setCookies != null) {
        for (var sc in setCookies) {
          try {
            final parts = sc.split(';')[0].split('=');
            if (parts.length >= 2) {
              final name = parts[0].trim();
              final value = parts.sublist(1).join('=').trim();
              await CookieManager.instance().setCookie(
                url: WebUri.uri(targetUrl),
                name: name,
                value: value,
                domain: targetUrl.host,
                path: "/",
              );
            }
          } catch (e) {
            debugPrint('⚠️ [Proxy-Cookie-Sync] Failed to sync cookie: $sc');
          }
        }
      }

      final data = response.data as Uint8List;
      String contentType =
          response.headers.value('content-type')?.toLowerCase() ?? 'text/html';

      Uint8List finalData = data;
      final bool isHtml = contentType.contains('text/html');
      final bool isJs = contentType.contains('javascript');

      if (isHtml || isJs) {
        String content = utf8.decode(data, allowMalformed: true);

        if (isHtml) {
          content = _purgeHarmfulContent(content, targetUrl);

          // ⭐ 核心修復：對於 Cloudflare 挑戰頁面,使用選擇性重寫
          final isChallengePage =
              targetUrl.path.contains('/cdn-cgi/challenge-platform/') ||
              targetUrl.path.contains('orchestrate/chl_page');

          if (!isChallengePage) {
            content = _preprocessHtml(
              content,
              targetUrl,
              requestId,
              finalSuccessMarker,
            );
          } else {
            // 挑戰頁面：只重寫 Turnstile API URL
            debugPrint(
              '🛡️ [Selective-Rewrite] Challenge page detected, rewriting Turnstile API only',
            );
            final String proxyPrefix =
                'https://$PROXY_HOST$PROXY_PATH_FETCH?requestId=$requestId&targetUrl=';
            final turnstileRegex = RegExp(
              r'(https?:)?//challenges\.cloudflare\.com/turnstile',
              caseSensitive: false,
            );
            content = content.replaceAll(
              turnstileRegex,
              proxyPrefix + 'https://challenges.cloudflare.com/turnstile',
            );
          }

          // 核心注入：攔截器、阻止器、點擊器、監控器
          const String boundaryMarker = "<!-- END_OF_TINY_LEGACY_INJECTION -->";
          final scList = [
            CloudflareScripts.shadowHijackJs,
            CloudflareScripts.domainBlockerJs,
            CloudflareScripts.networkInterceptorJs,
            CloudflareScripts.clickerJs,
            CloudflareScripts.resultMonitorJs,
            CloudflareScripts.receiverJs,
          ];

          final scripts =
              scList.map((s) => '<script>$s</script>').join('\n') +
              "\n$boundaryMarker\n";

          final lowerHtml = content.toLowerCase();
          if (lowerHtml.contains('<head>')) {
            final int headIndex = lowerHtml.indexOf('<head>');
            content =
                content.substring(0, headIndex + 6) +
                "\n$scripts\n" +
                content.substring(headIndex + 6);
          } else {
            content = scripts + content;
          }
        }

        finalData = Uint8List.fromList(utf8.encode(content));

        // ⭐ 调试辅助：打印网页内容
        if (isHtml) {
          debugPrint('📄 [HTML-DUMP] Total Len: ${content.length}');
        }
      }

      final Map<String, String> resHeaders = {};
      final blockedHeaders = [
        'x-frame-options',
        'content-security-policy',
        'permissions-policy',
        'feature-policy',
        'cross-origin-embedder-policy',
        'cross-origin-opener-policy',
        'content-encoding',
      ];

      response.headers.forEach((k, v) {
        if (!blockedHeaders.contains(k.toLowerCase())) {
          resHeaders[k] = v.first;
        }
      });

      // ⭐ 核心修復：添加 CORS 頭以允許跨域腳本加載
      resHeaders['Access-Control-Allow-Origin'] = '*';
      resHeaders['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS';
      resHeaders['Access-Control-Allow-Headers'] = '*';

      final reqOrigin =
          request.headers?['Origin'] ?? request.headers?['origin'];
      if (reqOrigin != null) {
        resHeaders['Access-Control-Allow-Origin'] = reqOrigin;
        resHeaders['Access-Control-Allow-Credentials'] = 'true';
      } else {
        resHeaders['Access-Control-Allow-Origin'] = '*';
      }
      resHeaders['Access-Control-Allow-Methods'] =
          'GET, POST, OPTIONS, PUT, DELETE';
      resHeaders['Access-Control-Allow-Headers'] = '*';

      return WebResourceResponse(
        contentType: contentType.contains('text/html')
            ? 'text/html'
            : contentType,
        contentEncoding: 'utf-8',
        data: finalData,
        statusCode: response.statusCode,
        headers: resHeaders,
      );
    } catch (e) {
      debugPrint('🛡️ [Proxy-Error] CRITICAL FAILURE for $targetUrl: $e');
      return null;
    }
  }

  /// 移植自 Legacy: 预处理 HTML，将所有资源路径重定向到我们的代理服务
  String _preprocessHtml(
    String htmlBody,
    Uri targetUri,
    String requestId,
    String? successMarker,
  ) {
    final targetOrigin = targetUri.origin;
    final attrRegex = RegExp(
      r'''(src|href)\s*=\s*(?:"([^"]*)"|'([^']*)')''',
      caseSensitive: false,
    );

    return htmlBody.replaceAllMapped(attrRegex, (match) {
      final originalMatch = match.group(0)!;
      final attr = match.group(1);
      final path = (match.group(2) ?? match.group(3) ?? '').trim();

      if (path.isEmpty ||
          path.startsWith('#') ||
          path.startsWith('data:') ||
          path.startsWith('javascript:') ||
          path.contains(PROXY_HOST)) {
        return originalMatch;
      }

      try {
        final absUrl = Uri.parse(targetOrigin).resolve(path).toString();

        // ⭐ 核心逻辑：如果是目标域，或者是 Cloudflare 的挑战域，强制代理！
        final isTarget = absUrl.contains(targetUri.host);
        final isCF =
            absUrl.contains('cloudflare.com') ||
            absUrl.contains('challenges.cloudflare.com') ||
            absUrl.contains('cdn-cgi');

        if (isTarget || isCF) {
          final queryParams = {'requestId': requestId, 'targetUrl': absUrl};
          if (successMarker != null)
            queryParams['successMarker'] = successMarker;

          final newProxyUrl = Uri.https(
            PROXY_HOST,
            PROXY_PATH_FETCH,
            queryParams,
          ).toString();

          debugPrint('🛡️ [Path-Rewrite] $path -> [PROXY]');
          if (match.group(2) != null) {
            return '$attr="$newProxyUrl"'; // 双引号
          } else {
            return "$attr='$newProxyUrl'"; // 单引号
          }
        }
      } catch (e) {}

      return originalMatch;
    });
  }

  /// 移植自 Legacy: 剥离 HTML 中的有害 META 标签 (如 CSP)
  String _purgeHarmfulContent(String htmlBody, Uri requestUri) {
    // 使用三引号原始字符串，避免单双引号引起的语法错误
    final cspRegex = RegExp(
      r'''<meta[^>]+http-equiv=["']Content-Security-Policy["'][^>]*>''',
      caseSensitive: false,
    );
    htmlBody = htmlBody.replaceAll(cspRegex, '<!-- Removed CSP -->');

    final xfoRegex = RegExp(
      r'''<meta[^>]+http-equiv=["']X-Frame-Options["'][^>]*>''',
      caseSensitive: false,
    );
    htmlBody = htmlBody.replaceAll(xfoRegex, '<!-- Removed XFO -->');

    return htmlBody;
  }

  void cleanupSession(String requestId) {
    _sessionOrigins.remove(requestId);
  }
}
