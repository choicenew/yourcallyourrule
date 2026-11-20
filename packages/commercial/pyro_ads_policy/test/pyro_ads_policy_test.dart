import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_ads_policy/pyro_ads_policy.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AdPolicyManager calculates default tier correctly', () {
    final manager = AdPolicyManager.instance;
    expect(manager.value, equals(AdTrafficTier.tier1));

    manager.updateVipStatus(true);
    expect(manager.value, equals(AdTrafficTier.none));

    manager.updateVipStatus(false);
    expect(manager.value, equals(AdTrafficTier.tier1));
  });

  test('AdPolicyManager respects manual override and JSON specs', () {
    final manager = AdPolicyManager.instance;
    manager.setOverrideTier(AdTrafficTier.tier3);
    expect(manager.value, equals(AdTrafficTier.tier3));

    final spec = AdPolicySpec.fromJson({
      'default_tier': 'tier2',
      'interstitial_min_interval_seconds': 120,
    });
    expect(spec.defaultTier, equals(AdTrafficTier.tier2));
    expect(spec.interstitialMinIntervalSeconds, equals(120));
  });
}
