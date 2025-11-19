import 'package:postgres/postgres.dart';

/// 负责直接连接 Supabase Postgres 数据库并创建表结构
class SupabaseDbInitializer {
  
  /// 初始化数据库结构
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
        // 1. 创建通用函数：自动更新 updated_at 字段
        await session.execute('''
          CREATE OR REPLACE FUNCTION update_updated_at_column()
          RETURNS TRIGGER AS \$\$
          BEGIN
             NEW.updated_at = now();
             RETURN NEW;
          END;
          \$\$ language 'plpgsql';
        ''');

        // ==================== 核心业务表 ====================

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
            last_updated text NOT NULL,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Call History
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

        // Sms
        await _createTable(session, 'sms', '''
          CREATE TABLE IF NOT EXISTS sms (
            id text PRIMARY KEY,
            phone_number text NOT NULL,
            contact_name text,
            message_type text NOT NULL,
            content text NOT NULL,
            timestamp text NOT NULL,
            is_read integer DEFAULT 0,
            sim_info text,
            is_marked integer DEFAULT 0,
            label_ids text,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // ==================== 规则表 ====================

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

        // PhoneRules
        await _createTable(session, 'phone_rules', '''
          CREATE TABLE IF NOT EXISTS phone_rules (
            phone_number text PRIMARY KEY,
            id text,
            name text NOT NULL,
            rule_type text NOT NULL,
            label_id text,
            priority integer DEFAULT 5,
            action text DEFAULT 'none',
            is_enabled integer DEFAULT 1,
            count integer DEFAULT 0,
            avatar text,
            subscription_id text,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // RegexRules
        await _createTable(session, 'regex_rules', '''
          CREATE TABLE IF NOT EXISTS regex_rules (
            pattern text PRIMARY KEY,
            id text,
            name text NOT NULL,
            rule_type text NOT NULL,
            priority integer DEFAULT 5,
            action text DEFAULT 'none',
            is_enabled integer DEFAULT 1,
            subscription_id text,
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

        // SimSlotRules
        await _createTable(session, 'sim_slot_rules', '''
          CREATE TABLE IF NOT EXISTS sim_slot_rules (
            id text PRIMARY KEY,
            name text NOT NULL,
            priority integer,
            action text,
            is_enabled integer DEFAULT 1,
            phone_number text NOT NULL,
            sim_slot_index integer,
            label_id text NOT NULL,
            avatar text,
            rule_type text DEFAULT 'simSlot',
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // ==================== 标签与配置表 ====================

        // Predefined Labels
        await _createTable(session, 'predefined_labels', '''
          CREATE TABLE IF NOT EXISTS predefined_labels (
            id text PRIMARY KEY,
            label_text text NOT NULL,
            avatar text,
            icon text,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Label Phones
        await _createTable(session, 'label_phones', '''
          CREATE TABLE IF NOT EXISTS label_phones (
            id text PRIMARY KEY,
            name text,
            icon text,
            phone_number text NOT NULL,
            label_id text NOT NULL,
            avatar text,
            priority integer DEFAULT 0,
            action text DEFAULT 'none',
            is_enabled integer DEFAULT 1,
            rule_type text DEFAULT 'label',
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Label Mark Statistics
        await _createTable(session, 'label_mark_statistics', '''
          CREATE TABLE IF NOT EXISTS label_mark_statistics (
            id text PRIMARY KEY,
            phone_number text NOT NULL,
            label_id text NOT NULL,
            marked_at text NOT NULL,
            is_counted integer DEFAULT 1,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // User Mark Count
        await _createTable(session, 'user_mark_count', '''
          CREATE TABLE IF NOT EXISTS user_mark_count (
            id text PRIMARY KEY,
            total_count integer DEFAULT 0,
            last_updated text,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Subscriptions
        await _createTable(session, 'subscriptions', '''
          CREATE TABLE IF NOT EXISTS subscriptions (
            id text PRIMARY KEY,
            name text NOT NULL,
            url text NOT NULL,
            table_type text NOT NULL,
            is_enabled integer DEFAULT 1,
            last_updated text NOT NULL,
            auto_update integer DEFAULT 0,
            contact_group text,
            keyword_filters text,
            action text DEFAULT 'none',
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Plugins
        await _createTable(session, 'plugins', '''
          CREATE TABLE IF NOT EXISTS plugins (
            id text PRIMARY KEY,
            name text NOT NULL,
            url text NOT NULL,
            version text NOT NULL,
            description text,
            is_enabled integer DEFAULT 1,
            plugin_order integer NOT NULL,
            is_auto_update integer DEFAULT 0,
            updated_at timestamptz DEFAULT now(),
            modified_by_device text
          );
        ''');

        // Locations
        await _createTable(session, 'locations', '''
          CREATE TABLE IF NOT EXISTS locations (
            id text PRIMARY KEY,
            phone_number text NOT NULL,
            region text,
            country_name text,
            carrier text,
            number_type integer,
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