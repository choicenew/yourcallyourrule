import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SmsConnectors.mountToHub self-registers all default drivers', () {
    final hub = SmsHub();
    SmsConnectors.mountToHub(hub);

    expect(hub.activeLinkThreatAdapters.length, greaterThanOrEqualTo(1));
    expect(hub.activeFilters.length, greaterThanOrEqualTo(2));
    expect(hub.notificationListener, isNotNull);
  });
}
