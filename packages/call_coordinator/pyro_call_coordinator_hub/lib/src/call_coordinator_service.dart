import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_call_coordinator_protocol/pyro_call_coordinator_protocol.dart';

part 'call_coordinator_service.g.dart';

@Riverpod(keepAlive: true)
CallCoordinatorService callCoordinatorService(Ref ref) {
  final service = CallCoordinatorService.instance;
  return service;
}

/// Master 并发编排中枢服务 (CallCoordinatorService)
class CallCoordinatorService {
  static final CallCoordinatorService instance = CallCoordinatorService._();

  CallCoordinatorService._();

  final List<CallCoordinatorDriver> _drivers = [];
  final _callDataController = StreamController<CallCoordinatorData>.broadcast();

  Stream<CallCoordinatorData> get callDataStream => _callDataController.stream;

  void registerCoordinatorDriver(CallCoordinatorDriver driver) {
    _drivers.add(driver);
    debugPrint('[CallCoordinatorHub] 已挂载注册编排响应驱动: ${driver.runtimeType}');
  }

  void publishCallData(CallCoordinatorData data) {
    _callDataController.add(data);
    for (final driver in _drivers) {
      driver.onCallDataPublished(data);
    }
    debugPrint('[CallCoordinatorHub] 并发编排发布 CallData: ${data.phoneNumber}');
  }
}
