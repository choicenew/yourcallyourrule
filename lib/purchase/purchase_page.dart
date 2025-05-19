import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';

/// 重构后的购买页面
/// 使用ModernPurchasePage组件和PurchaseProvider实现UI与业务逻辑的分离
class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends State<PurchasePage> {
  late PurchaseProvider purchaseProvider;

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    purchaseProvider = PurchaseProvider(context, purchaseState);
    purchaseState.loadState(); // 加载保存的状态
  }

  @override
  void dispose() {
    purchaseProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseState>(
      builder: (context, purchaseState, child) {
        // 构建购买卡片
        final purchaseCards = [
          // 移除广告卡片
          purchaseProvider.createRemoveAdsCard(),
          const SizedBox(height: 16.0),
          
          // 订阅卡片（月度和季度）
          Row(
            children: [
              Expanded(
                child: purchaseProvider.createMonthlySubscriptionCard(),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: purchaseProvider.createQuarterlySubscriptionCard(),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          
          // 终身会员卡片
          purchaseProvider.createLifetimeSubscriptionCard(),
          const SizedBox(height: 20),
          
          // 激励广告卡片
          purchaseProvider.createRewardedAdCard(),
        ];
        
        // 构建底部按钮
        final bottomButtons = [
          Center(
            child: purchaseProvider.createRestorePurchasesButton(),
          ),
        ];
        
        // 使用ModernPurchasePage组件
        return ModernPurchasePage(
          title: '会员中心',
          featureCard: purchaseProvider.createFeatureCard(),
          purchaseCards: purchaseCards,
          bottomButtons: bottomButtons,
          backgroundGradient: const [Colors.white, Color(0xFFFFF3E0)],
        );
      },
    );
  }
}