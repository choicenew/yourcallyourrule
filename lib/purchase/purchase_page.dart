import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';


/// 重构后的购买页面
/// 使用ModernPurchasePage组件和PurchaseProviderNotifier实现UI与业务逻辑的分离
class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends ConsumerState<PurchasePage> {
  @override
  void initState() {
    super.initState();
    // 加载保存的状态
    Future.microtask(() {
      ref.read(purchaseStateProvider.notifier).loadState();
    });
  }

  @override
  void dispose() {
    // 清理资源
    ref.read(purchaseProviderProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 监听购买状态变化
    final purchaseStateModel = ref.watch(purchaseStateProvider);
    // 获取购买提供者
    final purchaseProvider = ref.watch(purchaseProviderProvider.notifier);
        // 构建购买卡片
        final purchaseCards = [
          // 移除广告卡片
          purchaseProvider.createRemoveAdsCard(context),
          const SizedBox(height: 16.0),
          
          // 订阅卡片（月度和季度）
          Row(
            children: [
              Expanded(
                child: purchaseProvider.createMonthlySubscriptionCard(context),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: purchaseProvider.createQuarterlySubscriptionCard(context),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          
          // 终身会员卡片
          purchaseProvider.createLifetimeSubscriptionCard(context),
          const SizedBox(height: 20),
          
          // 激励广告卡片
          purchaseProvider.createRewardedAdCard(context),
        ];
        
        // 构建底部按钮
        final bottomButtons = [
          Center(
            child: purchaseProvider.createRestorePurchasesButton(context),
          ),
        ];
        
        // 使用ModernPurchasePage组件
        return ModernPurchasePage(
          title: '会员中心',
          featureCard: purchaseProvider.createFeatureCard(context),
          purchaseCards: purchaseCards,
          bottomButtons: bottomButtons,
          backgroundGradient: const [Colors.white, Color(0xFFFFF3E0)],
        );
      }
    
  }