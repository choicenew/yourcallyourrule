
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


import 'dart:core';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';

import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_blacklist.dart';

import 'blacklist_page.dart';

import 'import_blacklists.dart';



import '../../services/sms_text_service.dart';


class ExportSmsTextBlacklistsPageView extends StatelessWidget {
  const ExportSmsTextBlacklistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSmsTextBlacklistsPage, // 页面标题
      'SmsTextBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsTextBlacklistPageView(), // 点击卡片导航到的页面
      const ExportSmsTextBlacklistsPage(), // 当前页面主要内容
      exportPage: const ExportSmsTextBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsTextBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsTextBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}


class ExportSmsTextBlacklistsPage extends StatefulWidget {
  const ExportSmsTextBlacklistsPage({super.key});

  @override
  ExportSmsTextBlacklistsPageState createState() => ExportSmsTextBlacklistsPageState();
}

class ExportSmsTextBlacklistsPageState extends State<ExportSmsTextBlacklistsPage> {
  final _entries = <SmsTextBlacklistEntry>[];
  late SmsTextBlacklistService _smsTextBlacklistService;
  List<SmsTextBlacklistEntry>? _selectedEntries;


 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedEntries = []; // 初始化为空列表
     _smsTextBlacklistService = appState.smsTextBlacklistService; 
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)
  


  @override
  Widget build(BuildContext context) {
        final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }


  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<SmsTextBlacklistEntry>( // 使用泛型指定类型
      getEntries: appState.smsTextBlacklistService.getEntries,
      buildSelectDialog: (BuildContext context, List<SmsTextBlacklistEntry> entries) {
        //return SelectWhitelistEntriesDialog(entries: entries);
        return SelectEntriesDialog<SmsTextBlacklistEntry>(
  entries: entries,
  hasSubscriptionTabs: true,
  searchKey: 'keyword',
);
      },
      exportToCsv: appState.smsTextBlacklistService.exportToCsv,
      exportToJson: appState.smsTextBlacklistService.exportToJson,
    );
  }
}