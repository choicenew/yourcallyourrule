
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';


import '../../new_set_icons.dart';
import '../../screens/appstate_provider.dart';

import '../../services/blacklist_whitelist_service.dart';

import '../../services/subscription_service.dart';
import '../../utils/ad_manager.dart';
import '../../utils/ad_state.dart';
import '../../utils/create_card.dart';
import '../../widgets/adwidgets/native_ads.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/self_managed_search_bar.dart';
import '../Custom_3Button_Style.dart';

import '../public/build_page_switch.dart';
import '../public/responsive_grid_list.dart';
import '../shield_switch_style.dart';
import '../subpage_style.dart';


import 'add_subscription.dart';
import 'export_subscriptions.dart';
import 'import_subscriptions.dart';
/*
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
*/

/*
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
                                  await _blacklistService.importBlacklistNumbersFromUrl(
                                      subscription.url);
                                  await _whitelistService
                                      .deleteByUrl(subscription.url);
                                } else if (subscription.isWhitelist) {
                                  await _whitelistService.importWhitelistNumbersFromUrl(
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
                      await _blacklistService.importBlacklistNumbersFromUrl(subscription.url);
                    } else if (subscription.isWhitelist) {
                      await _whitelistService.importWhitelistNumbersFromUrl(subscription.url);
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
*/


class SubscriptionListView extends StatelessWidget {
  const SubscriptionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return buildPageWithCollapsibleContent(
      context,
      Intl.message("Subscription List Page"), // 页面标题
      Intl.message("SubscriptionListView"), // 卡片标题=点击卡片导航到的页面
      const SubscriptionListView(), // 点击卡片导航到的页面
      const SubscriptionList(), // 当前页面主要内容
      exportPage: const ExportSubscriptionsPageView(), // 导出页面
      exportLabel: Intl.message("Export"), // 自定义导出按钮文字
      addPage: const AddSubscriptionPageView(), // 添加页面
      addLabel: Intl.message("Add"), // 自定义 add 按钮文字
      importPage: const ImportSubscriptionsPageView(), // 导入页面
      importLabel: Intl.message("Import"), // 自定义导入按钮文字
    );
  }
}





class SubscriptionList extends StatefulWidget {
  const SubscriptionList({super.key});

  @override
  SubscriptionListState createState() => SubscriptionListState();
}

