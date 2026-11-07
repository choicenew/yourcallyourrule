import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'base_call_handler.dart';

part 'sim_call_handler.g.dart';

@Riverpod(keepAlive: true)
class SimCallHandler extends _$SimCallHandler implements BaseCallHandler {
  @override
  SimInfo? build() {
    ref.onDispose(() {});
    return null;
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}

  @override
  dynamic handleMethodCall(MethodCall call) {
    switch (call.method) {
      case "onSimInitializationComplete":
        return _handleInitializationComplete();
      case "onSimInfo":
        final args = call.arguments as Map<dynamic, dynamic>? ?? {};
        return _handleSimInfo(
          args['carrierName'] as String?,
          args['displayName'] as String?,
          args['iccId'] as String?,
          args['countryIso'] as String?,
          args['incomingPhoneNumber'] as String?,
          args['simSlotIndex'] as int?,
          args['subscriptionId'] as int?,
          args['mccString'] as String?,
          args['mncString'] as String?,
          args['simPhoneNumber'] as String?,
          args['callType'] as String?,
        );
      default:
        throw UnimplementedError('SimCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  void _handleSimInfo(
    String? carrierName,
    String? displayName,
    String? iccId,
    String? countryIso,
    String? phoneNumber,
    int? simSlotIndex,
    int? subscriptionId,
    String? mccString,
    String? mncString,
    String? simPhoneNumber,
    String? callType,
  ) {
    final newSimInfo = SimInfo(
      carrierName: carrierName,
      displayName: displayName,
      iccId: iccId,
      countryIso: countryIso,
      phoneNumber: phoneNumber,
      simSlotIndex: simSlotIndex,
      subscriptionId: subscriptionId,
      mccString: mccString,
      mncString: mncString,
      simPhoneNumber: simPhoneNumber,
      callType: callType,
    );
    state = newSimInfo;
  }
}
