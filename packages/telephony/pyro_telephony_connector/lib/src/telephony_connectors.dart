import 'package:flutter/foundation.dart';
import 'package:pyro_call_control_connector/pyro_call_control_connector.dart';
import 'package:pyro_call_screening_connector/pyro_call_screening_connector.dart';

class TelephonyConnectors {
  static bool _mounted = false;

  static void ensureMounted({
    bool enableControlDriver = true,
    bool enableScreeningDriver = true,
  }) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[TelephonyConnectors] Mounting full Telephony package suite...');

    CallControlConnectors.ensureMounted(enableDriver: enableControlDriver);
    CallScreeningConnectors.ensureMounted(enableDriver: enableScreeningDriver);

    debugPrint('[TelephonyConnectors] Full Telephony suite assembly complete.');
  }
}
