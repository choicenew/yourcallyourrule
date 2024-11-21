import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_subscribe_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/public_add_import_list.dart';
import '../subpage_style.dart';
import 'add_subscription.dart';
import 'export_subscriptions.dart';
import 'subscription_page.dart';

class ImportSmsSubscriptionsPageView extends StatelessWidget {
  const ImportSmsSubscriptionsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).importSmsSubscriptionPage, // 页面标题
     // 'SmsSubscriptionListView', // 卡片标题=点击卡片导航到的页面
      const SmsSubscriptionListView(), // 点击卡片导航到的页面
      const ImportSmsSubscriptionsPage(), // 当前页面主要内容
      exportPage: const ExportSmsSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsSubscriptionPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ImportSmsSubscriptionsPage extends StatefulWidget {
  const ImportSmsSubscriptionsPage({super.key});

  @override
  ImportSmsSubscriptionsPageState createState() =>
      ImportSmsSubscriptionsPageState();
}

class ImportSmsSubscriptionsPageState
    extends State<ImportSmsSubscriptionsPage> {
  final _urlController = TextEditingController();

  late SmsSubscribeService _smsSubscriptionService;
  String? filePath;
  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);

    _smsSubscriptionService = appState.smsSubscriptionService;
  }



  @override
  Widget build(BuildContext context) {
    return _build(context); // 直接调用 _build(context)
  }

// 在 _build 方法中使用 AddItemWidget
  Widget _build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAddImportItem(_urlController, filePath, (path) {
              setState(() {
                filePath = path;
              });
            }),
            nativeAdWidgetMedium(
                adWidth: 320, adHeight: 320), // 将广告 Widget 移到这里
            const SizedBox(height: 16.0),
            const GoogleAdWidget(adInfo: AdManager.bannerAd), // 将广告 Widget 移到这里
            const SizedBox(height: 16.0),
          ],
        ),
      ),

      //居于屏幕右下角
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              // 检查 URL 和本地文件
              if (_urlController.text.isNotEmpty || filePath == null) {
                // Check if the URL is valid
                if (Uri.tryParse(_urlController.text) == null &&
                    filePath == null) {
                  showErrorSnackBar(
                      context, S.of(context).urlFormatIsIncorrect);
                  return;
                }
              }

              // 导入号码
              if (_urlController.text.isNotEmpty) {
                _smsSubscriptionService
                    .importSubscriptionsFromUrl(_urlController.text);
              } else if (filePath != null) {
                _smsSubscriptionService
                    .importSubscriptionsFromLocalFile(filePath!);
              } else {
                showErrorSnackBar(
                    context, S.of(context).pleaseSelectAFileOrInputAUrl);
                return;
              }
            },
            style: addButtonStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use minimum size
              children: [
                const Icon(NewSet.add),
                const SizedBox(width: 8.0),
                Text(
                  S.of(context).import,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
