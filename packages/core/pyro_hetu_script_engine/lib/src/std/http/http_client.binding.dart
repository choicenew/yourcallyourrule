import 'package:flutter/foundation.dart';
import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/values.dart';
import '../../../delegates/delegates.dart';
import 'http_client.dart';

extension HttpBaseOptionsBinding on HttpBaseOptions {
  dynamic htFetch(String id) {
    switch (id) {
      case 'baseUrl':
        return baseUrl;
      case 'connectTimeout':
        return connectTimeout;
      case 'receiveTimeout':
        return receiveTimeout;
      case 'sendTimeout':
        return sendTimeout;
      case 'followRedirects':
        return followRedirects;
      case 'validateStatus':
        return validateStatus;
      case 'headers':
        return headers;
      case 'queryParameters':
        return queryParameters;
      default:
        throw HTError.undefined(id);
    }
  }
}

class HttpBaseOptionsClassBinding extends HTExternalClass {
  HttpBaseOptionsClassBinding() : super('HttpBaseOptions');

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'HttpBaseOptions':
        return ({positionalArgs, namedArgs}) {
          HTFunction? validateStatus = namedArgs['validateStatus'];
          final enableUnsafeSsl = namedArgs['enableUnsafeSsl'] as bool?;
          if (enableUnsafeSsl == true) {
            debugPrint('[HttpClientBinding] ⚠️ enableUnsafeSsl is TRUE!');
          }
          return HttpBaseOptions(
            baseUrl: namedArgs['baseUrl'],
            connectTimeout: namedArgs['connectTimeout'],
            receiveTimeout: namedArgs['receiveTimeout'],
            sendTimeout: namedArgs['sendTimeout'],
            followRedirects: namedArgs['followRedirects'],
            validateStatus: validateStatus == null
                ? null
                : (status) =>
                    validateStatus.call(positionalArgs: [status]) as bool,
            headers: _toMap(namedArgs['headers']),
            queryParameters: _toMap(namedArgs['queryParameters']),
            responseHeadersToRemove:
                (namedArgs['responseHeadersToRemove'] as List?)?.cast<String>(),
            domPurgeRules: (namedArgs['domPurgeRules'] as List?)
                ?.map((rule) => _toMap(rule))
                .whereType<Map<String, dynamic>>()
                .toList(),
            requestDelayMs: namedArgs['requestDelayMs'] as int?,
            enableUnsafeSsl: namedArgs['enableUnsafeSsl'] as bool?,
          );
        };
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    var i = instance as HttpBaseOptions;
    return i.htFetch(id);
  }
}

Map<String, dynamic>? _toMap(dynamic object) {
  if (object == null) return null;
  if (object is Map) return object.cast<String, dynamic>();
  if (object is HTStruct) {
    try {
      final map = <String, dynamic>{};
      for (final key in object.keys) {
        map[key.toString()] = object[key];
      }
      return map;
    } catch (e) {
      debugPrint('[HttpClientBinding] Failed to convert HTStruct to Map: $e');
    }
  }
  return null;
}

extension RequestOptionsBinding on RequestOptions {
  dynamic htFetch(String id) {
    switch (id) {
      case 'method':
        return method;
      case 'headers':
        return headers;
      case 'extra':
        return extra;
      case 'responseType':
        return responseType;
      case 'followRedirects':
        return followRedirects;
      case 'maxRedirects':
        return maxRedirects;
      case 'validateStatus':
        return validateStatus;
      default:
        throw HTError.undefined(id);
    }
  }
}

class RequestOptionsClassBinding extends HTExternalClass {
  RequestOptionsClassBinding() : super('RequestOptions');

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'RequestOptions':
        return ({positionalArgs, namedArgs}) {
          HTFunction? validateStatus = namedArgs['validateStatus'];
          return RequestOptions(
            method: namedArgs['method'],
            headers: _toMap(namedArgs['headers']),
            extra: namedArgs['extra'],
            responseType: namedArgs['responseType'],
            followRedirects: namedArgs['followRedirects'],
            maxRedirects: namedArgs['maxRedirects'],
            validateStatus: validateStatus == null
                ? null
                : (status) =>
                    validateStatus.call(positionalArgs: [status]) as bool,
          );
        };
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    var i = instance as RequestOptions;
    return i.htFetch(id);
  }
}

