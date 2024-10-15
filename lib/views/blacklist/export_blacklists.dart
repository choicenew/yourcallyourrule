import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';

import '../../screens/appstate_provider.dart';
import '../../services/blacklist_whitelist_service.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_blacklist.dart';

import 'blacklist_page.dart';

import 'import_blacklists.dart';

class ExportBlacklistsPageView extends StatelessWidget {
  const ExportBlacklistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportBlacklistPage, // 当前页面标题
      'BlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const BlacklistPageView(), // create card卡片导航到的页面
      const ExportBlacklistsPage(), // 当前页面主要内容
      exportPage: const ExportBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字//不要动
      addPage: const AddBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字 //不要动
      importPage: const ImportBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字 //不要动
    );
  }
}

class ExportBlacklistsPage extends StatefulWidget {
  const ExportBlacklistsPage({super.key});

  @override
  ExportBlacklistsPageState createState() => ExportBlacklistsPageState();
}

class ExportBlacklistsPageState extends State<ExportBlacklistsPage> {
  final _entries = <BlacklistEntry>[];
  late BlacklistService _blacklistService;
  List<BlacklistEntry>? _selectedEntries;


  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedEntries = []; // 初始化为空列表
    _blacklistService = appState.blacklistService;
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<BlacklistEntry>(
      // 使用泛型指定类型
      getEntries: appState.blacklistService.getEntries,
      buildSelectDialog: (BuildContext context, List<BlacklistEntry> entries) {
        //return SelectBlacklistEntriesDialog(entries: entries);
        return SelectEntriesDialog<BlacklistEntry>(
          entries: entries,
          hasSubscriptionTabs: true,
          searchKey: 'phoneNumber',
        );
      },
      exportToCsv: appState.blacklistService.exportToCsv,
      exportToJson: appState.blacklistService.exportToJson,
    );
  }
}
