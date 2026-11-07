import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:native_dio_adapter/native_dio_adapter.dart';

import 'win_http_adapter.dart';

HttpClientAdapter createPlatformAdapter({
  void Function(HttpClient)? onHttpClientCreate,
}) {
  // 1. 第一优先级：iOS、Android、macOS 优先尝试 NativeAdapter (Cronet / Cupertino)
  if (Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
    try {
      return NativeAdapter();
    } catch (e) {
      debugPrint(
          '⚠️ [PlatformHttpAdapter] NativeAdapter initialization failed: $e. Fallback to IOHttpClientAdapter.');
    }
  }

  // 2. 第二优先级：Windows 尝试 WinHttpDioAdapter (Schannel TLS)
  else if (Platform.isWindows) {
    try {
      return WinHttpDioAdapter(onHttpClientCreate: onHttpClientCreate);
    } catch (e) {
      debugPrint(
          '⚠️ [PlatformHttpAdapter] WinHttpDioAdapter initialization failed: $e. Fallback to IOHttpClientAdapter.');
    }
  }

  // 3. 最终托底：退化为 Dart 默认的 IOHttpClientAdapter
  final adapter = IOHttpClientAdapter();
  if (onHttpClientCreate != null) {
    adapter.createHttpClient = () {
      final client = HttpClient();
      onHttpClientCreate(client);
      return client;
    };
  }
  return adapter;
}
