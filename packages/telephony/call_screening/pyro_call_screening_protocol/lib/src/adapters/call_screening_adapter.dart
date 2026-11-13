import 'package:pyro_call_control_protocol/pyro_call_control_protocol.dart';
import '../models/incoming_call_entity.dart';

/// Abstract adapter contract for CallScreening gatekeeper driver.
abstract interface class ICallScreeningAdapter {
  String get providerId;

  /// Evaluate incoming call gatekeeper request.
  Future<CallActionType> onScreeningRequested(IncomingCallEntity call);
}
