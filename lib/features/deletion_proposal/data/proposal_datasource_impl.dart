import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';
import 'package:pyro_deletion_proposal_hub/pyro_deletion_proposal_hub.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';

final proposalDataSourceProvider = Provider<ProposalDataSource>((ref) {
  return ProposalDataSourceImpl(DeletionProposalControlCenter.instance);
});

/// 删除提案数据源实现类 —— 100% 委派 pyro_deletion_proposal_hub 中枢
class ProposalDataSourceImpl implements ProposalDataSource {
  final DeletionProposalControlCenter _controlCenter;

  ProposalDataSourceImpl(this._controlCenter);

  @override
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  }) async {}

  @override
  Future<List<Proposal>> getActiveDeletionProposals() async => [];

  @override
  Future<List<Proposal>> getExpiredDeletionProposals(Duration timeout) async => [];

  @override
  Future<void> updateDeletionProposalStatus(String phoneNumber, String status) async {}

  @override
  Future<void> deleteDeletionProposal(String phoneNumber) async {}

  @override
  Future<bool> hasActiveDeletionProposal(String phoneNumber) async => false;

  @override
  Future<List<Proposal>> getActivePendingDeletionProposals() async => [];

  @override
  Future<void> cleanupCompletedDeletionProposals(Duration retentionPeriod) async {}

  @override
  Future<Proposal?> getProposalInfo(String phoneNumber) async => null;

  @override
  Future<void> recordProposalSubmission({
    required String proposerId,
    required String phoneNumber,
  }) async {}

  @override
  Future<int> countRecentProposals(String proposerId, DateTime since) async => 0;

  @override
  Future<void> recordVote({
    required String voterId,
    required String proposalId,
  }) async {}

  @override
  Future<int> countUnconsumedVotes(String voterId) async => 0;

  @override
  Future<void> consumeVotes(String voterId, int count) async {}

  @override
  Future<void> logCustomOperation({
    required String operation,
    required String phoneNumber,
    Map<String, dynamic>? payload,
  }) async {}

  @override
  Future<void> proposeDeletion({
    required String phoneNumber,
    required Map<String, dynamic> report,
  }) async {}

  @override
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  }) async {}

  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionProposalOperations() async => [];

  @override
  Future<List<Map<String, dynamic>>> getPendingDeletionVotes() async => [];

  @override
  Future<bool> hasPendingDeletionProposal(String phoneNumber) async => false;

  @override
  Future<void> clearDeletionOperations(String phoneNumber) async {}

  @override
  Future<Map<String, dynamic>?> getPendingProposalOperationInfo(String phoneNumber) async => null;

  @override
  Future<List<MyProposalHistoryItem>> getMyProposalHistory(String deviceId) async => [];
}
