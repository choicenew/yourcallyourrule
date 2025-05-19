import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 购买服务提供者
/// 负责处理所有与应用内购买相关的业务逻辑
class PurchaseProvider extends ChangeNotifier {
  final BuildContext context;
  final PurchaseState purchaseState;
  int _adCount = 0;
  Timer? _tempPurchaseTimer;

  PurchaseProvider(this.context, this.purchaseState) {
    _initialize();
  }

  Future<void> _initialize() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      return;
    }

    InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList, context);
    });

    // 恢复之前的购买
    await InAppPurchase.instance.restorePurchases();
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // 根据 productID 区分不同的套餐
        if (purchaseDetails.productID == 'remove_ads_product_id') {
          // 去除广告套餐
          Provider.of<AdState>(context, listen: false).disableAds();
        } else if (purchaseDetails.productID == 'monthly_id_subscription' ||
            purchaseDetails.productID == 'quarterly_id_subscription' ||
            purchaseDetails.productID == 'lifetime_purchase_id') {
          // 订阅或永久购买套餐
          purchaseState.updatePurchaseState(true);
          Provider.of<AdState>(context, listen: false).disableAds();
        }

        // 显示购买成功提示
        _showSnackBar(
          context,
          '购买成功',
          Colors.green,
        );

        // 确认购买已完成 (必须调用)
        InAppPurchase.instance.completePurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.pending) {
        // 购买待处理
        _showSnackBar(
          context,
          '正在处理购买请求...',
          Colors.orange,
        );
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
        _showSnackBar(
          context,
          '购买失败: ${purchaseDetails.error}',
          Colors.red,
        );
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        // 恢复购买状态
        if (purchaseDetails.productID == 'monthly_id_subscription' ||
            purchaseDetails.productID == 'quarterly_id_subscription' ||
            purchaseDetails.productID == 'lifetime_purchase_id') {
          purchaseState.updatePurchaseState(true);
          Provider.of<AdState>(context, listen: false).disableAds();
        } else if (purchaseDetails.productID == 'remove_ads_product_id') {
          Provider.of<AdState>(context, listen: false).disableAds();
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
  void _showSnackBar(BuildContext context, String message, Color backgroundColor) {
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
      _showSnackBar(context, '购买失败: $e', Colors.red);
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
      _showSnackBar(context, '购买失败: $e', Colors.red);
    }
  }

  // 显示激励广告
  void showRewardedAd(BuildContext context) {
    // 如果用户已经拥有临时权限或已购买
    if (purchaseState.hasTempPurchase) {
      _showSnackBar(
        context,
        purchaseState.isPurchasesEnabled
            ? '您已拥有VIP特权（除广告外）'
            : '您已拥有临时特权，到期时间: ${purchaseState.tempPurchaseExpiryDate!.toLocal()}',
        Colors.orange,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ModernRewardedAdPage(
          onRewardEarned: (rewardItem) {
            _adCount++;
            if (_adCount >= 5) {
              _grantTemporaryPurchase(context);
            } else {
              _showSnackBar(
                context,
                '您需要再观看 ${5 - _adCount} 个广告以获得临时VIP特权',
                Colors.orange,
              );
            }
          },
        ),
      ),
    );
  }

  // 授予临时购买权限
  void _grantTemporaryPurchase(BuildContext context) {
    final randomDays = Random().nextInt(5) + 1;
    final expiryDate = DateTime.now().add(Duration(days: randomDays));

    purchaseState.updateTempPurchaseState(true, expiryDate);

    _tempPurchaseTimer = Timer(Duration(days: randomDays), () {
      purchaseState.updateTempPurchaseState(false, DateTime.now());
      _adCount = 0;
      _showSnackBar(context, '临时购买特权已过期', Colors.orange);
    });

    _showSnackBar(
      context,
      '您已获得 $randomDays 天临时购买特权。到期时间: ${expiryDate.toLocal()}',
      Colors.green,
    );
  }

  // 提供一个公共方法来切换广告状态
  void toggleAdState(BuildContext context) {
    final adState = Provider.of<AdState>(context, listen: false);
    // 只有正式购买时才禁用广告
    if (purchaseState.isPurchasesEnabled) {
      adState.disableAds();
    } else {
      adState.enableAds();
    }
  }

  // 手动恢复购买
  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }

  // 获取会员特权标签
  List<String> getMembershipLabels() {
    return ['无广告', '云备份', '来电识别增强', '语音识别'];
  }

  // 获取临时会员特权标签
  List<String> getTempMembershipLabels() {
    return ['云备份', '来电识别增强', '语音识别'];
  }
}

/// 现代化设计的激励广告页面
class _ModernRewardedAdPage extends StatefulWidget {
  final Function(RewardItem?) onRewardEarned;

  const _ModernRewardedAdPage({required this.onRewardEarned});

  @override
  State<_ModernRewardedAdPage> createState() => _ModernRewardedAdPageState();
}

class _ModernRewardedAdPageState extends State<_ModernRewardedAdPage> {
  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdManager.rewardedInterstitialAd.adUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {},
            onAdImpression: (ad) {},
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              Navigator.pop(context);
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              widget.onRewardEarned(null);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('已获得临时VIP'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(8),
              ));
            },
            onAdClicked: (ad) {},
          );
          ad.show(
            onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              widget.onRewardEarned(reward);
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5A623), Color(0xFFFF8C00)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                '正在加载广告...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}