import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import '../sms_no_whitelist/import_whitelists.dart';

import '../../services/sms_blacklist_whitelist_service.dart';

import 'add_whitelist.dart';

import 'whitelist_page.dart';

class ExportSmsWhitelistsPageView extends StatelessWidget {
  const ExportSmsWhitelistsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSmsWhitelistsPage, // 页面标题
      // 'SmsWhitelistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsWhitelistPageView(), // 点击卡片导航到的页面
      const ExportSmsWhitelistsPage(), // 当前页面主要内容
      exportPage: const ExportSmsWhitelistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsWhitelistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsWhitelistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportSmsWhitelistsPage extends StatefulWidget {
  const ExportSmsWhitelistsPage({super.key});

  @override
  ExportSmsWhitelistsPageState createState() => ExportSmsWhitelistsPageState();
}

class ExportSmsWhitelistsPageState extends State<ExportSmsWhitelistsPage> {
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
    return ExportScreenWidget<SmsWhitelistEntry>(
      // 使用泛型指定类型
      getEntries: appState.smsWhitelistService.getEntries,
      buildSelectDialog:
          (BuildContext context, List<SmsWhitelistEntry> entries) {
        //return SelectWhitelistEntriesDialog(entries: entries);
        return SelectEntriesDialog<SmsWhitelistEntry>(
          entries: entries,
          hasSubscriptionTabs: true,
          //searchKey: 'phoneNumber',
          getSearchString: (entry) => entry.phoneNumber, //  提供 Getter 函数
        );
      },
      exportToCsv: appState.smsWhitelistService.exportToCsv,
      exportToJson: appState.smsWhitelistService.exportToJson,
    );
  }
}
