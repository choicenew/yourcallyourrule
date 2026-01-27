import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'bypass_scripts.dart';

// [REFACTOR] Ephemeral Session Class
class _BypassSession {
  final String id;
  final String targetUrl;
  final String? userAgent;
  final String marker;
  final Completer<Map<String, dynamic>?> _completer = Completer();

  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _controller;
  bool _isPolling = false;

  _BypassSession({
    required this.id,
    required this.targetUrl,
    required this.userAgent,
    required this.marker,
  });

  Future<Map<String, dynamic>?> run() async {
    try {
      _headlessWebView = HeadlessInAppWebView(
        initialSize: const Size(1080, 1920),
        initialUrlRequest: URLRequest(url: WebUri('about:blank')),
        initialSettings: InAppWebViewSettings(
          userAgent: userAgent ?? '',
          javaScriptEnabled: true,
          domStorageEnabled: true,
          databaseEnabled: true,
          useHybridComposition: true,
          mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
          allowFileAccessFromFileURLs: true,
          allowUniversalAccessFromFileURLs: true,
        ),
        onWebViewCreated: (controller) {
          _controller = controller;
          _setupCallbacks(controller);
        },
        onLoadStop: (controller, url) async {
          // debugPrint('🛡️ [Session-$id] Page Loaded: $url');
        },
      );

      debugPrint('🛡️ [Session-$id] Creating Headless WebView...');
      await _headlessWebView?.run();

      // Wait for Controller
      int attempts = 0;
      while (_controller == null && attempts < 20) {
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }

      if (_controller == null)
        throw Exception('WebViewController failed to initialize');

      // Start Logic
      await _injectScriptsAndLoad();

      // Polling
      _isPolling = true;
      _startNativePolling();

      // Wait for result
      return await _completer.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () => {'success': false, 'error': 'Timeout'},
      );
    } catch (e) {
      debugPrint('❌ [Session-$id] Error: $e');
      return {'success': false, 'error': e.toString()};
    } finally {
      dispose();
    }
  }

  void _setupCallbacks(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: 'BypassSuccess',
      callback: (args) {
        if (args.isNotEmpty) _onSuccess(args[0]);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'BypassFailed',
      callback: (args) {
        if (args.isNotEmpty) _onFailed(args[0]);
      },
    );
    // [RESTORE] Restore interaction logging channel
    controller.addJavaScriptHandler(
      handlerName: 'TestPageChannel',
      callback: (args) {
        if (args.isNotEmpty) debugPrint('🛡️ [JS-Log] ${args[0]}');
      },
    );
  }

  Future<void> _injectScriptsAndLoad() async {
    await _controller?.removeAllUserScripts();
    await _controller?.addUserScript(
      userScript: UserScript(
        source: "window._cf_success_marker = '$marker';",
        injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
        forMainFrameOnly: false,
      ),
    );
    await _controller?.addUserScript(
      userScript: UserScript(
        source: BypassScripts.bypassUniversal,
        injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
        forMainFrameOnly: false,
      ),
    );

    debugPrint('🛡️ [Session-$id] Navigating to target...');
    await _controller?.loadUrl(urlRequest: URLRequest(url: WebUri(targetUrl)));
  }

  void _onSuccess(dynamic result) {
    if (!_completer.isCompleted) {
      Map<String, dynamic> finalResult;
      if (result is String) {
        try {
          finalResult = Map<String, dynamic>.from(jsonDecode(result));
        } catch (_) {
          finalResult = {'data': result};
        }
      } else if (result is Map) {
        finalResult = Map<String, dynamic>.from(result);
      } else {
        finalResult = {'data': result};
      }
      debugPrint('🛡️ [Session-$id] Success!');
      _completer.complete(finalResult);
    }
  }

  void _onFailed(dynamic reason) {
    if (!_completer.isCompleted) {
      debugPrint('🛑 [Session-$id] Failed: $reason');
      _completer.complete({'success': false, 'error': reason.toString()});
    }
  }

  void _startNativePolling() async {
    int attempts = 0;
    while (attempts < 30 && _isPolling && !_completer.isCompleted) {
      await Future.delayed(const Duration(seconds: 2));
      attempts++;
      try {
        final html = await _controller?.getHtml();
        final title = await _controller?.getTitle();

        bool isCloudflare =
            (title != null &&
                (title.contains("Just a moment") ||
                    title.contains("Cloudflare"))) ||
            (html != null &&
                (html.contains("challenge-platform") ||
                    html.contains("cf-turnstile")));

        if (!isCloudflare && html != null && html.contains(marker)) {
          final url = await _controller?.getUrl();
          if (url != null) {
            final cookies = await CookieManager.instance().getCookies(url: url);
            final cookieString = cookies
                .map((c) => "${c.name}=${c.value}")
                .join("; ");
            _onSuccess({
              'success': true,
              'cookies': cookieString,
              'content': html,
              'url': url.toString(),
            });
            return;
          }
        }
      } catch (_) {}
    }
  }

  void dispose() {
    _isPolling = false;
    // Destroy the WebView strictly
    _headlessWebView?.dispose();
    _headlessWebView = null;
    _controller = null;
    debugPrint('🛡️ [Session-$id] Disposed (Headless View Destroyed)');
  }
}

class PluginAccessBypassHelper {
  static final PluginAccessBypassHelper _instance =
      PluginAccessBypassHelper._internal();
  factory PluginAccessBypassHelper() => _instance;
  PluginAccessBypassHelper._internal();

  // Semaphore / Queue
  static const int MAX_CONCURRENT_SESSIONS = 3;
  int _activeSessions = 0;
  final Queue<Completer<void>> _waitQueue = Queue();

  Future<void> _acquireSlot() async {
    if (_activeSessions < MAX_CONCURRENT_SESSIONS) {
      _activeSessions++;
      return;
    }
    final completer = Completer<void>();
    _waitQueue.add(completer);
    debugPrint(
      '🛡️ [BypassHelper] Limit reached ($MAX_CONCURRENT_SESSIONS), Queued. (Queue Size: ${_waitQueue.length})',
    );
    await completer.future;
  }

  void _releaseSlot() {
    if (_waitQueue.isNotEmpty) {
      final completer = _waitQueue.removeFirst();
      completer.complete();
    } else {
      _activeSessions--;
    }
  }

  /// Execute Bypass: Creates an Ephemeral Session, Runs it, then Destroys it.
  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? userAgent,
    String? successMarker,
    String mode = 'auto',
  }) async {
    await _acquireSlot();
    final String sessionId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final session = _BypassSession(
        id: sessionId,
        targetUrl: targetUrl,
        userAgent: userAgent,
        marker: successMarker ?? 'number_data_box',
      );

      return await session.run();
    } finally {
      _releaseSlot();
    }
  }

  // Legacy Stop method - deprecated but kept for API compatibility,
  // can't easily kill specific sessions without tracking references,
  // but since sessions are auto-disposed in finally, this might be less critical.
  // We could implement a _trackSession list if "Force Stop All" is needed.
  Future<void> stop() async {
    // For now, no-op or we could track active sessions to kill them.
    // Given "Destroy after use" paradigm, explicit stop is mostly for cancelling mid-flight.
  }

  void dispose() {}
}
