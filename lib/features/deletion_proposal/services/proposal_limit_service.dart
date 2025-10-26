import 'package:riverpod_annotation/riverpod_annotation.dart';

// 【MODIFIED】: 引入了新的、统一的、自动生成的 Repository Provider
import 'package:yourcallyourrule/features/deletion_proposal/providers/proposal_repository_provider.dart';

// 【MODIFIED】: 引入了现代的、自动生成的 PurchaseState Provider
import 'package:yourcallyourrule/purchase/purchase_state.dart';

import 'proposal_limit_config_service.dart';

part 'proposal_limit_service.g.dart';

// 【MODIFIED】: 使用 @riverpod 注解声明 Provider，使其现代化并自动生成代码。
@riverpod
ProposalLimitService proposalLimitService(Ref ref) {
  // 【BEST PRACTICE】: 在函数体内通过 ref 读取依赖，这是 Riverpod 3.0 的推荐做法。
  return ProposalLimitService(ref);
}

/// 提议限制服务。
///
/// 封装了所有关于用户是否有权提交新提议的复杂业务逻辑。
class ProposalLimitService {
  final Ref _ref;

  ProposalLimitService(this._ref);

  /// 检查用户当前是否可以提交一个新的提议。
  Future<bool> canSubmitProposal(String userId) async {
    // 1. 读取所有需要的服务和状态，Riverpod 会自动管理它们的实例。
    final configService = _ref.read(proposalLimitConfigServiceProvider);
    
    // 【MODIFIED】: 从新的 Repository Provider 获取数据源的抽象。
    final proposalRepository = _ref.read(proposalRepositoryProvider);
    
    // 【MODIFIED】: 从新的 PurchaseState Provider 获取购买状态。
    final purchaseState = _ref.read(purchaseStateProvider);

    // 2. 从远程配置中获取规则
    final standardUserLimit = await configService.getStandardUserLimit();
    final vipUserLimit = await configService.getVipUserLimit();
    final limitDays = await configService.getLimitDays();
    final votesPerProposal = await configService.getVotesPerProposal();

    // 3. 确定用户的基本提议限额
    final isVip = purchaseState.isPurchasedOrHasTempAccess();
    final baseLimit = isVip ? vipUserLimit : standardUserLimit;

    // 4. 从数据层查询用户近期的行为数据
    final since = DateTime.now().subtract(Duration(days: limitDays));
    final recentProposals = await proposalRepository.countRecentProposals(userId, since);
    final totalUnconsumedVotes = await proposalRepository.countUnconsumedVotes(userId);

    // 5. 计算总的可用提议次数（基础限额 + 投票奖励）
    final bonusProposals = (votesPerProposal > 0) ? totalUnconsumedVotes ~/ votesPerProposal : 0;
    final totalAllowedProposals = baseLimit + bonusProposals;

    // 6. 返回最终结果
    return recentProposals < totalAllowedProposals;
  }
}