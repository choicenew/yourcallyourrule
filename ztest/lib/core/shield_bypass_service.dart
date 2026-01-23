import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ShieldBypassService {
  HeadlessInAppWebView? _headlessWebView;
  final Completer<Map<String, dynamic>?> _resultCompleter =
      Completer<Map<String, dynamic>?>();

  /// Attempts to bypass Cloudflare shield for the given URL
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker, // Plugin-Defined Success Marker
  }) async {
    debugPrint("🛡️ ShieldBypassService: Starting bypass for $url");

    // 0. Prepare UserAgent
    String finalUA =
        userAgent ?? await InAppWebViewController.getDefaultUserAgent();
    debugPrint("🛡️ ShieldBypassService: Using UA: $finalUA");

    // 1. Create Headless WebView
    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        useShouldInterceptRequest: false,
        userAgent: finalUA,
        javaScriptEnabled: true,
        // Ensure DOM storage is enabled for CF
        domStorageEnabled: true,
      ),
      onLoadStop: (controller, url) async {
        debugPrint("🛡️ ShieldBypassService: Page loaded: $url");
        _checkChallengeStatus(controller, url, successMarker);
      },
      onConsoleMessage: (controller, consoleMessage) {
        // Capture JS logs for debugging
        if (consoleMessage.message.contains("🛡️")) {
          debugPrint("${consoleMessage.message}");
        }
      },
    );

    // 2. Run WebView
    await _headlessWebView?.run();

    // 3. Set a global timeout (increased to 60s for difficult shields)
    Timer(const Duration(seconds: 60), () {
      if (!_resultCompleter.isCompleted) {
        debugPrint("🛡️ ShieldBypassService: Global Timeout.");
        _cleanup();
        _resultCompleter.complete(null);
      }
    });

    return _resultCompleter.future;
  }

  Future<void> _checkChallengeStatus(
    InAppWebViewController controller,
    WebUri? url,
    String? successMarker,
  ) async {
    if (url == null) return;

    int attempts = 0;
    const maxAttempts = 50; // ~50 seconds max polling

    int stableCount = 0;
    const int requiredStabilityCyles = 3;

    while (attempts < maxAttempts) {
      if (_resultCompleter.isCompleted) return;

      final html = await controller.getHtml();
      final title = await controller.getTitle();

      // [Validation Strategy] Check Cookies for 'cf_clearance' (Reference: CloudflareKiller.kt)
      final cookies = await CookieManager.instance().getCookies(url: url);
      bool hasClearance = cookies.any((c) => c.name == 'cf_clearance');

      if (html == null) {
        await Future.delayed(const Duration(seconds: 1));
        attempts++;
        continue;
      }

      // [DEBUG] Print HTML for inspection (User Request)
      // Print every few attempts or when a challenge is detected to see the structure.
      if (attempts % 5 == 0) {
        debugPrint(
          "🛡️ [HTML DUMP - Attempt $attempts]\n$html\n🛡️ [END DUMP]",
        );
      }

      // [Detection Strategy]
      bool isChallengePage =
          html.contains('id="challenge-error-text"') ||
          html.contains('challenge-platform') ||
          (title != null && title.contains('Just a moment')) ||
          html.contains('cf-turnstile') ||
          html.contains('Verifying you are human'); // New indicator

      // [Plugin Success Strategy]
      bool isPluginSuccess = false;
      if (successMarker != null) {
        isPluginSuccess = html.contains(successMarker);
      }

      // LOGIC MATRIX
      // 1. If plugin marker is found -> SUCCESS (Highest Priority)
      if (isPluginSuccess) {
        await _returnSuccess(controller, url, html, "Plugin Marker Found");
        return;
      }

      // 2. If Challenge Page Detected AND No Clearance -> ATTACK
      if (isChallengePage && !hasClearance) {
        stableCount = 0;
        debugPrint(
          "🛡️ Status: Challenge Detected (No Clearance). Action: Interaction.",
        );

        // [Interaction Strategy] Click, Click, Click
        await _attemptAutoClick(controller);
      } else {
        // 3. If Clearance Present OR No Challenge detected -> WAIT FOR CONTENT
        // (If we have clearance but no content yet, we just wait for hydration)

        String statusMsg = hasClearance
            ? "Shield Cleared. Waiting for Content..."
            : "No Shield Detected. Waiting...";

        if (successMarker != null) {
          // Mode A: Waiting for specific marker
          debugPrint("🛡️ $statusMsg (Target: '$successMarker')");
        } else {
          // Mode B: Generic Stability Wait
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

      // Wait and Retry
      await Future.delayed(const Duration(seconds: 1));
      attempts++;
    }
  }

  /// Implements "Inspection + Center Click" Strategy
  Future<void> _attemptAutoClick(InAppWebViewController controller) async {
    try {
      await controller.evaluateJavascript(
        source: """
        (function() {
            // [Inspection] DUMP IFRAME INFO
            var iframes = document.getElementsByTagName('iframe');
            console.log("🛡️ JS INSPECT: Found " + iframes.length + " iframes.");
            for(var i=0; i<iframes.length; i++) {
               // Try to log src if possible (CORS might block)
               try { console.log("🛡️ JS INSPECT: Frame["+i+"] src=" + iframes[i].src); } catch(e) {}
            }

            function clickElement(el, reason) {
                if (!el) return;
                // Visibility check (Reference: MangaSourceAntiCrawler)
                if (el.offsetParent === null) {
                   console.log("🛡️ JS: Skipped Hidden Element: " + reason);
                   return;
                }
                
                console.log("🛡️ JS ACTION: Clicking " + reason);
                el.click();
                var evt = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
                el.dispatchEvent(evt);
            }

            // Strategy 1: Known Selectors (Fastest)
            var stage = document.querySelector('#challenge-stage');
            if (stage) clickElement(stage, "#challenge-stage");

            var wrapper = document.querySelector('#turnstile-wrapper');
            if (wrapper) clickElement(wrapper, "#turnstile-wrapper");
            
            // Strategy 2: Shadow DOM Deep Search
            var all = document.querySelectorAll('*');
            for (var i=0; i<all.length; i++) {
               if (all[i].shadowRoot) {
                  var cb = all[i].shadowRoot.querySelector('input[type="checkbox"]');
                  if (cb) clickElement(cb, "ShadowRoot Checkbox");
               }
            }

            // Strategy 3: Center Click (The "Dumb but Effective" Fallback)
            // Reference: MangaSourceAntiCrawler.ets
            // Often the challenge is a modal in the center of the screen
            var centerX = window.innerWidth / 2;
            var centerY = window.innerHeight / 2;
            var centerEl = document.elementFromPoint(centerX, centerY);
            
            if (centerEl) {
                // Ensure it's not just the body/html
                if (centerEl.tagName !== 'BODY' && centerEl.tagName !== 'HTML') {
                    // console.log("🛡️ JS ACTION: Center Click on " + centerEl.tagName + "." + centerEl.className);
                    // centerEl.click(); 
                    // Note: enabling center click can be risky if ads are present, 
                    // but for Cloudflare pages it's usually safe. 
                    // Uncommenting to enable "Nuclear Option":
                    clickElement(centerEl, "Center Screen Element");
                }
            }

        })();
      """,
      );
    } catch (e) {
      debugPrint("🛡️ Click Error: $e");
    }
  }

  Future<void> _returnSuccess(
    InAppWebViewController controller,
    WebUri url,
    String html,
    String reason,
  ) async {
    final cookieManager = CookieManager.instance();
    final cookies = await cookieManager.getCookies(url: url);

    if (cookies.isNotEmpty && !_resultCompleter.isCompleted) {
      final cookieString = cookies
          .map((c) => "${c.name}=${c.value}")
          .join("; ");

      debugPrint("🛡️ ShieldBypassService: Success ($reason).");
      _resultCompleter.complete({
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
    } catch (e) {
      debugPrint("🛡️ ShieldBypassService: Cleanup warning: $e");
    }
    _headlessWebView = null;
  }
}
