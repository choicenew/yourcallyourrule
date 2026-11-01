import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'phishing_tld_database.dart';
import 'redos_backtracking_tree.dart';

/// Driver for analyzing SMS text content, links, TLD risks, and ReDoS safety
class SmsContentAnalyzerDriver implements SmsContentAnalyzerAdapter {
  @override
  String get providerId => 'pyro_sms_content_analyzer';

  final Set<String> _openPhishDomains = {'malicious-bank-verify.xyz', 'update-account-security.icu'};
  final Set<String> _phishTankUrls = {'http://phishing-login.top/account'};

  @override
  Future<List<PhishingUrlItem>> analyzeUrls(String text) async {
    final urlRegex = RegExp(
      r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&=]*)',
      caseSensitive: false,
    );

    final matches = urlRegex.allMatches(text);
    final results = <PhishingUrlItem>[];

    for (final match in matches) {
      final rawUrl = match.group(0)!;
      final uri = Uri.tryParse(rawUrl);
      if (uri == null) continue;

      final domain = uri.host.toLowerCase();
      final parts = domain.split('.');
      final tld = parts.isNotEmpty ? parts.last : '';

      final isShortener = PhishingTldDatabase.urlShorteners.contains(domain);
      final isHighRiskTld = PhishingTldDatabase.highRiskTlds.contains(tld);
      final inOpenPhish = _openPhishDomains.contains(domain);
      final inPhishTank = _phishTankUrls.contains(rawUrl);

      SmsRiskLevel risk = SmsRiskLevel.safe;
      String? reason;

      if (inPhishTank || inOpenPhish) {
        risk = SmsRiskLevel.critical;
        reason = 'Matched active PhishTank/OpenPhish phishing database.';
      } else if (isHighRiskTld) {
        risk = SmsRiskLevel.high;
        reason = 'Domain uses high-risk Top Level Domain (.$tld).';
      } else if (isShortener) {
        risk = SmsRiskLevel.medium;
        reason = 'URL shortener domain hiding true target location.';
      }

      results.add(PhishingUrlItem(
        rawUrl: rawUrl,
        domain: domain,
        tld: tld,
        isShortener: isShortener,
        isHighRiskTld: isHighRiskTld,
        inOpenPhishFeed: inOpenPhish,
        inPhishTankDatabase: inPhishTank,
        riskLevel: risk,
        matchedReason: reason,
      ));
    }

    return results;
  }

  @override
  bool isRegexSafe(String pattern, {int maxBacktrackingPaths = 1000000}) {
    return ReDosBacktrackingTree.validateSafety(pattern, maxPaths: maxBacktrackingPaths);
  }

  @override
  bool isHighRiskTld(String tld) {
    return PhishingTldDatabase.highRiskTlds.contains(tld.toLowerCase());
  }
}
