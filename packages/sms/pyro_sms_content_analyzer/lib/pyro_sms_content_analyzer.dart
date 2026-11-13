library pyro_sms_content_analyzer;

export 'package:pyro_sms_driver_link_resolver/pyro_sms_driver_link_resolver.dart';

import 'package:pyro_sms_driver_link_resolver/pyro_sms_driver_link_resolver.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

class SmsContentAnalyzerDriver extends LinkResolverDriver implements SmsContentAnalyzerAdapter {
  SmsContentAnalyzerDriver({super.isEnabled});

  @override
  String get providerId => 'pyro_sms_content_analyzer';

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
      final item = await checkUrl(rawUrl);
      if (item != null) results.add(item);
    }
    return results;
  }

  @override
  bool isHighRiskTld(String tld) {
    return PhishingTldDatabase.highRiskTlds.contains(tld.toLowerCase());
  }

  @override
  bool isRegexSafe(String pattern, {int maxBacktrackingPaths = 1000000}) {
    return super.isRegexSafe(pattern, maxBacktrackingPaths: maxBacktrackingPaths);
  }
}
