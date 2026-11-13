import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:yourcallyourrule/env.dart';

part 'api_service.g.dart';

/// ApiService Provider (基于 pyro_cloudflare 微包中的 CloudflareApiService 实例)
@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService();
}

/// 宿主 App 纯网络传输服务代理层 (ApiService)
/// 实例化 pyro_cloudflare 微包中的 CloudflareApiService 并安全注入 Env 秘钥
class ApiService {
  late final CloudflareApiService _delegate;

  ApiService({CloudflareApiService? delegate}) {
    _delegate = delegate ??
        CloudflareApiService(
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
    return await _delegate.pushChanges(changes: changes, deviceId: deviceId);
  }

  /// 从服务器获取自上次同步以来的变更
  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
    List<String>? countryCodes,
  }) async {
    return await _delegate.getChanges(
      since: since,
      deviceId: deviceId,
      countryCodes: countryCodes,
    );
  }

  /// 获取特定国家的初始数据
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    return await _delegate.getInitialDataForCountry(countryIsoCode);
  }

  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    return await _delegate.getProposalLimitsConfig();
  }
}
