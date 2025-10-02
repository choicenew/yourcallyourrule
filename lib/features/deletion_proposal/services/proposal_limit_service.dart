import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/remote/remote_database_manager.dart';
import 'package:yourcallyourrule/data/datasources/remote/proposal_datasource.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_config_service.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

final proposalDataSourceProvider = Provider<ProposalDataSource>((ref) {
  final databaseManager = RemoteDatabaseManagerImpl();
  return ProposalDataSource(databaseManager);
});

final proposalLimitServiceProvider = Provider<ProposalLimitService>((ref) {
  return ProposalLimitService(ref);
});

class ProposalLimitService {
  final Ref _ref;

  ProposalLimitService(this._ref);

  Future<bool> canSubmitProposal(String userId) async {
    final configService = _ref.read(proposalLimitConfigServiceProvider);
    final proposalDataSource = _ref.read(proposalDataSourceProvider);
    final purchaseNotifier = _ref.read(purchaseStateProvider.notifier);
    await purchaseNotifier.loadState();
    final isVip = purchaseNotifier.isPurchasesEnabled;

    final standardUserLimit = await configService.getStandardUserLimit();
    final vipUserLimit = await configService.getVipUserLimit();
    final limitDays = await configService.getLimitDays();
    final votesPerProposal = await configService.getVotesPerProposal();

    final baseLimit = isVip ? vipUserLimit : standardUserLimit;

    final since = DateTime.now().subtract(Duration(days: limitDays));
    final recentProposals = await proposalDataSource.countRecentProposals(userId, since);

    final totalVotes = await proposalDataSource.countUnconsumedVotes(userId);
    final bonusProposals = (votesPerProposal > 0) ? totalVotes ~/ votesPerProposal : 0;

    final totalAllowedProposals = baseLimit + bonusProposals;

    return recentProposals < totalAllowedProposals;
  }
}