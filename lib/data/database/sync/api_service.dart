import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:yourcallyourrule/env.dart';

part 'api_service.g.dart';

/// ApiService Provider
@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return const ApiService();
}

/// 经过 Cloudflare 驱动下沉配对的网络传输服务 (ApiService)
class ApiService {
  static final CloudflareConfig _config = CloudflareConfig(
    workerUrl: Env.cfWorkerUrl,
    apiSecret: Env.workerApiSecret,
    accountId: '',
  );

  static final CloudflareWorkerClient _workerClient = CloudflareWorkerClient(config: _config);

  const ApiService();

  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final response = await _workerClient.post('/sync', {
      'operations': changes,
      'sourceDeviceId': deviceId,
    });
    return response != null;
  }

  /// 从服务器获取自上次同步以来的变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    final queryParams = <String, String>{
      'since': since?.toIso8601String() ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      'deviceId': deviceId,
    };

    if (countryCodes != null && countryCodes.isNotEmpty) {
      queryParams['countryCodes'] = countryCodes.join(',');
    }

    final data = await _workerClient.get('/sync', queryParams);
    if (data != null) {
      return List<Map<String, dynamic>>.from(data['operations'] ?? []);
    }
    return [];
  }

  /// 获取特定国家的初始数据
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    final data = await _workerClient.get('/country-data', {'countryCode': countryIsoCode});
    if (data != null) {
      return List<Map<String, dynamic>>.from(data['numbers'] ?? []);
    }
    return [];
  }

  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final data = await _workerClient.get('/api/v1/config/proposal-limits');
    return data ?? {};
  }
}
