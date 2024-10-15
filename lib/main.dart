import 'package:flutter/material.dart';
//import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' hide AppState;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';


import '../utils/language_provider.dart';
import 'screens/appstate_provider.dart';

import 'screens/callerID/callerid_overlay_entry.dart';
import 'screens/callerID/callerid_style_provider.dart';
import 'screens/homePage.dart';
import 'screens/onboarding.dart';

import 'shared/const/theme_config.dart';
import 'utils/ad_state.dart';
import 'generated/l10n.dart';

import 'utils/purchase_state.dart';
import 'utils/theme_provider.dart';
import 'views/sync/backup_restore_controller.dart';


//ceshi
@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => AdState()),
        ChangeNotifierProvider(create: (_) => PurchaseState()),
        ChangeNotifierProvider(
            create: (context) => createBackupRestoreController(context)),
        ChangeNotifierProvider(create: (context) => CallerIdStyleProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<LocaleProvider>(
        // Access the LocaleProvider to get the current locale
        builder: (context, localeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: localeProvider
                .locale, // Use the current locale from LocaleProvider
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate, (if needed)
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: CallerIdOverlayEntry(),
          );
        },
      ),
    ),
  );
}
//ceshi

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  bool onboardingCompleted =
      await asyncPrefs.getBool('onboarding_completed') ?? false;

  final appState = AppState();
  //await appState.initializeDatabases();
  await appState.initServices();
  // await appState.ensureServicesInitialized();

  await MobileAds.instance.initialize(); // 初始化 Google Mobile Ads SDK
  // 检查 onboarding 是否已经完成Check if onboarding is completed

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => LocaleProvider()), // Provide LocaleProvider
          ChangeNotifierProvider(
              create: (_) => AppState()), // 添加 AppState Provider
          ChangeNotifierProvider(
            create: (context) => AdState(),
          ), // 添加广告 AdState Provider
          ChangeNotifierProvider(
              create: (_) => PurchaseState()), // 添加内购purchase State Provider
          ChangeNotifierProvider(
            create: (context) => createBackupRestoreController(context),
          ), // 添加Controller Provider
          ChangeNotifierProvider(
            create: (context) => CallerIdStyleProvider(),
          ), // 添加caller id styler Provider
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ), // 添加caller id styler Provider
        ],
        child: MyApp(
          onboardingCompleted: onboardingCompleted, // 传递 onboarding 状态
        )),
  );
}



class MyApp extends StatelessWidget {
  final bool onboardingCompleted;

  const MyApp({super.key, required this.onboardingCompleted});



  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      // 使用 Consumer2 监听两个 Provider
      builder: (context, localeProvider, themeProvider, child) {
        return MaterialApp(
          title: 'Your Call Your Rule',
          debugShowCheckedModeBanner: false,
          theme: getTheme(themeProvider.themeMode), // 使用 getTheme 函数获取主题
          locale: localeProvider.locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: FlutterSplashScreen.scale(
            // 使用 FlutterSplashScreen.scale
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
              ],
            ),
            childWidget: SizedBox(
              height: 900,
              child: Image.asset("assets/app_logo.png"), // 替换成你的 logo
            ),
            duration: const Duration(milliseconds: 1500),
            animationDuration: const Duration(milliseconds: 1000),
            onAnimationEnd: () => debugPrint("On Scale End"),
            nextScreen: onboardingCompleted
                ? const MyHomePage()
                : OnboardingScreen(
                    onComplete: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
