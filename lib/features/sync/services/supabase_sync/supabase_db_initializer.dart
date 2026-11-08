import 'package:postgres/postgres.dart';
// 引入你的数据库和生成器
import '../../data/database/local/local_database.dart';
import 'drift_to_postgres_generator.dart'; 

class SupabaseDbInitializer {
  
  Future<void> initializeSchema(String connectionUri) async {
    final uri = Uri.parse(connectionUri);
    final connection = await Connection.open(
      Endpoint(
        host: uri.host,
        database: uri.pathSegments.first,
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
        port: uri.port,
      ),
      settings: ConnectionSettings(sslMode: SslMode.require),
    );

    try {
      await connection.runTx((session) async {
        // 1. 创建 Trigger 函数
        await session.execute('''
          CREATE OR REPLACE FUNCTION update_updated_at_column()
          RETURNS TRIGGER AS \$\$
          BEGIN
             NEW.updated_at = now();
             RETURN NEW;
          END;
          \$\$ language 'plpgsql';
        ''');

        // 2. ✅ 动态生成建表语句
        // 获取单例数据库实例
        final db = LocalDatabase(); 
        final generator = DriftToPostgresGenerator(db);
        final sqlStatements = generator.generateSchema();

        // 3. 执行所有建表语句
        for (final sql in sqlStatements) {
          // 这里比较粗暴，因为 generator 生成的是 CREATE TABLE
          // 如果我们需要从 SQL 中提取表名来创建 Trigger，需要一点正则技巧
          await session.execute(sql);
          
          // 提取表名用于创建 Trigger
          // 假设生成的 SQL 是 "CREATE TABLE IF NOT EXISTS tableName ("
          final match = RegExp(r'CREATE TABLE IF NOT EXISTS\s+(\w+)\s*\(').firstMatch(sql);
          if (match != null) {
            final tableName = match.group(1)!;
            await _createTrigger(session, tableName);
          }
        }
      });
    } finally {
      await connection.close();
    }
  }

  Future<void> _createTrigger(TxSession session, String tableName) async {
    await session.execute('DROP TRIGGER IF EXISTS update_${tableName}_modtime ON $tableName;');
    await session.execute('''
      CREATE TRIGGER update_${tableName}_modtime
      BEFORE UPDATE ON $tableName
      FOR EACH ROW
      EXECUTE PROCEDURE update_updated_at_column();
    ''');
  }
}