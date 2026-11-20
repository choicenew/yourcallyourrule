import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_central_database_cloudflare/pyro_central_database_cloudflare.dart';
import 'package:pyro_central_database_hub/pyro_central_database_hub.dart';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:yourcallyourrule/env.dart';
import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';
import '../app_coordinator.dart';

final centralDatabaseHubProvider = Provider<CentralDatabaseHub>((ref) => CentralDatabaseHub());

final centralDatabaseExchangeConnectorProvider = Provider<CentralDatabaseExchangeConnector>((ref) {
  final coordinator = ref.watch(appCoordinatorProvider);
  final hub = ref.watch(centralDatabaseHubProvider);
  return CentralDatabaseExchangeConnector(
    ref: ref,
    coordinator: coordinator,
    centralDatabaseHub: hub,
  );
});

/// 中央公共数据库中枢连接器 (CentralDatabaseExchangeConnector)
/// 专职负责：
/// 1. 唯一持有开发者云端基础设施凭证 (Env.cfWorkerUrl, Env.workerApiSecret)
/// 2. 挂载与调度 CentralDatabaseHub 及 CloudflareCentralDbAdapter 物理驱动
/// 3. 执行系统级公共号段、国家初始化规则库、众包删除审核与频次限制配置下发
/// 4. 严格杜绝凭证向外部或用户个人库 (user_database) 泄漏
class CentralDatabaseExchangeConnector {
  final Ref ref;
  final AppCoordinator coordinator;
  final CentralDatabaseHub centralDatabaseHub;

  const CentralDatabaseExchangeConnector({
    required this.ref,
    required this.coordinator,
    required this.centralDatabaseHub,
  });

  void initialize() {
    // 注册远程中央数据库适配器 (仅中央公共库享有开发者 Cloudflare 基础设施权限)
    try {
      centralDatabaseHub.register(
        CloudflareCentralDbAdapter(
          config: CloudflareConfig(
            workerUrl: Env.cfWorkerUrl,
            apiSecret: Env.workerApiSecret,
            accountId: '',
          ),
        ),
      );
      debugPrint('[CentralDatabaseConnector] Registered CloudflareCentralDbAdapter');
    } catch (e) {
      debugPrint('[CentralDatabaseConnector] Error registering CentralDatabase Adapters: $e');
    }

    // 远程中央数据库拉取事件管道
    coordinator.on('remote_central_db_update', (payload) async {
      final countryIsoCode = payload['countryIsoCode'] as String? ?? '';
      debugPrint('[CentralDatabaseConnector] Remote Central DB update triggered for country: $countryIsoCode');
      await syncCentralDatabase(countryIsoCode: countryIsoCode);
    });
  }

  /// 宿主协调层专属受控 Cloudflare 传输 Client (用于中央数据库及公共配置请求)
  CloudflareWorkerClient get workerClient {
    return CloudflareWorkerClient(
      config: CloudflareConfig(
        workerUrl: Env.cfWorkerUrl,
        apiSecret: Env.workerApiSecret,
        accountId: '',
      ),
    );
  }

  /// 推送变更至远程 Cloudflare Worker (如众包删除提议)
  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final res = await workerClient.post('/sync/push', {
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
    final res = await workerClient.get('/sync/pull', query);
    if (res != null && res['changes'] is List) {
      return List<Map<String, dynamic>>.from(res['changes'] as List);
    }
    return [];
  }

  /// 获取特定国家的初始规则数据 (Worker API 通道)
  Future<List<Map<String, dynamic>>> getInitialDataForCountry(
    String countryIsoCode,
  ) async {
    final res = await workerClient.get('/sync/initial/$countryIsoCode');
    if (res != null && res['data'] is List) {
      return List<Map<String, dynamic>>.from(res['data'] as List);
    }
    return [];
  }

  /// 获取云端提案限制与投票配置
  Future<Map<String, dynamic>> getProposalLimitsConfig() async {
    final res = await workerClient.get('/config/limits');
    return res ?? {};
  }

  /// 执行远程中央库指定国家规则同步并批量写入本地持久化库 (RemoteNumberDataSource)
  Future<int> syncCentralCountryRules({
    required String countryIsoCode,
    RemoteNumberDataSource? dataSource,
  }) async {
    final targetDataSource = dataSource ?? ref.read(remoteNumberDataSourceProvider);
    int totalCount = 0;

    try {
      final domain = countryIsoCode.isNotEmpty ? 'rules_$countryIsoCode' : 'rules_global';
      final List<Map<String, dynamic>> numbers = [];

      // 1. 优先通过 CentralDatabaseHub 多适配器拉取公共实体
      for (final adapter in centralDatabaseHub.allAdapters) {
        final entities = await adapter.fetchPublicEntities(domain);
        debugPrint('[CentralDatabaseConnector] Central database fetched ${entities.length} entities for domain: $domain via ${adapter.moduleId}');
        for (final entity in entities) {
          final payload = Map<String, dynamic>.from(entity.payload);
          if (!payload.containsKey('phoneNumber') && entity.entityKey.isNotEmpty) {
            payload['phoneNumber'] = entity.entityKey;
          }
          numbers.add(payload);
        }
      }

      // 2. 若中央库适配器尚未返回实体，回退至 Worker 初始化通道
      if (numbers.isEmpty && countryIsoCode.isNotEmpty) {
        final workerData = await getInitialDataForCountry(countryIsoCode);
        numbers.addAll(workerData);
      }

      if (numbers.isNotEmpty && targetDataSource != null) {
        await targetDataSource.bulkInsertFromServer(countryIsoCode, numbers);
        totalCount = numbers.length;
      }
      return totalCount;
    } catch (e) {
      debugPrint('[CentralDatabaseConnector] syncCentralCountryRules error: $e');
      rethrow;
    }
  }

  /// 执行远程中央库同步拉取
  Future<bool> syncCentralDatabase({String countryIsoCode = '', RemoteNumberDataSource? dataSource}) async {
    try {
      final count = await syncCentralCountryRules(
        countryIsoCode: countryIsoCode,
        dataSource: dataSource,
      );
      debugPrint('[CentralDatabaseConnector] Central database sync completed with $count entities.');
      return true;
    } catch (e) {
      debugPrint('[CentralDatabaseConnector] syncCentralDatabase error: $e');
      return false;
    }
  }
}

