import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:yourcallyourrule/env.dart';

part 'api_service.g.dart';

/// ApiService Provider (基于 pyro_cloudflare 最新微包中的 CloudflareWorkerClient 实例)
@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService();
}

/// 宿主 App 纯网络传输服务代理层 (ApiService)
/// 实例化 pyro_cloudflare 最新微包中的 CloudflareWorkerClient 并安全注入 Env 秘钥
class ApiService {
  late final CloudflareWorkerClient _delegate;

  ApiService({CloudflareWorkerClient? delegate}) {
    _delegate = delegate ??
        CloudflareWorkerClient(
          config: CloudflareConfig(
            workerUrl: Env.cfWorkerUrl,
            apiSecret: Env.workerApiSecret,
            accountId: '',
          ),
        );
  }

  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final res = await _delegate.post('/sync/push', {
      'deviceId': deviceId,
      'changes': changes,
    });
    return res != null && (res['success'] == true || res['status'] == 'ok');
  }

  /// 从服务器获取自上次同步以来的变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    final query = <String, String>{
      'deviceId': deviceId,
      if (since != null) 'since': since.toIso8601String(),
      if (countryCodes != null) 'countryCodes': countryCodes.join(','),
    };
    final res = await _delegate.get('/sync/pull', query);
    if (res != null && res['changes'] is List) {
      return List<Map<String, dynamic>>.from(res['changes'] as List);
    }
    return [];
  }

  /// 获取特定国家的初始数据
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    final res = await _delegate.get('/sync/initial/$countryIsoCode');
    if (res != null && res['data'] is List) {
      return List<Map<String, dynamic>>.from(res['data'] as List);
    }
    return [];
  }

  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final res = await _delegate.get('/config/limits');
    return res ?? {};
  }
}
