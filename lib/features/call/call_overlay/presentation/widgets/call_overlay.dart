import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_content_builder.dart';

import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';

class CallOverlay extends ConsumerWidget {
  final CallerIdData callerIdData;
  final SimInfo? simInfo;
  final StirInfo? stirInfo;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const CallOverlay({
    super.key,
    required this.callerIdData,
    this.simInfo,
    this.stirInfo,
    required this.onDismiss,
    required this.isDismissible,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 【关键修改点】: watch 统一的 provider
    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);

    return asyncConfig.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (config) {
        // 【关键修改点】: read notifier 以便调用其方法
        final notifier = ref.read(callOverlayStyleSecurityProvider.notifier);
        
        final content = _buildOverlayContent(context, config, notifier);

        return isDismissible
            ? Dismissible(
                key: Key(callerIdData.id),
                direction: DismissDirection.horizontal,
                onDismissed: (_) => onDismiss(),
                child: content,
              )
            : content;
      },
    );
  }

  Widget _buildOverlayContent(BuildContext context, CallOverlayConfig config, CallOverlayStyleSecurityNotifier notifier) {
    return CallOverlayContentBuilder.buildOverlayContainer(
      config: config,
      child: CallOverlayContentBuilder.buildCallOverlayContent(
        context: context,
        callerIdData: callerIdData,
        config: config,
        simInfo: simInfo,
        stirInfo: stirInfo,
        isDraggable: true, // 在预览界面，元素是可拖动的
        // 【关键修改点】: 将 notifier 的方法作为回调传递下去
        onAvatarPositionChanged: notifier.updateAvatarPosition,
        onCarrierPositionChanged: notifier.updateCarrierPosition,
        onNamePositionChanged: notifier.updateNamePosition,
        onCountryNamePositionChanged: notifier.updateCountryNamePosition,
        onLabelsPositionChanged: notifier.updateLabelsPosition,
        onCountPositionChanged: notifier.updateCountPosition,
        onNumberTypePositionChanged: notifier.updateNumberTypePosition,
        onNumberPositionChanged: notifier.updateNumberPosition,
        onLocationPositionChanged: notifier.updateLocationPosition,
        onStirPositionChanged: notifier.updateStirPosition,
        onCallTypePositionChanged: notifier.updateCallTypePosition,
        onSimCardPositionChanged: notifier.updateSimCardPosition,
        onSecurityMessagePositionChanged: notifier.updateSecurityMessagePosition,
      ),
    );
  }
}

typedef CallerIdOverlay = CallOverlay;