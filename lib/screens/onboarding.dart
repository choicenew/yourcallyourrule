import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';
import '../utils/app_data_collection.dart';
import '../utils/call_screen_plugin.dart';
import '../utils/language_provider.dart';
import 'appstate_provider.dart';
import 'callerID/callerid_configuration.dart';
import 'callerID/callerid_style_provider.dart';
import 'home_page.dart';
import 'language_data.dart';


class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    AnalyticsService.init();
        // 保存默认配置
  _loadCallerIDConfiguration(); 
  }



  // 显示进度条
// 显示进度条
  Widget _buildLoadingIndicator(AppState appState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
            child: ValueListenableBuilder<double>(
              valueListenable: appState.initializationProgress,
              builder: (context, value, child) {
                return LinearProgressIndicator(value: value);
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).initializing,
          ),
        ],
      ),
    );
  }

  // 新建的函数，用来显示加载指示器
  Widget _databaseLoadingIndicator(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (!appState.isDatabaseInitialized) {
          // 只在初始化过程中显示
          return Center(
            child: _buildLoadingIndicator(appState),
          );
        }
        return Container(); // 其他情况不返回任何内容
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _buildDatabaseInitializationPage(),
                ),
              ),
              PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildLanguageSelectionPage(),
                  _buildFeaturePage(1),
                  _buildPermissionRequestPage(),
                  _buildFeaturePage(3),
                  _buildDefaultCallerIDRequestPage(),
                  _buildFeaturePage(5),
                ],
              ),
              Positioned(
                top: 90,
                right: 20,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: Text(S.of(context).skip,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(147, 203, 128, 1))),
                ),
              ),
              _buildNavigationButton(orientation),
              Positioned(
                bottom: 150,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: _buildPageIndicator(),
                ),
              ),

              /*     Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                   child: _databaseLoadingIndicator(context),
                ),

              ),


                      if (!appState.isDatabaseInitialized) // 仅在初始化时显示
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildDatabaseInitializationPage(),
          ), */
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavigationButton(Orientation orientation) {
    // 使用与 _buildPageIndicator 相同的逻辑计算总页数
    int totalPages = _calculateTotalPages();

    // 根据当前页面决定按钮显示的文字
    String buttonText = _currentPage == totalPages - 1
        ? S.of(context).getStarted
        : S.of(context).next;

    final button = FilledButton(
      onPressed: _currentPage == totalPages - 1
          ? _finishOnboarding
          : () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
      style: FilledButton.styleFrom(
       // backgroundColor: const Color.fromRGBO(147, 203, 128, 1),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(buttonText),
    );

    // 根据屏幕方向和大小选择不同的 Positioned 属性
    if (orientation == Orientation.portrait) {
      // 竖屏时位于屏幕下方居中
      return Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: Center(child: button),
      );
    } else {
      // 横屏时位于屏幕右侧
      return Positioned(
        top: MediaQuery.of(context).size.height / 2 - 30,
        right: 20,
        child: button,
      );
    }
  }

  Widget _buildPageIndicator() {
    int totalPages = _calculateTotalPages();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? const Color.fromRGBO(255, 128, 149, 1)
                : const Color.fromRGBO(255, 128, 149, 1).withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  int _calculateTotalPages() {
    if (_pageController.hasClients &&
        _pageController.position.maxScrollExtent > 0) {
      // Calculate total pages based on the maximum scroll extent of the page controller
      return (_pageController.position.maxScrollExtent /
                  _pageController.position.viewportDimension)
              .ceil() +
          0;
    } else {
      return 1; // Default to at least one page
    }
  }

  Widget _buildDatabaseInitializationPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<AppState>(
            builder: (context, appState, _) {
              // 根据进度值设置进度条颜色
              Color progressColor = Colors.blue;
              if (appState.initializationProgress.value >= 0.8) {
                progressColor = Colors.green;
              } else if (appState.initializationProgress.value >= 0.5) {
                progressColor = Colors.orange;
              }

              return Column(
                children: [
                  // 使用 AnimatedBuilder 创建动画效果
                  AnimatedBuilder(
                    animation: appState.initializationProgress,
                    builder: (context, _) {
                      return LinearProgressIndicator(
                        value: appState.initializationProgress.value,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(progressColor),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${S.of(context).initializingDatabase} ${(appState.initializationProgress.value * 100).toInt()}%',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // if (!appState.isDatabaseInitialized)
                  Text(
                    S.of(context).pleaseWaitForDatabaseInitializationToComplete,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }



  Widget _buildLanguageSelectionPage() {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        Locale currentLocale = localeProvider.locale;

        // 确保当前语言代码在语言列表中，否则使用默认值
        if (!languages.any((lang) => lang['code'] == currentLocale)) {
          currentLocale = const Locale('en', 'US');
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).chooseYourLanguage,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownButton<Locale>(
                // 将类型改为 Locale
                value: currentLocale,
                items: languages.map((language) {
                  return DropdownMenuItem<Locale>(
                    // 将类型改为 Locale
                    value: language['code']!,
                    child: Text(language['name']!),
                  );
                }).toList(),
                onChanged: (Locale? newValue) {
                  // 将类型改为 Locale?
                  if (newValue != null) {
                    localeProvider.updateLocale(newValue);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //  新增： 权限请求页面
  Widget _buildPermissionRequestPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_in_picture, size: 80, color: Colors.green),
          const SizedBox(height: 20),
          Text(
            S.of(context).enableOverlayPermission,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${S.of(context).thisPermissionIsRequiredForOurAppToDisplayImportant}\n\n${S.of(context).pleaseTapGrantPermissionAndAllowThePermissionInThe}",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: () async {
              // 使用 permission_handler 请求 SYSTEM_ALERT_WINDOW 权限
              PermissionStatus status =
                  await Permission.systemAlertWindow.request();

              if (status.isGranted) {
                // 权限已授予
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context).youHaveEnabledThePermission),
                  ),
                );
              } else {
                // 权限被拒绝或出现错误
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S
                        .of(context)
                        .overlayPermissionNotGrantedWhichMayAffectTheCallerId),
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),

            ),
            child: Text(S.of(context).grantPermission),
          ),
        ],
      ),
    );
  }

 
 
  //  新增： 默认caller ID请求页面
  Widget _buildDefaultCallerIDRequestPage() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.verified_user, size: 80, color: Colors.green),
        
        const SizedBox(height: 20),
        Text(
          S.of(context).setupDefaultCallerIdApp,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "${S.of(context).thisPermissionIsRequiredForOurAppToBeThe}\n\n${S.of(context).pleaseTapSetupDefaultAndAllowThePermissionInThe}",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        FilledButton(
          onPressed: () async {
            try {
              bool result =
                  await CallScreeningPlugin.requestCallScreeningRole();
              // 新增： 显示 Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result
                      ? S.of(context).callScreeningRoleRequestSuccessful
                      : S.of(context).callScreeningRoleRequestFailed),
                ),
              );
            } catch (e) {
              //print("Error requesting call screening role: $e");
              // 新增： 显示 Snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      '${S.of(context).errorRequestingCallScreeningRole} $e'),
                ),
              );
            }
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: Text(S.of(context).setupDefault),
        ),
      ]),
    );
  }

  Widget _buildFeaturePage(int pageIndex) {
    // String title = '${S.of(context).feature} $pageIndex';
    String title;
    String description;

    // 使用 switch 语句根据 pageIndex 设置不同的描述
    switch (pageIndex) {
      case 1:
        title = S.of(context).feature1;
        description = S.of(context).descriptionFeature1;
        break;
      case 3:
        title = S.of(context).feature2;
        description = S.of(context).descriptionFeature2;
        break;
      case 5:
        title = S.of(context).feature3;
        description = S.of(context).descriptionFeature3;
        break;
      default:
        title = '${S.of(context).feature} $pageIndex'; // 默认标题
        description = '${S.of(context).featureDescription} $pageIndex.'; // 默认描述
    }
    String imagePath = 'assets/feature$pageIndex.png';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    await asyncPrefs.setBool('onboarding_completed', true);

    // if (mounted) {
    // Add this check
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const MyHomePage(),
    ));
    // }
  }



Future<void> _loadCallerIDConfiguration() async {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  bool onboardingCompleted = await asyncPrefs.getBool('onboarding_completed') ?? false;

  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_config.json');

    if (!onboardingCompleted || !await file.exists()) { 
      // 首次加载或配置文件不存在，使用默认配置
      await ConfigurationManager.saveConfiguration(
          Provider.of<CallerIdStyleProvider>(context, listen: false)); 
      // 保存默认配置，以便下次启动时加载
    } else {
      // 配置文件已存在，加载用户自定义配置
      await ConfigurationManager.loadConfiguration(
          Provider.of<CallerIdStyleProvider>(context, listen: false));
    }
  } catch (e) {
   // print('检查或保存默认配置出错: $e');
  }
}

}
