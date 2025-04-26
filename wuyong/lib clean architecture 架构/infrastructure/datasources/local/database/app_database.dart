import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dao/call_dao.dart';
import 'dao/contact_dao.dart';
import 'dao/sms_dao.dart';

import 'dao/label_dao.dart';
import 'dao/rule_dao.dart';

/// 应用数据库管理类
/// 负责数据库的初始化、升级和提供数据库实例
class AppDatabase {
  static const String _databaseName = 'your_call_your_rule.db';
  static const int _databaseVersion = 2;
  
  static Database? _database;
  
  // 数据访问对象
  late final LabelDao _labelDao;
  late final RuleDao _ruleDao;
  late final CallDao _callDao;
  late final ContactDao _contactDao;
  late final SmsDao _smsDao;
  
  // 私有构造函数
  AppDatabase._internal();
  
  // 标签DAO访问器
  LabelDao get labelDao => _labelDao;
  
  // 规则DAO访问器
  RuleDao get ruleDao => _ruleDao;
  
  // 通话记录DAO访问器
  CallDao get callDao => _callDao;
  
  // 联系人DAO访问器
  ContactDao get contactDao => _contactDao;
  
  // 短信DAO访问器
  SmsDao get smsDao => _smsDao;
  
  /// 获取数据库实例
  static Future<Database> get database async {
    if (_database != null) return _database!;
    
    _database = await _initDatabase();
    return _database!;
  }
  
  /// 初始化数据库
  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    
    final db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    
    // 初始化DAO
    final instance = AppDatabase._internal();
    instance._labelDao = LabelDao();
    instance._ruleDao = RuleDao();
    
    return db;
  }
  
  /// 创建数据库表
  static Future<void> _onCreate(Database db, int version) async {
    // 规则表
    await db.execute('''
      CREATE TABLE rules(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        type TEXT NOT NULL,
        is_enabled INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER,
        priority INTEGER NOT NULL,
        action TEXT NOT NULL,
        source TEXT NOT NULL,
        pattern TEXT,
        phone_number TEXT,
        extra_data TEXT
      )
    ''');
    
    // 联系人表
    await db.execute('''
      CREATE TABLE contacts(
        id TEXT PRIMARY KEY,
        name TEXT,
        phone_number TEXT NOT NULL,
        label TEXT,
        avatar TEXT,
        source TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      )
    ''');
    
    // 通话记录表
    await db.execute('''
      CREATE TABLE call_logs(
        id TEXT PRIMARY KEY,
        phone_number TEXT NOT NULL,
        name TEXT,
        duration INTEGER NOT NULL,
        timestamp INTEGER NOT NULL,
        call_type TEXT NOT NULL,
        action_taken TEXT,
        rule_id TEXT,
        note TEXT
      )
    ''');
    
    // 短信记录表
    await db.execute('''
      CREATE TABLE sms_messages(
        id TEXT PRIMARY KEY,
        phone_number TEXT NOT NULL,
        name TEXT,
        content TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        sms_type TEXT NOT NULL,
        action_taken TEXT,
        rule_id TEXT,
        is_read INTEGER NOT NULL
      )
    ''');
    
    // 标签表
    await db.execute('''
      CREATE TABLE labels(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        color TEXT NOT NULL,
        icon TEXT NOT NULL,
        is_system INTEGER NOT NULL,
        order INTEGER NOT NULL
      )
    ''');
    
    // 电话号码-标签关联表
    await db.execute('''
      CREATE TABLE phone_labels(
        phone_number TEXT NOT NULL,
        label_id TEXT NOT NULL,
        PRIMARY KEY (phone_number, label_id),
        FOREIGN KEY (label_id) REFERENCES labels(id) ON DELETE CASCADE
      )
    ''');
  }
  
  /// 升级数据库
  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 处理数据库版本升级
    if (oldVersion < 2) {
      // 版本1升级到版本2的迁移脚本
      // 添加标签表
      await db.execute('''
        CREATE TABLE IF NOT EXISTS labels(
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          description TEXT,
          color TEXT NOT NULL,
          icon TEXT NOT NULL,
          is_system INTEGER NOT NULL,
          order INTEGER NOT NULL
        )
      ''');
      
      // 添加电话号码-标签关联表
      await db.execute('''
        CREATE TABLE IF NOT EXISTS phone_labels(
          phone_number TEXT NOT NULL,
          label_id TEXT NOT NULL,
          PRIMARY KEY (phone_number, label_id),
          FOREIGN KEY (label_id) REFERENCES labels(id) ON DELETE CASCADE
        )
      ''');
    }
  }
  
  /// 关闭数据库
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}