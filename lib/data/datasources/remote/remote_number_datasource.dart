// 远程号码数据源实现类，用于处理远程号码数据的CRUD操作和同步

import 'dart:async';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/remote/remote_number_model.dart';
import '../../../data/models/sync/sync_record_model.dart';
import '../../database/database_manager.dart';
import 'remote_datasource_interface.dart';

// 远程号码数据源实现
class RemoteNumberDataSource
    implements RemoteDataSourceInterface<RemoteNumberModel> {
  // 数据库管理器
  final RemoteDatabaseManager _databaseManager;

  // 表名
  static const String _tableName = 'remote_numbers';
  static const String _pendingOperationsTable = 'pending_operations';
  static const String _syncTableName = 'sync_records';

  RemoteNumberDataSource(this._databaseManager);

  // 记录待处理操作的内部方法
  Future<void> _logOperation(
    DatabaseExecutor txn,
    String operation,
    String entityId, {
    Map<String, dynamic>? payload,
  }) async {
    await txn.insert(_pendingOperationsTable, {
      'id': const Uuid().v4(),
      'entityId': entityId,
      'operation': operation,
      'payload': payload != null ? jsonEncode(payload) : null,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<List<RemoteNumberModel>> getAll() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return RemoteNumberModel.fromMap(maps[i]);
    });
  }

  // 根据ID获取远程号码
  @override
  Future<RemoteNumberModel?> getById(String id) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RemoteNumberModel.fromMap(maps.first);
    }
    return null;
  }

  // 根据电话号码获取远程号码
  Future<RemoteNumberModel?> getByPhoneNumber(String phoneNumber) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );

    if (maps.isNotEmpty) {
      return RemoteNumberModel.fromMap(maps.first);
    }
    return null;
  }

  // 插入远程号码
  @override
  Future<String> insert(RemoteNumberModel remoteNumber) async {
    final db = await _databaseManager.database;

    // 如果没有ID，生成一个新的UUID
    final String id =
        remoteNumber.id.isEmpty ? const Uuid().v4() : remoteNumber.id;
    final modelToInsert = remoteNumber.copyWith(id: id);

    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        modelToInsert.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await _logOperation(txn, 'INSERT', id, payload: modelToInsert.toMap());
    });

    return id;
  }

  // 更新远程号码
  @override
  Future<int> update(RemoteNumberModel remoteNumber) async {
    final db = await _databaseManager.database;
    int result = 0;
    await db.transaction((txn) async {
      result = await txn.update(
        _tableName,
        remoteNumber.toMap(),
        where: 'id = ?',
        whereArgs: [remoteNumber.id],
      );
      if (result > 0) {
        await _logOperation(txn, 'UPDATE', remoteNumber.id,
            payload: remoteNumber.toMap());
      }
    });
    return result;
  }

  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;
    int result = 0;
    await db.transaction((txn) async {
      result = await txn.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result > 0) {
        await _logOperation(txn, 'DELETE', id);
      }
    });
    return result;
  }
  
  // 原子更新计数器（带乐观锁机制）
  @override
  Future<int> atomicIncrementCount(String id, int incrementValue) async {
    final db = await _databaseManager.database;
    int result = 0;
    await db.transaction((txn) async {
      final List<Map<String, dynamic>> maps = await txn.query(
        _tableName,
        columns: ['count'],
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        final currentCount = maps.first['count'] is String
            ? int.tryParse(maps.first['count'] ?? '0') ?? 0
            : (maps.first['count'] ?? 0);
        final newCount = currentCount + incrementValue;

        result = await txn.update(
          _tableName,
          {'count': newCount},
          where: 'id = ?',
          whereArgs: [id],
        );

        if (result > 0) {
          await _logOperation(
            txn,
            'INCREMENT',
            id,
            payload: {'increment': incrementValue},
          );
        }
      }
    });
    return result;
  }

  // 批量插入远程号码
  @override
  Future<List<String>> insertAll(List<RemoteNumberModel> remoteNumbers) async {
    final db = await _databaseManager.database;
    final List<String> ids = [];
    await db.transaction((txn) async {
      for (final remoteNumber in remoteNumbers) {
        final String id =
            remoteNumber.id.isEmpty ? const Uuid().v4() : remoteNumber.id;
        final modelToInsert = remoteNumber.copyWith(id: id);
        await txn.insert(
          _tableName,
          modelToInsert.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await _logOperation(txn, 'INSERT', id,
            payload: modelToInsert.toMap());
        ids.add(id);
      }
    });
    return ids;
  }

  // 批量更新远程号码
  @override
  Future<int> updateAll(List<RemoteNumberModel> remoteNumbers) async {
    final db = await _databaseManager.database;
    int count = 0;
    await db.transaction((txn) async {
      for (final remoteNumber in remoteNumbers) {
        final int updated = await txn.update(
          _tableName,
          remoteNumber.toMap(),
          where: 'id = ?',
          whereArgs: [remoteNumber.id],
        );
        if (updated > 0) {
          await _logOperation(txn, 'UPDATE', remoteNumber.id,
              payload: remoteNumber.toMap());
        }
        count += updated;
      }
    });
    return count;
  }

  // 批量删除远程号码
  @override
  Future<int> deleteAll(List<String> ids) async {
    final db = await _databaseManager.database;
    int count = 0;
    await db.transaction((txn) async {
      for (final id in ids) {
        final int deleted = await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
        if (deleted > 0) {
          await _logOperation(txn, 'DELETE', id);
        }
        count += deleted;
      }
    });
    return count;
  }

  // 清空所有远程号码
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    // This is a dangerous operation. In a real-world sync scenario,
    // we should probably log a special operation type, but for now,
    // we just clear the table.
    await db.delete(_tableName);
    await db.delete(_pendingOperationsTable); // Also clear pending operations
  }

  // --- New methods for SyncManager ---

  Future<List<Map<String, dynamic>>> getLocalPendingOperations() async {
    final db = await _databaseManager.database;
    return await db.query(_pendingOperationsTable, orderBy: 'timestamp ASC');
  }

  Future<void> clearPendingOperations(List<String> operationIds) async {
    final db = await _databaseManager.database;
    if (operationIds.isEmpty) return;
    await db.transaction((txn) async {
      for (final opId in operationIds) {
        await txn.delete(
          _pendingOperationsTable,
          where: 'id = ?',
          whereArgs: [opId],
        );
      }
    });
  }

  Future<void> applyRemoteChanges(List<Map<String, dynamic>> changes) async {
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      for (final change in changes) {
        final operation = change['operation'];
        final entityId = change['entityId'];
        final payload = change['payload'];

        switch (operation) {
          case 'INSERT':
          case 'UPDATE':
            await txn.insert(
              _tableName,
              payload,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            break;
          case 'DELETE':
            await txn.delete(
              _tableName,
              where: 'id = ?',
              whereArgs: [entityId],
            );
            break;
          case 'INCREMENT':
            // This requires fetching the current value first.
            final List<Map<String, dynamic>> maps = await txn.query(
              _tableName,
              columns: ['count'],
              where: 'id = ?',
              whereArgs: [entityId],
            );
            if (maps.isNotEmpty) {
              final currentCount = maps.first['count'] is String
                  ? int.tryParse(maps.first['count'] ?? '0') ?? 0
                  : (maps.first['count'] ?? 0);
              final increment = payload['increment'] ?? 0;
              final newCount = currentCount + increment;
              await txn.update(
                _tableName,
                {'count': newCount},
                where: 'id = ?',
                whereArgs: [entityId],
              );
            }
            break;
        }
      }
    });
  }

  // --- Methods from Interface that are now handled by SyncManager ---
  // We keep them to satisfy the interface but they will either be empty,
  // throw an exception, or have a very simple implementation.

  @override
  Future<bool> syncData() async {
    // This logic is now handled by IncrementalSyncManager
    throw UnimplementedError(
        'Sync logic is now handled by IncrementalSyncManager');
  }

  @override
  Future<bool> incrementalSync(DateTime lastSyncTime) async {
    // This logic is now handled by IncrementalSyncManager
    throw UnimplementedError(
        'Sync logic is now handled by IncrementalSyncManager');
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _syncTableName,
      orderBy: 'syncTime DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      final String timeString = maps.first['syncTime'] as String;
      return DateTime.parse(timeString);
    }
    return null;
  }

  @override
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10}) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _syncTableName,
      orderBy: 'syncTime DESC',
      limit: limit,
    );
    return List.generate(maps.length, (i) {
      return SyncRecordModel.fromMap(maps[i]);
    });
  }
  
  // The following methods from the interface might need re-evaluation
  // based on the new architecture. For now, providing a simple implementation.

  @override
  Future<String> insertSyncRecord(SyncRecordModel syncRecord) async {
    final db = await _databaseManager.database;
    await db.insert(_syncTableName, syncRecord.toMap());
    return syncRecord.id;
  }

  @override
  Future<bool> needSync(int syncIntervalHours) async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return true;
    return DateTime.now().difference(lastSync).inHours >= syncIntervalHours;
  }

  @override
  Future<SyncRecordModel?> getLastSyncRecord() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _syncTableName,
      orderBy: 'syncTime DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return SyncRecordModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<bool> atomicUpdateCount(String phoneNumber, int increment) async {
    final remoteNumber = await getByPhoneNumber(phoneNumber);
    if (remoteNumber != null) {
      final result = await atomicIncrementCount(remoteNumber.id, increment);
      return result > 0;
    }
    return false;
  }

  @override
  Future<Map<String, bool>> batchAtomicUpdateCount(
      Map<String, int> updates) async {
    final Map<String, bool> results = {};
    for (var entry in updates.entries) {
      final success = await atomicUpdateCount(entry.key, entry.value);
      results[entry.key] = success;
    }
    return results;
  }

  // 根据标签查询远程号码
  Future<List<RemoteNumberModel>> getByLabel(String label) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'label = ?',
      whereArgs: [label],
    );
    return List.generate(maps.length, (i) {
      return RemoteNumberModel.fromMap(maps[i]);
    });
  }

  // 根据优先级查询远程号码
  Future<List<RemoteNumberModel>> getByPriority(int priority) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'priority = ?',
      whereArgs: [priority],
    );
    return List.generate(maps.length, (i) {
      return RemoteNumberModel.fromMap(maps[i]);
    });
  }

  // 根据动作查询远程号码
  Future<List<RemoteNumberModel>> getByAction(String action) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'action = ?',
      whereArgs: [action],
    );
    return List.generate(maps.length, (i) {
      return RemoteNumberModel.fromMap(maps[i]);
    });
  }
  
  /// 删除特定国家代码的所有号码
  /// 返回删除的记录数
  /// [countryCode] 国家的拨号代码，例如 '+86'
  Future<int> deleteNumbersByCountryCode(String countryCode) async {
    final db = await _databaseManager.database;
    int count = 0;
    
    // 查找以该国家代码开头的所有号码
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'phoneNumber LIKE ?',
      whereArgs: ['$countryCode%'],
    );
    
    // 删除找到的号码
    await db.transaction((txn) async {
      for (final map in maps) {
        final id = map['id'] as String;
        final result = await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );
        if (result > 0) {
          await _logOperation(txn, 'DELETE', id);
          count += result;
        }
      }
    });
    
    return count;
  }
  
  /// 插入远程号码数据（不使用模型）
  Future<String> insertRemoteNumber(Map<String, dynamic> data) async {
    final db = await _databaseManager.database;
    
    // 确保数据有ID
    final String id = data['id'] ?? const Uuid().v4();
    final Map<String, dynamic> dataWithId = {...data, 'id': id};
    
    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        dataWithId,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await _logOperation(txn, 'INSERT', id, payload: dataWithId);
    });
    
    return id;
  }
  
  /// 批量插入从服务器获取的远程号码数据，不记录到pending_operations
  /// 
  /// 这是一个"特殊通道"，专门用于同步下载的数据，避免将刚下载的数据再推送回服务器
  Future<void> bulkInsertFromServer(List<Map<String, dynamic>> numbers) async {
    if (numbers.isEmpty) return;
    
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      final batch = txn.batch();
      for (final numberMap in numbers) {
        // 确保数据有ID
        final String id = numberMap['id'] ?? const Uuid().v4();
        final Map<String, dynamic> dataWithId = {...numberMap, 'id': id};
        
        // 直接插入，不调用 _logOperation
        batch.insert(_tableName, dataWithId, conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    });
  }
}
