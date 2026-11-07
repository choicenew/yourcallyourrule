import 'dart:convert';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' as html_parser;
import '../../../delegates/delegates.dart';

enum HttpResponseType { json, stream, plain, bytes }

class HttpBaseOptions {
  final String? baseUrl;
  final int? connectTimeout;
  final int? receiveTimeout;
  final int? sendTimeout;
  final bool? followRedirects;
  final ValidateStatus? validateStatus;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final List<String>?
      responseHeadersToRemove; // 🆕 Plugin-specified headers to remove
  final List<Map<String, dynamic>>?
      domPurgeRules; // 🆕 Plugin-specified DOM cleanup rules
  final int? requestDelayMs; // 🆕 Delay between requests (rate limiting)
  final bool? enableUnsafeSsl; // 🆕 Plugin-requested SSL bypass

  const HttpBaseOptions({
    this.baseUrl,
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
    this.followRedirects,
    this.validateStatus,
    this.headers,
    this.queryParameters,
    this.responseHeadersToRemove,
    this.domPurgeRules,
    this.requestDelayMs,
    this.enableUnsafeSsl,
  });
}

class RequestOptions {
  final String? method;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? extra;
  final HttpResponseType? responseType;
  final bool? followRedirects;
  final int? maxRedirects;
  final ValidateStatus? validateStatus;

  const RequestOptions({
    this.method,
    this.headers,
    this.extra,
    this.responseType,
    this.followRedirects,
    this.maxRedirects,
    this.validateStatus,
  });

  RequestOptions copyWith({
    String? method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    HttpResponseType? responseType,
    bool? followRedirects,
    int? maxRedirects,
    ValidateStatus? validateStatus,
  }) {
    return RequestOptions(
      method: method ?? this.method,
      headers: headers ?? this.headers,
      extra: extra ?? this.extra,
      responseType: responseType ?? this.responseType,
      followRedirects: followRedirects ?? this.followRedirects,
      maxRedirects: maxRedirects ?? this.maxRedirects,
      validateStatus: validateStatus ?? this.validateStatus,
    );
  }
}

Options optionsWrapperToDioOptions(RequestOptions options) {
  return Options(
    method: options.method,
    headers: options.headers,
    extra: options.extra,
    responseType: switch (options.responseType) {
      HttpResponseType.json => ResponseType.json,
      HttpResponseType.stream => ResponseType.stream,
      HttpResponseType.plain => ResponseType.plain,
      HttpResponseType.bytes => ResponseType.bytes,
      _ => null,
    },
    followRedirects: options.followRedirects,
    maxRedirects: options.maxRedirects,
    validateStatus: options.validateStatus,
  );
}

class HttpResponse {
  final int statusCode;
  final String statusMessage;
  final dynamic data;
  final Map<String, dynamic> headers;
  final bool isRedirect;

  const HttpResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
    required this.headers,
    required this.isRedirect,
  });
}

HttpResponse dioResponseToResponseWrapper(Response response) {
  return HttpResponse(
    statusCode: response.statusCode ?? 0,
    statusMessage: response.statusMessage ?? "",
    data: response.data,
    headers: response.headers.map,
    isRedirect: response.isRedirect,
  );
}

class HttpClient {
  late final Dio _dio;
  final HttpBaseOptions? _baseOptions;
  final CookieDelegate? _cookieDelegate; // 🆕 注入 Cookie 代理

