import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';
import 'js_execution_service.dart';
import 'plugin_access_bypass_service.dart';

class NativeRequestChannel {
  final JsExecutionService jsService;
  final Dio dio = Dio();

  String defaultUserAgent;

  // Hard limit for retries to avoid recursion
  static const int MAX_RETRIES = 1;

  // Log callback
  Function(String)? onLog;

  NativeRequestChannel(
    this.jsService, {
    required this.defaultUserAgent,
    this.onLog,
  }) {
    jsService.onRequestChannel = _handleRequest;
    dio.options.responseType = ResponseType.plain;
    // Allow strict status validation so 403/503 throws DioException and triggers bypass logic
    dio.options.validateStatus = (status) => status != null && status < 400;
    // Use Native Adapter for Chrome-like TLS fingerprint on Android/iOS
    dio.httpClientAdapter = NativeAdapter();
  }

  void register() {
    jsService.onRequestChannel = (dynamic message) async {
      return await _handleRequest(message);
    };
  }

  Future<dynamic> _handleRequest(dynamic message) async {
    // 1. Parse Message
    Map<String, dynamic> requestData;
    if (message is String) {
      try {
        requestData = jsonDecode(message);
      } catch (e) {
        debugPrint("❌ NativeRequestChannel: JSON decode error: $e");
        onLog?.call("❌ Native JSON Error: $e");
        return null;
      }
    } else if (message is Map) {
      requestData = Map<String, dynamic>.from(message);
    } else {
      return null;
    }

    final String url = requestData['url'] ?? '';
    // [ADAPTATION] plugindemo might not send pluginId in requestData, we might need to rely on what JS sends or external context.
    // However, for robustness, we assume JS sends it or we default to 'unknown'.
    // In plugindemo's current logic, the JS side uses window.plugin[id].handleResponse.
    final String pluginId = requestData['pluginId'] ?? 'unknown';

    if (url.isEmpty) {
      onLog?.call("❌ Native: URL is empty");
      return null;
    }

    debugPrint(
      "📡 NativeRequestChannel: Processing request for $url (Plugin: $pluginId)",
    );
    onLog?.call("📡 Native: Fetching $url (via $pluginId)");

    // [LEGACY PATTERN] Fire-and-Forget
    // Return immediately so JS does NOT block.
    // Process in background and call back.
    Future.microtask(() => _performRequest(url, requestData, 0));

    return null; // Return null to close the prompt synchronously
  }

