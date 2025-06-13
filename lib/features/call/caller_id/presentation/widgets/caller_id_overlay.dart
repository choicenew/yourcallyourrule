import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/provider/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';

/// 来电监控服务的数据模型

/// 来电显示覆盖层组件
/// 显示来电信息的浮动窗口
class CallerIdOverlay extends ConsumerStatefulWidget {
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
  CallerIdOverlayState createState() => CallerIdOverlayState();
}

class CallerIdOverlayState extends ConsumerState<CallerIdOverlay> {
  final double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return widget.isDismissible
        ? Dismissible(
            key: Key(widget.callerIdData.id),
            direction: DismissDirection.horizontal,
            onDismissed: (_) => widget.onDismiss(),
            child: _buildOverlayContent(context),
          )
        : _buildOverlayContent(context);
  }

  Widget _buildOverlayContent(BuildContext context) {
    final styleProvider = ref.watch(callerIdStyleProvider);
    return CallerIdContentBuilder.buildOverlayContainer(
      styleProvider: styleProvider,
      opacity: _opacity,
      child: CallerIdContentBuilder.buildCallerIdContent(
        context: context,
        callerIdData: widget.callerIdData,
        styleProvider: styleProvider,
        simInfo: widget.simInfo,
        stirInfo: widget.stirInfo,
        isDraggable: true,
      ),
    );
  }

  // 使用共享的CallerIdContentBuilder替代原有的内容构建方法
}
