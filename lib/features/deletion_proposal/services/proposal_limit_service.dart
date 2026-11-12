import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/repositories/proposal_repository_impl.dart';
import 'proposal_limit_config_service.dart';

part 'proposal_limit_service.g.dart';

@riverpod
ProposalLimitService proposalLimitService(Ref ref) {
  return ProposalLimitService(ref);
}

class ProposalLimitService {
  final Ref _ref;

  ProposalLimitService(this._ref);

  Future<bool> canSubmitProposal(String userId) async {
    final configService = _ref.read(proposalLimitConfigServiceProvider);
    final proposalRepository = _ref.read(proposalRepositoryProvider);

    final standardUserLimit = await configService.getStandardUserLimit();
    final vipUserLimit = await configService.getVipUserLimit();
    final limitDays = await configService.getLimitDays();
    final votesPerProposal = await configService.getVotesPerProposal();

    final isVip = true;
    final baseLimit = isVip ? vipUserLimit : standardUserLimit;

    final since = DateTime.now().subtract(Duration(days: limitDays));
    final recentProposals = await proposalRepository.countRecentProposals(userId, since);
    final totalUnconsumedVotes = await proposalRepository.countUnconsumedVotes(userId);

    final bonusProposals = (votesPerProposal > 0) ? totalUnconsumedVotes ~/ votesPerProposal : 0;
    final totalAllowedProposals = baseLimit + bonusProposals;

    return recentProposals < totalAllowedProposals;
  }
}
