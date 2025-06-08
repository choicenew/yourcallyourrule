// 远程数据库管理器实现，确保与本地数据库隔离

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../database_manager.dart';
import '../../../main.dart' show isOverlayMode;

// 远程数据库管理器实现类
class RemoteDatabaseManagerImpl implements RemoteDatabaseManager {
  static final RemoteDatabaseManagerImpl _instance = RemoteDatabaseManagerImpl._internal();
  static Database? _database;
  
  // 数据库版本
  static const int _version = 1;
  
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
  
  // 创建数据库表
  Future<void> _onCreate(Database db, int version) async {
    // 创建远程号码表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS remote_numbers (
        id TEXT PRIMARY KEY,
        name TEXT,
        phoneNumber TEXT NOT NULL,
        label TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 0,
        action TEXT NOT NULL DEFAULT 'none',
        count TEXT NOT NULL DEFAULT '0'
      )
    ''');
    
    // 创建同步记录表
    await db.execute('''
      CREATE TABLE IF NOT EXISTS sync_records (
        id TEXT PRIMARY KEY,
        syncTime TEXT NOT NULL,
        syncType TEXT NOT NULL,
        status TEXT NOT NULL,
        error TEXT
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
    // 根据版本号进行升级操作
    if (oldVersion < 2) {
      // 版本1升级到版本2的操作
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
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    
    await db.insert(
      'sync_records',
      {
        'id': id,
        'syncTime': DateTime.now().toIso8601String(),
        'syncType': syncType,
        'status': status,
        'error': error,
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
    return await db.insert(table, data);
  }

  // 更新记录
  @override
  Future<int> update(String table, String id, Map<String, dynamic> data) async {
    final db = await database;
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
}