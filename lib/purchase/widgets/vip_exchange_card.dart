import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/models/vip_exchange_rule_model.dart';
import 'package:yourcallyourrule/purchase/services/vip_exchange_service.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';

/// VIP兑换卡片组件
/// 用于显示标记兑换VIP的卡片
class VipExchangeCard extends ConsumerWidget {
  const VipExchangeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.vipExchangeTitle,
      description: AppLocalizations.of(context)!.vipExchangeDescription,
      price: AppLocalizations.of(context)!.free,
      buttonText: AppLocalizations.of(context)!.exchange,
      onTap: () {
        Navigator.of(context).pushNamed('/vip-exchange');
      },
      gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
      icon: Icons.stars_rounded,
      labels: [AppLocalizations.of(context)!.markExchange, AppLocalizations.of(context)!.getFree],
    );
  }
}

/// VIP兑换规则卡片组件
/// 用于显示单个VIP兑换规则的卡片
class VipExchangeRuleCard extends ConsumerWidget {
  final VipExchangeRule rule;
  final VoidCallback onExchange;
  final bool canExchange;

  const VipExchangeRuleCard({
    super.key,
    required this.rule,
    required this.onExchange,
    required this.canExchange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: canExchange ? const Color(0xFFFF9500) : const Color(0xFFEDE8DF),
          width: canExchange ? 1.8 : 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: canExchange
                ? const Color(0xFFFF9500).withValues(alpha: 0.16)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: canExchange ? 14 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: canExchange
                            ? const Color(0xFFFF9500).withValues(alpha: 0.12)
                            : Colors.grey.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.workspace_premium_rounded,
                        color: canExchange ? const Color(0xFFFF9500) : Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.requiredMarks('${rule.requiredMarks}'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: canExchange
                        ? const Color(0xFFFF9500).withValues(alpha: 0.12)
                        : Colors.grey.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.daysVip('${rule.days}'),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: canExchange ? const Color(0xFFFF9500) : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              rule.description,
              style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (!rule.hasAds)
                  _buildFeatureChip(AppLocalizations.of(context)!.noAds),
                if (rule.hasSync)
                  _buildFeatureChip(AppLocalizations.of(context)!.supportSync),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canExchange ? onExchange : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: canExchange ? const Color(0xFFFF9500) : const Color(0xFFEDE8DF),
                  foregroundColor: canExchange ? Colors.white : Colors.grey[500],
                  elevation: canExchange ? 2 : 0,
                  shadowColor: const Color(0xFFFF9500).withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  canExchange ? AppLocalizations.of(context)!.exchangeNow : AppLocalizations.of(context)!.insufficientMarks,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFEDE8DF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFF34C759), size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: Colors.grey[800], fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}