extension HttpResponseBinding on HttpResponse {
  dynamic htFetch(String id) {
    switch (id) {
      case 'statusCode':
        return statusCode;
      case 'statusMessage':
        return statusMessage;
      case 'data':
      case 'body':
        return data;
      case 'headers':
        return headers;
      case 'isRedirect':
        return isRedirect;
      default:
        throw HTError.undefined(id);
    }
  }
}

class HttpResponseClassBinding extends HTExternalClass {
  HttpResponseClassBinding() : super('HttpResponse');

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'HttpResponse':
        return ({positionalArgs, namedArgs}) => HttpResponse(
              statusCode: namedArgs['statusCode'],
              statusMessage: namedArgs['statusMessage'],
              data: namedArgs['data'],
              headers: namedArgs['headers'],
              isRedirect: namedArgs['isRedirect'],
            );
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    var i = instance as HttpResponse;
    return i.htFetch(id);
  }
}

extension HttpClientBinding on HttpClient {
  dynamic htFetch(String id) {
    return switch (id) {
      "request" => (HttpClient _,
              {String? path,
              dynamic data,
              dynamic options,
              dynamic queryParameters}) =>
            request(
            path: path ?? '',
            data: data,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "head" => (HttpClient _, String path,
              {String? url,
              dynamic options,
              dynamic queryParameters}) =>
            head(
            path,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "get" => (HttpClient _, String path,
              {String? url,
              dynamic options,
              dynamic queryParameters}) =>
            get(
            path,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "get_req" => (HttpClient _, String path,
              {String? url,
              dynamic options,
              dynamic queryParameters}) =>
            get(
            path,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "post" => (HttpClient _, String path,
              {String? url,
              dynamic data,
              dynamic options,
              dynamic queryParameters}) =>
            post(
            path,
            data: data,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "put" => (HttpClient _, String path,
              {String? url,
              dynamic data,
              dynamic options,
              dynamic queryParameters}) =>
            put(
            path,
            data: data,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "patch" => (HttpClient _, String path,
              {String? url,
              dynamic data,
              dynamic options,
              dynamic queryParameters}) =>
            patch(
            path,
            data: data,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      "delete_req" => (HttpClient _, String path,
              {String? url,
              dynamic data,
              dynamic options,
              dynamic queryParameters}) =>
            delete(
            path,
            data: data,
            options: _toRequestOptions(options),
            queryParameters: _toMap(queryParameters),
            ),
      _ => throw HTError.undefined(id),
    };
  }
}

RequestOptions? _toRequestOptions(dynamic object) {
  if (object == null) return null;
  if (object is RequestOptions) return object;
  // Convert HTStruct/Map to RequestOptions
  final map = _toMap(object);
  if (map != null) {
    return RequestOptions(
      method: map['method'],
      headers: _toMap(map['headers']),
      extra: _toMap(map['extra']),
      // responseType: map['responseType'], // Enum handling might be tricky, assuming compatible or null
      followRedirects: map['followRedirects'],
      maxRedirects: map['maxRedirects'],
    );
  }
  return null;
}

class HttpClientClassBinding extends HTExternalClass {
  final CookieDelegate? _cookieDelegate;
  HttpClientClassBinding([this._cookieDelegate]) : super('HttpClient');

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'HttpClient':
        return ({positionalArgs, namedArgs}) {
          var arg = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
          HttpBaseOptions? options;

          if (arg is HttpBaseOptions) {
            options = arg;
          } else if (arg != null) {
            // Try to convert Map/HTStruct to HttpBaseOptions for backward compatibility
            final map = _toMap(arg);
            if (map != null) {
              options = HttpBaseOptions(
                baseUrl: map['baseUrl'],
                connectTimeout: map['connectTimeout'],
                receiveTimeout: map['receiveTimeout'],
                sendTimeout: map['sendTimeout'],
                followRedirects: map['followRedirects'],
                // validateStatus cannot be easily passed from Map if it's a function, usually ignored in this fallback
                headers: _toMap(map['headers']),
                queryParameters: _toMap(map['queryParameters']),
              );
            }
          }
          return HttpClient(options, _cookieDelegate);
        };
      case 'HttpClient.withDelegate': // 🆕 Explicitly allow injecting a delegate if needed
        return ({positionalArgs, namedArgs}) {
          final options = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
          final delegate = namedArgs['delegate'] ?? _cookieDelegate;
          return HttpClient(
              options is HttpBaseOptions ? options : null, delegate);
        };
      default:
        throw HTError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic instance, String id,
      {bool ignoreUndefined = false}) {
    var i = instance as HttpClient;
    return i.htFetch(id);
  }
}
