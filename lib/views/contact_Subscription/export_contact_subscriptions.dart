import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../../services/subscribe_contacts_service.dart';
import '../contact_Subscription/contact_page.dart';
import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_contact_subscription.dart';
import 'import_contact_subscriptions.dart';

class ExportContactSubscriptionsPageView extends StatelessWidget {
  const ExportContactSubscriptionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportContactSubscriptionPage, // 页面标题
      'AddContactSubscriptionPage', // 卡片标题=点击卡片导航到的页面
      const ContactSubscriptionListView(), // 点击卡片导航到的页面
      const ExportContactSubscriptionsPage(), // 当前页面主要内容
      exportPage: const ExportContactSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddContactSubscriptionPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportContactSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportContactSubscriptionsPage extends StatefulWidget {
  const ExportContactSubscriptionsPage({super.key});

  @override
  ExportContactSubscriptionsPageState createState() =>
      ExportContactSubscriptionsPageState();
}

class ExportContactSubscriptionsPageState
    extends State<ExportContactSubscriptionsPage> {
  late SubscribeContactsService _subscribeContactsService;
  List<ContactSubscriptionModel>? _selectedSubscriptions;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedSubscriptions = []; // 初始化为空列表
    _subscribeContactsService = appState.subscribeContactsService;
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<ContactSubscriptionModel>(
      // 使用泛型指定类型
      getEntries: appState.subscribeContactsService.getAllSubscriptions,
      buildSelectDialog:
          (BuildContext context, List<ContactSubscriptionModel> subscriptions) {
        return SelectEntriesDialog<ContactSubscriptionModel>(
          entries: subscriptions,
          hasBlacklistWhitelistTabs: true,
          searchKey: 'name',
        );
      },
      exportToCsv: appState.subscribeContactsService.exportSubscriptionsToCsv,
      exportToJson: appState.subscribeContactsService.exportSubscriptionsToJson,
    );
  }
}
