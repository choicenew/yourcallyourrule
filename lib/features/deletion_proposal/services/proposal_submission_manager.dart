import 'package:riverpod_annotation/riverpod_annotation.dart';

// 引入所有必要的 Provider
import 'package:yourcallyourrule/core/router/app_router_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/proposal_limit_service.dart';

part 'proposal_submission_manager.g.dart';

/// ProposalSubmissionManager 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明，替代了旧的手动 `Provider` 定义。
@riverpod
ProposalSubmissionManager proposalSubmissionManager(Ref ref) {
  return ProposalSubmissionManager(ref);
}

/// 提议提交管理器 (编排者)。
///
/// 它的唯一职责是协调“提议限制检查”和“实际提议提交”这两个服务，
/// 以完成一个完整的业务流程。
class ProposalSubmissionManager {
  final Ref _ref;

  ProposalSubmissionManager(this._ref);

  /// 提议删除一个号码的完整流程。
  Future<bool> proposeDeletion(
    String number,
    String country, // 注意: country 参数当前未被使用
    String userId,
    String reason,
    int riskLevel,
    String deviceId,
  ) async {
    // 【MODIFIED】: 从自动生成的 `proposalLimitServiceProvider` 读取服务实例。
    final canSubmit = await _ref.read(proposalLimitServiceProvider).canSubmitProposal(userId);

    if (canSubmit) {
      // 【MODIFIED】: 从自动生成的 `deletionProposalServiceProvider` 读取服务实例。
      final result = await _ref.read(deletionProposalServiceProvider).proposeDeletion(
        phoneNumber: number,
        reason: reason,
        riskLevel: riskLevel,
        deviceId: deviceId,
        userId: userId,
      );
      return result != null;
    } else {
      // 如果用户无权提交，导航到购买页面。
      _ref.read(appRouterProvider).router.push('/purchase');
      return false;
    }
  }
}