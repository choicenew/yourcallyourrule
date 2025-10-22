// features/deletion_proposal/services/deletion_proposal_notification_service.dart

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/notifications/providers//notification_history_provider.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_manager.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'deletion_proposal_notification_service.g.dart';

@Riverpod(keepAlive: true)
DeletionProposalNotificationService deletionProposalNotificationService(Ref ref) {
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
    required this.proposalId, required this.phoneNumber, required this.type,
    required this.title, required this.body, this.additionalData,
  });

  Map<String, dynamic> toJson() => {
    'proposalId': proposalId, 'phoneNumber': phoneNumber, 'type': type.name,
    'title': title, 'body': body, 'additionalData': additionalData,
  };

  factory DeletionProposalNotificationData.fromJson(Map<String, dynamic> json) {
    return DeletionProposalNotificationData(
      proposalId: json['proposalId'] ?? '', phoneNumber: json['phoneNumber'] ?? '',
      type: DeletionProposalNotificationType.values.firstWhere(
        (e) => e.name == json['type'], orElse: () => DeletionProposalNotificationType.newVoteReceived,
      ),
      title: json['title'] ?? '', body: json['body'] ?? '',
      additionalData: json['additionalData'],
    );
  }
}

enum DeletionProposalNotificationType {
  proposalCreated, proposalApproved, proposalRejected,
  votingStarted, votingEnded, newVoteReceived,
}

class DeletionProposalNotificationService {
  DeletionProposalNotificationService(this._ref) {
    _manager = _ref.read(notificationManagerProvider);
    _manager.rawNotificationService.onNotificationTapped((payload) {
      if (payload != null && payload['type'] == 'deletion_proposal') {
        _handleNotificationTap(payload);
      }
    });
  }
  
  final Ref _ref;
  late final NotificationManager _manager;

  Future<void> notifyProposalCreated({
    required String proposalId, required String phoneNumber, required String reason, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.proposalCreated,
      title: l10n.deletionProposalCreated, body: l10n.deletionProposalCreatedBody(phoneNumber),
      additionalData: {'reason': reason},
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyProposalApproved({
    required String proposalId, required String phoneNumber, required int supportVotes, required int opposeVotes, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage = totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.proposalApproved,
      title: l10n.proposalApproved, body: l10n.proposalApprovedBody(phoneNumber, supportPercentage, totalVotes),
      additionalData: { 'supportVotes': supportVotes, 'opposeVotes': opposeVotes, 'supportPercentage': supportPercentage },
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyProposalRejected({
    required String proposalId, required String phoneNumber, required int supportVotes, required int opposeVotes, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage = totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.proposalRejected,
      title: l10n.proposalRejected, body: l10n.proposalRejectedBody(phoneNumber, supportPercentage, totalVotes),
      additionalData: { 'supportVotes': supportVotes, 'opposeVotes': opposeVotes, 'supportPercentage': supportPercentage },
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyVotingStarted({
    required String proposalId, required String phoneNumber, required String reason, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.votingStarted,
      title: l10n.communityVotingStarted, body: l10n.communityVotingStartedBody(phoneNumber), additionalData: {'reason': reason},
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyVotingEnded({
    required String proposalId, required String phoneNumber, required bool approved,
    required int supportVotes, required int opposeVotes, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final totalVotes = supportVotes + opposeVotes;
    final supportPercentage = totalVotes > 0 ? (supportVotes / totalVotes * 100).round() : 0;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.votingEnded,
      title: l10n.votingCompleted, body: l10n.votingCompletedBody(phoneNumber, approved ? l10n.approved : l10n.rejected, supportPercentage),
      additionalData: { 'approved': approved, 'supportVotes': supportVotes, 'opposeVotes': opposeVotes, 'supportPercentage': supportPercentage },
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyNewVoteReceived({
    required String proposalId, required String phoneNumber, required bool isSupport,
    required int currentSupportVotes, required int currentOpposeVotes, required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final totalVotes = currentSupportVotes + currentOpposeVotes;
    final voteType = isSupport ? l10n.support : l10n.oppose;
    final notificationData = DeletionProposalNotificationData(
      proposalId: proposalId, phoneNumber: phoneNumber, type: DeletionProposalNotificationType.newVoteReceived,
      title: l10n.newVoteReceived, body: l10n.newVoteReceivedBody(voteType, phoneNumber, totalVotes),
      additionalData: { 'isSupport': isSupport, 'currentSupportVotes': currentSupportVotes, 'currentOpposeVotes': currentOpposeVotes },
    );
    await _manager.showAndRecord(
      title: notificationData.title, body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal', notificationId: notificationData.proposalId.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> showPendingProposalsNotification({
    required List<Map<String, dynamic>> proposals,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final notificationData = DeletionProposalNotificationData(
      proposalId: 'pending_proposals',
      phoneNumber: '',
      type: DeletionProposalNotificationType.votingStarted,
      title: l10n.pendingProposals,
      body: l10n.pendingProposalsBody(proposals.length),
    );
    await _manager.showAndRecord(
      title: notificationData.title,
      body: notificationData.body,
      config: NotificationService.deletionProposalConfig(context),
      type: 'deletion_proposal',
      notificationId: 'pending_proposals'.hashCode,
      payload: { 'type': 'deletion_proposal', 'data': notificationData.toJson() },
    );
  }

  Future<void> notifyVotingResultsUpdate(
    List<Map<String, dynamic>> proposals, BuildContext context,
  ) async {
    for (final proposal in proposals) {
      final proposalId = proposal['proposal_id'] as String? ?? '';
      final phoneNumber = proposal['phone_number'] as String? ?? '';
      final status = proposal['status'] as String? ?? '';
      final supportCount = proposal['support_count'] as int? ?? 0;
      final opposeCount = proposal['oppose_count'] as int? ?? 0;
      if (proposalId.isEmpty || phoneNumber.isEmpty) continue;
      switch (status.toLowerCase()) {
        case 'approved':
          await notifyProposalApproved(
            proposalId: proposalId, phoneNumber: phoneNumber, supportVotes: supportCount, opposeVotes: opposeCount, context: context,
          );
          break;
        case 'rejected':
          await notifyProposalRejected(
            proposalId: proposalId, phoneNumber: phoneNumber, supportVotes: supportCount, opposeVotes: opposeCount, context: context,
          );
          break;
      }
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    try {
      final notificationData = DeletionProposalNotificationData.fromJson(data['data']);
      debugPrint('Deletion proposal notification tapped: ${notificationData.proposalId}');
    } catch (e) {
      debugPrint('Error handling deletion proposal notification tap: $e');
    }
  }

  Future<void> clearProposalNotifications(String proposalId) async {
    await _manager.rawNotificationService.cancelNotification(proposalId.hashCode);
  }
  
  Future<void> clearAllDeletionProposalNotifications() async {
    final history = await _ref.read(notificationHistoryProvider.future);
    final proposalNotifications = history.where((item) => item.type == 'deletion_proposal');

    for (final notification in proposalNotifications) {
      final proposalData = notification.payload?['data'];
      if (proposalData is Map<String, dynamic>) {
        final proposalId = proposalData['proposalId'] as String?;
        if (proposalId != null) {
          final notificationId = proposalId.hashCode;
          await _manager.rawNotificationService.cancelNotification(notificationId);
        }
      }
    }
    
    await _manager.rawHistoryService.removeNotificationsByType('deletion_proposal');
    _ref.invalidate(notificationHistoryProvider);
  }
}