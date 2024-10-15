import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_blacklist_whitelist_service.dart';
import '../../services/sms_subscribe_service.dart';
import '../../services/sms_text_service.dart';
import '../../services/snackbar_service.dart';
import '../../utils/ad_manager.dart';
import '../../widgets/google_ad.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../subpage_style.dart';
import 'export_subscriptions.dart';
import 'import_subscriptions.dart';
import 'subscription_page.dart';

class AddSmsSubscriptionPageView extends StatelessWidget {
  const AddSmsSubscriptionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).addSmsSubscriptionPage, // 页面标题
      'SmsSubscriptionListView', // 卡片标题=点击卡片导航到的页面
      const SmsSubscriptionListView(), // 点击卡片导航到的页面
      const AddSmsSubscriptionPage(), // 当前页面主要内容
      exportPage: const ExportSmsSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const AddSmsSubscriptionPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class AddSmsSubscriptionPage extends StatefulWidget {
  const AddSmsSubscriptionPage({super.key});

  @override
  AddSmsSubscriptionPageState createState() => AddSmsSubscriptionPageState();
}

class AddSmsSubscriptionPageState extends State<AddSmsSubscriptionPage> {
  // 订阅名称控制器

  TextEditingController _subscriptionNameController = TextEditingController();

  // 订阅链接控制器
  TextEditingController _urlController = TextEditingController();

  late SmsBlacklistService _smsBlacklistService;
  late SmsWhitelistService _smsWhitelistService;
  late SmsTextBlacklistService _smsTextblacklistService;
  late SmsTextWhitelistService _smsTextwhitelistService;
  late SmsSubscribeService _smsSubscriptionService;

  late SmsSubscriptionModel _subscriptions;
  bool _isAutoUpdate = false;
  bool _enabled = false;
  bool _isNumberType = true;

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
    _subscriptions = SmsSubscriptionModel(name: '', url: '');
    _smsSubscriptionService = appState.smsSubscriptionService;
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
              NameInputWidget(nameController: _subscriptionNameController),

              const SizedBox(height: 16.0),
              // 使用 UrlInputWidget
              UrlInputWidget(urlController: _urlController),

              const SizedBox(height: 16.0),

              //自动更新
              // 使用 SubscriptionAutoUpdateSwitchWidget
              SubscriptionAutoUpdateSwitchWidget(
                isAutoUpdate: _isAutoUpdate,
                onChanged: (value) {
                  _isAutoUpdate = value;
                  setState(() {});
                },
              ),

              // 使用 EnableDisableButtonWidget in a SwitchListTile
              SubscriptionEnabledSwitchWidget(
                enabled: _enabled,
                onChanged: (value) {
                  _enabled = value;
                  setState(() {});
                },
              ),

              // 使用 SubscriptionNumberTypeSwitchWidget
              SubscriptionNumberTypeSwitchWidget(
                isNumberType: _isNumberType,
                onChanged: (value) async {
                  _isNumberType = value;
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
              if (_subscriptionNameController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).nameCannotBeEmpty);
                return;
              }
              // 检查电话号码是否为空
              if (_urlController.text.isEmpty) {
                showErrorSnackBar(context, S.of(context).pleaseEnterAnUrl);
                return;
              }

              final subscription = SmsSubscriptionModel(
                name: _subscriptionNameController.text,
                url: _urlController.text,
                enabled: _enabled,
                isWhitelist: _isWhitelist,
                isBlacklist: _isBlacklist,
                isNumberType: _isNumberType,
                isAutoUpdate: _isAutoUpdate,
              );

              try {
                // 根据黑白名单类型添加订阅
                if (_isBlacklist) {
                  await _smsSubscriptionService
                      .addBlacklistSubscription(subscription);
                } else if (_isWhitelist) {
                  await _smsSubscriptionService
                      .addWhitelistSubscription(subscription);
                }

                //自动更新
                if (_isAutoUpdate && _enabled) {
                  await _smsSubscriptionService
                      .autoUpdateSubscription(subscription);
                }
                // 导入订阅号码
                if (_urlController.text.isNotEmpty) {
                  if (_isBlacklist) {
                    if (_isNumberType) {
                      await _smsBlacklistService
                          .importNumbersFromUrl(_urlController.text);
                    } else {
                      await _smsTextblacklistService
                          .importKeywordsFromUrl(_urlController.text);
                    }
                  } else if (_isWhitelist) {
                    if (_isNumberType) {
                      await _smsWhitelistService
                          .importNumbersFromUrl(_urlController.text);
                    } else {
                      await _smsTextwhitelistService
                          .importKeywordsFromUrl(_urlController.text);
                    }
                  }
                }

                _subscriptionNameController.clear();
                _urlController.clear();
                setState(() {
                  _subscriptions = SmsSubscriptionModel(name: '', url: '');
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
