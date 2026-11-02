import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SmsConnectors.ensureMounted self-registers all default drivers', () {
    SmsConnectors.ensureMounted();

    expect(SmsHub.instance.activeLinkThreatAdapters.length, greaterThanOrEqualTo(1));
    expect(SmsHub.instance.activeFilters.length, greaterThanOrEqualTo(2));
    expect(SmsHub.instance.notificationListener, isNotNull);
  });
}
