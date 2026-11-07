import 'package:dio/dio.dart';

HttpClientAdapter createPlatformAdapter({
  dynamic onHttpClientCreate,
}) {
  // Web 平台防护退化
  return HttpClientAdapter();
}
