import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';

/// 提议仓库的抽象接口。
/// 这是领域层与数据层之间的唯一契约。
abstract class ProposalRepository {
  // --- 核心提议状态管理 ---
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

  // 【MODIFIED】: 采用了您建议的更清晰的命名。
  Future<List<Proposal>> getActivePendingDeletionProposals();

  Future<void> cleanupCompletedDeletionProposals(Duration retentionPeriod);

  // --- 提议提交日志管理 ---
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  });
  Future<int> countRecentProposals(String proposerId, DateTime since);

  // --- 投票日志管理 ---
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  });
  Future<int> countUnconsumedVotes(String voterId);
  Future<void> consumeVotes(String voterId, int count);

  // --- 操作日志与同步管理 ---
  Future<void> logCustomOperation({
    required String operation,
    required String phoneNumber,
    Map<String, dynamic>? payload,
  });
  Future<void> proposeDeletion({
    required String phoneNumber,
    required Map<String, dynamic> report,
  });
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  });
  Future<List<Map<String, dynamic>>> getPendingDeletionProposalOperations();
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes();
  Future<bool> hasPendingDeletionProposal(String phoneNumber);
  Future<void> clearDeletionOperations(String phoneNumber);
// 【核心修正】: 确保 `getProposalInfo` 的返回类型是 Future<Proposal?>
  Future<Proposal?> getProposalInfo(String phoneNumber);
}
