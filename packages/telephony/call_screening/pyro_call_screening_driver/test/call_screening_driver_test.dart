import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_call_screening_driver/pyro_call_screening_driver.dart';
import 'package:pyro_call_screening_driver/src/call_screening_api.g.dart';

class FakeCallScreeningHostApi implements CallScreeningHostApi {
  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';

  @override
  Future<bool> isServiceActive() async => true;

  @override
  Future<bool> isRoleGranted() async => true;

  @override
  Future<bool> requestRole() async => true;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CallScreeningDriver Pigeon Tests', () {
    late FakeCallScreeningHostApi fakeHostApi;
    late CallScreeningDriver driver;

    setUp(() {
      fakeHostApi = FakeCallScreeningHostApi();
      driver = CallScreeningDriver(hostApi: fakeHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('isServiceActive and isRoleGranted invoke HostApi safely', () async {
      expect(await driver.isServiceActive(), isTrue);
      expect(await driver.isRoleGranted(), isTrue);
    });

    test('evaluateCall receives strongly-typed CallScreeningRequest', () async {
      final request = CallScreeningRequest(
        callId: 'call_123',
        phoneNumber: '+15551234567',
        normalizedNumber: '15551234567',
        timestampMs: 1700000000000,
      );

      final decision = await driver.evaluateCall(request);
      expect(decision.action, isNotEmpty);
      expect(decision.reason, isNotNull);
    });
  });
}

