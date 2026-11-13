/// Channel and method names for CallControl platform communication.
abstract class CallControlChannels {
  static const String channelName = 'net.pyro.telephony/call_control';

  static const String methodExecuteAction = 'executeAction';
  static const String methodSetMicMuted = 'setMicrophoneMuted';
  static const String methodIsMicMuted = 'isMicrophoneMuted';
}
