import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';

part 'deletion_proposal_notification_service.g.dart';

@Riverpod(keepAlive: true)
DeletionProposalNotificationService deletionProposalNotificationService(
  Ref ref,
) {
  return DeletionProposalNotificationService(ref);
}

class DeletionProposalNotificationData {
  final String proposalId;
  final String phoneNumber;
  final DeletionProposalNotificationType type;
  final String title;
  final String body;
  final Map<String, dynamic>? additionalData;

  const DeletionProposalNotificationData({
    required this.proposalId,
    required this.phoneNumber,
    required this.type,
    required this.title,
    required this.body,
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
    'proposalId': proposalId,
    'phoneNumber': phoneNumber,
    'type': type.name,
    'title': title,
    'body': body,
    'additionalData': additionalData,
  };

  factory DeletionProposalNotificationData.fromJson(Map<String, dynamic> json) {
    return DeletionProposalNotificationData(
      proposalId: json['proposalId'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      type: DeletionProposalNotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => DeletionProposalNotificationType.newVoteReceived,
      ),
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      additionalData: json['additionalData'],
    );
  }
}

enum DeletionProposalNotificationType {
  proposalCreated,
  proposalApproved,
  proposalRejected,
  votingStarted,
  votingEnded,
  newVoteReceived,
}

class DeletionProposalNotificationService {
  final AppCoordinator _coordinator;

  DeletionProposalNotificationService(Ref ref)
      : _coordinator = ref.read(appCoordinatorProvider);

  Future<void> notifyProposalCreated({
    required String proposalId,
    required String phoneNumber,
    required String reason,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.proposalCreated,
      title: l10n.deletionProposalCreated,
      body: l10n.deletionProposalCreatedBody(phoneNumber),
      additionalData: {'reason': reason},
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyProposalApproved({
    required String proposalId,
    required String phoneNumber,
    required int supportVotes,
    required int opposeVotes,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage =
        totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.proposalApproved,
      title: l10n.proposalApproved,
      body: l10n.proposalApprovedBody(
        phoneNumber,
        supportPercentage,
        totalVotes,
      ),
      additionalData: {
        'supportVotes': supportVotes,
        'opposeVotes': opposeVotes,
        'supportPercentage': supportPercentage,
      },
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyProposalRejected({
    required String proposalId,
    required String phoneNumber,
    required int supportVotes,
    required int opposeVotes,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage =
        totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.proposalRejected,
      title: l10n.proposalRejected,
      body: l10n.proposalRejectedBody(
        phoneNumber,
        supportPercentage,
        totalVotes,
      ),
      additionalData: {
        'supportVotes': supportVotes,
        'opposeVotes': opposeVotes,
        'supportPercentage': supportPercentage,
      },
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyVotingStarted({
    required String proposalId,
    required String phoneNumber,
    required String reason,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.votingStarted,
      title: l10n.communityVotingStarted,
      body: l10n.communityVotingStartedBody(phoneNumber),
      additionalData: {'reason': reason},
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyVotingEnded({
    required String proposalId,
    required String phoneNumber,
    required bool approved,
    required int supportVotes,
    required int opposeVotes,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage =
        totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.votingEnded,
      title: l10n.votingCompleted,
      body: l10n.votingCompletedBody(
        phoneNumber,
        approved ? l10n.approved : l10n.rejected,
        supportPercentage,
      ),
      additionalData: {
        'approved': approved,
        'supportVotes': supportVotes,
        'opposeVotes': opposeVotes,
        'supportPercentage': supportPercentage,
      },
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyNewVoteReceived({
    required String proposalId,
    required String phoneNumber,
    required bool isSupport,
    required int currentSupportVotes,
    required int currentOpposeVotes,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final totalVotes = currentSupportVotes + currentOpposeVotes;
    final voteType = isSupport ? l10n.support : l10n.oppose;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId,
      phoneNumber: phoneNumber,
      type: DeletionProposalNotificationType.newVoteReceived,
      title: l10n.newVoteReceived,
      body: l10n.newVoteReceivedBody(voteType, phoneNumber, totalVotes),
      additionalData: {
        'isSupport': isSupport,
        'currentSupportVotes': currentSupportVotes,
        'currentOpposeVotes': currentOpposeVotes,
      },
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': notificationData.proposalId.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> showPendingProposalsNotification({
    required List<Proposal> proposals,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context);
    final notificationData = DeletionProposalNotificationData(
      proposalId: 'pending_proposals',
      phoneNumber: '',
      type: DeletionProposalNotificationType.votingStarted,
      title: l10n.pendingProposals,
      body: l10n.pendingProposalsBody(proposals.length),
    );
    _coordinator.emit('show_system_notification', {
      'title': notificationData.title,
      'body': notificationData.body,
      'type': 'deletion_proposal',
      'notificationId': 'pending_proposals'.hashCode,
      'payload': {'type': 'deletion_proposal', 'data': notificationData.toJson()},
    });
  }

  Future<void> notifyVotingResultsUpdate(
    List<Proposal> proposals,
    BuildContext context,
  ) async {
    for (final proposal in proposals) {
      final proposalId = proposal.phoneNumber;
      final phoneNumber = proposal.phoneNumber;
      final status = proposal.status.name;
      final supportCount = proposal.supportVotes;
      final opposeCount = proposal.opposeVotes;
      if (proposalId.isEmpty || phoneNumber.isEmpty) continue;
      switch (status.toLowerCase()) {
        case 'approved':
          await notifyProposalApproved(
            proposalId: proposalId,
            phoneNumber: phoneNumber,
            supportVotes: supportCount,
            opposeVotes: opposeCount,
            context: context,
          );
          break;
        case 'rejected':
          await notifyProposalRejected(
            proposalId: proposalId,
            phoneNumber: phoneNumber,
            supportVotes: supportCount,
            opposeVotes: opposeCount,
            context: context,
          );
          break;
      }
    }
  }

  Future<void> clearProposalNotifications(String proposalId) async {
    _coordinator.emit('cancel_system_notification', {
      'notificationId': proposalId.hashCode,
    });
  }

  Future<void> clearAllDeletionProposalNotifications() async {
    _coordinator.emit('clear_notifications_by_type', {
      'type': 'deletion_proposal',
    });
  }
}
