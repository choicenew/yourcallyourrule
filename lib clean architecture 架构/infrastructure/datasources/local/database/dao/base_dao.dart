import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

/// 数据访问对象基类
/// 所有DAO都应该继承自这个基类
abstract class BaseDao<T> {
  /// 表名
  String get tableName;
  
  /// 从Map创建实体
  T fromMap(Map<String, dynamic> map);
  
  /// 将实体转换为Map
  Map<String, dynamic> toMap(T item);
  
  /// 获取数据库实例
  Future<Database> get database async => await AppDatabase.database;
  
  /// 获取所有数据
  Future<List<T>> getAll() async {
    final db = await database;
    final maps = await db.query(tableName);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  /// 根据ID获取数据
  Future<T?> getById(String id) async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }
  
  /// 添加数据
  Future<void> insert(T item) async {
    final db = await database;
    await db.insert(
      tableName,
      toMap(item),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  /// 更新数据
  Future<void> update(T item, String id) async {
    final db = await database;
    await db.update(
      tableName,
      toMap(item),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  /// 删除数据
  Future<void> delete(String id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  /// 清空表
  Future<void> clear() async {
    final db = await database;
    await db.delete(tableName);
  }
  
  /// 查询数据
  Future<List<T>> query({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
    
    return maps.map((map) => fromMap(map)).toList();
  }
}