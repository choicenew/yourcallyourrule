import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ShieldBypassService {
  HeadlessInAppWebView? _headlessWebView;

  // 核心修正：不再是 final，确保每次 bypass 调用都有全新的 Completer
  Completer<Map<String, dynamic>?>? _resultCompleter;

  /// Attempts to bypass Cloudflare shield for the given URL
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker, // Plugin-Defined Success Marker
  }) async {
    debugPrint(
      "🛡️ ShieldBypassService: [BACK-TO-BASICS] Starting Success-Proven Mode for $url",
    );

    // 0. 准备当前会话的 Completer
    _resultCompleter = Completer<Map<String, dynamic>?>();

    // 1. Prepare UserAgent
    String finalUA =
        userAgent ?? await InAppWebViewController.getDefaultUserAgent();
    debugPrint("🛡️ ShieldBypassService: Using UA: $finalUA");

    // 2. Create Headless WebView (还原之前的极简配置)
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        useShouldInterceptRequest: false,
        userAgent: finalUA,
        javaScriptEnabled: true,
        domStorageEnabled: true,
      ),
      onLoadStop: (controller, url) async {
        debugPrint("🛡️ ShieldBypassService: Page loaded: $url");
        _checkChallengeStatus(controller, url, successMarker);
      },
      onConsoleMessage: (controller, consoleMessage) {
        if (consoleMessage.message.contains("🛡️")) {
          debugPrint("${consoleMessage.message}");
        }
      },
    );

    // 3. Run WebView
    await _headlessWebView?.run();

    // 4. Set a global timeout (保持之前的 60s)
    Timer(const Duration(seconds: 60), () {
      if (_resultCompleter != null && !_resultCompleter!.isCompleted) {
        debugPrint("🛡️ ShieldBypassService: Global Timeout.");
        _cleanup();
        _resultCompleter!.complete(null);
      }
    });

    return _resultCompleter?.future;
  }

  Future<void> _checkChallengeStatus(
    InAppWebViewController controller,
    WebUri? url,
    String? successMarker,
  ) async {
    if (url == null) return;

    int attempts = 0;
    const maxAttempts = 50;

    int stableCount = 0;
    const int requiredStabilityCyles = 3;

    while (attempts < maxAttempts) {
      if (_resultCompleter == null || _resultCompleter!.isCompleted) return;

      final html = await controller.getHtml();
      final title = await controller.getTitle();

      if (html == null) {
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
        continue;
      }

      // [Validation Strategy] 判定 Clearance
      final cookies = await CookieManager.instance().getCookies(url: url);
      bool hasClearance = cookies.any((c) => c.name == 'cf_clearance');

      // [Detection Strategy]
      bool isChallengePage =
          html.contains('id="challenge-error-text"') ||
          html.contains('challenge-platform') ||
          (title != null && title.contains('Just a moment')) ||
          html.contains('cf-turnstile') ||
          html.contains('Verifying you are human');

      // [Plugin Success Strategy]
      bool isPluginSuccess = false;
      if (successMarker != null) {
        isPluginSuccess = html.contains(successMarker);
      }

      // 核心业务逻辑流程 (还原自 0bb77de)
      if (isPluginSuccess) {
        await _returnSuccess(controller, url, html, "Plugin Marker Found");
        return;
      }

      if (isChallengePage && !hasClearance) {
        stableCount = 0;
        debugPrint("🛡️ Status: Challenge Detected. Action: Polling Click...");
        // 彻底还原每一秒都点击的逻辑
        await _attemptAutoClick(controller);
      } else {
        // 等待数据加载
        String statusMsg = hasClearance
            ? "Shield Cleared. Waiting for Content..."
            : "No Shield Detected. Waiting for Content...";

        if (successMarker != null) {
          debugPrint("🛡️ $statusMsg (Target: '$successMarker')");
        } else {
          stableCount++;
          debugPrint(
            "🛡️ $statusMsg (Generic Stability $stableCount/$requiredStabilityCyles)",
          );

          if (stableCount >= requiredStabilityCyles) {
            await _returnSuccess(
              controller,
              url,
              html,
              "Generic Stability Reached",
            );
            return;
          }
        }
      }

      await Future.delayed(const Duration(seconds: 1));
      attempts++;
    }
  }

  /// 还原自 commit 0bb77de 的原始点击逻辑 (每一秒调用一次)
  Future<void> _attemptAutoClick(InAppWebViewController controller) async {
    try {
      await controller.evaluateJavascript(
        source: """
        (function() {
            function clickElement(el, reason) {
                if (!el) return;
                if (el.offsetParent === null) return;
                console.log("🛡️ JS ACTION: Clicking " + reason);
                el.click();
                var evt = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
                el.dispatchEvent(evt);
            }

            var stage = document.querySelector('#challenge-stage');
            if (stage) clickElement(stage, "#challenge-stage");

            var wrapper = document.querySelector('#turnstile-wrapper');
            if (wrapper) clickElement(wrapper, "#turnstile-wrapper");
            
            var all = document.querySelectorAll('*');
            for (var i=0; i<all.length; i++) {
               if (all[i].shadowRoot) {
                  var cb = all[i].shadowRoot.querySelector('input[type="checkbox"]');
                  if (cb) clickElement(cb, "ShadowRoot Checkbox");
               }
            }

            var centerX = window.innerWidth / 2;
            var centerY = window.innerHeight / 2;
            var centerEl = document.elementFromPoint(centerX, centerY);
            if (centerEl && centerEl.tagName !== 'BODY' && centerEl.tagName !== 'HTML') {
                clickElement(centerEl, "Center Screen Element");
            }
        })();
      """,
      );
    } catch (_) {}
  }

  Future<void> _returnSuccess(
    InAppWebViewController controller,
    WebUri url,
    String html,
    String reason,
  ) async {
    final cookies = await CookieManager.instance().getCookies(url: url);
    if (_resultCompleter != null && !_resultCompleter!.isCompleted) {
      final cookieString = cookies
          .map((c) => "${c.name}=${c.value}")
          .join("; ");
      debugPrint("🛡️ ShieldBypassService: Success ($reason).");
      _resultCompleter!.complete({
        'cookies': cookieString,
        'content': html,
        'userAgent': await controller.getSettings().then((s) => s?.userAgent),
      });
      _cleanup();
    }
  }

  void _cleanup() {
    try {
      _headlessWebView?.dispose();
    } catch (_) {}
    _headlessWebView = null;
  }
}
