import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_blacklist_whitelist_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../subpage_style.dart';
import 'blacklist_page.dart';
import 'export_blacklists.dart';
import 'import_blacklists.dart';

class AddSmsBlacklistPageView extends StatelessWidget {
  const AddSmsBlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addSmsBlacklistPage, // 页面标题
   //   'SmsBlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const SmsBlacklistPageView(), // 点击卡片导航到的页面
      const AddSmsBlacklistPage(), // 当前页面主要内容
      exportPage: const ExportSmsBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddSmsBlacklistPage extends StatefulWidget {
  const AddSmsBlacklistPage({super.key});

  @override
  AddSmsBlacklistPageState createState() => AddSmsBlacklistPageState();
}

class AddSmsBlacklistPageState extends State<AddSmsBlacklistPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late SmsBlacklistService _smsBlacklistService;
  //late String _selectedLabel;
  late SmsBlacklistEntry _entry;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = SmsBlacklistEntry(name: '', phoneNumber: '', label: '');
    _smsBlacklistService = appState.smsBlacklistService;
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
              PhoneNumberInputWidget(
                  phoneNumberController: _phoneNumberController),

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

              Labels(
                onLabelChanged: (label) {
                  _entry.label = label;
                },
                selectLabelService: ListServiceAdapter(
                    Provider.of<AppState>(context, listen: false)
                        .smsBlacklistService),
              ),

              const SizedBox(height: 16.0),

              const Divider(height: 1),
              const SizedBox(height: 16.0),
              // 广告
              const GoogleAdWidget(adInfo: AdManager.bannerAd),

              const SizedBox(height: 16.0),
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
              if (_phoneNumberController.text.isEmpty) {
                showErrorSnackBar(
                    context, S.of(context).pleaseEnterAPhoneNumber);
                return;
              }
              if (_entry.label.isEmpty) {
                showErrorSnackBar(context, S.of(context).pleaseSelectALabel);
                return;
              }

              final entry = SmsBlacklistEntry(
                phoneNumber: _phoneNumberController.text,
                label: _entry.label,
                name: _nameController.text,
                isSubscribed: _isSubscribed,
              );

              try {
                await _smsBlacklistService.addOrUpdate(entry);

                var result = await _smsBlacklistService
                    .getEntryByPhoneNumber(_phoneNumberController.text);

                if (result != null) {
                } else {
                }

                _nameController.clear();
                _phoneNumberController.clear();
                setState(() {
                  _entry =
                      SmsBlacklistEntry(name: '', phoneNumber: '', label: '');
                });
                if (mounted) {
                  showSuccessSnackBar(context, S.of(context).addedSuccessfully);
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, '${S.of(context).failedToAdd} $e');
                }
              }
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
