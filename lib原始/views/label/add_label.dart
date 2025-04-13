import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/allowed_blocked_service.dart';
import '../../services/label_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/public_select_label.dart';
import '../subpage_style.dart';
import 'export_labels.dart';
import 'import_labels.dart';

import 'label_page.dart';

class AddLabelPageView extends StatelessWidget {
  const AddLabelPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addLabelPage, // 页面标题
     // 'LabelPageView', // 卡片标题=点击卡片导航到的页面
      const LabelPageView(), // 点击卡片导航到的页面
      const AddLabelPage(), // 当前页面主要内容
      exportPage: const ExportLabelsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddLabelPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportLabelsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddLabelPage extends StatefulWidget {
  const AddLabelPage(
      {super.key, this.initialPhoneNumber}); // 添加 initialPhoneNumber 参数
  final String? initialPhoneNumber; // 接收外界传递的号码

  @override
  AddAllowedEntryPageState createState() => AddAllowedEntryPageState();
}

class AddAllowedEntryPageState extends State<AddLabelPage> {
  // 订阅名称控制器

  TextEditingController _nameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _phoneNumberController = TextEditingController();
  //bool _isBlocked = false;
  //bool _isAllowed = false;
  late LabelService _labelService;
  //late String _selectedLabel;
  late LabeledEntry _entry;

  late AllowedService _allowedService;
  late BlockedService _blockedService;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _entry = LabeledEntry(name: '', phoneNumber: '', label: '');
    // 如果 initialPhoneNumber 不为空，则设置到 _phoneNumberController
    if (widget.initialPhoneNumber != null) {
      _phoneNumberController.text = widget.initialPhoneNumber!;
    }

    _labelService = appState.labelService;
    _allowedService = appState.allowedService;
    _blockedService = appState.blockedService;
  }

  bool _isAllowed = false;
  bool _isBlocked = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isAllowed == _isBlocked) {
        // 当两个开关状态相同时（都为 false，因为它们不能同时为 true）
        if (newValue) {
          // 如果新值为 true，我们需要确定哪个开关被点击
          if (_isAllowed != newValue) {
            _isAllowed = true;
            _isBlocked = false;
          } else {
            _isBlocked = true;
            _isAllowed = false;
          }
        }
        // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
      } else {
        // 当两个开关状态不同时（一个为 true，一个为 false）
        if (newValue) {
          // 如果新值为 true，我们需要切换状态
          _isAllowed = !_isAllowed;
          _isBlocked = !_isBlocked;
        } else {
          // 如果新值为 false，我们只需要将当前为 true 的开关设为 false
          _isAllowed = false;
          _isBlocked = false;
        }
      }
    });
  }
/*
  @override
  Widget build(BuildContext context) {
    return _build(context); // 直接调用 _build(context)
  }
*/
/*
@override
Widget build(BuildContext context) {
  return SafeArea(
    child: _build(context),
  );
}
*/
@override
Widget build(BuildContext context) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 将状态栏设置为透明
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light
          ? Brightness.dark // 亮色主题时使用深色状态栏图标
          : Brightness.light, // 暗色主题时使用浅色状态栏图标
    ),
    child: Container(  // 添加 Container widget
      color: Theme.of(context).scaffoldBackgroundColor, // 设置 Container 的背景颜色
      child: SafeArea(
        minimum: EdgeInsets.zero, // 设置 minimum 为 EdgeInsets.zero
        child: _build(context),
      ),
    ),
  );
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
              const SizedBox(height: 10),
              const Divider(height: 1),
              SwitchRowWidget(
                isAllowed: _isAllowed,
                isBlocked: _isBlocked,
                onSwitchChanged: _onSwitchChanged,
                allowedType: "Allowed", // 传入 "Whitelist"
                blockedType: "Blocked", // 传入 "Blacklist"
              ),
              const Divider(),

              // 标签选择
              // Stateful widget to manage Entry name and label
              Labels(
                onLabelChanged: (label) {
                  _entry.label = label;
                },
                selectLabelService: ListServiceAdapter(
                    Provider.of<AppState>(context, listen: false).labelService),
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

              final entry = LabeledEntry(
                phoneNumber: _phoneNumberController.text,
                label: _entry.label,
                name: _nameController.text,
              );

              final allowedEntry = AllowedEntry(
                phoneNumber: entry.phoneNumber,
                label: entry.label,
                name: entry.name,
              );

              final blockedEntry = BlockedEntry(
                phoneNumber: entry.phoneNumber,
                label: entry.label,
                name: entry.name,
                avatar: entry.avatar,
              );

              try {
                await _labelService.addOrUpdate(entry);






                // Update database with updated entry
                if (_isAllowed) {
                  await _allowedService.addOrUpdate(allowedEntry);
                } else if (_isBlocked) {
                  await _blockedService.addOrUpdate(blockedEntry);
                }

                _nameController.clear();
                _phoneNumberController.clear();
                setState(() {
                  _entry = LabeledEntry(name: '', phoneNumber: '', label: '');
                });
                if (mounted) {
                  showSuccessSnackBar(
                      context, S.of(context).entryAddedSuccessfully);
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
