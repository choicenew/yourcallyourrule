import '../enums/sms_enums.dart';
import 'sms_message_entity.dart';
import 'phishing_url_item.dart';

/// Captured SMS evidence sample log
class SmsEvidenceItem {
  final String evidenceId;
  final SmsMessageEntity message;
  final SmsFilterAction takenAction;
  final SmsRiskLevel riskLevel;
  final SmsCategory category;
  final double spamScore;
  final List<SmsDetectionMechanism> mechanismsTriggered;
  final List<PhishingUrlItem> detectedUrls;
  final DateTime capturedAt;
  final String? ruleId;

  const SmsEvidenceItem({
    required this.evidenceId,
    required this.message,
    required this.takenAction,
    required this.riskLevel,
    required this.category,
    required this.spamScore,
    required this.mechanismsTriggered,
    this.detectedUrls = const [],
    required this.capturedAt,
    this.ruleId,
  });

  Map<String, dynamic> toJson() => {
        'evidenceId': evidenceId,
        'message': message.toJson(),
        'takenAction': takenAction.name,
        'riskLevel': riskLevel.name,
        'category': category.name,
        'spamScore': spamScore,
        'mechanismsTriggered': mechanismsTriggered.map((m) => m.name).toList(),
        'detectedUrls': detectedUrls.map((u) => u.toJson()).toList(),
        'capturedAt': capturedAt.toIso8601String(),
        'ruleId': ruleId,
      };

  factory SmsEvidenceItem.fromJson(Map<String, dynamic> json) {
    return SmsEvidenceItem(
      evidenceId: json['evidenceId'] as String? ?? '',
      message: SmsMessageEntity.fromJson(json['message'] as Map<String, dynamic>? ?? {}),
      takenAction: SmsFilterAction.values.firstWhere(
        (e) => e.name == json['takenAction'],
        orElse: () => SmsFilterAction.cancelNotification,
      ),
      riskLevel: SmsRiskLevel.values.firstWhere(
        (e) => e.name == json['riskLevel'],
        orElse: () => SmsRiskLevel.medium,
      ),
      category: SmsCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => SmsCategory.unknown,
      ),
      spamScore: (json['spamScore'] as num? ?? 0.0).toDouble(),
      mechanismsTriggered: (json['mechanismsTriggered'] as List<dynamic>? ?? [])
          .map((m) => SmsDetectionMechanism.values.firstWhere(
                (e) => e.name == m,
                orElse: () => SmsDetectionMechanism.regexRules,
              ))
          .toList(),
      detectedUrls: (json['detectedUrls'] as List<dynamic>? ?? [])
          .map((u) => PhishingUrlItem.fromJson(u as Map<String, dynamic>))
          .toList(),
      capturedAt: DateTime.tryParse(json['capturedAt'] as String? ?? '') ?? DateTime.now(),
      ruleId: json['ruleId'] as String?,
    );
  }
}
