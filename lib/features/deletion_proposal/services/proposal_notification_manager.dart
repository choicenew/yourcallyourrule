import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';

import 'notification_frequency_service.dart';
import '../../../features/deletion_proposal/services/deletion_proposal_service.dart';
import 'deletion_proposal_notification_service.dart';
import 'package:flutter/material.dart';

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
  ProposalNotificationManager(this._notificationFrequencyService, this._deletionProposalService, this._notificationService);

  final NotificationFrequencyService _notificationFrequencyService;
  final DeletionProposalService _deletionProposalService;
  final DeletionProposalNotificationService _notificationService;

  Future<void> showNotificationsIfNeeded(BuildContext context) async {
    if (await _notificationFrequencyService.canShowNotification()) {
      final proposals = await _deletionProposalService.getPendingProposals();
      if (proposals.isNotEmpty) {
        await _notificationService.showPendingProposalsNotification(proposals: proposals, context: context);
        await _notificationFrequencyService.recordNotificationShown();
      }
    }
  }
}