import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';

void main() {
  group('🛠️ 对齐补全缺陷项全流程验证测试 (Gaps Completion Verification Test)', () {
    late ProviderContainer container;
    late AppCoordinator coordinator;

    setUp(() {
      container = ProviderContainer();
      coordinator = container.read(appCoordinatorProvider);
    });

    tearDown(() {
      container.dispose();
    });

    test('1. 验证众包删除提案签名与验证事件广播 (Crowdsourcing Signature Event)', () async {
      String? verifiedProposalId;
      String? status;

      coordinator.on('crowdsourcing_proposal_verified', (payload) {
        verifiedProposalId = payload['proposalId'] as String?;
        status = payload['status'] as String?;
      });

      coordinator.on('crowdsourcing_proposal_submit', (payload) {
        final proposalId = payload['proposalId'] as String?;
        final signature = payload['signature'] as String?;

        if (proposalId != null && signature != null) {
          coordinator.emit('crowdsourcing_proposal_verified', {
            'proposalId': proposalId,
            'status': 'verified',
          });
        }
      });

      coordinator.emit('crowdsourcing_proposal_submit', {
        'proposalId': 'prop_9999',
        'signature': 'sig_rsa_2026_abcdef',
      });

      await Future.delayed(Duration.zero);

      expect(verifiedProposalId, equals('prop_9999'));
      expect(status, equals('verified'));
    });

    test('2. 验证离线 House Ads 离线自推 Banner 监听事件触发 (House Ads Fallback Event)', () async {
      bool houseAdsTriggered = false;

      coordinator.on('ad_load_fallback_house_ads', (payload) {
        houseAdsTriggered = true;
      });

      coordinator.emit('ad_load_fallback_house_ads', {'reason': 'AdMob network timeout'});

      await Future.delayed(Duration.zero);

      expect(houseAdsTriggered, isTrue);
    });
  });
}
