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

    // Polling Loop (Max 20 seconds)
    // We wait for the interstitial to clear and the real content to load.
    int attempts = 0;
    const maxAttempts = 20;

    while (attempts < maxAttempts) {
      if (_resultCompleter.isCompleted) return;

      final html = await controller.getHtml();
      final title = await controller.getTitle();

      if (html == null) {
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
        continue;
      }

      // 1. Detection: Are we still in the Cloudflare Interstitial?
      bool isChallenge =
          html.contains('id="challenge-error-text"') ||
          html.contains('challenge-platform') ||
          (title != null && title.contains('Just a moment'));

      // [Optimization] If we see "Verification successful", we are winning!
      // Cloudflare should redirect soon. We assume it is still a challenge until redirect.
      bool isSuccessMsg = html.contains('Verification successful');

      // 2. Detection: Did we load the target content?
      // "summary-result" is the class used by slick.ly for the result tag.
      bool isTargetLoaded =
          html.contains('summary-result') ||
          html.contains('slick.ly') && !isChallenge;

      debugPrint(
        "🛡️ Bypass Check #$attempts: Challenge=$isChallenge (SuccessMsg=$isSuccessMsg), Target=$isTargetLoaded, Title='$title'",
      );

      if (isTargetLoaded || !isChallenge) {
        if (!isChallenge) {
          final cookieManager = CookieManager.instance();
          final cookies = await cookieManager.getCookies(url: url);

          // Only return success if cookies are present (or content is clearly good)
          if (cookies.isNotEmpty && !_resultCompleter.isCompleted) {
            final cookieString = cookies
                .map((c) => "${c.name}=${c.value}")
                .join("; ");

            debugPrint("🛡️ ShieldBypassService: Success. Challenge cleared.");
            _resultCompleter.complete({
              'cookies': cookieString,
              'content': html,
              'userAgent': await controller.getSettings().then(
                (s) => s?.userAgent,
              ),
            });
            _cleanup();
            return;
          }
        }
      }

      // Wait and Retry
      await Future.delayed(const Duration(seconds: 1));
      attempts++;
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
