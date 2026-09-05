import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/env.dart';

class ApiService {
  static final String _workerUrl = Env.cfWorkerUrl;
  static final String _apiSecret = Env.workerApiSecret;

  const ApiService();

  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('$_workerUrl/sync'),
      headers: {'Content-Type': 'application/json', 'X-API-SECRET': _apiSecret},
      body: jsonEncode({'operations': changes, 'sourceDeviceId': deviceId}),
    );
    return response.statusCode == 200;
  }

  /// 从服务器获取自上次同步以来的变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes, // Now expects ISO country codes
  }) async {
    final queryParams = {
      'since':
          since?.toIso8601String() ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      'deviceId': deviceId,
    };

    // 如果提供了国家代码，将其添加到查询参数中
    if (countryCodes != null && countryCodes.isNotEmpty) {
      queryParams['countryCodes'] = countryCodes.join(',');
    }

    final uri = Uri.parse(
      '$_workerUrl/sync',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: {'X-API-SECRET': _apiSecret});

    if (response.statusCode == 200) {
      final data = await Isolate.run(() => jsonDecode(response.body));
      return List<Map<String, dynamic>>.from(data['operations'] ?? []);
    } else {
      throw Exception(
        'Failed to get changes from the API: ${response.statusCode}',
      );
    }
  }

  /// 获取特定国家的初始数据
  ///
  /// [countryIsoCode] 国家的ISO代码，例如 'US'
  /// 返回该国家的所有号码数据
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    final uri = Uri.parse(
      '$_workerUrl/country-data',
    ).replace(queryParameters: {'countryCode': countryIsoCode});

    final response = await http.get(uri, headers: {'X-API-SECRET': _apiSecret});

    if (response.statusCode == 200) {
      final data = await Isolate.run(() => jsonDecode(response.body));
      return List<Map<String, dynamic>>.from(data['numbers'] ?? []);
    } else {
      throw Exception(
        'Failed to get initial country data: ${response.statusCode}',
      );
    }
  }

  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final uri = Uri.parse('$_workerUrl/api/v1/config/proposal-limits');
    final response = await http.get(uri, headers: {'X-API-SECRET': _apiSecret});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to get proposal limits config: ${response.statusCode}',
      );
    }
  }
}
