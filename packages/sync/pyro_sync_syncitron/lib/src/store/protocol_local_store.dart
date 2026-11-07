import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:pyro_sync_hub/pyro_sync_hub.dart';

import 'package:syncitron/syncitron.dart';
import '../models/transition_record.dart';
import '../models/sync_meta.dart';

class ProtocolLocalStore implements LocalStore {
  final Isar isar;
  final Map<String, String> _tablePkColumns = {};
  final Map<String, StreamSubscription> _subscriptions = {};
  final Map<String, DateTime> _ignoredRecords = {};

  ProtocolLocalStore({required this.isar});

  void startListening(String table, String pkColumn) {
    _tablePkColumns[table] = pkColumn;
    _subscriptions[table]?.cancel();
    
    final adapter = SyncHub.instance.getAdapter(table);
    if (adapter == null) {
      debugPrint('ProtocolLocalStore: No adapter found for table/module $table');
      return;
    }

    _subscriptions[table] = adapter.watchChanges().listen((item) async {
      try {
        final json = adapter.toJson(item);
        final pkValue = json[pkColumn]?.toString();
        if (pkValue == null) return;

        if (_shouldIgnore(table, pkValue)) {
          return;
        }

        await isar.writeTxn(() async {
          final record = await isar.transitionRecords
              .filter()
              .tableEqualTo(table)
              .recordIdEqualTo(pkValue)
              .findFirst();

          final now = DateTime.now().toUtc();
          if (record != null) {
            record.payloadJson = jsonEncode(json);
            record.isSynced = false;
            record.operationId = null;
            record.updatedAt = now;
            await isar.transitionRecords.put(record);
          } else {
            final newRecord = TransitionRecord()
              ..table = table
              ..recordId = pkValue
              ..payloadJson = jsonEncode(json)
              ..isSynced = false
              ..updatedAt = now;
            await isar.transitionRecords.put(newRecord);
          }
        });
      } catch (e) {
        debugPrint('ProtocolLocalStore error in watchChanges: $e');
      }
    });
  }

  void _ignoreRecord(String table, String id) {
    _ignoredRecords['$table:$id'] = DateTime.now().add(const Duration(seconds: 2));
  }

  bool _shouldIgnore(String table, String id) {
    final key = '$table:$id';
    final expiry = _ignoredRecords[key];
    if (expiry == null) return false;
    if (DateTime.now().isAfter(expiry)) {
      _ignoredRecords.remove(key);
      return false;
    }
    return true;
  }

  void dispose() {
    for (final sub in _subscriptions.values) {
      sub.cancel();
    }
    _subscriptions.clear();
  }

  @override
  Future<void> ensureSyncColumns(
    String table,
    String updatedAtColumn,
    String deletedAtColumn,
  ) async {
    // Isar transition tables are predefined. No schema modification needed.
  }

  @override
  Future<SyncCursor?> readCursor(String table) async {
    try {
      final meta = await isar.syncMetas.filter().keyEqualTo('cursor_$table').findFirst();
      if (meta == null) return null;
      final decoded = jsonDecode(meta.value);
      return SyncCursor.fromJson(Map<String, dynamic>.from(decoded as Map));
    } catch (e) {
      debugPrint('ProtocolLocalStore error reading cursor for $table: $e');
      await clearCursor(table);
      return null;
    }
  }

