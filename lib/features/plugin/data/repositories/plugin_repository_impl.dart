import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/features/plugin/data/datasources/local_plugin_datasource.dart';

part 'plugin_repository_impl.g.dart';

@Riverpod(keepAlive: true)
PluginRepository pluginRepository(Ref ref) {
  final localPluginDataSource = ref.watch(localPluginDataSourceProvider);
  return PluginRepositoryImpl(localPluginDataSource);
}

class PluginRepositoryImpl implements PluginRepository {
  final LocalPluginDataSource _dataSource;

  PluginRepositoryImpl(this._dataSource);

  @override
  Future<List<PluginSourceData>> getAll() async {
    return await _dataSource.getAll();
  }

  @override
  Future<PluginSourceData?> getById(String id) async {
    return await _dataSource.getById(id);
  }

  @override
  Future<PluginSourceData> save(PluginSourceData entity) async {
    await _dataSource.insert(entity);
    return entity;
  }

  @override
  Future<PluginSourceData> update(PluginSourceData entity) async {
    await _dataSource.update(entity);
    return entity;
  }

  @override
  Future<bool> delete(PluginSourceData entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    final result = await _dataSource.delete(id);
    return result > 0;
  }

  @override
  Future<bool> deleteAll(List<PluginSourceData> entities) async {
    final ids = entities.map((e) => e.id).toList();
    final result = await _dataSource.deleteAll(ids);
    return result > 0;
  }

  @override
  Future<int> count() async {
    final items = await getAll();
    return items.length;
  }

  @override
  Future<PluginSourceData?> getByUrl(String url) async {
    return await _dataSource.getByUrl(url);
  }

  @override
  Future<List<PluginSourceData>> searchByName(String name) async {
    return await _dataSource.searchByName(name);
  }

  @override
  Future<PluginSourceData?> updateEnabledStatus(String id, bool isEnabled) async {
    final plugin = await getById(id);
    if (plugin != null) {
      final updated = plugin.copyWith(isEnabled: isEnabled);
      await update(updated);
      return updated;
    }
    return null;
  }

  @override
  Future<List<PluginSourceData>> getAllEnabledSortedByOrder() async {
    return await _dataSource.getEnabled();
  }

  @override
  Future<List<PluginSourceData>> getEnabled() async {
    return await _dataSource.getEnabled();
  }

  @override
  Future<void> setEnabled(String id, bool enabled) async {
    await updateEnabledStatus(id, enabled);
  }
}
