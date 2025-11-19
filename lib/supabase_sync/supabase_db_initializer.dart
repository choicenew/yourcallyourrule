import 'package:postgres/postgres.dart';

class SupabaseDbInitializer {
  /// 初始化数据库结构，支持多端同步字段
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
        // 1. 自动更新时间戳函数
        await session.execute('''
          CREATE OR REPLACE FUNCTION update_updated_at_column()
          RETURNS TRIGGER AS \$\$
          BEGIN
             NEW.updated_at = now();
             RETURN NEW;
          END;
          \$\$ language 'plpgsql';
        ''');

        // 2. 建表逻辑：增加 modified_by_device 字段
        // Contacts
        await _createTable(session, 'contacts', '''
          CREATE TABLE IF NOT EXISTS contacts (
            id text PRIMARY KEY,
            phone_number text NOT NULL,
            name text NOT NULL,
            avatar text,
            url text,
            note text,
            label_ids text,
            is_favorite integer DEFAULT 0,
            last_updated text, 
            updated_at timestamptz DEFAULT now(),
            modified_by_device text 
          );
        ''');

        // Rules
        await _createTable(session, 'rules', '''
          CREATE TABLE IF NOT EXISTS rules (
            id text PRIMARY KEY,
            name text NOT NULL,
            rule_type text NOT NULL,
            phone_number text,
            label_id text,
            priority integer DEFAULT 5,
            action text DEFAULT 'none',
            is_enabled integer DEFAULT 1,
            pattern text,
            avatar text,
            is_subscribed integer DEFAULT 0,
            count integer DEFAULT 0,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // SmsRules
        await _createTable(session, 'sms_rules', '''
          CREATE TABLE IF NOT EXISTS sms_rules (
            id text PRIMARY KEY,
            name text NOT NULL,
            content_regex text NOT NULL,
            sender_regex text,
            action text NOT NULL,
            priority integer DEFAULT 5,
            is_enabled integer DEFAULT 1,
            rule_type text NOT NULL,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // CallHistory
        await _createTable(session, 'call_history', '''
          CREATE TABLE IF NOT EXISTS call_history (
            id text PRIMARY KEY,
            phone_number text NOT NULL,
            name text,
            timestamp text NOT NULL,
            end_time text,
            duration integer,
            sim_display_name text,
            call_type text NOT NULL,
            sim_slot_index integer,
            carrier_name text,
            country_iso text,
            subscription_id integer,
            label_ids text,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');
      });
    } finally {
      await connection.close();
    }
  }

  Future<void> _createTable(TxSession session, String tableName, String sql) async {
    await session.execute(sql);
    await session.execute('DROP TRIGGER IF EXISTS update_${tableName}_modtime ON $tableName;');
    await session.execute('''
      CREATE TRIGGER update_${tableName}_modtime
      BEFORE UPDATE ON $tableName
      FOR EACH ROW
      EXECUTE PROCEDURE update_updated_at_column();
    ''');
  }
}