import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';
import 'package:yourcallyourrule/features/phone_plugin/services/plugin_execution_service.dart';
import 'package:yourcallyourrule/features/phone_plugin/services/plugin_manager_service.dart';

part 'plugin_invoker_service.g.dart';

@Riverpod(keepAlive: true)
PluginInvokerService pluginService(Ref ref) {
  final pluginManagerService = ref.watch(pluginManagerServiceProvider);
  final pluginExecutionService = ref.watch(pluginExecutionServiceProvider);
  return PluginInvokerService(pluginManagerService, pluginExecutionService);
}

class PluginInvokerService {
  final PluginManagerService _managerService;
  final PluginExecutionService _executionService;

  final Map<String, bool> _loadedPlugins = {};

  PluginInvokerService(this._managerService, this._executionService) {
    _executionService.pluginReadyStream.listen(_onPluginReady);
  }

  void _onPluginReady(String pluginId) {
    _loadedPlugins[pluginId] = true;
  }

  Future<bool> loadPlugin(PluginEntry plugin) async {
    try {
      if (_loadedPlugins.containsKey(plugin.id) &&
          _loadedPlugins[plugin.id] == true) {
        return true;
      }

      final scriptPath = await _managerService.getScriptPath(plugin.id);
      if (scriptPath == null) return false;
      final scriptFile = File(scriptPath);

      if (!await scriptFile.exists()) {
        debugPrint('Plugin script does not exist: $scriptPath');
        return false;
      }

      final script = await scriptFile.readAsString();

      await _executionService.loadScript(plugin.id, script);

      await _executionService.waitForPluginReady(plugin.id);

      _loadedPlugins[plugin.id] = true;

      return true;
    } catch (e) {
      debugPrint('Load plugin error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> callPlugin(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('Plugin not found: $pluginId');
        return null;
      }

      if (!plugin.isEnabled) {
        debugPrint('Plugin not enabled: $pluginId');
        return null;
      }

      final loaded = await loadPlugin(plugin);
      if (!loaded) {
        debugPrint('Cannot load plugin: $pluginId');
        return null;
      }

      return await _executionService.generatePluginOutput(
        pluginId,
        phoneNumber,
        nationalNumber,
        e164Number,
        config: plugin.config,
      );
    } catch (e) {
      debugPrint('Call plugin error: $e');
      return null;
    }
  }

  Future<PluginEntry?> installPlugin(String source, {bool isUrl = true}) async {
    try {
      PluginEntry? plugin;

      if (isUrl) {
        plugin = await _managerService.addPluginFromUrl(source);
      } else {
        plugin = await _managerService.addPluginFromLocal(source);
      }

      if (plugin != null && plugin.isEnabled) {
        await loadPlugin(plugin);
      }

      return plugin;
    } catch (e) {
      debugPrint('Install plugin error: $e');
      return null;
    }
  }

  Future<bool> uninstallPlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('Plugin not found: $pluginId');
        return false;
      }

      _loadedPlugins.remove(pluginId);

      await _managerService.deletePlugin(plugin.id);

      return true;
    } catch (e) {
      debugPrint('Uninstall plugin error: $e');
      return false;
    }
  }

  Future<bool> enablePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('Plugin not found: $pluginId');
        return false;
      }

      await _managerService.enablePlugin(plugin);

      await loadPlugin(plugin);

      return true;
    } catch (e) {
      debugPrint('Enable plugin error: $e');
      return false;
    }
  }

  Future<bool> disablePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('Plugin not found: $pluginId');
        return false;
      }

      await _managerService.disablePlugin(plugin);

      _loadedPlugins.remove(pluginId);

      return true;
    } catch (e) {
      debugPrint('Disable plugin error: $e');
      return false;
    }
  }

  Future<bool> updatePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('Plugin not found: $pluginId');
        return false;
      }

      final updated = (await _managerService.updatePluginFromUrl(plugin)) != null;

      if (updated && plugin.isEnabled) {
        _loadedPlugins.remove(pluginId);

        await loadPlugin(plugin);
      }

      return updated;
    } catch (e) {
      debugPrint('Update plugin error: $e');
      return false;
    }
  }

  Future<void> autoUpdateAllPlugins() async {
    await _managerService.updatePlugins();

    final enabledPlugins = await _managerService.getEnabledPlugins();

    for (final plugin in enabledPlugins) {
      if (plugin.isEnabled) {
        _loadedPlugins.remove(plugin.id);

        await loadPlugin(plugin);
      }
    }
  }

  Future<List<PluginEntry>> importPlugins(String path) async {
    final plugins = await _managerService.importFromFile(path);

    for (final plugin in plugins) {
      if (plugin.isEnabled) {
        await loadPlugin(plugin);
      }
    }

    return plugins;
  }

  Future<bool> exportPlugins(String path) async {
    return await _managerService.exportToFile(path);
  }

  Future<List<PluginEntry>> getAllPlugins() async {
    return await _managerService.getAll();
  }

  Future<List<PluginEntry>> getEnabledPlugins() async {
    return await _managerService.getEnabledPlugins();
  }

  Future<List<dynamic>?> getPluginSettings(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) return null;

      await loadPlugin(plugin);

      return await _executionService.getPluginSettings(pluginId);
    } catch (e) {
      return [];
    }
  }

  void dispose() {
    _loadedPlugins.clear();
  }
}
