import 'dart:isolate';
import 'package:pyro_cloudflare/pyro_cloudflare.dart';
import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';
import 'config/cloudflare_sync_config_store.dart';
import 'models/cloudflare_sync_payload.dart';

/// Cloudflare Worker & D1 增量同步 Provider 适配器
/// 内部自带 Isolate 下沉机制，大批量同步 Operation 序列化与反序列化绝不卡顿 UI 主线程
class CloudflareSyncProvider implements SyncDataAdapter<Map<String, dynamic>> {
  final CloudflareSyncConfigStore _configStore;

  CloudflareSyncProvider({
    String workerUrl = '',
    String apiSecret = '',
    String deviceId = '',
    CloudflareSyncConfigStore? configStore,
  }) : _configStore = configStore ?? CloudflareSyncConfigStore.instance {
    if (workerUrl.isNotEmpty || apiSecret.isNotEmpty) {
      _configStore.updateConfig(
        workerUrl: workerUrl,
        apiSecret: apiSecret,
        deviceId: deviceId,
      );
    }
  }

  @override
  String get moduleId => 'cloudflare_kv';

  @override
  Future<List<Map<String, dynamic>>> readAll() async => [];

  @override
  Future<void> overwriteAll(List<dynamic> items) async {}

  @override
  Stream<Map<String, dynamic>> watchChanges() => const Stream.empty();

  @override
  Future<void> upsert(Map<String, dynamic> item) async {}

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> item) => item;

  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) => json;

  Future<bool> initialize() async {
    return _configStore.isConfigured;
  }

  /// 测试物理网络连通性
  Future<bool> testConnection() async {
    if (!_configStore.isConfigured) return false;
    final workerClient = CloudflareWorkerClient(
      config: _configStore.toInfraConfig(),
    );
    final res = await workerClient.get('/api/health');
    return res != null;
  }

  /// 推送增量操作同步队列到 Cloudflare Worker (后台 Isolate 异步下沉)
  Future<bool> pushOperations(List<CloudflareSyncOperation> ops) async {
    if (ops.isEmpty) return true;
    if (!_configStore.isConfigured) return false;

    final workerClient = CloudflareWorkerClient(
      config: _configStore.toInfraConfig(),
    );

    // 在后台 Isolate 线程中序列化 Ops 操作队列 JSON 列表
    final operationsJson = await Isolate.run(() => ops.map((o) => o.toJson()).toList());

    final payload = {
      'sourceDeviceId': _configStore.deviceId,
      'operations': operationsJson,
    };

    final res = await workerClient.post('/api/sync/push', payload);
    return res != null && (res['success'] == true || res['status'] == 'ok');
  }

  /// 从 Cloudflare Worker 拉取最新社区增量与共识条目 (后台 Isolate 异步下沉)
  Future<List<CloudflareSyncOperation>> pullLatest({
    required String domain,
    String? lastSyncTime,
  }) async {
    if (!_configStore.isConfigured) return [];

    final workerClient = CloudflareWorkerClient(
      config: _configStore.toInfraConfig(),
    );

    final params = {
      'domain': domain,
      if (lastSyncTime != null) 'since': lastSyncTime,
    };

    final res = await workerClient.get('/api/sync/pull', params);
    if (res != null && res['operations'] is List) {
      final list = res['operations'] as List;
      // 在后台 Isolate 线程中还原解析 Ops 对象列表，零 UI 主线程耗时
      return await Isolate.run(() {
        return list
            .map((item) => CloudflareSyncOperation.fromJson(item as Map<String, dynamic>))
            .toList();
      });
    }
    return [];
  }
}
