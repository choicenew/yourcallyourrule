import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';
import 'package:pyro_deletion_proposal_hub/pyro_deletion_proposal_hub.dart';
import 'package:pyro_deletion_proposal_ui/pyro_deletion_proposal_ui.dart' as proposal_pkg_ui;
import 'package:yourcallyourrule/ads/ad_widgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class DeletionProposalPage extends ConsumerWidget {
  const DeletionProposalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final proposals = ref.watch(deletionProposalControlCenterProvider).proposals;

    return GenericListWithAdsPage<ProposalEntity>(
      title: l10n.deletionProposalTitle,
      items: proposals,
      emptyText: l10n.noProposalsFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, proposal) => proposal_pkg_ui.PyroProposalCardWidget(
        proposal: proposal,
        onTap: () => ref.read(deletionProposalControlCenterProvider).openProposalDetail(context, proposal),
      ),
      getItemId: (proposal) => proposal.id,
      onAdd: () => ref.read(deletionProposalControlCenterProvider).openSubmitProposalDialog(context),
      onRefresh: () => ref.read(deletionProposalControlCenterProvider).refreshProposals(),
    );
  }
}