  HttpClient([HttpBaseOptions? options, this._cookieDelegate])
      : _baseOptions = options {
    _dio = Dio(
      options != null
          ? BaseOptions(
              baseUrl: options.baseUrl ?? "",
              connectTimeout: options.connectTimeout != null
                  ? Duration(seconds: options.connectTimeout!)
                  : null,
              receiveTimeout: options.receiveTimeout != null
                  ? Duration(seconds: options.receiveTimeout!)
                  : null,
              sendTimeout: options.sendTimeout != null
                  ? Duration(seconds: options.sendTimeout!)
                  : null,
              followRedirects: options.followRedirects,
              validateStatus: (status) => status != null && status < 500,
              headers: options.headers,
              queryParameters: options.queryParameters,
            )
          : BaseOptions(
              validateStatus: (status) => status != null && status < 500,
            ),
    );

    // [FIX] Allow insecure certificates via option (plugin controlled)
    if (_baseOptions?.enableUnsafeSsl == true) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = io.HttpClient();
        client.badCertificateCallback =
            (io.X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // 🔑 注入全自动 Cookie 同步拦截器
    if (_cookieDelegate != null) {
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final url = options.uri.toString();
          final systemCookies = await _cookieDelegate.getCookies(url);
          if (systemCookies != null && systemCookies.isNotEmpty) {
            // 将系统 Cookie 合并到当前请求头
            final existing = options.headers['cookie'] ?? '';
            options.headers['cookie'] =
                existing.isEmpty ? systemCookies : '$existing; $systemCookies';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          final url = response.requestOptions.uri.toString();
          final setCookies = response.headers['set-cookie'];
          if (setCookies != null && setCookies.isNotEmpty) {
            // 将 Dio 拿到的 Cookie 同步回系统 CookieManager
            await _cookieDelegate.setCookies(url, setCookies);
          }
          return handler.next(response);
        },
      ));
    }
  }

  Future<HttpResponse> request({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    // 🔑 Rate limiting: delay if configured
    final delay = _baseOptions?.requestDelayMs;
    if (delay != null && delay > 0) {
      await Future.delayed(Duration(milliseconds: delay));
    }

    final res = await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options != null ? optionsWrapperToDioOptions(options) : null,
    );

    // 🔑 SMART HANDLING based on use case:
    // - HTML scraping (with domPurgeRules): convert to String and purge
    // - JSON APIs (no domPurgeRules): preserve original data structure

    final purgeRules = _baseOptions?.domPurgeRules;
    if (purgeRules != null && purgeRules.isNotEmpty) {
      // HTML Scraping: decode and purge
      String htmlBody;
      if (res.data is String) {
        htmlBody = res.data as String;
      } else if (res.data is List<int>) {
        htmlBody = utf8.decode(res.data as List<int>, allowMalformed: true);
      } else {
        htmlBody = res.data?.toString() ?? '';
      }

      final cleanedBody = _purgeHtmlContent(htmlBody, purgeRules);

      return HttpResponse(
        statusCode: res.statusCode ?? 0,
        statusMessage: res.statusMessage ?? "",
        data: cleanedBody,
        headers: res.headers.map,
        isRedirect: res.isRedirect,
      );
    } else {
      // JSON API: preserve original structure
      return dioResponseToResponseWrapper(res);
    }
  }

  Future<HttpResponse> head(
    String path, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    options ??= const RequestOptions();
    return await request(
      path: path,
      queryParameters: queryParameters,
      options: options.copyWith(method: "HEAD"),
    );
  }

  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    // Don't pass empty Options - let BaseOptions apply
    return await request(
      path: path,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "GET"),
    );
  }

  Future<HttpResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    return await request(
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "POST"),
    );
  }

  Future<HttpResponse> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    return await request(
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "PUT"),
    );
  }

  Future<HttpResponse> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    return await request(
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "DELETE"),
    );
  }

  Future<HttpResponse> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    RequestOptions? options,
  }) async {
    return await request(
      path: path,
      data: data,
      queryParameters: queryParameters,
      options: options?.copyWith(method: "PATCH"),
    );
  }

  // 🔑 Remove DOM elements from HTML content based on plugin rules
  // Matches webview_request_interceptor.dart: ALWAYS parse and clean, no content-type check
  String _purgeHtmlContent(
      String htmlString, List<Map<String, dynamic>> purgeRules) {
    debugPrint(
        '[HttpClient] Starting DOM purge with ${purgeRules.length} rules...');

    try {
      var document = html_parser.parse(htmlString);
      bool modified = false;

      // Apply each purge rule
      for (final rule in purgeRules) {
        final type = rule['type'] as String?;
        final selector = rule['selector'] as String?;

        if (type == 'remove' && selector != null) {
          final elements = document.querySelectorAll(selector);
          final contentMatch = rule['contentMatch'] as String?;

          int removedCount = 0;
          for (final element in elements) {
            // If contentMatch is specified, check if element content matches
            // If contentMatch is specified, check if element content matches
            if (contentMatch == null ||
                element.innerHtml.contains(contentMatch)) {
              element.remove();
              removedCount++;
              modified = true;
            }
          }

          if (removedCount > 0) {
            debugPrint(
                '[HttpClient] Purge rule removed $removedCount element(s) matching "$selector"');
          }
        }
      }

      if (modified) {
        debugPrint('[HttpClient] DOM purge completed, HTML modified');
        return document.outerHtml;
      } else {
        debugPrint('[HttpClient] DOM purge completed, no modifications');
        return htmlString;
      }
    } catch (e) {
      debugPrint('[HttpClient] DOM purge failed: $e, returning original');
      return htmlString;
    }
  }
}
