

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/screens/reorderable_wrap.dart';

import '../generated/l10n.dart';
import '../utils/ad_manager.dart';
import '../utils/call_filter.dart';
import '../utils/repeated_call.dart';
import '../views/shield_switch_style.dart';
import '../widgets/adwidgets/native_ads.dart';
import '../widgets/google_ad.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/search_bar.dart';
import 'appstate_provider.dart';
import 'callerID/callerid_configuration.dart';
import 'callerID/callerid_style_provider.dart';
import 'custom_swiper/card.dart';
import 'custom_swiper/card_manager.dart';
import 'custom_swiper/custom_swiper.dart';
import 'function_cards/function_card.dart';
import 'function_cards/function_cards_data.dart';
import 'home_styles.dart';

//import 'scan_screen.dart';
// 全局变量，在任何地方都可以访问
double? pixelRatio;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CardManager _cardManager;
  late CallFilterConfig _config; //callfiter 的配置
  final TimeBasedInterceptor timeBasedInterceptor =
      TimeBasedInterceptor(); //重复来电配置

  late TimeBasedInterceptorConfig _timeBasedInterceptorconfig; //重复来电配置
  List<FunctionCard> cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cardManager = CardManager();

//独立的属于repeated的call的配置不同于前面的call filter的
    _loadInterceptorSettings();
    // 在 initState 中初始化 _config，确保初始值可用
    _config = CallFilterConfig();

    _initializeCards();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeServices();
      _pixelRatio();
      _loadConfig();
      _loadCallerIDConfiguration();
    });
  }

  Future<void> _initializeCards() async {
    await _loadCardOrder();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_pixelRatio();
    // 只在 didChangeDependencies 中加载配置和初始化服务

    _initializeServices();
  }

  void _pixelRatio() {
    if (pixelRatio == null || pixelRatio == 1.0) {
      double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      pixelRatio = devicePixelRatio >= 3.0 ? devicePixelRatio : 3.0;
      print("HomePage 中展示屏幕比例值: ${pixelRatio}");
    } // 只有在 pixelRatio 为 null 或 1.0 时才重新计算，否则保持原值
  }

  void _initializeServices() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = Provider.of<AppState>(context, listen: false);
      final callerIdMonitorService = appState.callerIdMonitorService;
      final smsFilterService = appState.smsFilterService;
      // callerIdMonitorService.initialize(context);
      smsFilterService.initialize();

      callerIdMonitorService.initialize(context);
    });
  }

  @override
  void dispose() {
    _cardManager.dispose();
    super.dispose();
  }

  void _loadConfig() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    final appState = Provider.of<AppState>(context, listen: false);
    final callFilter = appState.callFilter;

    // 从 CallFilter 加载配置
    callFilter.loadConfig().then((_) {
      // 配置加载完成后，更新 _config 并触发 UI 重建
      setState(() {
        _config = callFilter.config;
      });
    });
    // });
  }

  // 加载重复来电Interceptor配置
  Future<void> _loadInterceptorSettings() async {
    // 从 重复来电 加载配置
    await timeBasedInterceptor.loadConfig().then((_) {
      setState(() {
// 配置加载完成后，更新 _config 并触发 UI 重建
        _timeBasedInterceptorconfig = timeBasedInterceptor.config;
      });
    });
  }

  Future<void> _loadCardOrder() async {
    final asyncPrefs = SharedPreferencesAsync();
    final allCards = getFunctionCards();
    final order = await asyncPrefs.getStringList('cardOrder');

    if (order != null) {
      cards = order
          .map((title) => allCards.firstWhere((card) => card.title == title))
          .toList();
    } else {
      cards = allCards;
    }
  }

  Future<void> _saveCardOrder() async {
    final asyncPrefs = SharedPreferencesAsync();
    final order = cards.map((card) => card.title).toList();
    await asyncPrefs.setStringList('cardOrder', order);
  }

  Future<void> _loadCallerIDConfiguration() async {
    try {
      await ConfigurationManager.loadConfiguration(
          Provider.of<CallerIdStyleProvider>(context, listen: false));
    } catch (e) {
      print('Error loading Caller ID configuration: $e');
      // Create and save a default configuration
      await ConfigurationManager.saveConfiguration(
          Provider.of<CallerIdStyleProvider>(context, listen: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SafeArea(
              // 使用 SafeArea 避免白条
              child: Padding(
                padding: HomePaddingStyle.searchBarPadding.copyWith(
                  left: 0, // 将左右 padding 设置为 0
                  right: 0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width, // 撑满屏幕宽度
                  color: const Color.fromRGBO(10, 202, 109, 1),
                  child: const Column(
                    children: [
                      Padding(
                        padding: HomePaddingStyle.paddingTop,
                        child: Text(
                          'Your Call Your Rule',
                          style: logoTitleTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    //  SizedBox(height: 10), // 增加底部间距
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // 设置左右 padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: CustomSearchBar()),
                          ],
                        ),
                      ),
                      SizedBox(height: 20), // 增加底部间距
                    ],
                  ),
                ),
              ),
            ),
          ),

//展示滚动swiper card 的
          SliverToBoxAdapter(
            child: OrientationBuilder(
              // 使用 OrientationBuilder 判断屏幕方向
              builder: (context, constraints) {
                // 获取当前 MediaQuery
                final mediaQuery = MediaQuery.of(context);

                // 根据断点设置 cardWidth 和 cardHeight
                final cardWidth = mediaQuery.size.width < 600
                    ? mediaQuery.size.width * 0.95
                    : mediaQuery.size.width < 900
                        ? mediaQuery.size.width * 0.8
                        : mediaQuery.size.width * 0.5;
                final cardHeight =
                    cardWidth * (mediaQuery.size.width < 600 ? 0.7 : 0.6);

                return Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 0.0), // 根据需要调整 padding 大小
                    child: SizedBox(
                        width: cardWidth,
                        height: cardHeight,
                        child: FutureBuilder<List<CardItem>>(
                          future: _cardManager.getFinalCards(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomSwiper(
                                cards: snapshot.data!,
                                width: cardWidth,
                                height: cardHeight,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              ); // 显示加载指示器
                            }
                          },
                        )),
                  ),
                );
              },
            ),
          ),
          //加载广告
          const SliverToBoxAdapter(
            child: GoogleAdWidget(adInfo: AdManager.bannerAd),
          ),
          //加载间距
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0), // 设置垂直间距
          ),

