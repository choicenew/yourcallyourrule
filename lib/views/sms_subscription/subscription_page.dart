
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';
import '../../services/sms_blacklist_whitelist_service.dart';
import '../../services/sms_subscribe_service.dart';
import '../../services/sms_text_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../public/build_page_switch.dart';
import '../public/isolated_widgets.dart';
import '../public/responsive_grid_list.dart';
import 'export_subscriptions.dart';
import 'import_subscriptions.dart';

class SmsSubscriptionListView extends StatelessWidget {
  const SmsSubscriptionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      S.of(context).smsSubscriptionPage, // 页面标题
    //  'SmsSubscriptionListView', // 卡片标题=点击卡片导航到的页面
      const SmsSubscriptionListView(), // 卡片导航到的页面
      const SmsSubscriptionList(), // 当前页面主要内容
      exportPage: const ExportSmsSubscriptionsPageView(), // 导出页面
      exportLabel: S.of(context).export, // 自定义导出按钮文字
      addPage: const ImportSmsSubscriptionsPageView(), // 添加页面
      addLabel: S.of(context).add, // 自定义 add 按钮文字
      importPage: const ImportSmsSubscriptionsPageView(), // 导入页面
      importLabel: S.of(context).import, // 自定义导入按钮文字
    );
  }
}

class SmsSubscriptionList extends StatefulWidget {
  const SmsSubscriptionList({super.key});

  @override
  SmsSubscriptionListState createState() => SmsSubscriptionListState();
}

class SmsSubscriptionListState extends State<SmsSubscriptionList>
    with WidgetsBindingObserver {
  // final SmsBlacklistService _smsSubscriptionService =
  //     SmsBlacklistService(database as Database);
  late SmsBlacklistService _smsBlacklistService;
  late SmsWhitelistService _smsWhitelistService;
  late SmsTextBlacklistService _smsTextblacklistService;
  late SmsTextWhitelistService _smsTextwhitelistService;
  late SmsSubscribeService _smsSubscriptionService;
  Map<int, bool> _expandedItems = {};
  List<SmsSubscriptionModel> _subscriptions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeServices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadSubscriptions();
    }
  }

  void _initializeServices() {
    final appState = Provider.of<AppState>(context, listen: false);
    _smsBlacklistService = appState.smsBlacklistService;
    _smsWhitelistService = appState.smsWhitelistService;
    _smsTextblacklistService = appState.smsTextBlacklistService;
    _smsTextwhitelistService = appState.smsTextWhitelistService;
    _smsSubscriptionService = appState.smsSubscriptionService;
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final subscriptions = await _smsSubscriptionService.getAllSubscriptions(
          orderBy: 'id', ascending: true);
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadSubscriptions,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : AdvancedSelfManagedSearchBar<SmsSubscriptionModel>(
                items: _subscriptions,
                itemBuilder: (context, subscription, width) =>
                    _buildSubscriptionItem(subscription, width),
                getSearchString: (subscription) =>
                    '${subscription.id} ${subscription.url} ${subscription.name}',
                getSortFields: (subscription) => ['ID', 'Url', 'Name'],
                getSortFieldValues: (subscription) =>
                    [subscription.id, subscription.url, subscription.name],
                originalBuilder: (context, items) => _build(context),
                //adBuilder: (width, height) => nativeAdWidgetSmall(adWidth: width, adHeight: height),
                // 添加回调函数
              ),
      ),
    );
  }

