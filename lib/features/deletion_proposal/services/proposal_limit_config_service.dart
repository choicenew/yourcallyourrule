import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/api_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';


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
    return int.tryParse(config['standard_user_limit']?.toString() ?? '1') ?? 1;
  }

  Future<int> getVipUserLimit() async {
    final config = await _getConfig();
    return int.tryParse(config['vip_user_limit']?.toString() ?? '3') ?? 3;
  }

  Future<int> getLimitDays() async {
    final config = await _getConfig();
    return int.tryParse(config['days']?.toString() ?? '7') ?? 7;
  }

  Future<int> getVotesPerProposal() async {
    final config = await _getConfig();
    return int.tryParse(config['votes_per_proposal']?.toString() ?? '10') ?? 10;
  }
}