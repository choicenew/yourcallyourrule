import 'package:sqflite/sqflite.dart';
import '../../../../../domain/entities/label/label_entry.dart';
import '../../../../models/label_model.dart';
import 'base_dao.dart';

/// 标签数据访问对象
/// 提供标签相关的数据库操作
class LabelDao extends BaseDao<LabelEntry> {
  @override
  String get tableName => 'labels';
  
  /// 电话号码-标签关联表名
  final String phoneLabelsTable = 'phone_labels';
  
  @override
  LabelEntry fromMap(Map<String, dynamic> map) {
    return LabelModel.fromMap(map).toEntity();
  }
  
  @override
  Map<String, dynamic> toMap(LabelEntry item) {
    return LabelModel.fromEntity(item).toMap();
  }
  
  /// 根据名称获取标签
  Future<LabelEntry?> getByName(String name) async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    
    if (maps.isEmpty) {
      return null;
    }
    
    return fromMap(maps.first);
  }
  
  /// 获取所有系统标签
  Future<List<LabelEntry>> getSystemLabels() async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'is_system = ?',
      whereArgs: [1],
      orderBy: 'order ASC',
    );
    
    return maps.map((map) => fromMap(map)).toList();
  }
  
  /// 获取所有用户自定义标签
  Future<List<LabelEntry>> getUserLabels() async {
    final db = await database;
    final maps = await db.query(
      tableName,
      where: 'is_system = ?',
      whereArgs: [0],
      orderBy: 'order ASC',
    );
    
    return maps.map((map) => fromMap(map)).toList();
  }
  
  /// 为电话号码分配标签
  Future<void> assignToPhone(String phoneNumber, String labelId) async {
    final db = await database;
    await db.insert(
      phoneLabelsTable,
      {
        'phone_number': phoneNumber,
        'label_id': labelId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  /// 从电话号码移除标签
  Future<void> removeFromPhone(String phoneNumber, String labelId) async {
    final db = await database;
    await db.delete(
      phoneLabelsTable,
      where: 'phone_number = ? AND label_id = ?',
      whereArgs: [phoneNumber, labelId],
    );
  }
  
  /// 获取电话号码的所有标签
  Future<List<LabelEntry>> getForPhone(String phoneNumber) async {
    final db = await database;
    final query = '''
      SELECT l.* FROM $tableName l
      INNER JOIN $phoneLabelsTable pl ON l.id = pl.label_id
      WHERE pl.phone_number = ?
      ORDER BY l.order ASC
    ''';
    
    final maps = await db.rawQuery(query, [phoneNumber]);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  /// 批量添加标签
  @override
  Future<void> addAll(List<LabelEntry> items) async {
    final db = await database;
    final batch = db.batch();
    
    for (final item in items) {
      batch.insert(
        tableName,
        toMap(item),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit(noResult: true);
  }
}