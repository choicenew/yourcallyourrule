import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';

class PluginManagementPage extends StatefulWidget {
  const PluginManagementPage({Key? key}) : super(key: key);

  @override
  State<PluginManagementPage> createState() => _PluginManagementPageState();
}

class _PluginManagementPageState extends State<PluginManagementPage> {
  List<PluginEntry> _plugins = [];
  bool _isLoading = true;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlugins();
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadPlugins() async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = Provider.of<PluginManagerService>(context, listen: false);
    try {
      final plugins = await pluginService.getAll();
      setState(() {
        _plugins = plugins;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载插件失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _togglePluginStatus(PluginEntry plugin, bool isEnabled) async {
    final pluginService = Provider.of<PluginManagerService>(context, listen: false);
    try {
      await pluginService.togglePluginStatus(plugin, isEnabled);
      await _loadPlugins(); // 重新加载插件列表
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更改插件状态失败: $e')),
      );
    }
  }

  Future<void> _updatePlugin(PluginEntry plugin) async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = Provider.of<PluginManagerService>(context, listen: false);
    try {
      final updated = await pluginService.updatePluginFromUrl(plugin);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(updated ? '插件更新成功' : '插件已是最新版本')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('更新插件失败: $e')),
      );
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _deletePlugin(PluginEntry plugin) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除插件'),
        content: Text('确定要删除插件 "${plugin.name}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final pluginService = Provider.of<PluginManagerService>(context, listen: false);
      try {
        await pluginService.deletePlugin(plugin);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('插件已删除')),
        );
        await _loadPlugins();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('删除插件失败: $e')),
        );
      }
    }
  }

  Future<void> _addPluginFromUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的URL')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final pluginService = Provider.of<PluginManagerService>(context, listen: false);
    try {
      final plugin = await pluginService.addPluginFromUrl(url);
      if (plugin != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('插件 "${plugin.name}" 添加成功')),
        );
        _urlController.clear();
        Navigator.of(context).pop(); // 关闭对话框
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('添加插件失败')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('添加插件失败: $e')),
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

        final pluginService = Provider.of<PluginManagerService>(context, listen: false);
        final plugin = await pluginService.addPluginFromLocal(result.files.single.path!);

        if (plugin != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('插件 "${plugin.name}" 添加成功')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('添加插件失败')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('添加插件失败: $e')),
      );
    } finally {
      await _loadPlugins();
    }
  }

  void _showAddPluginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加插件'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: '插件URL',
                hintText: '输入插件的URL地址',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: _addPluginFromUrl,
            child: const Text('添加'),
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
              title: const Text('从URL添加插件'),
              onTap: () {
                Navigator.of(context).pop();
                _showAddPluginDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text('从本地文件添加插件'),
              onTap: () {
                Navigator.of(context).pop();
                _addPluginFromLocal();
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_download),
              title: const Text('导出插件列表'),
              onTap: () async {
                Navigator.of(context).pop();
                // 导出插件列表的逻辑
                final path = await FilePicker.platform.getDirectoryPath();
                if (path != null) {
                  final pluginService = Provider.of<PluginManagerService>(context, listen: false);
                  try {
                    await pluginService.exportToFile('$path/plugins_export.json');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('插件列表导出成功')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('导出插件列表失败: $e')),
                    );
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text('导入插件列表'),
              onTap: () async {
                Navigator.of(context).pop();
                // 导入插件列表的逻辑
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['json'],
                );

                if (result != null && result.files.single.path != null) {
                  final pluginService = Provider.of<PluginManagerService>(context, listen: false);
                  try {
                    final plugins = await pluginService.importFromFile(result.files.single.path!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('成功导入${plugins.length}个插件')),
                    );
                    await _loadPlugins();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('导入插件列表失败: $e')),
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
        title: const Text('插件管理'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddPluginDialog,
            tooltip: '添加插件',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showOptionsMenu,
            tooltip: '更多选项',
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
                      const Icon(Icons.extension_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('暂无插件', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('添加插件'),
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
                    ..._plugins.map(_buildPluginCard).toList(),
                  ],
                ),
    );
  }

  Widget _buildPluginStatusCard() {
    final enabledCount = _plugins.where((p) => p.isEnabled).length;
    final autoUpdateCount = _plugins.where((p) => p.isAutoUpdate).length;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.extension, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 8),
                    const Text(
                      '插件服务',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Switch(
                  value: _plugins.isNotEmpty && enabledCount > 0,
                  onChanged: (value) {
                    // 全局启用/禁用插件的逻辑
                    // 这里简化处理，实际可能需要更复杂的逻辑
                    for (final plugin in _plugins) {
                      _togglePluginStatus(plugin, value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusItem('已安装', _plugins.length.toString()),
                _buildStatusItem('已启用', enabledCount.toString()),
                _buildStatusItem('自动更新', autoUpdateCount.toString()),
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
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '版本: ${plugin.version}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                    const Text('自动更新'),
                    Switch(
                      value: plugin.isAutoUpdate,
                      onChanged: (value) {
                        final updatedPlugin = plugin.copyWith(isAutoUpdate: value);
                        final pluginService = Provider.of<PluginManagerService>(context, listen: false);
                        pluginService.updatePlugin(updatedPlugin).then((_) => _loadPlugins());
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () => _updatePlugin(plugin),
                      tooltip: '更新插件',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePlugin(plugin),
                      tooltip: '删除插件',
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