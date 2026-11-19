import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';

class MockFilterAdapter implements SmsFilterAdapter {
  @override
  String get providerId => 'mock_filter';
  @override
  String get displayName => 'Mock Filter';
  @override
  bool get isEnabled => true;

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    if (message.body.contains('SPAM_MOCK')) {
      return const SmsScreeningResult(
        recommendedAction: SmsFilterAction.cancelNotification,
        riskLevel: SmsRiskLevel.high,
        category: SmsCategory.scam,
        spamScore: 0.9,
        mechanismsTriggered: [SmsDetectionMechanism.regexRules],
        reasoning: 'Matched mock spam keyword',
      );
    }
    return null;
  }
}

void main() {
  late SmsHub hub;

  setUp(() {
    hub = SmsHub();
  });

  test('SmsHub registers and evaluates filter adapters', () async {
    final mock = MockFilterAdapter();
    hub.registerFilter(mock);

    expect(hub.activeFilters.length, 1);

    final safeMessage = SmsMessageEntity(
      id: '1',
      sender: '123456',
      body: 'Hello world',
      timestamp: DateTime.now(),
    );
    final resultSafe = await hub.pipeline.evaluate(safeMessage);
    expect(resultSafe.recommendedAction, SmsFilterAction.allow);

    final spamMessage = SmsMessageEntity(
      id: '2',
      sender: '123456',
      body: 'Get money now SPAM_MOCK',
      timestamp: DateTime.now(),
    );
    final resultSpam = await hub.pipeline.evaluate(spamMessage);
    expect(resultSpam.recommendedAction, SmsFilterAction.cancelNotification);
  });
}
