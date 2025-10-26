import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

// 引入所有必要的 Provider
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/notification/deletion_proposal_notification_service.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/notification/notification_frequency_service.dart';



// 引入 `DeletionProposalService` 的定义，以便访问其方法
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';

part 'proposal_notification_manager.g.dart';

/// ProposalNotificationManager 的 Provider。
///
/// 【MODIFIED】: 修正了 Provider 的函数签名，使其与 @riverpod 规范一致。
@riverpod
ProposalNotificationManager proposalNotificationManager(Ref ref) {
  // 【MODIFIED】: 使用 `ref.watch` 来获取依赖，这是 @riverpod 的标准做法。
  return ProposalNotificationManager(
    ref.watch(notificationFrequencyServiceProvider),
    ref.watch(deletionProposalServiceProvider),
    ref.watch(deletionProposalNotificationServiceProvider),
  );
}

/// 提议通知管理器 (编排者)。
///
/// 负责协调“通知频率”和“通知发送”服务，决定何时向用户展示待处理提议的通知。
class ProposalNotificationManager {
  final NotificationFrequencyService _notificationFrequencyService;
  final DeletionProposalService _deletionProposalService;
  final DeletionProposalNotificationService _notificationService;

  ProposalNotificationManager(
    this._notificationFrequencyService, 
    this._deletionProposalService, 
    this._notificationService
  );

  /// 检查是否需要并显示通知。
  Future<void> showNotificationsIfNeeded(BuildContext context) async {
    // 1. 检查频率：现在是否是发送通知的合适时机？
    if (await _notificationFrequencyService.canShowNotification()) {
      
      // 2. 获取数据：从 `DeletionProposalService` 获取待处理的提议列表。
      // 【MODIFIED】: `_deletionProposalService.getPendingProposals()` 现在正确地返回 `Future<List<Proposal>>`。
      final proposals = await _deletionProposalService.getPendingProposals();
      
      // 3. 判断并发送：如果存在待处理的提议，则调用通知服务来显示通知。
      if (proposals.isNotEmpty) {
        // 【MODIFIED】: 将强类型的 `List<Proposal>` 传递给 `showPendingProposalsNotification`。
        //               类型完全匹配，不再有错误。
        await _notificationService.showPendingProposalsNotification(
          proposals: proposals, 
          context: context
        );
        
        // 4. 记录时间戳：通知已发送，更新时间戳以备下次频率检查。
        await _notificationFrequencyService.recordNotificationShown();
      }
    }
  }
}