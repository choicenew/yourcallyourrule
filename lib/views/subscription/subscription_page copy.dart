
import 'dart:core';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';

import '../../services/blacklist_whitelist_service.dart';

import '../../services/subscription_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/create_card.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
import '../Custom_3Button_Style.dart';

import '../shield_switch_style.dart';
import '../subpage_style.dart';


import 'add_subscription.dart';
import 'export_subscriptions.dart';
import 'import_subscriptions.dart';

class SubscriptionListView extends StatefulWidget {
  const SubscriptionListView({super.key});

  @override
  SubscriptionListViewState createState() => SubscriptionListViewState();
}

class SubscriptionListViewState extends State<SubscriptionListView> {
  bool _isCollapsed = true; // 初始为折叠状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: " Subscription List Page"),
      body: Column(
        children: [
          // Toggle button for collapsing/expanding content
          IconButton(
            icon: Icon(_isCollapsed ? Icons.expand_more : Icons.expand_less),
            onPressed: () {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
          ),

          // Collapsible content
          Visibility(
            visible: !_isCollapsed,
            child: Column(
              children: [
                // 导航到 SubscriptionListView 的 GestureDetector
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SubscriptionListView()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          final mediaQuery = MediaQuery.of(context);
                          const double cardRatio = 3 / 1.8;

                          final cardWidth = mediaQuery.size.width < 600
                              ? mediaQuery.size.width * 0.4
                              : mediaQuery.size.width < 900
                                  ? mediaQuery.size.width * 0.2
                                  : mediaQuery.size.width * 0.1;
                          final cardHeight = cardWidth / cardRatio;

                          return Container(
                            constraints: BoxConstraints(
                              maxWidth: cardWidth,
                              maxHeight: cardHeight,
                            ),
                            child: AspectRatio(
                              aspectRatio: 3.1 / 1.3,
                              child: createCard('SubscriptionListView'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExportSubscriptionsPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.upload),
                            label: Text('Export'),
                            style: Custom3ButtonStyle.style,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddSubscriptionPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.add),
                            label: Text('Add'),
                            style: Custom3ButtonStyle.style,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportSubscriptionsPageView(),
                                ),
                              );
                            },
                            icon: Icon(NewSet.download),
                            label: Text('Import'),
                            style: Custom3ButtonStyle.style,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<Widget>(
                  future: Future.value(GoogleAdWidget(adInfo: AdManager.bannerAd)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SubscriptionList(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class SubscriptionList extends StatefulWidget {
  const SubscriptionList({super.key});

  @override
  SubscriptionListState createState() => SubscriptionListState();
}

class SubscriptionListState extends State<SubscriptionList> {
  // final SubscriptionService _subscriptionService =
  //     SubscriptionService(database as Database);
 
  late BlacklistService _blacklistService;
  late WhitelistService _whitelistService;
  late SubscriptionService _subscriptionService;
  Map<String, bool> _expandedItems = {};

 @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    _blacklistService = appState.blacklistService;
    _whitelistService = appState.whitelistService;
    _subscriptionService = appState.subscriptionService;
  }
  /*
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = Provider.of<AppState>(context, listen: false);
      _blacklistService = appState.blacklistService;
      _whitelistService = appState.whitelistService;
      _subscriptionService = appState.subscriptionService;
          _initServices();

    });
  }

  Future<void> _initServices() async {
    // 打开 number_control_list.db 数据库
    final numberControlDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'number_control_list.db'),
      onCreate: bw.createDatabase,
      version: 1,
    );

    // 打开 subscription_models.db 数据库
    final subscriptionDatabase = await openDatabase(
      path_helper.join(await getDatabasesPath(), 'subscription_models.db'),
      onCreate: su.createDatabase,
      version: 1,
    );

    // 实例化服务
    _blacklistService = BlacklistService(numberControlDatabase);
    _whitelistService = WhitelistService(numberControlDatabase);
    _subscriptionService = SubscriptionService(subscriptionDatabase);
  }
*/
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    return FutureBuilder(
      future: appState.ensureServicesInitialized(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(child: CircularProgressIndicator()); // 显示加载界面
        } else {
          return _build(context); // 显示主界面
        }
      },
    );
  }

  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    return FutureBuilder<List<SubscriptionModel>>(
      future: _subscriptionService.getAllSubscriptions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          final subscriptions = snapshot.data!;
          return ListView.builder(
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              return _buildSubscriptionItem(subscriptions[index]);
            },
          );
        }
      },
    );
  }

  // 构建单个订阅项
  Widget _buildSubscriptionItem(SubscriptionModel subscription) {
    bool isExpanded = _expandedItems[subscription.name] ?? false;
    return Column(
      children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _expandedItems[subscription.name] = !isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  // Set title to subscription name
                  title: Padding(
                    // 添加左右边距到标题
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      subscription.name,
                      style: subscriptionTitleStyle,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Shield icon for blacklist/whitelist status
                      Icon(
                        subscription.isBlacklist
                            ? NewSet.blacklist_fill
                            : subscription.isWhitelist
                                ? NewSet.whitelist_fill
                                : null,
                        color: subscription.isBlacklist
                            ? blackStatusIconColor
                            : subscription.isWhitelist
                                ? whiteStatusIconColor
                                : offlineStatusIconColor,
                        size: statusIconSize,
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                        subscription.isAutoUpdate
                            ? NewSet.autorenew
                            : NewSet.sync_disabled,
                        color: subscription.isAutoUpdate
                            ? onlineStatusIconColor
                            : offlineStatusIconColor,
                        size: statusIconSize,
                      ),
  onPressed: () async {
    if (subscription.isAutoUpdate) {

        await _subscriptionService.manualUpdateSubscription(subscription);

    }
    setState(() {}); // 更新状态
  },
),

                      SizedBox(width: 8),
                      Theme(
                          data: customSwitchThemeData, // 应用 shieldSwitchStyle
                          child: // Switch to enable/disable subscription
                              Switch(
                            value: subscription.enabled,
                            onChanged: (value) async {
                              if (value) {
                                await _subscriptionService
                                    .enableSubscription(subscription);
                                // 根据订阅类型执行相应操作
                                if (subscription.isBlacklist) {
                                  await _blacklistService.importNumbersFromUrl(
                                      subscription.url);
                                  await _whitelistService
                                      .deleteByUrl(subscription.url);
                                } else if (subscription.isWhitelist) {
                                  await _whitelistService.importNumbersFromUrl(
                                      subscription.url);
                                  await _blacklistService
                                      .deleteByUrl(subscription.url);
                                }
                              } else {
                                await _subscriptionService
                                    .disableSubscription(subscription);
                                await _whitelistService
                                    .deleteByUrl(subscription.url);
                                await _blacklistService
                                    .deleteByUrl(subscription.url);
                              }
                              setState(() {});
                            },
                          )),
                      SizedBox(width: 8),
                      // Menu icon to show more options
                      IconButton(
                        icon: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            _expandedItems[subscription.name] = !isExpanded;
                          });
                        },
                      ),

