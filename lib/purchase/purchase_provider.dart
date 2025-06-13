import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/purchase/modern_purchase_card.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/purchase/services/membership_feature_service.dart';
import 'package:yourcallyourrule/purchase/services/rewarded_ad_service.dart';

// 创建 PurchaseProvider 的 Provider
final purchaseProviderProvider = StateNotifierProvider<PurchaseProvider, PurchaseProviderState>((ref) {
  return PurchaseProvider(ref);
});






/// 购买提供者状态模型
class PurchaseProviderState {
  // 状态字段可以根据需要添加
  // 目前 PurchaseProvider 主要是提供方法而非状态
  const PurchaseProviderState();
}

/// 重构后的购买服务提供者 - Riverpod 版本
/// 负责处理所有与应用内购买相关的业务逻辑，但将广告和会员特权功能分离到专门的服务中
class PurchaseProvider extends StateNotifier<PurchaseProviderState> {
  final Ref _ref;
  
  // 服务依赖
  late final RewardedAdService _rewardedAdService;
  late final MembershipFeatureService _membershipService;

  PurchaseProvider(this._ref) : super(const PurchaseProviderState()) {
    _rewardedAdService = RewardedAdService(_ref.read(purchaseStateProvider.notifier));
    _membershipService = MembershipFeatureService();
    _initialize();
  }

  // 获取会员特权服务
  MembershipFeatureService get membershipService => _membershipService;
  
  // 获取激励广告服务
  RewardedAdService get rewardedAdService => _rewardedAdService;
  
  // 获取购买状态
  PurchaseState get purchaseState => _ref.read(purchaseStateProvider.notifier);

  Future<void> _initialize() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      return;
    }

    InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    });

    // 恢复之前的购买
    await InAppPurchase.instance.restorePurchases();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 根据 productID 区分不同的套餐
        if (_membershipService.isRemoveAds(purchaseDetails.productID)) {
          // 去除广告套餐 - 使用AdControlService
          _ref.read(adControlServiceProvider).disableAds();
        } else if (_membershipService.isSubscriptionOrLifetime(purchaseDetails.productID)) {
          // 订阅或永久购买套餐
          purchaseState.updatePurchaseState(true);
          // AdControlService会自动处理广告状态，不需要手动调用
        }

        // 确认购买已完成 (必须调用)
        InAppPurchase.instance.completePurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.pending) {
        // 购买待处理
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        // 恢复购买状态
        if (_membershipService.isSubscriptionOrLifetime(purchaseDetails.productID)) {
          purchaseState.updatePurchaseState(true);
          // AdControlService会自动处理广告状态，不需要手动调用
        } else if (_membershipService.isRemoveAds(purchaseDetails.productID)) {
          _ref.read(adControlServiceProvider).disableAds();
        }
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }

      // 无论状态如何，如果 pendingCompletePurchase 为 true，都必须调用 completePurchase
      if (purchaseDetails.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  // 显示SnackBar的辅助方法
  void showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  // 购买消耗型商品
  Future<void> purchaseConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status = await InAppPurchase.instance
          .buyConsumable(purchaseParam: purchaseParam, autoConsume: false);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      // 错误处理在UI层进行
    }
  }

  // 购买非消耗型商品（例如订阅）
  Future<void> purchaseNonConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }

      final ProductDetails productDetails = response.productDetails
          .firstWhere((element) => element.id == productId);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      final bool status = await InAppPurchase.instance
          .buyNonConsumable(purchaseParam: purchaseParam);

      if (!status) {
        throw Exception('购买请求失败');
      }
    } catch (e) {
      // 错误处理在UI层进行
    }
  }

  // 显示激励广告 - 委托给RewardedAdService
  void showRewardedAd(BuildContext context) {
    _rewardedAdService.showRewardedAd(
      context, 
      (message) => showSnackBar(context, message, Colors.orange)
    );
  }

  // 移除toggleAdState方法，该功能已移至AdControlService

  // 手动恢复购买
  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }

  // 创建功能卡片
  Widget createFeatureCard(BuildContext context) {
    return ModernFeatureTableCard(
      title: '会员特权',
      tableRows: _membershipService.getFeatureTableRows(),
      gradientColors: const [Color(0xFF5C6BC0), Color(0xFF3949AB)],
      icon: Icons.star,
    );
  }

  // 创建移除广告卡片
  Widget createRemoveAdsCard(BuildContext context) {
    return ModernPurchaseCard(
      title: '移除广告',
      description: '永久移除应用内所有广告，享受更流畅的使用体验',
      price: 'USD3.99',
      buttonText: '购买',
      onTap: () {
        purchaseNonConsumable(_membershipService.getProductIds()['removeAds']!);
      },
      gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
      icon: Icons.block,
      labels: ['无广告'],
    );
  }

  // 创建月度会员卡片
  Widget createMonthlySubscriptionCard(BuildContext context) {
    return ModernPurchaseCard(
      title: '月度会员',
      description: '解锁所有高级功能，每月自动续费',
      price: 'USD2.99/月',
      buttonText: '订阅',
      onTap: () {
        purchaseNonConsumable(_membershipService.getProductIds()['monthly']!);
      },
      gradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
      icon: Icons.calendar_month,
      isSmall: true,
      labels: _membershipService.getMembershipLabels(),
    );
  }

  // 创建季度会员卡片
  Widget createQuarterlySubscriptionCard(BuildContext context) {
    return ModernPurchaseCard(
      title: '季度会员',
      description: '解锁所有高级功能，每季度自动续费',
      price: 'USD6.99/季',
      buttonText: '订阅',
      onTap: () {
        purchaseNonConsumable(_membershipService.getProductIds()['quarterly']!);
      },
      gradientColors: const [Color(0xFF7986CB), Color(0xFF3F51B5)],
      icon: Icons.calendar_today,
      isSmall: true,
      labels: _membershipService.getMembershipLabels(),
    );
  }

  // 创建终身会员卡片
  Widget createLifetimeSubscriptionCard(BuildContext context) {
    return ModernPurchaseCard(
      title: '终身会员',
      description: '一次性购买，永久解锁所有高级功能和未来更新',
      price: 'USD9.99',
      buttonText: '购买',
      onTap: () {
        purchaseNonConsumable(_membershipService.getProductIds()['lifetime']!);
      },
      gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
      icon: Icons.star,
      labels: _membershipService.getMembershipLabels(),
    );
  }

  // 创建激励广告卡片
  Widget createRewardedAdCard(BuildContext context) {
    return ModernPurchaseCard(
      title: '观看广告获取临时特权',
      description: '观看短广告临时解锁部分高级功能',
      price: purchaseState.hasTempPurchase
          ? '到期时间: ${purchaseState.tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19)}'
          : '免费',
      buttonText: '观看广告',
      onTap: () {
        showRewardedAd(context);
      },
      gradientColors: const [Color(0xFFAED581), Color(0xFF8BC34A)],
      icon: Icons.movie,
      labels: _membershipService.getTempMembershipLabels(),
    );
  }

  // 创建恢复购买按钮
  Widget createRestorePurchasesButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        restorePurchases();
      },
      icon: const Icon(Icons.restore),
      label: const Text('恢复购买'),
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

  void dispose() {
    _rewardedAdService.dispose();
  }
}