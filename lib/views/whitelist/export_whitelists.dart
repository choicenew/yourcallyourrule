import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../../services/blacklist_whitelist_service.dart';
import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_whitelist.dart';
import 'import_whitelists.dart';
import 'whitelist_page.dart';

class ExportWhitelistsPageView extends StatelessWidget {
  const ExportWhitelistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportWhitelistsPage, // 页面标题
      'WhitelistPageView', // 卡片标题=点击卡片导航到的页面
      const WhitelistPageView(), // 点击卡片导航到的页面
      const ExportWhitelistsPage(), // 当前页面主要内容
      exportPage: const ExportWhitelistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddWhitelistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportWhitelistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportWhitelistsPage extends StatefulWidget {
  const ExportWhitelistsPage({super.key});

  @override
  ExportWhitelistsPageState createState() => ExportWhitelistsPageState();
}

class ExportWhitelistsPageState extends State<ExportWhitelistsPage> {
  final _entries = <WhitelistEntry>[];
  List<WhitelistEntry>? _selectedEntries;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedEntries = []; // 初始化为空列表
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<WhitelistEntry>(
      // 使用泛型指定类型
      getEntries: appState.whitelistService.getEntries,
      buildSelectDialog: (BuildContext context, List<WhitelistEntry> entries) {
        //return SelectWhitelistEntriesDialog(entries: entries);
        return SelectEntriesDialog<WhitelistEntry>(
          entries: entries,
          hasSubscriptionTabs: true,
          searchKey: 'phoneNumber',
        );
      },
      exportToCsv: appState.whitelistService.exportToCsv,
      exportToJson: appState.whitelistService.exportToJson,
    );
  }
}
