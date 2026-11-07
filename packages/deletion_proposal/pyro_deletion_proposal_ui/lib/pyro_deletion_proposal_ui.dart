library pyro_deletion_proposal_ui;

import 'package:flutter/material.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';

/// 删除提案 ListTile 组件
class ProposalTileView extends StatelessWidget {
  final ProposalEntity proposal;

  const ProposalTileView({
    super.key,
    required this.proposal,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.report_problem),
      title: Text(proposal.phoneNumber),
      subtitle: Text('${proposal.reason} • Votes: ${proposal.voteCount}'),
      trailing: Text(proposal.status),
    );
  }
}
