import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math' as math;
import '../domain/models/crowdsourced_item.dart';
import '../domain/models/crowdsourced_submission.dart';
import '../domain/models/crowdsourced_vote.dart';
import '../data/crowdsourcing_isar_dao.dart';

class SubmissionCheckResult {
  final bool allowed;
  final String? reason;
  final int remainingQuota;

  const SubmissionCheckResult({
    required this.allowed,
    this.reason,
    this.remainingQuota = 0,
  });
}

/// 众包裁决与共识服务引擎
/// 内部自带 Isolate 下沉机制，拉普拉斯评分算法与 JSON 解包编码绝不占用 UI 主线程
class CrowdsourcingArbiterService {
  final CrowdsourcingIsarDao _dao;
  final int maxSubmissionsPerDay;

  CrowdsourcingArbiterService({
    CrowdsourcingIsarDao? dao,
    this.maxSubmissionsPerDay = 10,
  }) : _dao = dao ?? CrowdsourcingIsarDao();

  static String buildCompositeKey(String domain, String entityKey) {
    return '$domain:$entityKey';
  }

  /// 提议/提交一个泛化条目 (后台 Isolate 计算与编码)
  Future<CrowdsourcedItem?> proposeItem({
    required String domain,
    required String entityKey,
    required Map<String, dynamic> payload,
    required String deviceId,
    bool isVerifiedOwner = false,
  }) async {
    final limitCheck = await checkSubmissionQuota(deviceId);
    if (!limitCheck.allowed) return null;

    final compositeKey = buildCompositeKey(domain, entityKey);
    final existing = await _dao.getItemByCompositeKey(compositeKey);
    final now = DateTime.now();

    final payloadStr = await Isolate.run(() => jsonEncode(payload));

    final item = existing ?? (CrowdsourcedItem()
      ..compositeKey = compositeKey
      ..domain = domain
      ..entityKey = entityKey
      ..payloadJson = payloadStr
      ..supportVotes = 0
      ..opposeVotes = 0
      ..verifiedOwnerCount = 0
      ..confidence = 0.0
      ..status = CrowdsourcedItemStatus.pending
      ..createdAt = now);

    item.supportVotes += 1;
    if (isVerifiedOwner) {
      item.verifiedOwnerCount += 1;
    }
    item.payloadJson = payloadStr;
    item.updatedAt = now;

    // 在后台 Isolate 线程计算拉普拉斯评分
    item.confidence = await Isolate.run(() => _calculateConfidence(item.supportVotes, item.opposeVotes, item.verifiedOwnerCount));
    item.status = _evaluateStatus(item);

    await _dao.upsertItem(item);
    await _dao.recordSubmission(CrowdsourcedSubmission()
      ..proposerDeviceId = deviceId
      ..domain = domain
      ..entityKey = entityKey
      ..submissionTime = now);

    return item;
  }

  /// 对条目进行投票 (后台 Isolate 评分计算)
  Future<CrowdsourcedItem?> voteItem({
    required String domain,
    required String entityKey,
    required bool support,
    required String deviceId,
  }) async {
    final compositeKey = buildCompositeKey(domain, entityKey);
    final item = await _dao.getItemByCompositeKey(compositeKey);
    if (item == null) return null;

    final now = DateTime.now();
    if (support) {
      item.supportVotes += 1;
    } else {
      item.opposeVotes += 1;
    }
    item.updatedAt = now;
    item.confidence = await Isolate.run(() => _calculateConfidence(item.supportVotes, item.opposeVotes, item.verifiedOwnerCount));
    item.status = _evaluateStatus(item);

    await _dao.upsertItem(item);
    await _dao.recordVote(CrowdsourcedVote()
      ..compositeKey = compositeKey
      ..deviceId = deviceId
      ..voteType = support ? 'support' : 'oppose'
      ..voteTime = now);

    return item;
  }

  /// 查询特定业务域内全量社区共识通过的规则/条目列表
  Future<List<CrowdsourcedItem>> getConsensusItems(String domain) async {
    return await _dao.getConsensusItemsByDomain(domain);
  }

  /// 提交频率限额检查
  Future<SubmissionCheckResult> checkSubmissionQuota(String deviceId) async {
    final count = await _dao.getSubmissionCountInWindow(
      deviceId: deviceId,
      window: const Duration(days: 1),
    );
    if (count >= maxSubmissionsPerDay) {
      return SubmissionCheckResult(
        allowed: false,
        reason: 'Daily submission quota reached ($count/$maxSubmissionsPerDay).',
        remainingQuota: 0,
      );
    }
    return SubmissionCheckResult(
      allowed: true,
      remainingQuota: maxSubmissionsPerDay - count,
    );
  }

  /// 社区置信度评分计算公式 (拉普拉斯平滑与样本量惩罚)
  static double _calculateConfidence(int support, int oppose, int verifiedOwners) {
    final total = support + oppose;
    if (total == 0) return 0.0;

    final weightedSupport = support + (verifiedOwners * 3);
    final ratio = (weightedSupport + 1.0) / (weightedSupport + oppose + 2.0);
    final samplePenalty = 1.0 - math.exp(-total / 5.0);

    return (ratio * samplePenalty).clamp(0.0, 1.0);
  }

  /// 自动置信度状态跃迁
  String _evaluateStatus(CrowdsourcedItem item) {
    if (item.verifiedOwnerCount >= 2 || item.confidence >= 0.75) {
      return CrowdsourcedItemStatus.communityConsensus;
    } else if (item.opposeVotes > 10 && item.confidence < 0.2) {
      return CrowdsourcedItemStatus.rejected;
    }
    return CrowdsourcedItemStatus.pending;
  }
}
