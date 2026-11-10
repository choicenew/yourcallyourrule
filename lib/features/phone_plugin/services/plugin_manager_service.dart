import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/features/plugin/data/repositories/plugin_repository_impl.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

final pluginManagerServiceProvider = Provider<PluginManagerService>((ref) {
  final db = ref.watch(localDatabaseProvider);
  final PluginRepository repo = PluginRepositoryImpl(db);
  final configRepo = ref.watch(configRepositoryProvider);
  return PluginManagerService(repo, configRepo);
});

class PluginManagerService {
  final PluginRepository _repository;

  PluginManagerService(
    this._repository,
    ConfigRepository configRepository,
  );

  Future<List<PluginSourceData>> getAllPlugins() async {
    return await _repository.getAll();
  }

  Future<PluginSourceData?> getPluginById(String id) async {
    return await _repository.getById(id);
  }

  Future<PluginSourceData> addPlugin(PluginSourceData plugin) async {
    return await _repository.save(plugin);
  }

  Future<PluginSourceData?> addPluginFromUrl(String url) async {
    return null;
  }

  Future<PluginSourceData> updatePlugin(PluginSourceData plugin) async {
    return await _repository.update(plugin);
  }

  Future<bool> deletePlugin(String id) async {
    return await _repository.deleteById(id);
  }

  Future<void> updatePlugins() async {
    final plugins = await getAllPlugins();
    for (final plugin in plugins) {
      await updatePlugin(plugin);
    }
  }

  Future<void> updateEnabledStatus(String id, bool isEnabled) async {
    final plugin = await _repository.getById(id);
    if (plugin != null) {
      await _repository.update(plugin);
    }
  }
}
