import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_cache_provider.dart';
import 'package:yourcallyourrule/ads/ad_preload_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    // 模拟 Google Mobile Ads 原生 MethodChannel，防止纯 JVM 单元测试环境抛出 MissingPluginException
    const MethodChannel channel = MethodChannel('plugins.flutter.io/google_mobile_ads');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return null;
    });
  });

  group('Google AdMob 官方测试 ID 与规则验证单元测试', () {
    test('1. 验证 Google 官方公开测试 ID 格式与配置正确', () {
      expect(AdManager.testBannerAd.adUnitId, equals('ca-app-pub-3940256099942544/6300978111'));
      expect(AdManager.testAdaptiveBannerAd.adUnitId, equals('ca-app-pub-3940256099942544/9214589741'));
      expect(AdManager.testNativeAdvancedAd.adUnitId, equals('ca-app-pub-3940256099942544/2247696110'));
      expect(AdManager.testInterstitialAd.adUnitId, equals('ca-app-pub-3940256099942544/1033173712'));
      expect(AdManager.testRewardedAd.adUnitId, equals('ca-app-pub-3940256099942544/5224354917'));
      expect(AdManager.testAppOpenAd.adUnitId, equals('ca-app-pub-3940256099942544/9257395921'));
      
      expect(AdManager.testBannerAd.size, equals(AdSize.banner));
      expect(AdManager.testBannerAd.type, equals(AdType.banner));
    });

    test('2. 验证 AdCacheState 状态拷贝与状态迁移逻辑', () {
      const initialState = AdCacheState();
      expect(initialState.isStarted, isFalse);
      expect(initialState.isLoaded, isFalse);
      expect(initialState.isFailed, isFalse);
      expect(initialState.bannerAd, isNull);

      final startedState = initialState.copyWith(isStarted: true);
      expect(startedState.isStarted, isTrue);
      expect(startedState.isLoaded, isFalse);

      final failedState = startedState.copyWith(isFailed: true, isLoaded: false);
      expect(failedState.isFailed, isTrue);
      expect(failedState.isLoaded, isFalse);
    });

    test('3. 验证 PreloadedAdWrapper 3小时/4小时过期判定逻辑', () {
      final freshWrapper = PreloadedAdWrapper(
        ad: null,
        loadTime: DateTime.now(),
      );
      expect(freshWrapper.isExpired, isFalse);

      final expiredWrapper = PreloadedAdWrapper(
        ad: null,
        loadTime: DateTime.now().subtract(const Duration(hours: 4)),
      );
      expect(expiredWrapper.isExpired, isTrue);
    });

    test('4. 验证 AdPreloadManager 单例与全局实例暴露', () {
      final manager = AdPreloadManager.instance;
      expect(manager, isNotNull);
      expect(identical(manager, AdPreloadManager.instance), isTrue);
    });

    test('5. 仿真模拟：动态滑动窗口消费速度预测算法 (闲置=1 ➔ 高频扩容=2 ➔ 闲置恢复=1)', () {
      final manager = AdPreloadManager.instance;
      const testUnitId = 'ca-app-pub-3940256099942544/6300978111';
      manager.clearConsumptionForTesting(testUnitId);

      // A. 闲置状态：无高频消耗 ➔ 预测容量上限必须为 1（100% 遵循谷歌 1~2 规范）
      expect(manager.calculateAdaptiveCapacityForTesting(testUnitId), equals(1));

      // B. 模拟用户快速刷卡片（10 秒内产生 2 次消费）
      final now = DateTime.now();
      manager.simulateConsumptionForTesting(testUnitId, customTime: now);
      manager.simulateConsumptionForTesting(testUnitId, customTime: now.add(const Duration(seconds: 1)));

      // 高频刷卡片激活 ➔ 预测算法检测到 2次/10s 消耗 ➔ 动态扩容至容量 2！
      expect(manager.calculateAdaptiveCapacityForTesting(testUnitId), equals(2));

      // C. 模拟用户停止刷卡片（重新清理并模拟 15 秒前的一次消费）
      manager.clearConsumptionForTesting(testUnitId);
      manager.simulateConsumptionForTesting(testUnitId, customTime: now.subtract(const Duration(seconds: 15)));

      // 超过 10 秒无新高频消费 ➔ 预测算法自动平滑收缩容量归一至 1！
      expect(manager.calculateAdaptiveCapacityForTesting(testUnitId), equals(1));
    });
  });
}
