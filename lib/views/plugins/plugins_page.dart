
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/plugin_manager_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/responsive_grid_list.dart';


import 'add_plugin.dart';
import 'export_plugins.dart';
import 'import_plugins.dart';

class PluginsPageView extends StatelessWidget {
  const PluginsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).pluginPage, // 页面标题
      //'PluginsPageView', // 卡片标题=点击卡片导航到的页面
      const PluginsPageView(), // 点击卡片导航到的页面
      const PluginsPage(), // 当前页面主要内容
      exportPage: const ExportPluginsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddPluginPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportPluginsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class PluginsPage extends StatefulWidget {
  const PluginsPage({super.key});

  @override
  PluginsPageState createState() => PluginsPageState();
}

class PluginsPageState extends State<PluginsPage> with WidgetsBindingObserver {
  late PluginService _pluginService;
  Map<String, bool> _expandedItems = {};
  List<Plugin> _plugins = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeServices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadPlugins();
    }
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);

    _pluginService = appState.pluginService;
    _loadPlugins();
  }

  Future<void> _loadPlugins() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final plugins =
          await _pluginService.getAllPlugins(orderBy: 'id', ascending: true);
      setState(() {
        _plugins = plugins;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadPlugins,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : AdvancedSelfManagedSearchBar<Plugin>(
                items: _plugins,
                itemBuilder: (context, plugin, width) =>
                    _buildPluginItem(plugin, width),
                getSearchString: (plugin) =>
                    '${plugin.id} ${plugin.pluginOrder} ${plugin.name}',
                getSortFields: (plugin) => ['ID', 'Order', 'Name'],
                getSortFieldValues: (plugin) =>
                    [plugin.id, plugin.pluginOrder, plugin.name],
                originalBuilder: (context, items) => _build(context),
                //adBuilder: (width, height) => nativeAdWidgetSmall(adWidth: width, adHeight: height),
                // 添加回调函数
              ),
      ),
    );
  }

// 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return buildResponsiveGridList(
        _plugins, _buildPluginItem, adState.isAdEnabled);
  }

  Widget _buildPluginItem(Plugin plugin, double pluginWidth) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: ValueKey(plugin.id),
        initiallyExpanded: _expandedItems[plugin.id] ?? false,
        onExpansionChanged: (isExpanded) {
          _expandedItems[plugin.id] = isExpanded;
        },
        title: SubscriptionTitleWidget(name: plugin.name),
        subtitle: Row(
          children: [
            SubscriptionUrlWidget(url: plugin.url),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoUpdateButtonWidget(
              isAutoUpdate: plugin.isAutoUpdate,
              onPressed: () async {
                if (plugin.isAutoUpdate) {
                  await _pluginService.manualUpdatePlugin(plugin);
                }
                setState(() {
                  plugin.isAutoUpdate = !plugin.isAutoUpdate;
                });
              },
            ),
    
            EnableDisableButtonWidget(
              isEnabled: plugin.enabled,
              onPressed: () async {
            

                await _toggleSubscriptionEnabled(plugin);

                setState(() {
                 // plugin.enabled = !plugin.enabled;
                });
              },
            ),
            
/*
EnableDisableButtonWidget<Plugin>(
  isEnabled: plugin.enabled,
  item: plugin, // 传递 plugin 对象
  onToggle: (context, pattern) async {
    setState(() {
      plugin.enabled = !plugin.enabled;
    });
    await _toggleSubscriptionEnabled(plugin);
  },
),
*/
            const SizedBox(width: 8),
            DeleteButtonWidget(
              onPressed: () => _showDeleteConfirmation(context, plugin),
            ),
            ExpansionIconWidget(isExpanded: _expandedItems[plugin.id] ?? false),
          ],
        ),
        children: [
          _buildExpandedContent(context, plugin),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context, Plugin plugin) {
    final TextEditingController nameController =
        TextEditingController(text: plugin.name);
    //新增加的url 路径
    final TextEditingController urlController =
        TextEditingController(text: plugin.url);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          NameInputWidget(
            nameController: nameController,
          ),
          const SizedBox(height: 10.0),
          UrlInputWidget(
            urlController: urlController,
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          SubscriptionAutoUpdateSwitchWidget(
            isAutoUpdate: plugin.isAutoUpdate,
            onChanged: (bool newValue) async {
              plugin.isAutoUpdate = newValue;
              if (newValue) {
                await _pluginService.autoUpdatePlugin(plugin);
              }
              setState(() {});
            },
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButtonWidget(
                icon: NewSet.delete,
                label: S.of(context).delete,
                onPressed: () => _showDeleteConfirmation(context, plugin),
                pressedColor: Colors.red,
              ),
              ActionButtonWidget(
                icon: NewSet.delete,
                label: S.of(context).editCode,
                onPressed: () => _showEditCodeDialog(plugin),
                pressedColor: Colors.red,
              ),
              ActionButtonWidget(
                icon: NewSet.check,
                label: S.of(context).save,
                onPressed: () =>
                    _saveEntry(plugin, nameController.text, urlController.text),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, Plugin plugin) async {
    showDeleteConfirmationDialog<Plugin>(
      context,
      plugin,
      _pluginService.deletePlugin,
      displayText: plugin.id.toString(),
    );
    await _loadPlugins();
  }

// 在 PluginsPageState 中定义一个新的方法
  Future<void> _toggleSubscriptionEnabled(Plugin plugin) async {
    plugin.enabled = !plugin.enabled;
 await _pluginService.editPlugin(plugin);

  if (plugin.enabled) {
    await _pluginService.enablePlugin(plugin);
  } else {
    await _pluginService.disablePlugin(plugin);
  }
   // setState(() {});
  }



// ... 其他代码 ...

  Future<void> _showEditCodeDialog(Plugin plugin) async {
    final scriptPath = await plugin.getScriptPath();
    final initialCode = await File(scriptPath).readAsString();
    final TextEditingController codeController =
        TextEditingController(text: initialCode);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).editPluginCode),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: codeController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: S.of(context).enterPluginCodeHere,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(S.of(context).save),
              onPressed: () async {
                // 保存修改后的脚本到文件
                await File(scriptPath).writeAsString(codeController.text);

                // 重新加载脚本
                await _pluginService.loadScriptFromFile(plugin);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

// ... 其他代码 ...


  Future<void> _updatePlugin(Plugin plugin, String name, String url) async {
    final updatedPlugin = Plugin(
      id: plugin.id,
      name: name,
      url: url,
      version: plugin.version,
      enabled: plugin.enabled,
      pluginOrder: plugin.pluginOrder,
      isAutoUpdate: plugin.isAutoUpdate,
    );

    await _pluginService.editPlugin(updatedPlugin);

    if (plugin.enabled) {
      await _pluginService.enablePlugin(updatedPlugin);
    } else {
      await _pluginService.disablePlugin(updatedPlugin);
    }
  }

  void _saveEntry(Plugin plugin, String name, String url) async {
    await _updatePlugin(plugin, name, url);

    await _loadPlugins();
    setState(() {
      _expandedItems[plugin.id] = false;
    });
  }

  ///
}
