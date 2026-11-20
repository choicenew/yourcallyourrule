import 'package:material_ui/material_ui.dart';
import '../models/house_ad_slot.dart';
import '../engine/matrix_ad_arbitrator.dart';
import '../manager/house_ads_manager.dart';
import 'house_ad_adaptive_card.dart';

/// 槽位自定义 Widget 构建器
typedef HouseAdCustomBuilder = Widget Function(
  BuildContext context,
  HouseAdDecision decision,
  HouseAdSlotType slotType,
);

/// 主 App 直接调用的响应式自适应 House Ad 组件
class HouseAdWidget extends StatelessWidget {
  final HouseAdSlotType slot;
  final HouseAdCustomBuilder? customBuilder;

  const HouseAdWidget({
    super.key,
    this.slot = HouseAdSlotType.anchoredBanner,
    this.customBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final manager = HouseAdsManager.instance;
    final decision = manager.scheduler?.selectNextAd(
      userState: manager.currentUserState,
    );

    if (decision == null) {
      return const SizedBox.shrink();
    }

    if (customBuilder != null) {
      return customBuilder!(context, decision, slot);
    }

    return HouseAdAdaptiveCard(
      decision: decision,
      slotType: slot,
      stringResolver: manager.stringResolver,
      onAction: (ctx, dec) => manager.handleAdAction(ctx, dec),
    );
  }
}