// 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return buildResponsiveGridList(
        _subscriptions, _buildSubscriptionItem, adState.isAdEnabled);
  }

  Widget _buildSubscriptionItem(
      SmsSubscriptionModel subscription, double subscriptionWidth) {
    return Card(
      color: Colors.grey[100],
      margin: const EdgeInsets.all(10.0),
      child: ExpansionTile(
        key: ValueKey(subscription.id),
        initiallyExpanded: _expandedItems[subscription.id] ?? false,
        onExpansionChanged: (isExpanded) {
          _expandedItems[subscription.id!] = isExpanded;
        },
        title: SubscriptionTitleWidget(name: subscription.name),
        subtitle: Row(
          children: [
            SubscriptionUrlWidget(url: subscription.url),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubscriptionStatusIconWidget(
              isBlacklist: subscription.isBlacklist,
              isWhitelist: subscription.isWhitelist,
            ),
            const SizedBox(width: 8),
            TypeStatusIconWidget(isNumberType: subscription.isNumberType),
            const SizedBox(width: 8),
            AutoUpdateButtonWidget(
              isAutoUpdate: subscription.isAutoUpdate,
              onPressed: () async {
                if (subscription.isAutoUpdate) {
                  await _smsSubscriptionService
                      .manualUpdateSubscription(subscription);
                }
                setState(() {
                  subscription.isAutoUpdate = !subscription.isAutoUpdate;
                });
              },
            ),
            EnableDisableButtonWidget(
              isEnabled: subscription.enabled,
              onPressed: () async {
                // subscription.enabled = !subscription.enabled;

                await _toggleSubscriptionEnabled(subscription);

                setState(() {});
              },
            ),

/*
EnableDisableButtonWidget<SmsSubscriptionModel>(
  isEnabled: subscription.enabled,
  item: subscription, // 传递 subscription 对象
  onToggle: (context, subscription) => _toggleSubscriptionEnabled(context, subscription),
),
*/
            const SizedBox(width: 8),
            DeleteButtonWidget(
              onPressed: () => _showDeleteConfirmation(context, subscription),
            ),
            ExpansionIconWidget(
                isExpanded: _expandedItems[subscription.id] ?? false),
          ],
        ),
        children: [
          _buildExpandedContent(context, subscription),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(
      BuildContext context, SmsSubscriptionModel subscription) {
    final TextEditingController nameController =
        TextEditingController(text: subscription.name);
    //新增加的url 路径
    final TextEditingController urlController =
        TextEditingController(text: subscription.url);

    // 在这里更新 _isWhitelist 和 _isBlacklist 的值
    _isWhitelist = subscription.isWhitelist;
    _isBlacklist = subscription.isBlacklist;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          NameInputWidget(
            nameController: nameController,
          ),
          const SizedBox(height: 10.0),
          UrlInputWidget(
            urlController: urlController,
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          SubscriptionAutoUpdateSwitchWidget(
            isAutoUpdate: subscription.isAutoUpdate,
            onChanged: (bool newValue) async {
              subscription.isAutoUpdate = newValue;
              if (newValue) {
                await _smsSubscriptionService
                    .autoUpdateSubscription(subscription);
              }
              setState(() {});
            },
          ),
          const SizedBox(height: 10.0),
          SubscriptionNumberTypeSwitchWidget(
            isNumberType: subscription.isNumberType,
            onChanged: (bool newValue) async {
              subscription.isNumberType = newValue;
              if (newValue) {
                await _smsSubscriptionService
                    .autoUpdateSubscription(subscription);
              }
              setState(() {});
            },
          ),
          const SizedBox(height: 10.0),
          SwitchRowWidget(
            isAllowed: _isWhitelist,
            isBlocked: _isBlacklist,
            onSwitchChanged: _onSwitchChanged,
            allowedType: "Whitelist", // 传入 "Whitelist"
            blockedType: "Blacklist", // 传入 "Blacklist"
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          const GoogleAdWidget(adInfo: AdManager.bannerAd),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionButtonWidget(
                icon: NewSet.delete,
                label: S.of(context).delete,
                onPressed: () => _showDeleteConfirmation(context, subscription),
                pressedColor: Colors.red,
              ),
              ActionButtonWidget(
                icon: NewSet.check,
                label: S.of(context).save,
                onPressed: () => _saveEntry(subscription, nameController.text,
                    urlController.text, _isWhitelist, _isBlacklist),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, SmsSubscriptionModel subscription) async {
    //void _showDeleteConfirmation(BuildContext context,SmsSubscriptionModel subscription) {
    showDeleteConfirmationDialog<SmsSubscriptionModel>(
      context,
      subscription,
      _smsSubscriptionService.deleteSubscription,
      displayText: subscription.id.toString(),
    );

    await _loadSubscriptions();
  }

// 在 SmsSubscriptionListState 中定义一个新的方法

  Future<void> _toggleSubscriptionEnabled(
      SmsSubscriptionModel subscription) async {
    subscription.enabled = !subscription.enabled;

    await _smsSubscriptionService.editSubscription(subscription);

    if (subscription.enabled) {
      await _smsSubscriptionService.enableSubscription(subscription);
    } else {
      await _smsSubscriptionService.disableSubscription(subscription);
    }

    //setState(() {});
  }

  Future<void> _updateSubscription(SmsSubscriptionModel subscription,
      String name, String url, bool isWhitelist, bool isBlacklist) async {
    final updatedSubscription = SmsSubscriptionModel(
      id: subscription.id,
      name: name,
      url: url,
      enabled: subscription.enabled,
      isWhitelist: isWhitelist,
      isBlacklist: isBlacklist,
      isNumberType: subscription.isNumberType,
      isAutoUpdate: subscription.isAutoUpdate,
    );

    await _smsSubscriptionService.editSubscription(updatedSubscription);

    if (isBlacklist) {
      if (updatedSubscription.isNumberType) {
        await _smsBlacklistService
            .importNumbersFromUrl(updatedSubscription.url);
        await _smsWhitelistService.deleteByUrl(updatedSubscription.url);
      } else {
        await _smsTextblacklistService
            .importKeywordsFromUrl(updatedSubscription.url);
        await _smsTextwhitelistService.deleteByUrl(updatedSubscription.url);
      }
    } else if (isWhitelist) {
      if (subscription.isNumberType) {
        await _smsWhitelistService
            .importNumbersFromUrl(updatedSubscription.url);
        await _smsBlacklistService.deleteByUrl(updatedSubscription.url);
      } else {
        await _smsTextwhitelistService
            .importKeywordsFromUrl(updatedSubscription.url);
        await _smsTextblacklistService.deleteByUrl(updatedSubscription.url);
      }
    } else {
      await _smsSubscriptionService.disableSubscription(updatedSubscription);
      await _smsWhitelistService.deleteByUrl(updatedSubscription.url);
      await _smsBlacklistService.deleteByUrl(updatedSubscription.url);
      await _smsTextwhitelistService.deleteByUrl(updatedSubscription.url);
      await _smsTextblacklistService.deleteByUrl(updatedSubscription.url);
    }

//分割
    if (subscription.enabled) {
      await _smsSubscriptionService.enableSubscription(updatedSubscription);
      if (isBlacklist) {
        if (subscription.isNumberType) {
          await _smsBlacklistService
              .importNumbersFromUrl(updatedSubscription.url);
          await _smsWhitelistService.deleteByUrl(updatedSubscription.url);
        } else {
          await _smsTextblacklistService
              .importKeywordsFromUrl(updatedSubscription.url);
          await _smsTextwhitelistService.deleteByUrl(updatedSubscription.url);
        }
      } else if (isWhitelist) {
        if (subscription.isNumberType) {
          await _smsWhitelistService
              .importNumbersFromUrl(updatedSubscription.url);
          await _smsBlacklistService.deleteByUrl(updatedSubscription.url);
        } else {
          await _smsTextwhitelistService
              .importKeywordsFromUrl(updatedSubscription.url);
          await _smsTextblacklistService.deleteByUrl(updatedSubscription.url);
        }
      }
    } else {
      await _smsSubscriptionService.disableSubscription(updatedSubscription);
      await _smsWhitelistService.deleteByUrl(updatedSubscription.url);
      await _smsBlacklistService.deleteByUrl(updatedSubscription.url);
      await _smsTextwhitelistService.deleteByUrl(updatedSubscription.url);
      await _smsTextblacklistService.deleteByUrl(updatedSubscription.url);
    }
  }

  void _saveEntry(SmsSubscriptionModel subscription, String name, String url,
      bool isWhitelist, bool isBlacklist) async {
    await _updateSubscription(
        subscription, name, url, isWhitelist, isBlacklist);

    await _loadSubscriptions();
    setState(() {
      _expandedItems[subscription.id!] = false;
    });
  }

  ///
}