class SubscriptionListState extends State<SubscriptionList> with WidgetsBindingObserver {
  // final BlacklistService _subscriptionService =
  //     BlacklistService(database as Database);
   late BlacklistService _blacklistService;
  late WhitelistService _whitelistService;
  late SubscriptionService _subscriptionService;
  Map<int, bool> _expandedItems = {};
  List<SubscriptionModel> _subscriptions = [];
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
    _blacklistService = appState.blacklistService;
    _whitelistService = appState.whitelistService;
    _subscriptionService = appState.subscriptionService;
    _loadSubscriptions();
  }

  Future<void> _loadSubscriptions() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final subscriptions = await _subscriptionService.getAllSubscriptions(orderBy: 'id', ascending: true);
      setState(() {
        _subscriptions = subscriptions;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading subscriptions: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

bool _isWhitelist = false;
bool _isBlacklist = false;

  void _onSwitchChanged(bool newValue) {
    setState(() {
      if (_isWhitelist == newValue) {
        // 如果允许开关状态与传入的新值相同，说明是重复点击了相同的开关，无需进行任何操作
        return;
      }
      // 更新允许开关状态为传入的新值
      _isWhitelist = newValue;
      // 更新阻止开关状态为与允许相反
      _isBlacklist = !_isWhitelist;
    });
  }





@override
Widget build(BuildContext context) {
  return Scaffold(
    body: RefreshIndicator(
      onRefresh: _loadSubscriptions,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : AdvancedSelfManagedSearchBar<SubscriptionModel>(
     
              items: _subscriptions,
              itemBuilder: (context, subscription, width) => _buildSubscriptionItem(subscription, width),
              getSearchString: (subscription) => '${subscription.id} ${subscription.url} ${subscription.name}',
              getSortFields: (subscription) => ['ID', 'Url', 'Name'],
              getSortFieldValues: (subscription) => [subscription.id, subscription.url, subscription.name],
              originalBuilder: (context, items) => _build(context),
              //adBuilder: (width, height) => nativeAdWidgetSmall(adWidth: width, adHeight: height),
                        // 添加回调函数

            ),
    ),
  );
}


/*
  // 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
  final adState = Provider.of<AdState>(context);
          return OrientationBuilder(
            builder: (context, orientation) {
              final mediaQuery = MediaQuery.of(context);
              // 根据屏幕方向和宽度设置每行卡片数
              final int  subscriptionsPerRow = orientation == Orientation.portrait
                  ? (mediaQuery.size.width > 900 ? 2 : 1)
                  : (mediaQuery.size.width > 1000 ? 4 : 2);

              // 根据屏幕宽度设置水平 padding
              final double functionEntryHorizontalPadding =
                  mediaQuery.size.width > 900 ? 24.0 : 9.0;

              // 计算卡片宽度
              final double subscriptionWidth = (mediaQuery.size.width -
                      2 * functionEntryHorizontalPadding -
                      (subscriptionsPerRow - 1) * 10) /
                  subscriptionsPerRow;


return ListView(
  children: [
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: functionEntryHorizontalPadding,
      ),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.spaceBetween,
        // 使用 adState.isAdEnabled
        children: List.generate(_subscriptions.length + (adState.isAdEnabled ? _subscriptions.length ~/ 3 : 0), (index) {
          if ((index + 1) % 4 == 0 && adState.isAdEnabled) {
           return nativeAdWidgetSmall(adWidth: subscriptionWidth, adHeight: 90);

          } else {
            final adjustedIndex = index - (index ~/ 4);
            return SizedBox(
              width: subscriptionWidth,
                      child: _buildSubscriptionItem(_subscriptions[adjustedIndex], subscriptionWidth),
                    );
                  }
                }),
              ),
            ),
          ],
        );
      },
    );
  }
*/

// 私有的构建订阅列表方法
  Widget _build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    return buildResponsiveGridList(
        _subscriptions, _buildSubscriptionItem, adState.isAdEnabled);
  }


// 构建单个订阅项，并传入卡片宽度参数
Widget _buildSubscriptionItem(SubscriptionModel subscription, double subscriptionWidth) {
  return  Card(
    color: Colors.grey[100], // 设置背景色为浅灰色
margin: const EdgeInsets.all(10.0), // Adds 16 pixels of space between the card's content and its border
    child: ExpansionTile(
      key: ValueKey(subscription.id),
      initiallyExpanded: _expandedItems[subscription.id] ?? false,
      onExpansionChanged: (isExpanded) {
      //  setState(() {
          _expandedItems[subscription.id!] = isExpanded;
       // });
      },

      title: Text(
        subscription.name,
        style: entryTitleStyle,
        overflow: TextOverflow.ellipsis,
      ),
subtitle: Row(
  children: [
    Expanded( // 使用 Expanded 包裹 Text 控件
      child: Text(
        Intl.message(subscription.url),
        style: entryLabelStyle,
        maxLines: 1, // 设置最大行数为 1
        overflow: TextOverflow.ellipsis, // 使用省略号表示截断

      ),
    ),
  ],
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
          const SizedBox(width: 8),
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


        await _subscriptionService.manualUpdateSubscription(subscription);

 
    setState(() {}); // 更新状态
  },
),


IconButton(
  icon: subscription.enabled
      ? const Icon(Icons.toggle_on) // 或者其他表示启用的图标
      : const Icon(Icons.toggle_off), // 或者其他表示禁用的图标
  color: subscription.enabled ? Colors.green : Colors.grey, // 根据状态设置颜色
  onPressed: () async {
    subscription.enabled = !subscription.enabled; // 切换状态

    if (subscription.enabled) {
      await _subscriptionService.enableSubscription(subscription);
      // 根据订阅类型执行相应操作
      if (subscription.isBlacklist) {
        await _blacklistService.importNumbersFromUrl(subscription.url);
        await _whitelistService.deleteByUrl(subscription.url);
      } else if (subscription.isWhitelist) {
        await _whitelistService.importNumbersFromUrl(subscription.url);
        await _blacklistService.deleteByUrl(subscription.url);
      }
    } else {
      await _subscriptionService.disableSubscription(subscription);
      await _whitelistService.deleteByUrl(subscription.url);
      await _blacklistService.deleteByUrl(subscription.url);
    }

    setState(() {}); // 更新 UI
  },
),
                      const SizedBox(width: 8),          
          IconButton(
            icon: const Icon(Icons.delete),
            iconSize: 32.0,
            style: deleteButtonStyle,
            onPressed: () => _showDeleteConfirmation(context, subscription),
          ),
                      // 展开/折叠图标
            Icon(
              _expandedItems[subscription.id] == true 
                  ? Icons.expand_less 
                  : Icons.expand_more
            ),
        ],
      ),
      children: [
        _buildExpandedContent(context, subscription),
      ],
    ),


  );


}

  //void _showMoreOptions(BuildContext context, SubscriptionModel subscription) {
  Widget _buildExpandedContent(BuildContext context, SubscriptionModel subscription) {
        final TextEditingController nameController = TextEditingController(text: subscription.name);
    //新增加的url 路径
    final TextEditingController urlController = TextEditingController(text: subscription.url);
    // 显示更多选项的逻辑
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Divider
       
  const SizedBox(height: 10),


           const Divider(height: 1),
         
          // Blacklist/Whitelist options with adjusted padding
          Row(
    mainAxisSize: MainAxisSize.min, // 添加了 mainAxisSize
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // allowed switch on the left
              Expanded(
                // 或 Flexible
                child: Theme(
                data: shieldSwitchThemeData,
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.only(top: 16, left: 16),
                  value: _isWhitelist,
                  onChanged: _onSwitchChanged,
                  title: Text(
                  _isWhitelist ? Intl.message('Add to Whitelist') : Intl.message('Remove Whitelist'),
                    style: whiteTextStyle,
                  ),
                ),
              ),
              ),
              // blocked switch on the right
                 const SizedBox(width: 8.0),
               Expanded(
                // 或 Flexible
                child: Theme(
                data: shieldSwitchThemeData,
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.only(top: 16, right: 16),
                  value: _isBlacklist,
                  //onChanged: (value) => _onSwitchChanged(!value),
                  onChanged: _onSwitchChanged,
                  title: Text(
                   _isBlacklist ? Intl.message('Add to Blacklist') : Intl.message('Remove Blacklist'),
                    style: whiteTextStyle,
                  ),
                ),
              ),
              ),
            ],
          ),
                    const Divider(),
                    const SizedBox(height: 10.0),
       Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: showmoreinputBoxDecoration.copyWith(
                      labelText: Intl.message('Name'),
                      border: const OutlineInputBorder(),
                      //labelStyle: showmoreTextStyle,
                    ),
                    //style: showmoreTextStyle,
                  ),
                ),
             const SizedBox(height: 10.0),
 Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFormField(
                    controller: urlController,
                    decoration: showmoreinputBoxDecoration.copyWith(
                      labelText: Intl.message('Url'),
                      border: const OutlineInputBorder(),
                      //labelStyle: showmoreTextStyle,
                    ),
                    //style: showmoreTextStyle,
                  ),
                ),
      
         const Divider(),
