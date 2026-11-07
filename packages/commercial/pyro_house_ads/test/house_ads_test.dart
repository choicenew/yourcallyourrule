import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_house_ads/pyro_house_ads.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testMatrixApps = [
    const MatrixAppItem(
      packageName: 'com.pyro.wallpaper',
      titleKey: 'wallpaperTitle',
      descKey: 'wallpaperDesc',
      vipRoute: '/wallpaper_vip',
      weight: 100,
    ),
    const MatrixAppItem(
      packageName: 'com.pyro.novel',
      titleKey: 'novelTitle',
      descKey: 'novelDesc',
      vipRoute: '/novel_vip',
      weight: 50,
    ),
    const MatrixAppItem(
      packageName: 'com.pyro.comic',
      titleKey: 'comicTitle',
      descKey: 'comicDesc',
      vipRoute: '/comic_vip',
      weight: 50,
    ),
  ];

  group('MatrixAdArbitrator Tests', () {
    test('Correctly identifies primary app and filters cross promo apps', () {
      final arbitrator = MatrixAdArbitrator(
        currentPackageName: 'com.pyro.wallpaper',
        matrixApps: testMatrixApps,
      );

      expect(arbitrator.primaryApp, isNotNull);
      expect(arbitrator.primaryApp!.packageName, equals('com.pyro.wallpaper'));

      expect(arbitrator.crossPromoApps.length, equals(2));
      expect(
        arbitrator.crossPromoApps.map((a) => a.packageName),
        containsAll(['com.pyro.novel', 'com.pyro.comic']),
      );
      expect(
        arbitrator.crossPromoApps.map((a) => a.packageName),
        isNot(contains('com.pyro.wallpaper')),
      );
    });
  });

  group('HouseAdScheduler Tests', () {
    test('Selects both primary IAP and cross promo based on user state', () {
      final arbitrator = MatrixAdArbitrator(
        currentPackageName: 'com.pyro.wallpaper',
        matrixApps: testMatrixApps,
      );
      final scheduler = HouseAdScheduler(arbitrator: arbitrator);

      final decision = scheduler.selectNextAd(userState: UserAdState.active);
      expect(decision, isNotNull);
      expect(decision.item, isNotNull);
    });
  });

  group('HouseAdsManager Tests', () {
    test('Manager initializes properly', () {
      final manager = HouseAdsManager.instance;
      manager.init(
        currentPackageName: 'com.pyro.wallpaper',
        matrixApps: testMatrixApps,
        stringResolver: (context, key) => 'Translated: $key',
      );

      expect(manager.arbitrator, isNotNull);
      expect(manager.scheduler, isNotNull);
    });
  });

  group('HouseAdAdaptiveCard Widget Tests', () {
    testWidgets('Renders anchoredBanner with gradient and title', (tester) async {
      final arbitrator = MatrixAdArbitrator(
        currentPackageName: 'com.pyro.wallpaper',
        matrixApps: testMatrixApps,
      );
      final decision = arbitrator.createDecision(arbitrator.primaryApp!);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HouseAdAdaptiveCard(
              decision: decision,
              slotType: HouseAdSlotType.anchoredBanner,
              stringResolver: (context, key) => 'Resolved $key',
            ),
          ),
        ),
      );

      expect(find.text('Resolved wallpaperTitle'), findsOneWidget);
    });
  });

  group('PyroHouseAdsAdapter Tests', () {
    test('Implements NetworkAdapter contract correctly', () async {
      final adapter = PyroHouseAdsAdapter();

      expect(adapter, isA<NetworkAdapter>());
      expect(adapter.providerId, equals(AdProviderToken.houseAds));
      expect(adapter.providerName, equals('Pyro House Ads'));
      expect(adapter.getTestBannerId(), equals('test_house_banner'));
      expect(adapter.getTestNativeId(), equals('test_house_native'));
      expect(adapter.getTestInterstitialId(), equals('test_house_interstitial'));
      expect(adapter.getTestRewardedId(), equals('test_house_rewarded'));

      await adapter.initialize({});
      await adapter.loadInterstitial('placement');
      await adapter.loadRewarded('placement');
      await adapter.loadAppOpen('placement');
      await adapter.showAppOpen();

      MagmaRewardItem? rewarded;
      await adapter.showRewarded((item) => rewarded = item);
      expect(rewarded, isNotNull);
      expect(rewarded!.amount, equals(1));
    });

    testWidgets('buildBanner and buildNative return HouseAdWidget', (tester) async {
      final adapter = PyroHouseAdsAdapter();

      final bannerWidget = adapter.buildBanner('');
      expect(bannerWidget, isA<HouseAdWidget>());

      final nativeWidget = adapter.buildNative('', NativeStyle.medium);
      expect(nativeWidget, isA<HouseAdWidget>());
    });
  });
}

