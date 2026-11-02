import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/core/repositories/base_repository.dart';

abstract class PluginRepository extends BaseRepository<PluginEntry, String> {
  Future<PluginEntry?> getByUrl(String url);

  Future<List<PluginEntry>> searchByName(String name);

  Future<PluginEntry?> updateEnabledStatus(String id, bool isEnabled);

  Future<PluginEntry?> updatePluginOrder(String id, int pluginOrder);

  Future<PluginEntry?> updateAutoUpdateStatus(String id, bool isAutoUpdate);

  Future<List<PluginEntry>> getAllEnabledSortedByOrder();

  Future<List<PluginEntry>> getAllDisabled();

  Future<int> getNextPluginOrder();

  @override
  Future<PluginEntry> save(PluginEntry entry);
  
  @override
  Future<bool> deleteById(String id);
  
  @override
  Future<PluginEntry?> getById(String id);
  
  @override
  Future<List<PluginEntry>> getAll();
  
  @override
  PluginEntry fromMap(Map<String, dynamic> map);
  
  Future<void> updateVersion(String id, String version);
  
  Future<List<PluginEntry>> getEnabled();
  
  Future<void> setEnabled(String id, bool enabled);
  
  Future<void> updateAutoUpdate(String id, bool isAutoUpdate);
  
  Future<List<PluginEntry>> getAllSorted({String? orderBy, bool ascending = true});
}
