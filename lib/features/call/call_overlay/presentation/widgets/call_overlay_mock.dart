import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';

import 'package:yourcallyourrule/features/call/call_overlay/mock_data/call_overlay_mock.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_content_builder.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';

// 【关键修改点�? 改为 ConsumerWidget，不再需�?StatefulWidget
class CallOverlaySample extends ConsumerWidget {
  const CallOverlaySample({super.key});
  
  // 【关键修改点�? initState 中的逻辑已废弃，Provider 会自我管�?
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 【关键修改点�? 直接 watch 新的 provider
    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);

    return OrientationBuilder(
      builder: (context, orientation) {
        // 尺寸计算逻辑保持不变
        final mediaQuery = MediaQuery.of(context);
        final overlayWidth = (orientation == Orientation.portrait
            ? (mediaQuery.size.width < 600 ? mediaQuery.size.width * 0.95 : mediaQuery.size.width * 0.7)
            : (mediaQuery.size.width * 0.6));
        final overlayHeight = overlayWidth * 0.5;

        // 【关键修改点�? 使用 .when() 处理 provider 的状�?
        return asyncConfig.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (config) {
            return SizedBox(
              width: overlayWidth,
              height: overlayHeight,
              child: CallOverlayContentBuilder.buildOverlayContainer(
                config: config,
                child: CallOverlayContentBuilder.buildCallOverlayContent(
                  context: context,
                  callerIdData: _mockCallerIdData(),
                  config: config,
                  simInfo: _mockSimInfoData(),
                  stirInfo: _mockStirInfoData(),
                  isDraggable: false, // 示例中通常不可拖动
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Mock 数据方法保持不变
  CallerIdData _mockCallerIdData() => CallOverlayMockData.mockCallerIdData();
  StirInfo _mockStirInfoData() => CallOverlayMockData.mockStirInfoData();
  SimInfo _mockSimInfoData() => CallOverlayMockData.mockSimInfoData();
}

typedef CallerIdSample = CallOverlaySample;