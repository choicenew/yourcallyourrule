import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:material_ui/material_ui.dart';

import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';
import 'deletion_proposal_notification_service.dart';
import 'notification_frequency_service.dart';

part 'proposal_notification_manager.g.dart';

@riverpod
ProposalNotificationManager proposalNotificationManager(Ref ref) {
  return ProposalNotificationManager(
    ref.watch(notificationFrequencyServiceProvider),
    ref.watch(deletionProposalServiceProvider),
    ref.watch(deletionProposalNotificationServiceProvider),
  );
}

class ProposalNotificationManager {
  final NotificationFrequencyService _notificationFrequencyService;
  final DeletionProposalService _deletionProposalService;
  final DeletionProposalNotificationService _notificationService;

  ProposalNotificationManager(
    this._notificationFrequencyService, 
    this._deletionProposalService, 
    this._notificationService
  );

  Future<void> showNotificationsIfNeeded(BuildContext context) async {
    if (await _notificationFrequencyService.canShowNotification()) {
      final proposals = await _deletionProposalService.getPendingProposals();
      
      if (proposals.isNotEmpty) {
        await _notificationService.showPendingProposalsNotification(
          proposals: proposals, 
          context: context
        );
        await _notificationFrequencyService.recordNotificationShown();
      }
    }
  }
}
