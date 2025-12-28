// remote_number_data_source.dart (最终完整且无语法错误版本)

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database.dart';

import '../../../data/models/remote/remote_number_model.dart';
import '../../../data/models/sync/sync_record_model.dart';

import 'remote_datasource_interface.dart';


// 远程号码数据源实现
class RemoteNumberDataSource
    implements RemoteDataSourceInterface<RemoteNumberModel> {
  
  final RemoteDatabase _database;
  final Uuid _uuid = const Uuid();

  RemoteNumberDataSource(this._database);

  // --- 辅助方法: 数据转换 ---

  RemoteNumberModel _fromRemoteNumberData(RemoteNumberData data) {
    return RemoteNumberModel(
      id: data.id, 
      name: data.name,
      phoneNumber: data.phoneNumber,
      label: data.label,
      priority: data.priority,
      action: data.action,
      count: data.count,
    );
  }
  
  RemoteNumbersCompanion _toRemoteNumberCompanion(RemoteNumberModel model) {
    return RemoteNumbersCompanion(
      id: Value(model.id),
      phoneNumber: Value(model.phoneNumber),
      name: Value(model.name),
      label: Value(model.label),
      priority: Value(model.priority),
      action: Value(model.action),
      count: Value(model.count),
      labelsJson: const Value.absent(), 
    );
  }
  
  SyncRecordsCompanion _toSyncRecordCompanion(SyncRecordModel model) {
    return SyncRecordsCompanion(
      id: Value(model.id),
      syncTime: Value(model.syncTime.toIso8601String()),
      syncType: Value(model.syncType),
      status: Value(model.status),
      pushedRecordCount: Value(model.pushedRecordCount),
      pulledRecordCount: Value(model.pulledRecordCount),
      errorMessage: Value(model.errorMessage),
      metadata: Value(model.metadata),
    );
  }
  
  SyncRecordModel _fromSyncRecordData(SyncRecordData data) {
    return SyncRecordModel(
      id: data.id,
      syncTime: DateTime.parse(data.syncTime),
      syncType: data.syncType,
      status: data.status,
      pushedRecordCount: data.pushedRecordCount,
      pulledRecordCount: data.pulledRecordCount,
      errorMessage: data.errorMessage,
      metadata: data.metadata,
    );
  }

  // 记录待处理操作的内部方法 (接收 DatabaseConnectionUser)
  Future<void> _logOperation(
    DatabaseConnectionUser executor, 
    String operation,
    String phoneNumber, {
    Map<String, dynamic>? payload,
  }) async {
    await executor.into(_database.pendingOperations).insert(
      PendingOperationsCompanion.insert(
        id: _uuid.v4(),
        entityId: phoneNumber, 
        operation: operation,
        payload: Value(payload != null ? jsonEncode(payload) : null),
        timestamp: DateTime.now().toIso8601String(),
      ),
    );
  }

  // --- 核心 CRUD ---

  @override
  Future<List<RemoteNumberModel>> getAll() async {
    final results = await _database.select(_database.remoteNumbers).get();
    return results.map(_fromRemoteNumberData).toList();
  }

  @override
  Future<RemoteNumberModel?> getById(String phoneNumber) async {
    final result = await (_database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
      ..limit(1))
      .getSingleOrNull();

    return result != null ? _fromRemoteNumberData(result) : null;
  }

  Future<RemoteNumberModel?> getByPhoneNumber(String phoneNumber) async {
    return getById(phoneNumber);
  }

  // 插入远程号码
  @override
  Future<String> insert(RemoteNumberModel remoteNumber) async {
    await _database.transaction(() async {
      await _database.into(_database.remoteNumbers).insert(
        _toRemoteNumberCompanion(remoteNumber).copyWith(id: Value(_uuid.v4())), 
        mode: InsertMode.insertOrReplace,
      );
      await _logOperation(_database, 'INSERT', remoteNumber.phoneNumber,
          payload: remoteNumber.toMap());
    });

    return remoteNumber.phoneNumber;
  }

  // 更新远程号码
  @override
  Future<int> update(RemoteNumberModel remoteNumber) async {
    int result = 0;
    await _database.transaction(() async {
      result = await (_database.update(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber)))
        .write(_toRemoteNumberCompanion(remoteNumber));
        
      if (result > 0) {
        await _logOperation(_database, 'UPDATE', remoteNumber.phoneNumber,
            payload: remoteNumber.toMap());
      }
    });
    return result;
  }

  @override
  Future<int> delete(String phoneNumber) async {
    int result = 0;
    await _database.transaction(() async {
      result = await (_database.delete(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
        .go();
    });
    return result;
  }

  // 原子更新计数器 (使用先读后写模式)
 @override
Future<int> atomicIncrementCount(String phoneNumber, int incrementValue) async {
  int updatedRows = 0;
  await _database.transaction(() async {
    // 【关键修改】
    // 直接构造一个更新语句，让数据库自己执行 "SET count = count + ?"
    final updateStatement = _database.update(_database.remoteNumbers)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));

    updatedRows = await updateStatement.write(
      RemoteNumbersCompanion.custom(
        // 使用 custom companion 来构建表达式
        // 这会生成类似 SQL: UPDATE remote_numbers SET count = count + [incrementValue]
        count: _database.remoteNumbers.count + Constant(incrementValue),
      ),
    );

    if (updatedRows > 0) {
      await _logOperation(
        _database, // _logOperation 接收 DatabaseConnectionUser
        'INCREMENT',
        phoneNumber,
        payload: {'increment': incrementValue},
      );
    }
  });
  // 返回受影响的行数，如果 > 0 则表示成功
  return updatedRows;
}        
         
            
  // 批量插入远程号码
  @override
  Future<List<String>> insertAll(List<RemoteNumberModel> remoteNumbers) async {
    final List<String> phoneNumbers = [];
    await _database.transaction(() async {
      for (final remoteNumber in remoteNumbers) {
        await _database.into(_database.remoteNumbers).insert(
          _toRemoteNumberCompanion(remoteNumber).copyWith(id: Value(_uuid.v4())),
          mode: InsertMode.insertOrReplace,
        );
        await _logOperation(_database, 'INSERT', remoteNumber.phoneNumber,
            payload: remoteNumber.toMap());
        phoneNumbers.add(remoteNumber.phoneNumber);
      }
    });
    return phoneNumbers;
  }

  // 批量更新远程号码
  @override
  Future<int> updateAll(List<RemoteNumberModel> remoteNumbers) async {
    int count = 0;
    await _database.transaction(() async {
      for (final remoteNumber in remoteNumbers) {
        final int updated = await (_database.update(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber)))
          .write(_toRemoteNumberCompanion(remoteNumber));
          
        if (updated > 0) {
          await _logOperation(_database, 'UPDATE', remoteNumber.phoneNumber,
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
    int count = 0;
    await _database.transaction(() async {
      for (final phoneNumber in phoneNumbers) {
        final int deleted = await (_database.delete(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
          .go();
          
        if (deleted > 0) {
          await _logOperation(_database, 'DELETE', phoneNumber);
        }
        count += deleted;
      }
    });
    return count;
  }

  // 清空所有远程号码
  @override
  Future<void> clear() async {
    await _database.delete(_database.remoteNumbers).go();
    await _database.delete(_database.pendingOperations).go();
  }

  // --- New methods for SyncManager ---

  Future<List<Map<String, dynamic>>> getLocalPendingOperations() async {
    final results = await (_database.select(_database.pendingOperations)
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.timestamp, mode: OrderingMode.asc)
      ]))
      .get();
    
    return results.map((data) => data.toJson()).toList();
  }

  Future<void> clearPendingOperations(List<String> operationIds) async {
    if (operationIds.isEmpty) return;
    await _database.transaction(() async {
      await (_database.delete(_database.pendingOperations)
        ..where((tbl) => tbl.id.isIn(operationIds)))
        .go();
    });
  }

  Future<void> applyRemoteChanges(List<Map<String, dynamic>> changes) async {
    await _database.transaction(() async {
      for (final change in changes) {
        final operation = change['operation'] as String;
        final entityId = change['entityId'] as String;
        final payload = change['payload'] as Map<String, dynamic>?;

        switch (operation) {
          case 'INSERT':
          case 'UPDATE':
            if (payload == null) continue;
            // 修正：使用 RemoteNumberData.fromJson 然后转 Companion
            final data = RemoteNumberData.fromJson(payload);
            final companion = data.toCompanion(true);
            
            await _database.into(_database.remoteNumbers).insert(
              companion.copyWith(phoneNumber: Value(entityId)),
              mode: InsertMode.insertOrReplace,
            );
            break;
          case 'DELETE':
            await (_database.delete(_database.remoteNumbers)
              ..where((tbl) => tbl.phoneNumber.equals(entityId)))
              .go();
            break;
      
      
      
      case 'INCREMENT':
            if (payload != null && payload.containsKey('increment')) {
              final incrementValue = (payload['increment'] as num).toInt();
              // 【最终正确方案】
              await (_database.update(_database.remoteNumbers)
                    ..where((tbl) => tbl.phoneNumber.equals(entityId)))
                  .write(
                RemoteNumbersCompanion.custom(
                  count: _database.remoteNumbers.count + Constant(incrementValue),
                ),
              );
            }
      
      
      
      
      
      
      
            break;
        }
      }
    });
  }

  // --- SyncRecord 相关的实现 ---

  @override
  Future<DateTime?> getLastSyncTime() async {
    final maxTimeExpression = _database.syncRecords.syncTime.max();
    
    final query = _database.selectOnly(_database.syncRecords)
      ..addColumns([maxTimeExpression]);
      
    final result = await query.getSingleOrNull();

    final timeString = result?.read(maxTimeExpression); 
    return timeString != null ? DateTime.tryParse(timeString) : null;
  }

  @override
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10}) async {
    final results = await (_database.select(_database.syncRecords)
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.syncTime, mode: OrderingMode.desc)
      ])
      ..limit(limit))
      .get();
      
    return results.map(_fromSyncRecordData).toList();
  }
  
  @override
  Future<String> insertSyncRecord(SyncRecordModel syncRecord) async {
    await _database.into(_database.syncRecords).insert(_toSyncRecordCompanion(syncRecord));
    return syncRecord.id;
  }

  Future<bool> needSync(int syncIntervalHours) async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return true;
    return DateTime.now().difference(lastSync).inHours >= syncIntervalHours;
  }

  @override
  Future<SyncRecordModel?> getLastSyncRecord() async {
    final result = await (_database.select(_database.syncRecords)
      ..orderBy([
        (tbl) => OrderingTerm(expression: tbl.syncTime, mode: OrderingMode.desc)
      ])
      ..limit(1))
      .getSingleOrNull();
      
    return result != null ? _fromSyncRecordData(result) : null;
  }

  @override
  Future<bool> atomicUpdateCount(String phoneNumber, int increment) async {
    final result = await atomicIncrementCount(phoneNumber, increment);
    return result > 0;
  }
  
  // 实现投票机制的原子操作 - 投票制模式
  @override
  Future<bool> atomicVote(String phoneNumber, String label) async {
    if (label.isEmpty) {
      return false; 
    }
    
    int result = 0;
    
    await _database.transaction(() async {
      
      final existingNumber = await (_database.select(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber))
        ..limit(1))
        .getSingleOrNull();
      
      RemoteNumbersCompanion companion;
      Map<String, int> labelsCount = {};

      if (existingNumber != null) {
        
        final currentCount = existingNumber.count;
        final labelsJson = existingNumber.labelsJson;
        if (labelsJson != null && labelsJson.isNotEmpty) {
          try {
            labelsCount = Map<String, int>.from(jsonDecode(labelsJson).map((k, v) => MapEntry(k, v is int ? v : int.tryParse(v.toString()) ?? 0)));
          } catch (e) {
            // 解析失败，忽略
          }
        }
        
        labelsCount[label] = (labelsCount[label] ?? 0) + 1;
        
        String topLabel = existingNumber.label;
        int maxVotes = labelsCount[topLabel] ?? 0;
        
        labelsCount.forEach((key, value) {
          if (value > maxVotes) {
            maxVotes = value;
            topLabel = key;
          }
        });
        
        final newCount = currentCount + 1;
        
        companion = RemoteNumbersCompanion(
          count: Value(newCount),
          label: Value(topLabel),
          labelsJson: Value(jsonEncode(labelsCount)),
        );
        
        result = await (_database.update(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
          .write(companion);
        
        if (result > 0) {
          await _logOperation(
            _database, 
            'VOTE',
            phoneNumber,
            payload: {
              'label': label,
              'increment': 1,
              'topLabel': topLabel,
              'labelsCount': labelsCount
            },
          );
        }
      } else {
        // 记录不存在，创建新记录
        labelsCount = {label: 1};
        companion = RemoteNumbersCompanion.insert(
          id: _uuid.v4(),
          phoneNumber: phoneNumber,
          label: label,
          count: Value(1), // 修正：使用 Value(1)
          labelsJson: Value(jsonEncode(labelsCount)),
        );
        
        result = await _database.into(_database.remoteNumbers).insert(companion);
        
        if (result > 0) {
          await _logOperation(
            _database, 
            'VOTE',
            phoneNumber,
            payload: {
              'label': label,
              'increment': 1,
              'topLabel': label,
              'labelsCount': {label: 1}
            },
          );
        }
      }
    });
    
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
    final results = await (_database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.label.equals(label)))
      .get();
      
    return results.map(_fromRemoteNumberData).toList();
  }

  // 根据优先级查询远程号码
  Future<List<RemoteNumberModel>> getByPriority(int priority) async {
    final results = await (_database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.priority.equals(priority)))
      .get();
      
    return results.map(_fromRemoteNumberData).toList();
  }

  // 根据动作查询远程号码
  Future<List<RemoteNumberModel>> getByAction(String action) async {
    final results = await (_database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.action.equals(action)))
      .get();
      
    return results.map(_fromRemoteNumberData).toList();
  }
  
  // 删除特定国家代码的所有号码
  Future<int> deleteNumbersByCountry(String countryIsoCode) async {
    int deletedCount = 0;

    await _database.transaction(() async {
      
      final numbersToDelete = await (_database.select(_database.numberCountries)
        ..where((tbl) => tbl.countryIsoCode.equals(countryIsoCode)))
        .get();

      if (numbersToDelete.isEmpty) return;

      final phoneNumbers = numbersToDelete.map((row) => row.phoneNumber).toList();

      await (_database.delete(_database.numberCountries)
        ..where((tbl) => tbl.countryIsoCode.equals(countryIsoCode)))
        .go();

      final List<String> orphanedNumbers = [];
      for (final phoneNumber in phoneNumbers) {
        // 修正：使用 _database 上的表引用访问表名
        final countResult = await _database.customSelect(
          'SELECT COUNT(*) as count FROM ${_database.numberCountries.actualTableName} WHERE phoneNumber = ?',
          variables: [Variable.withString(phoneNumber)],
          readsFrom: {_database.numberCountries},
        ).getSingle();
        
        final count = countResult.read('count') as int?;
        if (count == 0) {
          orphanedNumbers.add(phoneNumber);
        }
      }

      if (orphanedNumbers.isNotEmpty) {
        final result = await (_database.delete(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.isIn(orphanedNumbers)))
          .go();
          
        deletedCount = result;
      }
    });

    return deletedCount;
  }
  
  /// 插入远程号码数据（不使用模型）
  Future<String> insertRemoteNumber(Map<String, dynamic> data) async {
    final String phoneNumber = data['phoneNumber'] as String;
    
    await _database.transaction(() async {
      // 修正：使用 fromJson 构造 Data，再转 Companion
      final companion = RemoteNumberData.fromJson(data).toCompanion(true);
      
      await _database.into(_database.remoteNumbers).insert(
        companion,
        mode: InsertMode.insertOrReplace,
      );
      await _logOperation(_database, 'INSERT', phoneNumber, payload: data);
    });
    
    return phoneNumber;
  }
  
  /// 批量插入从服务器获取的远程号码数据，不记录到pending_operations
  Future<void> bulkInsertFromServer(String countryIsoCode, List<Map<String, dynamic>> numbers) async {
    if (numbers.isEmpty) return;
    
    await _database.batch((batch) {
      for (final numberMap in numbers) {
        final phoneNumber = numberMap['phoneNumber'] as String?;
        if (phoneNumber == null) continue;

        // Insert into remote_numbers table
        final numberCompanion = RemoteNumberData.fromJson(numberMap).toCompanion(true);
        batch.insert(_database.remoteNumbers, numberCompanion, mode: InsertMode.insertOrReplace);

        // Insert into number_countries junction table
        batch.insert(_database.numberCountries, NumberCountriesCompanion.insert(
          phoneNumber: phoneNumber,
          countryIsoCode: countryIsoCode,
        ), mode: InsertMode.insertOrIgnore); 
      }
    });
  }

  Future<void> linkNumberToCountry(String phoneNumber, String countryIsoCode) async {
    await _database.into(_database.numberCountries).insert(
      NumberCountriesCompanion.insert(
        phoneNumber: phoneNumber,
        countryIsoCode: countryIsoCode,
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }
}