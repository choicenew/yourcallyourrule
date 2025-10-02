import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_config_service.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_config_sync_scheduler.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_service.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_submission_manager.dart';

part 'providers.g.dart';

@riverpod
ProposalLimitConfigService proposalLimitConfigService(Ref ref) {
  return ProposalLimitConfigService(ref);
}

@riverpod
ProposalLimitConfigSyncScheduler proposalLimitConfigSyncScheduler(
    Ref ref) {
  return ProposalLimitConfigSyncScheduler(ref);
}

@riverpod
ProposalLimitService proposalLimitService(Ref ref) {
  return ProposalLimitService(ref);
}

@riverpod
ProposalSubmissionManager proposalSubmissionManager(Ref ref) {
  return ProposalSubmissionManager(ref);
}