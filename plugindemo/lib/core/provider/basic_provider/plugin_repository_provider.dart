import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/core/repositories/plugin_repository.dart';
import 'package:plugindemo/data/datasources/local/local_plugin_datasource.dart';
import 'package:plugindemo/data/models/plugin_model.dart';

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
    final models = await _dataSource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PluginEntry?> getById(String id) async {
    final model = await _dataSource.getById(id);
    if (model == null) return null;
    return model.toEntity();
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
    final affected = await _dataSource.delete(id);
    return affected > 0;
  }

  @override
  Future<bool> deleteAll(List<PluginEntry> entities) async {
    final ids = entities.map((e) => e.id).toList();
    await _dataSource.deleteAll(ids);
    return true;
  }

  @override
  Future<List<PluginEntry>> saveAll(List<PluginEntry> entities) async {
    final models = entities.map((e) => PluginModel.fromEntity(e)).toList();
    await _dataSource.insertAll(models);
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
    final model = await _dataSource.getByUrl(url);
    if (model == null) return null;
    return model.toEntity();
  }

  @override
  Future<List<PluginEntry>> searchByName(String name) async {
    final models = await _dataSource.searchByName(name);
    return models.map((m) => m.toEntity()).toList();
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
    // 没有类型字段的支持，返回所有插件。
    return await getAll();
  }

  Future<List<PluginEntry>> getAllEnabled() async {
    final enabled = await getEnabled();
    return enabled;
  }

  Future<List<PluginEntry>> getByCategory(String category) async {
    // 没有分类字段的支持，返回所有插件。
    return await getAll();
  }

  Future<PluginEntry?> getByName(String name) async {
    final models = await _dataSource.searchByName(name);
    if (models.isEmpty) return null;
    return models.first.toEntity();
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
    final all = await getAll();
    return all.where((p) => !p.isEnabled).toList();
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
    final models = await _dataSource.getEnabled();
    return models.map((m) => m.toEntity()).toList();
  }
}