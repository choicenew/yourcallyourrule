import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_list_options.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Proposal 重构单元测试 - 风险等级 (RiskLevel) 健壮性测试', () {
    test('1. 字符串与数字各种格式转换为 RiskLevel 枚举', () {
      expect(RiskLevel.fromString('verified'), equals(RiskLevel.verified));
      expect(RiskLevel.fromString('VERIFIED'), equals(RiskLevel.verified));
      expect(RiskLevel.fromString('1'), equals(RiskLevel.verified));
      expect(RiskLevel.fromString(1), equals(RiskLevel.verified));

      expect(RiskLevel.fromString('low'), equals(RiskLevel.low));
      expect(RiskLevel.fromString('LOW'), equals(RiskLevel.low));
      expect(RiskLevel.fromString('2'), equals(RiskLevel.low));
      expect(RiskLevel.fromString(2), equals(RiskLevel.low));

      expect(RiskLevel.fromString('medium'), equals(RiskLevel.medium));
      expect(RiskLevel.fromString('MEDIUM'), equals(RiskLevel.medium));
      expect(RiskLevel.fromString('3'), equals(RiskLevel.medium));
      expect(RiskLevel.fromString(3), equals(RiskLevel.medium));

      expect(RiskLevel.fromString('high'), equals(RiskLevel.high));
      expect(RiskLevel.fromString('HIGH'), equals(RiskLevel.high));
      expect(RiskLevel.fromString('4'), equals(RiskLevel.high));
      expect(RiskLevel.fromString(4), equals(RiskLevel.high));
    });

    test('2. 脏数据与非法格式容错 (不得崩溃，默认降级为 high)', () {
      expect(RiskLevel.fromString(null), equals(RiskLevel.high));
      expect(RiskLevel.fromString(''), equals(RiskLevel.high));
      expect(RiskLevel.fromString('unknown_risk_level'), equals(RiskLevel.high));
      expect(RiskLevel.fromString(999), equals(RiskLevel.high));
    });

    test('3. RiskLevel 导出为原始存储字符串 (toRawString)', () {
      expect(RiskLevel.verified.toRawString(), equals('Verified'));
      expect(RiskLevel.low.toRawString(), equals('Low'));
      expect(RiskLevel.medium.toRawString(), equals('Medium'));
      expect(RiskLevel.high.toRawString(), equals('High'));
    });
  });

  group('Proposal 重构单元测试 - 提议状态 (ProposalStatus) 健壮性测试', () {
    test('1. 字符串解析为 ProposalStatus 枚举', () {
      expect(ProposalStatus.fromString('pending'), equals(ProposalStatus.pending));
      expect(ProposalStatus.fromString('APPROVED'), equals(ProposalStatus.approved));
      expect(ProposalStatus.fromString('rejected'), equals(ProposalStatus.rejected));
      expect(ProposalStatus.fromString('expired'), equals(ProposalStatus.expired));
    });

    test('2. 脏数据容错 (默认降级为 pending)', () {
      expect(ProposalStatus.fromString(null), equals(ProposalStatus.pending));
      expect(ProposalStatus.fromString('invalid_status'), equals(ProposalStatus.pending));
    });
  });

  group('Proposal 领域实体 (Freezed + JsonSerializable) 序列化与反序列化测试', () {
    test('1. Proposal 对象的创建、序列化与反序列化双向转换', () {
      final now = DateTime(2026, 10, 15, 8, 0, 0);
      final proposal = Proposal(
        phoneNumber: '+18005550199',
        proposalStartTime: now,
        status: ProposalStatus.pending,
        highestRiskLevel: RiskLevel.high,
        proposalCount: 5,
        verifiedOwnerCount: 2,
        lastUpdated: now,
        verificationReportJson: '{"test": true}',
      );

      expect(proposal.phoneNumber, equals('+18005550199'));
      expect(proposal.highestRiskLevel, equals(RiskLevel.high));
      expect(proposal.status, equals(ProposalStatus.pending));

      // 转换为 JSON Map
      final map = proposal.toJson();
      expect(map['phoneNumber'], equals('+18005550199'));
      expect(map['proposalCount'], equals(5));

      // 从 Map 反序列化
      final restored = Proposal.fromJson(map);
      expect(restored.phoneNumber, equals('+18005550199'));
      expect(restored.highestRiskLevel, equals(RiskLevel.high));
      expect(restored.status, equals(ProposalStatus.pending));
      expect(restored.proposalCount, equals(5));
    });

    test('2. 兼容服务端 RAW JSON 的动态类型解析 (HighestRiskLevel 为字符串时)', () {
      final rawMapFromCloud = {
        'phoneNumber': '+8613800138000',
        'proposalStartTime': '2026-10-15T08:00:00.000',
        'status': 'pending',
        'highestRiskLevel': 'low', // 云端返回 Raw String
        'proposalCount': 10,
        'verifiedOwnerCount': 3,
        'lastUpdated': '2026-10-15T08:00:00.000',
      };

      final proposal = Proposal.fromJson(rawMapFromCloud);
      expect(proposal.phoneNumber, equals('+8613800138000'));
      expect(proposal.highestRiskLevel, equals(RiskLevel.low));
      expect(proposal.status, equals(ProposalStatus.pending));
      expect(proposal.proposalCount, equals(10));
    });

    test('3. Proposal.copyWith 变更方法测试', () {
      final proposal = Proposal(
        phoneNumber: '+8613800138000',
        proposalStartTime: DateTime.now(),
        status: ProposalStatus.pending,
        highestRiskLevel: RiskLevel.low,
        proposalCount: 1,
        verifiedOwnerCount: 0,
        lastUpdated: DateTime.now(),
      );

      final updated = proposal.copyWith(
        highestRiskLevel: RiskLevel.verified,
        proposalCount: 2,
        status: ProposalStatus.approved,
      );

      expect(updated.highestRiskLevel, equals(RiskLevel.verified));
      expect(updated.proposalCount, equals(2));
      expect(updated.status, equals(ProposalStatus.approved));
    });
  });

  group('Proposal 辅助模型测试 - ProposalListOptions & MyProposalHistoryItem', () {
    test('1. ProposalListOptions 支持 RiskLevel? 筛选与 copyWith', () {
      const options = ProposalListOptions(
        status: ProposalStatus.pending,
        riskLevel: RiskLevel.medium,
      );

      expect(options.status, equals(ProposalStatus.pending));
      expect(options.riskLevel, equals(RiskLevel.medium));

      final updatedOptions = options.copyWith(riskLevel: RiskLevel.verified);
      expect(updatedOptions.riskLevel, equals(RiskLevel.verified));
    });

    test('2. MyProposalHistoryItem 支持 RiskLevel? 存储', () {
      final historyItem = MyProposalHistoryItem(
        phoneNumber: '+8613800138000',
        submissionTime: DateTime.now(),
        status: MyProposalStatus.approved,
        highestRiskLevel: RiskLevel.high,
        currentVotes: 8,
        verifiedOwnerCount: 1,
      );

      expect(historyItem.phoneNumber, equals('+8613800138000'));
      expect(historyItem.highestRiskLevel, equals(RiskLevel.high));
      expect(historyItem.status, equals(MyProposalStatus.approved));
    });
  });
}
