
import 'dart:core';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



import '../../generated/l10n.dart';

import '../../screens/appstate_provider.dart';
import '../../services/sms_blacklist_whitelist_service.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_blacklist.dart';
import 'blacklist_page.dart';
import 'import_blacklists.dart';


class ExportSmsBlacklistsPageView extends StatelessWidget {
  const ExportSmsBlacklistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSmsBlacklistsPage, // 页面标题
      'SmsBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsBlacklistPageView(), // 点击卡片导航到的页面
      const ExportSmsBlacklistsPage(), // 当前页面主要内容
      exportPage: const ExportSmsBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}


class ExportSmsBlacklistsPage extends StatefulWidget {
  const ExportSmsBlacklistsPage({super.key});

  @override
  ExportSmsBlacklistsPageState createState() => ExportSmsBlacklistsPageState();
}

class ExportSmsBlacklistsPageState extends State<ExportSmsBlacklistsPage> {
  final _entries = <SmsBlacklistEntry>[];
  late SmsBlacklistService _smsBlacklistService;
  List<SmsBlacklistEntry>? _selectedEntries;


 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedEntries = []; // 初始化为空列表
     _smsBlacklistService = appState.smsBlacklistService; 
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)
  


  @override
  Widget build(BuildContext context) {
        final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }


  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<SmsBlacklistEntry>( // 使用泛型指定类型
      getEntries: appState.smsBlacklistService.getEntries,
      buildSelectDialog: (BuildContext context, List<SmsBlacklistEntry> entries) {
        //return SelectWhitelistEntriesDialog(entries: entries);
        return SelectEntriesDialog<SmsBlacklistEntry>(
  entries: entries,
  hasSubscriptionTabs: true,
  searchKey: 'phoneNumber',
);
      },
      exportToCsv: appState.smsBlacklistService.exportToCsv,
      exportToJson: appState.smsBlacklistService.exportToJson,
    );
  }
}