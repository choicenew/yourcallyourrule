// 远程号码数据源实现类，用于处理远程号码数据的CRUD操作和同步

import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/services/cloudflare_d1_service.dart';

import '../../../data/models/remote/remote_number_model.dart';
import '../../../data/models/sync/sync_record_model.dart';
import '../../database/database_manager.dart';
import '../datasource_interface.dart';
import 'remote_datasource_interface.dart';

// 远程号码数据源实现
class RemoteNumberDataSource
    implements RemoteDataSourceInterface<RemoteNumberModel> {
  // 数据库管理器
  final RemoteDatabaseManager _databaseManager;

  // 表名
  static const String _tableName = 'remote_numbers';
  static const String _syncTableName = 'sync_records';

  // 同步类型
  static const String _syncTypeFull = 'full';
  static const String _syncTypeIncremental = 'incremental';

  // 同步状态
  static const String _syncStatusSuccess = 'success';
  static const String _syncStatusFailed = 'failed';

  // 构造函数
  RemoteNumberDataSource(this._databaseManager);

  // 获取所有远程号码
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
    final RemoteNumberModel remoteNumberWithId = remoteNumber.id.isEmpty
        ? RemoteNumberModel(
            id: id,
            name: remoteNumber.name,
            phoneNumber: remoteNumber.phoneNumber,
            label: remoteNumber.label,
            priority: remoteNumber.priority,
            action: remoteNumber.action,
            count: remoteNumber.count,
          )
        : remoteNumber;

    await db.insert(
      _tableName,
      remoteNumberWithId.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // 更新同步记录
    await _updateSyncRecord('insert');

    return id;
  }

  // 更新远程号码
  @override
  Future<int> update(RemoteNumberModel remoteNumber) async {
    final db = await _databaseManager.database;

    final result = await db.update(
      _tableName,
      remoteNumber.toMap(),
      where: 'id = ?',
      whereArgs: [remoteNumber.id],
    );

    // 更新同步记录
    if (result > 0) {
      await _updateSyncRecord('update');
    }

    return result;
  }
  
  // 原子更新计数器（带乐观锁机制）
  @override
  Future<int> atomicIncrementCount(String id, int incrementValue) async {
    final db = await _databaseManager.database;
    int updatedCount = 0;
    int retryCount = 0;
    const maxRetries = 3; // 最大重试次数
    
    while (retryCount < maxRetries) {
      try {
        await db.transaction((txn) async {
          // 1. 获取当前记录，包括版本号
          final List<Map<String, dynamic>> maps = await txn.query(
            _tableName,
            columns: ['count', 'version'],
            where: 'id = ?',
            whereArgs: [id],
          );
          
          if (maps.isEmpty) {
            return 0;
          }
          
          // 2. 解析当前计数值和版本号
          final currentCount = maps.first['count'] is String 
              ? int.tryParse(maps.first['count'] ?? '0') ?? 0 
              : (maps.first['count'] ?? 0);
          final currentVersion = maps.first['version'] is String
              ? int.tryParse(maps.first['version'] ?? '0') ?? 0
              : (maps.first['version'] ?? 0);
          
          // 3. 计算新的计数值和版本号
          final newCount = currentCount + incrementValue;
          final newVersion = currentVersion + 1;
          
          // 4. 使用乐观锁更新记录
          updatedCount = await txn.update(
            _tableName,
            {
              'count': newCount,
              'version': newVersion,
              'updatedAt': DateTime.now().toIso8601String(),
            },
            where: 'id = ? AND version = ?',
            whereArgs: [id, currentVersion],
          );
          
          // 5. 记录同步状态，包含元数据
          if (updatedCount > 0) {
            final metadata = jsonEncode({
              'entityId': id,
              'field': 'count',
              'oldValue': currentCount,
              'newValue': newCount,
              'changeValue': incrementValue,
              'operation': 'increment',
              'version': newVersion,
            });
            
            await _updateSyncRecordWithMetadata('atomic_update', metadata);
            //break; // 更新成功，跳出循环
          } else {
            // 乐观锁冲突，需要重试
            throw Exception('乐观锁冲突，需要重试');
          }
        });
        break; // 事务成功完成，跳出循环
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          // 达到最大重试次数，记录失败
          final metadata = jsonEncode({
            'entityId': id,
            'field': 'count',
            'changeValue': incrementValue,
            'operation': 'increment',
            'error': e.toString(),
            'retryCount': retryCount,
          });
          await _updateSyncRecordWithMetadata('atomic_update_failed', metadata, error: e.toString());
          return 0; // 返回失败
        }
        // 短暂延迟后重试
        await Future.delayed(Duration(milliseconds: 100 * retryCount));
      }
    }
    
    return updatedCount;
  }

  // 删除远程号码
  @override
  Future<int> delete(String id) async {
    final db = await _databaseManager.database;

    final result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    // 更新同步记录
    if (result > 0) {
      await _updateSyncRecord('delete');
    }

    return result;
  }

  // 批量插入远程号码
  @override
  Future<List<String>> insertAll(List<RemoteNumberModel> remoteNumbers) async {
    final List<String> ids = [];
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final remoteNumber in remoteNumbers) {
        // 如果没有ID，生成一个新的UUID
        final String id =
            remoteNumber.id.isEmpty ? const Uuid().v4() : remoteNumber.id;
        final RemoteNumberModel remoteNumberWithId = remoteNumber.id.isEmpty
            ? RemoteNumberModel(
                id: id,
                name: remoteNumber.name,
                phoneNumber: remoteNumber.phoneNumber,
                label: remoteNumber.label,
                priority: remoteNumber.priority,
                action: remoteNumber.action,
                count: remoteNumber.count,
              )
            : remoteNumber;

        await txn.insert(
          _tableName,
          remoteNumberWithId.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        ids.add(id);
      }
    });

    // 更新同步记录
    await _updateSyncRecord(_syncTypeIncremental);

    return ids;
  }

  // 批量更新远程号码
  @override
  Future<int> updateAll(List<RemoteNumberModel> remoteNumbers) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final remoteNumber in remoteNumbers) {
        final int updated = await txn.update(
          _tableName,
          remoteNumber.toMap(),
          where: 'id = ?',
          whereArgs: [remoteNumber.id],
        );

        count += updated;
      }
    });

    // 更新同步记录
    if (count > 0) {
      await _updateSyncRecord(_syncTypeIncremental);
    }

    return count;
  }

  // 批量删除远程号码
  @override
  Future<int> deleteAll(List<String> ids) async {
    int count = 0;
    final db = await _databaseManager.database;

    await db.transaction((txn) async {
      for (final id in ids) {
        final int deleted = await txn.delete(
          _tableName,
          where: 'id = ?',
          whereArgs: [id],
        );

        count += deleted;
      }
    });

    // 更新同步记录
    if (count > 0) {
      await _updateSyncRecord(_syncTypeIncremental);
    }

    return count;
  }

  // 清空所有远程号码
  @override
  Future<void> clear() async {
    final db = await _databaseManager.database;
    await db.delete(_tableName);

    // 更新同步记录
    await _updateSyncRecord(_syncTypeFull);
  }

  // 同步数据
  @override
  Future<bool> syncData() async {
    try {
      // 这里应该实现与远程服务器的同步逻辑
      // 例如：从服务器获取最新数据，更新本地数据库
      
      // 使用CloudFlare D1的原子操作进行同步
      await _syncWithCloudFlareD1();

      // 更新同步记录
      await _updateSyncRecord('full_sync');

      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 与CloudFlare D1同步数据
  Future<void> _syncWithCloudFlareD1() async {
    final db = await _databaseManager.database;
    
    // 1. 获取需要同步的本地数据
    final lastSyncRecord = await getLastSyncRecord();
    final DateTime? lastSyncTime = lastSyncRecord?.syncTime;
    
    // 2. 查询自上次同步以来的本地更改
    final List<Map<String, dynamic>> localChanges = await db.query(
      _tableName,
      where: lastSyncTime != null ? 'updatedAt > ?' : null,
      whereArgs: lastSyncTime != null ? [lastSyncTime.toIso8601String()] : null,
    );
    
    // 3. 获取自上次同步以来的原子更新记录
    final List<SyncRecordModel> atomicUpdates = await _getAtomicUpdateRecords(lastSyncTime);
    final Map<String, int> entityCountChanges = {};
    
    // 4. 从同步记录中提取计数变化信息
    for (final record in atomicUpdates) {
      if (record.metadata != null) {
        try {
          final Map<String, dynamic> metadata = jsonDecode(record.metadata!);
          final String entityId = metadata['entityId'] as String? ?? '';
          final int changeValue = metadata['changeValue'] is String
              ? int.tryParse(metadata['changeValue'] ?? '0') ?? 0
              : (metadata['changeValue'] ?? 0);
          
          if (entityId.isNotEmpty) {
            entityCountChanges[entityId] = (entityCountChanges[entityId] ?? 0) + changeValue;
          }
        } catch (e) {
          // 解析元数据失败，跳过此记录
          continue;
        }
      }
    }
    
    // 5. 对于每个本地更改，使用原子操作同步到CloudFlare D1
    for (final change in localChanges) {
      final remoteNumber = RemoteNumberModel.fromMap(change);
      final int countChange = entityCountChanges[remoteNumber.id] ?? 0;
      
      if (countChange != 0) {
        // 使用CloudFlare D1的原子操作更新计数
        await CloudFlareD1Service().atomicUpdate(
          databaseId: dotenv.get('CF_D1_DATABASE_ID'),
          query: 'UPDATE $_tableName SET count = count + ?, version = ? WHERE id = ?',
          params: {'1': countChange, '2': change['version'], '3': remoteNumber.id},
        );
        
        // 记录同步操作
        final metadata = jsonEncode({
          'entityId': remoteNumber.id,
          'field': 'count',
          'changeValue': countChange,
          'operation': 'cloudflare_sync',
          'version': change['version'],
        });
        
        await _updateSyncRecordWithMetadata('cloudflare_sync', metadata);
      }
    }
  }
  
  // 获取原子更新记录
  Future<List<SyncRecordModel>> _getAtomicUpdateRecords(DateTime? since) async {
    final db = await _databaseManager.database;
    
    final List<Map<String, dynamic>> records = await db.query(
      _syncTableName,
      where: since != null ? 'lastSyncTime > ? AND syncType LIKE ?' : 'syncType LIKE ?',
      whereArgs: since != null 
          ? [since.toIso8601String(), '%atomic_update%'] 
          : ['%atomic_update%'],
      orderBy: 'lastSyncTime ASC',
    );
    
    return records.map((record) => SyncRecordModel.fromMap(record)).toList();
  }

  // 获取最后同步时间
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

  // 增量同步数据
  @override
  Future<bool> incrementalSync(DateTime lastSyncTime) async {
    try {
      // 这里应该实现与远程服务器的增量同步逻辑
      // 例如：从服务器获取自上次同步以来的变更数据
      
      // 使用CloudFlare D1的原子操作进行增量同步
      await _incrementalSyncWithCloudFlareD1(lastSyncTime);

      // 更新同步记录
      await _updateSyncRecord('incremental_sync');

      return true;
    } catch (e) {
      return false;
    }
  }
  
  // 与CloudFlare D1进行增量同步
  Future<void> _incrementalSyncWithCloudFlareD1(DateTime lastSyncTime) async {
    final db = await _databaseManager.database;
    
    // 1. 获取需要同步的本地数据
    final List<Map<String, dynamic>> localChanges = await db.query(
      _tableName,
      where: 'updatedAt > ?',
      whereArgs: [lastSyncTime.toIso8601String()],
    );
    
    // 2. 获取自上次同步以来的原子更新记录
    final List<SyncRecordModel> atomicUpdates = await _getAtomicUpdateRecords(lastSyncTime);
    final Map<String, int> entityCountChanges = {};
    
    // 3. 从同步记录中提取计数变化信息
    for (final record in atomicUpdates) {
      if (record.metadata != null) {
        try {
          final Map<String, dynamic> metadata = jsonDecode(record.metadata!);
          
          // 处理单个实体的原子更新
          if (metadata.containsKey('entityId')) {
            final String entityId = metadata['entityId'] as String? ?? '';
            final int changeValue = metadata['changeValue'] is String
                ? int.tryParse(metadata['changeValue'] ?? '0') ?? 0
                : (metadata['changeValue'] ?? 0);
            
            if (entityId.isNotEmpty) {
              entityCountChanges[entityId] = (entityCountChanges[entityId] ?? 0) + changeValue;
            }
          } 
          // 处理批量原子更新
          else if (metadata.containsKey('updates') && metadata['updates'] is Map) {
            final Map<String, dynamic> updates = metadata['updates'] as Map<String, dynamic>;
            
            for (final entry in updates.entries) {
              final String entityId = entry.key;
              final Map<String, dynamic> updateInfo = entry.value as Map<String, dynamic>;
              final int changeValue = updateInfo['changeValue'] is String
                  ? int.tryParse(updateInfo['changeValue'] ?? '0') ?? 0
                  : (updateInfo['changeValue'] ?? 0);
              
              if (entityId.isNotEmpty) {
                entityCountChanges[entityId] = (entityCountChanges[entityId] ?? 0) + changeValue;
              }
            }
          }
        } catch (e) {
          // 解析元数据失败，跳过此记录
          continue;
        }
      }
    }
    
    // 4. 对于每个本地更改，使用原子操作同步到CloudFlare D1
    for (final change in localChanges) {
      final remoteNumber = RemoteNumberModel.fromMap(change);
      final int countChange = entityCountChanges[remoteNumber.id] ?? 0;
      
      if (countChange != 0) {
        // 使用CloudFlare D1的原子操作更新计数
        await CloudFlareD1Service().atomicUpdate(
          databaseId: dotenv.get('CF_D1_DATABASE_ID'),
          query: 'UPDATE $_tableName SET count = count + ?, version = ? WHERE id = ?',
          params: {'1': countChange, '2': change['version'], '3': remoteNumber.id},
        );
        
        // 记录同步操作
        final metadata = jsonEncode({
          'entityId': remoteNumber.id,
          'field': 'count',
          'changeValue': countChange,
          'operation': 'incremental_sync',
          'version': change['version'],
          'syncTime': DateTime.now().toIso8601String(),
        });
        
        await _updateSyncRecordWithMetadata('incremental_sync', metadata);
      }
    }
    
    // 5. 从CloudFlare D1获取远程更改并应用到本地
    final remoteChanges = await CloudFlareD1Service().getChanges(
      databaseId: dotenv.get('CF_D1_DATABASE_ID'),
      since: lastSyncTime,
    );
    await _applyRemoteChanges(remoteChanges);
  }
  
  // 获取本地计数增量
  Future<int> _getLocalCountDelta(String id, DateTime since) async {
    // 使用新的元数据方法获取原子更新记录
    final List<SyncRecordModel> atomicUpdates = await _getAtomicUpdateRecords(since);
    
    // 计算增量总和
    int delta = 0;
    for (final record in atomicUpdates) {
      if (record.metadata != null) {
        try {
          final Map<String, dynamic> metadata = jsonDecode(record.metadata!);
          
          // 处理单个实体的原子更新
          if (metadata.containsKey('entityId') && metadata['entityId'] == id) {
            final int changeValue = metadata['changeValue'] is String
                ? int.tryParse(metadata['changeValue'] ?? '0') ?? 0
                : (metadata['changeValue'] ?? 0);
            
            delta += changeValue;
          } 
          // 处理批量原子更新
          else if (metadata.containsKey('updates') && metadata['updates'] is Map) {
            final Map<String, dynamic> updates = metadata['updates'] as Map<String, dynamic>;
            
            if (updates.containsKey(id) && updates[id] is Map<String, dynamic>) {
              final Map<String, dynamic> updateInfo = updates[id] as Map<String, dynamic>;
              final int changeValue = updateInfo['changeValue'] is String
                  ? int.tryParse(updateInfo['changeValue'] ?? '0') ?? 0
                  : (updateInfo['changeValue'] ?? 0);
              
              delta += changeValue;
            }
          }
        } catch (e) {
          // 解析元数据失败，跳过此记录
          continue;
        }
      }
    }
    
    return delta;
  }
  
  // 应用远程更改到本地数据库（支持版本控制和原子操作）
  Future<void> _applyRemoteChanges(List<Map<String, dynamic>> remoteChanges) async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> successfulChanges = [];
    final List<Map<String, dynamic>> failedChanges = [];
    
    await db.transaction((txn) async {
      for (final change in remoteChanges) {
        try {
          final String id = change['id'];
          final String operation = change['operation'];
          final int? remoteVersion = change['version'] is String
              ? int.tryParse(change['version'] ?? '0')
              : (change['version'] as int?);
          
          switch (operation) {
            case 'insert':
              await txn.insert(_tableName, change['data'], conflictAlgorithm: ConflictAlgorithm.replace);
              successfulChanges.add({
                'id': id,
                'operation': operation,
                'status': 'success'
              });
              break;
              
            case 'update':
              // 如果提供了版本号，使用乐观锁更新
              if (remoteVersion != null) {
                final List<Map<String, dynamic>> current = await txn.query(
                  _tableName,
                  columns: ['version'],
                  where: 'id = ?',
                  whereArgs: [id],
                );
                
                if (current.isEmpty) {
                  failedChanges.add({
                    'id': id,
                    'operation': operation,
                    'status': 'failed',
                    'reason': 'record_not_found'
                  });
                  continue;
                }
                
                final int localVersion = current.first['version'] is String
                    ? int.tryParse(current.first['version'] ?? '0') ?? 0
                    : (current.first['version'] ?? 0);
                
                // 只有当远程版本大于本地版本时才更新
                if (remoteVersion > localVersion) {
                  final Map<String, dynamic> updateData = Map<String, dynamic>.from(change['data']);
                  updateData['version'] = remoteVersion;
                  
                  final updated = await txn.update(
                    _tableName,
                    updateData,
                    where: 'id = ? AND version <= ?',
                    whereArgs: [id, remoteVersion],
                  );
                  
                  if (updated > 0) {
                    successfulChanges.add({
                      'id': id,
                      'operation': operation,
                      'status': 'success',
                      'oldVersion': localVersion,
                      'newVersion': remoteVersion
                    });
                  } else {
                    failedChanges.add({
                      'id': id,
                      'operation': operation,
                      'status': 'failed',
                      'reason': 'version_conflict',
                      'localVersion': localVersion,
                      'remoteVersion': remoteVersion
                    });
                  }
                } else {
                  // 本地版本已经是最新的或更新的
                  failedChanges.add({
                    'id': id,
                    'operation': operation,
                    'status': 'skipped',
                    'reason': 'local_version_newer',
                    'localVersion': localVersion,
                    'remoteVersion': remoteVersion
                  });
                }
              } else {
                // 没有版本号，直接更新
                await txn.update(_tableName, change['data'], where: 'id = ?', whereArgs: [id]);
                successfulChanges.add({
                  'id': id,
                  'operation': operation,
                  'status': 'success'
                });
              }
              break;
              
            case 'delete':
              await txn.delete(_tableName, where: 'id = ?', whereArgs: [id]);
              successfulChanges.add({
                'id': id,
                'operation': operation,
                'status': 'success'
              });
              break;
              
            case 'increment':
              // 处理原子增量操作
              final String field = change['field'];
              final int value = change['value'] is String
                  ? int.tryParse(change['value'] ?? '0') ?? 0
                  : (change['value'] ?? 0);
              
              if (field == 'count') {
                // 如果提供了版本号，使用乐观锁更新
                if (remoteVersion != null) {
                  final List<Map<String, dynamic>> current = await txn.query(
                    _tableName,
                    columns: [field, 'version'],
                    where: 'id = ?',
                    whereArgs: [id],
                  );
                  
                  if (current.isEmpty) {
                    failedChanges.add({
                      'id': id,
                      'operation': operation,
                      'field': field,
                      'status': 'failed',
                      'reason': 'record_not_found'
                    });
                    continue;
                  }
                  
                  final int localVersion = current.first['version'] is String
                      ? int.tryParse(current.first['version'] ?? '0') ?? 0
                      : (current.first['version'] ?? 0);
                  
                  // 只有当远程版本大于本地版本时才更新
                  if (remoteVersion > localVersion) {
                    final int currentValue = current.first[field] is String
                        ? int.tryParse(current.first[field] ?? '0') ?? 0
                        : (current.first[field] ?? 0);
                    final int newValue = currentValue + value;
                    
                    final updated = await txn.update(
                      _tableName,
                      {
                        field: newValue,
                        'version': remoteVersion,
                        'updatedAt': DateTime.now().toIso8601String(),
                      },
                      where: 'id = ? AND version <= ?',
                      whereArgs: [id, remoteVersion],
                    );
                    
                    if (updated > 0) {
                      successfulChanges.add({
                        'id': id,
                        'operation': operation,
                        'field': field,
                        'status': 'success',
                        'oldValue': currentValue,
                        'newValue': newValue,
                        'delta': value,
                        'oldVersion': localVersion,
                        'newVersion': remoteVersion
                      });
                    } else {
                      failedChanges.add({
                        'id': id,
                        'operation': operation,
                        'field': field,
                        'status': 'failed',
                        'reason': 'version_conflict',
                        'localVersion': localVersion,
                        'remoteVersion': remoteVersion
                      });
                    }
                  } else {
                    // 本地版本已经是最新的或更新的
                    failedChanges.add({
                      'id': id,
                      'operation': operation,
                      'field': field,
                      'status': 'skipped',
                      'reason': 'local_version_newer',
                      'localVersion': localVersion,
                      'remoteVersion': remoteVersion
                    });
                  }
                } else {
                  // 没有版本号，直接更新
                  final List<Map<String, dynamic>> current = await txn.query(
                    _tableName,
                    columns: [field],
                    where: 'id = ?',
                    whereArgs: [id],
                  );
                  
                  if (current.isNotEmpty) {
                    final int currentValue = current.first[field] is String
                        ? int.tryParse(current.first[field] ?? '0') ?? 0
                        : (current.first[field] ?? 0);
                    final int newValue = currentValue + value;
                    
                    await txn.update(
                      _tableName,
                      {
                        field: newValue,
                        'updatedAt': DateTime.now().toIso8601String(),
                      },
                      where: 'id = ?',
                      whereArgs: [id],
                    );
                    
                    successfulChanges.add({
                      'id': id,
                      'operation': operation,
                      'field': field,
                      'status': 'success',
                      'oldValue': currentValue,
                      'newValue': newValue,
                      'delta': value
                    });
                  } else {
                    failedChanges.add({
                      'id': id,
                      'operation': operation,
                      'field': field,
                      'status': 'failed',
                      'reason': 'record_not_found'
                    });
                  }
                }
              }
              break;
          }
        } catch (e) {
          failedChanges.add({
            'id': change['id'] ?? 'unknown',
            'operation': change['operation'] ?? 'unknown',
            'status': 'failed',
            'reason': 'exception',
            'error': e.toString()
          });
        }
      }
    });
    
    // 记录同步结果
    if (successfulChanges.isNotEmpty || failedChanges.isNotEmpty) {
      final metadata = jsonEncode({
        'successfulChanges': successfulChanges,
        'failedChanges': failedChanges,
        'totalSuccess': successfulChanges.length,
        'totalFailed': failedChanges.length,
        'syncTime': DateTime.now().toIso8601String(),
      });
      
      final String status = failedChanges.isEmpty ? 'completed' : 'partial';
      final String? error = failedChanges.isEmpty ? null : '${failedChanges.length} changes failed';
      
      await _updateSyncRecordWithMetadata('remote_changes_applied', metadata, error: error);
    }
  }

  // 更新同步记录
  Future<void> _updateSyncRecord(String syncType) async {
    final db = await _databaseManager.database;
    final String id = const Uuid().v4();
    final DateTime now = DateTime.now();

    await db.insert(
      _syncTableName,
      {
        'id': id,
        'lastSyncTime': now.toIso8601String(),
        'syncType': syncType,
        'status': 'completed',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  // 更新带元数据的同步记录
  Future<void> _updateSyncRecordWithMetadata(String syncType, String metadata, {String? error}) async {
    final db = await _databaseManager.database;
    final String id = const Uuid().v4();
    final DateTime now = DateTime.now();
    final String status = error == null ? 'completed' : 'failed';

    await db.insert(
      _syncTableName,
      {
        'id': id,
        'lastSyncTime': now.toIso8601String(),
        'syncType': syncType,
        'status': status,
        'error': error,
        'metadata': metadata,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  @override
  Future<SyncRecordModel?> getLastSyncRecord() async {
    final db = await _databaseManager.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _syncTableName,
      orderBy: 'lastSyncTime DESC',
      limit: 1,
    );

    return maps.isNotEmpty ? SyncRecordModel.fromMap(maps.first) : null;
  }

  @override
  Future<List<SyncRecordModel>> getSyncRecords(
      {int limit = 100, DateTime? startTime}) async {
    final db = await _databaseManager.database;
    final whereArgs = startTime != null ? [startTime.toIso8601String()] : [];

    final List<Map<String, dynamic>> maps = await db.query(
      _syncTableName,
      where: startTime != null ? 'lastSyncTime > ?' : null,
      whereArgs: whereArgs,
      orderBy: 'lastSyncTime DESC',
      limit: limit,
    );

    return maps.map((map) => SyncRecordModel.fromMap(map)).toList();
  }

  // 插入同步记录
  @override
  Future<String> insertSyncRecord(SyncRecordModel record) async {
    final db = await _databaseManager.database;
    await db.insert(
      _syncTableName,
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return record.id; // 返回插入记录的ID
  }

  @override
  Future<bool> needSync(int syncIntervalHours) async {
    final lastSync = await getLastSyncRecord();
    if (lastSync == null) return true;

    final timeSinceLastSync = DateTime.now().difference(lastSync.syncTime);
    return timeSinceLastSync > Duration(hours: syncIntervalHours);
  }
  
  // 原子更新远程号码的计数
  @override
  Future<bool> atomicUpdateCount(String phoneNumber, int increment) async {
    try {
      // 1. 查找远程号码
      final remoteNumber = await getByPhoneNumber(phoneNumber);
      if (remoteNumber == null) {
        return false;
      }
      
      // 2. 执行原子更新
      final result = await atomicIncrementCount(remoteNumber.id, increment);
      
      return result > 0;
    } catch (e) {
      return false;
    }
  }
  
  // 批量原子更新计数（带乐观锁机制）
  @override
  Future<Map<String, bool>> batchAtomicUpdateCount(Map<String, int> updates) async {
    final Map<String, bool> results = {};
    final db = await _databaseManager.database;
    final Map<String, dynamic> metadataEntries = {};
    
    await db.transaction((txn) async {
      for (final entry in updates.entries) {
        final phoneNumber = entry.key;
        final increment = entry.value;
        
        // 查找远程号码，包括版本号
        final List<Map<String, dynamic>> maps = await txn.query(
          _tableName,
          columns: ['id', 'phoneNumber', 'count', 'version'],
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
        
        if (maps.isEmpty) {
          results[phoneNumber] = false;
          continue;
        }
        
        final remoteNumber = RemoteNumberModel.fromMap(maps.first);
        final String id = remoteNumber.id;
        final currentCount = remoteNumber.count;
        final newCount = currentCount + increment;
        
        // 获取当前版本号
        final currentVersion = maps.first['version'] is String
            ? int.tryParse(maps.first['version'] ?? '0') ?? 0
            : (maps.first['version'] ?? 0);
        final newVersion = currentVersion + 1;
        
        // 使用乐观锁更新计数
        final updated = await txn.update(
          _tableName,
          {
            'count': newCount,
            'version': newVersion,
            'updatedAt': DateTime.now().toIso8601String(),
          },
          where: 'id = ? AND version = ?',
          whereArgs: [id, currentVersion],
        );
        
        results[phoneNumber] = updated > 0;
        
        // 收集元数据信息
        if (updated > 0) {
          metadataEntries[id] = {
            'entityId': id,
            'phoneNumber': phoneNumber,
            'field': 'count',
            'oldValue': currentCount,
            'newValue': newCount,
            'changeValue': increment,
            'operation': 'increment',
            'version': newVersion,
          };
        }
      }
      
      // 记录同步状态，包含元数据
      final metadata = jsonEncode({
        'updates': metadataEntries,
        'totalUpdates': metadataEntries.length,
        'timestamp': DateTime.now().toIso8601String(),
      });
      
      await _updateSyncRecordWithMetadata('batch_atomic_update', metadata);
    });
    
    return results;
  }
}
