// 1. 导入必要的包，特别是 riverpod_annotation
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/purchase/services/membership_feature_service.dart';
import 'package:yourcallyourrule/purchase/services/rewarded_ad_service.dart';

// 2. 链接到将要生成的代码文件
part 'purchase_provider.g.dart';

/// 购买提供者状态模型 (此类保持不变)
class PurchaseProviderState {
  const PurchaseProviderState();
}

// 3. 使用 @riverpod 注解来声明一个 Provider
// keepAlive: true 确保 Provider 不会被自动销毁，使其在整个应用生命周期内保持活动状态
@Riverpod(keepAlive: true)
class Purchase extends _$Purchase {
  
  // 将服务声明为私有后期最终变量
  late final RewardedAdService _rewardedAdService;
  late final MembershipFeatureService _membershipService;

  /// build 方法是 Provider 的初始化入口。
  /// Riverpod 会自动调用此方法，并且它只会被执行一次 (因为 keepAlive: true)。
  @override
  PurchaseProviderState build() {
    // 将所有初始化逻辑放在这里
    _rewardedAdService = RewardedAdService(ref.read(purchaseStateProvider.notifier));
    _membershipService = MembershipFeatureService();
    _initialize();

    // 使用 ref.onDispose 来处理清理逻辑，替代旧的 dispose 方法
    ref.onDispose(() {
      _rewardedAdService.dispose();
    });

    // 返回 Provider 的初始状态
    return const PurchaseProviderState();
  }
  
  // ------------------- 公共接口 -------------------

  MembershipFeatureService get membershipService => _membershipService;
  
  RewardedAdService get rewardedAdService => _rewardedAdService;
  
  PurchaseState get purchaseState => ref.read(purchaseStateProvider.notifier);

  // ------------------- 核心逻辑方法 (与之前基本相同) -------------------

  Future<void> _initialize() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      return;
    }

    InAppPurchase.instance.purchaseStream.listen(_listenToPurchaseUpdated);

    // 恢复之前的购买
    await InAppPurchase.instance.restorePurchases();
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        if (_membershipService.isRemoveAds(purchaseDetails.productID)) {
          ref.read(adControlServiceProvider).disableAds();
        } else if (_membershipService.isSubscriptionOrLifetime(purchaseDetails.productID)) {
          purchaseState.updatePurchaseState(true);
        }
        InAppPurchase.instance.completePurchase(purchaseDetails);

      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        if (_membershipService.isSubscriptionOrLifetime(purchaseDetails.productID)) {
          purchaseState.updatePurchaseState(true);
        } else if (_membershipService.isRemoveAds(purchaseDetails.productID)) {
          ref.read(adControlServiceProvider).disableAds();
        }
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }

      if (purchaseDetails.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  // ------------------- UI 和购买操作 (无需改动) -------------------

  void showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(8),
    ));
  }

  Future<void> purchaseConsumable(String productId) async {
    try {
      final response = await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }
      final productDetails = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: productDetails);
      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
    } catch (e) {
      // 错误处理可以在UI层进行
    }
  }

  Future<void> purchaseNonConsumable(String productId) async {
    try {
      final response = await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception('找不到商品: ${response.notFoundIDs}');
      }
      final productDetails = response.productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: productDetails);
      await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      // 错误处理可以在UI层进行
    }
  }

  void showRewardedAd(BuildContext context) {
    _rewardedAdService.showRewardedAd(
      context, 
      (message) => showSnackBar(context, message, Colors.orange)
    );
  }

  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }
}