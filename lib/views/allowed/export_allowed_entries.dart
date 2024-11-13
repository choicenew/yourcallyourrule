
import 'dart:core';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_allowed_entry.dart';
import 'allowed_page.dart';

import 'import_allowed_entries.dart';

class ExportAllowedEntriesPageView extends StatelessWidget {
  const ExportAllowedEntriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportAllowedEntryPage, // 页面标题
     // 'AllowedPageView', // 卡片标题=点击卡片导航到的页面
      const AllowedPageView(), // 点击卡片导航到的页面
      const ExportAllowedEntriesPage(), // 当前页面主要内容
      exportPage: const ExportAllowedEntriesPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddAllowedEntryPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportAllowedEntriesPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportAllowedEntriesPage extends StatefulWidget {
  const ExportAllowedEntriesPage({super.key});

  @override
  ExportAllowedEntriesPageState createState() =>
      ExportAllowedEntriesPageState();
}

class ExportAllowedEntriesPageState extends State<ExportAllowedEntriesPage> {
  //final _entries = <AllowedEntry>[];

  late AllowedService _allowedService;
  List<AllowedEntry>? _selectedEntries;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);

    _allowedService = appState.allowedService;
    _selectedEntries = []; // 初始化为空列表
  }

 // String? _filePath;
 // String _selectedType = 'csv'; // Default export format (CSV)

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<AllowedEntry>(
      // 使用泛型指定类型
      getEntries: appState.allowedService.getEntries,
      buildSelectDialog: (BuildContext context, List<AllowedEntry> entries) {
        //return SelectBlacklistEntriesDialog(entries: entries);
        return SelectEntriesDialog<AllowedEntry>(
          entries: entries,
          hasSubscriptionTabs: false,
          searchKey: 'phoneNumber',
        );
      },
      exportToCsv: appState.allowedService.exportToCsv,
      exportToJson: appState.allowedService.exportToJson,
    );
  }
}
