import 'package:pyro_call_redirection_protocol/pyro_call_redirection_protocol.dart';
import 'call_redirection_pipeline.dart';

/// Central Service Locator singleton for the Call Redirection Package Suite.
class CallRedirectionHub {
  CallRedirectionHub._();
  static final CallRedirectionHub instance = CallRedirectionHub._();

  ICallRedirectionAdapter? _redirectionDriver;
  late final CallRedirectionPipeline pipeline = CallRedirectionPipeline(this);

  /// Get registered redirection driver adapter.
  ICallRedirectionAdapter? get redirectionDriver => _redirectionDriver;

  /// Register concrete redirection driver.
  void registerRedirectionDriver(ICallRedirectionAdapter driver) {
    _redirectionDriver = driver;
  }

  /// Unregister driver.
  void unregisterDriver() {
    _redirectionDriver = null;
  }
}
