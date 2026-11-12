import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';

part 'deletion_proposal_statistics_sync_service.g.dart';

@Riverpod(keepAlive: true)
class DeletionProposalStatisticsSyncService extends _$DeletionProposalStatisticsSyncService {
  @override
  void build() {
    ref.listen(
      deletionProposalProvider,
      (DeletionProposalState? previous, DeletionProposalState next) {
        _handleProposalsChange(previous?.proposals, next.proposals);
      },
    );

    ref.onDispose(() {
      debugPrint('DeletionProposalStatisticsSyncService disposed.');
    });
  }

  void _handleProposalsChange(List<Proposal>? previousProposals, List<Proposal> nextProposals) {
    for (final proposal in nextProposals) {
      _handleProposalData(proposal);
    }
  }

  void _handleProposalData(Proposal proposal) {
  }

  Future<void> syncSingleProposal(Proposal proposal, bool support) async {
    await _handleProposalVote(proposal, support);
  }

  Future<void> _handleProposalVote(Proposal proposal, bool support) async {
  }
}
