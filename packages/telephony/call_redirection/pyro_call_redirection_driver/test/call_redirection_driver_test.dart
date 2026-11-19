import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_call_redirection_driver/pyro_call_redirection_driver.dart';
import 'package:pyro_call_redirection_driver/src/call_redirection_api.g.dart';

class FakeCallRedirectionHostApi implements CallRedirectionHostApi {
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

  group('CallRedirectionDriver Pigeon Tests', () {
    late FakeCallRedirectionHostApi fakeHostApi;
    late CallRedirectionDriver driver;

    setUp(() {
      fakeHostApi = FakeCallRedirectionHostApi();
      driver = CallRedirectionDriver(hostApi: fakeHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('isServiceActive and isRoleGranted invoke HostApi safely', () async {
      expect(await driver.isServiceActive(), isTrue);
      expect(await driver.isRoleGranted(), isTrue);
    });

    test('evaluateCall receives strongly-typed PigeonRedirectionRequest', () async {
      final request = PigeonRedirectionRequest(
        id: 'call_456',
        rawPhoneNumber: '+15559876543',
        normalizedPhoneNumber: '15559876543',
        timestampMs: 1700000000000,
        isInteractiveAllowed: true,
        isCarModeActive: false,
      );

      final decision = await driver.evaluateCall(request);
      expect(decision.action, isNotEmpty);
    });
  });
}