//switch 开关
          SliverToBoxAdapter(
            child: OrientationBuilder(
              // 使用 OrientationBuilder 判断屏幕方向
              builder: (context, orientation) {
                final mediaQuery = MediaQuery.of(context);

                // 根据断点设置 cardWidth 和 cardHeight
                final containerdWidth = mediaQuery.size.width < 600
                    ? mediaQuery.size.width * 0.95
                    : mediaQuery.size.width < 900
                        ? mediaQuery.size.width * 0.9
                        : mediaQuery.size.width * 0.8;

                // 根据屏幕方向和宽度设置每行开关数量
                final int switchesPerRow = orientation == Orientation.portrait
                    ? (mediaQuery.size.width > 600 ? 2 : 1)
                    : (mediaQuery.size.width > 900 ? 4 : 2);
                // 根据屏幕宽度设置水平 padding
                final double switchHorizontalPadding =
                    mediaQuery.size.width > 600 ? 20.0 : 9.0;

                return Center(
                  child: ClipRRect(
                    // Add ClipRRect here
                    borderRadius: BorderRadius.circular(
                        20.0), // Adjust the radius value as needed
                    child: Container(
                        width: containerdWidth,
                        color: const Color.fromARGB(255, 11, 215, 116),
                        padding: EdgeInsets.symmetric(
                            horizontal: switchHorizontalPadding,
                            vertical: 10.0),
                        // 使用动态 padding
                        child: Theme(
                          // 添加 Theme widget
                          data: Theme.of(context).copyWith(
                            expansionTileTheme: ExpansionTileThemeData(
                              collapsedShape: Border.all(
                                  color: Colors.transparent), // 移除折叠时的边框
                              shape: Border.all(
                                  color: Colors.transparent), // 移除展开时的边框
                            ),
                          ),
                          child: ExpansionTile(
                            // 使用 ExpansionTile 包裹开关列表
                            title: Container(
                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.8), // 设置背景颜色，并设置透明度
                                borderRadius:
                                    BorderRadius.circular(35.0), // 设置圆角
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0), // 设置左右边距
                              padding: const EdgeInsets.only(
                                  left: 10, top: 5, right: 5.0, bottom: 5.0),
                              child: Text(
                                S.of(context).manageRules,
                                style: subtitleTextStyle,
                              ),
                            ),
                            initiallyExpanded: true, // 可以根据需要设置初始展开状态
                            children: [
                              const Divider(
                                height: 10,
                                color: Colors.white, // Set the color to white
                              ),
                              Padding(
                                // Add padding here around the Wrap
                                padding: const EdgeInsets.symmetric(
                                    //horizontal: switchHorizontalPadding,
                                    vertical: 13.0),

                                child: Wrap(
                                  spacing: 15.0, //横向
                                  runSpacing: 10.0, //纵向
                                  // alignment: WrapAlignment.spaceBetween, // 设置对齐方式为 spaceBetween
                                  children: _buildSwitchList(
                                      context,
                                      switchesPerRow,
                                      switchHorizontalPadding,
                                      containerdWidth),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
          //加载间距
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0), // 设置垂直间距
          ),
          //加载广告

          // ... inside your SliverToBoxAdapter ...

          SliverToBoxAdapter(
            child: nativeAdWidgetMedium(adWidth: 320, adHeight: 350),
          ),

          //加载间距
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0), // 设置垂直间距
          ),
          //加载function cards

          SliverToBoxAdapter(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : OrientationBuilder(
                    // 使用 OrientationBuilder 判断屏幕方向
                    builder: (context, orientation) {
                      final mediaQuery = MediaQuery.of(context);
                      const double cardRatio = 3.1 / 1.3;

                      // 根据屏幕方向和宽度设置每行卡片数
                      final int cardsPerRow =
                          orientation == Orientation.portrait
                              ? (mediaQuery.size.width > 600 ? 3 : 2)
                              : (mediaQuery.size.width > 900 ? 6 : 3);
                      // 根据屏幕宽度设置水平 padding
                      final double functionCardHorizontalPadding =
                          mediaQuery.size.width > 600 ? 20.0 : 9.0;

                      // 计算卡片宽度，注意这里使用 horizontalPadding,*16 是
                      final double cardWidth = (mediaQuery.size.width -
                              2 * functionCardHorizontalPadding -
                              (cardsPerRow - 1) * 9) /
                          cardsPerRow;
                      final double cardHeight = cardWidth / cardRatio;

                      return Align(
                          // 使用 Padding 包裹 ReorderableWrap
                          alignment: Alignment.center, // 设置居中对齐
                          //margin: EdgeInsets.symmetric(horizontal: functionCardHorizontalPadding),
                          child: ReorderableWrap(
                            spacing: 9,
                            runSpacing: 16,
                            //动态边距
                            padding: EdgeInsets.symmetric(
                              horizontal: functionCardHorizontalPadding,
                            ),
                            children: cards.map((card) {
                              return SizedBox(
                                key: ValueKey(card.title),
                                width: cardWidth,
                                height: cardHeight,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => card.page),
                                  ),
                                  child: card,
                                ),
                              );
                            }).toList(),
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final item = cards.removeAt(oldIndex);
                                cards.insert(newIndex, item);
                              });
                              _saveCardOrder();
                            },
                          ));
                    },
                  ),
          ),
          //加载间距
          const SliverToBoxAdapter(
            child: SizedBox(height: 16.0), // 设置垂直间距
          ),
          //加载广告
          SliverToBoxAdapter(
            child: nativeAdWidgetMedium(adWidth: 320, adHeight: 320),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  List<Widget> _buildSwitchList(BuildContext context, int switchesPerRow,
      double switchHorizontalPadding, double containerdWidth) {
    final List<Widget> switchList = [];

    // 计算可用宽度，减去 padding 和 spacing
    final mediaQuery = MediaQuery.of(context);
    final availableWidth = containerdWidth -
        2 * switchHorizontalPadding -
        (switchesPerRow - 1) * 15; // 5.0 是 Wrap 的 spacing

    final switchWidth = (availableWidth / switchesPerRow) * 0.95;

    final List<Map<String, dynamic>> switchData = [
      {
        'key': 'allowAllAllowedNumbers',
        'title': S.of(context).allowAllAllowedNumbers
      },
      {
        'key': 'allowRegexWhitelistedPatterns',
        'title': S.of(context).allowRegexWhitelistedPatterns
      },
      {
        'key': 'allowAllWhitelistedNumbers',
        'title': S.of(context).allowAllWhitelistedNumbers
      },
      {
        'key': 'allowBlockedNumbers',
        'title': S.of(context).allowBlockedNumbers
      },
      {
        'key': 'allowRegexBlacklistedPatterns',
        'title': S.of(context).allowRegexBlacklistedPatterns
      },
      {
        'key': 'allowAllBlacklistedNumbers',
        'title': S.of(context).allowAllBlacklistedNumbers
      },
      {'key': 'rejectAllNumbers', 'title': S.of(context).rejectAllNumbers},
      //独立的属于repeated的call的配置不同于前面的call filter的
      {
        'key': 'shouldIntercept',
        'title':
            '${S.of(context).repeatedBlockedCallsIn} ${_timeBasedInterceptorconfig.duration.inMinutes} ${S.of(context).mins}',
      },
    ];

    for (int i = 0; i < switchData.length; i++) {
      switchList.add(
        SizedBox(
          width: switchWidth,
          child: _buildSwitch(switchData[i]['key'], switchData[i]['title']),
        ),
      );

      // 只在非最后一列且不是最后一个元素时添加行间距
      if ((i + 1) % switchesPerRow != 0 && (i + 1) != switchData.length) {
        switchList.add(const SizedBox(width: 0.0, height: 1.0));
      }
    }

    return switchList;
  }

  Widget _buildSwitch(String key, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            _getConfigValue(key)
                ? '$title (${S.of(context).accept})' // 翻译 Accept
                : '$title (${S.of(context).reject})', // 翻译 Reject
            style: const TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
        Theme(
          data: switchThemeData,
          child: Switch(
            value: _getConfigValue(key),
            onChanged: (bool value) => _handleConfigChange(key, value),
          ),
        ),
      ],
    );
  }

  void _handleConfigChange(String key, bool value) {
    setState(() {
      switch (key) {
        case 'rejectAllNumbers':
          _config.rejectAllNumbers = value;
          print(
              "_config.rejectAllNumbers updated to: ${_config.rejectAllNumbers}"); // 添加打印日志
          break;
        case 'allowAllAllowedNumbers':
          _config.allowAllAllowedNumbers = value;
          break;
        case 'allowBlockedNumbers':
          _config.allowBlockedNumbers = value;
          break;
        case 'allowRegexWhitelistedPatterns':
          _config.allowRegexWhitelistedPatterns = value;
          break;
        case 'allowAllWhitelistedNumbers':
          _config.allowAllWhitelistedNumbers = value;
          break;
        case 'allowRegexBlacklistedPatterns':
          _config.allowRegexBlacklistedPatterns = value;
          break;
        case 'allowAllBlacklistedNumbers':
          _config.allowAllBlacklistedNumbers = value;
          break;
        //独立的属于repeated的call的配置不同于前面的call filter的
        case 'shouldIntercept':
          _timeBasedInterceptorconfig.shouldIntercept = value;
          // timeBasedInterceptor.updateShouldIntercept(value); // 更新 _timeBasedInterceptor 的配置
          break;
      }
    });
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    final appState = Provider.of<AppState>(context, listen: false);
    final callFilter = appState.callFilter;
    callFilter.updateConfig(_config);
    callFilter.saveConfig();

    //   });
    timeBasedInterceptor
        .updateShouldIntercept(_timeBasedInterceptorconfig.shouldIntercept);
  }

  bool _getConfigValue(String key) {
    switch (key) {
      case 'rejectAllNumbers':
        return _config.rejectAllNumbers;
      case 'allowAllAllowedNumbers':
        return _config.allowAllAllowedNumbers;
      case 'allowBlockedNumbers':
        return _config.allowBlockedNumbers;
      case 'allowRegexWhitelistedPatterns':
        return _config.allowRegexWhitelistedPatterns;
      case 'allowAllWhitelistedNumbers':
        return _config.allowAllWhitelistedNumbers;
      case 'allowRegexBlacklistedPatterns':
        return _config.allowRegexBlacklistedPatterns;
      case 'allowAllBlacklistedNumbers':
        return _config.allowAllBlacklistedNumbers;
      //独立的属于repeated的call的配置不同于前面的call filter的
      case 'shouldIntercept':
        return _timeBasedInterceptorconfig.shouldIntercept;
      default:
        return false;
    }
  }
}
