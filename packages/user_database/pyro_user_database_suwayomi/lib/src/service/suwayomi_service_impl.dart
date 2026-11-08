import 'package:dio/dio.dart';
import '../domain/suwayomi_service.dart';

/// Suwayomi (Tachidesk) 服务端通讯的真实落地实现类
class SuwayomiServiceImpl implements SuwayomiService {
  final Dio _dio;
  String? _baseUrl;
  String? _authToken;
  bool _connected = false;

  SuwayomiServiceImpl({Dio? dio}) : _dio = dio ?? Dio();

  @override
  Future<bool> connect({
    required String host,
    required int port,
    String? token,
  }) async {
    final sanitizedHost = host.startsWith('http://') || host.startsWith('https://')
        ? host
        : 'http://$host';
    _baseUrl = '$sanitizedHost:$port/api/v1';
    _authToken = token;

    final options = Options(
      headers: {
        if (_authToken != null && _authToken!.isNotEmpty)
          'Authorization': 'Bearer $_authToken',
        'Accept': 'application/json',
      },
      sendTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    try {
      final response = await _dio.get('$_baseUrl/category', options: options);
      _connected = response.statusCode == 200;
      return _connected;
    } catch (_) {
      _connected = false;
      return false;
    }
  }

  @override
  Future<bool> isConnected() async {
    if (!_connected || _baseUrl == null) return false;
    try {
      final response = await _dio.get(
        '$_baseUrl/category',
        options: Options(
          headers: {
            if (_authToken != null && _authToken!.isNotEmpty)
              'Authorization': 'Bearer $_authToken',
          },
        ),
      );
      _connected = response.statusCode == 200;
      return _connected;
    } catch (_) {
      _connected = false;
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLibrary() async {
    if (_baseUrl == null) {
      throw StateError('SuwayomiService is not connected. Call connect() first.');
    }

    try {
      final response = await _dio.get(
        '$_baseUrl/manga',
        options: Options(
          headers: {
            if (_authToken != null && _authToken!.isNotEmpty)
              'Authorization': 'Bearer $_authToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List).cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch library from Suwayomi: $e');
    }
  }

  @override
  Future<void> syncProgress(String mangaId, int chapterIndex) async {
    if (_baseUrl == null) {
      throw StateError('SuwayomiService is not connected. Call connect() first.');
    }

    try {
      await _dio.patch(
        '$_baseUrl/manga/$mangaId/chapter/$chapterIndex',
        data: {'read': true, 'lastPageRead': 0},
        options: Options(
          headers: {
            if (_authToken != null && _authToken!.isNotEmpty)
              'Authorization': 'Bearer $_authToken',
            'Content-Type': 'application/json',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to sync chapter progress to Suwayomi: $e');
    }
  }

  @override
  void dispose() {
    _connected = false;
    _dio.close();
  }
}
