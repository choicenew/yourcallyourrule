import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'bypass_scripts.dart';

class PluginAccessBypassHelper {
  static final PluginAccessBypassHelper _instance =
      PluginAccessBypassHelper._internal();
  factory PluginAccessBypassHelper() => _instance;

  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _controller;
  Completer<Map<String, dynamic>?>? _currentBypassCompleter;
  bool _isHeadlessRunning = false;
  Completer<void>? _initCompleter;

  PluginAccessBypassHelper._internal();

  // Initialize the Headless WebView on demand, persisting it as a Singleton.
  Future<void> _ensureInitialized() async {
    if (_headlessWebView != null && _isHeadlessRunning && _controller != null) {
      return;
    }

    if (_initCompleter != null && !_initCompleter!.isCompleted) {
      await _initCompleter!.future;
      return;
    }

    _initCompleter = Completer<void>();

    try {
      _headlessWebView = HeadlessInAppWebView(
        initialSize: const Size(1080, 1920),
        initialUrlRequest: URLRequest(url: WebUri('about:blank')),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          domStorageEnabled: true,
          databaseEnabled: true,
          useHybridComposition: true,
          mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
          allowFileAccessFromFileURLs: true,
          allowUniversalAccessFromFileURLs: true,
        ),
        // [HYBRID] Restore Complex Script for Anti-Fingerprinting & Interaction
        initialUserScripts: UnmodifiableListView<UserScript>([
          UserScript(
            source: BypassScripts.bypassUniversal,
            injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
            forMainFrameOnly: false,
          ),
        ]),
        onWebViewCreated: (controller) {
          _controller = controller;
          debugPrint('🛡️ [BypassHelper] Headless WebView Created');

          // [CALLBACK] Script-based success signaling
          controller.addJavaScriptHandler(
            handlerName: 'BypassSuccess',
            callback: (args) {
              if (args.isNotEmpty) _onBypassSuccess(args[0]);
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'TestPageChannel',
            callback: (args) {
              if (args.isNotEmpty) debugPrint('🛡️ [JS-Log] ${args[0]}');
            },
          );
        },
        onLoadStop: (controller, url) async {
          debugPrint('🛡️ [BypassHelper] Page Loaded: $url');
        },
        onConsoleMessage: (controller, consoleMessage) {
          // Optional: Forward console messages
        },
      );

      debugPrint('🛡️ [BypassHelper] Starting Headless WebView...');
      await _headlessWebView?.run();
      _isHeadlessRunning = true;

      // Wait for controller assignment
      int attempts = 0;
      while (_controller == null && attempts < 20) {
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }

      if (_controller == null) {
        debugPrint('⚠️ [BypassHelper] Controller not assigned after run()');
      }

      _initCompleter!.complete();
    } catch (e) {
      debugPrint('❌ [BypassHelper] Initialization failed: $e');
      _initCompleter!.completeError(e);
      _headlessWebView = null;
      _isHeadlessRunning = false;
    } finally {
      if (_headlessWebView == null) _initCompleter = null;
    }
  }

  Future<void> enableManualMode() async {
    await _controller?.evaluateJavascript(
      source: "window._cf_manual_mode = true;",
    );
  }

  Future<void> disableManualMode() async {
    await _controller?.evaluateJavascript(
      source:
          "window._cf_manual_mode = false; window._hasClickedGlobal = false;",
    );
  }

  /// Execute Bypass with Hybrid Strategy (Script + Polling)
  Future<Map<String, dynamic>?> executeBypass(
    String targetUrl, {
    String? userAgent,
    String? successMarker,
    String mode = 'auto',
  }) async {
    // 1. Ensure Persistent Headless Service is Ready
    await _ensureInitialized();

    if (_controller == null) {
      return {'success': false, 'error': 'Headless WebView failed to start'};
    }

    if (userAgent != null) {
      await _controller?.setSettings(
        settings: InAppWebViewSettings(userAgent: userAgent),
      );
    }

    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      _currentBypassCompleter!.complete(null);
    }
    _currentBypassCompleter = Completer<Map<String, dynamic>?>();

    final marker = successMarker ?? 'number_data_box';
    String finalUrl = targetUrl;
    if (!targetUrl.startsWith("about:")) {
      finalUrl =
          targetUrl +
          (targetUrl.contains('?') ? '&' : '?') +
          'successMarker=$marker';
    }

    debugPrint('🛡️ [BypassHelper] Navigating to: $finalUrl');
    await _controller?.loadUrl(urlRequest: URLRequest(url: WebUri(finalUrl)));

    // [HYBRID] Start Native Polling Loop as Backup for "Automatic Termination"
    // This ensures that if the script fails to call back, we still catch the success.
    _startNativePolling(marker);

    try {
      return await _currentBypassCompleter!.future.timeout(
        const Duration(seconds: 60),
        onTimeout: () => {'success': false, 'error': 'Timeout'},
      );
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  void _startNativePolling(String marker) async {
    int attempts = 0;
    // Check every 2 seconds for up to 60 seconds
    while (attempts < 30) {
      if (_currentBypassCompleter == null ||
          _currentBypassCompleter!.isCompleted) {
        return;
      }

      await Future.delayed(const Duration(seconds: 2));
      attempts++;

      try {
        // [AUTO-TERMINATE] Check if content is already loaded in WebView
        final html = await _controller?.getHtml();
        if (html != null && html.contains(marker)) {
          debugPrint(
            '🛡️ [BypassHelper] Native Polling found marker: "$marker"',
          );

          final url = await _controller?.getUrl();
          if (url != null) {
            final cookies = await CookieManager.instance().getCookies(url: url);
            final cookieString = cookies
                .map((c) => "${c.name}=${c.value}")
                .join("; ");

            _onBypassSuccess({
              'success': true,
              'cookies': cookieString,
              'content': html, // Optional, depending on if we need full content
              'url': url.toString(),
            });
          }
          return;
        }
      } catch (e) {
        // Ignore polling errors
      }
    }
  }

  void _onBypassSuccess(dynamic result) {
    if (_currentBypassCompleter != null &&
        !_currentBypassCompleter!.isCompleted) {
      try {
        Map<String, dynamic> finalResult;
        if (result is String) {
          finalResult = Map<String, dynamic>.from(jsonDecode(result));
        } else if (result is Map) {
          finalResult = Map<String, dynamic>.from(result);
        } else {
          finalResult = {'data': result};
        }
        debugPrint('🛡️ [BypassHelper] ✅ Bypass Success! (Terminating)');
        _currentBypassCompleter!.complete(finalResult);
      } catch (e) {
        _currentBypassCompleter!.complete({
          'success': false,
          'error': e.toString(),
        });
      }
    }
  }

  void dispose() {
    // Only dispose on app termination
    _headlessWebView?.dispose();
    _headlessWebView = null;
    _controller = null;
    _isHeadlessRunning = false;
    _initCompleter = null;
  }
}
