import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/provider/app_router_provider_riverpod.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_service.dart';

final proposalSubmissionManagerProvider = Provider<ProposalSubmissionManager>((ref) {
  return ProposalSubmissionManager(ref);
});

class ProposalSubmissionManager {
  final Ref _ref;

  ProposalSubmissionManager(this._ref);

  Future<bool> proposeDeletion(String number, String country, String userId, String reason, int riskLevel, String deviceId) async {
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