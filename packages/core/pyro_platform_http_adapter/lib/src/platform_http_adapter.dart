import 'dart:io';
import 'package:dio/dio.dart';

import 'platform_http_adapter_io.dart'
    if (dart.library.html) 'platform_http_adapter_mobile.dart'
    as adapter;

/// PlatformHttpAdapter: 条件 import 跨平台统一入口
/// - Windows: WinHttpDioAdapter (Schannel TLS)
/// - Android/iOS/macOS: NativeAdapter (Cronet/Cupertino)
/// - Linux/Web/其他: IOHttpClientAdapter
class PlatformHttpAdapter {
  static HttpClientAdapter create({
    void Function(HttpClient)? onHttpClientCreate,
  }) {
    return adapter.createPlatformAdapter(
      onHttpClientCreate: onHttpClientCreate,
    );
  }
}
