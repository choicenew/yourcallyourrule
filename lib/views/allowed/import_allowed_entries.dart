import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';

import '../../widgets/adwidgets/native_ads.dart';

import '../../widgets/google_ad.dart';

import '../public/build_page_switch.dart';
import '../public/public_add_import_list.dart';
import '../subpage_style.dart';

import 'add_allowed_entry.dart';
import 'allowed_page.dart';

import 'export_allowed_entries.dart';

class ImportAllowedEntriesPageView extends StatelessWidget {
  const ImportAllowedEntriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).importAllowedEntryPage, // 页面标题
      //'AllowedPageView', // 卡片标题=点击卡片导航到的页面
      const AllowedPageView(), // 点击卡片导航到的页面
      const ImportAllowedEntriesPage(), // 当前页面主要内容
      exportPage: const ExportAllowedEntriesPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddAllowedEntryPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportAllowedEntriesPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class ImportAllowedEntriesPage extends StatefulWidget {
  const ImportAllowedEntriesPage({super.key});

  @override
  ImportAllowedEntriesPageState createState() =>
      ImportAllowedEntriesPageState();
}

class ImportAllowedEntriesPageState extends State<ImportAllowedEntriesPage> {
  final _urlController = TextEditingController();
  String? filePath;
  late AllowedService _allowedService;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);

    _allowedService = appState.allowedService;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return FutureBuilder(
      future: appState.ensureServicesInitialized(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // 显示加载界面
        } else {
          return _build(context); // 显示主界面
        }
      },
    );
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
                _allowedService.importNumbersFromUrl(_urlController.text);
              } else if (filePath != null) {
                _allowedService.importNumbersFromLocal(filePath!);
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
