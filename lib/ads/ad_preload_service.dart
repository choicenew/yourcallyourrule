// -----------------------------------------------------------------------------
// 文件: ad_preload_service.dart
// 描述: 全局广告预加载池管理器 (Ad Preload Engine)。
// 包含【滑动消耗速度预测算法】：默认保持 1 个官方容量；快速滑动时动态扩容至 2 个；闲置自动归一。
// -----------------------------------------------------------------------------

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

class PreloadedAdWrapper {
  final dynamic ad; // BannerAd, NativeAd, InterstitialAd, RewardedAd
  final AdSize? adSize;
  final DateTime loadTime;

  PreloadedAdWrapper({
    required this.ad,
    this.adSize,
    required this.loadTime,
  });

  /// 检查广告是否过期（AdMob 规范：4小时内有效，预留3小时安全阈值）
  bool get isExpired {
    return DateTime.now().difference(loadTime).inHours >= 3;
  }
}

class AdPreloadManager {
  AdPreloadManager._();
  static final AdPreloadManager instance = AdPreloadManager._();

  // 广告池映射：adUnitId -> PreloadedAdWrapper 列表队列
  final Map<String, List<PreloadedAdWrapper>> _preloadQueueMap = {};
  final Set<String> _loadingUnits = {};

  // 消耗速度预测器：adUnitId -> 最近 10 秒内的消耗时间戳记录
  final Map<String, List<DateTime>> _consumptionTimestamps = {};

  /// 预测当前消费速度，计算自适应预加载容量上限（1 ~ 2）
  int _calculateAdaptiveCapacity(String adUnitId) {
    final now = DateTime.now();
    final timestamps = _consumptionTimestamps[adUnitId] ?? [];

    // 过滤保留 10 秒以内的消费记录
    timestamps.removeWhere((ts) => now.difference(ts).inSeconds > 10);
    _consumptionTimestamps[adUnitId] = timestamps;

    // 如果 10 秒内被消费了 >= 2 次（说明用户正在快速滑动卡片或频繁换页），容量扩容至 2
    if (timestamps.length >= 2) {
      debugPrint('⚡ [AdPreloadPredictor] 检测到高频滑动消耗 (${timestamps.length}次/10s)，池容量扩容至 2');
      return 2;
    }

    // 闲置状态，默认保持 1 个官方标准容量
    return 1;
  }

  /// 记录一次消耗事件
  void _recordConsumption(String adUnitId, {DateTime? customTime}) {
    final timestamps = _consumptionTimestamps.putIfAbsent(adUnitId, () => []);
    timestamps.add(customTime ?? DateTime.now());
  }

  @visibleForTesting
  int calculateAdaptiveCapacityForTesting(String adUnitId) {
    return _calculateAdaptiveCapacity(adUnitId);
  }

  @visibleForTesting
  void simulateConsumptionForTesting(String adUnitId, {DateTime? customTime}) {
    _recordConsumption(adUnitId, customTime: customTime);
  }

  @visibleForTesting
  void clearConsumptionForTesting(String adUnitId) {
    _consumptionTimestamps.remove(adUnitId);
    _preloadQueueMap.remove(adUnitId);
  }

  // ===========================================================================
  // 1. 横幅广告 (Banner / Adaptive Banner) 预加载
  // ===========================================================================
  Future<void> preloadBannerAd(AdInfo adInfo, {AdSize? customSize}) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final targetCapacity = _calculateAdaptiveCapacity(unitId);
    final queue = _preloadQueueMap.putIfAbsent(unitId, () => []);

    // 清理队列中已过期的广告
    queue.removeWhere((wrapper) {
      if (wrapper.isExpired) {
        wrapper.ad?.dispose();
        return true;
      }
      return false;
    });

    // 如果队列数量已达目标上限，或正在加载中，跳过
    if (queue.length >= targetCapacity || _loadingUnits.contains(unitId)) {
      return;
    }

    _loadingUnits.add(unitId);
    final size = customSize ?? adInfo.size ?? AdSize.banner;

