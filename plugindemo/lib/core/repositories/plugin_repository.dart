
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/core/repositories/base_repository.dart';

/// 插件仓库接口，定义插件相关的数据操作方法
abstract class PluginRepository extends BaseRepository<PluginEntry, String> {
  /// 根据 URL 获取插件
  Future<PluginEntry?> getByUrl(String url);

  /// 根据插件名称搜索插件
  Future<List<PluginEntry>> searchByName(String name);

  /// 更新插件启用状态
  Future<PluginEntry?> updateEnabledStatus(String id, bool isEnabled);

  /// 更新插件优先级
  Future<PluginEntry?> updatePluginOrder(String id, int pluginOrder);

  /// 更新插件自动更新状态
  Future<PluginEntry?> updateAutoUpdateStatus(String id, bool isAutoUpdate);

  /// 获取所有启用的插件，按 pluginOrder 排序
  Future<List<PluginEntry>> getAllEnabledSortedByOrder();

  /// 获取所有禁用的插件
  Future<List<PluginEntry>> getAllDisabled();

  /// 获取下一个可用的 pluginOrder
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
  
  // 添加原始服务中的方法

  
  Future<void> updateVersion(String id, String version);
  
  Future<List<PluginEntry>> getEnabled();
  
  Future<void> setEnabled(String id, bool enabled);
  
  Future<void> updateAutoUpdate(String id, bool isAutoUpdate);
  
  Future<List<PluginEntry>> getAllSorted({String? orderBy, bool ascending = true});
}