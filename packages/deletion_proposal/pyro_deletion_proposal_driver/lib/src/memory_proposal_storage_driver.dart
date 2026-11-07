import 'package:flutter/foundation.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';

/// 真实内存级删除提案持久化驱动 (MemoryProposalStorageDriver)
class MemoryProposalStorageDriver implements ProposalStorageDriver {
  final Map<String, ProposalEntity> _proposals = {};

  MemoryProposalStorageDriver();

  @override
  Future<ProposalEntity?> getProposalById(String id) async {
    return _proposals[id];
  }

  @override
  Future<void> saveProposal(ProposalEntity proposal) async {
    _proposals[proposal.id] = proposal;
    debugPrint('[MemoryProposalDriver] 持久化保存删除提案: ${proposal.id} (${proposal.phoneNumber})');
  }

  @override
  Future<List<ProposalEntity>> getAllProposals() async {
    return _proposals.values.toList();
  }
}
