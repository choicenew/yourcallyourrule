import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';

import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/caller_id_content_builder.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';

// 【关键修改点】: 改为 ConsumerWidget，不再需要 StatefulWidget
class CallerIdSample extends ConsumerWidget {
  const CallerIdSample({super.key});
  
  // 【关键修改点】: initState 中的逻辑已废弃，Provider 会自我管理
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 【关键修改点】: 直接 watch 新的 provider
    final asyncConfig = ref.watch(callerIdStyleSecurityProvider);

    return OrientationBuilder(
      builder: (context, orientation) {
        // 尺寸计算逻辑保持不变
        final mediaQuery = MediaQuery.of(context);
        final overlayWidth = (orientation == Orientation.portrait
            ? (mediaQuery.size.width < 600 ? mediaQuery.size.width * 0.95 : mediaQuery.size.width * 0.7)
            : (mediaQuery.size.width * 0.6));
        final overlayHeight = overlayWidth * 0.5;

        // 【关键修改点】: 使用 .when() 处理 provider 的状态
        return asyncConfig.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (config) {
            return SizedBox(
              width: overlayWidth,
              height: overlayHeight,
              child: CallerIdContentBuilder.buildOverlayContainer(
                config: config,
                child: CallerIdContentBuilder.buildCallerIdContent(
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
  CallerIdData _mockCallerIdData() => CallerIdMockData.mockCallerIdData();
  StirInfo _mockStirInfoData() => CallerIdMockData.mockStirInfoData();
  SimInfo _mockSimInfoData() => CallerIdMockData.mockSimInfoData();
}