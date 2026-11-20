import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_commercial_hub/pyro_commercial_hub.dart';
import 'package:pyro_render_ad_protocol/pyro_render_ad_protocol.dart';

class MockTestAdapter implements NetworkAdapter {
  @override
  String get providerId => 'test_provider';

  @override
  String get providerName => 'Test Provider';

  @override
  Future<void> initialize(Map<String, dynamic> config) async {}

  @override
  Widget buildBanner(String placementId) => const SizedBox.shrink();

  @override
  Widget buildNative(String placementId, NativeStyle style) => const SizedBox.shrink();

  @override
  Future<void> loadInterstitial(String placementId) async {}

  @override
  Future<void> showInterstitial() async {}

  @override
  Future<void> loadRewarded(String placementId) async {}

  @override
  Future<void> showRewarded(Function(MagmaRewardItem item) onReward) async {}

  @override
  Future<void> loadAppOpen(String placementId) async {}

  @override
  Future<void> showAppOpen() async {}

  @override
  String? getTestBannerId() => 'test_banner';

  @override
  String? getTestNativeId() => 'test_native';

  @override
  String? getTestInterstitialId() => 'test_interstitial';

  @override
  String? getTestRewardedId() => 'test_rewarded';
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CommercialAdConnectors mounts RenderAdInterface correctly', (tester) async {
    CommercialAdConnectors.ensureAdConnectorsMounted();

    await tester.pumpWidget(
      Builder(
        builder: (context) {
          final adWidget = RenderAdInterface.buildAd(
            context,
            placement: RenderAdPlacement.contentInline,
            styleSpec: RenderAdStyleSpec.bannerStandard,
          );
          return Directionality(
            textDirection: TextDirection.ltr,
            child: adWidget,
          );
        },
      ),
    );

    expect(find.byType(AdsInlineBanner), findsOneWidget);
  });

  test('Drivers self-register into AdsHub instance independently', () {
    final hub = AdsHub.instance;
    final mockAdapter = MockTestAdapter();

    // 自注册模式：底层包各自独立向 AdsHub.instance 注册
    hub.register(mockAdapter);

    expect(hub.availableProviders, contains('test_provider'));
    expect(hub.getDriver('test_provider'), equals(mockAdapter));
  });
}
