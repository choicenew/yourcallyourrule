import 'package:drift/drift.dart';
import '../../data/database/local/local_database.dart';

/// 变更数据捕获 (CDC) 服务
/// 负责在运行时注入 SQL 触发器，记录数据变更
class SyncLogService {
  final LocalDatabase _db;

  // 影子表名，使用特殊前缀防止冲突
  static const String _logTableName = '__app_sync_log';

  SyncLogService(this._db);

  /// 初始化：创建日志表和触发器
  /// 即使多次调用也是安全的 (IF NOT EXISTS)
  Future<void> initialize() async {
    // 1. 创建日志表
    await _db.customStatement('''
      CREATE TABLE IF NOT EXISTS $_logTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_name TEXT NOT NULL,
        record_id TEXT NOT NULL,
        operation TEXT NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');

    // 2. 遍历所有 Drift 表，注入触发器
    for (final table in _db.allTables) {
      final tableName = table.actualTableName;
      
      // 跳过不需要同步的表 (包括日志表自己)
      if (tableName == _logTableName || 
          tableName == 'android_metadata' || 
          tableName == 'sqlite_sequence') {
        continue;
      }

      // 注入三个触发器 (Insert, Update, Delete)
      await _createTrigger(tableName, 'INSERT', 'NEW.id');
      await _createTrigger(tableName, 'UPDATE', 'NEW.id');
      await _createTrigger(tableName, 'DELETE', 'OLD.id');
    }
  }

  Future<void> _createTrigger(String tableName, String op, String idRef) async {
    // 注意：这里假设主键都是 id。如果 PhoneRules 主键是 phone_number，需特殊处理
    // 这里做一个简单的判断兼容 PhoneRules
    if (tableName == 'phone_rules' || tableName == 'phone_rules_data') {
      if (op == 'DELETE') idRef = 'OLD.phone_number';
      else idRef = 'NEW.phone_number';
    } else if (tableName == 'regex_rules') {
       if (op == 'DELETE') idRef = 'OLD.pattern';
      else idRef = 'NEW.pattern';
    }

    final triggerName = 'trig_${tableName}_${op.toLowerCase()}';
    
    await _db.customStatement('''
      CREATE TRIGGER IF NOT EXISTS $triggerName
      AFTER $op ON $tableName
      BEGIN
        INSERT INTO $_logTableName (table_name, record_id, operation)
        VALUES ('$tableName', $idRef, '$op');
      END;
    ''');
  }

  /// 获取变更日志
  Future<List<SyncLogEntry>> getChanges() async {
    final result = await _db.customSelect(
      'SELECT * FROM $_logTableName ORDER BY id ASC'
    ).get();

    return result.map((row) => SyncLogEntry(
      id: row.read<int>('id'),
      tableName: row.read<String>('table_name'),
      recordId: row.read<String>('record_id'),
      operation: row.read<String>('operation'),
    )).toList();
  }

  /// 清除已处理的日志
  Future<void> clearLogs(List<int> logIds) async {
    if (logIds.isEmpty) return;
    // 简单防 SQL 注入处理，直接拼 ID 列表
    final ids = logIds.join(',');
    await _db.customStatement('DELETE FROM $_logTableName WHERE id IN ($ids)');
  }
  
  /// 获取变更的统计信息（用于调试）
  Future<int> getLogCount() async {
    final result = await _db.customSelect(
      'SELECT COUNT(*) as c FROM $_logTableName'
    ).getSingle();
    return result.read<int>('c');
  }
}

class SyncLogEntry {
  final int id;
  final String tableName;
  final String recordId;
  final String operation;

  SyncLogEntry({
    required this.id,
    required this.tableName,
    required this.recordId,
    required this.operation,
  });
}