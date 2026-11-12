import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/phone_plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/features/phone_plugin/data/repositories/plugin_repository_impl.dart';
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

  Future<List<PluginSourceData>> getAll() async {
    return await getAllPlugins();
  }

  Future<List<PluginSourceData>> getEnabledPlugins() async {
    return await _repository.getEnabled();
  }

  Future<PluginSourceData?> getPluginById(String id) async {
    return await _repository.getById(id);
  }

  Future<String?> getScriptPath(String id) async {
    final plugin = await getPluginById(id);
    return plugin?.phoneNumber;
  }

  Future<PluginSourceData> addPlugin(PluginSourceData plugin) async {
    return await _repository.save(plugin);
  }

  Future<PluginSourceData?> addPluginFromUrl(String url) async {
    return null;
  }

  Future<PluginSourceData?> addPluginFromLocal(String source) async {
    return null;
  }

  Future<PluginSourceData> updatePlugin(PluginSourceData plugin) async {
    return await _repository.update(plugin);
  }

  Future<PluginSourceData?> updatePluginFromUrl(dynamic plugin) async {
    return null;
  }

  Future<bool> deletePlugin(dynamic plugin) async {
    if (plugin is String) {
      return await _repository.deleteById(plugin);
    } else if (plugin is PluginSourceData) {
      return await _repository.delete(plugin);
    }
    return false;
  }

  Future<void> enablePlugin(dynamic plugin) async {
    final id = plugin is String ? plugin : (plugin as dynamic).id?.toString();
    if (id != null) {
      await updateEnabledStatus(id, true);
    }
  }

  Future<void> disablePlugin(dynamic plugin) async {
    final id = plugin is String ? plugin : (plugin as dynamic).id?.toString();
    if (id != null) {
      await updateEnabledStatus(id, false);
    }
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

  Future<List<PluginSourceData>> importFromFile(String path) async {
    return [];
  }

  Future<bool> exportToFile(String path) async {
    return true;
  }
}
