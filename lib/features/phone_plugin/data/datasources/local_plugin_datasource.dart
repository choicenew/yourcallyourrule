import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_plugin_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalPluginDataSource localPluginDataSource(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return LocalPluginDataSource(db);
}

class LocalPluginDataSource {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocalPluginDataSource(this._db);

  PluginsCompanion _toCompanion(PluginSourceData plugin) {
    final id = plugin.id.isEmpty ? _uuid.v4() : plugin.id;
    return PluginsCompanion.insert(
      id: id,
      name: plugin.id,
      url: plugin.sourceUrl ?? '',
      version: plugin.version,
      description: Value(plugin.scriptContent),
      isEnabled: Value(plugin.isEnabled ? 1 : 0),
      pluginOrder: Value(plugin.priority),
      isAutoUpdate: Value(plugin.isAutoUpdate ? 1 : 0),
    );
  }

  PluginSourceData _fromData(PluginData data) {
    return PluginSourceData(
      id: data.id,
      version: data.version,
      sourceUrl: data.url,
      scriptContent: data.description ?? '',
      priority: data.pluginOrder,
      isEnabled: data.isEnabled == 1,
      isAutoUpdate: data.isAutoUpdate == 1,
    );
  }

  Future<List<PluginSourceData>> getAll() async {
    final data = await (_db.select(_db.plugins)
          ..orderBy([(t) => OrderingTerm(expression: t.pluginOrder)])).get();
    return data.map(_fromData).toList();
  }

  Future<PluginSourceData?> getById(String id) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<String> insert(PluginSourceData model) async {
    final companion = _toCompanion(model);
    await _db.into(_db.plugins).insert(companion, mode: InsertMode.replace);
    return companion.id.value;
  }

  Future<List<String>> insertAll(List<PluginSourceData> models) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final model in models) {
        final companion = _toCompanion(model);
        ids.add(companion.id.value);
        batch.insert(_db.plugins, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> update(PluginSourceData model) async {
    final companion = _toCompanion(model);
    return await (_db.update(_db.plugins)
      ..where((tbl) => tbl.id.equals(model.id))).write(companion);
  }

  Future<int> updateAll(List<PluginSourceData> items) async {
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

  Future<int> delete(String id) async {
    return await (_db.delete(_db.plugins)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_db.delete(_db.plugins)
      ..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> clear() async {
    await _db.delete(_db.plugins).go();
  }

  Future<PluginSourceData?> getByUrl(String url) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.url.equals(url))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  Future<List<PluginSourceData>> searchByName(String name) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.name.like('%$name%'))).get();
    return data.map(_fromData).toList();
  }

  Future<List<PluginSourceData>> getEnabled() async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.isEnabled.equals(1))).get();
    return data.map(_fromData).toList();
  }

  Future<String> exportData() async {
    final items = await getAll();
    return jsonEncode(items.map((item) => item.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data) as List<dynamic>;
      final items = maps.map((map) => PluginSourceData.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }
}
