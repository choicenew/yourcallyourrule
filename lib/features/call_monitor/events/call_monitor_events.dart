abstract class CallMonitorEvent {
  const CallMonitorEvent();
}

class IncomingCallEvent extends CallMonitorEvent {
  final String phoneNumber;
  final String rawHandle;
  final int timestampMs;

  const IncomingCallEvent({
    required this.phoneNumber,
    required this.rawHandle,
    required this.timestampMs,
  });
}

class SimInfoEvent extends CallMonitorEvent {
  final String phoneNumber;
  final int simSlot;
  final String? carrierName;
  final String? countryIso;

  const SimInfoEvent({
    required this.phoneNumber,
    required this.simSlot,
    this.carrierName,
    this.countryIso,
  });
}

class StirInfoEvent extends CallMonitorEvent {
  final String phoneNumber;
  final String status;
  final bool isVerified;

  const StirInfoEvent({
    required this.phoneNumber,
    required this.status,
    required this.isVerified,
  });
}

class CallEndedEvent extends CallMonitorEvent {
  final String phoneNumber;
  final int timestampMs;

  const CallEndedEvent({
    required this.phoneNumber,
    required this.timestampMs,
  });
}
