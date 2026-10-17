// -----------------------------------------------------------------------------
// 文件: ad_cache_provider.dart
// 描述: 全局广告缓存中心 (已更新至 Riverpod Generator 方案)。
//
// 【核心修改】
// 1.  使用 `@riverpod` 注解来代替手动的 Provider 声明。
// 2.  类名 `AdCacheNotifier` 需继承由生成器创建的 `_$AdCacheNotifier`。
// 3.  `build` 方法现在正确地接收 family 参数 (`adInfo`)。
// 4.  需要一个 `part` 指令来链接到即将生成的代码文件。
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// 【新增】: 导入代码生成所需的注解库
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

// 【新增】: `part` 指令，链接到代码生成器将要创建的文件。
// 如果这里有红线，是正常的，运行生成命令后就会消失。
part 'ad_cache_provider.g.dart';

/// 【新增】: 一个专门用于区分自适应 Banner 类型的、无冲突的 enum。
enum AdaptiveBannerType { inline, anchored }

/// 广告缓存的状态数据结构 (这个类保持不变)。
@immutable
class AdCacheState {
  final BannerAd? bannerAd;
  final bool isStarted;
  final bool isLoaded;
  final bool isFailed;
  final AdSize? adSize;

  const AdCacheState({
    this.bannerAd,
    this.isStarted = false,
    this.isLoaded = false,
    this.isFailed = false,
    this.adSize,
  });

  AdCacheState copyWith({
    BannerAd? bannerAd,
    bool? isStarted,
    bool? isLoaded,
    bool? isFailed,
    AdSize? adSize,
  }) {
    return AdCacheState(
      bannerAd: bannerAd ?? this.bannerAd,
      isStarted: isStarted ?? this.isStarted,
      isLoaded: isLoaded ?? this.isLoaded,
      isFailed: isFailed ?? this.isFailed,
      adSize: adSize ?? this.adSize,
    );
  }
}

/// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存
@riverpod
class AdCache extends _$AdCache {
  // 【修改】: 继承 _$AdCache (由生成器创建)
  late final AdInfo _adInfo;
  BannerAd? _bannerAd;
  bool _hasRetried = false;

  /// `build` 方法现在是 family 的入口，它接收 `adInfo` 参数。
  /// 它只在 Provider 第一次被创建时运行一次。
  @override
  AdCacheState build(AdInfo adInfo) {
    _adInfo = adInfo;
    // 自动管理资源的销毁，使用私有引用进行 dispose，避免访问 state 抛出异常
    ref.onDispose(() {
      _bannerAd?.dispose();
      _bannerAd = null;
    });
    return const AdCacheState(); // 返回初始状态
  }

  /// 加载广告的公开方法。
  /// 【修正】: loadAd 方法现在接受新的 `AdaptiveBannerType`。
  /// 【修正】: 新增可选的 `explicitWidth` 参数。
  Future<void> loadAd(
    BuildContext context,
    AdaptiveBannerType bannerType, {
    double? explicitWidth,
  }) async {
    // 如果已经开始加载，则立即返回。
    if (state.isStarted) return;

    // 标记为“已开始加载”。
    state = state.copyWith(isStarted: true);

    // `arg` 是由代码生成器提供的，它就是 build 方法接收的 `adInfo` 参数。
    final AdInfo adInfo = _adInfo;
    // 【核心逻辑】: 优先使用传入的宽度，否则使用屏幕宽度。
    final double calculationWidth =
        explicitWidth ?? MediaQuery.of(context).size.width;
    AdSize? size;

    // 【核心修复】：优先检查 adInfo 是否自带尺寸 (例如 AdSize.banner 320x50)。
    // 如果已有显式尺寸，直接尊重并使用，不强行改为自适应尺寸，从而完美兼容全 App 所有 UI 页面的调用！
    if (adInfo.size != null) {
      size = adInfo.size;
    } else {
      // 否则根据传入的 bannerType 动态计算自适应广告尺寸
      switch (bannerType) {
        case AdaptiveBannerType.inline:
          size = await AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
            calculationWidth.truncate(),
          );
          break;
        case AdaptiveBannerType.anchored:
          size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            calculationWidth.truncate(),
          );
          break;
      }
    }

    if (size == null) {
      debugPrint('Failed to get ad size for type: $bannerType');
      state = state.copyWith(isStarted: true, isLoaded: false);
      return;
    }

    final ad = BannerAd(
      adUnitId: adInfo.adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          final bannerAd = ad as BannerAd;
          _bannerAd = bannerAd;
          final platformAdSize = await bannerAd.getPlatformAdSize();
          if (!ref.mounted) {
            bannerAd.dispose();
            _bannerAd = null;
            return;
          }
          state = state.copyWith(
            bannerAd: bannerAd,
            isLoaded: true,
            isFailed: false,
            adSize: platformAdSize,
          );
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          debugPrint('Ad failed to load: $error');
          if (!ref.mounted) return;
          if (!_hasRetried) {
            _hasRetried = true;
            debugPrint('AdCache 首次加载失败，4秒后自动重试...');
            Future.delayed(const Duration(seconds: 4), () {
              if (ref.mounted) {
                state = state.copyWith(isStarted: false);
                loadAd(context, bannerType, explicitWidth: explicitWidth);
              }
            });
          } else {
            state = state.copyWith(
              bannerAd: null,
              isStarted: true,
              isLoaded: false,
              isFailed: true,
            );
          }
        },
      ),
    );
    await ad.load();
  }
}
