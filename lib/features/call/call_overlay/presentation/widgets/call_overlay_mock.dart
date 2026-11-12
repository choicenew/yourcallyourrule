import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';

import 'package:yourcallyourrule/features/call/call_overlay/mock_data/call_overlay_mock.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_content_builder.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';

class CallOverlaySample extends ConsumerWidget {
  const CallOverlaySample({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);

    return OrientationBuilder(
      builder: (context, orientation) {
        final mediaQuery = MediaQuery.of(context);
        final overlayWidth = (orientation == Orientation.portrait
            ? (mediaQuery.size.width < 600 ? mediaQuery.size.width * 0.95 : mediaQuery.size.width * 0.7)
            : (mediaQuery.size.width * 0.6));
        final overlayHeight = overlayWidth * 0.5;

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
                  isDraggable: false,
                ),
              ),
            );
          },
        );
      },
    );
  }

  CallerIdData _mockCallerIdData() => CallOverlayMockData.mockCallerIdData();
  StirInfo _mockStirInfoData() => CallOverlayMockData.mockStirInfoData();
  SimInfo _mockSimInfoData() => CallOverlayMockData.mockSimInfoData();
}

typedef CallerIdSample = CallOverlaySample;
