import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_crowdsourcing_arbiter/pyro_crowdsourcing_arbiter.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 删除提案主页面 —— 全量使用 pyro_crowdsourcing_arbiter 众包裁决引擎 (domain: 'deletion_proposal')
class DeletionProposalPage extends ConsumerWidget {
  final CrowdsourcingArbiterService _arbiterService;

  DeletionProposalPage({super.key, CrowdsourcingArbiterService? arbiterService})
      : _arbiterService = arbiterService ?? CrowdsourcingArbiterService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<CrowdsourcedItem>>(
      future: _arbiterService.getConsensusItems('deletion_proposal'),
      builder: (context, snapshot) {
        final proposals = snapshot.data ?? [];
        return GenericListPage<CrowdsourcedItem>(
          title: l10n.deletionProposals,
          items: proposals,
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, item) => Card(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              title: Text(item.entityKey, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Domain: ${item.domain} | Support: ${item.supportVotes} / Oppose: ${item.opposeVotes}'),
              trailing: Chip(
                label: Text('${(item.confidence * 100).toStringAsFixed(0)}%'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
          getItemId: (item) => item.compositeKey,
        );
      },
    );
  }
}
