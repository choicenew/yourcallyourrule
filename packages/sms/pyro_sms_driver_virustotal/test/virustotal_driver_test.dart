import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_driver_virustotal/pyro_sms_driver_virustotal.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

void main() {
  test('VirusTotalDriver flags malicious URLs', () async {
    final driver = VirusTotalDriver();

    final safeItem = await driver.checkUrl('http://wikipedia.org');
    expect(safeItem?.riskLevel, SmsRiskLevel.safe);

    final flaggedItem = await driver.checkUrl('http://virustotal-flagged-malware.top');
    expect(flaggedItem?.riskLevel, SmsRiskLevel.critical);
  });
}
