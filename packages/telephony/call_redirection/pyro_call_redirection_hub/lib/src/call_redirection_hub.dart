import 'package:flutter/foundation.dart';
import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'call_redirection_pipeline.dart';

/// Central IoC Service Locator for Call Redirection Package Suite
class CallRedirectionHub {
  CallRedirectionHub._internal();
  static final CallRedirectionHub instance = CallRedirectionHub._internal();

  ICallRedirectionAdapter? _activeDriver;
  late final CallRedirectionPipeline pipeline = CallRedirectionPipeline(this);

  void registerRedirectionDriver(ICallRedirectionAdapter driver) {
    _activeDriver = driver;
    debugPrint('[CallRedirectionHub] Registered redirection driver: ${driver.providerId}');
  }

  ICallRedirectionAdapter? get activeDriver => _activeDriver;

  void clear() {
    _activeDriver = null;
  }
}
