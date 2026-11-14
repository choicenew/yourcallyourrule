import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pyro_commercial_hub/pyro_commercial_hub.dart';
import 'package:yourcallyourrule/features/commercial/widgets/modern_purchase_card.dart';
import 'package:yourcallyourrule/features/commercial/pages/vip_exchange_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 全量对齐 elite-ui 原始功能的 VIP 会员中心页面
class PurchasePage extends ConsumerStatefulWidget {
  const PurchasePage({super.key});

  @override
  ConsumerState<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends ConsumerState<PurchasePage> {
  final Map<String, String> _productPrices = {
    'remove_ads': '\$3.99',
    'vip_monthly': '\$2.99 / Month',
    'vip_quarterly': '\$6.99 / 3 Month',
    'vip_lifetime': '\$9.99',
  };

  static const Set<String> _kProductIds = {
    'remove_ads',
    'vip_monthly',
    'vip_quarterly',
    'vip_lifetime',
  };

  @override
  void initState() {
    super.initState();
    _queryProductDetails();
  }

  Future<void> _queryProductDetails() async {
    try {
      final available = await InAppPurchase.instance.isAvailable();
      if (!available) return;

      final response = await InAppPurchase.instance.queryProductDetails(_kProductIds);
      if (mounted && response.productDetails.isNotEmpty) {
        setState(() {
          for (final pd in response.productDetails) {
            _productPrices[pd.id] = pd.price;
          }
        });
      }
    } catch (_) {}
  }

  void _triggerPurchase(String productId) async {
    try {
      final available = await InAppPurchase.instance.isAvailable();
      if (!available) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Store service is currently unavailable')),
          );
        }
        return;
      }
      final response = await InAppPurchase.instance.queryProductDetails({productId});
      if (response.productDetails.isNotEmpty) {
        final param = PurchaseParam(productDetails: response.productDetails.first);
        await InAppPurchase.instance.buyNonConsumable(purchaseParam: param);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // 构建会员特权对比表卡片
    final featureCard = ModernFeatureTableCard(
      title: l10n.membershipCenter,
      gradientColors: const [Color(0xFF5C6BC0), Color(0xFF3949AB)],
      icon: Icons.star_rounded,
      tableRows: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(l10n.basicRuleFilter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Free: Basic', style: TextStyle(color: Colors.white70)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('VIP: Unlimited', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cloud Drive', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Free: Disabled', style: TextStyle(color: Colors.white70)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('VIP: E2EE Sync', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );

    // 7 大购买卡片全量注入，无闪烁
    final purchaseCards = [
      // 1. 免广告卡片
      ModernPurchaseCard(
        title: 'Remove Ads',
        description: 'Enjoy a completely clean, ad-free experience',
        price: _productPrices['remove_ads'] ?? '\$3.99',
        buttonText: l10n.add,
        onTap: () => _triggerPurchase('remove_ads'),
        gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
        icon: Icons.block_rounded,
        labels: const ['No Ads'],
      ),

      // 2 & 3. 月度与季度卡片
      Row(
        children: [
          Expanded(
            child: ModernPurchaseCard(
              title: 'Monthly VIP',
              description: 'Auto-renews monthly',
              price: _productPrices['vip_monthly'] ?? '\$2.99 / Month',
              buttonText: 'Subscribe',
              onTap: () => _triggerPurchase('vip_monthly'),
              gradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
              icon: Icons.calendar_month_rounded,
              isSmall: true,
              labels: const ['Flexible'],
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: ModernPurchaseCard(
              title: 'Quarterly VIP',
              description: 'Save 30% vs monthly',
              price: _productPrices['vip_quarterly'] ?? '\$6.99 / 3 Month',
              buttonText: 'Subscribe',
              onTap: () => _triggerPurchase('vip_quarterly'),
              gradientColors: const [Color(0xFF7986CB), Color(0xFF3F51B5)],
              icon: Icons.calendar_today_rounded,
              isSmall: true,
              labels: const ['Popular'],
            ),
          ),
        ],
      ),

      // 4. 终身会员卡片
      ModernPurchaseCard(
        title: 'Lifetime VIP',
        description: 'Pay once, unlock all future premium features forever',
        price: _productPrices['vip_lifetime'] ?? '\$9.99',
        buttonText: 'Get Lifetime',
        onTap: () => _triggerPurchase('vip_lifetime'),
        gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
        icon: Icons.workspace_premium_rounded,
        labels: const ['Best Value', 'One-time'],
      ),

      // 5. 标记兑换 VIP 卡片
      ModernPurchaseCard(
        title: 'Community Contribution VIP',
        description: 'Earn VIP access by marking spam numbers for community protection',
        price: 'Free Access',
        buttonText: 'Exchange',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VipExchangePage()),
          );
        },
        gradientColors: const [Color(0xFFBA68C8), Color(0xFF9C27B0)],
        icon: Icons.card_giftcard_rounded,
        labels: const ['Community Special'],
      ),

      // 6. 激励广告体验卡片 (100% 直接调起 CommercialHub 闭环策略，零二次套壳)
      ModernPurchaseCard(
        title: l10n.watchAdForTemp,
        description: l10n.watchAdForTempDescription,
        price: 'Free',
        buttonText: l10n.watchAd,
        onTap: () {
          CommercialHub.instance.showRewardedAdForPrivilege(
            onResult: (thresholdReached, remaining, newExpiryDate) {
              if (context.mounted) {
                if (thresholdReached && newExpiryDate != null) {
                  final dateStr = newExpiryDate.toString().substring(0, 10);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.grantedTempPurchaseWithExpiry('1', dateStr))),
                  );
                } else if (remaining > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Watch $remaining more ad(s) to unlock VIP')),
                  );
                }
              }
            },
            onError: (error) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to play ad: $error')),
                );
              }
            },
          );
        },
        gradientColors: const [Color(0xFFAED581), Color(0xFF8BC34A)],
        icon: Icons.ondemand_video_rounded,
        labels: const ['Free Trial'],
      ),
    ];

    // 7. 恢复购买按钮
    final bottomButtons = [
      Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            await InAppPurchase.instance.restorePurchases();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchases restored successfully')),
              );
            }
          },
          icon: const Icon(Icons.restore_rounded),
          label: const Text('Restore Purchases'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5A623),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
        ),
      ),
    ];

    return ModernPurchasePage(
      title: l10n.membershipCenter,
      featureCard: featureCard,
      purchaseCards: purchaseCards,
      bottomButtons: bottomButtons,
    );
  }
}
