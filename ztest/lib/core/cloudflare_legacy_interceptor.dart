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

  CloudflareLegacyInterceptor._internal() {
    _dio.options.responseType = ResponseType.bytes;
    _dio.options.validateStatus = (status) => true;
    _dio.httpClientAdapter = NativeAdapter(); // ⭐ 核心：使用 Native TLS 指纹
  }

  void registerSession(String requestId, String origin) {
    _sessionOrigins[requestId] = origin;
    debugPrint(
      '🛡️ [Legacy-Interceptor] Session registered: $requestId -> $origin',
    );
  }

  Future<WebResourceResponse?> handleRequest(
    InAppWebViewController controller,
    WebResourceRequest request,
  ) async {
    final uri = request.url;
    final urlStr = uri.toString();

    // --- 分支 1: 处理显式代理入口 (fetch?targetUrl=...) ---
    if (uri.scheme == PROXY_SCHEME &&
        uri.host == PROXY_HOST &&
        uri.path.startsWith(PROXY_PATH_FETCH)) {
      final String? targetUrlStr = uri.queryParameters['targetUrl'];
      final String? requestId = uri.queryParameters['requestId'];
      if (targetUrlStr == null || requestId == null) return null;

      final Uri targetUrl = Uri.parse(targetUrlStr);
      final String? successMarker = targetUrl.queryParameters['successMarker'];
      _sessionOrigins[requestId] = targetUrl.origin;
      debugPrint('🛡️ [Proxy-Entry] Fetching target: $targetUrl');
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
            debugPrint('🎯 [Leak-Recovery] Recovered by Referer: $urlStr');
            return _performProxy(controller, request, uri, requestId);
          }
        }
      } catch (_) {}
    }

    // --- 分支 3: 泄露回收 - 基于活跃 Origin 保险层 ---
    if (_sessionOrigins.values.contains(uri.origin)) {
      debugPrint('🔥 [Leak-Recovery] Recovered by Origin Match: $urlStr');
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
      debugPrint(
        '🛡️ [Recursive-Proxy] Forcing proxy for CF resource: $urlStr',
      );
      return _performProxy(controller, request, uri, 'cf_recursive');
    }

    // --- 默认：放行 (自然加载) ---
    return null;
  }

  bool _isCloudflareResource(Uri uri) {
    final host = uri.host.toLowerCase();
    final path = uri.path.toLowerCase();
    return host.contains('cloudflare.com') ||
        path.contains('/cdn-cgi/') ||
        path.contains('orchestrate');
  }

  Future<WebResourceResponse?> _performProxy(
    InAppWebViewController controller,
    WebResourceRequest request,
    Uri targetUrl,
    String requestId, [
    String? successMarker,
  ]) async {
    try {
      // 这里的逻辑只处理 GET，POST 让 WebView 自然发球以带上 Body
      if (request.method == 'POST') {
        debugPrint('🛡️ [Proxy-Pass] Passing POST to WebView: $targetUrl');
        return null;
      }

      Map<String, String> requestHeaders = {};
      request.headers?.forEach((k, v) => requestHeaders[k] = v);

      // 添加 Cookie
      final cookies = await CookieManager.instance().getCookies(
        url: WebUri.uri(targetUrl),
      );
      if (cookies.isNotEmpty) {
        final cookieStr = cookies.map((c) => '${c.name}=${c.value}').join('; ');
        requestHeaders['Cookie'] = (requestHeaders['Cookie'] != null)
            ? "${requestHeaders['Cookie']}; $cookieStr"
            : cookieStr;
      }
      final String? successMarkerFromUrl =
          targetUrl.queryParameters['successMarker'];
      final String? finalSuccessMarker = successMarker ?? successMarkerFromUrl;

      debugPrint(
        '🛡️ [Proxy-Entry] Fetching: $targetUrl (ID: $requestId, Marker: $finalSuccessMarker)',
      );

      final response = await _dio.getUri(
        targetUrl,
        options: Options(
          headers: requestHeaders,
          responseType: ResponseType.bytes,
        ),
      );

      debugPrint(
        '🛡️ [Proxy-Response] Status: ${response.statusCode} | Length: ${response.data.length}',
      );

      final data = response.data as Uint8List;
      String contentType =
          response.headers.value('content-type')?.toLowerCase() ?? 'text/html';

      // 1. 预处理 HTML (从 Legacy 移植)
      Uint8List finalData = data;
      if (contentType.contains('text/html')) {
        String html = utf8.decode(data, allowMalformed: true);

        // 剥离恶意内容 (Meta CSP 等)
        html = _purgeHarmfulContent(html, targetUrl);

        // 重写路径（包括绝对路径的 CF 资源）
        html = _preprocessHtml(html, targetUrl, requestId, finalSuccessMarker);

        // 核心注入：Scripts (完全同步 Legacy 结构)
        final scripts = [
          CloudflareScripts.domainBlockerJs,
          CloudflareScripts.networkInterceptorJs,
          CloudflareScripts.shadowHijackJs,
          CloudflareScripts.clickerJs,
          CloudflareScripts.resultMonitorJs,
          CloudflareScripts.receiverJs, // ⭐ 补全 Receiver
        ].map((s) => '<script>$s</script>').join('\n');

        if (html.contains('<head>')) {
          html = html.replaceFirst('<head>', '<head>$scripts');
        } else if (html.contains('<html>')) {
          html = html.replaceFirst('<html>', '<html><head>$scripts</head>');
        } else {
          html = scripts + html;
        }
        debugPrint(
          '🛡️ [Proxy-Injection] Injected scripts into HTML (ID: $requestId)',
        );
        finalData = Uint8List.fromList(utf8.encode(html));
      }

      // 2. 构建响应头，剥离安全保护
      final Map<String, String> resHeaders = {};
      final blockedHeaders = [
        'x-frame-options',
        'content-security-policy',
        'permissions-policy',
        'feature-policy',
        'cross-origin-embedder-policy',
        'cross-origin-opener-policy',
        'content-encoding', // ⭐ 必须剥离，因为 Dio 已经解压了
      ];

      response.headers.forEach((k, v) {
        if (!blockedHeaders.contains(k.toLowerCase())) {
          resHeaders[k] = v.first;
        }
      });

      // 3. 动态修复 CORS (Fix for credentials mode)
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
        contentEncoding: 'utf-8', // ⭐ 强制指定为 utf-8
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
