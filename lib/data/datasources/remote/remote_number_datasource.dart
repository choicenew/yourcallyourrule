// 文件名: remote_number_data_source.dart
// 描述: 【真正完整的最终版】远程号码数据源实现类，已迁移至 Drift

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/remote/remote_number_model.dart';
import '../../../data/models/sync/sync_record_model.dart';
import '../../database/remote/remote_database.dart'; // 确保这个路径正确
import 'remote_datasource_interface.dart'; // 确保这个路径正确

class RemoteNumberDataSource
    implements RemoteDataSourceInterface<RemoteNumberModel> {
  final RemoteDatabase _database;
  final Uuid _uuid = const Uuid();

  RemoteNumberDataSource(this._database);

  // --- Helper Methods ---

  RemoteNumbersCompanion _modelToCompanion(RemoteNumberModel model) {
    final modelMap = model.toMap();
    return RemoteNumbersCompanion(
      id: Value(model.id ?? _uuid.v4()),
      phoneNumber: Value(model.phoneNumber),
      name: Value(model.name),
      label: Value(model.label),
      priority: Value(model.priority),
      action: Value(model.action),
      count: Value(model.count),
      labels_json: Value(modelMap['labels_json'] as String?),
    );
  }

  RemoteNumberModel _dataToModel(RemoteNumberData data) {
    return RemoteNumberModel.fromMap(data.toJson());
  }

  Future<void> _logOperation(
    String operation,
    String phoneNumber, {
    Map<String, dynamic>? payload,
  }) async {
    final companion = PendingOperationsCompanion.insert(
      id: _uuid.v4(),
      entityId: phoneNumber,
      operation: operation,
      payload: Value(payload != null ? jsonEncode(payload) : null),
      timestamp: DateTime.now().toIso8601String(),
    );
    await _database.into(_database.pendingOperations).insert(companion);
  }

  // --- CRUD Methods ---

  @override
  Future<List<RemoteNumberModel>> getAll() async {
    final results = await _database.select(_database.remoteNumbers).get();
    return results.map(_dataToModel).toList();
  }

  @override
  Future<RemoteNumberModel?> getById(String phoneNumber) async {
    final query = _database.select(_database.remoteNumbers)
      ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
    final result = await query.getSingleOrNull();
    return result != null ? _dataToModel(result) : null;
  }

  @override
  Future<RemoteNumberModel?> getByPhoneNumber(String phoneNumber) async {
    return getById(phoneNumber);
  }

  @override
  Future<String> insert(RemoteNumberModel remoteNumber) async {
    await _database.transaction(() async {
      final companion = _modelToCompanion(remoteNumber);
      await _database
          .into(_database.remoteNumbers)
          .insert(companion, mode: InsertMode.replace);
      await _logOperation('INSERT', remoteNumber.phoneNumber,
          payload: remoteNumber.toMap());
    });
    return remoteNumber.phoneNumber;
  }

  @override
  Future<int> update(RemoteNumberModel remoteNumber) async {
    return await _database.transaction(() async {
      final companion = _modelToCompanion(remoteNumber);
      final query = _database.update(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber));
      final result = await query.write(companion);

      if (result > 0) {
        await _logOperation('UPDATE', remoteNumber.phoneNumber,
            payload: remoteNumber.toMap());
      }
      return result;
    });
  }

  @override
  Future<int> delete(String phoneNumber) async {
    return await _database.transaction(() async {
      final query = _database.delete(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
      final result = await query.go();

      if (result > 0) {
        // [关键修改] 暂时禁用将此删除操作同步到云端。
        // 未来，当审核式删除功能上线时，只需取消这里的注释即可。
        /*
        // [修复逻辑] 在删除前，先获取国家代码
        final countryQuery = _database.select(_database.numberCountries)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
        final countries = await countryQuery.get();
        final countryIsoCode = countries.isNotEmpty ? countries.first.countryIsoCode : null;
        
        await _logOperation(
          'DELETE',
          phoneNumber,
          payload: {'countryIsoCode': countryIsoCode},
        );
        */
      }
      return result;
    });
  }

  @override
  Future<List<String>> insertAll(List<RemoteNumberModel> remoteNumbers) async {
    final phoneNumbers = remoteNumbers.map((e) => e.phoneNumber).toList();
    await _database.transaction(() async {
      final companions = remoteNumbers.map(_modelToCompanion).toList();
      await _database.batch((batch) {
        batch.insertAll(_database.remoteNumbers, companions,
            mode: InsertMode.replace);
      });
      for (final number in remoteNumbers) {
        await _logOperation('INSERT', number.phoneNumber,
            payload: number.toMap());
      }
    });
    return phoneNumbers;
  }

  @override
  Future<int> updateAll(List<RemoteNumberModel> remoteNumbers) async {
    return await _database.transaction(() async {
      int count = 0;
      for (final remoteNumber in remoteNumbers) {
        final companion = _modelToCompanion(remoteNumber);
        final updated = await (_database.update(_database.remoteNumbers)
              ..where((tbl) => tbl.phoneNumber.equals(remoteNumber.phoneNumber)))
            .write(companion);

        if (updated > 0) {
          await _logOperation('UPDATE', remoteNumber.phoneNumber,
              payload: remoteNumber.toMap());
        }
        count += updated;
      }
      return count;
    });
  }

  @override
  Future<int> deleteAll(List<String> phoneNumbers) async {
    return await _database.transaction(() async {
      final query = _database.delete(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.isIn(phoneNumbers));
      final count = await query.go();

      if (count > 0) {
        for (final phoneNumber in phoneNumbers) {
          await _logOperation('DELETE', phoneNumber);
        }
      }
      return count;
    });
  }

  @override
  Future<void> clear() async {
    await _database.transaction(() async {
      await _database.delete(_database.remoteNumbers).go();
      await _database.delete(_database.numberCountries).go();
      await _database.delete(_database.pendingOperations).go();
    });
  }

  // --- Atomic Operations ---

  @override
  Future<int> atomicIncrementCount(
      String phoneNumber, int incrementValue) async {
    return await _database.transaction(() async {
      final existing = await (_database.select(_database.remoteNumbers)
            ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
          .getSingleOrNull();

      if (existing != null) {
        final newCount = existing.count + incrementValue;
        final query = _database.update(_database.remoteNumbers)
          ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
        final result =
            await query.write(RemoteNumbersCompanion(count: Value(newCount)));

        if (result > 0) {
          await _logOperation(
            'INCREMENT',
            phoneNumber,
            payload: {'increment': incrementValue},
          );
        }
        return result;
      }
      return 0;
    });
  }

  @override
  Future<bool> atomicUpdateCount(String phoneNumber, int increment) async {
    final result = await atomicIncrementCount(phoneNumber, increment);
    return result > 0;
  }
  
  @override
  Future<bool> atomicVote(String phoneNumber, String label) async {
    return await _database.transaction(() async {
      final existing = await (_database.select(_database.remoteNumbers)
            ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
          .getSingleOrNull();

      if (existing != null) {
        Map<String, int> labelsCount = {};
        if (existing.labels_json != null && existing.labels_json!.isNotEmpty) {
          try {
            labelsCount =
                Map<String, int>.from(jsonDecode(existing.labels_json!));
          } catch (e) {
            print('Error parsing labels_json: $e');
          }
        }
        labelsCount[label] = (labelsCount[label] ?? 0) + 1;

        String topLabel = label;
        int maxVotes = labelsCount[label]!;
        labelsCount.forEach((key, value) {
          if (value > maxVotes) {
            maxVotes = value;
            topLabel = key;
          }
        });

        final companion = RemoteNumbersCompanion(
          count: Value(existing.count + 1),
          label: Value(topLabel),
          labels_json: Value(jsonEncode(labelsCount)),
        );
        final updated = await (_database.update(_database.remoteNumbers)
              ..where((tbl) => tbl.phoneNumber.equals(phoneNumber)))
            .write(companion);
        if (updated > 0) {
          await _logOperation('VOTE', phoneNumber, payload: {
            'label': label,
            'increment': 1,
            'topLabel': topLabel,
            'labelsCount': labelsCount
          });
          return true;
        }
      } else {
        final companion = RemoteNumbersCompanion.insert(
          id: _uuid.v4(),
          phoneNumber: phoneNumber,
          label: label,
          count: const Value(1),
          labels_json: Value(jsonEncode({label: 1})),
        );
        await _database.into(_database.remoteNumbers).insert(companion);
        await _logOperation('VOTE', phoneNumber, payload: {
          'label': label,
          'increment': 1,
          'topLabel': label,
          'labelsCount': {label: 1}
        });
        return true;
      }
      return false;
    });
  }

  @override
  Future<Map<String, bool>> batchAtomicUpdateCount(
      Map<String, int> updates) async {
    final Map<String, bool> results = {};
    for (var entry in updates.entries) {
      results[entry.key] = await atomicUpdateCount(entry.key, entry.value);
    }
    return results;
  }

  // --- SyncManager Methods ---

  @override
  Future<List<Map<String, dynamic>>> getLocalPendingOperations() async {
    final query = _database.select(_database.pendingOperations)
      ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]);
    final results = await query.get();
    return results.map((e) => e.toJson()).toList();
  }

  @override
  Future<void> clearPendingOperations(List<String> operationIds) async {
    if (operationIds.isEmpty) return;
    await (_database.delete(_database.pendingOperations)
          ..where((tbl) => tbl.id.isIn(operationIds)))
        .go();
  }

  @override
  Future<void> applyRemoteChanges(List<Map<String, dynamic>> changes) async {
    await _database.transaction(() async {
      for (final change in changes) {
        final operation = change['operation'] as String;
        final entityId = change['entityId'] as String;
        final payload = change['payload'] as Map<String, dynamic>;

        switch (operation) {
          case 'INSERT':
          case 'UPDATE':
            final data = RemoteNumberData.fromJson(payload);
            await _database.into(_database.remoteNumbers).insert(
                  data.toCompanion(true),
                  mode: InsertMode.replace,
                );
            break;
          case 'DELETE':
            await (_database.delete(_database.remoteNumbers)
                  ..where((tbl) => tbl.phoneNumber.equals(entityId)))
                .go();
            break;
          case 'INCREMENT':
            final existing = await (_database.select(_database.remoteNumbers)
                  ..where((tbl) => tbl.phoneNumber.equals(entityId)))
                .getSingleOrNull();

            if (existing != null) {
              final increment = (payload['increment'] as num).toInt();
              final newCount = existing.count + increment;
              await (_database.update(_database.remoteNumbers)
                    ..where((tbl) => tbl.phoneNumber.equals(entityId)))
                  .write(RemoteNumbersCompanion(count: Value(newCount)));
            }
            break;
        }
      }
    });
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final query = _database.select(_database.syncRecords)
      ..orderBy([(t) =>
          OrderingTerm(expression: t.syncTime, mode: OrderingMode.desc)])
      ..limit(1);

    final record = await query.getSingleOrNull();
    return record != null ? DateTime.parse(record.syncTime) : null;
  }

  @override
  Future<List<SyncRecordModel>> getSyncRecords({int limit = 10}) async {
    final query = _database.select(_database.syncRecords)
      ..orderBy([(t) =>
          OrderingTerm(expression: t.syncTime, mode: OrderingMode.desc)])
      ..limit(limit);

    final records = await query.get();
    return records
        .map((data) => SyncRecordModel.fromMap(data.toJson()))
        .toList();
  }

  @override
  Future<String> insertSyncRecord(SyncRecordModel syncRecord) async {
    final companion =
        SyncRecordData.fromJson(syncRecord.toMap()).toCompanion(true);
    await _database.into(_database.syncRecords).insert(companion);
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
    final query = _database.select(_database.syncRecords)
      ..orderBy([(t) =>
          OrderingTerm(expression: t.syncTime, mode: OrderingMode.desc)])
      ..limit(1);

    final record = await query.getSingleOrNull();
    return record != null ? SyncRecordModel.fromMap(record.toJson()) : null;
  }

  // --- Other Methods ---

  @override
  Future<List<RemoteNumberModel>> getByLabel(String label) async {
    final results = await (_database.select(_database.remoteNumbers)
          ..where((tbl) => tbl.label.equals(label)))
        .get();
    return results.map(_dataToModel).toList();
  }

  @override
  Future<List<RemoteNumberModel>> getByPriority(int priority) async {
    final results = await (_database.select(_database.remoteNumbers)
          ..where((tbl) => tbl.priority.equals(priority)))
        .get();
    return results.map(_dataToModel).toList();
  }

  @override
  Future<List<RemoteNumberModel>> getByAction(String action) async {
    final results = await (_database.select(_database.remoteNumbers)
          ..where((tbl) => tbl.action.equals(action)))
        .get();
    return results.map(_dataToModel).toList();
  }

  @override
  Future<int> deleteNumbersByCountry(String countryIsoCode) async {
    return await _database.transaction(() async {
      final numbersQuery = _database.select(_database.numberCountries)
        ..where((tbl) => tbl.countryIsoCode.equals(countryIsoCode));
      final numbersToDelete = await numbersQuery.get();
      if (numbersToDelete.isEmpty) return 0;

      final phoneNumbers =
          numbersToDelete.map((row) => row.phoneNumber).toList();
      await (_database.delete(_database.numberCountries)
            ..where((tbl) => tbl.countryIsoCode.equals(countryIsoCode)))
          .go();

      final List<String> orphanedNumbers = [];
      for (final phoneNumber in phoneNumbers) {
        final countQuery = _database.selectOnly(_database.numberCountries)
          ..addColumns([_database.numberCountries.phoneNumber.count()])
          ..where(_database.numberCountries.phoneNumber.equals(phoneNumber));
        final countResult = await countQuery.getSingle();
        if ((countResult.read(_database.numberCountries.phoneNumber.count()) ??
                0) ==
            0) {
          orphanedNumbers.add(phoneNumber);
        }
      }

      if (orphanedNumbers.isNotEmpty) {
        final deletedCount = await (_database.delete(_database.remoteNumbers)
              ..where((tbl) => tbl.phoneNumber.isIn(orphanedNumbers)))
            .go();
        return deletedCount;
      }
      return 0;
    });
  }

  @override
  Future<String> insertRemoteNumber(Map<String, dynamic> data) async {
    final String phoneNumber = data['phoneNumber'] as String;
    await _database.transaction(() async {
      await _database.into(_database.remoteNumbers).insert(
            RemoteNumberData.fromJson(data).toCompanion(true),
            mode: InsertMode.replace,
          );
      await _logOperation('INSERT', phoneNumber, payload: data);
    });
    return phoneNumber;
  }

  @override
  Future<void> bulkInsertFromServer(
      String countryIsoCode, List<Map<String, dynamic>> numbers) async {
    if (numbers.isEmpty) return;
    await _database.batch((batch) {
      for (final numberMap in numbers) {
        final phoneNumber = numberMap['phoneNumber'] as String?;
        if (phoneNumber == null) continue;
        batch.insert(
          _database.remoteNumbers,
          RemoteNumberData.fromJson(numberMap).toCompanion(true),
          mode: InsertMode.replace,
        );
        batch.insert(
          _database.numberCountries,
          NumberCountriesCompanion.insert(
              phoneNumber: phoneNumber, countryIsoCode: countryIsoCode),
          mode: InsertMode.insertOrIgnore,
        );
      }
    });
  }

  @override
  Future<void> linkNumberToCountry(
      String phoneNumber, String countryIsoCode) async {
    await _database.into(_database.numberCountries).insert(
      NumberCountriesCompanion.insert(
          phoneNumber: phoneNumber, countryIsoCode: countryIsoCode),
      mode: InsertMode.insertOrIgnore,
    );
  }

  // --- 众包删除审核系统相关方法 ---
  // =======================================================================
  // 【MODIFIED】: 以下所有与“删除提议”相关的方法已被彻底移除。
  // REASON: 为了实现职责分离（Separation of Concerns），所有与“提议”相关的
  //         数据库操作都必须内聚在 `ProposalDataSource` 中。将它们分散在
  //         `RemoteNumberDataSource` 中会导致逻辑混乱和维护困难。
  // =======================================================================
  /*
  /// 记录自定义操作到pending_operations表
  /// 用于支持删除提议等新的操作类型
  Future<void> logCustomOperation(
    String operation,
    String phoneNumber,
    Map<String, dynamic>? payload,
  ) async {
    await _database.transaction(() async {
      await _logOperation(
        operation,
        phoneNumber,
        payload: payload,
      );
    });
  }

  /// 提议删除号码
  /// 这个方法会记录一个PROPOSE_DELETION操作到pending_operations表
  Future<void> proposeDeletion(
    String phoneNumber,
    Map<String, dynamic> report,
  ) async {
    await logCustomOperation(
      'PROPOSE_DELETION',
      phoneNumber,
      {
        'report': report,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// 对删除提议进行投票
  /// 这个方法会记录一个VOTE_DELETION操作到pending_operations表
  Future<void> voteOnDeletionProposal(
    String phoneNumber,
    String voteType, // 'support' 或 'oppose'
    Map<String, dynamic>? additionalData,
  ) async {
    await logCustomOperation(
      'VOTE_DELETION',
      phoneNumber,
      {
        'voteType': voteType,
        'additionalData': additionalData,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// 获取待处理的删除提议操作
  /// 返回所有PROPOSE_DELETION类型的pending operations
  Future<List<Map<String, dynamic>>> getPendingDeletionProposals() async {
    final query = _database.select(_database.pendingOperations)
      ..where((tbl) => tbl.operation.equals('PROPOSE_DELETION'))
      ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]);
    final results = await query.get();
    return results.map((e) => e.toJson()).toList();
  }

  /// 获取待处理的删除投票操作
  /// 返回所有VOTE_DELETION类型的pending operations
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes() async {
    final query = _database.select(_database.pendingOperations)
      ..where((tbl) => tbl.operation.equals('VOTE_DELETION'))
      ..orderBy([(t) => OrderingTerm(expression: t.timestamp)]);
    final results = await query.get();
    return results.map((e) => e.toJson()).toList();
  }

  /// 检查号码是否已有待处理的删除提议
  Future<bool> hasPendingDeletionProposal(String phoneNumber) async {
    final query = _database.select(_database.pendingOperations)
      ..where((tbl) => tbl.operation.equals('PROPOSE_DELETION') & tbl.entityId.equals(phoneNumber))
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result != null;
  }

  /// 清除特定号码的删除相关操作
  Future<void> clearDeletionOperations(String phoneNumber) async {
    final query = _database.delete(_database.pendingOperations)
      ..where((tbl) => tbl.entityId.equals(phoneNumber) &
                      (tbl.operation.equals('PROPOSE_DELETION') | tbl.operation.equals('VOTE_DELETION')));
    await query.go();
  }
  
  /// 获取号码的标签信息
  Future<Map<String, dynamic>?> getNumberLabels(String phoneNumber) async {
    try {
      final query = _database.select(_database.remoteNumbers)
        ..where((tbl) => tbl.phoneNumber.equals(phoneNumber));
      final result = await query.getSingleOrNull();
      
      if (result != null && result.labels_json != null) {
        return jsonDecode(result.labels_json!);
      }
      return null;
    } catch (e) {
      print('RemoteNumberDataSource: Error getting number labels: $e');
      return null;
    }
  }
  
  /// 获取提议信息，包括验证报告
  Future<Map<String, dynamic>?> getProposalInfo(String phoneNumber) async {
    try {
      final query = _database.select(_database.pendingOperations)
        ..where((tbl) => tbl.entityId.equals(phoneNumber) & tbl.operation.equals('PROPOSE_DELETION'));
      final proposals = await query.get();
      
      if (proposals.isNotEmpty) {
        final proposal = proposals.first;
        final String? payloadStr = proposal.payload;
        if (payloadStr != null) {
          return jsonDecode(payloadStr);
        }
      }
      return null;
    } catch (e) {
      print('RemoteNumberDataSource: Error getting proposal info: $e');
      return null;
    }
  }

  // 这些方法已移至 ProposalDataSource
  // countRecentProposals 和 countTotalVotes 方法已被移除
  // 请使用 ProposalDataSource 中的 countRecentProposals 和 countUnconsumedVotes 方法
  */
}