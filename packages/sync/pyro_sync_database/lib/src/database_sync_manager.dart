import 'dart:async';

import 'package:isar_community/isar.dart';
import 'package:pyro_sync_syncitron/pyro_sync_syncitron.dart';
import 'package:syncitron/syncitron.dart';

/// 数据库同步管理器，协调业务线本地数据与云端引擎之间的同步。
class DatabaseSyncManager {
  SyncEngine? _engine;
  ProtocolLocalStore? _localStore;

  /// 获取底层的同步引擎实例
  SyncEngine? get engine => _engine;

  /// 初始化底层的 syncitron 同步引擎与 Isar 过渡区
  Future<void> initializeEngine({
    required Isar isar,
    required RemoteAdapter remoteAdapter,
    dynamic config,
    Logger? logger,
  }) async {
    _localStore = ProtocolLocalStore(isar: isar);
    _engine = SyncEngine(
      localStore: _localStore!,
      remoteAdapter: remoteAdapter,
      config: config ?? syncitronConfig.production(),
      logger: logger ?? ConsoleLogger(minLevel: LogLevel.info),
    );
    await _engine!.init();
  }

  /// 注册特定模块的同步表，并自动激活本地数据流的监听
  void registerTable(TableConfig tableConfig) {
    final engine = _engine;
    final store = _localStore;
    if (engine == null || store == null) {
      throw StateError('Engine not initialized. Call initializeEngine first.');
    }
    engine.registerTable(tableConfig);
    store.startListening(tableConfig.name, tableConfig.primaryKey);
  }

  /// 手动执行一次全面同步
  Future<SyncSessionMetrics> syncAll() async {
    final engine = _engine;
    if (engine == null) {
      throw StateError('Engine not initialized.');
    }
    return await engine.syncAll();
  }

  /// 释放资源
  void dispose() {
    _localStore?.dispose();
    _engine?.dispose();
  }
}
