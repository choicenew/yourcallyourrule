import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import '../domain/models/crowdsourced_item.dart';
import '../domain/models/crowdsourced_submission.dart';
import '../domain/models/crowdsourced_vote.dart';
import '../data/crowdsourcing_isar_dao.dart';

/// 提议/投票拦截结果
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

/// 众包裁决与共识服务主引擎 (Crowdsourcing Arbiter Service)
class CrowdsourcingArbiterService {
  final CrowdsourcingIsarDao _dao;
  final int maxSubmissionsPerDay;

  CrowdsourcingArbiterService({
    CrowdsourcingIsarDao? dao,
    this.maxSubmissionsPerDay = 10,
  }) : _dao = dao ?? CrowdsourcingIsarDao();

  /// 复合 Key 生成器
  static String buildCompositeKey(String domain, String entityKey) {
    return '$domain:$entityKey';
  }

  /// 1. 提交/提议一个泛化条目 (规则、关键词、社区标签等)
  Future<CrowdsourcedItem?> proposeItem({
    required String domain,
    required String entityKey,
    required Map<String, dynamic> payload,
    required String deviceId,
    bool isVerifiedOwner = false,
  }) async {
    // 检查提交额度
    final limitCheck = await checkSubmissionQuota(deviceId);
    if (!limitCheck.allowed) {
      return null;
    }

    final compositeKey = buildCompositeKey(domain, entityKey);
    final existing = await _dao.getItemByCompositeKey(compositeKey);
    final now = DateTime.now();

    final item = existing ?? (CrowdsourcedItem()
      ..compositeKey = compositeKey
      ..domain = domain
      ..entityKey = entityKey
      ..payloadJson = jsonEncode(payload)
      ..supportVotes = 0
      ..opposeVotes = 0
      ..verifiedOwnerCount = 0
      ..confidence = 0.0
      ..status = CrowdsourcedItemStatus.pending
      ..createdAt = now);

    // 增加计数与所有者验证
    item.supportVotes += 1;
    if (isVerifiedOwner) {
      item.verifiedOwnerCount += 1;
    }
    item.payloadJson = jsonEncode(payload); // 更新最新 payload
    item.updatedAt = now;

    // 重新计算社区置信度
    item.confidence = _calculateConfidence(item.supportVotes, item.opposeVotes, item.verifiedOwnerCount);
    item.status = _evaluateStatus(item);

    // 落盘与记录日志
    await _dao.upsertItem(item);
    await _dao.recordSubmission(CrowdsourcedSubmission()
      ..proposerDeviceId = deviceId
      ..domain = domain
      ..entityKey = entityKey
      ..submissionTime = now);

    return item;
  }

  /// 2. 对条目进行投票 (支持 / 反对)
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
    item.confidence = _calculateConfidence(item.supportVotes, item.opposeVotes, item.verifiedOwnerCount);
    item.status = _evaluateStatus(item);

    await _dao.upsertItem(item);
    await _dao.recordVote(CrowdsourcedVote()
      ..compositeKey = compositeKey
      ..deviceId = deviceId
      ..voteType = support ? 'support' : 'oppose'
      ..voteTime = now);

    return item;
  }

  /// 3. 查询特定业务域内全量社区共识通过的规则/条目列表
  Future<List<CrowdsourcedItem>> getConsensusItems(String domain) async {
    return await _dao.getConsensusItemsByDomain(domain);
  }

  /// 4. 提交频率限额检查
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

  /// 5. 社区置信度评分计算公式 (结合拉普拉斯平滑与样本量惩罚)
  double _calculateConfidence(int support, int oppose, int verifiedOwners) {
    final total = support + oppose;
    if (total == 0) return 0.0;

    // 验证所有者权重加成
    final weightedSupport = support + (verifiedOwners * 3);

    // 拉普拉斯平滑胜率
    final ratio = (weightedSupport + 1.0) / (weightedSupport + oppose + 2.0);

    // 样本量惩罚因子因子: (1 - e^(-total / 5.0))
    final samplePenalty = 1.0 - math.exp(-total / 5.0);

    return (ratio * samplePenalty).clamp(0.0, 1.0);
  }

  /// 6. 置信度状态自动跃迁评估
  String _evaluateStatus(CrowdsourcedItem item) {
    if (item.verifiedOwnerCount >= 2 || item.confidence >= 0.75) {
      return CrowdsourcedItemStatus.communityConsensus;
    } else if (item.opposeVotes > 10 && item.confidence < 0.2) {
      return CrowdsourcedItemStatus.rejected;
    }
    return CrowdsourcedItemStatus.pending;
  }
}
