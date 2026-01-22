import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ShieldBypassService {
  HeadlessInAppWebView? _headlessWebView;
  final Completer<Map<String, dynamic>?> _resultCompleter =
      Completer<Map<String, dynamic>?>();

  /// Attempts to bypass Cloudflare shield for the given URL
  /// Returns a map with cookies and content if successful, null otherwise.
  Future<Map<String, dynamic>?> bypass(String url, {String? userAgent}) async {
    debugPrint("🛡️ ShieldBypassService: Starting bypass for $url");

    // 0. Use provided UA or modify system default?
    String finalUA =
        userAgent ?? await InAppWebViewController.getDefaultUserAgent();
    debugPrint("🛡️ ShieldBypassService: Using UA: $finalUA");

    // 1. Create Headless WebView
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        useShouldInterceptRequest: false, // PHYSICAL ISOLATION
        userAgent: finalUA,
        javaScriptEnabled: true,
      ),
      onLoadStop: (controller, url) async {
        debugPrint("🛡️ ShieldBypassService: Page loaded: $url");
        _checkChallengeStatus(controller, url);
      },
      onTitleChanged: (controller, title) {
        debugPrint("🛡️ ShieldBypassService: Title changed: $title");
      },
    );

    // 2. Run WebView
    await _headlessWebView?.run();

    // 3. Set a timeout
    Timer(const Duration(seconds: 30), () {
      if (!_resultCompleter.isCompleted) {
        debugPrint("🛡️ ShieldBypassService: Timeout.");
        _cleanup();
        _resultCompleter.complete(null);
      }
    });

    return _resultCompleter.future;
  }

  Future<void> _checkChallengeStatus(
    InAppWebViewController controller,
    WebUri? url,
  ) async {
    if (url == null) return;

    final cookieManager = CookieManager.instance();
    final cookies = await cookieManager.getCookies(url: url);
    final hasClearance = cookies.any((c) => c.name == 'cf_clearance');

    debugPrint(
      "🛡️ ShieldBypassService: Cookies: ${cookies.length}, Clearance: $hasClearance",
    );

    // If we have clearance or at least some validation that we are IN
    // For now, any load that isn't a 403 error page (which WebView handles internally often)
    // We can also check title != "Just a moment..."

    if (cookies.isNotEmpty) {
      final cookieString = cookies
          .map((c) => "${c.name}=${c.value}")
          .join("; ");
      final html = await controller.getHtml();

      // Basic check: if HTML contains "Challenge Validation" maybe we wait?
      // But assuming onLoadStop happens after redirect...

      if (!_resultCompleter.isCompleted) {
        debugPrint("🛡️ ShieldBypassService: Success. Got Content.");
        _resultCompleter.complete({
          'cookies': cookieString,
          'content': html,
          'userAgent': await controller.getSettings().then((s) => s?.userAgent),
        });
        _cleanup();
      }
    }
  }

  void _cleanup() {
    try {
      _headlessWebView?.dispose();
    } catch (e) {
      debugPrint("🛡️ ShieldBypassService: Cleanup warning: $e");
    }
    _headlessWebView = null;
  }
}
