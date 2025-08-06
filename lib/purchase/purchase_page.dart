import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/purchase/providers/purchase_card_provider.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';



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
     final context = AppRouter.navigatorKey.currentContext!;
    // 监听购买状态变化
    final purchaseStateModel = ref.watch(purchaseStateProvider);
    // 获取购买卡片工厂
    final cardFactory = ref.watch(purchaseCardFactoryProvider);
    
    // 构建购买卡片
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