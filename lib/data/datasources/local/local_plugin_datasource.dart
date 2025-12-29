import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/plugin_model.dart';

import '../../database/local/local_database.dart';
import '../datasource_interface.dart';

class LocalPluginDataSource implements LocalDataSource<PluginModel> {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocalPluginDataSource(this._db);

  PluginModel _fromData(PluginData data) {
    return PluginModel(
      id: data.id,
      name: data.name,
      url: data.url,
      version: data.version,
      description: data.description ?? '',
      isEnabled: data.isEnabled == 1,
      pluginOrder: data.pluginOrder,
      isAutoUpdate: data.isAutoUpdate == 1,
      config: data.configJson != null ? jsonDecode(data.configJson!) : {},
    );
  }

  PluginsCompanion _toCompanion(PluginModel model) {
    return PluginsCompanion(
      id: Value(model.id),
      name: Value(model.name),
      url: Value(model.url),
      version: Value(model.version),
      description: Value(model.description),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      pluginOrder: Value(model.pluginOrder),
      isAutoUpdate: Value(model.isAutoUpdate ? 1 : 0),
      configJson: Value(jsonEncode(model.config)),
    );
  }

  @override
  Future<List<PluginModel>> getAll() async {
    final data =
        await (_db.select(_db.plugins)
          ..orderBy([(t) => OrderingTerm(expression: t.pluginOrder)])).get();
    return data.map(_fromData).toList();
  }

  @override
  Future<PluginModel?> getById(String id) async {
    final data =
        await (_db.select(_db.plugins)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  @override
  Future<String> insert(PluginModel model) async {
    final id = model.id.isEmpty ? _uuid.v4() : model.id;
    final companion = _toCompanion(model).copyWith(id: Value(id));
    await _db.into(_db.plugins).insert(companion, mode: InsertMode.replace);
    return id;
  }

  @override
  Future<List<String>> insertAll(List<PluginModel> models) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final model in models) {
        final id = model.id.isEmpty ? _uuid.v4() : model.id;
        ids.add(id);
        final companion = _toCompanion(model).copyWith(id: Value(id));
        batch.insert(_db.plugins, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  @override
  Future<int> update(PluginModel model) async {
    return await (_db.update(_db.plugins)
      ..where((tbl) => tbl.id.equals(model.id))).write(_toCompanion(model));
  }

  @override
  Future<int> updateAll(List<PluginModel> items) async {
    await _db.batch((batch) {
      for (final item in items) {
        batch.update(
          _db.plugins,
          _toCompanion(item),
          where: (tbl) => tbl.id.equals(item.id),
        );
      }
    });
    return items.length;
  }

  @override
  Future<int> delete(String id) async {
    return await (_db.delete(_db.plugins)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.plugins)
      ..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> clear() async {
    await _db.delete(_db.plugins).go();
  }

  Future<PluginModel?> getByUrl(String url) async {
    final data =
        await (_db.select(_db.plugins)
          ..where((tbl) => tbl.url.equals(url))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<List<PluginModel>> searchByName(String name) async {
    final data =
        await (_db.select(_db.plugins)
          ..where((tbl) => tbl.name.like('%$name%'))).get();
    return data.map(_fromData).toList();
  }

  Future<List<PluginModel>> getEnabled() async {
    final data =
        await (_db.select(_db.plugins)
          ..where((tbl) => tbl.isEnabled.equals(1))).get();
    return data.map(_fromData).toList();
  }

  @override
  Future<String> exportData() async {
    final items = await getAll();
    return jsonEncode(items.map((item) => item.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final items =
          maps
              .map((map) => PluginModel.fromMap(map as Map<String, dynamic>))
              .toList();
      await insertAll(items);
      return true;
    } catch (e) {
      print('Error importing plugin data: $e');
      return false;
    }
  }
}
