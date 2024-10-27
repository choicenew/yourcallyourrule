import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
import '../utils/ad_manager.dart';
import '../utils/ad_state.dart';
import '../utils/purchase_state.dart';

class InAppPurchaseManager {
  final BuildContext context;
  final PurchaseState purchaseState;
  int _adCount = 0;
  Timer? _tempPurchaseTimer;

  InAppPurchaseManager(this.context, this.purchaseState) {
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
          //  purchaseState.updatePurchaseState(true); // 更新购买状态
          Provider.of<AdState>(context, listen: false).disableAds(); // 禁用广告
          // ... (其他去除广告套餐的逻辑)
        } else if (purchaseDetails.productID == 'monthly_id_subscription' ||
            purchaseDetails.productID == 'quarterly_id_subscription' ||
            purchaseDetails.productID == 'lifetime_purchase_id') {
          // 订阅或永久购买套餐
          purchaseState.updatePurchaseState(true); // 更新购买状态
          Provider.of<AdState>(context, listen: false).disableAds(); // 禁用广告
          // ... (其他订阅或永久购买套餐的逻辑)
        }

        // ... (其他购买成功的处理)
        // 显示 SnackBar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).purchaseSuccessful),
        ));

        // 可以根据需要添加其他处理逻辑，例如解锁功能

        // 确认购买已完成 (必须调用)
        InAppPurchase.instance.completePurchase(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.pending) {
        // 购买待处理 (例如：等待用户付款确认)
        // 可以添加一些 UI 提示，告知用户正在处理购买
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(S.of(context).purchaseIsBeingProcessed),
        ));
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // 购买失败
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('${S.of(context).purchaseFailed} ${purchaseDetails.error}'),
        ));
      } else if (purchaseDetails.status == PurchaseStatus.restored) {
        // 添加恢复购买状态的处理
        if (purchaseDetails.productID == 'monthly_id_subscription' ||
            purchaseDetails.productID == 'quarterly_id_subscription' ||
            purchaseDetails.productID == 'lifetime_purchase_id') {
          purchaseState.updatePurchaseState(true);
          Provider.of<AdState>(context, listen: false).disableAds();
          // ... (其他处理逻辑，例如更新 UI) ...
        } else if (purchaseDetails.productID == 'remove_ads_product_id') {
          // 单独处理 remove_ads_product_id
          Provider.of<AdState>(context, listen: false).disableAds();
          // ... (其他 remove_ads_product_id 的恢复逻辑) ...
        }
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }

      // 无论状态如何，如果 pendingCompletePurchase 为 true，都必须调用 completePurchase
      if (purchaseDetails.pendingCompletePurchase) {
        InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  // 购买消耗型商品
  Future<void> purchaseConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception(
            '${S.of(context).cannotFindItem}: ${response.notFoundIDs}');
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
      //print('购买消耗型商品失败: $e');
      // 处理错误，例如显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).purchaseFailed}: $e')),
      );
    }
  }

  // 购买非消耗型商品（例如订阅）
  Future<void> purchaseNonConsumable(String productId) async {
    try {
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({productId});
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception(
            '${S.of(context).cannotFindItem}: ${response.notFoundIDs}');
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
      // 处理错误，例如显示错误消息
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).purchaseFailed} $e')),
      );
    }
  }

  // 显示激励广告
  void showRewardedAd(BuildContext context) {
    // 如果用户已经拥有临时权限或已购买
    if (purchaseState.hasTempPurchase) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            purchaseState.isPurchasesEnabled
                ? S.of(context).youHaveVipPrivilegesExceptForTurningOffAds
                : '${S.of(context).youAlreadyHaveTemporaryPrivilegesExpiryDate}: ${purchaseState.tempPurchaseExpiryDate!.toLocal()}',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _RewardedAdPage(
          onRewardEarned: (rewardItem) {
            _adCount++;
            if (_adCount >= 5) {
              _grantTemporaryPurchase(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${S.of(context).youNeedToWatch} ${5 - _adCount} ${S.of(context).moreAdsToGetTemporaryVipPrivileges}',
                  ),
                ),
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
      purchaseState.updateTempPurchaseState(
          false, DateTime.now()); // 设置过期时间为当前时间
      _adCount = 0;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).temporaryPurchasePrivilegeHasExpired),
      ));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${S.of(context).youHaveObtainedTemporaryPurchasePrivilegesFor} $randomDays ${S.of(context).days}. ${S.of(context).expirationDate}: ${expiryDate.toLocal()}',
        ),
      ),
    );
  }

  // 提供一个公共方法来切换广告状态 (如果适用)
  void toggleAdState(BuildContext context) {
    final adState = Provider.of<AdState>(context, listen: false);
    // 只有正式购买时才禁用广告
    if (purchaseState.isPurchasesEnabled) {
      adState.disableAds();
    } else {
      adState.enableAds();
    }
  }

  // 添加一个公共方法来手动恢复购买
  Future<void> restorePurchases() async {
    await InAppPurchase.instance.restorePurchases();
  }

  //结束



}

// 空白页面用于显示广告
class _RewardedAdPage extends StatefulWidget {
  final Function(RewardItem?) onRewardEarned;

  const _RewardedAdPage({required this.onRewardEarned});

