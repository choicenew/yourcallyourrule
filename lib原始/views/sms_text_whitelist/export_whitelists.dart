import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';

import '../../services/sms_text_service.dart';
import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_whitelist.dart';
import 'import_whitelists.dart';
import 'whitelist_page.dart';

class ExportSmsTextWhitelistsPageView extends StatelessWidget {
  const ExportSmsTextWhitelistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSmsTextWhitelistsPage, // 页面标题
      //  'SmsTextWhitelistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsTextWhitelistPageView(), // 点击卡片导航到的页面
      const ExportSmsTextWhitelistsPage(), // 当前页面主要内容
      exportPage: const ExportSmsTextWhitelistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsTextWhitelistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsTextWhitelistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportSmsTextWhitelistsPage extends StatefulWidget {
  const ExportSmsTextWhitelistsPage({super.key});

  @override
  ExportSmsTextWhitelistsPageState createState() =>
      ExportSmsTextWhitelistsPageState();
}

class ExportSmsTextWhitelistsPageState
    extends State<ExportSmsTextWhitelistsPage> {
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
    return ExportScreenWidget<SmsTextWhitelistEntry>(
      // 使用泛型指定类型
      getEntries: appState.smsTextWhitelistService.getEntries,
      buildSelectDialog:
          (BuildContext context, List<SmsTextWhitelistEntry> entries) {
        //return SelectWhitelistEntriesDialog(entries: entries);
        return SelectEntriesDialog<SmsTextWhitelistEntry>(
          entries: entries,
          hasSubscriptionTabs: true,
          // searchKey: 'keyword',
          getSearchString: (entry) => entry.keyword, //  提供 Getter 函数
        );
      },
      exportToCsv: appState.smsTextWhitelistService.exportToCsv,
      exportToJson: appState.smsTextWhitelistService.exportToJson,
    );
  }
}
