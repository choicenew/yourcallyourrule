
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



import '../../generated/l10n.dart';

import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';



import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_blocked_entry.dart';
import 'blocked_page.dart';

import 'import_blocked_entries.dart';

class ExportBlockedEntriesPageView extends StatelessWidget {
  const ExportBlockedEntriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportBlockedPage, // 当前页面标题
     // 'BlockedPageView', //要=createcard 这个不要修改-卡片标题=点击卡片导航到的页面
      const BlockedPageView(), // create card卡片导航到的页面
      const ExportBlockedEntriesPage(), // 当前页面主要内容
      //下面分别是导出，添加，导入
      exportPage: const ExportBlockedEntriesPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字//不要动
      addPage: const AddBlockedEntryPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字 //不要动
      importPage: const ImportBlockedEntriesPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字 //不要动
    );
  }
}

class ExportBlockedEntriesPage extends StatefulWidget {
  const ExportBlockedEntriesPage({super.key});

  @override
  ExportBlockedEntriesPageState createState() =>
      ExportBlockedEntriesPageState();
}

class ExportBlockedEntriesPageState extends State<ExportBlockedEntriesPage> {

  



 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);


  }


  @override
  Widget build(BuildContext context) {
        final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<BlockedEntry>( // 使用泛型指定类型
      getEntries: appState.blockedService.getEntries,
      buildSelectDialog: (BuildContext context, List<BlockedEntry> entries) {
        //return SelectBlacklistEntriesDialog(entries: entries);
        return SelectEntriesDialog<BlockedEntry>(
  entries: entries,
  hasSubscriptionTabs: false,
 // searchKey: 'phoneNumber',
   getSearchString: (entry) => entry.phoneNumber, //  提供 Getter 函数
);
      },
      exportToCsv: appState.blockedService.exportToCsv,
      exportToJson: appState.blockedService.exportToJson,
    );
  }
}