  @override
  State<_RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<_RewardedAdPage> {
  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdManager.rewardedInterstitialAd.adUnitId, // 使用你的广告单元 ID
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
              // 打印一条日志
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(S.of(context).temporaryVipObtained),
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  PurchasePageState createState() => PurchasePageState();
}

class PurchasePageState extends State<PurchasePage> {
  late InAppPurchaseManager inAppPurchaseManager;

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    inAppPurchaseManager = InAppPurchaseManager(context, purchaseState);
    purchaseState.loadState(); // 加载保存的状态
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseState>(
      builder: (context, purchaseState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).inappPurchase),
            bottom: purchaseState.isPurchasesEnabled
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.green,
                      child: Text(
                        S.of(context).subscriptionValid,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : null,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 功能介绍卡片
                Container(
                  width: double.infinity, // 使功能介绍卡片与其他卡片宽度相同
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).featureIntroduction,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        _buildFeatureRow(
                            S.of(context).function,
                            S.of(context).normalUser,
                            S.of(context).vipUser,
                            S.of(context).temporaryVipUser),
                        const Divider(color: Colors.white54), // 添加分割线
                        _buildFeatureRow(
                            S.of(context).removeAds, '❌', '✅', '❌'),
                        _buildFeatureRow(
                            S.of(context).cloudBackup, '❌', '✅', '✅'),
                        _buildFeatureRow(
                            S.of(context).callerIdSimSource, '❌', '✅', '✅'),
                        _buildFeatureRow(
                            S.of(context).stirRecognition, '❌', '✅', '✅'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // 移除广告卡片
                _buildPurchaseCard(
                  title: S.of(context).removeAds,
                  description:
                      S.of(context).permanentlyRemoveAllAdsInTheAppAndEnjoyA,
                  price: 'USD3.99', // 价格信息不需要翻译
                  buttonText: S.of(context).purchase,
                  onTap: () {
                    inAppPurchaseManager
                        //.purchaseConsumable('consumable_product_id');
                        .purchaseNonConsumable('remove_ads_product_id');
                  },
                  backgroundColor: Colors.amber, // 设置卡片背景颜色
                ),
                const SizedBox(height: 16.0), // 添加卡片之间的间距

                // 订阅卡片 (月订阅和季度订阅)
                Row(
                  children: [
                    Expanded(
                      child: _buildPurchaseCard(
                        title: S.of(context).monthlySubscription,
                        description: S
                            .of(context)
                            .unlockPremiumFeaturesEveryMonthIncludingExclusiveContentAndRemoving,
                        price: 'USD2.99', // 价格信息不需要翻译
                        buttonText: S.of(context).subscribe,
                        onTap: () {
                          inAppPurchaseManager
                              .purchaseNonConsumable('monthly_id_subscription');
                        },
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: _buildPurchaseCard(
                        title: S.of(context).quarterlySubscription,
                        description: S
                            .of(context)
                            .unlockPremiumFeaturesEveryQuarterAndEnjoyABetterPrice,
                        price: 'USD6.99', // 价格信息不需要翻译
                        buttonText: S.of(context).subscribe,
                        onTap: () {
                          inAppPurchaseManager.purchaseNonConsumable(
                              'quarterly_id_subscription');
                        },
                        backgroundColor: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // 永久买断卡片
                _buildPurchaseCard(
                  title: S.of(context).lifetimePurchase,
                  description: S
                      .of(context)
                      .onetimePurchaseToPermanentlyUnlockAllAdvancedFeaturesAndFuture,
                  price: 'USD9.99', // 价格信息不需要翻译
                  buttonText: S.of(context).purchase,
                  onTap: () {
                    inAppPurchaseManager
                        .purchaseNonConsumable('lifetime_purchase_id');
                  },
                  backgroundColor: Colors.greenAccent,
                ),
                const SizedBox(height: 20),

                // 激励广告卡片
                _buildPurchaseCard(
                  title: S.of(context).watchAdsToGetTemporaryPrivileges,
                  description: S
                      .of(context)
                      .watchAShortAdToTemporarilyUnlockSomeAdvancedFeatures,
                  price: purchaseState.hasTempPurchase
                      ? '${S.of(context).expiryDate}: ${purchaseState.tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19)}' // 显示到秒
                      : '0.00', // 根据是否有临时权限显示不同的价格信息
                  buttonText: S.of(context).watchAd,
                  onTap: () {
                    inAppPurchaseManager.showRewardedAd(context);
                  },
                  backgroundColor: Colors.greenAccent,
                ),

                // 添加一个恢复购买按钮
                ElevatedButton(
                  onPressed: () {
                    inAppPurchaseManager.restorePurchases();
                  },
                  child: Text(S.of(context).restorePurchase), // 使用你的翻译
                ),




              ],
            ),
          ),
        );
      },
    );
  }

  // 功能介绍行 Widget (修改为类似表格的样式)
  Widget _buildFeatureRow(
      String feature, String normal, String vip, String tempVip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              normal,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              vip,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          Expanded(
            child: Text(
              tempVip,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 购买卡片 Widget
  Widget _buildPurchaseCard({
    required String title,
    required String description,
    required String price, // 添加价格参数
    required String buttonText,
    required VoidCallback onTap,
    required Color backgroundColor, // 添加背景颜色参数
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), // 设置圆角
      color: backgroundColor, // 设置背景颜色
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 14.0, color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 按钮背景颜色
                foregroundColor: backgroundColor, // 按钮文字颜色
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
