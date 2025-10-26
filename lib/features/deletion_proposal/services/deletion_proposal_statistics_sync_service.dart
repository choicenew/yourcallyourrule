// 文件路径: lib/features/deletion_proposal/services/deletion_proposal_statistics_sync_service.dart

// 导入 Riverpod 和代码生成相关包
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 导入所有必要的 Provider 和模型
import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';

// part 指令，用于代码生成
part 'deletion_proposal_statistics_sync_service.g.dart';


/// 使用 Notifier 模式的删除提议统计同步服务。
///
/// 这个 Provider 本身不管理任何需要暴露给 UI 的状态 (其 state 类型为 void)，
/// 它的主要作用是作为一个后台服务，响应其他 Provider 的状态变化来执行任务。
///
/// - `@Riverpod(keepAlive: true)`: 
///   使用 `keepAlive: true` 可以确保这个服务在被监听后，即使没有 UI 在 `watch` 它，
///   也能持续在后台运行，直到被手动销毁或应用关闭。对于这类后台服务来说通常是必要的。
@Riverpod(keepAlive: true)
class DeletionProposalStatisticsSyncService extends _$DeletionProposalStatisticsSyncService {
  
  /// `build` 方法是 Notifier 的生命周期入口，在 Provider 第一次被读取时执行。
  /// 这里是执行一次性初始化和设置监听的最佳位置。
  /// 因为我们不管理状态，所以它返回 `void`。
  @override
  void build() {
    
    // 【核心逻辑】: 在 Notifier 内部，可以直接使用 `ref` 来设置监听。
    ref.listen(
      deletionProposalProvider, // 监听强类型的 Provider
      (DeletionProposalState? previous, DeletionProposalState next) {
        // 当状态变化时，调用 Notifier 自身的私有方法来处理
        _handleProposalsChange(previous?.proposals, next.proposals);
      },
    );

    // 注册清理逻辑
    ref.onDispose(() {
      print('🗑️ [Notifier] DeletionProposalStatisticsSyncService Notifier is disposed.');
    });

    print("✅ [Notifier] DeletionProposalStatisticsSyncService initialized and is listening for proposal changes.");
  }

  /// 依赖项可以通过一个私有的 getter 来按需获取。
  /// 使用 `ref.read` 来获取依赖，因为它只在需要时被调用一次。
  DeletionProposalStatisticsService get _statisticsService => ref.read(deletionProposalStatisticsServiceProvider);

  // --- 公共和私有方法 ---
  // 所有业务逻辑现在都是这个 Notifier 类的一部分，内聚性更强。

  /// 处理由 `ref.listen` 触发的提议列表变化。
  void _handleProposalsChange(List<Proposal>? previousProposals, List<Proposal> nextProposals) {
    for (final proposal in nextProposals) {
      _handleProposalData(proposal);
    }
  }

  /// 处理单个提议的数据（目前为空，可扩展）。
  void _handleProposalData(Proposal proposal) {
    // 例如: print("Handling data for proposal: ${proposal.phoneNumber}");
  }

  /// 公共方法，用于同步单个提议的投票结果。
  /// UI 层或其他服务可以通过 `ref.read(deletionProposalStatisticsSyncServiceProvider.notifier).syncSingleProposal(...)` 来调用。
  Future<void> syncSingleProposal(Proposal proposal, bool support) async {
    await _handleProposalVote(proposal, support);
  }

  /// 内部方法，调用底层的统计服务来记录投票。
  Future<void> _handleProposalVote(Proposal proposal, bool support) async {
    // 通过 getter 安全地访问依赖项
    await _statisticsService.recordVote(proposal.phoneNumber, support);
  }
}