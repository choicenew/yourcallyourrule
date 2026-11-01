import '../models/phishing_url_item.dart';

/// Abstract adapter for URL extraction, shortener resolution, TLD safety, ReDoS safety guard, and phishing link check
abstract class SmsContentAnalyzerAdapter {
  String get providerId;
  
  /// Extracts and analyzes all URLs in the SMS body
  Future<List<PhishingUrlItem>> analyzeUrls(String text);

  /// Validates regex safety against catastrophic ReDoS backtracking
  bool isRegexSafe(String pattern, {int maxBacktrackingPaths = 1000000});

  /// Check if a TLD is classified as high risk
  bool isHighRiskTld(String tld);
}
