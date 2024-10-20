// ignore_for_file: prefer_final_fields

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/blacklist_whitelist_service.dart';
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

class AddBlacklistPageView extends StatelessWidget {
  const AddBlacklistPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addBlacklistPage, // 页面标题
     // 'BlacklistPageView', // 卡片标题=点击卡片导航到的页面
      const BlacklistPageView(), // 点击卡片导航到的页面
      const AddBlacklistPage(), // 当前页面主要内容
      exportPage: const ExportBlacklistsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddBlacklistPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportBlacklistsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddBlacklistPage extends StatefulWidget {
  const AddBlacklistPage({super.key});

  @override
  AddBlacklistPageState createState() => AddBlacklistPageState();
}

class AddBlacklistPageState extends State<AddBlacklistPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late BlacklistService _blacklistService;
  //late String _selectedLabel;
  late BlacklistEntry _entry;
  bool _isSubscribed = false;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = BlacklistEntry(name: '', phoneNumber: '', label: '');
    _blacklistService = appState.blacklistService;
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
                        .blacklistService),
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

              final entry = BlacklistEntry(
                phoneNumber: _phoneNumberController.text,
                label: _entry.label,
                name: _nameController.text,
                isSubscribed: _isSubscribed,
              );

              try {
                await _blacklistService.addOrUpdate(entry);

                var result = await _blacklistService
                    .getEntryByPhoneNumber(_phoneNumberController.text);



                _nameController.clear();
                _phoneNumberController.clear();
                setState(() {
                  _entry = BlacklistEntry(name: '', phoneNumber: '', label: '');
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
