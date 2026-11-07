import 'package:flutter/foundation.dart';
import 'package:pyro_ads_protocol/pyro_ads_protocol.dart';
import '../ads_hub.dart';

/// 瀑布流降级与风险熔断仲裁器 (Waterfall Fallback & Strategy Arbitrator)
class WaterfallStrategyArbitrator {
  final AdsHub hub;

  WaterfallStrategyArbitrator(this.hub);

  /// 根据初始梯队 resolve 出当前有驱动可用的目标网络适配器，若找不到或遇到 No Fill 则自动按优先级回退降级
  NetworkAdapter? resolveAvailableAdapter(AdTrafficTier initialTier) {
    final tiersToTry = _buildFallbackChain(initialTier);

    for (final tier in tiersToTry) {
      final adapter = hub.getDriverByTier(tier);
      if (adapter != null) {
        debugPrint('[WaterfallStrategyArbitrator] Resolved adapter: ${adapter.providerName} for Tier: $tier');
        return adapter;
      }
    }

    debugPrint('[WaterfallStrategyArbitrator] Warning: No registered adapter found in fallback chain from $initialTier');
    return null;
  }

  List<AdTrafficTier> _buildFallbackChain(AdTrafficTier initialTier) {
    switch (initialTier) {
      case AdTrafficTier.tier1:
        return [AdTrafficTier.tier1, AdTrafficTier.tier2, AdTrafficTier.tier3, AdTrafficTier.tier4, AdTrafficTier.tier5];
      case AdTrafficTier.tier2:
        return [AdTrafficTier.tier2, AdTrafficTier.tier3, AdTrafficTier.tier4, AdTrafficTier.tier5];
      case AdTrafficTier.tier3:
        return [AdTrafficTier.tier3, AdTrafficTier.tier4, AdTrafficTier.tier5];
      case AdTrafficTier.tier4:
        return [AdTrafficTier.tier4, AdTrafficTier.tier5];
      case AdTrafficTier.tier5:
        return [AdTrafficTier.tier5];
      case AdTrafficTier.none:
        return [AdTrafficTier.tier5];
    }
  }
}
