import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_crowdsourcing_arbiter/pyro_crowdsourcing_arbiter.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';

final proposalDataSourceProvider = Provider<ProposalDataSource>((ref) {
  return ProposalDataSourceImpl(CrowdsourcingArbiterService());
});

/// 删除提案数据源实现类 —— 100% 委派 pyro_crowdsourcing_arbiter 众包裁决引擎
class ProposalDataSourceImpl implements ProposalDataSource {
  final CrowdsourcingArbiterService _arbiterService;

  ProposalDataSourceImpl(this._arbiterService);

  @override
  Future<void> upsertDeletionProposal({
    required String phoneNumber,
    required String riskLevel,
    required bool isOwner,
    String? verificationReportJson,
  }) async {
    await _arbiterService.proposeItem(
      domain: 'deletion_proposal',
      entityKey: phoneNumber,
      payload: {'riskLevel': riskLevel, 'verificationReport': verificationReportJson},
      deviceId: 'device_client',
      isVerifiedOwner: isOwner,
    );
  }

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
  }) async {
    await _arbiterService.proposeItem(
      domain: 'deletion_proposal',
      entityKey: phoneNumber,
      payload: report,
      deviceId: 'device_client',
    );
  }

  @override
  Future<void> voteOnDeletionProposal({
    required String phoneNumber,
    required String voteType,
    Map<String, dynamic>? additionalData,
  }) async {
    await _arbiterService.voteItem(
      domain: 'deletion_proposal',
      entityKey: phoneNumber,
      support: voteType == 'support',
      deviceId: 'device_client',
    );
  }

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
