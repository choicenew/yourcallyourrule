import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';

import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';

class CallerIdOverlay extends ConsumerWidget {
  final CallerIdData callerIdData;
  final SimInfo? simInfo;
  final StirInfo? stirInfo;
  final VoidCallback onDismiss;
  final bool isDismissible;

  const CallerIdOverlay({
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
    final asyncConfig = ref.watch(callerIdStyleSecurityProvider);

    return asyncConfig.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (config) {
        // 【关键修改点】: read notifier 以便调用其方法
        final notifier = ref.read(callerIdStyleSecurityProvider.notifier);
        
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

  Widget _buildOverlayContent(BuildContext context, CallerIdConfig config, CallerIdStyleSecurityNotifier notifier) {
    return CallerIdContentBuilder.buildOverlayContainer(
      config: config,
      child: CallerIdContentBuilder.buildCallerIdContent(
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