import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_text_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../subpage_style.dart';
import 'blacklist_page.dart';
import 'export_blacklists.dart';
import 'import_blacklists.dart';

class AddSmsTextBlacklistPageView extends StatelessWidget {
  const AddSmsTextBlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addSmsTextBlacklistPage, // 页面标题
      'SmsTextBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsTextBlacklistPageView(), // 点击卡片导航到的页面
      const AddSmsTextBlacklistPage(), // 当前页面主要内容
      exportPage: const ExportSmsTextBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsTextBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsTextBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddSmsTextBlacklistPage extends StatefulWidget {
  const AddSmsTextBlacklistPage({super.key});

  @override
  AddSmsTextBlacklistPageState createState() => AddSmsTextBlacklistPageState();
}

class AddSmsTextBlacklistPageState extends State<AddSmsTextBlacklistPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _keywordController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late SmsTextBlacklistService _smsTextBlacklistService;
  //late String _selectedLabel;
  late SmsTextBlacklistEntry _entry;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = SmsTextBlacklistEntry(name: '', keyword: '');
    _smsTextBlacklistService = appState.smsTextBlacklistService;
  }

  @override
  Widget build(BuildContext context) {
    return _build(context); // 直接调用 _build(context)
  }

  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // 使用 NameInputWidget
              NameInputWidget(nameController: _nameController),

              const SizedBox(height: 16.0),
              // 使用 UrlInputWidget
              KeywordInputWidget(keywordController: _keywordController),

              const SizedBox(height: 16.0),
              // 使用 SubscribedSwitchWidget
              SubscribedSwitchWidget(
                isSubscribed: _isSubscribed,
                onChanged: (value) {
                  setState(() {
                    _isSubscribed = value;
                  });
                },
              ),

              const SizedBox(height: 16.0),

              const Divider(height: 1),
              const SizedBox(height: 16.0),
              // 广告
              const GoogleAdWidget(adInfo: AdManager.bannerAd),

              const SizedBox(height: 16.0),
              nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
            ],
          ),
        ),
      ),

      //居于屏幕右下角
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 16.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              // 检查订阅名称是否为空
              if (_nameController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).nameCannotBeEmpty);
                return;
              }
              // 检查电话号码是否为空
              if (_keywordController.text.isEmpty) {
                showErrorSnackBar(
                    context, S.of(context).pleaseEnterAPhoneNumber);
                return;
              }

              final entry = SmsTextBlacklistEntry(
                keyword: _keywordController.text,
                name: _nameController.text,
                isSubscribed: _isSubscribed,
              );

              try {
                await _smsTextBlacklistService.addOrUpdate(entry);

                var result = await _smsTextBlacklistService
                    .getEntryByKeyword(_keywordController.text);

                _nameController.clear();
                _keywordController.clear();
                setState(() {
                  _entry = SmsTextBlacklistEntry(name: '', keyword: '');
                });
                if (mounted) {
                  showSuccessSnackBar(context, S.of(context).addedSuccessfully);
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, '${S.of(context).failedToAdd} $e');
                }
              }
              // Update database with updated entry
              //  if (_isAllowed) {
              //    await _allowedService.add(entry as AllowedEntry);
              //  } else if (_isBlocked) {
              //    await _blockedService.add(entry as BlockedEntry);
              //   }
            },
            style: floatingButtonStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Use minimum size
              children: [
                const Icon(NewSet.add),
                const SizedBox(width: 8.0),
                Text(
                  S.of(context).save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
