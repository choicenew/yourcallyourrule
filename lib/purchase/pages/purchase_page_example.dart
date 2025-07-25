import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/purchase/providers/purchase_card_provider.dart';

/// 购买页面示例
/// 展示如何使用PurchaseCardFactory创建各种购买卡片
class PurchasePageExample extends ConsumerWidget {
  const PurchasePageExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取购买卡片工厂
    final cardFactory = ref.watch(purchaseCardFactoryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('会员购买'),
        backgroundColor: const Color(0xFFF5A623),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 功能卡片
            cardFactory.createFeatureCard(context),
            const SizedBox(height: 16),
            
            // 终身会员卡片
            cardFactory.createLifetimeSubscriptionCard(context),
            const SizedBox(height: 16),
            
            // 订阅卡片
            Row(
              children: [
                Expanded(
                  child: cardFactory.createMonthlySubscriptionCard(context),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: cardFactory.createQuarterlySubscriptionCard(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // 移除广告卡片
            cardFactory.createRemoveAdsCard(context),
            const SizedBox(height: 16),
            
            // 激励广告卡片
            cardFactory.createRewardedAdCard(context),
            const SizedBox(height: 16),
            
            // 标记兑换VIP卡片
            cardFactory.createMarkExchangeVipCard(context),
            const SizedBox(height: 24),
            
            // 恢复购买按钮
            Center(
              child: cardFactory.createRestorePurchasesButton(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}