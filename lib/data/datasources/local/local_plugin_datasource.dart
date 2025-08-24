import 'package:sqflite/sqflite.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/data/models/plugin_model.dart';

class LocalPluginDataSource {
  final LocalDatabaseManager _dbManager;

  LocalPluginDataSource(this._dbManager);

  Future<Database> get _db async => _dbManager.database;

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await _db;
    return await db.query('plugins');
  }

  Future<Map<String, dynamic>?> queryById(String id) async {
    final db = await _db;
    final maps = await db.query(
      'plugins',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return maps.first;
  }

  Future<String> insert(PluginModel plugin) async {
    final db = await _db;
    await db.insert(
      'plugins',
      plugin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return plugin.id;
  }

  Future<int> update(PluginModel plugin) async {
    final db = await _db;
    return db.update(
      'plugins',
      plugin.toMap(),
      where: 'id = ?',
      whereArgs: [plugin.id],
    );
  }

  Future<int> delete(String id) async {
    final db = await _db;
    return db.delete(
      'plugins',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Map<String, dynamic>?> getByUrl(String url) async {
    final db = await _db;
    final maps = await db.query(
      'plugins',
      where: 'url = ?',
      whereArgs: [url],
    );
    if (maps.isEmpty) return null;
    return maps.first;
  }

  Future<List<Map<String, dynamic>>> searchByName(String name) async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
  }

  Future<List<Map<String, dynamic>>> getAllDisabled() async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'isEnabled = ?',
      whereArgs: [0],
    );
  }

  Future<List<Map<String, dynamic>>> getEnabled() async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'isEnabled = ?',
      whereArgs: [1],
    );
  }

  Future<List<Map<String, dynamic>>> getByType(String type) async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'type = ?',
      whereArgs: [type],
    );
  }

  Future<List<Map<String, dynamic>>> getAllEnabled() async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'isEnabled = ?',
      whereArgs: [1],
    );
  }

  Future<List<Map<String, dynamic>>> getByCategory(String category) async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<List<Map<String, dynamic>>> getByName(String name) async {
    final db = await _db;
    return await db.query(
      'plugins',
      where: 'name = ?',
      whereArgs: [name],
    );
  }
}