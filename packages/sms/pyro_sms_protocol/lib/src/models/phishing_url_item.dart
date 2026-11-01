import '../enums/sms_enums.dart';

/// Item representing a detected URL with risk assessment
class PhishingUrlItem {
  final String rawUrl;
  final String? resolvedUrl;
  final String domain;
  final String tld;
  final bool isShortener;
  final bool isHighRiskTld;
  final bool inOpenPhishFeed;
  final bool inPhishTankDatabase;
  final SmsRiskLevel riskLevel;
  final String? matchedReason;

  const PhishingUrlItem({
    required this.rawUrl,
    this.resolvedUrl,
    required this.domain,
    required this.tld,
    this.isShortener = false,
    this.isHighRiskTld = false,
    this.inOpenPhishFeed = false,
    this.inPhishTankDatabase = false,
    this.riskLevel = SmsRiskLevel.safe,
    this.matchedReason,
  });

  Map<String, dynamic> toJson() => {
        'rawUrl': rawUrl,
        'resolvedUrl': resolvedUrl,
        'domain': domain,
        'tld': tld,
        'isShortener': isShortener,
        'isHighRiskTld': isHighRiskTld,
        'inOpenPhishFeed': inOpenPhishFeed,
        'inPhishTankDatabase': inPhishTankDatabase,
        'riskLevel': riskLevel.name,
        'matchedReason': matchedReason,
      };

  factory PhishingUrlItem.fromJson(Map<String, dynamic> json) {
    return PhishingUrlItem(
      rawUrl: json['rawUrl'] as String? ?? '',
      resolvedUrl: json['resolvedUrl'] as String?,
      domain: json['domain'] as String? ?? '',
      tld: json['tld'] as String? ?? '',
      isShortener: json['isShortener'] as bool? ?? false,
      isHighRiskTld: json['isHighRiskTld'] as bool? ?? false,
      inOpenPhishFeed: json['inOpenPhishFeed'] as bool? ?? false,
      inPhishTankDatabase: json['inPhishTankDatabase'] as bool? ?? false,
      riskLevel: SmsRiskLevel.values.firstWhere(
        (e) => e.name == json['riskLevel'],
        orElse: () => SmsRiskLevel.safe,
      ),
      matchedReason: json['matchedReason'] as String?,
    );
  }
}
