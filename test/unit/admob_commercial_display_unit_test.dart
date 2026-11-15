import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:yourcallyourrule/features/commercial/config/app_ads_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    AdsHub.instance.clear();
  });

  group('AdMob 广告展示与 ID 解析完整性单测', () {
    test('1. 生产环境 AppAdsConfig 广告位 ID 提取 100% 正确匹配', () {
      final hub = AdsHub.instance;
      hub.setProductionConfig(AppAdsConfig.production);

      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.anchoredBanner),
        equals('ca-app-pub-7500321599129263/2198040152'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.interstitial),
        equals('ca-app-pub-7500321599129263/1982417737'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.rewarded),
        equals('ca-app-pub-7500321599129263/1982417737'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.nativeMedium),
        equals('ca-app-pub-7500321599129263/2757981774'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.appOpen),
        equals('ca-app-pub-7500321599129263/3319550135'),
      );
    });

    test('2. Debug 模式官方测试 ID 隔离配置匹配校验', () {
      final hub = AdsHub.instance;
      hub.setProductionConfig(const AdsConfig.test());

      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.anchoredBanner),
        equals('ca-app-pub-3940256099942544/9214589741'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.interstitial),
        equals('ca-app-pub-3940256099942544/1033173712'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.rewarded),
        equals('ca-app-pub-3940256099942544/5224354917'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.nativeMedium),
        equals('ca-app-pub-3940256099942544/2247696110'),
      );
      expect(
        hub.getPlacementId(AdProviderToken.admob, AdSlotType.appOpen),
        equals('ca-app-pub-3940256099942544/9257395921'),
      );
    });
  });
}
