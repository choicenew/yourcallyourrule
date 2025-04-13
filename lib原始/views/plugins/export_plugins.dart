import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

import '../../screens/appstate_provider.dart';
import '../../services/plugin_manager_service.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_plugin.dart';

import 'import_plugins.dart';

import 'plugins_page.dart';

class ExportPluginsPageView extends StatelessWidget {
  const ExportPluginsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportPluginPage, // 页面标题
      //  'PluginsPageView', // 卡片标题=点击卡片导航到的页面
      const PluginsPageView(), // 点击卡片导航到的页面
      const ExportPluginsPage(), // 当前页面主要内容
      exportPage: const ExportPluginsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddPluginPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportPluginsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportPluginsPage extends StatefulWidget {
  const ExportPluginsPage({super.key});

  @override
  ExportPluginsPageState createState() => ExportPluginsPageState();
}

class ExportPluginsPageState extends State<ExportPluginsPage> {
  @override
  void initState() {
    super.initState();
  //  final appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<Plugin>(
      // 使用泛型指定类型
      getEntries: appState.pluginService.getAllPlugins,
      buildSelectDialog: (BuildContext context, List<Plugin> plugins) {
        return SelectEntriesDialog<Plugin>(
          entries: plugins,
          hasSubscriptionTabs: false,
          // searchKey: 'name',
          getSearchString: (entry) => entry.name, //  提供 Getter 函数
        );
      },
      exportToCsv: appState.pluginService.exportPluginsToCsv,
      exportToJson: appState.pluginService.exportPluginsToJson,
    );
  }
}
