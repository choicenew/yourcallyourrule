import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/services/plugin_execution_service.dart';
import 'package:plugindemo/features/plugin/services/plugin_manager_service.dart';

/// 插件调用服务 - 负责协调插件管理服务和插件执行服务
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
      final scriptFile = File(scriptPath);

      if (!await scriptFile.exists()) {
        debugPrint('插件脚本文件不存在: $scriptPath');
        return false;
      }

      final script = await scriptFile.readAsString();

      await _executionService.loadScript(plugin.id, script);

      await _executionService.waitForPluginReady(plugin.id);

      _loadedPlugins[plugin.id] = true;

      return true;
    } catch (e) {
      debugPrint('加载插件失败: $e');
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
        debugPrint('插件不存在: $pluginId');
        return null;
      }

      if (!plugin.isEnabled) {
        debugPrint('插件未启用: $pluginId');
        return null;
      }

      final loaded = await loadPlugin(plugin);
      if (!loaded) {
        debugPrint('无法加载插件: $pluginId');
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
      debugPrint('调用插件失败: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> callPlugins(
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    try {
      final enabledPlugins = await _managerService.getEnabledPlugins();
      if (enabledPlugins.isEmpty) {
        debugPrint('没有启用的插件');
        return null;
      }

      List<Future<Map<String, dynamic>?>> futures = [];

      for (final plugin in enabledPlugins) {
        final loaded = await loadPlugin(plugin);
        if (loaded) {
          futures.add(
            _executionService.generatePluginOutput(
              plugin.id,
              phoneNumber,
              nationalNumber,
              e164Number,
              config: plugin.config,
            ),
          );
        }
      }

      for (var future in futures) {
        try {
          final result = await future;
          if (result != null && isValidResult(result)) {
            return result;
          }
        } catch (e) {
          debugPrint('插件执行错误: $e');
        }
      }

      return null;
    } catch (e) {
      debugPrint('调用插件失败: $e');
      return null;
    }
  }

  Future<(Map<String, dynamic>?, Future<List<Map<String, dynamic>>>)>
  callPluginsAll(
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    final results = <Map<String, dynamic>>[];
    final allResultsCompleter = Completer<List<Map<String, dynamic>>>();
    final firstResultCompleter = Completer<Map<String, dynamic>?>();
    Map<String, dynamic>? firstValidResult;

    try {
      final plugins = await _managerService.getEnabledPlugins();
      if (plugins.isEmpty) {
        firstResultCompleter.complete(null);
        allResultsCompleter.complete(results);
        return (null, allResultsCompleter.future);
      }

      var completedCount = 0;
      final totalCount = plugins.length;

      for (final plugin in plugins) {
        final loaded = await loadPlugin(plugin);
        if (loaded) {
          debugPrint('[Invoker] Calling plugin: ${plugin.id}');
          _executionService
              .generatePluginOutput(
                plugin.id,
                phoneNumber,
                nationalNumber,
                e164Number,
              )
              .then((result) {
                debugPrint('[Invoker] Got result for plugin: ${plugin.id}');
                if (result != null) {
                  synchronized(() {
                    results.add(result);

                    if (!firstResultCompleter.isCompleted &&
                        isValidResult(result)) {
                      firstValidResult = result;
                      firstResultCompleter.complete(result);
                    }
                  });
                }

                completedCount++;

                if (completedCount >= totalCount &&
                    !allResultsCompleter.isCompleted) {
                  allResultsCompleter.complete(results);
                }
              })
              .catchError((e) {
                debugPrint('[Invoker] Error calling plugin: ${plugin.id} - $e');

                completedCount++;

                if (completedCount >= totalCount &&
                    !allResultsCompleter.isCompleted) {
                  allResultsCompleter.complete(results);
                }
              });
        } else {
          completedCount++;

          if (completedCount >= totalCount &&
              !allResultsCompleter.isCompleted) {
            allResultsCompleter.complete(results);
          }
        }
      }

      Timer(const Duration(seconds: 20), () {
        if (!allResultsCompleter.isCompleted) {
          debugPrint(
            '[Invoker] Main 30s timer expired, completing all results.',
          );
          allResultsCompleter.complete(results);
        }
        if (!firstResultCompleter.isCompleted) {
          debugPrint(
            '[Invoker] Main 30s timer expired, completing first result with null.',
          );
          firstResultCompleter.complete(null);
        }
      });

      try {
        debugPrint('[Invoker] Waiting for the first valid result...');
        firstValidResult = await firstResultCompleter.future.timeout(
          const Duration(seconds: 7),
        );
        debugPrint('[Invoker] Got first valid result: $firstValidResult');
      } catch (e) {
        debugPrint('[Invoker] Timeout waiting for the first result: $e');
        firstValidResult = null;
        if (!firstResultCompleter.isCompleted) {
          firstResultCompleter.complete(null);
        }
      }

      return (firstValidResult, allResultsCompleter.future);
    } catch (e) {
      debugPrint('调用所有插件失败: $e');

      if (!firstResultCompleter.isCompleted) {
        firstResultCompleter.complete(null);
      }
      if (!allResultsCompleter.isCompleted) {
        allResultsCompleter.complete(results);
      }

      return (null, allResultsCompleter.future);
    }
  }

  final _lock = Object();
  void synchronized(Function() fn) {
    _synchronizedInternal(_lock, fn);
  }

  void _synchronizedInternal(Object lock, Function() fn) {
    fn();
  }

  bool isValidResult(Map<String, dynamic> result) {
    if (result['success'] == false) return false;

    final count = result['count'];
    if (count is int && count > 0) return true;

    final predefinedLabel = result['predefinedLabel']?.toString().trim();
    if (predefinedLabel != null &&
        predefinedLabel.isNotEmpty &&
        predefinedLabel != 'Unknown') {
      return true;
    }

    final action = result['action']?.toString().trim();
    if (action != null && action.isNotEmpty && action != 'none') {
      return true;
    }

    final sourceLabel = result['sourceLabel']?.toString().trim();
    if (sourceLabel != null &&
        sourceLabel.isNotEmpty &&
        sourceLabel != 'No Match') {
      return true;
    }

    final name = result['name']?.toString().trim();
    if (name != null && name.isNotEmpty) {
      return true;
    }

    return false;
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
      debugPrint('安装插件失败: $e');
      return null;
    }
  }

  Future<bool> uninstallPlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      _loadedPlugins.remove(pluginId);

      await _managerService.deletePlugin(plugin);

      return true;
    } catch (e) {
      debugPrint('卸载插件失败: $e');
      return false;
    }
  }

  Future<bool> enablePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      await _managerService.enablePlugin(plugin);

      await loadPlugin(plugin);

      return true;
    } catch (e) {
      debugPrint('启用插件失败: $e');
      return false;
    }
  }

  Future<bool> disablePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      await _managerService.disablePlugin(plugin);

      _loadedPlugins.remove(pluginId);

      return true;
    } catch (e) {
      debugPrint('禁用插件失败: $e');
      return false;
    }
  }

  Future<bool> updatePlugin(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      final updated = await _managerService.updatePluginFromUrl(plugin);

      if (updated && plugin.isEnabled) {
        _loadedPlugins.remove(pluginId);

        await loadPlugin(plugin);
      }

      return updated;
    } catch (e) {
      debugPrint('更新插件失败: $e');
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

  Future<void> loadAllEnabledPlugins() async {
    final enabledPlugins = await _managerService.getEnabledPlugins();
    await Future.wait(enabledPlugins.map((plugin) => loadPlugin(plugin)));
  }
}
