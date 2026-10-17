// -----------------------------------------------------------------------------
// 文件: ad_preload_service.dart
// 描述: 全局广告预加载池管理器 (Ad Preload Engine)。
// 支持对 Banner、Native、插屏 (Interstitial) 和 激励广告 (Rewarded) 进行全方位预加载！
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

  // 广告池映射：adUnitId -> PreloadedAdWrapper
  final Map<String, PreloadedAdWrapper> _preloadPool = {};
  final Set<String> _loadingUnits = {};

  // ===========================================================================
  // 1. 横幅广告 (Banner / Adaptive Banner) 预加载
  // ===========================================================================
  Future<void> preloadBannerAd(AdInfo adInfo, {AdSize? customSize}) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final existing = _preloadPool[unitId];
    if (existing != null && !existing.isExpired) return;
    if (_loadingUnits.contains(unitId)) return;

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
          _preloadPool[unitId]?.ad?.dispose();

          _preloadPool[unitId] = PreloadedAdWrapper(
            ad: bannerAd,
            adSize: platformAdSize,
            loadTime: DateTime.now(),
          );
          debugPrint('⚡ [AdPreload] BannerAd 预加载成功: $unitId');
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
    final wrapper = _preloadPool.remove(adUnitId);
    if (wrapper != null && !wrapper.isExpired) {
      debugPrint('🚀 [AdPreload] 命中 Banner 预加载池 (0ms 秒出): $adUnitId');
      return wrapper;
    }
    wrapper?.ad?.dispose();
    return null;
  }

  // ===========================================================================
  // 2. 原生高级广告 (Native Advanced) 预加载
  // ===========================================================================
  Future<void> preloadNativeAd(AdInfo adInfo, {NativeAdConfig? config}) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final existing = _preloadPool[unitId];
    if (existing != null && !existing.isExpired) return;
    if (_loadingUnits.contains(unitId)) return;

    _loadingUnits.add(unitId);
    final nativeConfig = config ??
        const NativeAdConfig(template: NativeAdTemplate.small);

    NativeAd(
      adUnitId: unitId,
      request: const AdRequest(),
      nativeTemplateStyle: nativeConfig.style,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          _preloadPool[unitId]?.ad?.dispose();

          _preloadPool[unitId] = PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          );
          debugPrint('⚡ [AdPreload] NativeAd 预加载成功: $unitId');
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
    final wrapper = _preloadPool.remove(adUnitId);
    if (wrapper != null && !wrapper.isExpired) {
      debugPrint('🚀 [AdPreload] 命中 Native 预加载池 (0ms 秒出): $adUnitId');
      return wrapper;
    }
    wrapper?.ad?.dispose();
    return null;
  }

  // ===========================================================================
  // 3. 插屏广告 (Interstitial Ad) 预加载 (谷歌官方推荐提前预加载)
  // ===========================================================================
  Future<void> preloadInterstitialAd(AdInfo adInfo) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final existing = _preloadPool[unitId];
    if (existing != null && !existing.isExpired) return;
    if (_loadingUnits.contains(unitId)) return;

    _loadingUnits.add(unitId);

    InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          _preloadPool[unitId]?.ad?.dispose();

          _preloadPool[unitId] = PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          );
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
    final wrapper = _preloadPool.remove(adUnitId);
    if (wrapper != null && !wrapper.isExpired) {
      debugPrint('🚀 [AdPreload] 命中 Interstitial 预加载池 (0ms 秒出): $adUnitId');
      return wrapper;
    }
    wrapper?.ad?.dispose();
    return null;
  }

  // ===========================================================================
  // 4. 激励广告 (Rewarded Ad) 预加载
  // 核心规则：可以提前预加载视频素材，但【绝对不自动播放】！
  // 只有当用户主动点击“看视频”按钮时，调用 show() 瞬间播放，避免用户等待5秒圈圈！
  // ===========================================================================
  Future<void> preloadRewardedAd(AdInfo adInfo) async {
    final unitId = adInfo.adUnitId;
    if (unitId.isEmpty || unitId.startsWith('<YOUR_')) return;

    final existing = _preloadPool[unitId];
    if (existing != null && !existing.isExpired) return;
    if (_loadingUnits.contains(unitId)) return;

    _loadingUnits.add(unitId);

    RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _loadingUnits.remove(unitId);
          _preloadPool[unitId]?.ad?.dispose();

          _preloadPool[unitId] = PreloadedAdWrapper(
            ad: ad,
            loadTime: DateTime.now(),
          );
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
    final wrapper = _preloadPool.remove(adUnitId);
    if (wrapper != null && !wrapper.isExpired) {
      debugPrint('🚀 [AdPreload] 命中 Rewarded 预加载池 (点击即刻秒播): $adUnitId');
      return wrapper;
    }
    wrapper?.ad?.dispose();
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
