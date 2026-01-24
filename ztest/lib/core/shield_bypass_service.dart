import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// ShieldBypassService - Cloudflare Shield Bypass via HeadlessWebView
///
/// 重构策略：
/// 1. 静默观察模式 (waitForNaturalBypass) - 纯粹轮询，不触碰DOM
/// 2. 交互辅助模式 (attemptInteraction) - 仅在必要时尝试点击
/// 3. 分离关注点，避免混合逻辑导致的触发红线
class ShieldBypassService {
  HeadlessInAppWebView? _headlessWebView;
  Completer<Map<String, dynamic>?>? _resultCompleter;

  /// 主入口：绕过 Cloudflare 盾
  ///
  /// [mode] - 绕过模式：
  ///   - 'silent': 仅静默观察，完全不碰DOM
  ///   - 'interactive': 尝试交互点击
  ///   - 'auto': 先静默，失败后尝试交互（默认）
  Future<Map<String, dynamic>?> bypass(
    String url, {
    String? userAgent,
    String? successMarker,
    String mode = 'interactive', // 默认仅静默模式
  }) async {
    debugPrint("🛡️ ShieldBypassService: Starting in [$mode] mode for $url");

    _resultCompleter = Completer<Map<String, dynamic>?>();

    String finalUA =
        userAgent ?? await InAppWebViewController.getDefaultUserAgent();

    _headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(
        userAgent: finalUA,
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        useHybridComposition: true,
      ),
      onLoadStop: (controller, url) async {
        debugPrint("🛡️ Page loaded: $url");
        if (successMarker != null) {
          // 根据模式选择策略
          switch (mode) {
            case 'silent':
              await _waitForNaturalBypass(controller, url, successMarker);
              break;
            case 'interactive':
              await _attemptInteraction(controller, url, successMarker);
              break;
            case 'auto':
              // 先尝试静默，超时后再尝试交互
              final silentSuccess = await _waitForNaturalBypass(
                controller,
                url,
                successMarker,
                maxWaitSeconds: 15,
              );
              if (!silentSuccess) {
                debugPrint("🛡️ Silent mode failed, attempting interaction...");
                await _attemptInteraction(controller, url, successMarker);
              }
              break;
          }
        }
      },
      onConsoleMessage: (controller, consoleMessage) {
        if (consoleMessage.message.contains("🛡️")) {
          debugPrint("[JS] ${consoleMessage.message}");
        }
      },
    );

    await _headlessWebView?.run();

    Timer(const Duration(seconds: 120), () {
      if (_resultCompleter != null && !_resultCompleter!.isCompleted) {
        debugPrint("🛡️ Timeout.");
        _cleanup();
        _resultCompleter!.complete(null);
      }
    });

    return _resultCompleter?.future;
  }

  /// 静默观察模式：纯粹轮询，完全不碰DOM
  ///
  /// 这种模式依赖：
  /// 1. 底层 TLS 指纹（NativeAdapter）足够好
  /// 2. Cloudflare 自动通过验证
  /// 3. 只负责检测结果（通过 successMarker）
  Future<bool> _waitForNaturalBypass(
    InAppWebViewController controller,
    WebUri? url,
    String successMarker, {
    int maxWaitSeconds = 60,
  }) async {
    debugPrint("🛡️ [SILENT MODE] Waiting for natural bypass...");

    int attempts = 0;
    final maxAttempts = maxWaitSeconds;

    while (attempts < maxAttempts) {
      if (_resultCompleter == null || _resultCompleter!.isCompleted)
        return false;

      final html = await controller.getHtml();
      if (html != null && html.contains(successMarker)) {
        await _returnSuccess(controller, url, html, "Natural Bypass");
        return true;
      }

      // 每3秒检查一次，完全不触碰页面
      await Future.delayed(const Duration(seconds: 3));
      attempts++;
    }

    debugPrint("🛡️ [SILENT MODE] Timeout - no natural bypass occurred.");
    return false;
  }

  /// 交互辅助模式：仅在必要时尝试点击
  ///
  /// 注意：这种模式风险较高，可能触发 Cloudflare 的行为检测
  Future<void> _attemptInteraction(
    InAppWebViewController controller,
    WebUri? url,
    String successMarker,
  ) async {
    debugPrint(
      "🛡️ [INTERACTIVE MODE] Attempting to interact with challenge...",
    );

    int attempts = 0;
    const maxAttempts = 30;

    while (attempts < maxAttempts) {
      if (_resultCompleter == null || _resultCompleter!.isCompleted) return;

      final html = await controller.getHtml();
      if (html != null && html.contains(successMarker)) {
        await _returnSuccess(controller, url, html, "Interactive Success");
        return;
      }

      // 每5秒尝试一次交互
      if (attempts % 5 == 0) {
        await _tryInteract(controller);
      }

      await Future.delayed(const Duration(seconds: 1));
      attempts++;
    }
  }

  /// 尝试与页面交互（简化版，避免复杂逻辑）
  Future<void> _tryInteract(InAppWebViewController controller) async {
    try {
      await controller.callAsyncJavaScript(
        functionBody: """
        try {
            // 极简策略：查找所有 iframe 并尝试点击
            const iframes = document.querySelectorAll('iframe');
            for (let iframe of iframes) {
                const rect = iframe.getBoundingClientRect();
                if (rect.width > 20 && rect.height > 20) {
                    console.log("🛡️ [INTERACT] Clicking iframe center");
                    const x = rect.left + rect.width / 2;
                    const y = rect.top + rect.height / 2;
                    const el = document.elementFromPoint(x, y) || iframe;
                    el.dispatchEvent(new MouseEvent('click', {
                        bubbles: true, cancelable: true, view: window,
                        clientX: x, clientY: y
                    }));
                    break; // 只点击第一个
                }
            }
        } catch(e) {
            console.log("🛡️ [ERROR] " + e.message);
        }
      """,
      );
    } catch (_) {}
  }

  Future<void> _returnSuccess(
    InAppWebViewController controller,
    WebUri? url,
    String html,
    String reason,
  ) async {
    if (url == null) return;
    final cookies = await CookieManager.instance().getCookies(url: url);
    if (_resultCompleter != null && !_resultCompleter!.isCompleted) {
      final cookieString = cookies
          .map((c) => "${c.name}=${c.value}")
          .join("; ");
      debugPrint("🛡️ Success ($reason).");
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
