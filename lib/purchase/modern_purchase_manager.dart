import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/features/common/widgets/labeled_service_card.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 现代化的应用内购买管理器
/// 使用可复用组件和标签功能
class ModernInAppPurchaseManager {
  final BuildContext context;
  final PurchaseState purchaseState;
  int _adCount = 0;
  Timer? _tempPurchaseTimer;

  ModernInAppPurchaseManager(this.context, this.purchaseState) {
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

/// 现代化设计的购买页面
class ModernPurchasePage extends StatefulWidget {
  const ModernPurchasePage({super.key});

  @override
  ModernPurchasePageState createState() => ModernPurchasePageState();
}

class ModernPurchasePageState extends State<ModernPurchasePage> {
  late ModernInAppPurchaseManager inAppPurchaseManager;

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    inAppPurchaseManager = ModernInAppPurchaseManager(context, purchaseState);
    purchaseState.loadState(); // 加载保存的状态
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PurchaseState>(
      builder: (context, purchaseState, child) {
        // 获取会员特权标签
        final vipLabels = inAppPurchaseManager.getMembershipLabels();
        final tempVipLabels = inAppPurchaseManager.getTempMembershipLabels();
        
        // 构建功能表格行
        final tableRows = [
          _buildTableRow(
            '功能',
            '普通用户',
            'VIP用户',
            '临时VIP',
            isHeader: true,
          ),
          _buildTableRow('移除广告', '❌', '✅', '❌'),
          _buildTableRow('云备份', '❌', '✅', '✅'),
          _buildTableRow('来电识别增强', '❌', '✅', '✅'),
          _buildTableRow('语音识别', '❌', '✅', '✅'),
        ];
        
        // 构建功能卡片
        final featureCard = ModernFeatureTableCard(
          title: '会员特权',
          tableRows: tableRows,
          gradientColors: const [Color(0xFF5C6BC0), Color(0xFF3949AB)],
          icon: Icons.star,
        );
        
        // 构建购买卡片
        final purchaseCards = [
          // 移除广告卡片
          ModernPurchaseCard(
            title: '移除广告',
            description: '永久移除应用内所有广告，享受更流畅的使用体验',
            price: '¥25.99',
            buttonText: '购买',
            onTap: () {
              inAppPurchaseManager.purchaseNonConsumable('remove_ads_product_id');
            },
            gradientColors: const [Color(0xFFFFB74D), Color(0xFFFF9800)],
            icon: Icons.block,
            labels: ['无广告'],
          ),
          const SizedBox(height: 16.0),
          
          // 订阅卡片（月度和季度）
          Row(
            children: [
              Expanded(
                child: ModernPurchaseCard(
                  title: '月度会员',
                  description: '解锁所有高级功能，每月自动续费',
                  price: '¥18.99/月',
                  buttonText: '订阅',
                  onTap: () {
                    inAppPurchaseManager.purchaseNonConsumable('monthly_id_subscription');
                  },
                  gradientColors: const [Color(0xFF64B5F6), Color(0xFF2196F3)],
                  icon: Icons.calendar_month,
                  isSmall: true,
                  labels: vipLabels,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: ModernPurchaseCard(
                  title: '季度会员',
                  description: '解锁所有高级功能，每季度自动续费',
                  price: '¥45.99/季',
                  buttonText: '订阅',
                  onTap: () {
                    inAppPurchaseManager.purchaseNonConsumable('quarterly_id_subscription');
                  },
                  gradientColors: const [Color(0xFF7986CB), Color(0xFF3F51B5)],
                  icon: Icons.calendar_today,
                  isSmall: true,
                  labels: vipLabels,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          
          // 终身会员卡片
          ModernPurchaseCard(
            title: '终身会员',
            description: '一次性购买，永久解锁所有高级功能和未来更新',
            price: '¥68.99',
            buttonText: '购买',
            onTap: () {
              inAppPurchaseManager.purchaseNonConsumable('lifetime_purchase_id');
            },
            gradientColors: const [Color(0xFF81C784), Color(0xFF4CAF50)],
            icon: Icons.star,
            labels: vipLabels,
          ),
          const SizedBox(height: 20),
          
          // 激励广告卡片
          ModernPurchaseCard(
            title: '观看广告获取临时特权',
            description: '观看短广告临时解锁部分高级功能',
            price: purchaseState.hasTempPurchase
                ? '到期时间: ${purchaseState.tempPurchaseExpiryDate!.toLocal().toString().substring(0, 19)}'
                : '免费',
            buttonText: '观看广告',
            onTap: () {
              inAppPurchaseManager.showRewardedAd(context);
            },
            gradientColors: const [Color(0xFFAED581), Color(0xFF8BC34A)],
            icon: Icons.movie,
            labels: tempVipLabels,
          ),
        ];
        
        // 构建底部按钮
        final bottomButtons = [
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                inAppPurchaseManager.restorePurchases();
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
            ),
          ),
        ];
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('会员中心'),
            backgroundColor: const Color(0xFFF5A623),
            elevation: 0,
            bottom: purchaseState.isPurchasesEnabled
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF5A623), Color(0xFFFF8C00)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Text(
                        '您的会员订阅有效',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFFFF3E0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 功能介绍卡片
                  featureCard,
                  const SizedBox(height: 24.0),
                  
                  // 购买卡片
                  ...purchaseCards,
                  const SizedBox(height: 24.0),
                  
                  // 底部按钮
                  ...bottomButtons,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 表格行
  TableRow _buildTableRow(String feature, String normal, String vip, String tempVip,
      {bool isHeader = false}) {
    final TextStyle style = TextStyle(
      fontSize: isHeader ? 16.0 : 14.0,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: Colors.white,
    );

    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.black26 : Colors.transparent,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(feature, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(normal, style: style)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(vip, style: style)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(tempVip, style: style)),
        ),
      ],
    );
  }
}