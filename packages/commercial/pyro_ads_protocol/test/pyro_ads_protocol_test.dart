import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';

void main() {
  test('MagmaRewardItem serializes string correctly', () {
    const item = MagmaRewardItem(10, 'coins');
    expect(item.amount, equals(10));
    expect(item.type, equals('coins'));
    expect(item.toString(), contains('coins'));
  });

  test('AdTrafficTier enum values exist', () {
    expect(AdTrafficTier.values, contains(AdTrafficTier.tier1));
    expect(AdTrafficTier.values, contains(AdTrafficTier.tier5));
  });

  test('AdsConfig resolves placement IDs by provider token and slot type', () {
    const config = AdsConfig.test();

    final admobBanner = config.getPlacementId(AdProviderToken.admob, AdSlotType.anchoredBanner);
    expect(admobBanner, equals('ca-app-pub-3940256099942544/9214589741'));

    final liftoffBanner = config.getPlacementId(AdProviderToken.liftoff, AdSlotType.anchoredBanner);
    expect(liftoffBanner, equals('BANNER_ADS-DEFAULT'));

    final applovinNative = config.getPlacementId(AdProviderToken.applovin, AdSlotType.nativeMedium);
    expect(applovinNative, equals('test_applovin_native'));
  });
}
