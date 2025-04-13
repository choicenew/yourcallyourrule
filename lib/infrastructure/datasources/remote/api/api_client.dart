import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../common/constants/app_constants.dart';
import '../../../../common/error/exceptions.dart';

/// API客户端
/// 负责与远程服务器进行通信
class ApiClient {
  final http.Client _httpClient;
  final String _baseUrl;
  
  ApiClient({
    required http.Client httpClient,
    required String baseUrl,
  }) : _httpClient = httpClient,
       _baseUrl = baseUrl;
  
  /// 发送GET请求
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final uri = Uri.parse('$_baseUrl/$endpoint').replace(queryParameters: queryParams);
      
      final response = await _httpClient.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));
      
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('网络请求失败: $e');
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw ServerException('服务器请求失败: $e');
    }
  }
  
  /// 发送POST请求
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse('$_baseUrl/$endpoint');
      
      final response = await _httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));
      
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('网络请求失败: $e');
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw ServerException('服务器请求失败: $e');
    }
  }
  
  /// 发送PUT请求
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse('$_baseUrl/$endpoint');
      
      final response = await _httpClient.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? json.encode(body) : null,
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));
      
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('网络请求失败: $e');
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw ServerException('服务器请求失败: $e');
    }
  }
  
  /// 发送DELETE请求
  Future<dynamic> delete(String endpoint) async {
    try {
      final uri = Uri.parse('$_baseUrl/$endpoint');
      
      final response = await _httpClient.delete(
        uri,
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(milliseconds: AppConstants.connectionTimeout));
      
      return _processResponse(response);
    } on http.ClientException catch (e) {
      throw NetworkException('网络请求失败: $e');
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw ServerException('服务器请求失败: $e');
    }
  }
  
  /// 处理响应
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw ServerException('未授权访问', code: '401');
    } else if (response.statusCode == 403) {
      throw ServerException('禁止访问', code: '403');
    } else if (response.statusCode == 404) {
      throw ServerException('资源不存在', code: '404');
    } else if (response.statusCode >= 500) {
      throw ServerException('服务器错误', code: response.statusCode.toString());
    } else {
      throw ServerException(
        '请求失败: ${response.statusCode}',
        code: response.statusCode.toString(),
      );
    }
  }
}