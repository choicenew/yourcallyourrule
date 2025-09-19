import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

/// 激励广告服务
/// 负责处理所有与激励广告相关的业务逻辑
class RewardedAdService {
  final PurchaseState purchaseState;
  int _adCount = 0;
  Timer? _tempPurchaseTimer;

  RewardedAdService(this.purchaseState);

  int get adCount => _adCount;

  // 显示激励广告
  void showRewardedAd(BuildContext context, Function(String) showSnackBar) {
    // 如果用户已经拥有临时权限或已购买
    if (purchaseState.hasTempPurchase) {
      showSnackBar(
        purchaseState.isPurchasesEnabled
            ? AppLocalizations.of(context)!.hasVipPrivilegeExceptAds
            : AppLocalizations.of(context)!.hasTempPrivilegeWithExpiry(
                purchaseState.tempPurchaseExpiryDate!.toLocal().toString()),
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
              _grantTemporaryPurchase(context, showSnackBar);
            } else {
              showSnackBar(
                AppLocalizations.of(context)!.watchMoreAdsForTempVip(5 - _adCount),
              );
            }
          },
        ),
      ),
    );
  }

  // 授予临时购买权限
  void _grantTemporaryPurchase(BuildContext context, Function(String) showSnackBar) {
    final randomDays = Random().nextInt(5) + 1;
    final expiryDate = DateTime.now().add(Duration(days: randomDays));

    purchaseState.updateTempPurchaseState(true, expiryDate);

    _tempPurchaseTimer = Timer(Duration(days: randomDays), () {
      purchaseState.updateTempPurchaseState(false, DateTime.now());
      _adCount = 0;
      showSnackBar(AppLocalizations.of(context)!.tempPurchaseExpired);
    });

    showSnackBar(
      AppLocalizations.of(context)!.grantedTempPurchaseWithExpiry(
          randomDays, expiryDate.toLocal().toString()),
    );
  }

  // 重置广告计数
  void resetAdCount() {
    _adCount = 0;
  }

  // 取消临时购买计时器
  void dispose() {
    _tempPurchaseTimer?.cancel();
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
                content: Text(AppLocalizations.of(context)!.earnedTempVip),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.loadingAd,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}