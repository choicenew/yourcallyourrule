import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_call_control_driver/pyro_call_control_driver.dart';
import 'package:pyro_call_control_driver/src/call_control_api.g.dart';

class FakeCallControlHostApi implements CallControlHostApi {
  CallControlActionRequest? lastRequest;
  bool? lastMuted;

  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';

  @override
  Future<CallControlActionResult> executeAction(CallControlActionRequest request) async {
    lastRequest = request;
    return CallControlActionResult(
      success: true,
      actionType: request.actionType,
      message: 'Fake success',
      executedAtMs: 1700000000000,
    );
  }

  @override
  Future<bool> setMicrophoneMuted(bool muted) async {
    lastMuted = muted;
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CallControlDriver Pigeon Tests', () {
    test('executeAction sends strongly-typed request and receives result', () async {
      final fakeApi = FakeCallControlHostApi();
      final driver = CallControlDriver(hostApi: fakeApi);

      final result = await driver.executeAction(
        const CallActionContext(
          callId: 'call_999',
          phoneNumber: '+15550001111',
          actionType: CallActionType.answerThenHangup,
          delayHangupMs: 2000,
          enableMicMuteProtection: true,
        ),
      );

      expect(result.success, isTrue);
      expect(fakeApi.lastRequest, isNotNull);
      expect(fakeApi.lastRequest!.phoneNumber, equals('+15550001111'));
      expect(fakeApi.lastRequest!.delayHangupMs, equals(2000));
    });

    test('setMicrophoneMuted passes boolean flag', () async {
      final fakeApi = FakeCallControlHostApi();
      final driver = CallControlDriver(hostApi: fakeApi);

      final success = await driver.setMicrophoneMuted(true);
      expect(success, isTrue);
      expect(fakeApi.lastMuted, isTrue);
    });
  });
}
