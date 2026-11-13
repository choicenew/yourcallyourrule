import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/call_log_extension.dart';

part 'outgoing_call_handler.g.dart';

@Riverpod(keepAlive: true)
OutgoingCallHandler outgoingCallHandler(Ref ref) {
  final identityService = ref.watch(callerIdentityServiceProvider);
  return OutgoingCallHandler(
    identityService: identityService,
  );
}

class OutgoingCallHandler {
  final CallerIdentityService _identityService;

  OutgoingCallHandler({
    required CallerIdentityService identityService,
  }) : _identityService = identityService;

  Future<void> processOutgoingCall(String phoneNumber, Function(CallerIdData) onCallerIdDataReceived) async {
    CallerIdData callerIdData = await _identityService.getCallerId(
      phoneNumber,
      Locale.english,
    );
    onCallerIdDataReceived(callerIdData);
    recordOutgoingCallWithOptionalRecorder(phoneNumber, callerIdData);
  }
}