                      // Add spacing between icons
                      SizedBox(width: 8),
                    ],
                  ),
                );
              },
              body: _buildExpandedContent(context, subscription),
              isExpanded: isExpanded,
            ),
          ],
        ),
      ],
    );
  }

  //void _showMoreOptions(BuildContext context, SubscriptionModel subscription) {
  Widget _buildExpandedContent(
      BuildContext context, SubscriptionModel subscription) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textFieldHeight = 14.0; // 设置文本字段的高度
    // 显示更多选项的逻辑
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
          Divider(height: 1),
          SizedBox(height: 10),
          // Blacklist/Whitelist options with adjusted padding
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Whitelist switch on the left
              Theme(
                data: shieldSwitchThemeData,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.only(top: 16, left: 16),
                  value: subscription.isWhitelist,
                  onChanged: (value) {
                    setState(() {
                      subscription.isWhitelist = value;
                      subscription.isBlacklist = false; // 确保互斥
                      if (subscription.isWhitelist) {
                        _subscriptionService
                            .addWhitelistSubscription(subscription);
                        _subscriptionService
                            .removeBlacklistSubscription(subscription);
                      } else {
                        _subscriptionService
                            .removeWhitelistSubscription(subscription);
                      }
                    });
                  },
                  title: Text(
                    subscription.isWhitelist ? '移除白名单订阅' : '加入白名单订阅',
                    style: whiteTextStyle,
                  ),
                ),
              ),
              Theme(
                data: shieldSwitchThemeData,
                child: SwitchListTile(
                  contentPadding: EdgeInsets.only(top: 16, right: 16),
                  value: subscription.isBlacklist,
                  onChanged: (value) {
                    setState(() {
                      subscription.isBlacklist = value;
                      subscription.isWhitelist = false; // 确保互斥
                      if (subscription.isBlacklist) {
                        _subscriptionService
                            .addBlacklistSubscription(subscription);
                        _subscriptionService
                            .removeWhitelistSubscription(subscription);
                      } else {
                        _subscriptionService
                            .removeBlacklistSubscription(subscription);
                      }
                    });
                  },
                  title: Text(
                    subscription.isBlacklist ? '移除黑名单订阅' : '加入黑名单订阅',
                    style: whiteTextStyle,
                  ),
                ),
              ),
            ],
          ),

          // Stateful widget to manage subscription name and URL
          // _SubscriptionNameAndUrl(
          //   subscription: subscription,
          //   subscriptionService: _subscriptionService,
          // ),
          Expanded(
            child: Container(
              width: screenWidth * 0.83, // width set to 83% of screen width
              height: textFieldHeight, // 设置为文本字段的高度
              child: TextFormField(
                initialValue: subscription.name,
                decoration: showmoreinputBoxDecoration.copyWith(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  labelStyle: showmoreTextStyle,
                ),
                style: showmoreTextStyle,
                // Update subscription name on _subscription change
                onChanged: (value) {
                  setState(() {
                    subscription.name = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(width: 16.0), // Spacing between buttons
          Expanded(
            child: Container(
              width: screenWidth * 0.83, // width set to 83% of screen width
              height: textFieldHeight, // 设置为文本字段的高度
              child: TextFormField(
                initialValue: subscription.url,
                decoration: showmoreinputBoxDecoration.copyWith(
                  labelText: 'Subscription Url',
                  border: OutlineInputBorder(),
                  labelStyle: showmoreTextStyle,
                ),
                style: showmoreTextStyle,
                // Update subscription name on _subscription change
                onChanged: (value) {
                  setState(() {
                    subscription.url = value;
                  });
                },
              ),
            ),
          ),
          Divider(height: 1),

          Row(
            //按钮最小均分
            mainAxisSize: MainAxisSize.min, // 让按钮最小
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 让按钮左右对齐

            children: [
              Expanded(
                child: ElevatedButton(
                  style: showmoreButtonStyle.copyWith(
                    // 设置按钮文字颜色,根据按钮状态
                    foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green; // 按下时的颜色
                        }
                        return null; // 默认颜色
                      },
                    ),
                  ),
                  onPressed: () {
                    _showDeleteConfirmation(
                        context, subscription); // Call confirmation method
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                    children: [
                      Icon(NewSet.delete), // 设置图标大小
                      SizedBox(width: 8.0),
                      Text(
                        'Delete',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.0), // Spacing between buttons

              Expanded(
                child: ElevatedButton(
                  style: showmoreButtonStyle,
                  onPressed: () {
                     setState(() {
                    // 切换状态
                    subscription.isAutoUpdate = !subscription.isAutoUpdate;
                   
                      if (subscription.isAutoUpdate) {

    _subscriptionService.autoUpdateSubscription(subscription);

}
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                    children: [
                      Icon(NewSet.autorenew, size: 24.0),
                      SizedBox(width: 8.0),
                      Text(
                        // 根据当前状态显示文本
                        subscription.isAutoUpdate ? '禁用自动更新' : '启用自动更新',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 16.0), // Spacing between buttons

              Expanded(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                    children: [
                      Icon(NewSet.check),
                      SizedBox(width: 8.0),
                      Text(
                        'Save',
                      ),
                    ],
                  ),
                  onPressed: () async {
                    await _subscriptionService.editSubscription(subscription);
                    // 根据订阅类型执行相应操作
                    if (subscription.isBlacklist) {
                      await _blacklistService.importNumbersFromUrl(subscription.url);
                    } else if (subscription.isWhitelist) {
                      await _whitelistService.importNumbersFromUrl(subscription.url);
                    }
                    setState(() {});
                    _expandedItems[subscription.name] = false;
                  },
                  style: showmoreButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, SubscriptionModel subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认删除'),
        content: Text('您确定要删除标签项 ${subscription.name} 吗？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog first

              // Perform deletion
              await _subscriptionService.deleteSubscription(subscription);

              // Update UI
              setState(() {});

              // Show SnackBar using a GlobalKey<ScaffoldState>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('删除成功')),
              );
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
  }
}


