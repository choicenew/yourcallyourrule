//import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:yourcallyourrule/screens/appstate_provider.dart';

import '../../generated/l10n.dart';

import '../../new_set_icons.dart';
import '../../services/allowed_blocked_service.dart';

import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';

import '../../widgets/google_ad.dart';

import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../subpage_style.dart';
import 'allowed_page.dart';

import 'export_allowed_entries.dart';
import 'import_allowed_entries.dart';

class AddAllowedEntryPageView extends StatelessWidget {
  const AddAllowedEntryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addAllowedEntryPage, // 页面标题
     // 'AllowedPageView', // 卡片标题=点击卡片导航到的页面
      const AllowedPageView(), // 点击卡片导航到的页面
      const AddAllowedEntryPage(), // 当前页面主要内容
      exportPage: const ExportAllowedEntriesPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddAllowedEntryPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportAllowedEntriesPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddAllowedEntryPage extends StatefulWidget {
  const AddAllowedEntryPage({super.key});

  @override
  AddAllowedEntryPageState createState() => AddAllowedEntryPageState();
}

class AddAllowedEntryPageState extends State<AddAllowedEntryPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late AllowedService _allowedService;
  //late String _selectedLabel;
  late AllowedEntry _entry;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = AllowedEntry(name: '', phoneNumber: '', label: '');
    _allowedService = appState.allowedService;
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

              // 标签选择
              // Stateful widget to manage Entry name and label
              Labels(
                onLabelChanged: (label) {
                  _entry.label = label;
                },
                selectLabelService: ListServiceAdapter(
                    Provider.of<AppState>(context, listen: false)
                        .allowedService),
              ),

              const SizedBox(height: 16.0),
              const Divider(height: 1),

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

              final entry = AllowedEntry(
                phoneNumber: _phoneNumberController.text,
                label: _entry.label,
                name: _nameController.text,
              );

              try {
                await _allowedService.addOrUpdate(entry);

                var result = await _allowedService
                    .getEntryByPhoneNumber(_phoneNumberController.text);

                if (result != null) {
                } else {}

                _nameController.clear();
                _phoneNumberController.clear();
                setState(() {
                  _entry = AllowedEntry(name: '', phoneNumber: '', label: '');
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
