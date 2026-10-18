import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_cache_provider.dart';
import 'package:yourcallyourrule/ads/ad_preload_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

    test('4. 验证 AdPreloadManager 单例与常用默认广告加载调用', () {
      final manager = AdPreloadManager.instance;
      expect(manager, isNotNull);

      // 验证常用预加载函数可以正常触发，不抛出同步异常
      expect(() => manager.preloadDefaultAds(), returnsNormally);
    });
  });
}
