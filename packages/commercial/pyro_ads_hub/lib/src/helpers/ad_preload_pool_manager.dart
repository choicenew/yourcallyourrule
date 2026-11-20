import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 预加载包装器 (带 3 小时过期清空校验)
class HubPreloadWrapper {
  final String providerId;
  final AdSlotType slotType;
  final String placementId;
  final DateTime loadTime;

  HubPreloadWrapper({
    required this.providerId,
    required this.slotType,
    required this.placementId,
    required this.loadTime,
  });

  /// 检查预加载广告句柄是否超过 3 小时阈值
  bool get isExpired => DateTime.now().difference(loadTime).inHours >= 3;
}

/// 全局纯中枢广告预加载池管理器 (AdPreloadPoolManager)
/// 100% 运行在 pyro_ads_hub 内部，对底层 Protocol 与 Driver 驱动零触碰、零侵入。
/// 内置【滑动消耗速度预测算法】：低频保持 1 个容量；10s 内消耗 ≥ 2 次扩容至 2 个容量；闲置 10s 后恢复。
class AdPreloadPoolManager {
  AdPreloadPoolManager._();
  static final AdPreloadPoolManager instance = AdPreloadPoolManager._();

  // 预加载队列: key ('providerId_slotType') -> List<HubPreloadWrapper>
  final Map<String, List<HubPreloadWrapper>> _pool = {};
  final Set<String> _loadingKeys = {};

  // 10 秒滑动消耗时间戳记录
  final Map<String, List<DateTime>> _consumptionTimestamps = {};

  String _buildKey(String providerId, AdSlotType slotType) =>
      '${providerId.toLowerCase()}_${slotType.name}';

  /// 计算自适应预加载容量上限 (1 ~ 2)
  int _calculateAdaptiveCapacity(String key) {
    final now = DateTime.now();
    final timestamps = _consumptionTimestamps[key] ?? [];

    timestamps.removeWhere((ts) => now.difference(ts).inSeconds > 10);
    _consumptionTimestamps[key] = timestamps;

    if (timestamps.length >= 2) {
      debugPrint('⚡ [AdPreloadPoolManager] 高频滑动消费检测 ($key: ${timestamps.length}次/10s)，池容量扩容至 2');
      return 2;
    }
    return 1;
  }

  void _recordConsumption(String key) {
    final list = _consumptionTimestamps.putIfAbsent(key, () => []);
    list.add(DateTime.now());
  }

  /// 触发指定渠道与槽位的纯哑巴预加载
  Future<void> preloadSlot({
    required String providerId,
    required AdSlotType slotType,
    String? customPlacementId,
  }) async {
    final key = _buildKey(providerId, slotType);
    final capacity = _calculateAdaptiveCapacity(key);
    final queue = _pool.putIfAbsent(key, () => []);

    // 清理已过期项
    queue.removeWhere((w) => w.isExpired);

    if (queue.length >= capacity || _loadingKeys.contains(key)) {
      return;
    }

    final driver = AdsHub.instance.getDriver(providerId);
    if (driver == null) return;

    final placementId = customPlacementId ??
        AdsHub.instance.getPlacementId(providerId, slotType) ??
        '';

    _loadingKeys.add(key);
    try {
      switch (slotType) {
        case AdSlotType.interstitial:
          await driver.loadInterstitial(placementId);
          break;
        case AdSlotType.rewarded:
          await driver.loadRewarded(placementId);
          break;
        case AdSlotType.appOpen:
          await driver.loadAppOpen(placementId);
          break;
        default:
          break;
      }

      queue.add(HubPreloadWrapper(
        providerId: providerId,
        slotType: slotType,
        placementId: placementId,
        loadTime: DateTime.now(),
      ));
      debugPrint('⚡ [AdPreloadPoolManager] 预加载成功 ($key, 当前队列: ${queue.length}/$capacity)');

      if (queue.length < capacity) {
        preloadSlot(
          providerId: providerId,
          slotType: slotType,
          customPlacementId: customPlacementId,
        );
      }
    } catch (e) {
      debugPrint('❌ [AdPreloadPoolManager] 预加载失败 ($key): $e');
    } finally {
      _loadingKeys.remove(key);
    }
  }

  /// 消费并弹出预加载广告
  Future<bool> consumeAndShowSlot({
    required String providerId,
    required AdSlotType slotType,
    Function(MagmaRewardItem item)? onReward,
  }) async {
    final key = _buildKey(providerId, slotType);
    _recordConsumption(key);

    final queue = _pool[key];
    if (queue != null && queue.isNotEmpty) {
      final wrapper = queue.removeAt(0);
      if (!wrapper.isExpired) {
        final driver = AdsHub.instance.getDriver(providerId);
        if (driver != null) {
          switch (slotType) {
            case AdSlotType.interstitial:
              await driver.showInterstitial();
              break;
            case AdSlotType.rewarded:
              if (onReward != null) {
                await driver.showRewarded(onReward);
              }
              break;
            case AdSlotType.appOpen:
              await driver.showAppOpen();
              break;
            default:
              break;
          }
          debugPrint('🚀 [AdPreloadPoolManager] 0ms 命中中枢预加载池 ($key, 剩余: ${queue.length})');
          return true;
        }
      }
    }
    return false;
  }

  /// 一键预加载基础默认广告
  void preloadDefaultAdsForDriver(String providerId) {
    preloadSlot(providerId: providerId, slotType: AdSlotType.interstitial);
    preloadSlot(providerId: providerId, slotType: AdSlotType.rewarded);
  }
}
