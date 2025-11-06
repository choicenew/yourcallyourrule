// lib/features/call/live_activities/ui/widgets/live_notification_preview.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';

import 'package:yourcallyourrule/features/call/live_activities/providers/live_notification_config_provider.dart';

/// 一个可交互的、模拟 Android 通知尺寸和左右死区的预览组件
class LiveNotificationPreview extends ConsumerWidget {
  final LiveNotificationConfig config;

  const LiveNotificationPreview({super.key, required this.config});

  static const double _kHeightExpanded = 200.0; // 展开高度
  static const double _kHeightCollapsed = 64.0; // 折叠高度指示线
  static const double _kLeftDeadZone = 24.0; // 左侧系统区域（调整更窄，文本可更靠左）
  static const double _kRightDeadZone = 24.0; // 右侧系统区域与左侧对齐

  Color _colorFromHex(String hexColor) {
    var v = hexColor.toUpperCase().replaceAll('#', '');
    if (v.length == 6) {
      v = 'FF$v';
    }
    return Color(int.parse(v, radix: 16));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(liveNotificationConfigProvider.notifier);
    final mockData = CallerIdMockData.mockCallerIdData();
    final mockSimInfo = CallerIdMockData.mockSimInfoData();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSystemHeader(),
          const SizedBox(height: 8),
          Container(
            height: _kHeightExpanded,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _colorFromHex(config.globalSettings.backgroundColor),
              borderRadius: BorderRadius.circular(config.globalSettings.border.radius),
              border: config.globalSettings.border.width > 0
                  ? Border.all(
                      color: _colorFromHex(config.globalSettings.border.color),
                      width: config.globalSettings.border.width,
                    )
                  : null,
            ),
            child: Stack(
              children: [
                // 折叠高度指示线 (64dp)
                const Positioned(
                  top: _kHeightCollapsed,
                  left: 0,
                  right: 0,
                  child: DottedLineSeparator(),
                ),
                // 左右系统区域（不可交互）视觉指示
                Positioned.fill(
                  child: Row(
                    children: [
                      Container(width: _kLeftDeadZone, color: Colors.black.withOpacity(0.05)),
                      const Expanded(child: SizedBox()),
                      Container(width: _kRightDeadZone, color: Colors.black.withOpacity(0.05)),
                    ],
                  ),
                ),
                // 可交互内容区域：限制拖拽范围
                Padding(
                  padding: const EdgeInsets.only(left: _kLeftDeadZone, right: _kRightDeadZone),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          if (config.avatar.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.avatar.position.x, config.avatar.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('avatar', pos),
                              child: CircleAvatar(
                                radius: config.avatar.size / 2,
                                backgroundColor: _colorFromHex(config.avatar.borderColor),
                                child: CircleAvatar(
                                  radius: (config.avatar.size / 2) - config.avatar.borderWidth,
                                  backgroundColor: Colors.blue,
                                  child: const Icon(Icons.person, color: Colors.white),
                                ),
                              ),
                            ),

                          if (config.name.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.name.position.x, config.name.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('name', pos),
                              child: Text(
                                mockData.name ?? 'Unknown Name',
                                style: TextStyle(
                                  color: _colorFromHex(config.name.color),
                                  fontSize: config.name.fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          if (config.number.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.number.position.x, config.number.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('number', pos),
                              child: Text(
                                mockData.phoneNumber.value,
                                style: TextStyle(
                                  color: _colorFromHex(config.number.color),
                                  fontSize: config.number.fontSize,
                                ),
                              ),
                            ),

                          if (config.location.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.location.position.x, config.location.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('location', pos),
                              child: Text(
                                mockData.region ?? 'Unknown Location',
                                style: TextStyle(
                                  color: _colorFromHex(config.location.color),
                                  fontSize: config.location.fontSize,
                                ),
                              ),
                            ),

                          if (config.carrier.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.carrier.position.x, config.carrier.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('carrier', pos),
                              child: Text(
                                mockData.carrier ?? 'Unknown Carrier',
                                style: TextStyle(
                                  color: _colorFromHex(config.carrier.color),
                                  fontSize: config.carrier.fontSize,
                                ),
                              ),
                            ),

                          if (config.countryName.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.countryName.position.x, config.countryName.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('countryName', pos),
                              child: Text(
                                mockData.countryName ?? 'Unknown Country',
                                style: TextStyle(
                                  color: _colorFromHex(config.countryName.color),
                                  fontSize: config.countryName.fontSize,
                                ),
                              ),
                            ),

                          if (config.labels.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.labels.position.x, config.labels.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('labels', pos),
                              child: Text(
                                mockData.labels?.map((l) => l.label).join(', ') ?? 'No Labels',
                                style: TextStyle(
                                  color: _colorFromHex(config.labels.color),
                                  fontSize: config.labels.fontSize,
                                ),
                              ),
                            ),

                          if (config.count.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.count.position.x, config.count.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('count', pos),
                              child: Text(
                                'Marked by ${mockData.count}',
                                style: TextStyle(
                                  color: _colorFromHex(config.count.color),
                                  fontSize: config.count.fontSize,
                                ),
                              ),
                            ),

                          if (config.numberType.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.numberType.position.x, config.numberType.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('numberType', pos),
                              child: Text(
                                mockData.numberType.name,
                                style: TextStyle(
                                  color: _colorFromHex(config.numberType.color),
                                  fontSize: config.numberType.fontSize,
                                ),
                              ),
                            ),

                          if (config.stir.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.stir.position.x, config.stir.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('stir', pos),
                              child: Text(
                                'Verified',
                                style: TextStyle(
                                  color: _colorFromHex(config.stir.color),
                                  fontSize: config.stir.fontSize,
                                ),
                              ),
                            ),

                          if (config.simCard.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.simCard.position.x, config.simCard.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('simCard', pos),
                              child: Text(
                                mockSimInfo.displayName ?? 'SIM',
                                style: TextStyle(
                                  color: _colorFromHex(config.simCard.color),
                                  fontSize: config.simCard.fontSize,
                                ),
                              ),
                            ),

                          if (config.callType.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.callType.position.x, config.callType.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('callType', pos),
                              child: Icon(
                                Icons.call_received,
                                size: config.callType.size,
                                color: _colorFromHex(config.callType.color),
                              ),
                            ),

                          if (config.securityMessage.visible)
                            _DraggableElement(
                              parentConstraints: constraints,
                              position: Offset(config.securityMessage.position.x, config.securityMessage.position.y),
                              onPositionChanged: (pos) => notifier.updateElementPosition('securityMessage', pos),
                              child: Container(
                                width: config.securityMessage.containerWidth,
                                height: config.securityMessage.height,
                                color: _colorFromHex(config.securityMessage.backgroundColor),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Security Alert!',
                                  style: TextStyle(
                                    color: _colorFromHex(config.securityMessage.color),
                                    fontSize: config.securityMessage.fontSize,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Row(
        children: [
          Icon(Icons.android, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text('Your App Name', style: TextStyle(color: Colors.white, fontSize: 12)),
          Spacer(),
          Text('now', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _DraggableElement extends StatelessWidget {
  final BoxConstraints parentConstraints;
  final Offset position;
  final Function(Offset) onPositionChanged;
  final Widget child;

  const _DraggableElement({
    required this.parentConstraints,
    required this.position,
    required this.onPositionChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          final newDx = (position.dx + details.delta.dx).clamp(0.0, parentConstraints.maxWidth - 20);
          final newDy = (position.dy + details.delta.dy).clamp(0.0, parentConstraints.maxHeight - 20);
          onPositionChanged(Offset(newDx, newDy));
        },
        child: child,
      ),
    );
  }
}

class DottedLineSeparator extends StatelessWidget {
  const DottedLineSeparator({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        const dashSpace = 3.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.white38),
              ),
            );
          }),
        );
      },
    );
  }
}