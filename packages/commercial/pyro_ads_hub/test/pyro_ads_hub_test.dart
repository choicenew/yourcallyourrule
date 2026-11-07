import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';

class MockMockAdapter implements NetworkAdapter {
  final String _id;
  final String _name;
  bool isInterstitialLoaded = false;
  bool isRewardedLoaded = false;
  bool isAppOpenLoaded = false;

  MockMockAdapter(this._id, this._name);

  @override
  String get providerId => _id;

  @override
  String get providerName => _name;

  @override
  Future<void> initialize(Map<String, dynamic> config) async {}

  @override
  Widget buildBanner(String placementId) => Text('Banner: $placementId');

  @override
  Widget buildNative(String placementId, NativeStyle style) => Text('Native: $placementId');

  @override
  Future<void> loadInterstitial(String placementId) async {
    isInterstitialLoaded = true;
  }

  @override
  Future<void> showInterstitial() async {}

  @override
  Future<void> loadRewarded(String placementId) async {
    isRewardedLoaded = true;
  }

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {
    onReward(const MagmaRewardItem(100, 'gems'));
  }

  @override
  Future<void> loadAppOpen(String placementId) async {
    isAppOpenLoaded = true;
  }

  @override
  Future<void> showAppOpen() async {}

  @override
  String? getTestBannerId() => 'test_banner_id';
  @override
  String? getTestNativeId() => 'test_native_id';
  @override
  String? getTestInterstitialId() => 'test_interstitial_id';
  @override
  String? getTestRewardedId() => 'test_rewarded_id';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AdsHub.instance.clear();
  });

  test('AdsHub registers and retrieves drivers correctly', () {
    final hub = AdsHub.instance;
    final mockAdMob = MockMockAdapter('admob', 'AdMob Driver');

    hub.register(mockAdMob);

    expect(hub.availableProviders, contains('admob'));
    expect(hub.getDriver('admob'), equals(mockAdMob));
    expect(hub.getDriverByTier(AdTrafficTier.tier1), equals(mockAdMob));
  });

  test('WaterfallStrategyArbitrator resolves available adapters with fallback', () {
    final hub = AdsHub.instance;
    final mockHouse = MockMockAdapter('house_ads', 'House Ads Driver');

    hub.register(mockHouse);

    final resolved = hub.arbitrator.resolveAvailableAdapter(AdTrafficTier.tier1);
    expect(resolved, equals(mockHouse));
  });

  test('AdsHub stores and retrieves AdsConfig production IDs correctly', () {
    final hub = AdsHub.instance;
    const config = AdsConfig(
      admobBannerId: 'prod_admob_banner_123',
      liftoffBannerId: 'prod_liftoff_banner_456',
    );

    hub.setProductionConfig(config);
    expect(hub.adsConfig, equals(config));
    expect(hub.getPlacementId(AdProviderToken.admob, AdSlotType.anchoredBanner), equals('prod_admob_banner_123'));
  });

  testWidgets('AdsBanner & AdsNative render widgets via AdsHub arbitration', (tester) async {
    final mockAdMob = MockMockAdapter('admob', 'AdMob Driver');
    AdsHub.instance.register(mockAdMob);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              AdsBanner(tier: AdTrafficTier.tier1),
              AdsInlineBanner(tier: AdTrafficTier.tier1, height: 80),
              AdsNative(tier: AdTrafficTier.tier1, style: NativeStyle.medium),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Banner: test_banner_id'), findsNWidgets(2));
    expect(find.text('Native: test_native_id'), findsOneWidget);
  });

  test('AdsInterstitial, AdsRewarded and AdsAppOpen helpers dispatch correctly', () async {
    final mockAdMob = MockMockAdapter('admob', 'AdMob Driver');
    AdsHub.instance.register(mockAdMob);

    await AdsInterstitial.load(AdTrafficTier.tier1);
    expect(mockAdMob.isInterstitialLoaded, isTrue);

    await AdsAppOpen.load(AdTrafficTier.tier1);
    expect(mockAdMob.isAppOpenLoaded, isTrue);

    bool rewardReceived = false;
    await AdsRewarded.load(AdTrafficTier.tier1);
    expect(mockAdMob.isRewardedLoaded, isTrue);

    await AdsRewarded.show(AdTrafficTier.tier1, onUserEarnedReward: (reward) {
      expect(reward.amount, equals(100));
      expect(reward.type, equals('gems'));
      rewardReceived = true;
    });

    expect(rewardReceived, isTrue);
  });
}
