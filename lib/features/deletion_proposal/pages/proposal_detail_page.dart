import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import '../services/deletion_proposal_statistics_service.dart';
import '../services/deletion_proposal_statistics_service.g.dart';
import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_card.dart';

/// 提议详情页面
class ProposalDetailPage extends ConsumerWidget {
  final String proposalId;

  const ProposalDetailPage({
    super.key,
    required this.proposalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalAsyncValue = ref.watch(proposalDetailsProvider(proposalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.proposalDetails),
      ),
      body: proposalAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load proposal: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(proposalDetailsProvider(proposalId));
                },
                child: Text(AppLocalizations.of(context)!.retry),
              ),
            ],
          ),
        ),
        data: (proposal) {
          if (proposal == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/deletion-proposal');
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.proposalNotFound)),
              );
            });
            return const SizedBox.shrink();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ProposalCard(
              proposal: proposal,
              isVoting: ref.watch(deletionProposalProvider.select((s) => s.isSubmitting)),
              onVote: (id, support) async {
                await ref.read(deletionProposalStatisticsServiceProvider).recordVote(id, support);
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
      ),
    );
  }
}
