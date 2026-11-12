import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';
import 'package:pyro_deletion_proposal_ui/pyro_deletion_proposal_ui.dart' as proposal_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 删除提案页面
class DeletionProposalPage extends ConsumerWidget {
  const DeletionProposalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<ProposalEntity>>(
      future: Future.value([]),
      builder: (context, snapshot) {
        final proposals = snapshot.data ?? [];
        return GenericListWithAdsPage<ProposalEntity>(
          title: l10n.deletionProposals,
          items: proposals,
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, proposal) => proposal_pkg_ui.PyroProposalCardWidget(
            proposal: proposal,
            onTap: () {},
          ),
          getItemId: (proposal) => proposal.id,
        );
      },
    );
  }
}
