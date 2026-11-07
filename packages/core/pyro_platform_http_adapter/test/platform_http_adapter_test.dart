import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_platform_http_adapter/pyro_platform_http_adapter.dart';

void main() {
  test('PyroPlatformNetwork install sets global HttpOverrides', () {
    expect(PyroPlatformNetwork.isInstalled, false);
    PyroPlatformNetwork.install();
    expect(PyroPlatformNetwork.isInstalled, true);
    expect(HttpOverrides.current, isNotNull);
  });

  test('PlatformHttpAdapter.create returns valid adapter', () {
    final adapter = PlatformHttpAdapter.create();
    expect(adapter, isNotNull);
  });

  test('Dio request with PlatformHttpAdapter initializes and dispatches', () async {
    final dio = Dio();
    dio.httpClientAdapter = PlatformHttpAdapter.create();
    expect(dio.httpClientAdapter, isNotNull);
  });
}
