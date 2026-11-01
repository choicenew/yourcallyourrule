import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  group('SmsMessageEntity Tests', () {
    test('JSON serialization and deserialization', () {
      final now = DateTime.now();
      final entity = SmsMessageEntity(
        id: 'msg_101',
        sender: '+18005550199',
        body: 'Test SMS body',
        timestamp: now,
        packageName: 'com.google.android.apps.messaging',
      );

      final json = entity.toJson();
      expect(json['id'], 'msg_101');
      expect(json['sender'], '+18005550199');

      final deserialized = SmsMessageEntity.fromJson(json);
      expect(deserialized.id, entity.id);
      expect(deserialized.sender, entity.sender);
    });
  });

  group('PhishingUrlItem Tests', () {
    test('PhishingUrlItem risk level parsing', () {
      const item = PhishingUrlItem(
        rawUrl: 'http://malicious.xyz',
        domain: 'malicious.xyz',
        tld: 'xyz',
        riskLevel: SmsRiskLevel.high,
      );

      final json = item.toJson();
      expect(json['riskLevel'], 'high');

      final deserialized = PhishingUrlItem.fromJson(json);
      expect(deserialized.riskLevel, SmsRiskLevel.high);
    });
  });
}
