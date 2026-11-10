import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

part 'plugin_repository_impl.g.dart';

/// 插件仓库提供者 (直连 Drift LocalDatabase)
@Riverpod(keepAlive: true)
PluginRepository pluginRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return PluginRepositoryImpl(db);
}

class PluginRepositoryImpl implements PluginRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  PluginRepositoryImpl(this._db);

  String _extractId(PluginSourceData data) {
    if (data.phoneNumber != null && data.phoneNumber!.isNotEmpty) {
      return data.phoneNumber!;
    }
    if (data.name != null && data.name!.isNotEmpty) {
      return data.name!;
    }
    return _uuid.v4();
  }

  PluginsCompanion _toCompanion(PluginSourceData data) {
    final id = _extractId(data);
    return PluginsCompanion.insert(
      id: id,
      name: data.name ?? '',
      url: data.phoneNumber ?? '',
      version: '1.0.0',
      pluginOrder: data.count ?? 0,
      isEnabled: const Value(1),
    );
  }

  PluginSourceData _fromData(PluginData data) {
    return PluginSourceData(
      name: data.name,
      phoneNumber: data.url,
      count: data.pluginOrder,
    );
  }

  @override
  Future<List<PluginSourceData>> getAll() async {
    final rows = await _db.select(_db.plugins).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<PluginSourceData?> getById(String id) async {
    final row = await (_db.select(_db.plugins)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<PluginSourceData> save(PluginSourceData entity) async {
    final companion = _toCompanion(entity);
    await _db.into(_db.plugins).insertOnConflictUpdate(companion);
    return entity;
  }

  @override
  Future<PluginSourceData> update(PluginSourceData entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<bool> delete(PluginSourceData entity) async {
    return await deleteById(_extractId(entity));
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.plugins)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PluginSourceData> entities) async {
    final ids = entities.map(_extractId).toList();
    await (_db.delete(_db.plugins)..where((tbl) => tbl.id.isIn(ids))).go();
    return true;
  }

  @override
  Future<int> count() async {
    final items = await getAll();
    return items.length;
  }

  @override
  Future<PluginSourceData?> getByUrl(String url) async {
    final row = await (_db.select(_db.plugins)..where((tbl) => tbl.url.equals(url))).getSingleOrNull();
    return row != null ? _fromData(row) : null;
  }

  @override
  Future<List<PluginSourceData>> searchByName(String name) async {
    final rows = await (_db.select(_db.plugins)..where((tbl) => tbl.name.contains(name))).get();
    return rows.map(_fromData).toList();
  }

  @override
  Future<PluginSourceData?> updateEnabledStatus(String id, bool isEnabled) async {
    final plugin = await getById(id);
    if (plugin != null) {
      await save(plugin);
      return plugin;
    }
    return null;
  }

  @override
  Future<List<PluginSourceData>> getAllEnabledSortedByOrder() async {
    return await getEnabled();
  }

  @override
  Future<List<PluginSourceData>> getEnabled() async {
    final rows = await (_db.select(_db.plugins)..where((tbl) => tbl.isEnabled.equals(1))).get();
    final items = rows.map(_fromData).toList();
    items.sort((a, b) => (a.count ?? 0).compareTo(b.count ?? 0));
    return items;
  }

  @override
  Future<void> setEnabled(String id, bool enabled) async {
    await updateEnabledStatus(id, enabled);
  }
}
