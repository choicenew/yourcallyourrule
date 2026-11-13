import 'package:pyro_phone_call_monitor_protocol/src/models/call_monitor_events.dart';

/// 原生 Telephony 通道传感器 Driver 抽象接口契约 (TelephonySensorDriver)
abstract class TelephonySensorDriver {
  Stream<CallMonitorEvent> get eventStream;
  Future<void> startListening();
  Future<void> stopListening();
}
