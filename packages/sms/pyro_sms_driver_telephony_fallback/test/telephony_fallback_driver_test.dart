import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';
import 'package:pyro_sms_driver_telephony_fallback/src/telephony_fallback_api.g.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

class MockTelephonyFallbackHostApi implements TelephonyFallbackHostApi {
  bool granted = true;

  @override
  // ignore: non_constant_identifier_names
  final String pigeonVar_messageChannelSuffix = '';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<bool> isSmsPermissionGranted() async => granted;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TelephonyFallbackDriver tests', () {
    late MockTelephonyFallbackHostApi mockHostApi;
    late TelephonyFallbackDriver driver;

    setUp(() {
      mockHostApi = MockTelephonyFallbackHostApi();
      driver = TelephonyFallbackDriver(hostApi: mockHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('isSmsPermissionGranted forwards to HostApi', () async {
      mockHostApi.granted = true;
      expect(await driver.isSmsPermissionGranted(), isTrue);

      mockHostApi.granted = false;
      expect(await driver.isSmsPermissionGranted(), isFalse);
    });

    test('screenMessage returns null (pure listener driver)', () async {
      final message = SmsMessageEntity(
        id: 'msg_1',
        sender: '10086',
        body: 'Hello World',
        timestamp: DateTime.fromMillisecondsSinceEpoch(1700000000000),
      );
      final result = await driver.screenMessage(message);
      expect(result, isNull);
    });

    test('onSmsReceived handler registration and disposal', () {
      SmsMessageEntity? received;
      driver.onSmsReceived((msg) => received = msg);
      expect(received, isNull);

      driver.dispose();
      expect(received, isNull);
    });
  });
}
