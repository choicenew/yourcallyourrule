import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CloudflareConfig {
  final String workerUrl;
  final String apiSecret;
  final String accountId;

  const CloudflareConfig({
    required this.workerUrl,
    required this.apiSecret,
    this.accountId = '',
  });
}

class CloudflareApiService {
  final CloudflareConfig config;
  final Dio _dio;

  CloudflareApiService({required this.config, Dio? dio})
      : _dio = dio ?? Dio() {
    _dio.options.baseUrl = config.workerUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer ${config.apiSecret}',
      'Content-Type': 'application/json',
    };
  }

  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    try {
      final response = await _dio.post(
        '/sync/push',
        data: {
          'deviceId': deviceId,
          'changes': changes,
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('[CloudflareApiService] pushChanges failed: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    try {
      final response = await _dio.get(
        '/sync/pull',
        queryParameters: {
          'deviceId': deviceId,
          if (since != null) 'since': since.toIso8601String(),
          if (countryCodes != null) 'countryCodes': countryCodes.join(','),
        },
      );
      if (response.statusCode == 200 && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      return [];
    } catch (e) {
      debugPrint('[CloudflareApiService] getChanges failed: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    try {
      final response = await _dio.get('/sync/initial/$countryIsoCode');
      if (response.statusCode == 200 && response.data is List) {
        return List<Map<String, dynamic>>.from(response.data as List);
      }
      return [];
    } catch (e) {
      debugPrint('[CloudflareApiService] getInitialDataForCountry failed: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    try {
      final response = await _dio.get('/config/limits');
      if (response.statusCode == 200 && response.data is Map) {
        return Map<String, dynamic>.from(response.data as Map);
      }
      return {};
    } catch (e) {
      debugPrint('[CloudflareApiService] getProposalLimitsConfig failed: $e');
      return {};
    }
  }
}
