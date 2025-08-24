import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalizations.of(context)!.loadPluginsFailed(e.toString()))),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _togglePluginStatus(PluginEntry plugin, bool isEnabled) async {
    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      await pluginService.togglePluginStatus(plugin, isEnabled);
      await _loadPlugins(); // 重新加载插件列表
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .changePluginStatusFailed(e.toString()))),
      );
    }
  }

  Future<void> _updatePlugin(PluginEntry plugin) async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      final updated = await pluginService.updatePluginFromUrl(plugin);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(updated
                ? AppLocalizations.of(context)!.pluginUpdateSuccess
                : AppLocalizations.of(context)!.pluginLatestVersion)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .updatePluginFailed(e.toString()))),
      );
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _deletePlugin(PluginEntry plugin) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deletePlugin),
        content: Text(
            AppLocalizations.of(context)!.confirmDeletePlugin(plugin.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.deletePlugin),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final pluginService = ref.read(pluginManagerServiceProvider);
      try {
        await pluginService.deletePlugin(plugin);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.pluginDeleted)),
        );
        await _loadPlugins();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .deletePluginFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> _addPluginFromUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterValidUrl)),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .pluginAddedSuccess(plugin.name))),
        );
        _urlController.clear();
        Navigator.of(context).pop(); // 关闭对话框
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.addPluginFailed)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .addPluginFailedWithError(e.toString()))),
      );
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _addPluginFromLocal() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['js'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _isLoading = true;
        });

        final pluginService = ref.read(pluginManagerServiceProvider);
        final plugin =
            await pluginService.addPluginFromLocal(result.files.single.path!);

        if (plugin != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .pluginAddedSuccess(plugin.name))),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.addPluginFailed)),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .addPluginFailedWithError(e.toString()))),
      );
    } finally {
      await _loadPlugins();
    }
  }

  // 添加新插件
  Future<void> _addNewPlugin() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // 创建一个新的插件条目
      final pluginService = ref.read(pluginManagerServiceProvider);
      final newPlugin = PluginEntry(
        id: const Uuid().v4(),
        name: _nameController.text,
        version: _versionController.text,
        url: _urlController.text,
               description: _descriptionController.text,
        isEnabled: true,
        pluginOrder: _plugins.length, // 使用当前插件列表长度作为顺序
      );

      // 保存插件条目
      await pluginService.addPlugin(newPlugin);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .pluginAddedSuccess(newPlugin.name))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .addPluginFailedWithError(e.toString()))),
      );
    } finally {
      await _loadPlugins();
    }
  }

  void _showAddPluginDialog() {
    // 重置控制器
    _nameController.text = '';
    _versionController.text = '1.0.0';
    _descriptionController.text = '';
    _urlController.text = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addPlugin),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.pluginName,
                  hintText: AppLocalizations.of(context)!.enterPluginName,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _versionController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.pluginVersion,
                  hintText: AppLocalizations.of(context)!.enterVersion,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.pluginUrl,
                  hintText: AppLocalizations.of(context)!.enterPluginUrl,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _addNewPlugin();
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add_link),
              title: Text(AppLocalizations.of(context)!.addPluginFromUrl),
              onTap: () {
                Navigator.of(context).pop();
                _addPluginFromUrl();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: Text(AppLocalizations.of(context)!.addPluginFromLocalFile),
              onTap: () {
                Navigator.of(context).pop();
                _addPluginFromLocal();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: Text(AppLocalizations.of(context)!.exportPluginList),
              onTap: () async {
                Navigator.of(context).pop();
                // 导出插件列表的逻辑
                final path = await FilePicker.platform.getDirectoryPath();
                if (path != null) {
                  final pluginService = ref.read(pluginManagerServiceProvider);
                  try {
                    await pluginService
                        .exportToFile('$path/plugins_export.json');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .pluginListExportSuccess)),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .exportPluginListFailed(e.toString()))),
                    );
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: Text(AppLocalizations.of(context)!.importPluginList),
              onTap: () async {
                Navigator.of(context).pop();
                // 导入插件列表的逻辑
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );

                if (result != null && result.files.single.path != null) {
                  final pluginService = ref.read(pluginManagerServiceProvider);
                  try {
                    final plugins = await pluginService
                        .importFromFile(result.files.single.path!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .importPluginSuccess(plugins.length.toString()))),
                    );
                    await _loadPlugins();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .importPluginListFailed(e.toString()))),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pluginManagement),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPluginDialog, // 直接调用添加插件对话框
            tooltip: AppLocalizations.of(context)!.addPlugin,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPlugins,
            tooltip: AppLocalizations.of(context)!.refresh,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showOptionsMenu,
            tooltip: AppLocalizations.of(context)!.moreOptions,
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
                      Text(AppLocalizations.of(context)!.noPlugins,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(AppLocalizations.of(context)!.addPlugin),
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
            // 添加全局操作选框
            Row(
              children: [
                Checkbox(
                  value: allEnabled,
                  onChanged: (value) {
                    if (value != null) {
                      // 全局启用/禁用插件的逻辑
                      final pluginService = ref.read(pluginManagerServiceProvider);
                      pluginService.toggleAllPluginsStatus(value).then((_) {
                        _loadPlugins(); // 重新加载插件列表
                        // 显示提示信息
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(value
                                  ? AppLocalizations.of(context)!
                                      .enableGlobalPlugins
                                  : AppLocalizations.of(context)!
                                      .disableGlobalPlugins)),
                        );
                      });
                    }
                  },
                ),
                Text(AppLocalizations.of(context)!.selectAll),
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
                      AppLocalizations.of(context)!.pluginService,
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
                _buildStatusItem(AppLocalizations.of(context)!.installed,
                    _plugins.length.toString()),
                _buildStatusItem(AppLocalizations.of(context)!.enabled,
                    enabledCount.toString()),
                _buildStatusItem(AppLocalizations.of(context)!.autoUpdate,
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
                        AppLocalizations.of(context)!.version(plugin.version),
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
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.autoUpdate),
                    Switch(
                      value: plugin.isAutoUpdate,
                      onChanged: (value) {
                        final updatedPlugin =
                            plugin.copyWith(isAutoUpdate: value);
                        final pluginService = ref.read(pluginManagerServiceProvider);
                        pluginService
                            .updatePlugin(updatedPlugin)
                            .then((_) => _loadPlugins());
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => _updatePlugin(plugin),
                      tooltip: AppLocalizations.of(context)!.updatePlugin,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePlugin(plugin),
                      tooltip: AppLocalizations.of(context)!.deletePlugin,
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
