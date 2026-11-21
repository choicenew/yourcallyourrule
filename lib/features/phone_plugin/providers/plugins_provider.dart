import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/phone_plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/features/phone_plugin/data/repositories/plugin_repository_impl.dart';

part 'plugins_provider.g.dart';

@Riverpod(keepAlive: true)
class PluginsNotifier extends _$PluginsNotifier {
  late final PluginRepository _pluginRepository;

  @override
  Future<List<PluginSourceData>> build() async {
    _initRepository();
    return _loadPlugins();
  }

  void _initRepository() {
    _pluginRepository = ref.read(pluginRepositoryProvider);
  }

  Future<List<PluginSourceData>> _loadPlugins() async {
    try {
      return await _pluginRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addPlugin(PluginSourceData plugin) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.save(plugin);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updatePlugin(PluginSourceData plugin) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.update(plugin);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deletePlugin(String pluginId) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.deleteById(pluginId);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updatePluginEnabledStatus(String pluginId, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _pluginRepository.updateEnabledStatus(pluginId, isEnabled);
      state = AsyncValue.data(await _loadPlugins());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
