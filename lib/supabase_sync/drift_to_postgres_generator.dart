import 'package:drift/drift.dart';
import '../../data/database/local/local_database.dart';

class DriftToPostgresGenerator {
  final LocalDatabase db;

  DriftToPostgresGenerator(this.db);

  /// 生成所有表的初始化 SQL
  List<String> generateSchema() {
    final List<String> sqlList = [];

    // 遍历 Drift 中注册的所有表
    for (final tableInfo in db.allTables) {
      // 跳过不需要同步的表 (如果需要的话)
      // if (tableInfo.actualTableName == 'some_local_only_table') continue;
      
      sqlList.add(_generateCreateTableSql(tableInfo));
    }

    return sqlList;
  }

  String _generateCreateTableSql(TableInfo tableInfo) {
    final tableName = tableInfo.actualTableName; 
    final buffer = StringBuffer();

    buffer.writeln('CREATE TABLE IF NOT EXISTS $tableName (');

    final columns = tableInfo.columnsByName;
    final primaryKeys = tableInfo.primaryKey;
    
    // 1. 遍历 Drift 定义的字段
    columns.forEach((columnName, column) {
      // 防止 Drift 定义了和系统字段重名的字段 (虽然概率很低)
      if (columnName == 'updated_at' || columnName == 'modified_by_device') {
        return; 
      }

      final pgType = _mapDriftTypeToPostgres(column);
      
      // 主键处理
      final isPk = primaryKeys.contains(column);
      // 如果是单列主键，直接加 PRIMARY KEY
      final pkSuffix = (isPk && primaryKeys.length == 1) ? ' PRIMARY KEY' : '';
      
      buffer.write('  $columnName $pgType$pkSuffix');
      buffer.write(',');
      buffer.writeln();
    });

    // 2. 处理复合主键
    if (primaryKeys.length > 1) {
       final pkNames = primaryKeys.map((c) => c.name).join(', ');
       buffer.writeln('  PRIMARY KEY ($pkNames),');
    }

    // 3. ✅ 添加系统同步字段
    // 【修复】：移除了 last_updated 的手动添加，防止与 Drift 原有字段冲突。
    // Supabase 端使用 updated_at 进行增量判断，不需要依赖 last_updated。
    
    buffer.writeln('  updated_at timestamptz DEFAULT now(),'); // Postgres 自动维护的修改时间
    buffer.writeln('  modified_by_device text'); // 防回环字段

    buffer.writeln(');');
    
    return buffer.toString();
  }

  String _mapDriftTypeToPostgres(GeneratedColumn column) {
    if (column is GeneratedColumn<int>) {
      return 'integer';
    } else if (column is GeneratedColumn<double>) {
      return 'double precision';
    } else if (column is GeneratedColumn<bool>) {
      return 'integer'; 
    } else if (column is GeneratedColumn<DateTime>) {
      return 'timestamptz';
    } else if (column is GeneratedColumn<Uint8List>) {
      return 'bytea';
    } else {
      return 'text';
    }
  }
}