import 'dart:async';
import 'package:flutter/material.dart' hide Locale;
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/service/time_interceptor_service.dart';

part 'caller_id_monitor_service.g.dart';

@Riverpod(keepAlive: true)
CallerIdMonitorService callerIdMonitorService(Ref ref) {
  final callerIdService = ref.watch(callerIdentityServiceProvider);
  final filterService = ref.watch(enhancedCompositeFilterServiceProvider);
  final timeInterceptor = ref.watch(timeInterceptorServiceProvider);
  return CallerIdMonitorService(
    callerIdService: callerIdService,
    filterService: filterService,
    timeInterceptorService: timeInterceptor,
  );
}

/// 来电显示监控服务 (CallerIdMonitorService)
/// 负责监控和处理来电显示相关的事件流
class CallerIdMonitorService {
  final CallerIdentityService _callerIdService;
  final EnhancedCompositeFilterService _filterService;
  final TimeInterceptorService _timeInterceptorService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();

  bool _isListening = false;

  CallerIdMonitorService({
    required CallerIdentityService callerIdService,
    required EnhancedCompositeFilterService filterService,
    required TimeInterceptorService timeInterceptorService,
  })  : _callerIdService = callerIdService,
        _filterService = filterService,
        _timeInterceptorService = timeInterceptorService;

  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  void startListening() {
    _isListening = true;
    debugPrint('[CallerIdMonitorService] 启动来电监控服务成功');
  }

  void stopListening() {
    _isListening = false;
    debugPrint('[CallerIdMonitorService] 停止来电监控服务');
  }

  Future<void> processIncomingCall(String phoneNumber) async {
    if (!_isListening) return;
    try {
      final callerIdData = await _callerIdService.getCallerIdWithParsed(
        phoneNumber,
        phoneNumber,
        phoneNumber,
        dlib.Locale(country: 'CN', language: 'zh'),
      );
      _callerIdSubject.add(callerIdData);
    } catch (e) {
      debugPrint('[CallerIdMonitorService] 处理来电显示失败: $e');
    }
  }

  void dispose() {
    stopListening();
    _callerIdSubject.close();
  }
}
