import '../enums/sms_enums.dart';
import 'phishing_url_item.dart';

/// Comprehensive result output from the SMS screening pipeline
class SmsScreeningResult {
  final SmsFilterAction recommendedAction;
  final SmsRiskLevel riskLevel;
  final SmsCategory category;
  final double spamScore;
  final List<SmsDetectionMechanism> mechanismsTriggered;
  final List<PhishingUrlItem> detectedUrls;
  final String? matchedRuleId;
  final String reasoning;

  const SmsScreeningResult({
    required this.recommendedAction,
    required this.riskLevel,
    required this.category,
    required this.spamScore,
    required this.mechanismsTriggered,
    this.detectedUrls = const [],
    this.matchedRuleId,
    required this.reasoning,
  });

  static const SmsScreeningResult safe = SmsScreeningResult(
    recommendedAction: SmsFilterAction.allow,
    riskLevel: SmsRiskLevel.safe,
    category: SmsCategory.personal,
    spamScore: 0.0,
    mechanismsTriggered: [],
    reasoning: 'No suspicious characteristics or patterns detected.',
  );
}
