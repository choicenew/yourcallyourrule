// 远程数据库管理器实现，确保与本地数据库隔离

import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

import '../database_manager.dart';
import '../../../main.dart' show isOverlayMode;

// 远程数据库管理器实现类
class RemoteDatabaseManagerImpl implements RemoteDatabaseManager {
  static final RemoteDatabaseManagerImpl _instance = RemoteDatabaseManagerImpl._internal();
  static Database? _database;
  
  // 数据库版本
  static const int _version = 2;
  
  // 数据库名称
  static const String _databaseName = 'remote_database.db';
  
  // 私有构造函数
  RemoteDatabaseManagerImpl._internal();
  
  // 工厂构造函数
  factory RemoteDatabaseManagerImpl() {
    return _instance;
  }
  
  // 获取数据库实例
  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  // 初始化数据库
  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    int retryCount = 0;
    const maxRetries = 5;
    
    while (retryCount < maxRetries) {
      try {
        // 根据是否处于覆盖层模式决定是否以只读模式打开数据库
        return await openDatabase(
          path,
          version: _version,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          readOnly: isOverlayMode, // 在覆盖层模式下以只读方式打开
        );
      } catch (e) {
        if (e.toString().contains('database is locked') && retryCount < maxRetries - 1) {
          retryCount++;
          await Future.delayed(Duration(milliseconds: 200 * retryCount));
        } else {
          rethrow;
        }
      }
    }
    
