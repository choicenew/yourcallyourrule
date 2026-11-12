import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/common/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/domain/risk_level.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_service.dart';

part 'proposal_submission_manager.g.dart';

@riverpod
ProposalSubmissionManager proposalSubmissionManager(Ref ref) {
  return ProposalSubmissionManager(ref);
}

class ProposalSubmissionManager {
  final Ref _ref;

  ProposalSubmissionManager(this._ref);

  Future<bool> proposeDeletion(
    String number,
    String country,
    String userId,
    String reason,
    RiskLevel riskLevel,
    String deviceId,
  ) async {
    final canSubmit = await _ref.read(proposalLimitServiceProvider).canSubmitProposal(userId);

    if (canSubmit) {
      final result = await _ref.read(deletionProposalServiceProvider).proposeDeletion(
        phoneNumber: number,
        reason: reason,
        riskLevel: riskLevel,
        deviceId: deviceId,
        userId: userId,
      );
      return result != null;
    } else {
      _ref.read(appRouterProvider).router.push('/purchase');
      return false;
    }
  }
}
