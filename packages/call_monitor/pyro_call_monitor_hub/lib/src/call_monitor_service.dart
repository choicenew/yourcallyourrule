import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_call_monitor_protocol/pyro_call_monitor_protocol.dart';

part 'call_monitor_service.g.dart';

@Riverpod(keepAlive: true)
CallMonitorService callMonitorService(Ref ref) {
  final service = CallMonitorService.instance;
  return service;
}

/// 通道传感器中枢服务 (CallMonitorService)
class CallMonitorService {
  static final CallMonitorService instance = CallMonitorService._();

  CallMonitorService._();

  TelephonySensorDriver? _sensorDriver;
  final _eventController = StreamController<CallMonitorEvent>.broadcast();

  Stream<CallMonitorEvent> get eventStream => _eventController.stream;

  void registerSensorDriver(TelephonySensorDriver driver) {
    _sensorDriver = driver;
    debugPrint('[CallMonitorHub] 已挂载注册传感器驱动: ${driver.runtimeType}');
  }

  TelephonySensorDriver? get sensorDriver => _sensorDriver;

  void emitEvent(CallMonitorEvent event) {
    _eventController.add(event);
    debugPrint('[CallMonitorHub] 传感器广播事件: ${event.runtimeType}');
  }
}
