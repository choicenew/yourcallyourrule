import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/services/plugin_manager_service.dart';
import 'package:plugindemo/features/plugin/services/plugin_execution_service.dart';

/// 插件调用服务 - 负责协调插件管理服务和插件执行服务
/// 遵循单向依赖原则，作为连接数据库和执行引擎的桥梁
class PluginInvokerService {
  final PluginManagerService _managerService;
  final PluginExecutionService _executionService;

  // 存储已加载的插件
  final Map<String, bool> _loadedPlugins = {};

  PluginInvokerService(this._managerService, this._executionService) {
    // 监听插件就绪状态
    _executionService.pluginReadyStream.listen(_onPluginReady);
  }

  // 处理插件就绪事件
  void _onPluginReady(String pluginId) {
    _loadedPlugins[pluginId] = true;
  }

  // 加载插件
  Future<bool> loadPlugin(PluginEntry plugin) async {
    try {
      // 检查插件是否已加载
      if (_loadedPlugins.containsKey(plugin.id) &&
          _loadedPlugins[plugin.id] == true) {
        return true;
      }

      // 获取插件脚本路径
      final scriptPath = await _managerService.getScriptPath(plugin.id);
      final scriptFile = File(scriptPath);

      // 检查脚本文件是否存在
      if (!await scriptFile.exists()) {
        debugPrint('插件脚本文件不存在: $scriptPath');
        return false;
      }

      // 读取脚本内容
      final script = await scriptFile.readAsString();

      // 加载脚本到引擎
      await _executionService.loadScript(plugin.id, script);

      // 等待插件就绪
      await _executionService.waitForPluginReady(plugin.id);

      // 标记插件为已加载
      _loadedPlugins[plugin.id] = true;

      return true;
    } catch (e) {
      debugPrint('加载插件失败: $e');
      return false;
    }
  }

