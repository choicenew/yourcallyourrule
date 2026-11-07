import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';
import 'json_sync_protocol.dart';
import 'sync_conflict_resolver.dart';

class IncrementalSyncManager {
  final SyncConflictResolver _conflictResolver = SyncConflictResolver();
  final Map<String, String> _lastHashes = {};

  String calculateHash(List<Map<String, dynamic>> items) {
    final raw = jsonEncode(items);
    return md5.convert(utf8.encode(raw)).toString();
  }

  /// 动态计算云端物理隔离工作路径 (格式: /{appName}/{accountId})
  /// 优先使用传入的参数，未传入时自动继承当前 CloudDriveHub 全局注入的宿主上下文
  static String computeRemoteFolder({String? appName, String? accountId}) {
    return CloudDriveHub.instance.computeRootPath(
      overrideAppName: appName,
      overrideAccountId: accountId,
    );
  }

  /// 执行单个模块的数据同步 (支持动态 App 名称与多影子账户隔离)
  Future<bool> syncModule(
    String moduleId, {
    String? appName,
    String? accountId,
    String? customRemoteFolder,
    bool? isSyncEnabled,
  }) async {
    // 1. 如果该账户显式禁用了云同步，则直接跳过
    if (isSyncEnabled == false) {
      final activeAccount = accountId ?? CloudDriveHub.instance.activeAccountId;
      debugPrint('⏸️ [IncrementalSyncManager] 账户 $activeAccount 已禁用云同步，跳过模块 $moduleId 同步');
      return false;
    }

    final driver = CloudDriveHub.instance.currentDriver;
    if (driver == null || !await driver.isConnected()) return false;

    final adapter = SyncHub.instance.getAdapter(moduleId);
    if (adapter == null) return false;
    final jsonProto = JsonSyncProtocol(adapter);

    final localItems = await jsonProto.exportFullJson();
    final localHash = calculateHash(localItems);

    final folder = customRemoteFolder ?? computeRemoteFolder(appName: appName, accountId: accountId);
    final remoteFilePath = '$folder/$moduleId.json';

    // 2. 读取远端数据
    final remoteRaw = await driver.readFile(remoteFilePath);
    List<Map<String, dynamic>> remoteItems = [];
    if (remoteRaw != null && remoteRaw is String && remoteRaw.isNotEmpty) {
      try {
        final decoded = jsonDecode(remoteRaw);
        if (decoded is List) {
          remoteItems = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
        }
      } catch (_) {}
    }

    // 3. 比对 Hash，若相同则无需同步
    final effectiveAccount = accountId ?? CloudDriveHub.instance.activeAccountId ?? 'default';
    final hashKey = '${effectiveAccount}_$moduleId';
    final remoteHash = calculateHash(remoteItems);
    if (remoteHash == localHash && _lastHashes[hashKey] == localHash) {
      return true;
    }

    // 4. 冲突合并
    final merged = _conflictResolver.resolveConflicts(
      localItems: localItems,
      remoteItems: remoteItems,
    );

    // 5. 写回网盘
    final mergedJson = jsonEncode(merged);
    await driver.writeFile(remoteFilePath, mergedJson);

    // 6. 写回本地数据库
    await jsonProto.importFullJson(merged);
    _lastHashes[hashKey] = calculateHash(merged);

    debugPrint('☁️ [IncrementalSyncManager] 成功同步模块 [$moduleId] 到云端目录: $remoteFilePath');
    return true;
  }

  /// 同步所有在 SyncHub 中注册的业务模块
  Future<Map<String, bool>> syncAllModules({
    String? appName,
    String? accountId,
    String? customRemoteFolder,
    bool? isSyncEnabled,
  }) async {
    final results = <String, bool>{};
    final moduleIds = SyncHub.instance.registeredModuleIds;
    for (final id in moduleIds) {
      results[id] = await syncModule(
        id,
        appName: appName,
        accountId: accountId,
        customRemoteFolder: customRemoteFolder,
        isSyncEnabled: isSyncEnabled,
      );
    }
    return results;
  }
}
