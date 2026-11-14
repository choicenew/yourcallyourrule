import 'package:material_ui/material_ui.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';

import 'call_overlay_content_builder.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';

class CallOverlayEntry extends ConsumerStatefulWidget {
  const CallOverlayEntry({super.key});

  @override
  ConsumerState<CallOverlayEntry> createState() => _CallOverlayEntryState();
}

class _CallOverlayEntryState extends ConsumerState<CallOverlayEntry> {
  CallerIdData? _callerIdData;
  SimInfo? _simInfo;
  StirInfo? _stirInfo;

  @override
  void initState() {
    super.initState();

    FloatingWindowAndroid.overlayListener.listen((event) {
      debugPrint('Received data: $event');
      if (event is Map<String, dynamic> && event.containsKey("configType")) {
        setState(() {
          String configType = event["configType"];
          if (configType == "callerIdData") {
            _callerIdData = _processCallerIdData(event);
          } else if (configType == "stirInfo") {
            _stirInfo = event;
          } else if (configType == "simInfo") {
            _simInfo = event;
          }
        });
      }
    });
  }

  CallerIdData _processCallerIdData(Map<String, dynamic> map) {
    return CallerIdData.fromMap(map);
  }

  @override
  Widget build(BuildContext context) {
    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);

    if (_callerIdData == null) {
      return const SizedBox.shrink();
    }

    return asyncConfig.when(
      data: (config) => CallOverlayContentBuilder.buildCallOverlayContent(
        context: context,
        config: config,
        callerIdData: _callerIdData!,
        simInfo: _simInfo,
        stirInfo: _stirInfo,
      ),
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
