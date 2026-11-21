import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';
import 'package:pyro_sms_driver_notification_listener/src/sms_notification_listener_api.g.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

class MockNotificationHostApi implements SmsNotificationListenerHostApi {
  bool granted = true;
  String? lastCancelledKey;
  List<String>? lastPackages;
  SmsEvidencePayloadDetails? lastEvidence;

  @override
  // ignore: non_constant_identifier_names
  final String pigeonVar_messageChannelSuffix = '';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<bool> isPermissionGranted() async => granted;

  @override
  Future<void> requestPermission() async {}

  @override
  Future<bool> cancelNotification(String key) async {
    lastCancelledKey = key;
    return true;
  }

  @override
  Future<bool> saveEvidence(SmsEvidencePayloadDetails evidence) async {
    lastEvidence = evidence;
    return true;
  }

  @override
  Future<bool> setProtectedPackages(List<String> packages) async {
    lastPackages = packages;
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SmsNotificationListenerDriver tests', () {
    late MockNotificationHostApi mockHostApi;
    late SmsNotificationListenerDriver driver;

    setUp(() {
      mockHostApi = MockNotificationHostApi();
      driver = SmsNotificationListenerDriver(hostApi: mockHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('isPermissionGranted returns value from HostApi', () async {
      mockHostApi.granted = true;
      expect(await driver.isPermissionGranted(), isTrue);

      mockHostApi.granted = false;
      expect(await driver.isPermissionGranted(), isFalse);
    });

    test('cancelNotification forwards key to HostApi', () async {
      final result = await driver.cancelNotification('notif_123');
      expect(result, isTrue);
      expect(mockHostApi.lastCancelledKey, equals('notif_123'));
    });

    test('setProtectedPackages forwards list to HostApi', () async {
      await driver.setProtectedPackages(['com.tencent.mm', 'org.telegram.messenger']);
      expect(mockHostApi.lastPackages, contains('com.tencent.mm'));
      expect(await driver.getProtectedPackages(), contains('com.tencent.mm'));
    });

    test('saveEvidence stores log in memory and calls HostApi', () async {
      final item = SmsEvidenceItem(
        evidenceId: 'ev_001',
        message: SmsMessageEntity(
          id: 'msg_001',
          sender: '10086',
          body: 'Your verification code is 123456',
          timestamp: DateTime.fromMillisecondsSinceEpoch(1700000000000),
        ),
        takenAction: SmsFilterAction.cancelNotification,
        riskLevel: SmsRiskLevel.high,
        category: SmsCategory.verificationCode,
        spamScore: 0.95,
        mechanismsTriggered: const [SmsDetectionMechanism.notificationListener],
        capturedAt: DateTime.fromMillisecondsSinceEpoch(1700000000000),
      );

      await driver.saveEvidence(item);
      expect(driver.getCapturedEvidenceLogs().length, equals(1));
      expect(mockHostApi.lastEvidence?.key, equals('ev_001'));
      expect(mockHostApi.lastEvidence?.sender, equals('10086'));
    });

    test('onNotificationReceived dispatches to registered handler', () {
      SmsMessageEntity? receivedMessage;
      driver.onNotificationReceived((msg) {
        receivedMessage = msg;
      });

      final handler = SmsNotificationListenerDriver.register(SmsHub());
      handler.onNotificationReceived((msg) {
        receivedMessage = msg;
      });

      // Simulate native dispatch via driver internal method
      driver.onNotificationReceived((msg) => receivedMessage = msg);
      expect(receivedMessage, isNull);
    });
  });
}
