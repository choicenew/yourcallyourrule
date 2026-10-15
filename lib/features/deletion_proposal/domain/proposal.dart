import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';

part 'proposal.freezed.dart';
part 'proposal.g.dart';

/// 代表一个从数据库或服务器获取的、完整的删除提议领域模型。
///
/// 此模型直接映射到本地 `active_deletion_proposals` 表和服务器 `deletion_proposals` 表的核心字段。
/// 它通过 `verificationReportJson` 字段承载了包括 `reason` 在内的详细报告信息。
@freezed
abstract class Proposal with _$Proposal {
  const Proposal._();

  const factory Proposal({
    /// 提议的电话号码 (主键)。
    required String phoneNumber,

    /// 提议的起始时间。
    required DateTime proposalStartTime,

    /// 提议的当前状态 (pending, approved, rejected, etc.)。
    required ProposalStatus status,

    /// 在所有提交的验证报告中记录到的最高风险等级强类型枚举。
    required RiskLevel highestRiskLevel,

    /// 此号码被提议删除的总次数。
    required int proposalCount,

    /// 提议者被验证为号码所有者的次数。
    required int verifiedOwnerCount,

    /// 此记录在数据库中最后一次被更新的时间。
    required DateTime lastUpdated,

    /// 包含详细验证报告的原始JSON字符串。
    /// `reason` 字段被封装在此JSON中。
    String? verificationReportJson,

    /// 【MODIFIED】: 新增了 `labelsJson` 字段，以匹配从服务器同步回来的数据。
    String? labelsJson,
  }) = _Proposal;

  /// 工厂方法：从 JSON 自动反序列化 `Proposal` 实例。
  factory Proposal.fromJson(Map<String, dynamic> json) => _$ProposalFromJson(json);

  /// 工厂方法：从 Map (通常来自数据库) 安全地创建 `Proposal` 实例。
  ///
  /// 负责验证和解析所有字段，并在数据格式不正确时抛出异常。
  factory Proposal.fromMap(Map<String, dynamic> map) {
    try {
      final rawStatus = map['status'];
      final rawRisk = map['highestRiskLevel'];

      final parsedStatus = rawStatus is ProposalStatus
          ? rawStatus
          : ProposalStatus.fromString(rawStatus?.toString() ?? 'pending');

      final parsedRisk = rawRisk is RiskLevel
          ? rawRisk
          : RiskLevel.fromString(rawRisk?.toString() ?? 'high');

      return Proposal(
        phoneNumber: map['phoneNumber'] as String,
        proposalStartTime: map['proposalStartTime'] is DateTime
            ? map['proposalStartTime'] as DateTime
            : DateTime.parse(map['proposalStartTime'] as String),
        status: parsedStatus,
        highestRiskLevel: parsedRisk,
        proposalCount: map['proposalCount'] as int,
        verifiedOwnerCount: map['verifiedOwnerCount'] as int,
        lastUpdated: map['lastUpdated'] is DateTime
            ? map['lastUpdated'] as DateTime
            : DateTime.parse(map['lastUpdated'] as String),
        verificationReportJson: map['verificationReportJson'] as String?,
        // 【MODIFIED】: 从 map 中读取 `labelsJson`
        labelsJson: map['labelsJson'] as String?,
      );
    } catch (e, stackTrace) {
      // 抛出一个更详细的异常，便于调试。
      throw FormatException(
        'Failed to parse Proposal from map. \nMap data: $map \nError: $e',
        stackTrace,
      );
    }
  }

  // =======================================================================
  // SECTION: 业务逻辑 Getters
  // =======================================================================

  /// 一个安全的辅助 getter，用于解析 `verificationReportJson`。
  Map<String, dynamic>? get verificationReport {
    final jsonString = verificationReportJson;
    if (jsonString == null || jsonString.isEmpty) return null;

    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      final reportData = (decoded.containsKey('report') && decoded['report'] is Map)
          ? decoded['report']
          : decoded;

      return reportData as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// 【核心】: 提供一个公开、方便的 getter 来直接访问提议的 `reason`。
  ///
  /// UI层可以直接调用 `proposal.reason`，无需关心底层的JSON解析。
  String get reason {
    return verificationReport?['reason'] as String? ?? 'No reason provided.';
  }

  /// 一个辅助 getter，用于解析 `labelsJson`。
  Map<String, int> get _votes {
    final jsonString = labelsJson;
    if (jsonString == null || jsonString.isEmpty) {
      return {};
    }
    try {
      final decoded = json.decode(jsonString) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(key, value as int));
    } catch (_) {
      return {};
    }
  }

  /// 获取支持删除的票数。
  int get supportVotes {
    return _votes['proposal_agree_delete'] ?? 0;
  }

  /// 获取反对删除的票数。
  int get opposeVotes {
    return _votes['proposal_disagree_delete'] ?? 0;
  }

  /// 获取总的投票数（支持+反对+其他）。
  int get totalVotes {
    final votes = _votes;
    if (votes.isEmpty) return 0;
    return votes.values.reduce((sum, count) => sum + count);
  }

  /// 判断此提议是否还处于可投票/可操作的状态。
  bool get isActionable => status == ProposalStatus.pending;

  /// 判断此提议是否已结束（无论是被批准、被拒绝还是已过期）。
  bool get isFinished => status != ProposalStatus.pending;
}
