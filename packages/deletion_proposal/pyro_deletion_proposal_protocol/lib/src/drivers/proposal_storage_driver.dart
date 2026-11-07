import 'package:pyro_deletion_proposal_protocol/src/models/proposal_entity.dart';

/// 删除提案持久化 Driver 抽象接口契约 (ProposalStorageDriver)
abstract class ProposalStorageDriver {
  Future<ProposalEntity?> getProposalById(String id);
  Future<void> saveProposal(ProposalEntity proposal);
  Future<List<ProposalEntity>> getAllProposals();
}
