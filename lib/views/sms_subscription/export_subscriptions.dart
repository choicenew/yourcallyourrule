
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';



import '../../generated/l10n.dart';



import '../../screens/appstate_provider.dart';
import '../../services/sms_subscribe_service.dart';



import '../public/build_page_switch.dart';
import '../public/export_item.dart';
import '../public/select_items.dart';

import 'add_subscription.dart';

import 'import_subscriptions.dart';

import 'subscription_page.dart';

class ExportSmsSubscriptionsPageView extends StatelessWidget {
  const ExportSmsSubscriptionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).exportSmsSubscriptionPage, // 页面标题
    //  'SmsSubscriptionListView', // 卡片标题=点击卡片导航到的页面
      const SmsSubscriptionListView(), // 点击卡片导航到的页面
      const ExportSmsSubscriptionsPage(), // 当前页面主要内容
      exportPage: const ExportSmsSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsSubscriptionPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}


class ExportSmsSubscriptionsPage extends StatefulWidget {
  const ExportSmsSubscriptionsPage({super.key});

  @override
  ExportSmsSubscriptionsPageState createState() =>
      ExportSmsSubscriptionsPageState();
}

class ExportSmsSubscriptionsPageState extends State<ExportSmsSubscriptionsPage> {
  final _subscriptions = <SmsSubscriptionModel>[];
  late SmsSubscribeService _smsSubscriptionService;
  List<SmsSubscriptionModel>? _selectedSubscriptions;




 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _selectedSubscriptions = []; // 初始化为空列表
     _smsSubscriptionService = appState.smsSubscriptionService; 
  }

  String? _filePath;
  String _selectedType = 'csv'; // Default export format (CSV)
  



  @override
  Widget build(BuildContext context) {
     final appState = Provider.of<AppState>(context, listen: false);
    return _build(context, appState); // 直接调用 _build(context)
  }



  Widget _build(BuildContext context, AppState appState) {
    return ExportScreenWidget<SmsSubscriptionModel>( // 使用泛型指定类型
      getEntries: appState.smsSubscriptionService.getAllSubscriptions,
      buildSelectDialog: (BuildContext context, List<SmsSubscriptionModel> subscriptions) {
        return SelectEntriesDialog<SmsSubscriptionModel>(
  entries: subscriptions,
  hasBlacklistWhitelistTabs: true,
  searchKey: 'name',
);
      },
      exportToCsv: appState.smsSubscriptionService.exportSubscriptionsToCsv,
      exportToJson: appState.smsSubscriptionService.exportSubscriptionsToJson,
    );
  }
}