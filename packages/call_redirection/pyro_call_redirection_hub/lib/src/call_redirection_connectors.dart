import 'call_redirection_hub.dart';

typedef RedirectionDriverRegistrar = void Function(CallRedirectionHub hub);

/// Helper for self-registering driver registrars with CallRedirectionHub.
class CallRedirectionConnectors {
  static void ensureMounted({
    required List<RedirectionDriverRegistrar> driverRegistrars,
  }) {
    final hub = CallRedirectionHub.instance;
    for (final registrar in driverRegistrars) {
      registrar(hub);
    }
  }
}