    BannerAd(
      adUnitId: unitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          _loadingUnits.remove(unitId);
          final bannerAd = ad as BannerAd;
          final platformAdSize = await bannerAd.getPlatformAdSize();

          queue.add(PreloadedAdWrapper(
            ad: bannerAd,
            adSize: platformAdSize,
            loadTime: DateTime.now(),
          ));
          debugPrint('⚡ [AdPreload] BannerAd 预加载成功 (队列长度 ${queue.length}/$targetCapacity): $unitId');

          // 如果还没达到预测容量上限，自动开启下一个补充加载
          if (queue.length < targetCapacity) {
            preloadBannerAd(adInfo, customSize: customSize);
          }
        },
        onAdFailedToLoad: (ad, error) {
          _loadingUnits.remove(unitId);
          ad.dispose();
          debugPrint('❌ [AdPreload] BannerAd 预加载失败: $error');
        },
      ),
    ).load();
  }

  PreloadedAdWrapper? consumeBannerAd(String adUnitId) {
    _recordConsumption(adUnitId);
    final queue = _preloadQueueMap[adUnitId];
    if (queue != null && queue.isNotEmpty) {
      final wrapper = queue.removeAt(0);
      if (!wrapper.isExpired) {
        debugPrint('🚀 [AdPreload] 命中 Banner 预加载池 (0ms 秒出，剩余队列: ${queue.length}): $adUnitId');
        return wrapper;
      }
      wrapper.ad?.dispose();
    }
    return null;
  }

  // ===========================================================================
  // 2. 原生高级广告 (Native Advanced) 预加载
  // ===========================================================================
  Future<void> preloadNativeAd(AdInfo adInfo, {NativeAdConfig? config}) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final targetCapacity = _calculateAdaptiveCapacity(unitId);
    final queue = _preloadQueueMap.putIfAbsent(unitId, () => []);

    queue.removeWhere((wrapper) {
      if (wrapper.isExpired) {
        wrapper.ad?.dispose();
        return true;
      }
      return false;
    });

    if (queue.length >= targetCapacity || _loadingUnits.contains(unitId)) {
      return;
    }

    _loadingUnits.add(unitId);
    final nativeConfig = config ?? const NativeAdConfig(template: NativeAdTemplate.small);

    NativeAd(
      adUnitId: unitId,
      request: const AdRequest(),
      nativeTemplateStyle: nativeConfig.style,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          queue.add(PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          ));
          debugPrint('⚡ [AdPreload] NativeAd 预加载成功 (队列长度 ${queue.length}/$targetCapacity): $unitId');

          if (queue.length < targetCapacity) {
            preloadNativeAd(adInfo, config: config);
          }
        },
        onAdFailedToLoad: (ad, error) {
          _loadingUnits.remove(unitId);
          ad.dispose();
          debugPrint('❌ [AdPreload] NativeAd 预加载失败: $error');
        },
      ),
    ).load();
  }

  PreloadedAdWrapper? consumeNativeAd(String adUnitId) {
    _recordConsumption(adUnitId);
    final queue = _preloadQueueMap[adUnitId];
    if (queue != null && queue.isNotEmpty) {
      final wrapper = queue.removeAt(0);
      if (!wrapper.isExpired) {
        debugPrint('🚀 [AdPreload] 命中 Native 预加载池 (0ms 秒出，剩余队列: ${queue.length}): $adUnitId');
        return wrapper;
      }
      wrapper.ad?.dispose();
    }
    return null;
  }

  // ===========================================================================
  // 3. 插屏广告 (Interstitial Ad) 预加载
  // ===========================================================================
  Future<void> preloadInterstitialAd(AdInfo adInfo) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final targetCapacity = _calculateAdaptiveCapacity(unitId);
    final queue = _preloadQueueMap.putIfAbsent(unitId, () => []);

    queue.removeWhere((wrapper) {
      if (wrapper.isExpired) {
        wrapper.ad?.dispose();
        return true;
      }
      return false;
    });

    if (queue.length >= targetCapacity || _loadingUnits.contains(unitId)) {
      return;
    }

    _loadingUnits.add(unitId);

    InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          queue.add(PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          ));
          debugPrint('⚡ [AdPreload] InterstitialAd 预加载成功: $unitId');
        },
        onAdFailedToLoad: (error) {
          _loadingUnits.remove(unitId);
          debugPrint('❌ [AdPreload] InterstitialAd 预加载失败: $error');
        },
      ),
    );
  }

  PreloadedAdWrapper? consumeInterstitialAd(String adUnitId) {
    _recordConsumption(adUnitId);
    final queue = _preloadQueueMap[adUnitId];
    if (queue != null && queue.isNotEmpty) {
      final wrapper = queue.removeAt(0);
      if (!wrapper.isExpired) {
        debugPrint('🚀 [AdPreload] 命中 Interstitial 预加载池 (0ms 秒出): $adUnitId');
        return wrapper;
      }
      wrapper.ad?.dispose();
    }
    return null;
  }

  // ===========================================================================
  // 4. 激励广告 (Rewarded Ad) 预加载
  // ===========================================================================
  Future<void> preloadRewardedAd(AdInfo adInfo) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final targetCapacity = _calculateAdaptiveCapacity(unitId);
    final queue = _preloadQueueMap.putIfAbsent(unitId, () => []);

    queue.removeWhere((wrapper) {
      if (wrapper.isExpired) {
        wrapper.ad?.dispose();
        return true;
      }
      return false;
    });

    if (queue.length >= targetCapacity || _loadingUnits.contains(unitId)) {
      return;
    }

    _loadingUnits.add(unitId);

    RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          queue.add(PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          ));
          debugPrint('⚡ [AdPreload] RewardedAd 视频素材预加载成功: $unitId');
        },
        onAdFailedToLoad: (error) {
          _loadingUnits.remove(unitId);
          debugPrint('❌ [AdPreload] RewardedAd 预加载失败: $error');
        },
      ),
    );
  }

  PreloadedAdWrapper? consumeRewardedAd(String adUnitId) {
    _recordConsumption(adUnitId);
    final queue = _preloadQueueMap[adUnitId];
    if (queue != null && queue.isNotEmpty) {
      final wrapper = queue.removeAt(0);
      if (!wrapper.isExpired) {
        debugPrint('🚀 [AdPreload] 命中 Rewarded 预加载池 (点击即刻秒播): $adUnitId');
        return wrapper;
      }
      wrapper.ad?.dispose();
    }
    return null;
  }

  // ===========================================================================
  // 5. 统一入口：应用启动时预加载全品类广告
  // ===========================================================================
  void preloadDefaultAds() {
    preloadBannerAd(AdManager.bannerAd);
    preloadBannerAd(AdManager.adaptiveBannerAd);
    preloadNativeAd(AdManager.nativeAdvancedAd);
    preloadInterstitialAd(AdManager.interstitialAd);
    preloadRewardedAd(AdManager.rewardedInterstitialAd);
  }
}
