import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:plugindemo/features/plugin/services/plugin_manager_service.dart';
import 'package:plugindemo/features/plugin/services/plugin_invoker_service.dart';
import 'package:plugindemo/core/entities/plugin/plugin_entry.dart';
import 'package:plugindemo/features/plugin/presentation/pages/plugin_test_page.dart';
import 'package:plugindemo/features/plugin/presentation/pages/plugin_script_editor_page.dart';
import 'package:plugindemo/features/plugin/presentation/pages/plugin_settings_dialog.dart';
import 'package:plugindemo/generated/app_localizations.dart';

class PluginManagementPage extends ConsumerStatefulWidget {
  const PluginManagementPage({super.key});

  @override
  ConsumerState<PluginManagementPage> createState() => _PluginManagementPageState();
}

class _PluginManagementPageState extends ConsumerState<PluginManagementPage> {
  List<PluginEntry> _plugins = [];
  bool _isLoading = true;
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlugins();
  }

  @override
  void dispose() {
    _urlController.dispose();
    _nameController.dispose();
    _versionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadPlugins() async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      final plugins = await pluginService.getAll();
      setState(() {
        _plugins = plugins;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.loadPluginsFailed(e.toString()) ??
                  '加载插件失败: $e',
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _togglePluginStatus(PluginEntry plugin, bool isEnabled) async {
    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      await pluginService.togglePluginStatus(plugin, isEnabled);
      await _loadPlugins();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.changePluginStatusFailed(e.toString()) ??
                  '修改状态失败: $e',
            ),
          ),
        );
      }
    }
  }

  Future<void> _updatePlugin(PluginEntry plugin) async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      final updated = await pluginService.updatePluginFromUrl(plugin);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              updated
                  ? (AppLocalizations.of(context)?.pluginUpdateSuccess ?? '更新成功')
                  : (AppLocalizations.of(context)?.pluginLatestVersion ?? '已是最新版本'),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.updatePluginFailed(e.toString()) ??
                  '更新失败: $e',
            ),
          ),
        );
      }
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _deletePlugin(PluginEntry plugin) async {
    final loc = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc?.deletePlugin ?? '删除插件'),
        content: Text(
          loc?.confirmDeletePlugin(plugin.name) ?? '确定要删除插件 "${plugin.name}" 吗？',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(loc?.cancelButton ?? '取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(loc?.deletePlugin ?? '删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final pluginService = ref.read(pluginManagerServiceProvider);
      try {
        await pluginService.deletePlugin(plugin);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc?.pluginDeleted ?? '插件已删除')),
          );
        }
        await _loadPlugins();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loc?.deletePluginFailed(e.toString()) ?? '删除失败: $e',
              ),
            ),
          );
        }
      }
    }
  }

  Future<void> _addPluginFromUrl() async {
    final loc = AppLocalizations.of(context);
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc?.enterValidUrl ?? '请输入有效 URL')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      final plugin = await pluginService.addPluginFromUrl(url);
      if (plugin != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loc?.pluginAddedSuccess(plugin.name) ?? '插件 ${plugin.name} 添加成功',
              ),
            ),
          );
          _urlController.clear();
          Navigator.of(context).pop();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc?.addPluginFailed ?? '添加插件失败')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc?.addPluginFailedWithError(e.toString()) ?? '添加失败: $e',
            ),
          ),
        );
      }
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _addPluginFromLocal() async {
    final loc = AppLocalizations.of(context);
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['js'],
      );

      if (result.isNotEmpty && result.single.path != null) {
        setState(() {
          _isLoading = true;
        });

        final pluginService = ref.read(pluginManagerServiceProvider);
        final plugin =
            await pluginService.addPluginFromLocal(result.single.path!);

        if (plugin != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loc?.pluginAddedSuccess(plugin.name) ?? '插件 ${plugin.name} 添加成功',
              ),
            ),
          );
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loc?.addPluginFailed ?? '添加失败')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc?.addPluginFailedWithError(e.toString()) ?? '添加失败: $e',
            ),
          ),
        );
      }
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _addNewPlugin() async {
    final loc = AppLocalizations.of(context);
    try {
      setState(() {
        _isLoading = true;
      });

      final pluginService = ref.read(pluginManagerServiceProvider);
      final newPlugin = PluginEntry(
        id: const Uuid().v4(),
        name: _nameController.text,
        version: _versionController.text,
        url: _urlController.text,
        description: _descriptionController.text,
        isEnabled: true,
        pluginOrder: _plugins.length,
      );

      await pluginService.addPlugin(newPlugin);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc?.pluginAddedSuccess(newPlugin.name) ?? '插件已添加',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              loc?.addPluginFailedWithError(e.toString()) ?? '添加失败: $e',
            ),
          ),
        );
      }
    } finally {
      await _loadPlugins();
    }
  }

  void _showAddPluginDialog() {
    _nameController.text = '';
    _versionController.text = '1.0.0';
    _descriptionController.text = '';
    _urlController.text = '';

    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc?.addPlugin ?? '添加插件'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: loc?.pluginName ?? '插件名称',
                  hintText: loc?.enterPluginName ?? '请输入插件名称',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _versionController,
                decoration: InputDecoration(
                  labelText: loc?.pluginVersion ?? '版本号',
                  hintText: loc?.enterVersion ?? '请输入版本号',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: loc?.pluginUrl ?? '插件 URL',
                  hintText: loc?.enterPluginUrl ?? '请输入插件 URL',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc?.cancelButton ?? '取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addNewPlugin();
            },
            child: Text(loc?.add ?? '添加'),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu() {
    final loc = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_link),
              title: Text(loc?.addPluginFromUrl ?? '从 URL 添加插件'),
              onTap: () {
                Navigator.of(context).pop();
                _showAddPluginFromUrlDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: Text(loc?.addPluginFromLocalFile ?? '从本地 JS 文件添加'),
              onTap: () {
                Navigator.of(context).pop();
                _addPluginFromLocal();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: Text(loc?.exportPluginList ?? '导出插件列表'),
              onTap: () async {
                Navigator.of(context).pop();
                final path = await FilePicker.getDirectoryPath();
                if (path != null) {
                  final pluginService = ref.read(pluginManagerServiceProvider);
                  try {
                    await pluginService
                        .exportToFile('$path/plugins_export.json');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loc?.pluginListExportSuccess ?? '导出成功',
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loc?.exportPluginListFailed(e.toString()) ??
                                '导出失败: $e',
                          ),
                        ),
                      );
                    }
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: Text(loc?.importPluginList ?? '导入插件列表'),
              onTap: () async {
                Navigator.of(context).pop();
                final result = await FilePicker.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );

                if (result.isNotEmpty && result.single.path != null) {
                  final pluginService = ref.read(pluginManagerServiceProvider);
                  try {
                    final plugins = await pluginService
                        .importFromFile(result.single.path!);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loc?.importPluginSuccess(
                                  plugins.length.toString(),
                                ) ??
                                '导入成功 ${plugins.length} 个插件',
                          ),
                        ),
                      );
                    }
                    await _loadPlugins();
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            loc?.importPluginListFailed(e.toString()) ??
                                '导入失败: $e',
                          ),
                        ),
                      );
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPluginFromUrlDialog() {
    _urlController.clear();
    final loc = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc?.addPluginFromUrl ?? '从 URL 下载插件'),
        content: TextField(
          controller: _urlController,
          decoration: InputDecoration(
            labelText: loc?.pluginUrl ?? '插件 URL',
            hintText: 'https://example.com/plugin.js',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(loc?.cancelButton ?? '取消'),
          ),
          TextButton(
            onPressed: () {
              _addPluginFromUrl();
            },
            child: Text(loc?.add ?? '下载并添加'),
          ),
        ],
      ),
    );
  }

  Future<void> _openPluginSettings(PluginEntry plugin) async {
    final invokerService = ref.read(pluginServiceProvider);
    final newConfig = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => PluginSettingsDialog(
        plugin: plugin,
        invokerService: invokerService,
      ),
    );

    if (newConfig != null) {
      final updatedPlugin = plugin.copyWith(config: newConfig);
      final managerService = ref.read(pluginManagerServiceProvider);
      await managerService.updatePlugin(updatedPlugin);
      await _loadPlugins();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc?.pluginManagement ?? '插件测试与配置'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPluginDialog,
            tooltip: loc?.addPlugin ?? '添加插件',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPlugins,
            tooltip: loc?.refresh ?? '刷新',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showOptionsMenu,
            tooltip: loc?.moreOptions ?? '更多选项',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _plugins.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.extension_off,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(loc?.noPlugins ?? '暂无插件，点击下方按钮添加',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(loc?.addPlugin ?? '添加新插件'),
                        onPressed: _showAddPluginDialog,
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildPluginStatusCard(),
                    const SizedBox(height: 16),
                    ..._plugins.map(_buildPluginCard),
                  ],
                ),
    );
  }

  Widget _buildPluginStatusCard() {
    final loc = AppLocalizations.of(context);
    final enabledCount = _plugins.where((p) => p.isEnabled).length;
    final autoUpdateCount = _plugins.where((p) => p.isAutoUpdate).length;
    final allEnabled = _plugins.isNotEmpty && enabledCount == _plugins.length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: allEnabled,
                  onChanged: (value) {
                    if (value != null) {
                      final pluginService = ref.read(pluginManagerServiceProvider);
                      pluginService.toggleAllPluginsStatus(value).then((_) {
                        _loadPlugins();
                      });
                    }
                  },
                ),
                Text(loc?.selectAll ?? '全选启用'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.extension,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      loc?.pluginService ?? '插件服务概览',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusItem(loc?.installed ?? '已安装',
                    _plugins.length.toString()),
                _buildStatusItem(loc?.enabled ?? '已启用',
                    enabledCount.toString()),
                _buildStatusItem(loc?.autoUpdate ?? '自动更新',
                    autoUpdateCount.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPluginCard(PluginEntry plugin) {
    final loc = AppLocalizations.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plugin.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc?.version(plugin.version) ?? 'v${plugin.version}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: plugin.isEnabled,
                  onChanged: (value) => _togglePluginStatus(plugin, value),
                ),
              ],
            ),
            if (plugin.url.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                plugin.url,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: Text(loc?.testPlugin ?? '运行测试'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PluginTestPage(plugin: plugin),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => _openPluginSettings(plugin),
                      tooltip: loc?.settings ?? '插件设置',
                    ),
                    IconButton(
                      icon: const Icon(Icons.code),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PluginScriptEditorPage(plugin: plugin),
                          ),
                        );
                      },
                      tooltip: '编辑脚本',
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => _updatePlugin(plugin),
                      tooltip: loc?.updatePlugin ?? '更新插件',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePlugin(plugin),
                      tooltip: loc?.deletePlugin ?? '删除插件',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
