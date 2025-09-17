import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/data/datasources/local/local_plugin_datasource.dart';
import 'package:yourcallyourrule/data/models/plugin_model.dart';

import '../datasource/local_plugin_datasource_provider.dart';

/// 插件仓库提供者
final pluginRepositoryProvider = Provider<PluginRepository>((ref) {
  final localPluginDataSource = ref.watch(localPluginDataSourceProvider);
  // 返回插件仓库实现
  return PluginRepositoryImpl(localPluginDataSource);
});

/// 插件仓库实现类
class PluginRepositoryImpl implements PluginRepository {
  final LocalPluginDataSource _dataSource;

  PluginRepositoryImpl(this._dataSource);

  @override
  Future<List<PluginEntry>> getAll() async {
    final maps = await _dataSource.queryAll();
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<PluginEntry?> getById(String id) async {
    final map = await _dataSource.queryById(id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<PluginEntry> save(PluginEntry entity) async {
    await _dataSource.insert(PluginModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<PluginEntry> update(PluginEntry entity) async {
    await _dataSource.update(PluginModel.fromEntity(entity));
    return entity;
  }

  @override
  Future<bool> delete(PluginEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _dataSource.delete(id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<PluginEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<PluginEntry>> saveAll(List<PluginEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final plugins = await getAll();
    return plugins.length;
  }

  @override
  PluginEntry fromMap(Map<String, dynamic> map) {
    return PluginEntry.fromMap(map);
  }

  @override
  Future<PluginEntry?> getByUrl(String url) async {
    final map = await _dataSource.getByUrl(url);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<List<PluginEntry>> searchByName(String name) async {
    final maps = await _dataSource.searchByName(name);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  @override
  Future<void> setEnabled(String id, bool enabled) async {
    await updateEnabledStatus(id, enabled);
  }
  
  @override
  Future<void> updateAutoUpdate(String id, bool isAutoUpdate) async {
    await updateAutoUpdateStatus(id, isAutoUpdate);
  }
  
  @override
  Future<List<PluginEntry>> getAllSorted({String? orderBy, bool ascending = true}) async {
    final plugins = await getAll();
    
    if (orderBy != null) {
      plugins.sort((a, b) {
        dynamic valueA;
        dynamic valueB;
        
        switch (orderBy) {
          case 'name':
            valueA = a.name;
            valueB = b.name;
            break;
          case 'pluginOrder':
            valueA = a.pluginOrder;
            valueB = b.pluginOrder;
            break;
          case 'version':
            valueA = a.version;
            valueB = b.version;
            break;
          default:
            valueA = a.name;
            valueB = b.name;
        }
        
        int result = valueA.compareTo(valueB);
        return ascending ? result : -result;
      });
    }
    
    return plugins;
  }



  Future<List<PluginEntry>> getByType(String type) async {
    final maps = await _dataSource.getByType(type);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<PluginEntry>> getAllEnabled() async {
    final maps = await _dataSource.getAllEnabled();
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<List<PluginEntry>> getByCategory(String category) async {
    final maps = await _dataSource.getByCategory(category);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<PluginEntry?> getByName(String name) async {
    final maps = await _dataSource.getByName(name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<PluginEntry?> updateEnabledStatus(String id, bool isEnabled) async {
    final plugin = await getById(id);
    if (plugin == null) return null;
    final updatedPlugin = plugin.copyWith(isEnabled: isEnabled);
    await update(updatedPlugin);
    return updatedPlugin;
  }

  @override
  Future<PluginEntry?> updatePluginOrder(String id, int pluginOrder) async {
    final plugin = await getById(id);
    if (plugin == null) return null;
    final updatedPlugin = plugin.copyWith(pluginOrder: pluginOrder);
    await update(updatedPlugin);
    return updatedPlugin;
  }

  @override
  Future<PluginEntry?> updateAutoUpdateStatus(String id, bool isAutoUpdate) async {
    final plugin = await getById(id);
    if (plugin == null) return null;
    final updatedPlugin = plugin.copyWith(isAutoUpdate: isAutoUpdate);
    await update(updatedPlugin);
    return updatedPlugin;
  }

  @override
  Future<List<PluginEntry>> getAllEnabledSortedByOrder() async {
    final plugins = await getEnabled();
    plugins.sort((a, b) => a.pluginOrder.compareTo(b.pluginOrder));
    return plugins;
  }

  @override
  Future<List<PluginEntry>> getAllDisabled() async {
    final maps = await _dataSource.getAllDisabled();
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<int> getNextPluginOrder() async {
    final plugins = await getAll();
    if (plugins.isEmpty) return 0;
    return plugins.map((p) => p.pluginOrder).reduce((a, b) => a > b ? a : b) + 1;
  }

  @override
  Future<void> updateVersion(String id, String version) async {
    final plugin = await getById(id);
    if (plugin != null) {
      final updatedPlugin = plugin.copyWith(version: version);
      await update(updatedPlugin);
    }
  }

  @override
  Future<List<PluginEntry>> getEnabled() async {
    final maps = await _dataSource.getEnabled();
    return maps.map((map) => fromMap(map)).toList();
  }
}