  // 调用单个插件
  Future<Map<String, dynamic>?> callPlugin(
    String pluginId,
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    try {
      // 获取插件
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return null;
      }

      // 检查插件是否启用
      if (!plugin.isEnabled) {
        debugPrint('插件未启用: $pluginId');
        return null;
      }

      // 加载插件
      final loaded = await loadPlugin(plugin);
      if (!loaded) {
        debugPrint('无法加载插件: $pluginId');
        return null;
      }

      // 调用插件生成输出
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

  // 调用所有启用的插件，返回第一个有效结果（用于快速显示）
  Future<Map<String, dynamic>?> callPlugins(
    String phoneNumber,
    String nationalNumber,
    String e164Number,
  ) async {
    try {
      // 获取所有启用的插件
      final enabledPlugins = await _managerService.getEnabledPlugins();
      if (enabledPlugins.isEmpty) {
        debugPrint('没有启用的插件');
        return null;
      }

      // 用于存储所有插件查询任务的Future
      List<Future<Map<String, dynamic>?>> futures = [];

      // 加载并调用每个插件
      for (final plugin in enabledPlugins) {
        // 加载插件
        final loaded = await loadPlugin(plugin);
        if (loaded) {
          // 调用插件生成输出
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

      // 等待第一个有效的插件结果
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

  /// 调用所有启用的插件并返回所有结果（用于获取完整数据）
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
      // 获取所有启用的插件
      final plugins = await _managerService.getEnabledPlugins();
      if (plugins.isEmpty) {
        firstResultCompleter.complete(null);
        allResultsCompleter.complete(results);
        return (null, allResultsCompleter.future);
      }

      // 创建一个计数器，用于跟踪完成的插件数量
      var completedCount = 0;
      final totalCount = plugins.length;

      // 并行调用所有插件
      for (final plugin in plugins) {
        // 加载插件
        final loaded = await loadPlugin(plugin);
        if (loaded) {
          debugPrint('[Invoker] Calling plugin: ${plugin.id}');
          // 异步调用插件并立即处理结果
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
                  // 使用锁确保线程安全
                  synchronized(() {
                    results.add(result);

                    // 如果这是第一个有效结果且尚未完成firstResultCompleter
                    if (!firstResultCompleter.isCompleted &&
                        isValidResult(result)) {
                      firstValidResult = result;
                      firstResultCompleter.complete(result);
                    }
                  });
                }

                // 增加完成计数
                completedCount++;

                // 当所有插件都完成时，完成Future
                if (completedCount >= totalCount &&
                    !allResultsCompleter.isCompleted) {
                  allResultsCompleter.complete(results);
                }
              })
              .catchError((e) {
                debugPrint('[Invoker] Error calling plugin: ${plugin.id} - $e');

                // 增加完成计数，即使出错也算作完成
                completedCount++;

                // 当所有插件都完成时，完成Future
                if (completedCount >= totalCount &&
                    !allResultsCompleter.isCompleted) {
                  allResultsCompleter.complete(results);
                }
              });
        } else {
          // 如果插件加载失败，也算作完成
          completedCount++;

          // 当所有插件都完成时，完成Future
          if (completedCount >= totalCount &&
              !allResultsCompleter.isCompleted) {
            allResultsCompleter.complete(results);
          }
        }
      }

      // 设置超时，确保不会无限等待
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

      // 等待第一个有效结果（最多等待3秒）
      try {
        debugPrint('[Invoker] Waiting for the first valid result...');
        firstValidResult = await firstResultCompleter.future.timeout(
          const Duration(seconds: 7),
        );
        debugPrint('[Invoker] Got first valid result: $firstValidResult');
      } catch (e) {
        // 超时后，如果没有有效结果，则设置为null
        debugPrint('[Invoker] Timeout waiting for the first result: $e');
        firstValidResult = null;
        if (!firstResultCompleter.isCompleted) {
          firstResultCompleter.complete(null);
        }
      }

      // 返回第一个有效结果和所有结果的Future
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

  // 用于同步访问共享资源的简单锁
  final _lock = Object();
  void synchronized(Function() fn) {
    _synchronizedInternal(_lock, fn);
  }

  void _synchronizedInternal(Object lock, Function() fn) {
    // 在实际应用中，这里应该使用适当的锁机制
    // 但在Dart中，单线程事件循环模型使得这种简单实现在大多数情况下是安全的
    fn();
  }

  // 定义一个函数来检查结果是否有效
  bool isValidResult(Map<String, dynamic> result) {
    return result['count'] != null && result['count'] > 0;
  }

  // 安装插件
  Future<PluginEntry?> installPlugin(String source, {bool isUrl = true}) async {
    try {
      PluginEntry? plugin;

      if (isUrl) {
        // 从URL安装插件
        plugin = await _managerService.addPluginFromUrl(source);
      } else {
        // 从本地文件安装插件
        plugin = await _managerService.addPluginFromLocal(source);
      }

      if (plugin != null && plugin.isEnabled) {
        // 加载插件
        await loadPlugin(plugin);
      }

      return plugin;
    } catch (e) {
      debugPrint('安装插件失败: $e');
      return null;
    }
  }

  // 卸载插件
  Future<bool> uninstallPlugin(String pluginId) async {
    try {
      // 获取插件
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      // 从已加载插件列表中移除
      _loadedPlugins.remove(pluginId);

      // 从数据库中删除插件
      await _managerService.deletePlugin(plugin);

      return true;
    } catch (e) {
      debugPrint('卸载插件失败: $e');
      return false;
    }
  }

  // 启用插件
  Future<bool> enablePlugin(String pluginId) async {
    try {
      // 获取插件
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      // 启用插件
      await _managerService.enablePlugin(plugin);

      // 加载插件
      await loadPlugin(plugin);

      return true;
    } catch (e) {
      debugPrint('启用插件失败: $e');
      return false;
    }
  }

  // 禁用插件
  Future<bool> disablePlugin(String pluginId) async {
    try {
      // 获取插件
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      // 禁用插件
      await _managerService.disablePlugin(plugin);

      // 从已加载插件列表中移除
      _loadedPlugins.remove(pluginId);

      return true;
    } catch (e) {
      debugPrint('禁用插件失败: $e');
      return false;
    }
  }

  // 更新插件
  Future<bool> updatePlugin(String pluginId) async {
    try {
      // 获取插件
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) {
        debugPrint('插件不存在: $pluginId');
        return false;
      }

      // 更新插件
      final updated = await _managerService.updatePluginFromUrl(plugin);

      if (updated && plugin.isEnabled) {
        // 从已加载插件列表中移除
        _loadedPlugins.remove(pluginId);

        // 重新加载插件
        await loadPlugin(plugin);
      }

      return updated;
    } catch (e) {
      debugPrint('更新插件失败: $e');
      return false;
    }
  }

  // 自动更新所有插件
  Future<void> autoUpdateAllPlugins() async {
    await _managerService.updatePlugins();

    // 获取所有启用的插件
    final enabledPlugins = await _managerService.getEnabledPlugins();

    // 重新加载已更新的插件
    for (final plugin in enabledPlugins) {
      if (plugin.isEnabled) {
        // 从已加载插件列表中移除
        _loadedPlugins.remove(plugin.id);

        // 重新加载插件
        await loadPlugin(plugin);
      }
    }
  }

  // 导入插件
  Future<List<PluginEntry>> importPlugins(String path) async {
    final plugins = await _managerService.importFromFile(path);

    // 加载所有启用的插件
    for (final plugin in plugins) {
      if (plugin.isEnabled) {
        await loadPlugin(plugin);
      }
    }

    return plugins;
  }

  // 导出插件
  Future<bool> exportPlugins(String path) async {
    return await _managerService.exportToFile(path);
  }

  // 获取所有插件
  Future<List<PluginEntry>> getAllPlugins() async {
    return await _managerService.getAll();
  }

  // 获取所有启用的插件
  Future<List<PluginEntry>> getEnabledPlugins() async {
    return await _managerService.getEnabledPlugins();
  }

  // 获取插件配置定义
  Future<List<dynamic>?> getPluginSettings(String pluginId) async {
    try {
      final plugin = await _managerService.getPluginById(pluginId);
      if (plugin == null) return null;

      // 确保插件已加载
      await loadPlugin(plugin);

      return await _executionService.getPluginSettings(pluginId);
    } catch (e) {
      return [];
    }
  }

  // 释放资源
  void dispose() {
    // 清理资源
    _loadedPlugins.clear();
  }

  // 添加批量加载方法
  Future<void> loadAllEnabledPlugins() async {
    final enabledPlugins = await _managerService.getEnabledPlugins();
    await Future.wait(enabledPlugins.map((plugin) => loadPlugin(plugin)));
  }
}
