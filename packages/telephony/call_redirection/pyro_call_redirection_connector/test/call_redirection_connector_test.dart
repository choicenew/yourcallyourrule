import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_call_redirection_connector/pyro_call_redirection_connector.dart';
import 'package:pyro_call_redirection_hub/pyro_call_redirection_hub.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CallRedirectionConnectors.ensureMounted self-registers drivers', () {
    CallRedirectionConnectors.ensureMounted();
    expect(CallRedirectionHub.instance.activeDriver, isNotNull);
  });
}
