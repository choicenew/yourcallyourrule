import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Driver integrating VirusTotal v3 REST API multi-engine URL threat scanner
class VirusTotalDriver implements SmsLinkThreatAdapter {
  @override
  String get providerId => 'pyro_sms_driver_virustotal';

  @override
  String get displayName => 'VirusTotal Multi-Engine Scanner';

  @override
  bool isEnabled;

  final String? apiKey;
  final http.Client _client;

  VirusTotalDriver({
    this.apiKey,
    this.isEnabled = true,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<PhishingUrlItem?> checkUrl(String url) async {
    if (!isEnabled || url.isEmpty) return null;

    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final domain = uri.host.toLowerCase();
    final parts = domain.split('.');
    final tld = parts.isNotEmpty ? parts.last : '';

    final effectiveKey = apiKey;
    if (effectiveKey == null || effectiveKey.isEmpty) {
      return PhishingUrlItem(
        rawUrl: url,
        domain: domain,
        tld: tld,
        riskLevel: SmsRiskLevel.safe,
      );
    }

    try {
      // VirusTotal v3 URL ID = base64Url encoded raw URL without '=' padding
      final urlId = base64Url.encode(utf8.encode(url)).replaceAll('=', '');
      final requestUri = Uri.parse('https://www.virustotal.com/api/v3/urls/$urlId');

      final response = await _client.get(
        requestUri,
        headers: {'x-apikey': effectiveKey},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final attributes = (data['data'] as Map<String, dynamic>?)?['attributes'] as Map<String, dynamic>?;
        final stats = attributes?['last_analysis_stats'] as Map<String, dynamic>?;

        if (stats != null) {
          final maliciousCount = (stats['malicious'] as num?)?.toInt() ?? 0;
          final suspiciousCount = (stats['suspicious'] as num?)?.toInt() ?? 0;

          if (maliciousCount > 0 || suspiciousCount > 0) {
            return PhishingUrlItem(
              rawUrl: url,
              domain: domain,
              tld: tld,
              riskLevel: SmsRiskLevel.critical,
              matchedReason: 'VirusTotal REST API v3 multi-engine detected $maliciousCount malicious, $suspiciousCount suspicious engines.',
            );
          }
        }
      }
    } catch (_) {
      // Graceful timeout/network failure handling
    }

    return PhishingUrlItem(
      rawUrl: url,
      domain: domain,
      tld: tld,
      riskLevel: SmsRiskLevel.safe,
    );
  }
}
