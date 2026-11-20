import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/phone_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/phone_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/phone_monitor/services/caller_id_monitor_service.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

class CallEventListenerService {
  final Ref _ref;
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
  final PredefinedLabelService _predefinedLabelService;
  late final CallLogRecorder _callLogRecorder;

  final Map<String, CallerIdData> _processedCallDataBuffer = {};

  CallEventListenerService(
    this._ref,
    this._callLogService,
    this._callerIdMonitorService,
    this._predefinedLabelService,
  ) {
    _callLogRecorder = CallLogRecorder(_callLogService, _predefinedLabelService);
  }

  Future<void> initialize() async {}

  void dispose() {}
}
