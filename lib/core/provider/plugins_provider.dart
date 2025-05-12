import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/plugin_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/plugin_repository.dart';

/// 插件数据状态的Notifier类
class PluginsNotifier extends AsyncNotifier<List<PluginEntry>> {
  late final PluginRepository _pluginRepository;

  @override
  Future<List<PluginEntry>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有插件
    return _loadPlugins();
  }

  void _initRepository() {
    // 获取仓库实例
    _pluginRepository = ref.read(pluginRepositoryProvider);
  }

  Future<List<PluginEntry>> _loadPlugins() async {
    try {
      // 获取所有插件
      return await _pluginRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加插件
  Future<void> addPlugin(PluginEntry plugin) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.save(plugin);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新插件
  Future<void> updatePlugin(PluginEntry plugin) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.update(plugin);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除插件
  Future<void> deletePlugin(String pluginId) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.deleteById(pluginId);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新插件启用状态
  Future<void> updatePluginEnabledStatus(String pluginId, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.updateEnabledStatus(pluginId, isEnabled);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// 插件数据提供者
final pluginsProvider = AsyncNotifierProvider<PluginsNotifier, List<PluginEntry>>(() {
  return PluginsNotifier();
});