  Future<void> _performRequest(
    String url,
    Map<String, dynamic> originalRequest,
    int retryCount,
  ) async {
    // 1. Determine User-Agent EARLY
    String userAgent = defaultUserAgent;
    if (originalRequest['headers'] is Map) {
      final headers = originalRequest['headers'] as Map;
      headers.forEach((k, v) {
        if (k.toString().toLowerCase() == 'user-agent') {
          userAgent = v.toString();
        }
      });
    }

    Map<String, dynamic> responseMap;

    try {
      // 2. Prepare Request
      Map<String, dynamic> requestHeaders = {};

      if (originalRequest['headers'] is Map) {
        requestHeaders = Map<String, dynamic>.from(originalRequest['headers']);
      }

      // Ensure the headers use the resolved userAgent
      bool uaFound = false;
      requestHeaders.forEach((k, v) {
        if (k.toLowerCase() == 'user-agent') {
          uaFound = true;
        }
      });

      if (!uaFound) {
        requestHeaders['User-Agent'] = userAgent;
      }

      // NativeAdapter handles TLS fingerprint natively - no need for manual Client Hints
      // Manual Client Hints with hardcoded values can cause version mismatch with dynamic UA

      final options = Options(
        headers: requestHeaders,
        method: originalRequest['method'] ?? 'GET',
        responseType: ResponseType.plain,
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      );

      debugPrint("📡 NativeRequestChannel: Sending Request to $url");
      debugPrint("   🔑 UA: ${requestHeaders['User-Agent']}");

      // Perform Request
      Response response;
      if (options.method == 'POST') {
        response = await dio.post(
          url,
          data: originalRequest['body'],
          options: options,
        );
      } else {
        // [ADAPTATION] Handle other methods if needed (PUT, DELETE), plugindemo supports them.
        final method = options.method?.toUpperCase();
        if (method == 'PUT') {
          response = await dio.put(
            url,
            data: originalRequest['body'],
            options: options,
          );
        } else if (method == 'DELETE') {
          response = await dio.delete(
            url,
            data: originalRequest['body'],
            options: options,
          );
        } else {
          response = await dio.get(url, options: options);
        }
      }

      // 3. Success
      final logMsg =
          "✅ NATIVE: ${response.statusCode} (Len: ${response.data.toString().length})";
      debugPrint(logMsg);
      onLog?.call(logMsg);

      // [ADAPTATION] Map fields to plugindemo structure
      responseMap = {
        'success': true,
        'status': response.statusCode,
        'responseText': response.data.toString(),
        'headers': response.headers.map,
        'requestId': originalRequest['phoneRequestId'], // [ADAPTATION]
        'phoneRequestId':
            originalRequest['phoneRequestId'], // [ADAPTATION] Redundant but safe
        'externalRequestId':
            originalRequest['externalRequestId'], // [ADAPTATION]
      };
    } on DioException catch (e) {
      // 4. Handle Cloudflare 403 / 503 OR Timeouts
      if ((e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout ||
              e.response?.statusCode == 403 ||
              e.response?.statusCode == 503) &&
          retryCount < MAX_RETRIES) {
        debugPrint(
          "⚠️ NativeRequestChannel: Challenge Detected (${e.type}/${e.response?.statusCode}). Retrying...",
        );
        onLog?.call(
          "⚠️ Challenge ${e.response?.statusCode ?? 'Timeout'}! Attempting bypass...",
        );

        // Invoke Shield Bypass (Proxy Mode)
        final bypassService = PluginAccessBypassService();
        final successMarker =
            originalRequest['successMarker']; // Extract Marker

        if (successMarker != null) {
          debugPrint(
            "🛡️ Using Plugin-Defined Success Marker: '$successMarker'",
          );
        }

        final bypassResult = await bypassService.bypass(
          url,
          userAgent: userAgent,
          successMarker: successMarker, // Pass to Service
        );

        if (bypassResult != null && bypassResult['content'] != null) {
          final content = bypassResult['content'];
          debugPrint(
            "🛡️ Returning Proxy Content to JS (Len: ${content.length})",
          );
          onLog?.call("🛡️ Bypass OK. Proxy Content Retrieved.");

          responseMap = {
            'success': true,
            'status': 200,
            'responseText': content,
            'headers': {'content-type': 'text/html; charset=utf-8'},
            'requestId': originalRequest['phoneRequestId'], // [ADAPTATION]
            'phoneRequestId': originalRequest['phoneRequestId'], // [ADAPTATION]
            'externalRequestId':
                originalRequest['externalRequestId'], // [ADAPTATION]
            'proxy': true,
          };

          debugPrint(
            "🛡️ Native Content Preview: ${content.substring(0, content.length > 500 ? 500 : content.length)}...",
          );
        } else if (bypassResult != null && bypassResult['cookies'] != null) {
          onLog?.call("🛡️ Bypass OK. Got Cookies.");
          // Retry with cookies
          if (originalRequest['headers'] == null) {
            originalRequest['headers'] = {};
          }
          originalRequest['headers']['Cookie'] = bypassResult['cookies'];
          originalRequest['headers']['User-Agent'] = userAgent;

          // Recursive retry
          await _performRequest(url, originalRequest, retryCount + 1);
          return;
        } else {
          onLog?.call("❌ Bypass Failed. No content/cookies retrieved.");
          responseMap = {
            'success': false,
            'error': "Bypass Failed",
            'status': 503,
            'requestId': originalRequest['phoneRequestId'], // [ADAPTATION]
            'phoneRequestId': originalRequest['phoneRequestId'], // [ADAPTATION]
          };
        }
      } else {
        String errorMsg = "Dio Error: ${e.message}";
        if (e.message == null) {
          errorMsg =
              "Dio Error (Null Message): Type=${e.type}, Error=${e.error}";
        }
        onLog?.call("❌ $errorMsg");
        debugPrint("❌ NativeRequestChannel Detailed Error: $e");

        responseMap = {
          'success': false,
          'error': errorMsg,
          'status': e.response?.statusCode,
          'type': e.type.toString(),
          'requestId': originalRequest['phoneRequestId'], // [ADAPTATION]
          'phoneRequestId': originalRequest['phoneRequestId'], // [ADAPTATION]
          'externalRequestId':
              originalRequest['externalRequestId'], // [ADAPTATION]
        };
      }
    } catch (e) {
      onLog?.call("❌ Unknown Error: $e");
      responseMap = {
        'success': false,
        'error': "Unknown Error: $e",
        'requestId': originalRequest['phoneRequestId'], // [ADAPTATION]
        'phoneRequestId': originalRequest['phoneRequestId'], // [ADAPTATION]
      };
    }

    // 5. Send Result Back to JS (Legacy Callback)
    await _sendResponseToJs(responseMap, originalRequest['pluginId']);
  }

  Future<void> _sendResponseToJs(
    Map<String, dynamic> responseData,
    String? pluginId,
  ) async {
    // [ADAPTATION] Fallback to 'truecallerPluginchannel' if ID is missing (as per plugindemo logic)
    // But since this is a cleaner refactor, we prefer the actual ID.
    // However, to keep safety:
    final actualPluginId = pluginId ?? 'truecallerPluginchannel';

    try {
      // [USER REQUEST] Print Full HTML Content for Verification
      if (responseData.containsKey('responseText')) {
        final htmlContent = responseData['responseText'].toString();
        debugPrint(
          "📄 [NATIVE HTML DUMP START] --------------------------------",
        );
        debugPrint(htmlContent); // Print raw HTML
        debugPrint(
          "📄 [NATIVE HTML DUMP END] ----------------------------------",
        );
      }

      final jsonResponse = jsonEncode(responseData);

      debugPrint("📦 Sending Native Response to JS (Plugin: $actualPluginId)");

      // Ensure quotes are escaped by jsonEncode
      // Pass the JSON object literal directly to the function
      final script =
          "if(window.plugin && window.plugin['$actualPluginId']) { window.plugin['$actualPluginId'].handleResponse($jsonResponse); } else { console.warn('Plugin $actualPluginId not found for response'); }";

      await jsService.sendNativeResponse(script);
    } catch (e) {
      debugPrint("❌ Failed to send response to JS: $e");
      onLog?.call("❌ Failed to send response: $e");
    }
  }

  /// Force stop any active bypass operations (cleanup)
  Future<void> cleanup() async {
    await PluginAccessBypassService().stop();
  }
}
