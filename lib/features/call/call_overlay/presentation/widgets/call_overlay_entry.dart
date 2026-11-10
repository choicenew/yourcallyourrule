import 'package:flutter/material.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/call_overlay_content_builder.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

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
            _stirInfo = StirInfo.fromJson(event);
          } else if (configType == "simInfo") {
            _simInfo = SimInfo.fromJson(event);
          }
        });
      }
    });
  }

  CallerIdData _processCallerIdData(Map<String, dynamic> data) {
    List<Label> labels = (data['labels'] as List? ?? [])
        .map((labelData) => Label.fromMap(labelData))
        .toList();

    return CallerIdData(
      id: data['phoneNumber'] ?? '',
      phoneNumber: PhoneNumber.fromString(data['phoneNumber'] ?? ''),
      numberType: data['numberType'] != null && data['numberType'] is int
          ? PhoneNumberType.values[data['numberType']]
          : PhoneNumberType.unknown,
      name: data['name'],
      countryName: data['countryName'],
      region: data['region'],
      carrier: data['carrier'],
      labels: labels,
      avatar: data['avatar'],
      count: data['count'] ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_callerIdData == null) {
      return const Material(
        color: Color.fromARGB(0, 250, 1, 1),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final asyncConfig = ref.watch(callOverlayStyleSecurityProvider);
    final asyncLocale = ref.watch(localeProvider);

    return asyncLocale.when(
      loading: () => const Material(color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Material(color: Colors.transparent, child: Center(child: Text('Lang Error: $err'))),
      data: (locale) {
        return Localizations.override(
          context: context,
          locale: locale,
          child: Builder(
            builder: (localizedContext) {
              if (_callerIdData == null) {
                return const Material(
                  color: Colors.transparent,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return asyncConfig.when(
                loading: () => const Material(color: Colors.transparent, child: Center(child: CircularProgressIndicator())),
                error: (err, stack) => Material(color: Colors.transparent, child: Center(child: Text('Config Error: $err'))),
                data: (config) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      key: Key(_callerIdData!.id),
                      onTap: () async {
                        await FloatingWindowAndroid.closeOverlayFromOverlay();
                      },
                      child: CallOverlayContentBuilder.buildOverlayContainer(
                        config: config,
                        child: CallOverlayContentBuilder.buildCallOverlayContent(
                          context: localizedContext,
                          callerIdData: _callerIdData!,
                          config: config,
                          simInfo: _simInfo,
                          stirInfo: _stirInfo,
                          isDraggable: false,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

typedef CallerIdOverlayEntry = CallOverlayEntry;
