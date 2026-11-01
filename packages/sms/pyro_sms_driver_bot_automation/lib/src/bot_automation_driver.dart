import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';

/// Representation of an automation rule (Trigger -> Action)
class AutomationRule {
  final String id;
  final String name;
  final SmsRiskLevel minRiskLevel;
  final String? webhookUrl;
  final String? forwardPhoneNumber;
  final bool enableAlertNotification;

  const AutomationRule({
    required this.id,
    required this.name,
    this.minRiskLevel = SmsRiskLevel.high,
    this.webhookUrl,
    this.forwardPhoneNumber,
    this.enableAlertNotification = true,
  });
}

/// Driver executing Trigger-Action automation workflows for detected spam/phishing SMS
class BotAutomationDriver {
  final List<AutomationRule> _rules = [];
  final HttpClient _httpClient;

  BotAutomationDriver({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  void addRule(AutomationRule rule) {
    _rules.add(rule);
  }

  /// Evaluates screening result and executes matching automation actions
  Future<void> executeAutomation(
    SmsMessageEntity message,
    SmsScreeningResult result,
  ) async {
    for (final rule in _rules) {
      if (result.riskLevel.index >= rule.minRiskLevel.index) {
        debugPrint('[BotAutomation] Triggered rule: ${rule.name}');

        if (rule.webhookUrl != null && rule.webhookUrl!.isNotEmpty) {
          await _sendWebhookPost(rule.webhookUrl!, message, result);
        }
      }
    }
  }

  Future<void> _sendWebhookPost(
    String url,
    SmsMessageEntity message,
    SmsScreeningResult result,
  ) async {
    try {
      final uri = Uri.parse(url);
      final request = await _httpClient.postUrl(uri);
      request.headers.contentType = ContentType.json;

      final payload = {
        'event': 'SMS_THREAT_DETECTED',
        'message': message.toJson(),
        'screeningResult': {
          'riskLevel': result.riskLevel.name,
          'action': result.recommendedAction.name,
          'spamScore': result.spamScore,
          'reasoning': result.reasoning,
        },
        'timestamp': DateTime.now().toIso8601String(),
      };

      request.write(jsonEncode(payload));
      final response = await request.close();
      debugPrint('[BotAutomation] Webhook response status: ${response.statusCode}');
    } catch (e) {
      debugPrint('[BotAutomation] Webhook trigger error: $e');
    }
  }
}
