# 重要：原生广告使用说明

## 问题说明

原生广告（NativeAd）的 Factory 必须在 `MobileAds.instance.initialize()` **之后**注册，否则会出现以下错误：

```
PlatformException(NativeAdError, No NativeAdFactory with id: fullScreenAdFactory or nativeTemplateStyle)
```

## 正确的初始化顺序 ✅

在你的 `main.dart` 中：

```dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ads_package/ads_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. 初始化广告配置
  AdManager.initialize(AdConfig.test());
  
  // 2. 初始化 Google Mobile Ads
  await MobileAds.instance.initialize();
  
  // 3. 【关键】注册 NativeAdFactory
  await AdManager.registerNativeAdFactories();
  
  runApp(MyApp());
}
```

## ⚠️ 错误的方式

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  AdManager.initialize(AdConfig.test());
  
  // ❌ 错误：没有先初始化 MobileAds
  // ❌ 错误：没有注册 Factory
  
  runApp(MyApp());
}
```

## 为什么需要这样做？

1. **顺序依赖**：`GoogleMobileAdsPlugin` 必须先初始化，然后才能注册 Factory
2. **插件架构**：Flutter 的插件系统无法保证插件间的初始化顺序
3. **手动控制**：通过 `AdManager.registerNativeAdFactories()` 让你明确控制注册时机

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ads_package/ads_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 配置广告
  AdManager.initialize(const AdConfig(
    bannerAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    adaptiveBannerAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    interstitialAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    rewardedInterstitialAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    rewardedAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    nativeAdvancedAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
    appOpenAdId: 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY',
  ));
  
  // 初始化广告 SDK
  await MobileAds.instance.initialize();
  
  // 注册原生广告 Factory
  await AdManager.registerNativeAdFactories();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ads Package Demo')),
        body: ListView(
          children: [
            // Banner 广告
            GoogleAdWidget(adInfo: AdManager.bannerAd),
            
            const SizedBox(height: 20),
            
            // 原生全屏广告 - 现在可以正常工作了！
            nativeAdWidgetFullScreen(),
            
            const SizedBox(height: 20),
            
            // 原生自适应卡片广告
            nativeAdWidgetAdaptiveCard(
              width: MediaQuery.of(context).size.width - 32,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
```

## 故障排查

如果仍然遇到 `No NativeAdFactory` 错误：

1. **检查顺序**：确保 `MobileAds.instance.initialize()` 在 `registerNativeAdFactories()` 之前
2. **使用 await**：两个初始化方法都应该使用 `await`
3. **检查 factoryId**：确保 Dart 代码中的 factoryId 与插件注册的一致：
   - `fullScreenAdFactory`
   - `adaptiveCardAdFactory`

## 测试环境

开发时使用测试配置：

```dart
AdManager.initialize(AdConfig.test());
```

生产环境切换为真实 ID：

```dart
AdManager.initialize(const AdConfig(
  bannerAdId: 'ca-app-pub-YOUR_PUBLISHER_ID/YOUR_BANNER_ID',
  // ... 其他真实 ID
));
```
