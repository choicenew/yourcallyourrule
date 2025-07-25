import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'package:yourcallyourrule/purchase/widgets/vip_exchange_card.dart';

/// 购买卡片工厂类
/// 负责创建各种购买相关的卡片组件，将UI组件从PurchaseProvider中分离出来
class PurchaseCardFactory {
  final PurchaseProvider _purchaseProvider;

  PurchaseCardFactory(this._purchaseProvider);

  // 创建功能卡片
  Widget createFeatureCard(BuildContext context) {

    return ModernFeatureTableCard(
      title: AppLocalizations.of(context)!.membershipPrivileges,
      tableRows: _purchaseProvider.membershipService.getFeatureTableRows(),
      gradientColors: const [Color(0xFF5C6BC0), Color(0xFF3949AB)],
      icon: Icons.star,
    );
  }

  // 创建移除广告卡片
  Widget createRemoveAdsCard(BuildContext context) {

    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.removeAdsTitle,
      description: AppLocalizations.of(context)!.removeAdsDescription,
      price: 'USD3.99',
      buttonText: AppLocalizations.of(context)!.purchase,
      onTap: () {
        _purchaseProvider.purchaseNonConsumable(_purchaseProvider.membershipService.getProductIds()['removeAds']!);
      },
      gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
      icon: Icons.block,
      labels: [AppLocalizations.of(context)!.noAds],
    );
  }

  // 创建月度会员卡片
  Widget createMonthlySubscriptionCard(BuildContext context) {

    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.monthlyMembership,
      description: AppLocalizations.of(context)!.monthlyMembershipDescription,
      price: 'USD2.99/月',
      buttonText: AppLocalizations.of(context)!.subscribe,
      onTap: () {
        _purchaseProvider.purchaseNonConsumable(_purchaseProvider.membershipService.getProductIds()['monthly']!);
      },
      gradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
      icon: Icons.calendar_month,
      isSmall: true,
      labels: _purchaseProvider.membershipService.getMembershipLabels(),
    );
  }

  // 创建季度会员卡片
  Widget createQuarterlySubscriptionCard(BuildContext context) {

    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.quarterlyMembership,
      description: AppLocalizations.of(context)!.quarterlyMembershipDescription,
      price: 'USD6.99/季',
      buttonText: AppLocalizations.of(context)!.subscribe,
      onTap: () {
        _purchaseProvider.purchaseNonConsumable(_purchaseProvider.membershipService.getProductIds()['quarterly']!);
      },
      gradientColors: const [Color(0xFF7986CB), Color(0xFF3F51B5)],
      icon: Icons.calendar_today,
      isSmall: true,
      labels: _purchaseProvider.membershipService.getMembershipLabels(),
    );
  }

  // 创建终身会员卡片
  Widget createLifetimeSubscriptionCard(BuildContext context) {

    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.lifetimeMembership,
      description: AppLocalizations.of(context)!.lifetimeMembershipDescription,
      price: 'USD9.99',
      buttonText: AppLocalizations.of(context)!.purchase,
      onTap: () {
        _purchaseProvider.purchaseNonConsumable(_purchaseProvider.membershipService.getProductIds()['lifetime']!);
      },
      gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
      icon: Icons.star,
      labels: _purchaseProvider.membershipService.getMembershipLabels(),
    );
  }

  // 创建激励广告卡片
  Widget createRewardedAdCard(BuildContext context) {

    return ModernPurchaseCard(
      title: AppLocalizations.of(context)!.watchAdForTemp,
      description: AppLocalizations.of(context)!.watchAdForTempDescription,
      price: _purchaseProvider.purchaseState.hasTempPurchase
          ? AppLocalizations.of(context)!.expiryTime( _purchaseProvider.purchaseState.tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19))
          : AppLocalizations.of(context)!.free,
      buttonText: AppLocalizations.of(context)!.watchAd,
      onTap: () {
        _purchaseProvider.showRewardedAd(context);
      },
      gradientColors: const [Color(0xFFAED581), Color(0xFF8BC34A)],
      icon: Icons.movie,
      labels: _purchaseProvider.membershipService.getTempMembershipLabels(),
    );
  }
  
  // 创建标记兑换VIP卡片
  Widget createMarkExchangeVipCard(BuildContext context) {
    // 使用新的VipExchangeCard组件
    return const VipExchangeCard();
  }

  // 创建恢复购买按钮
  Widget createRestorePurchasesButton(BuildContext context) {

    return ElevatedButton.icon(
      onPressed: () {
        _purchaseProvider.restorePurchases();
      },
      icon: const Icon(Icons.restore),
      label: Text(AppLocalizations.of(context)!.restorePurchases),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF5A623),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
    );
  }
}