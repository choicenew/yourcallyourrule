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
      icon: Icons.stars,
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: canExchange
                ? [const Color(0xFF81C784), const Color(0xFF4CAF50)]
                : [Colors.grey.shade300, Colors.grey.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.requiredMarks('${rule.requiredMarks}'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white..withValues( alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.daysVip('${rule.days}'),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                rule.description,
                style: const TextStyle(color: Colors.white, fontSize: 16),
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
                    backgroundColor: Colors.white,
                    foregroundColor: canExchange ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(canExchange ? AppLocalizations.of(context)!.exchangeNow : AppLocalizations.of(context)!.insufficientMarks),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}