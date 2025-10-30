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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

// 【新增】: 导入代码生成所需的注解库
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 【新增】: `part` 指令，链接到代码生成器将要创建的文件。
// 如果这里有红线，是正常的，运行生成命令后就会消失。
part 'ad_cache_provider.g.dart';

/// 【新增】: 一个专门用于区分自适应 Banner 类型的、无冲突的 enum。
enum AdaptiveBannerType {
  inline,
  anchored,
}





/// 广告缓存的状态数据结构 (这个类保持不变)。
@immutable
class AdCacheState {
  final BannerAd? bannerAd;
  final bool isStarted;
  final bool isLoaded;
  final AdSize? adSize;

  const AdCacheState({
    this.bannerAd,
    this.isStarted = false,
    this.isLoaded = false,
    this.adSize,
  });

  AdCacheState copyWith({
    BannerAd? bannerAd,
    bool? isStarted,
    bool? isLoaded,
    AdSize? adSize,
  }) {
    return AdCacheState(
      bannerAd: bannerAd ?? this.bannerAd,
      isStarted: isStarted ?? this.isStarted,
      isLoaded: isLoaded ?? this.isLoaded,
      adSize: adSize ?? this.adSize,
    );
  }
}


/// 【核心修改】: 使用 @riverpod 注解
///
/// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
/// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。
@Riverpod(keepAlive: true)
class AdCache extends _$AdCache { // 【修改】: 继承 _$AdCache (由生成器创建)
  late final AdInfo _adInfo;
  /// `build` 方法现在是 family 的入口，它接收 `adInfo` 参数。
  /// 它只在 Provider 第一次被创建时运行一次。
  @override
  AdCacheState build(AdInfo adInfo) {
      _adInfo = adInfo;
    // 自动管理资源的销毁
    ref.onDispose(() {
      state.bannerAd?.dispose();
    });
    return const AdCacheState(); // 返回初始状态
  }

  /// 加载广告的公开方法。
 /// 【修正】: loadAd 方法现在接受新的 `AdaptiveBannerType`。
 /// 【修正】: 新增可选的 `explicitWidth` 参数。
  Future<void> loadAd(BuildContext context, AdaptiveBannerType bannerType, {double? explicitWidth}) async {
    // 如果已经开始加载，则立即返回。
    if (state.isStarted) return;

    // 标记为“已开始加载”。
    state = state.copyWith(isStarted: true);

    // `arg` 是由代码生成器提供的，它就是 build 方法接收的 `adInfo` 参数。
     final AdInfo adInfo = _adInfo;
    // 【核心逻辑】: 优先使用传入的宽度，否则使用屏幕宽度。
    final double calculationWidth = explicitWidth ?? MediaQuery.of(context).size.width;
    AdSize? size;
  
    // 根据传入的、无冲突的 bannerType 来获取广告尺寸。
    switch (bannerType) {
      case AdaptiveBannerType.inline:
        size = await AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(calculationWidth.truncate());
        break;
      case AdaptiveBannerType.anchored:
        size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(calculationWidth.truncate());
        break;
    }

    if (size == null) {
      debugPrint('Failed to get ad size for type: $bannerType');
      state = const AdCacheState();
      return;
    }

    final ad = BannerAd(
      adUnitId: adInfo.adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          final bannerAd = ad as BannerAd;
          final platformAdSize = await bannerAd.getPlatformAdSize();
          state = state.copyWith(
            bannerAd: bannerAd,
            isLoaded: true,
            adSize: platformAdSize,
          );
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
          state = const AdCacheState();
        },
      ),
    );
    await ad.load();
  }
}