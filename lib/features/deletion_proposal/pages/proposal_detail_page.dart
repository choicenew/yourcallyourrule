import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 引入新的 proposalDetailsProvider 和其他必要的 Provider
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';

import 'package:yourcallyourrule/features/deletion_proposal/widgets/proposal_card.dart';

/// 提议详情页面
class ProposalDetailPage extends ConsumerWidget {
  final String proposalId;

  const ProposalDetailPage({
    super.key,
    required this.proposalId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 【MODIFIED】: 使用新的 `proposalDetailsProvider` 来异步获取单个提议的数据。
    // `ref.watch` 会自动处理 Future 的状态，并返回一个 `AsyncValue` 对象。
    final proposalAsyncValue = ref.watch(proposalDetailsProvider(proposalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.proposalDetails),
      ),
      body:
          // `AsyncValue` 提供了一个 `when` 方法，用于优雅地处理所有可能的状态。
          proposalAsyncValue.when(
        // 1. 加载中状态：显示一个加载指示器。
        loading: () => const Center(child: CircularProgressIndicator()),
        
        // 2. 错误状态：显示错误信息，并提供一个重试按钮。
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load proposal: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // `ref.invalidate` 会强制让 Provider 重新执行。
                  ref.invalidate(proposalDetailsProvider(proposalId));
                },
                child: Text(AppLocalizations.of(context)!.retry),
              ),
            ],
          ),
        ),
        
        // 3. 数据加载成功状态
        data: (proposal) {
          // 3a. 如果返回的 proposal 数据是 null（即数据库中确实没有这个提议）
          if (proposal == null) {
            // 【您的建议】: 直接跳转回列表页。这是一个很好的用户体验。
            // 使用 `WidgetsBinding.instance.addPostFrameCallback` 确保跳转在 build 之后执行。
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.canPop()) {
                context.pop();
              } else {
                // 如果无法返回（例如，通过 deep link 直接进入），则跳转到列表页
                context.go('/deletion-proposal');
              }
              // 可以选择性地显示一个 SnackBar 提示用户
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.proposalNotFound)),
              );
            });
            // 在跳转发生前，显示一个空的 Container。
            return const SizedBox.shrink();
          }
          
          // 3b. 如果成功获取到 proposal 对象，则构建 UI
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ProposalCard(
              proposal: proposal,
              isVoting: ref.watch(deletionProposalProvider.select((s) => s.isSubmitting)),
              onVote: (id, support) async {
                await ref.read(deletionProposalStatisticsServiceProvider).recordVote(id, support);
                final success = await ref.read(deletionProposalProvider.notifier).voteOnProposal(
                  proposalId: id,
                  support: support,
                );
                if (success) {
                  // 投票成功后，刷新详情页的数据
                  ref.invalidate(proposalDetailsProvider(proposalId));
                }
                return success;
              },
            ),
          );
        },
      ),
    );
  }
}