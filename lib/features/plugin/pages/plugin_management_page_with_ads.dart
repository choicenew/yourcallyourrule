import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_test_page.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_script_editor_page.dart';
import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_url_webview_page.dart';
import 'package:yourcallyourrule/presentation/test.dart';
import 'package:yourcallyourrule/features/plugin/presentation/pages/plugin_settings_dialog.dart';
import 'package:yourcallyourrule/core/provider/providers/plugin_service_provider.dart';

/// 使用GenericListWithAdsPage的插件管理页面
/// 集成了广告功能
class PluginManagementPageWithAds extends ConsumerStatefulWidget {
  const PluginManagementPageWithAds({super.key});

  @override
  ConsumerState<PluginManagementPageWithAds> createState() =>
      _PluginManagementPageWithAdsState();
}

class _PluginManagementPageWithAdsState
    extends ConsumerState<PluginManagementPageWithAds> {
  List<PluginEntry> _plugins = [];
  bool _isLoading = true;
  String _searchKeyword = '';
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Set<String> _selectedPluginIds = {};
  bool _isMultiSelectMode = false;

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

  void _onToggleItemSelection(String pluginId) {
    setState(() {
      if (_selectedPluginIds.contains(pluginId)) {
        _selectedPluginIds.remove(pluginId);
      } else {
        _selectedPluginIds.add(pluginId);
      }
    });
  }

  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedPluginIds.clear();
      }
    });
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadPlugins();
  }

  Future<void> _loadPlugins() async {
    setState(() {
      _isLoading = true;
    });

    final pluginService = ref.read(pluginManagerServiceProvider);
    try {
      var plugins = await pluginService.getAll();
      if (_searchKeyword.isNotEmpty) {
        plugins =
            plugins
                .where(
                  (p) =>
                      p.name.toLowerCase().contains(
                        _searchKeyword.toLowerCase(),
                      ) ||
                      p.description.toLowerCase().contains(
                        _searchKeyword.toLowerCase(),
                      ),
                )
                .toList();
      }
      setState(() {
        _plugins = plugins;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.loadPluginsFailed(e.toString()),
          ),
        ),
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
          content: Text(
            AppLocalizations.of(
              context,
            )!.changePluginStatusFailed(e.toString()),
          ),
        ),
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
          content: Text(
            updated
                ? AppLocalizations.of(context)!.pluginUpdateSuccess
                : AppLocalizations.of(context)!.pluginLatestVersion,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.updatePluginFailed(e.toString()),
          ),
        ),
      );
    } finally {
      await _loadPlugins();
    }
  }

  Future<void> _deletePlugin(PluginEntry plugin) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.deletePlugin),
            content: Text(
              AppLocalizations.of(context)!.confirmDeletePlugin(plugin.name),
            ),
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
            content: Text(
              AppLocalizations.of(context)!.deletePluginFailed(e.toString()),
            ),
          ),
        );
      }
    }
  }

  Future<void> _addPluginFromUrl() async {
    // 显示添加插件URL对话框
    _urlController.clear();
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.addPluginFromUrl),
            content: TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.pluginUrl,
                hintText: AppLocalizations.of(context)!.enterPluginUrl,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancelButton),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.add),
              ),
            ],
          ),
    );

    if (confirmed == true) {
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
              content: Text(
                AppLocalizations.of(context)!.pluginAddedSuccess(plugin.name),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.addPluginFailed),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.addPluginFailedWithError(e.toString()),
            ),
          ),
        );
      } finally {
        await _loadPlugins();
      }
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
        final plugin = await pluginService.addPluginFromLocal(
          result.files.single.path!,
        );

        if (plugin != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.pluginAddedSuccess(plugin.name),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.addPluginFailed),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.addPluginFailedWithError(e.toString()),
          ),
        ),
      );
    } finally {
      await _loadPlugins();
    }
  }

  // 添加新插件
  Future<void> _addNewPlugin(bool manualEntry) async {
    final pluginService = ref.read(pluginManagerServiceProvider);
    setState(() {
      _isLoading = true;
    });

    try {
      if (manualEntry) {
        // 手动输入模式
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.pluginAddedSuccess(newPlugin.name),
            ),
          ),
        );
      } else {
        // URL模式
        final url = _urlController.text.trim();
        if (url.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.enterValidUrl),
            ),
          );
          return;
        }
        final plugin = await pluginService.addPluginFromUrl(url);
        if (plugin != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.pluginAddedSuccess(plugin.name),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.addPluginFailed),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.addPluginFailedWithError(e.toString()),
          ),
        ),
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
    bool manualEntry = false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.addPlugin),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _urlController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.pluginUrl,
                            hintText:
                                AppLocalizations.of(context)!.enterPluginUrl,
                          ),
                        ),
                        SwitchListTile(
                          // secondary 属性用来放图标
                          secondary: Icon(
                            Icons.keyboard_sharp,
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.primary, // 给图标一点颜色
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.manualEntry,
                          ),
                          value: manualEntry,
                          onChanged: (bool value) {
                            setState(() {
                              manualEntry = value;
                            });
                          },
                        ),
                        if (manualEntry) ...[
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.pluginName,
                              hintText:
                                  AppLocalizations.of(context)!.enterPluginName,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _versionController,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context)!.pluginVersion,
                              hintText:
                                  AppLocalizations.of(context)!.enterVersion,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(
                                    context,
                                  )!.pluginDescription,
                              hintText:
                                  AppLocalizations.of(
                                    context,
                                  )!.enterPluginDescription,
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        nativeAdWidgetMedium(adWidth: 400, adHeight: 320),
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
                        _addNewPlugin(manualEntry);
                      },
                      child: Text(AppLocalizations.of(context)!.add),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
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
                  title: Text(
                    AppLocalizations.of(context)!.addPluginFromLocalFile,
                  ),
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
                      final pluginService = ref.read(
                        pluginManagerServiceProvider,
                      );
                      try {
                        await pluginService.exportToFile(
                          '$path/plugins_export.json',
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.pluginListExportSuccess,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.exportPluginListFailed(e.toString()),
                            ),
                          ),
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
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['json'],
                        );

                    if (result != null && result.files.single.path != null) {
                      final pluginService = ref.read(
                        pluginManagerServiceProvider,
                      );
                      try {
                        final plugins = await pluginService.importFromFile(
                          result.files.single.path!,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.importPluginSuccess(plugins.length.toString()),
                            ),
                          ),
                        );
                        await _loadPlugins();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.importPluginListFailed(e.toString()),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
                // 添加访问插件URL的选项
                ListTile(
                  leading: const Icon(Icons.public),
                  title: Text(AppLocalizations.of(context)!.pluginUrl),
                  onTap: () {
                    Navigator.of(context).pop();
                    // 导航到插件URL访问页面
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PluginUrlWebViewPage(),
                      ),
                    );
                  },
                ),

                // 单个插件测试
                ListTile(
                  leading: const Icon(Icons.science_outlined),
                  title: Text(
                    AppLocalizations.of(context)!.pluginTestPageTitle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // 导航到插件URL访问页面
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const TestPage()),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  // 构建广告项
  Widget _buildAdItem() {
    return GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd);
  }

  // 构建插件状态卡片（作为headerContent）
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.extension,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.pluginService,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusItem(
                  AppLocalizations.of(context)!.installed,
                  _plugins.length.toString(),
                ),
                _buildStatusItem(
                  AppLocalizations.of(context)!.enabled,
                  enabledCount.toString(),
                ),
                _buildStatusItem(
                  AppLocalizations.of(context)!.autoUpdate,
                  autoUpdateCount.toString(),
                ),
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
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  // 构建插件卡片
  Widget _buildPluginCard(PluginEntry plugin) {
    final isSelected = _selectedPluginIds.contains(plugin.id);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  plugin.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => _updatePlugin(plugin),
                    tooltip: AppLocalizations.of(context)!.updatePlugin,
                  ),
                  Switch(
                    value: plugin.isEnabled,
                    onChanged: (value) => _togglePluginStatus(plugin, value),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context)!.pluginVersion}: ${plugin.version}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  if (plugin.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.description}: ${plugin.description}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                  if (plugin.url.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _accessPluginUrl(plugin),
                      child: Text(
                        'Url: ${plugin.url}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(AppLocalizations.of(context)!.autoUpdate),
                          Switch(
                            value: plugin.isAutoUpdate,
                            onChanged: (value) {
                              final updatedPlugin = plugin.copyWith(
                                isAutoUpdate: value,
                              );
                              final pluginService = ref.read(
                                pluginManagerServiceProvider,
                              );
                              pluginService
                                  .updatePlugin(updatedPlugin)
                                  .then((_) => _loadPlugins());
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.science_outlined),
                            onPressed: () => _testPlugin(plugin),
                            tooltip: AppLocalizations.of(context)!.testPlugin,
                          ),
                          if (plugin.url.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.public),
                              onPressed: () => _accessPluginUrl(plugin),
                              tooltip:
                                  AppLocalizations.of(context)!.accessTargetUrl,
                            ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editPluginScript(plugin),
                            tooltip: AppLocalizations.of(context)!.editScript,
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => _openSettings(plugin),
                            tooltip: 'Settings',
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
          ],
        ),
      ),
    );
  }

  Future<void> _openSettings(PluginEntry plugin) async {
    final invokerService = ref.read(pluginServiceProvider);
    final newConfig = await showDialog<Map<String, dynamic>>(
      context: context,
      builder:
          (context) => PluginSettingsDialog(
            plugin: plugin,
            invokerService: invokerService,
          ),
    );

    if (newConfig != null && mounted) {
      final updatedPlugin = plugin.copyWith(config: newConfig);
      final pluginService = ref.read(pluginManagerServiceProvider);
      try {
        await pluginService.updatePlugin(updatedPlugin);
        await _loadPlugins();
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Settings saved')));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save settings: $e')),
          );
        }
      }
    }
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.pluginManagementSubtitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(AppLocalizations.of(context)!.pluginRulesInfo),
          ],
        ),
      ),
    );
  }

  void _editPluginScript(PluginEntry plugin) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PluginScriptEditorPage(plugin: plugin),
      ),
    );
  }

  // 测试单个插件
  void _testPlugin(PluginEntry plugin) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PluginTestPage(plugin: plugin)),
    );
  }

  // 访问插件URL
  void _accessPluginUrl(PluginEntry plugin) {
    // 传递整个plugin对象，而不仅仅是plugin.url
    // 这样PluginUrlWebViewPage可以提取插件内部的targetSearchUrl
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PluginUrlWebViewPage(plugin: plugin),
      ),
    );
  }

  // 处理多选删除插件
  Future<void> _deleteSelectedPlugins() async {
    final selectedPlugins =
        _plugins.where((p) => _selectedPluginIds.contains(p.id)).toList();
    if (selectedPlugins.isEmpty) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.deletePlugins),
            content: Text(
              AppLocalizations.of(
                context,
              )!.confirmDeletePlugins(selectedPlugins.length),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.of(context)!.cancelButton),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  AppLocalizations.of(context)!.deleteButton,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      try {
        final pluginService = ref.read(pluginManagerServiceProvider);
        for (final plugin in selectedPlugins) {
          await pluginService.deletePlugin(plugin);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.pluginsDeleted(selectedPlugins.length),
            ),
          ),
        );
        await _loadPlugins();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.deletePluginsFailed(e.toString()),
            ),
          ),
        );
      } finally {
        setState(() {
          _selectedPluginIds.clear();
          _isMultiSelectMode = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 使用GenericListWithAdsPage构建页面
    return GenericListWithAdsPage<PluginEntry>(
      title: AppLocalizations.of(context)!.pluginManagement,
      items: _plugins,
      itemBuilder: (context, plugin) => _buildPluginCard(plugin),
      adBuilder: _buildAdItem,
      adInterval: 3, // 每3个插件显示一个广告
      emptyText: AppLocalizations.of(context)!.noPlugins,
      emptyIcon: Icons.extension_off,
      emptyActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addPlugin),
        onPressed: _showAddPluginDialog,
      ),
      themeColor: Color.fromRGBO(
        255,
        Random().nextInt(180),
        Random().nextInt(50),
        0.8,
      ),
      isLoading: _isLoading,
      onRefresh: _loadPlugins,
      onAdd: _showAddPluginDialog,
      onMoreOptions: _showOptionsMenu,
      onMultiSelect: (selectedPlugins) {},
      getItemId: (plugin) => plugin.id,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedPluginIds,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onDeleteSelected: _deleteSelectedPlugins,
      onToggleItemSelection: _onToggleItemSelection,
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchPluginsHint,
      headerContent: _buildPluginStatusCard(),
      infoCard: _buildInfoCard(),
    );
  }
}