    throw Exception('无法打开数据库，重试次数已达上限');
  }
  
  // 创建数据库表 (for new installations)
  Future<void> _onCreate(Database db, int version) async {
    // 创建远程号码表 (phoneNumber as PK)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_numbers (
        id TEXT NOT NULL UNIQUE,
        phoneNumber TEXT PRIMARY KEY,
        name TEXT,
        label TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        count INTEGER NOT NULL DEFAULT 0,
        labels_json TEXT
      )
    ''');
    
    // 创建号码与国家的关联表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS number_countries (
        phoneNumber TEXT NOT NULL,
        countryIsoCode TEXT NOT NULL,
        PRIMARY KEY (phoneNumber, countryIsoCode),
        FOREIGN KEY (phoneNumber) REFERENCES remote_numbers(phoneNumber) ON DELETE CASCADE
      )
    ''');
    
    // 为 countryIsoCode 创建索引
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_number_countries_country_iso_code ON number_countries(countryIsoCode)
    ''');
    
    // 待处理操作表新增：待处理操作表，用于记录本地的所有写操作，等待同步
    await db.execute('''
      CREATE TABLE IF NOT EXISTS pending_operations (
        id TEXT PRIMARY KEY,
        entityId TEXT NOT NULL, -- This is now phoneNumber
        operation TEXT NOT NULL,
        payload TEXT,
        timestamp TEXT NOT NULL
      )
    ''');

    // 创建同步记录表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sync_records (
        id TEXT PRIMARY KEY,
        syncTime TEXT NOT NULL,
        syncType TEXT NOT NULL,
        status TEXT NOT NULL,
        pushedRecordCount INTEGER,
        pulledRecordCount INTEGER,
        errorMessage TEXT,
        metadata TEXT
      )
    ''');
    
    // 创建同步配置表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sync_config (
        id TEXT PRIMARY KEY,
        lastSyncTime TEXT,
        syncInterval INTEGER NOT NULL DEFAULT 24,
        isAutoSync INTEGER NOT NULL DEFAULT 1
      )
    ''');
    
    // 创建活跃删除提议表 - 众包删除审核系统
    await db.execute('''
      CREATE TABLE IF NOT EXISTS active_deletion_proposals (
        phoneNumber TEXT PRIMARY KEY,
        proposal_start_time TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'pending',
        highest_risk_level TEXT NOT NULL,
        proposal_count INTEGER NOT NULL DEFAULT 0,
        verified_owner_count INTEGER NOT NULL DEFAULT 0,
        last_updated TEXT NOT NULL,
        verificationReportJson TEXT,
        FOREIGN KEY (phoneNumber) REFERENCES remote_numbers(phoneNumber) ON DELETE CASCADE
      )
    ''');
    
    // 为活跃删除提议表创建索引
    await db.execute('CREATE INDEX IF NOT EXISTS idx_active_deletion_proposals_status ON active_deletion_proposals(status)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_active_deletion_proposals_start_time ON active_deletion_proposals(proposal_start_time)');
    
    // 插入默认同步配置
    await db.insert(
      'sync_config',
      {
        'id': '1',
        'lastSyncTime': null,
        'syncInterval': 24,
        'isAutoSync': 1,
      },
    );
  }
  
  // 升级数据库
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // --- Schema Migration from v1 to v2 ---
      final pendingOperationsExist = (await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ['pending_operations'],
      )).isNotEmpty;

      final batch = db.batch();

      if (pendingOperationsExist) {
        // 1. Create a temporary table for pending_operations to preserve them
        batch.execute('CREATE TABLE pending_operations_temp AS SELECT * FROM pending_operations');
        batch.execute('DROP TABLE pending_operations');
      }

      // 2. Rename old remote_numbers table
      batch.execute('ALTER TABLE remote_numbers RENAME TO remote_numbers_old');

      // 3. Create new remote_numbers table with phoneNumber as PRIMARY KEY
      batch.execute('''
        CREATE TABLE remote_numbers (
          id TEXT NOT NULL UNIQUE,
          phoneNumber TEXT PRIMARY KEY,
          name TEXT,
          label TEXT NOT NULL,
          priority INTEGER NOT NULL DEFAULT 0,
          action TEXT NOT NULL DEFAULT 'none',
          count INTEGER NOT NULL DEFAULT 0,
          labels_json TEXT
        )
      ''');

      // 4. Copy data from old table to new table
      batch.execute('''
        INSERT INTO remote_numbers (id, phoneNumber, name, label, priority, action, count)
        SELECT id, phoneNumber, name, label, priority, action, count FROM remote_numbers_old
      ''');

      // 5. Create the new number_countries junction table
      batch.execute('''
        CREATE TABLE number_countries (
          phoneNumber TEXT NOT NULL,
          countryIsoCode TEXT NOT NULL,
          PRIMARY KEY (phoneNumber, countryIsoCode),
          FOREIGN KEY (phoneNumber) REFERENCES remote_numbers(phoneNumber) ON DELETE CASCADE
        )
      ''');
      batch.execute('CREATE INDEX IF NOT EXISTS idx_number_countries_country_iso_code ON number_countries(countryIsoCode)');

      // 6. Recreate pending_operations table
      batch.execute('''
        CREATE TABLE pending_operations (
          id TEXT PRIMARY KEY,
          entityId TEXT NOT NULL, -- This will now be phoneNumber
          operation TEXT NOT NULL,
          payload TEXT,
          timestamp TEXT NOT NULL
        )
      ''');

      await batch.commit(noResult: true);

      // 7. Migrate pending_operations data
      if (pendingOperationsExist) {
        // This requires mapping old UUID entityId to new phoneNumber entityId
        final oldPendingOps = await db.rawQuery('SELECT * FROM pending_operations_temp');
        final newBatch = db.batch();
        for (final op in oldPendingOps) {
          final oldEntityId = op['entityId'] as String;
          final correspondingNumber = await db.rawQuery('SELECT phoneNumber FROM remote_numbers_old WHERE id = ?', [oldEntityId]);
          if (correspondingNumber.isNotEmpty) {
            final newEntityId = correspondingNumber.first['phoneNumber'] as String;
            newBatch.insert('pending_operations', {
              'id': op['id'],
              'entityId': newEntityId,
              'operation': op['operation'],
              'payload': op['payload'],
              'timestamp': op['timestamp'],
            });
          }
        }
        await newBatch.commit(noResult: true);
        await db.execute('DROP TABLE pending_operations_temp');
      }


      // 8. Drop temporary and old tables
      await db.execute('DROP TABLE remote_numbers_old');
      await db.execute('DROP INDEX IF EXISTS idx_remote_numbers_phone_number');
    }
  }
  
  // 关闭数据库
  @override
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
  
  // 获取最后同步时间
  Future<DateTime?> getLastSyncTime() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sync_config');
    
    if (maps.isNotEmpty && maps.first['lastSyncTime'] != null) {
      return DateTime.parse(maps.first['lastSyncTime']);
    }
    return null;
  }
  
  // 更新最后同步时间
  Future<void> updateLastSyncTime(DateTime syncTime) async {
    final db = await database;
    await db.update(
      'sync_config',
      {'lastSyncTime': syncTime.toIso8601String()},
      where: 'id = ?',
      whereArgs: ['1'],
    );
  }
  
  // 添加同步记录
  Future<String> addSyncRecord(String syncType, String status, {String? error}) async {
    final db = await database;
    final String id = const Uuid().v4();
    
    await db.insert(
      'sync_records',
      {
        'id': id,
        'syncTime': DateTime.now().toIso8601String(),
        'syncType': syncType,
        'status': status,
        'errorMessage': error,
      },
    );
    
    return id;
  }
  
  // 获取同步记录
  Future<List<Map<String, dynamic>>> getSyncRecords({int limit = 10}) async {
    final db = await database;
    return await db.query(
      'sync_records',
      orderBy: 'syncTime DESC',
      limit: limit,
    );
  }
  
  // 清空数据库（仅用于测试）
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('remote_numbers');
    await db.delete('number_countries');
    await db.delete('sync_records');
    await db.update(
      'sync_config',
      {'lastSyncTime': null},
      where: 'id = ?',
      whereArgs: ['1'],
    );
  }
  
  // 导出数据（禁止使用）
  @override
  Future<Map<String, dynamic>> exportData() async {
    throw UnsupportedError('远程数据库不支持导出操作');
  }

  // 查询所有记录
  @override
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  // 根据ID查询记录
  @override
  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    final db = await database;
    // This method assumes the PK is 'id'. For remote_numbers, this is no longer true.
    // It should only be used for tables that still use 'id' as PK.
    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  // 根据条件查询记录
  @override
  Future<List<Map<String, dynamic>>> queryWhere(String table, String field, dynamic value) async {
    final db = await database;
    return await db.query(
      table,
      where: '$field = ?',
      whereArgs: [value],
    );
  }

  // 模糊查询
  @override
  Future<List<Map<String, dynamic>>> queryLike(String table, String field, String pattern) async {
    final db = await database;
    return await db.query(
      table,
      where: '$field LIKE ?',
      whereArgs: ['%$pattern%'],
    );
  }

  // 插入记录
  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // 更新记录
  @override
  Future<int> update(String table, String id, Map<String, dynamic> data) async {
    final db = await database;
    // This method assumes the PK is 'id'. For remote_numbers, this is no longer true.
    return await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 删除记录
  @override
  Future<int> delete(String table, String id) async {
    final db = await database;
    // This method assumes the PK is 'id'. For remote_numbers, this is no longer true.
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 根据电话号码查询记录
  @override
  Future<List<Map<String, dynamic>>> queryByPhoneNumber(String table, String phoneNumber) async {
    final db = await database;
    return await db.query(
      table,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  // --- New methods for remote_numbers table with phoneNumber as PK ---

  Future<int> updateByPhoneNumber(String table, String phoneNumber, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      table,
      data,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  Future<int> deleteByPhoneNumber(String table, String phoneNumber) async {
    final db = await database;
    return await db.delete(
      table,
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  // --- 众包删除审核系统相关方法 ---

  /// 创建或更新删除提议
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
  }) async {
    final db = await database;
    final now = DateTime.now().toIso8601String();
    
    await db.transaction((txn) async {
      final existing = await txn.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
        limit: 1,
      );
      
      if (existing.isEmpty) {
        // 创建新的删除提议
        await txn.insert('active_deletion_proposals', {
          'phoneNumber': phoneNumber,
          'proposal_start_time': now,
          'status': 'pending',
          'highest_risk_level': riskLevel,
          'proposal_count': 1,
          'verified_owner_count': isOwner ? 1 : 0,
          'last_updated': now,
        });
      } else {
        // 更新现有的删除提议
        final current = existing.first;
        final currentRiskLevel = current['highest_risk_level'] as String;
        final currentProposalCount = current['proposal_count'] as int;
        final currentOwnerCount = current['verified_owner_count'] as int;
        
        // 确定最高风险等级
        String newRiskLevel = currentRiskLevel;
        if (riskLevel == 'Verified' || currentRiskLevel == 'Verified') {
          newRiskLevel = 'Verified';
        } else if (riskLevel == 'Low' && currentRiskLevel != 'Verified') {
          newRiskLevel = 'Low';
        }
        
        await txn.update(
          'active_deletion_proposals',
          {
            'proposal_count': currentProposalCount + 1,
            'verified_owner_count': currentOwnerCount + (isOwner ? 1 : 0),
            'highest_risk_level': newRiskLevel,
            'last_updated': now,
          },
          where: 'phoneNumber = ?',
          whereArgs: [phoneNumber],
        );
      }
    });
  }

  /// 获取所有待处理的删除提议（内部方法）
  Future<List<Map<String, dynamic>>> _getActiveDeletionProposals() async {
    final db = await database;
    return await db.query(
      'active_deletion_proposals',
      where: 'status = ?',
      whereArgs: ['pending'],
      orderBy: 'proposal_start_time ASC',
    );
  }

  /// 获取过期的删除提议
  Future<List<Map<String, dynamic>>> getExpiredDeletionProposals(Duration timeout) async {
    final db = await database;
    final cutoffTime = DateTime.now().subtract(timeout).toIso8601String();
    
    return await db.query(
      'active_deletion_proposals',
      where: 'status = ? AND proposal_start_time < ?',
      whereArgs: ['pending', cutoffTime],
      orderBy: 'proposal_start_time ASC',
    );
  }

  /// 更新删除提议状态
  Future<void> updateDeletionProposalStatus(String phoneNumber, String status) async {
    final db = await database;
    await db.update(
      'active_deletion_proposals',
      {
        'status': status,
        'last_updated': DateTime.now().toIso8601String(),
      },
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  /// 删除删除提议记录
  Future<void> deleteDeletionProposal(String phoneNumber) async {
    final db = await database;
    await db.delete(
      'active_deletion_proposals',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  /// 检查号码是否有活跃的删除提议
  @override
  Future<bool> hasActiveDeletionProposal(String phoneNumber) async {
    try {
      final db = await database;
      final result = await db.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ? AND status = ?',
        whereArgs: [phoneNumber, 'pending'],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      print('RemoteDatabaseManager: Error checking active deletion proposal: $e');
      return false;
    }
  }
  
  /// 获取提议信息，包括验证报告
  // 此方法已移至下方，与原getDeletionProposal方法合并
  
  /// 获取所有待处理的删除提议
  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionProposals() async {
    try {
      // 首先尝试从 deletion_proposals 表获取数据
      final db = await database;
      final result = await db.query(
        'deletion_proposals',
        where: 'status = ?',
        whereArgs: ['pending'],
        orderBy: 'created_at DESC',
      );
      
      if (result.isNotEmpty) {
        return result.map((row) {
          // 确保返回的数据格式一致
          return {
            'phoneNumber': row['phone_number'],
            'reason': row['reason'],
            'risk_level': row['risk_level'],
            'created_at': row['created_at'],
            'support_count': row['support_count'] ?? 0,
            'oppose_count': row['oppose_count'] ?? 0,
            'status': row['status'],
            'proposalId': row['phone_number'], // 使用电话号码作为提议ID
            'verification_report': row['verification_report'],
          };
        }).toList();
      } else {
        // 如果 deletion_proposals 表没有数据，则尝试从 active_deletion_proposals 表获取
        final activeProposals = await _getActiveDeletionProposals();
        return activeProposals.map((row) {
          // 处理验证报告数据
          dynamic verificationReport;
          if (row.containsKey('verificationReportJson') && row['verificationReportJson'] != null) {
            try {
              verificationReport = jsonDecode(row['verificationReportJson']);
            } catch (e) {
              print('RemoteDatabaseManager: Error decoding verification report in getPendingDeletionProposals: $e');
              verificationReport = null;
            }
          }
          
          return {
            'phoneNumber': row['phoneNumber'],
            'reason': 'Unknown',
            'risk_level': row['highest_risk_level'] == 'Verified' ? 5 : 3,
            'created_at': row['proposal_start_time'],
            'support_count': row['proposal_count'] ?? 0,
            'oppose_count': 0,
            'status': row['status'],
            'proposalId': row['phoneNumber'],
            'verification_report': verificationReport,
          };
        }).toList();
      }
    } catch (e) {
      print('RemoteDatabaseManager: Error getting pending deletion proposals: $e');
      return [];
    }
  }

  /// 获取提议信息，包括验证报告（原getDeletionProposal方法）
  @override
  Future<Map<String, dynamic>?> getProposalInfo(String phoneNumber) async {
    try {
      final db = await database;
      final result = await db.query(
        'active_deletion_proposals',
        where: 'phoneNumber = ?',
        whereArgs: [phoneNumber],
        limit: 1,
      );
      
      if (result.isNotEmpty) {
        final Map<String, dynamic> info = Map.from(result.first);
        
        // 处理验证报告JSON
        if (info.containsKey('verificationReportJson') && info['verificationReportJson'] != null) {
          try {
            info['verificationReport'] = jsonDecode(info['verificationReportJson']);
          } catch (e) {
            print('RemoteDatabaseManager: Error decoding verification report: $e');
            info['verificationReport'] = null;
          }
        }
        
        return info;
      }
      return null;
    } catch (e) {
      print('RemoteDatabaseManager: Error getting proposal info: $e');
      return null;
    }
  }

  /// 清理已完成的删除提议（状态为approved或rejected）
  @override
  Future<int> cleanupCompletedDeletionProposals({Duration? olderThan}) async {
    final db = await database;
    
    if (olderThan != null) {
      final cutoffTime = DateTime.now().subtract(olderThan).toIso8601String();
      return await db.delete(
        'active_deletion_proposals',
        where: 'status IN (?, ?) AND last_updated < ?',
        whereArgs: ['approved', 'rejected', cutoffTime],
      );
    } else {
      return await db.delete(
        'active_deletion_proposals',
        where: 'status IN (?, ?)',
        whereArgs: ['approved', 'rejected'],
      );
    }
  }
}