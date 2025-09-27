import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
// 关键：确保你导入了包含新的、自动生成的 `purchaseStateProvider` 的文件

// 关键：确保你导入了包含 `purchaseCardFactoryProvider` 的文件

import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/purchase/providers/purchase_card_provider.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/purchase/widgets/purchase_cards.dart'; // 假设 ModernPurchasePage 在这里

/// 重构后的购买页面
/// 这个 Widget 现在是一个 `ConsumerWidget`，因为它不再需要管理任何自己的状态 (StatefulWidget)。
/// 它只负责消费 Provider 提供的状态和逻辑。
class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 关键修改 1: 不再需要 initState 和 dispose
    // `purchaseStateProvider` 的 `loadState()` 已经在其 Notifier 的 `build` 方法中被调用，
    // 所以它会在 Provider 第一次被读取时自动加载，我们无需在 initState 中手动触发。
    
    // 关键修改 2: 不再需要手动管理 Notifier 的生命周期。
    // `Purchase` Notifier (旧称 PurchaseProvider) 使用了 `keepAlive: true`，
    // 它的生命周期由 Riverpod 自动管理，与此页面的生命周期无关。

    // final context = AppRouter.navigatorKey.currentContext!; // 这行代码通常是不推荐的，
    // build 方法自带的 context 是最安全和最正确的。如果必须使用全局 context，请保留。

    // 监听购买状态的变化。当 `purchaseStateProvider` 的状态改变时，此 Widget 会自动重建。
    // 注意：我们现在监听的是 `purchaseStateProvider` 本身，而不是它的 `notifier`。
    final purchaseStateModel = ref.watch(purchaseStateProvider);
    
    // 获取购买卡片工厂的实例。`watch` 确保如果工厂的依赖发生变化，这里也能得到更新。
    final cardFactory = ref.watch(purchaseCardFactoryProvider);
    
    // --- UI 构建逻辑完全不变 ---    // 构建购买卡片
    
    final purchaseCards = [
      // 移除广告卡片
      cardFactory.createRemoveAdsCard(context),
      const SizedBox(height: 16.0),
      
      // 订阅卡片（月度和季度）
      Row(
        children: [
          Expanded(
            child: cardFactory.createMonthlySubscriptionCard(context),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: cardFactory.createQuarterlySubscriptionCard(context),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      
      // 终身会员卡片
      cardFactory.createLifetimeSubscriptionCard(context),
      const SizedBox(height: 20),
      
      // 标记兑换VIP卡片
      cardFactory.createMarkExchangeVipCard(context),
      const SizedBox(height: 20),
      
      // 激励广告卡片
      cardFactory.createRewardedAdCard(context),
    ];
    
    // 构建底部按钮
    final bottomButtons = [
      Center(
        child: cardFactory.createRestorePurchasesButton(context),
      ),
    ];
    
    // 使用ModernPurchasePage组件
    return ModernPurchasePage(
      title: AppLocalizations.of(context)!.membershipCenter,
      featureCard: cardFactory.createFeatureCard(context),
      purchaseCards: purchaseCards,
      bottomButtons: bottomButtons,
      backgroundGradient: const [Color.fromARGB(255, 233, 11, 11), Color(0xFFFFF3E0)],
    );
  }
}