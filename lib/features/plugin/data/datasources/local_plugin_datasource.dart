import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'local_plugin_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalPluginDataSource localPluginDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localPluginDataSource;
}

abstract class PluginModelMapper {
  static PluginEntry fromData(PluginData data) {
    return PluginEntry(
      id: data.id,
      name: data.name,
      url: data.url,
      version: data.version,
      description: data.description ?? '',
      isEnabled: data.isEnabled == 1,
      pluginOrder: data.pluginOrder,
      isAutoUpdate: data.isAutoUpdate == 1,
    );
  }

  static PluginsCompanion toCompanion(PluginEntry model) {
    return PluginsCompanion(
      id: Value(model.id),
      name: Value(model.name),
      url: Value(model.url),
      version: Value(model.version),
      description: Value(model.description),
      isEnabled: Value(model.isEnabled ? 1 : 0),
      pluginOrder: Value(model.pluginOrder),
      isAutoUpdate: Value(model.isAutoUpdate ? 1 : 0),
    );
  }
}

class LocalPluginDataSource {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  LocalPluginDataSource(this._db);

  Future<List<PluginEntry>> getAll() async {
    final data = await (_db.select(_db.plugins)
          ..orderBy([(t) => OrderingTerm(expression: t.pluginOrder)])).get();
    return data.map(PluginModelMapper.fromData).toList();
  }

  Future<PluginEntry?> getById(String id) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? PluginModelMapper.fromData(data) : null;
  }

  Future<String> insert(PluginEntry model) async {
    final id = model.id.isEmpty ? _uuid.v4() : model.id;
    final companion = PluginModelMapper.toCompanion(model).copyWith(id: Value(id));
    await _db.into(_db.plugins).insert(companion, mode: InsertMode.replace);
    return id;
  }

  Future<List<String>> insertAll(List<PluginEntry> models) async {
    final ids = <String>[];
    await _db.batch((batch) {
      for (final model in models) {
        final id = model.id.isEmpty ? _uuid.v4() : model.id;
        ids.add(id);
        final companion = PluginModelMapper.toCompanion(model).copyWith(id: Value(id));
        batch.insert(_db.plugins, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> update(PluginEntry model) async {
    return await (_db.update(_db.plugins)
      ..where((tbl) => tbl.id.equals(model.id))).write(PluginModelMapper.toCompanion(model));
  }

  Future<int> updateAll(List<PluginEntry> items) async {
    await _db.batch((batch) {
      for (final item in items) {
        batch.update(
          _db.plugins,
          PluginModelMapper.toCompanion(item),
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

  Future<PluginEntry?> getByUrl(String url) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.url.equals(url))).getSingleOrNull();
    return data != null ? PluginModelMapper.fromData(data) : null;
  }

  Future<List<PluginEntry>> searchByName(String name) async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.name.like('%$name%'))).get();
    return data.map(PluginModelMapper.fromData).toList();
  }

  Future<List<PluginEntry>> getEnabled() async {
    final data = await (_db.select(_db.plugins)
          ..where((tbl) => tbl.isEnabled.equals(1))).get();
    return data.map(PluginModelMapper.fromData).toList();
  }

  Future<String> exportData() async {
    final items = await getAll();
    return jsonEncode(items.map((item) => item.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> maps = jsonDecode(data);
      final items = maps.map((map) => PluginEntry.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(items);
      return true;
    } catch (e) {
      return false;
    }
  }
}