import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/repositories/proposal_repository.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';

/// 提议仓库的实现类。
/// 将所有调用委托给底层的 `ProposalDataSource`。
class ProposalRepositoryImpl implements ProposalRepository {
  final ProposalDataSource _dataSource;
  ProposalRepositoryImpl(this._dataSource);

  @override
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  }) => _dataSource.upsertDeletionProposal(
    phoneNumber: phoneNumber,
    riskLevel: riskLevel,
    isOwner: isOwner,
    verificationReportJson: verificationReportJson,
  );
  @override
  Future<List<Proposal>> getActiveDeletionProposals() =>
      _dataSource.getActiveDeletionProposals();
  @override
  Future<List<Proposal>> getExpiredDeletionProposals(Duration timeout) =>
      _dataSource.getExpiredDeletionProposals(timeout);
  @override
  Future<void> updateDeletionProposalStatus(
    String phoneNumber,
    String status,
  ) => _dataSource.updateDeletionProposalStatus(phoneNumber, status);
  @override
  Future<void> deleteDeletionProposal(String phoneNumber) =>
      _dataSource.deleteDeletionProposal(phoneNumber);
  @override
  Future<bool> hasActiveDeletionProposal(String phoneNumber) =>
      _dataSource.hasActiveDeletionProposal(phoneNumber);

  // 【MODIFIED】: 实现了新的命名。
  @override
  Future<List<Proposal>> getActivePendingDeletionProposals() =>
      _dataSource.getActivePendingDeletionProposals();

  @override
  Future<void> cleanupCompletedDeletionProposals(Duration retentionPeriod) =>
      _dataSource.cleanupCompletedDeletionProposals(retentionPeriod);
  @override
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  }) => _dataSource.recordProposalSubmission(
    proposerId: proposerId,
    phoneNumber: phoneNumber,
  );
  @override
  Future<int> countRecentProposals(String proposerId, DateTime since) =>
      _dataSource.countRecentProposals(proposerId, since);
  @override
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  }) => _dataSource.recordVote(voterId: voterId, proposalId: proposalId);
  @override
  Future<int> countUnconsumedVotes(String voterId) =>
      _dataSource.countUnconsumedVotes(voterId);
  @override
  Future<void> consumeVotes(String voterId, int count) =>
      _dataSource.consumeVotes(voterId, count);
  @override
  Future<void> logCustomOperation({
    required String operation,
    required String phoneNumber,
    Map<String, dynamic>? payload,
  }) => _dataSource.logCustomOperation(
    operation: operation,
    phoneNumber: phoneNumber,
    payload: payload,
  );
  @override
  Future<void> proposeDeletion({
    required String phoneNumber,
    required Map<String, dynamic> report,
  }) => _dataSource.proposeDeletion(phoneNumber: phoneNumber, report: report);
  @override
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  }) => _dataSource.voteOnDeletionProposal(
    phoneNumber: phoneNumber,
    voteType: voteType,
    additionalData: additionalData,
  );
  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionProposalOperations() =>
      _dataSource.getPendingDeletionProposalOperations();
  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes() =>
      _dataSource.getPendingDeletionVotes();
  @override
  Future<bool> hasPendingDeletionProposal(String phoneNumber) =>
      _dataSource.hasPendingDeletionProposal(phoneNumber);
  @override
  Future<void> clearDeletionOperations(String phoneNumber) =>
      _dataSource.clearDeletionOperations(phoneNumber);
  @override
   Future<Proposal?> getProposalInfo(String phoneNumber) {
    return _dataSource.getProposalInfo(phoneNumber);
  }
 
  // 【新增实现】
  @override
  Future<List<MyProposalHistoryItem>> getMyProposalHistory(String deviceId) =>
      _dataSource.getMyProposalHistory(deviceId);


}
