import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';

/// 提议数据源的抽象接口。
/// 定义了所有与“提议”功能相关的底层数据操作。
abstract class ProposalDataSource {
  // --- 核心提议状态管理 (`active_deletion_proposals` 表) ---
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  });
  Future<List<Proposal>> getActiveDeletionProposals();
  Future<List<Proposal>> getExpiredDeletionProposals(Duration timeout);
  Future<void> updateDeletionProposalStatus(String phoneNumber, String status);
  Future<void> deleteDeletionProposal(String phoneNumber);
  Future<bool> hasActiveDeletionProposal(String phoneNumber);
  Future<List<Proposal>>
  getActivePendingDeletionProposals(); // NOTE: 此方法现在查询 active_deletion_proposals
  Future<void> cleanupCompletedDeletionProposals(Duration retentionPeriod);
 // =======================================================================
  // 【核心修正】: `getProposalInfo` 现在明确定义为查询 `active_deletion_proposals` 表，并返回强类型的 `Proposal`。
  // REASON: 这是 Service 层获取提议详情的唯一正确方式。
  // =======================================================================
  Future<Proposal?> getProposalInfo(String phoneNumber);

  // --- 提议提交日志管理 (`proposal_submissions` 表) ---
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  });
  Future<int> countRecentProposals(String proposerId, DateTime since);

  // --- 投票日志管理 (`proposal_votes` 表) ---
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  });
  Future<int> countUnconsumedVotes(String voterId);
  Future<void> consumeVotes(String voterId, int count);

  // =======================================================================
  // 【核心修正】: 使用【原始函数名】完整恢复了基于 `pending_operations` 表的所有功能。
  // REASON: 确保与原始代码1:1对应，便于对照和理解迁移路径。
  // =======================================================================

  // --- 操作日志与同步管理 (`pending_operations` 表) ---

  /// 【原名恢复】: 记录一个通用的自定义操作。
  Future<void> logCustomOperation({
    required String operation,
    required String phoneNumber,
    Map<String, dynamic>? payload,
  });

  /// 【原名恢复】: 记录“提议删除”的操作。
  Future<void> proposeDeletion({
    required String phoneNumber,
    required Map<String, dynamic> report,
  });

  /// 【原名恢复】: 记录“对提议投票”的操作。
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  });

  /// 【原名恢复】: 获取待同步的删除提议操作。
  Future<List<Map<String, dynamic>>> getPendingDeletionProposalOperations();

  /// 【原名恢复】: 获取待同步的删除投票操作。
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes();

  /// 【原名恢复】: 检查是否有待同步的删除提议。
  Future<bool> hasPendingDeletionProposal(
    String phoneNumber,
  ); // 注意: 这个方法现在查询 pending_operations

  /// 【原名恢复】: 清除待同步的删除相关操作。
  Future<void> clearDeletionOperations(String phoneNumber);

  /// 【原名恢复】: 获取提议信息（从 pending_operations）。
   Future<Map<String, dynamic>?> getPendingProposalOperationInfo(
    String phoneNumber,
  ); // 注意: 这个方法现在查询 pending_operations

  // =======================================================================
  // 【新增功能】: 获取当前用户的提议历史，聚合查询多张表的状态
  // =======================================================================
  Future<List<MyProposalHistoryItem>> getMyProposalHistory(String deviceId);


}
