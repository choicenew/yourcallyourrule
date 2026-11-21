import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/phone_plugin/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/features/phone_plugin/data/repositories/plugin_repository_impl.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'plugin_manager_service.g.dart';

@Riverpod(keepAlive: true)
PluginManagerService pluginManagerService(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  final PluginRepository repo = PluginRepositoryImpl(db);
  final configRepo = ref.watch(configRepositoryProvider);
  return PluginManagerService(repo, configRepo);
}

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
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final script = response.body;
        final info = extractPluginInfo(script);
        final plugin = PluginSourceData(
          name: info['name'] ?? 'Unknown Plugin',
          phoneNumber: url,
          count: 0,
        );
        return await _repository.save(plugin);
      }
    } catch (e) {
      debugPrint('[PluginManagerService] addPluginFromUrl 失败: $e');
    }
    return null;
  }

  Future<PluginSourceData?> addPluginFromLocal(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final script = await file.readAsString();
        final info = extractPluginInfo(script);
        final plugin = PluginSourceData(
          name: info['name'] ?? (file.uri.pathSegments.isNotEmpty ? file.uri.pathSegments.last : 'Local Plugin'),
          phoneNumber: filePath,
          count: 0,
        );
        return await _repository.save(plugin);
      }
    } catch (e) {
      debugPrint('[PluginManagerService] addPluginFromLocal 失败: $e');
    }
    return null;
  }

  static Map<String, String> extractPluginInfo(String script) {
    final nameRegex = RegExp(r'''name:\s*['"](.*?)['"]''');
    final nameMatch = nameRegex.firstMatch(script);
    return {
      'name': nameMatch?.group(1) ?? 'Custom Plugin',
    };
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

  Future<void> reloadPlugins() async => await updatePlugins();

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
