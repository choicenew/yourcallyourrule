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
  static const String _junctionTable = 'number_countries';
  static const String _pendingOperationsTable = 'pending_operations';
  static const String _syncTableName = 'sync_records';

  RemoteNumberDataSource(this._databaseManager);

  // 记录待处理操作的内部方法
  Future<void> _logOperation(
    DatabaseExecutor txn,
    String operation,
    String phoneNumber, {
    Map<String, dynamic>? payload,
  }) async {
    await txn.insert(_pendingOperationsTable, {
      'id': const Uuid().v4(),
      'entityId': phoneNumber, // Use phone number as entityId
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

  // 根据电话号码获取远程号码
  @override
  Future<RemoteNumberModel?> getById(String phoneNumber) async {
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

  // 根据电话号码获取远程号码
  Future<RemoteNumberModel?> getByPhoneNumber(String phoneNumber) async {
    return getById(phoneNumber);
  }

  // 插入远程号码
  @override
  Future<String> insert(RemoteNumberModel remoteNumber) async {
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        remoteNumber.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await _logOperation(txn, 'INSERT', remoteNumber.phoneNumber,
          payload: remoteNumber.toMap());
    });

    return remoteNumber.phoneNumber;
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
        where: 'phoneNumber = ?',
        whereArgs: [remoteNumber.phoneNumber],
      );
      if (result > 0) {
        await _logOperation(txn, 'UPDATE', remoteNumber.phoneNumber,
            payload: remoteNumber.toMap());
      }
    });
    return result;
  }

  @override
  Future<int> delete(String phoneNumber) async {
    final db = await _databaseManager.database;
    int result = 0;
    await db.transaction((txn) async {
      result = await txn.delete(
        _tableName,
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
      );
      if (result > 0) {
        await _logOperation(txn, 'DELETE', phoneNumber);
      }
    });
    return result;
  }

  // 原子更新计数器
  @override
  Future<int> atomicIncrementCount(String phoneNumber, int incrementValue) async {
    final db = await _databaseManager.database;
    int result = 0;
    await db.transaction((txn) async {
      final List<Map<String, dynamic>> maps = await txn.query(
        _tableName,
        columns: ['count'],
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
      );

      if (maps.isNotEmpty) {
        final currentCount = maps.first['count'] is String
            ? int.tryParse(maps.first['count'] ?? '0') ?? 0
            : (maps.first['count'] ?? 0);
        final newCount = currentCount + incrementValue;

        result = await txn.update(
          _tableName,
          {'count': newCount},
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );

        if (result > 0) {
          await _logOperation(
            txn,
            'INCREMENT',
            phoneNumber,
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
    final List<String> phoneNumbers = [];
    await db.transaction((txn) async {
      for (final remoteNumber in remoteNumbers) {
        await txn.insert(
          _tableName,
          remoteNumber.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await _logOperation(txn, 'INSERT', remoteNumber.phoneNumber,
            payload: remoteNumber.toMap());
        phoneNumbers.add(remoteNumber.phoneNumber);
      }
    });
    return phoneNumbers;
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
          where: 'phoneNumber = ?',
          whereArgs: [remoteNumber.phoneNumber],
        );
        if (updated > 0) {
          await _logOperation(txn, 'UPDATE', remoteNumber.phoneNumber,
              payload: remoteNumber.toMap());
        }
        count += updated;
      }
    });
    return count;
  }

  // 批量删除远程号码
  @override
  Future<int> deleteAll(List<String> phoneNumbers) async {
    final db = await _databaseManager.database;
    int count = 0;
    await db.transaction((txn) async {
      for (final phoneNumber in phoneNumbers) {
        final int deleted = await txn.delete(
          _tableName,
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
        if (deleted > 0) {
          await _logOperation(txn, 'DELETE', phoneNumber);
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
    await db.delete(_tableName);
    await db.delete(_junctionTable);
    await db.delete(_pendingOperationsTable);
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
        final entityId = change['entityId']; // This is phoneNumber
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
              where: 'phoneNumber = ?',
              whereArgs: [entityId],
            );
            break;
          case 'INCREMENT':
            final List<Map<String, dynamic>> maps = await txn.query(
              _tableName,
              columns: ['count'],
              where: 'phoneNumber = ?',
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
                where: 'phoneNumber = ?',
                whereArgs: [entityId],
              );
            }
            break;
        }
      }
    });
  }

  // --- Methods from Interface that are now handled by SyncManager ---

  Future<bool> syncData() async {
    // This logic is now handled by IncrementalSyncManager
    throw UnimplementedError(
        'Sync logic is now handled by IncrementalSyncManager');
  }

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
    final result = await atomicIncrementCount(phoneNumber, increment);
    return result > 0;
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
  /// [countryIsoCode] 国家的ISO代码，例如 'US'
  Future<int> deleteNumbersByCountry(String countryIsoCode) async {
    final db = await _databaseManager.database;
    int deletedCount = 0;

    await db.transaction((txn) async {
      // 1. Find all phone numbers for the given country ISO code
      final numbersToDelete = await txn.query(
        _junctionTable,
        columns: ['phoneNumber'],
        where: 'countryIsoCode = ?',
        whereArgs: [countryIsoCode],
      );

      if (numbersToDelete.isEmpty) return;

      final phoneNumbers = numbersToDelete.map((row) => row['phoneNumber'] as String).toList();

      // 2. Delete the associations from the junction table
      await txn.delete(
        _junctionTable,
        where: 'countryIsoCode = ?',
        whereArgs: [countryIsoCode],
      );

      // 3. Find which of these numbers are now orphaned (not associated with any other country)
      final List<String> orphanedNumbers = [];
      for (final phoneNumber in phoneNumbers) {
        final countResult = await txn.query(
          _junctionTable,
          columns: ['COUNT(*) as count'],
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
        final count = Sqflite.firstIntValue(countResult);
        if (count == 0) {
          orphanedNumbers.add(phoneNumber);
        }
      }

      // 4. Delete the orphaned numbers from the remote_numbers table
      if (orphanedNumbers.isNotEmpty) {
        final result = await txn.delete(
          _tableName,
          where: 'phoneNumber IN (${orphanedNumbers.map((_) => '?').join(',')})',
          whereArgs: orphanedNumbers,
        );
        deletedCount = result;

        // Log deletion for orphaned numbers
        for (final phoneNumber in orphanedNumbers) {
          await _logOperation(txn, 'DELETE', phoneNumber);
        }
      }
    });

    return deletedCount;
  }
  
  /// 插入远程号码数据（不使用模型）
  Future<String> insertRemoteNumber(Map<String, dynamic> data) async {
    final db = await _databaseManager.database;
    
    final String phoneNumber = data['phoneNumber'];
    if (phoneNumber == null) {
      throw ArgumentError('phoneNumber cannot be null');
    }
    
    await db.transaction((txn) async {
      await txn.insert(
        _tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await _logOperation(txn, 'INSERT', phoneNumber, payload: data);
    });
    
    return phoneNumber;
  }
  
  /// 批量插入从服务器获取的远程号码数据，不记录到pending_operations
  /// 
  /// 这是一个"特殊通道"，专门用于同步下载的数据，避免将刚下载的数据再推送回服务器
  Future<void> bulkInsertFromServer(String countryIsoCode, List<Map<String, dynamic>> numbers) async {
    if (numbers.isEmpty) return;
    
    final db = await _databaseManager.database;
    await db.transaction((txn) async {
      final numberBatch = txn.batch();
      final junctionBatch = txn.batch();

      for (final numberMap in numbers) {
        final phoneNumber = numberMap['phoneNumber'] as String?;
        if (phoneNumber == null) continue;

        // Insert into remote_numbers table
        numberBatch.insert(_tableName, numberMap, conflictAlgorithm: ConflictAlgorithm.replace);

        // Insert into number_countries junction table
        junctionBatch.insert(_junctionTable, {
          'phoneNumber': phoneNumber,
          'countryIsoCode': countryIsoCode,
        }, conflictAlgorithm: ConflictAlgorithm.ignore); // Ignore if the relationship already exists
      }
      
      await numberBatch.commit(noResult: true);
      await junctionBatch.commit(noResult: true);
    });
  }

  Future<void> linkNumberToCountry(String phoneNumber, String countryIsoCode) async {
    final db = await _databaseManager.database;
    await db.insert(
      _junctionTable,
      {
        'phoneNumber': phoneNumber,
        'countryIsoCode': countryIsoCode,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
