import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver for evaluating SMS messages against user and system regular expressions & keywords
class RegexRulesDriver implements SmsFilterAdapter {
  @override
  String get providerId => 'pyro_sms_driver_regex_rules';

  @override
  String get displayName => 'Regex & Keyword Rules';

  @override
  bool isEnabled;

  final List<String> _keywordRules = [
    'casino', 'lottery', 'winner', 'urgent bank', 'verification code',
    '博彩', '中奖', '特大喜讯', '退税', '汇款到',
  ];

  RegexRulesDriver({this.isEnabled = true});

  @override
  Future<SmsScreeningResult?> screenMessage(SmsMessageEntity message) async {
    if (!isEnabled) return null;

    final lowerBody = message.body.toLowerCase();
    for (final keyword in _keywordRules) {
      if (lowerBody.contains(keyword.toLowerCase())) {
        return SmsScreeningResult(
          recommendedAction: SmsFilterAction.cancelNotification,
          riskLevel: SmsRiskLevel.high,
          category: SmsCategory.scam,
          spamScore: 0.85,
          mechanismsTriggered: [SmsDetectionMechanism.regexRules],
          reasoning: 'Matched high-risk spam keyword: "$keyword"',
        );
      }
    }

    return null;
  }
}
