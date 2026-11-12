import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_card.dart';

class ProposalDetailPage extends ConsumerWidget {
  final String proposalId;

  const ProposalDetailPage({
    super.key,
    required this.proposalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalAsync = ref.watch(proposalDetailsProvider(proposalId));

    return Scaffold(
      appBar: AppBar(
        title: Text((AppLocalizations.of(context) as dynamic)?.proposalDetail as String? ?? 'Proposal Detail'),
      ),
      body: proposalAsync.when(
        data: (proposal) {
          if (proposal == null) {
            return Center(
              child: Text(AppLocalizations.of(context).proposalNotFound),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ProposalCard(
              proposal: proposal,
              isVoting: ref.watch(deletionProposalProvider.select((s) => s.isSubmitting)),
              onVote: (id, support) async {
                final success = await ref.read(deletionProposalProvider.notifier).voteOnProposal(
                  proposalId: id,
                  support: support,
                );
                if (success) {
                  ref.invalidate(proposalDetailsProvider(proposalId));
                }
                return success;
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('${AppLocalizations.of(context).errorPrefix}: $err'),
        ),
      ),
    );
  }
}
