import 'package:flutter/foundation.dart';
import 'package:pyro_purchase_core/pyro_purchase_core.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_ads_policy/pyro_ads_policy.dart';

import 'strategies/rewarded_ad_strategy.dart';

/// 商业变现与激励调度中台 (Commercial Hub)
/// 聚合 [pyro_purchase] (内购特权) 与 [pyro_ads_hub] (广告调度中轴)，管理激励广告到特权到期的策略转化。
class CommercialHub {
  static CommercialHub? _instance;

  late final CommercialNotifier _commercialNotifier;
  RewardedAdStrategy _strategy;
  int _watchedAdsCount = 0;

  CommercialHub._({
    required CommercialNotifier commercialNotifier,
    RewardedAdStrategy? strategy,
  })  : _commercialNotifier = commercialNotifier,
        _strategy = strategy ?? DefaultFiveAdVipStrategy();

  /// 获取单例实例
  static CommercialHub get instance {
    if (_instance == null) {
      throw StateError('CommercialHub 尚未初始化！请先调用 CommercialHub.init(...)');
    }
    return _instance!;
  }

  /// 初始化商业化中台
  static CommercialHub init({
    required CommercialNotifier commercialNotifier,
    RewardedAdStrategy? strategy,
  }) {
    _instance = CommercialHub._(
      commercialNotifier: commercialNotifier,
      strategy: strategy,
    );
    return _instance!;
  }

  /// 当前已观看广告计数
  int get watchedAdsCount => _watchedAdsCount;

  /// 剩余所需广告数
  int get remainingAdsCount => (_strategy.requiredAdCount - _watchedAdsCount).clamp(0, _strategy.requiredAdCount);

  /// 策略模型
  RewardedAdStrategy get strategy => _strategy;

  /// 更新激励转化策略
  void setStrategy(RewardedAdStrategy newStrategy) {
    _strategy = newStrategy;
  }

  /// 播放激励视频并自动更新临时免广告特权
  Future<void> showRewardedAdForPrivilege({
    required void Function(bool thresholdReached, int remaining, DateTime? newExpiryDate) onResult,
    void Function(String error)? onError,
    AdTrafficTier? targetTier,
  }) async {
    try {
      if (_commercialNotifier.isPurchased) {
        onResult(true, 0, _commercialNotifier.tempPurchaseExpiryDate);
        return;
      }

      // 对接 AdPolicyManager 的动态策略决议 (若未指定，则读取 AdPolicyManager 当前动态值)
      final tierToUse = targetTier ?? AdPolicyManager.instance.value;

      // 通过 AdsHub 瀑布流仲裁器获取当前可用的驱动
      final adapter = AdsHub.instance.arbitrator.resolveAvailableAdapter(tierToUse);
      if (adapter == null) {
        throw StateError('无可用广告驱动匹配当前梯队: $tierToUse');
      }

      await adapter.showRewarded((rewardItem) async {
        _watchedAdsCount++;
        if (_watchedAdsCount >= _strategy.requiredAdCount) {
          _watchedAdsCount = 0;
          final currentExpiry = _commercialNotifier.tempPurchaseExpiryDate;
          final newExpiry = _strategy.calculateExpiryDate(currentExpiry);

          await _commercialNotifier.grantTempAdFree(newExpiry);
          debugPrint('🎉 [CommercialHub] 激励广告看满 ${_strategy.requiredAdCount} 次，特权已延至: $newExpiry');
          onResult(true, 0, newExpiry);
        } else {
          final remaining = remainingAdsCount;
          debugPrint('📺 [CommercialHub] 观看激励视频 1 次，已看 $_watchedAdsCount/${_strategy.requiredAdCount} 次');
          onResult(false, remaining, null);
        }
      });
    } catch (e, stack) {
      debugPrint('❌ [CommercialHub] 激励广告播放异常: $e\n$stack');
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  /// 重置已看计数
  void resetAdCount() {
    _watchedAdsCount = 0;
  }
}
