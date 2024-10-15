import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/regex_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../subpage_style.dart';
import 'export_regexs.dart';
import 'hint.dart';
import 'import_regexs.dart';
import 'regex_page.dart';

class AddRegexPageView extends StatelessWidget {
  const AddRegexPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addRegexPage, // 页面标题
      'RegexPageView', // 卡片标题=点击卡片导航到的页面
      const RegexPageView(), // 点击卡片导航到的页面
      const AddRegexPage(), // 当前页面主要内容
      exportPage: const ExportRegexPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddRegexPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportRegexPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddRegexPage extends StatefulWidget {
  const AddRegexPage({super.key});

  @override
  AddRegexPageState createState() => AddRegexPageState();
}

class AddRegexPageState extends State<AddRegexPage> {
  // 订阅名称控制器

  TextEditingController _regexNameController = TextEditingController();

  //规则控制器
  TextEditingController _patternController = TextEditingController();

  late RegexService _regexService;

  late RegexPattern _rexPattern;

  bool _enabled = false;

  bool _isWhitelist = false;
  bool _isBlacklist = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isWhitelist == _isBlacklist) {
        // 当两个开关状态相同时（都为 false，因为它们不能同时为 true）
        if (newValue) {
          // 如果新值为 true，我们需要确定哪个开关被点击
          if (_isWhitelist != newValue) {
            _isWhitelist = true;
            _isBlacklist = false;
          } else {
            _isBlacklist = true;
            _isWhitelist = false;
          }
        }
        // 如果新值为 false，不需要做任何改变，因为两个开关已经是 false
      } else {
        // 当两个开关状态不同时（一个为 true，一个为 false）
        if (newValue) {
          // 如果新值为 true，我们需要切换状态
          _isWhitelist = !_isWhitelist;
          _isBlacklist = !_isBlacklist;
        } else {
          // 如果新值为 false，我们只需要将当前为 true 的开关设为 false
          if (_isWhitelist) {
            _isWhitelist = false;
            _isBlacklist = true;
          } else {
            _isBlacklist = false;
            _isWhitelist = true;
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _rexPattern = RegexPattern(name: '', pattern: '');
    _regexService = appState.regexService;
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
              NameInputWidget(nameController: _regexNameController),

              const SizedBox(height: 16.0),
              // 使用 patternInputWidget
              PatternInputWidget(patternController: _patternController),

              const SizedBox(height: 16.0),

              // 使用 EnableDisableButtonWidget in a SwitchListTile
              SubscriptionEnabledSwitchWidget(
                enabled: _enabled,
                onChanged: (value) {
                  _enabled = value;
                  setState(() {});
                },
              ),

              const Divider(height: 1),

              // Blacklist/Whitelist options with adjusted padding
              // 使用 SwitchRowWidget
              SwitchRowWidget(
                isAllowed: _isWhitelist,
                isBlocked: _isBlacklist,
                onSwitchChanged: _onSwitchChanged,
                allowedType: 'Whitelist',
                blockedType: 'Blacklist',
              ),

              const Divider(height: 1),
// regex 提示
              const RegexPatternExplanationButton(),

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
              if (_regexNameController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).nameCannotBeEmpty);
                return;
              }
              // 检查规则是否为空
              if (_patternController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).pleaseEnterAnPattern);
                return;
              }

              final rexPattern = RegexPattern(
                name: _regexNameController.text,
                pattern: _patternController.text,
                isWhitelist: _isWhitelist,
                isBlacklist: _isBlacklist,
                enabled: _enabled,
              );

              await _regexService.add(rexPattern);
              try {
                //启用
                if (_enabled) {
                  await _regexService.enablePattern(rexPattern);
                }

                _regexNameController.clear();
                _patternController.clear();
                setState(() {
                  _rexPattern = RegexPattern(name: '', pattern: '');
                });
                if (mounted) {
                  showSuccessSnackBar(context, S.of(context).addedSuccessfully);
                }
              } catch (e) {
                if (mounted) {
                  showErrorSnackBar(context, '${S.of(context).failedToAdd} $e');
                }
              }
              // Update database with updated model
              //  if (_isAllowed) {
              //    await _allowedService.add(model as AllowedEntry);
              //  } else if (_isBlocked) {
              //    await _blockedService.add(model as BlockedEntry);
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
