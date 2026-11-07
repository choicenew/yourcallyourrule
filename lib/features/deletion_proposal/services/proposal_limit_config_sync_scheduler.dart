import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_config_service.dart';

part 'proposal_limit_config_sync_scheduler.g.dart';

@Riverpod(keepAlive: true)
ProposalLimitConfigSyncScheduler proposalLimitConfigSyncScheduler(Ref ref) {
  return ProposalLimitConfigSyncScheduler(ref);
}

class ProposalLimitConfigSyncScheduler {
  final Ref _ref;
  Timer? _timer;

  ProposalLimitConfigSyncScheduler(this._ref);

  void start() {
    // Run immediately and then every 24 hours
    _ref.read(proposalLimitConfigServiceProvider).syncConfig();
    _timer = Timer.periodic(const Duration(hours: 24), (timer) {
      _ref.read(proposalLimitConfigServiceProvider).syncConfig();
    });
  }

  void stop() {
    _timer?.cancel();
  }
}