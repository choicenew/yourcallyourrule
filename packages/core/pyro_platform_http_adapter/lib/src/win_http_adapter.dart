import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:win_http/win_http.dart';

/// WinHttpDioAdapter: 将 win_http 的 WinHttpClient 封装为 Dio 的 HttpClientAdapter
/// 仅在 Windows 平台上使用以走原生的 Schannel TLS 栈规避 JA3 拦截。
/// 如果 WinHttp 初始化或执行过程发生错误，会自动平滑降级退化为 Dart 默认的 IOHttpClientAdapter。
class WinHttpDioAdapter implements HttpClientAdapter {
  http.Client? _winHttpClient;
  final IOHttpClientAdapter _fallbackAdapter;

  WinHttpDioAdapter({void Function(HttpClient)? onHttpClientCreate})
      : _fallbackAdapter = IOHttpClientAdapter() {
    if (onHttpClientCreate != null) {
      _fallbackAdapter.createHttpClient = () {
        final client = HttpClient();
        onHttpClientCreate(client);
        return client;
      };
    }

    if (Platform.isWindows) {
      try {
        _winHttpClient = WinHttpClient.defaultConfiguration();
      } catch (e) {
        debugPrint(
            '⚠️ [WinHttpDioAdapter] Failed to initialize WinHttpClient: $e. Falling back to IOHttpClientAdapter.');
        _winHttpClient = null;
      }
    }
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final client = _winHttpClient;
    if (client == null) {
      return _fallbackAdapter.fetch(options, requestStream, cancelFuture);
    }

    try {
      final reqUri = options.uri;
      final method = options.method;
      final data = options.data;

      http.BaseRequest request;
      if (requestStream != null) {
        final bytesBuilder = BytesBuilder(copy: false);
        await for (final chunk in requestStream) {
          bytesBuilder.add(chunk);
        }
        final requestWithBody = http.Request(method, reqUri);
        requestWithBody.bodyBytes = bytesBuilder.takeBytes();
        request = requestWithBody;
      } else if (data != null) {
        final requestWithBody = http.Request(method, reqUri);
        final dynamic dataVal = data;
        if (dataVal is String) {
          requestWithBody.body = dataVal;
        } else if (dataVal is List<int>) {
          requestWithBody.bodyBytes = Uint8List.fromList(dataVal);
        } else {
          requestWithBody.body = jsonEncode(dataVal);
        }
        request = requestWithBody;
      } else {
        request = http.Request(method, reqUri);
      }

      options.headers.forEach((key, value) {
        if (value != null) {
          request.headers[key] = value.toString();
        }
      });

      if (options.contentType != null) {
        request.headers['Content-Type'] = options.contentType!;
      }

      final http.StreamedResponse streamedResponse;
      if (cancelFuture != null) {
        final completer = Completer<http.StreamedResponse>();
        unawaited(
          client.send(request).then(
            completer.complete,
            onError: completer.completeError,
          ),
        );
        unawaited(
          cancelFuture.then((_) {
            if (!completer.isCompleted) {
              completer.completeError(
                DioException(
                  requestOptions: options,
                  type: DioExceptionType.cancel,
                  error: 'Request was cancelled',
                ),
              );
            }
          }),
        );
        streamedResponse = await completer.future;
      } else {
        streamedResponse = await client.send(request);
      }

      final responseHeaders = <String, List<String>>{};
      streamedResponse.headers.forEach((key, value) {
        responseHeaders[key] = [value];
      });

      return ResponseBody(
        streamedResponse.stream.cast<Uint8List>(),
        streamedResponse.statusCode,
        headers: responseHeaders,
        statusMessage: streamedResponse.reasonPhrase,
        isRedirect: streamedResponse.isRedirect,
      );
    } catch (e) {
      debugPrint(
          '⚠️ [WinHttpDioAdapter] WinHttp fetch failed: $e. Retrying via IOHttpClientAdapter.');
      return _fallbackAdapter.fetch(options, requestStream, cancelFuture);
    }
  }

  @override
  void close({bool force = false}) {
    _winHttpClient?.close();
    _fallbackAdapter.close(force: force);
  }
}
