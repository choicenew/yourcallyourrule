import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/database/sync/api_service.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';


part 'proposal_limit_config_service.g.dart';

@Riverpod(keepAlive: true)
ProposalLimitConfigService proposalLimitConfigService(Ref ref) {
  return ProposalLimitConfigService(ref);
}

class ProposalLimitConfigService {
  final Ref _ref;
  static const String _configKey = 'config_proposal_limits';

  ProposalLimitConfigService(this._ref);

  Future<void> syncConfig() async {
    try {
      final config = await _ref.read(apiServiceProvider).getProposalLimitsConfig();
      await _ref.read(configRepositoryProvider).saveConfig(_configKey, config);
    } catch (e) {
      // Handle error
    }
  }

  Future<Map<String, dynamic>> _getConfig() async {
    final config = await _ref.read(configRepositoryProvider).getConfig(_configKey);
    return config ?? {};
  }

  Future<int> getStandardUserLimit() async {
    final config = await _getConfig();
    return int.tryParse(config['standard_user_limit']?.toString() ?? '5') ?? 5;
  }

  Future<int> getVipUserLimit() async {
    final config = await _getConfig();
    return int.tryParse(config['vip_user_limit']?.toString() ?? '20') ?? 20;
  }

  Future<int> getLimitDays() async {
    final config = await _getConfig();
    return int.tryParse(config['days']?.toString() ?? '7') ?? 7;
  }

  Future<int> getVotesPerProposal() async {
    final config = await _getConfig();
    return int.tryParse(config['votes_per_proposal']?.toString() ?? '3') ?? 3;
  }
}