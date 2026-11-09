import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

/// 插件仓库接口，定义统一的 PluginSourceData CRUD 管道
abstract class PluginRepository {
  Future<List<PluginSourceData>> getAll();
  Future<PluginSourceData?> getById(String id);
  Future<PluginSourceData> save(PluginSourceData entity);
  Future<PluginSourceData> update(PluginSourceData entity);
  Future<bool> deleteById(String id);
  Future<bool> delete(PluginSourceData entity);
  Future<bool> deleteAll(List<PluginSourceData> entities);
  Future<int> count();

  Future<PluginSourceData?> getByUrl(String url);
  Future<List<PluginSourceData>> searchByName(String name);
  Future<PluginSourceData?> updateEnabledStatus(String id, bool isEnabled);
  Future<List<PluginSourceData>> getAllEnabledSortedByOrder();
  Future<List<PluginSourceData>> getEnabled();
  Future<void> setEnabled(String id, bool enabled);
}