  @override
  Future<void> writeCursor(String table, SyncCursor cursor) async {
    try {
      await isar.writeTxn(() async {
        final existing = await isar.syncMetas.filter().keyEqualTo('cursor_$table').findFirst();
        final jsonStr = jsonEncode(cursor.toJson());
        if (existing != null) {
          existing.value = jsonStr;
          await isar.syncMetas.put(existing);
        } else {
          final newMeta = SyncMeta()
            ..key = 'cursor_$table'
            ..value = jsonStr;
          await isar.syncMetas.put(newMeta);
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to write cursor for table "$table" in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<void> clearCursor(String table) async {
    try {
      await isar.writeTxn(() async {
        final existing = await isar.syncMetas.filter().keyEqualTo('cursor_$table').findFirst();
        if (existing != null) {
          await isar.syncMetas.delete(existing.id!);
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to clear cursor for table "$table" in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> queryDirty(String table) async {
    try {
      final records = await isar.transitionRecords
          .filter()
          .tableEqualTo(table)
          .isSyncedEqualTo(false)
          .findAll();

      final list = <Map<String, dynamic>>[];
      for (final r in records) {
        final payload = Map<String, dynamic>.from(jsonDecode(r.payloadJson) as Map);
        payload['is_synced'] = false;
        payload['op_id'] = r.operationId;
        list.add(payload);
      }
      return list;
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to query dirty records from Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<void> upsertBatch(
    String table,
    List<Map<String, dynamic>> records,
  ) async {
    if (records.isEmpty) return;

    final adapter = SyncHub.instance.getAdapter(table);
    if (adapter == null) {
      throw LocalStoreException(
        table: table,
        message: 'No SyncDataAdapter registered for table "$table".',
      );
    }

    final pkColumn = _tablePkColumns[table] ?? 'id';

    try {
      for (final row in records) {
        final pkValue = row[pkColumn]?.toString();
        if (pkValue != null) {
          _ignoreRecord(table, pkValue);
        }

        final item = adapter.fromJson(row);
        await adapter.upsert(item);

        if (pkValue != null) {
          await isar.writeTxn(() async {
            final transitionRecord = await isar.transitionRecords
                .filter()
                .tableEqualTo(table)
                .recordIdEqualTo(pkValue)
                .findFirst();
            if (transitionRecord != null) {
              await isar.transitionRecords.delete(transitionRecord.id!);
            }
          });
        }
      }
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'upsertBatch failed in ProtocolLocalStore.',
        cause: e,
      );
    }
  }

  @override
  Future<void> markAsSynced(
    String table,
    String pkColumn,
    dynamic primaryKey,
  ) async {
    try {
      final pkValue = primaryKey.toString();
      await isar.writeTxn(() async {
        final record = await isar.transitionRecords
            .filter()
            .tableEqualTo(table)
            .recordIdEqualTo(pkValue)
            .findFirst();
        if (record != null) {
          await isar.transitionRecords.delete(record.id!);
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to mark record as synced in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<void> setOperationId(
    String table,
    String pkColumn,
    dynamic primaryKey,
    String operationId,
  ) async {
    try {
      final pkValue = primaryKey.toString();
      await isar.writeTxn(() async {
        final record = await isar.transitionRecords
            .filter()
            .tableEqualTo(table)
            .recordIdEqualTo(pkValue)
            .findFirst();
        if (record != null) {
          record.operationId = operationId;
          await isar.transitionRecords.put(record);
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to set operation ID in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<void> markManyAsSynced(
    String table,
    String pkColumn,
    List<dynamic> primaryKeys,
  ) async {
    try {
      await isar.writeTxn(() async {
        for (final pk in primaryKeys) {
          final pkValue = pk.toString();
          final record = await isar.transitionRecords
              .filter()
              .tableEqualTo(table)
              .recordIdEqualTo(pkValue)
              .findFirst();
          if (record != null) {
            await isar.transitionRecords.delete(record.id!);
          }
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to mark many records as synced in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<void> setOperationIds(
    String table,
    String pkColumn,
    Map<dynamic, String> operationIds,
  ) async {
    try {
      await isar.writeTxn(() async {
        for (final entry in operationIds.entries) {
          final pkValue = entry.key.toString();
          final record = await isar.transitionRecords
              .filter()
              .tableEqualTo(table)
              .recordIdEqualTo(pkValue)
              .findFirst();
          if (record != null) {
            record.operationId = entry.value;
            await isar.transitionRecords.put(record);
          }
        }
      });
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to set operation IDs in Isar store.',
        cause: e,
      );
    }
  }

  @override
  Future<Map<String, dynamic>?> findById(
    String table,
    String pkColumn,
    dynamic id,
  ) async {
    try {
      final pkValue = id.toString();
      final record = await isar.transitionRecords
          .filter()
          .tableEqualTo(table)
          .recordIdEqualTo(pkValue)
          .findFirst();
      if (record == null) return null;
      final payload = Map<String, dynamic>.from(jsonDecode(record.payloadJson) as Map);
      payload['is_synced'] = record.isSynced;
      payload['op_id'] = record.operationId;
      return payload;
    } catch (e) {
      debugPrint('ProtocolLocalStore findById error: $e');
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> findManyByIds(
    String table,
    String pkColumn,
    List<dynamic> ids,
  ) async {
    try {
      final stringIds = ids.map((id) => id.toString()).toList();
      final list = <Map<String, dynamic>>[];
      for (final idStr in stringIds) {
        final record = await isar.transitionRecords
            .filter()
            .tableEqualTo(table)
            .recordIdEqualTo(idStr)
            .findFirst();
        if (record != null) {
          final payload = Map<String, dynamic>.from(jsonDecode(record.payloadJson) as Map);
          payload['is_synced'] = record.isSynced;
          payload['op_id'] = record.operationId;
          list.add(payload);
        }
      }
      return list;
    } catch (e) {
      throw LocalStoreException(
        table: table,
        message: 'Failed to find records by IDs in Isar store.',
        cause: e,
      );
    }
  }
}
