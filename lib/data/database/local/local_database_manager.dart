// 本地数据库管理器实现，确保与远程数据库隔离

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../database_manager.dart';
import '../migration/database_migration.dart';

// 本地数据库管理器实现类
class LocalDatabaseManagerImpl implements LocalDatabaseManager {
  static final LocalDatabaseManagerImpl _instance =
      LocalDatabaseManagerImpl._internal();
  static Database? _database;

  // 数据库版本
  // 数据库版本
  static const int _version = 2;

  // 数据库名称
  static const String _databaseName = 'local_database.db';

  // 私有构造函数
  LocalDatabaseManagerImpl._internal();

  // 工厂构造函数
  factory LocalDatabaseManagerImpl() {
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
    return await openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // 创建数据库表
  Future<void> _onCreate(Database db, int version) async {
    // 创建联系人表
    await db.execute('''
      CREATE TABLE contacts (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        name TEXT NOT NULL,
        avatar TEXT,
        note TEXT,
        labelIds TEXT,
        isFavorite INTEGER NOT NULL DEFAULT 0,
        lastUpdated TEXT NOT NULL
      )
    ''');

    // 创建通话记录表
    await db.execute('''
      CREATE TABLE calls (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        callType TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT,
        duration INTEGER NOT NULL DEFAULT 0,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        note TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT,
        name TEXT
      )
    ''');

    // 创建正则规则表
    await db.execute('''
      CREATE TABLE regex_rules (
        id TEXT PRIMARY KEY,
        pattern TEXT NOT NULL,
        action TEXT NOT NULL,
        name TEXT NOT NULL,
        priority INTEGER NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1
      )
    ''');

    // 创建规则表（统一处理黑白名单/allow/block）
    await db.execute('''
      CREATE TABLE rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        ruleType TEXT NOT NULL,
        phoneNumber TEXT,
        labelId TEXT, -- Changed from label to labelId
        priority INTEGER NOT NULL,
        action TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pattern TEXT,
        avatar TEXT,
        isSubscribed INTEGER NOT NULL DEFAULT 0, -- Added isSubscribed
        count INTEGER NOT NULL DEFAULT 0 -- Added count
      )
    ''');

    // 创建订阅表（处理三种订阅类型）
    await db.execute('''
      CREATE TABLE subscriptions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        table_type TEXT NOT NULL,
        enabled INTEGER NOT NULL DEFAULT 1,
        last_updated TEXT NOT NULL,
        is_auto_update INTEGER NOT NULL DEFAULT 0,
        contact_group TEXT,
        keyword_filters TEXT,
        action TEXT NOT NULL DEFAULT 'none'
      )
    ''');

    // 创建短信表 - 更新结构以支持正则规则
    await db.execute('''
      CREATE TABLE sms (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        contactName TEXT,
        messageType TEXT NOT NULL,
        content TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        isRead INTEGER NOT NULL DEFAULT 0,
        simInfo TEXT,
        isMarked INTEGER NOT NULL DEFAULT 0,
        labelIds TEXT
      )
    ''');

    // 创建SMS规则表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sms_rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        contentRegex TEXT NOT NULL,
        senderRegex TEXT,
        action TEXT NOT NULL,
        priority INTEGER NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        ruleType TEXT NOT NULL
      )
    ''');

    // 创建插件表
    await db.execute('''
      CREATE TABLE plugins (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        version TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        pluginOrder INTEGER NOT NULL,
        isAutoUpdate INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 创建位置表
    await db.execute('''
      CREATE TABLE locations (
        id TEXT PRIMARY KEY,
        phoneNumber TEXT NOT NULL,
        region TEXT,
        countryName TEXT,
        carrier TEXT,
        numberType INTEGER NOT NULL
      )
    ''');

    // 创建预定义标签表
    await db.execute('''
      CREATE TABLE predefined_labels (
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        avatar TEXT,
        icon TEXT
      )
    ''');

    // 创建标签表
    await db.execute('''
      CREATE TABLE labels (
        id TEXT PRIMARY KEY,
        name TEXT,
        icon TEXT,
        phoneNumber TEXT NOT NULL,
        label TEXT NOT NULL,
        labelId TEXT NOT NULL,
        avatar TEXT,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        isEnabled INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (labelId) REFERENCES predefined_labels (id)
      )
    ''');

    // 创建规则表
    await db.execute('''
      CREATE TABLE rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        conditions TEXT NOT NULL,
        actions TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        priority INTEGER NOT NULL DEFAULT 0,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
    
    // 创建SIM卡槽位规则表
    await db.execute('''
      CREATE TABLE sim_slot_rules (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        priority INTEGER NOT NULL,
        action TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        phoneNumber TEXT NOT NULL,
        simSlotIndex INTEGER NOT NULL,
        label TEXT,
        avatar TEXT,
        ruleType TEXT NOT NULL DEFAULT 'sim_slot'
      )
    ''');
  }

  // 升级数据库
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 根据版本号进行升级操作
    if (oldVersion < 2) {
      // 版本1升级到版本2的操作

      // 检查SMS表结构并迁移
      try {
        // 获取SMS表的列信息
        final tableInfo = await db.rawQuery("PRAGMA table_info(sms)");
        final columnNames =
            tableInfo.map((col) => col['name'] as String).toList();

        // 如果表中有phoneNumber列但没有sender列，需要重命名
        if (columnNames.contains('phoneNumber') &&
            !columnNames.contains('sender')) {
          // 创建临时表
          await db.execute('''
            CREATE TABLE sms_temp (
              id TEXT PRIMARY KEY,
              phoneNumber TEXT NOT NULL,
              contactName TEXT,
              messageType TEXT NOT NULL,
              content TEXT NOT NULL,
              timestamp TEXT NOT NULL,
              isRead INTEGER NOT NULL DEFAULT 0,
              simInfo TEXT,
              isMarked INTEGER NOT NULL DEFAULT 0,
              labelIds TEXT,
              ruleId TEXT,
              actionApplied TEXT,
              contentRegex TEXT,
              senderRegex TEXT
            )
          ''');

          // 复制数据，保持phoneNumber字段名称
          await db.execute('''
            INSERT INTO sms_temp(id, phoneNumber, contactName, messageType, content, timestamp, isRead, simInfo, isMarked, labelIds)
            SELECT id, phoneNumber, contactName, messageType, content, timestamp, isRead, simInfo, isMarked, labelIds FROM sms
          ''');

          // 删除旧表并重命名新表
          await db.execute('DROP TABLE sms');
          await db.execute('ALTER TABLE sms_temp RENAME TO sms');
        }

        // 如果没有rules表，创建它
        final tables = await db.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='rules'");
        if (tables.isEmpty) {
          await db.execute('''
            CREATE TABLE rules (
              id TEXT PRIMARY KEY,
              name TEXT NOT NULL,
              contentRegex TEXT NOT NULL,
              senderRegex TEXT,
              action TEXT NOT NULL,
              priority INTEGER NOT NULL DEFAULT 5,
              isEnabled INTEGER NOT NULL DEFAULT 1,
              ruleType TEXT NOT NULL,
              createdAt TEXT,
              updatedAt TEXT
            )
          ''');
        }

        // 调用数据库迁移类进行数据迁移
        await DatabaseMigration.migrateLocalDatabase(
            db, oldVersion, newVersion);
      } catch (e) {
        print('SMS表迁移错误: $e');
      }
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

  // 清空数据库（仅用于测试）
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('contacts');
    await db.delete('calls');
    await db.delete('labels');
    await db.delete('rules');
    await db.delete('regex_rules');
    await db.delete('subscriptions');
    await db.delete('sms');
    await db.delete('plugins');
    await db.delete('locations');
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
    final results = await db.query(table, where: 'id = ?', whereArgs: [id], limit: 1);
    return results.isNotEmpty ? results.first : null;
  }
  
  // 根据条件查询记录
  @override
  Future<List<Map<String, dynamic>>> queryWhere(String table, String field, dynamic value) async {
    final db = await database;
    return await db.query(table, where: '$field = ?', whereArgs: [value]);
  }
  
  // 模糊查询
  @override
  Future<List<Map<String, dynamic>>> queryLike(String table, String field, String pattern) async {
    final db = await database;
    return await db.query(table, where: '$field LIKE ?', whereArgs: ['%$pattern%']);
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
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }
  
  // 删除记录
  @override
  Future<int> delete(String table, String id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
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
}
