import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:pyro_call_monitor_protocol/pyro_call_monitor_protocol.dart';

/// 真实内存级通道传感器驱动 (MemoryTelephonySensorDriver)
class MemoryTelephonySensorDriver implements TelephonySensorDriver {
  final _controller = StreamController<CallMonitorEvent>.broadcast();

  MemoryTelephonySensorDriver();

  @override
  Stream<CallMonitorEvent> get eventStream => _controller.stream;

  @override
  Future<void> startListening() async {
    debugPrint('[MemoryTelephonyDriver] 开始监听原生通道事件...');
  }

  @override
  Future<void> stopListening() async {
    await _controller.close();
    debugPrint('[MemoryTelephonyDriver] 停止监听原生通道事件。');
  }

  void simulateIncomingCall(String phoneNumber) {
    _controller.add(CallMonitorEvent.incoming(phoneNumber: phoneNumber));
  }
}
