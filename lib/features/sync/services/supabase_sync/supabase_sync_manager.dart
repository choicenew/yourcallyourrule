import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' as drift;

import '../../data/database/local/local_database.dart';
import '../../data/database/sync/device_id_service.dart';
import 'sync_log_service.dart';

class SyncResult {
  final bool success;
  final int pushedCount;
  final int pulledCount;
  final int deletedCount;
  final String? errorMessage;
  final bool skipped;

  SyncResult({
    this.success = false,
    this.pushedCount = 0,
    this.pulledCount = 0,
    this.deletedCount = 0,
    this.errorMessage,
    this.skipped = false,
  });
}

class SupabaseSyncManager {
  final LocalDatabase _localDb;
  final SupabaseClient _supabase;
  final DeviceIdService _deviceIdService;
  final SyncLogService _logService;
  
  final bool _syncCallLogs;
  final DateTime? _lastSyncTime;
  final int _syncIntervalHours;

  SupabaseSyncManager({
    required LocalDatabase localDb,
    required SupabaseClient supabase,
    required DeviceIdService deviceIdService,
    required SyncLogService logService,
    bool syncCallLogs = false,
    DateTime? lastSyncTime,
    int syncIntervalHours = 24,
  })  : _localDb = localDb,
        _supabase = supabase,
        _deviceIdService = deviceIdService,
        _logService = logService,
        _syncCallLogs = syncCallLogs,
        _lastSyncTime = lastSyncTime,
        _syncIntervalHours = syncIntervalHours;

  Future<SyncResult> sync({bool force = false}) async {
    try {
      // 1. 初始化触发器
      await _logService.initialize();

      // 2. 时间间隔检查
      if (!force && _lastSyncTime != null) {
        final diff = DateTime.now().difference(_lastSyncTime!);
        final pendingCount = await _logService.getLogCount();
        // 如果未到时间且积压日志少于100条，则跳过
        if (diff.inHours < _syncIntervalHours && pendingCount < 100) {
          return SyncResult(success: true, skipped: true);
        }
      }

      final deviceId = await _deviceIdService.getDeviceId();
      int totalPushed = 0;
      int totalDeleted = 0;
      int totalPulled = 0;

      // ======================================================
      // 1. PUSH: 基于影子表 (SyncLog)
      // ======================================================
      
      final logs = await _logService.getChanges();
      
      // 按表分组处理
      final logsByTable = <String, List<SyncLogEntry>>{};
      for (var log in logs) {
        if (log.tableName == 'call_history' && !_syncCallLogs) continue;
        logsByTable.putIfAbsent(log.tableName, () => []).add(log);
      }

      for (final tableName in logsByTable.keys) {
        final tableLogs = logsByTable[tableName]!;
        
        // 整理每个 ID 的最终操作
        final finalOps = <String, String>{}; 
        final logIdsToClear = <int>[];

        for (var log in tableLogs) {
          logIdsToClear.add(log.id);
          if (log.operation == 'DELETE') {
            finalOps[log.recordId] = 'DELETE';
          } else {
            finalOps[log.recordId] = 'UPSERT';
          }
        }

        final idsToDelete = <String>[];
        final idsToUpsert = <String>[];

        finalOps.forEach((id, op) {
          if (op == 'DELETE') idsToDelete.add(id);
          else idsToUpsert.add(id);
        });

        // 执行 DELETE
        if (idsToDelete.isNotEmpty) {
           final pkName = _getPrimaryKeyName(tableName);
           // ✅ 修复：使用 filter 替代 in_
           await _supabase.from(tableName).delete().filter(pkName, 'in', idsToDelete);
           totalDeleted += idsToDelete.length;
        }

        // 执行 UPSERT
        if (idsToUpsert.isNotEmpty) {
           final tableInfo = _localDb.allTables.firstWhere(
             (t) => t.actualTableName == tableName,
             orElse: () => throw Exception('Table $tableName not found in Drift'),
           );

           final pkName = _getPrimaryKeyName(tableName);
           // 构造 placeholders: (?,?,?)
           final placeholders = List.filled(idsToUpsert.length, '?').join(',');
           final sql = 'SELECT * FROM $tableName WHERE $pkName IN ($placeholders)';
           
           // ✅ 修复：使用 drift.Variable<String>
           final rows = await _localDb.customSelect(
             sql, 
             variables: idsToUpsert.map((id) => drift.Variable<String>(id)).toList()
           ).get();

           final List<Map<String, dynamic>> toPush = [];
           for (final row in rows) {
             final map = Map<String, dynamic>.from(row.data);
             map['modified_by_device'] = deviceId;
             toPush.add(map);
           }

           if (toPush.isNotEmpty) {
             await _supabase.from(tableName).upsert(toPush, onConflict: pkName);
             totalPushed += toPush.length;
           }
        }

        await _logService.clearLogs(logIdsToClear);
      }

      // ======================================================
      // 2. PULL: 常规拉取 (基于 updated_at)
      // ======================================================
      
      for (final tableInfo in _localDb.allTables) {
        final tableName = tableInfo.actualTableName;
        if (tableName == 'call_history' && !_syncCallLogs) continue;
        // 跳过系统表和日志表
        if (tableName.startsWith('__') || tableName == 'sqlite_sequence' || tableName == 'android_metadata') continue;

        var remoteQuery = _supabase.from(tableName).select();
        if (_lastSyncTime != null) {
          remoteQuery = remoteQuery.gt('updated_at', _lastSyncTime!.toIso8601String());
        }
        remoteQuery = remoteQuery.neq('modified_by_device', deviceId);

        final remoteData = await remoteQuery;
        if (remoteData.isNotEmpty) {
          await _localDb.batch((batch) {
             for (var json in remoteData) {
               if (json is Map<String, dynamic>) {
                 final cleanJson = Map<String, dynamic>.from(json);
                 cleanJson.remove('updated_at');
                 cleanJson.remove('modified_by_device');
                 
                 final dataClass = tableInfo.map(cleanJson);
                 // 必须 cast 为 dynamic 才能调用 toCompanion
                 final companion = (dataClass as dynamic).toCompanion(true);
                 
                 batch.insert(tableInfo as dynamic, companion, mode: drift.InsertMode.insertOrReplace);
               }
             }
          });
          totalPulled += remoteData.length;
        }
      }

      return SyncResult(
        success: true,
        pushedCount: totalPushed,
        pulledCount: totalPulled,
        deletedCount: totalDeleted,
      );

    } catch (e, st) {
      debugPrint('Sync Error: $e');
      return SyncResult(success: false, errorMessage: e.toString());
    }
  }

  String _getPrimaryKeyName(String tableName) {
    if (tableName == 'phone_rules' || tableName == 'phone_rules_data') return 'phone_number';
    if (tableName == 'regex_rules') return 'pattern';
    return 'id';
  }
}