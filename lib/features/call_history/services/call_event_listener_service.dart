import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/features/call_history/services/call_log_recorder.dart';
import 'package:yourcallyourrule/features/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/intercept_event_provider.dart';
import 'package:yourcallyourrule/features/call_monitor/services/caller_id_monitor_service.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

typedef CallData = CallerIdData;

class CallEventListenerService {
  final Ref _ref;
  final CallLogService _callLogService;
  final CallerIdMonitorService _callerIdMonitorService;
  final PredefinedLabelService _predefinedLabelService;
  late final CallLogRecorder _callLogRecorder;

  final Map<String, CallData> _processedCallDataBuffer = {};

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