const SizedBox(height: 10.0),
        
                // 或 Flexible
             Theme(
                data: customSwitchThemeData,
                child:          SwitchListTile(
  title: Text(
    subscription.isAutoUpdate ? Intl.message('Auto Update Enabled') : Intl.message('Auto Update Disabled'),
  ),
  value: subscription.isAutoUpdate,
  onChanged: (bool newValue) async{
    subscription.isAutoUpdate = newValue;
    if (newValue) {
    await  _subscriptionService.autoUpdateSubscription(subscription);
    } 
    setState(() {}); // 更新 UI 
  },
), 
              ),

         
      const SizedBox(height: 10.0),



    
            const GoogleAdWidget(adInfo: AdManager.bannerAd),      
 

          Row(
            //按钮最小均分
            mainAxisSize: MainAxisSize.min, // 让按钮最小
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 让按钮左右对齐
            children: [
              FilledButton(
                style: showmoreButtonStyle.copyWith(
                  // 设置按钮文字颜色,根据按钮状态
                  foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.green; // 按下时的颜色
                      }
                      return null; // 默认颜色
                    },
                  ),
                ),
                onPressed: () {
                  // 显示确认对话框
                  _showDeleteConfirmation(context, subscription);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                  children: [
                    const Icon(NewSet.delete), // 设置图标大小
                    const SizedBox(width: 8.0),
                    Text(
                      Intl.message('Delete'),
                    ),
                  ],
                ),
              ),






              const SizedBox(width: 16.0), // Spacing between buttons
              FilledButton(
                onPressed: () async {

                      final updatedSubscription = SubscriptionModel(
                        id: subscription.id,
                        name: nameController.text,
                        url: urlController.text,
                        enabled: subscription.enabled,
                        isWhitelist: _isWhitelist,
                        isBlacklist: _isBlacklist,
                        isAutoUpdate: subscription.isAutoUpdate,

                      );

await _subscriptionService.editSubscription(updatedSubscription);

                  if (_isWhitelist) {
                     await  _subscriptionService
                            .addWhitelistSubscription(updatedSubscription);                    
                     await  _subscriptionService
                            .removeBlacklistSubscription(updatedSubscription);
                  } else if (_isBlacklist) {
                    await   _subscriptionService
                            .addBlacklistSubscription(updatedSubscription);
                     await   _subscriptionService
                            .removeWhitelistSubscription(updatedSubscription);
                  }
                  await _loadSubscriptions();
                  // Additional action after saving (optional)
                  setState(() {
                    _expandedItems[subscription.id!] = false;
                  });
                },
                style: showmoreButtonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 按钮内容居中对齐
                  children: [
                    const Icon(NewSet.check),
                    const SizedBox(width: 8.0),
                    Text(
                      Intl.message('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }      
  





  void _showDeleteConfirmation(BuildContext context, SubscriptionModel subscription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Intl.message('Confirm Deletion')),
        content: Text(Intl.message('Are you sure you want to delete the  item ${subscription.id}?')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(Intl.message('Cancel')),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _subscriptionService.deleteSubscription(subscription);
              await _loadSubscriptions();
                          // 添加 setState 来更新 UI
            setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Intl.message('Deleted successfully'))),
              );
            },
            child: Text(Intl.message('OK')),
          ),
        ],
      ),
    );
  }

  
}


