import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../screens/appstate_provider.dart';
import '../../services/subscription_service.dart';
import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';
import 'add_subscription.dart';
import 'import_subscriptions.dart';
import 'subscription_page.dart';

class ExportSubscriptionsPageView extends StatelessWidget {
  const ExportSubscriptionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSubscriptionsPage, // 页面标题
      'SubscriptionListView', // 卡片标题=点击卡片导航到的页面
      const SubscriptionListView(), // 点击卡片导航到的页面
      const ExportSubscriptionsPage(), // 当前页面主要内容
      exportPage: const ExportSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSubscriptionPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ExportSubscriptionsPage extends StatefulWidget {
  const ExportSubscriptionsPage({super.key});

  @override
  ExportSubscriptionsPageState createState() => ExportSubscriptionsPageState();
}

class ExportSubscriptionsPageState extends State<ExportSubscriptionsPage> {
  late SubscriptionService _subscriptionService;
  List<SubscriptionModel>? _selectedSubscriptions;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedSubscriptions = []; // 初始化为空列表
    _subscriptionService = appState.subscriptionService;
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }

  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<SubscriptionModel>(
      // 使用泛型指定类型
      getEntries: appState.subscriptionService.getAllSubscriptions,
      buildSelectDialog:
          (BuildContext context, List<SubscriptionModel> subscriptions) {
        return SelectEntriesDialog<SubscriptionModel>(
          entries: subscriptions,
          hasBlacklistWhitelistTabs: true,
          searchKey: 'name',
        );
      },
      exportToCsv: appState.subscriptionService.exportSubscriptionsToCsv,
      exportToJson: appState.subscriptionService.exportSubscriptionsToJson,
    );
  }
}
