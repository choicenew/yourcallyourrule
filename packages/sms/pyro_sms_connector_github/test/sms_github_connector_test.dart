import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_connector_github/pyro_sms_connector_github.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SmsGithubConnectors.mountToHub self-registers full drivers including TelephonyFallback', () {
    final hub = SmsHub();
    SmsGithubConnectors.mountToHub(hub);

    expect(hub.activeLinkThreatAdapters.length, greaterThanOrEqualTo(1));
    expect(hub.activeFilters.length, greaterThanOrEqualTo(2));
    expect(hub.notificationListener, isNotNull);
  });
}
