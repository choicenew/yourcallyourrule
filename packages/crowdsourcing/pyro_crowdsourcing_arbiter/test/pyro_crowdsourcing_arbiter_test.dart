import 'package:test/test.dart';
import 'package:pyro_crowdsourcing_arbiter/pyro_crowdsourcing_arbiter.dart';

void main() {
  group('pyro_crowdsourcing_arbiter 独立众包裁决引擎测试', () {
    late CrowdsourcingArbiterService arbiter;

    setUp(() {
      arbiter = CrowdsourcingArbiterService(
        dao: CrowdsourcingIsarDao(),
        maxSubmissionsPerDay: 5,
      );
    });

    test('提议条目与拉普拉斯置信度计算测试', () async {
      final item = await arbiter.proposeItem(
        domain: 'system_rule',
        entityKey: 'cleaner_rule_001',
        payload: {'pattern': '*.tmp'},
        deviceId: 'device_alpha',
        isVerifiedOwner: true,
      );

      expect(item, isNotNull);
      expect(item!.supportVotes, equals(1));
      expect(item.verifiedOwnerCount, equals(1));
      expect(item.confidence, greaterThan(0.0));
      expect(item.compositeKey, equals('system_rule:cleaner_rule_001'));
    });

    test('投票累加与共识自动跃迁测试', () async {
      await arbiter.proposeItem(
        domain: 'public_source',
        entityKey: 'book_source_99',
        payload: {'name': '精品书源'},
        deviceId: 'dev_proposer',
        isVerifiedOwner: true,
      );

      await arbiter.voteItem(
        domain: 'public_source',
        entityKey: 'book_source_99',
        support: true,
        deviceId: 'dev_voter_1',
      );
      final item = await arbiter.voteItem(
        domain: 'public_source',
        entityKey: 'book_source_99',
        support: true,
        deviceId: 'dev_voter_2',
      );

      expect(item, isNotNull);
      expect(item!.supportVotes, equals(3));
      expect(item.confidence, greaterThan(0.35));
    });

    test('提交额度受控测试', () async {
      for (int i = 0; i < 5; i++) {
        final res = await arbiter.checkSubmissionQuota('dev_quota_test');
        expect(res.allowed, isTrue);
        await arbiter.proposeItem(
          domain: 'test_domain',
          entityKey: 'item_$i',
          payload: {},
          deviceId: 'dev_quota_test',
        );
      }

      final check = await arbiter.checkSubmissionQuota('dev_quota_test');
      expect(check.allowed, isFalse);
    });
  });
}
