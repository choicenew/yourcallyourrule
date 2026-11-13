import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'call_overlay_content_builder.dart';

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
    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);

    return asyncConfig.when(
      data: (config) => CallOverlayContentBuilder.buildCallOverlayContent(
        context: context,
        config: config,
        callerIdData: callerIdData,
        simInfo: simInfo,
        stirInfo: stirInfo,
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }
}
