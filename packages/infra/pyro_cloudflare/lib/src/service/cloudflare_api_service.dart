import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import '../config/cloudflare_config.dart';
import '../worker/cloudflare_worker_client.dart';

/// Cloudflare REST API 标准独立服务 (CloudflareApiService)
/// 专职处理增量同步、国家数据包与配额限制查询，纯下沉无状态工具服务
class CloudflareApiService {
  final CloudflareConfig config;
  final CloudflareWorkerClient _workerClient;

  CloudflareApiService({
    required this.config,
    CloudflareWorkerClient? workerClient,
    http.Client? httpClient,
  }) : _workerClient = workerClient ?? CloudflareWorkerClient(config: config, httpClient: httpClient);

  /// 推送增量变更至 Cloudflare Worker
  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final res = await _workerClient.post('/sync', {
      'operations': changes,
      'sourceDeviceId': deviceId,
    });
    return res != null;
  }

  /// 从服务器拉取自上次同步点以来的增量变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    final queryParams = <String, String>{
      'since': since?.toIso8601String() ?? DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
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

  /// 获取指定 ISO 国家代码的初始号码数据
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(String countryIsoCode) async {
    final data = await _workerClient.get('/country-data', {'countryCode': countryIsoCode});
    if (data != null) {
      return List<Map<String, dynamic>>.from(data['numbers'] ?? []);
    }
    return [];
  }

  /// 获取提案限额配置
  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final data = await _workerClient.get('/api/v1/config/proposal-limits');
    return data ?? <String, dynamic>{};
  }
}
