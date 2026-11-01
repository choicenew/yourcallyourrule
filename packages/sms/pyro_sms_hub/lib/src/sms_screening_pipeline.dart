import 'package:flutter/foundation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'sms_hub.dart';

/// Orchestrates multi-stage SMS screening pipeline across registered drivers
class SmsScreeningPipeline {
  final SmsHub hub;

  SmsScreeningPipeline(this.hub);

  /// Run an incoming message through all registered detection drivers
  Future<SmsScreeningResult> evaluate(SmsMessageEntity message) async {
    final triggeredMechanisms = <SmsDetectionMechanism>[];
    final urls = <PhishingUrlItem>[];
    double mlScore = 0.0;
    bool isBursting = false;

    // Stage 1: Burst Protection check
    if (hub.burstProtection != null) {
      try {
        await hub.burstProtection!.recordMessage(message);
        isBursting = await hub.burstProtection!.isBursting(message);
        if (isBursting) {
          triggeredMechanisms.add(SmsDetectionMechanism.burstProtection);
        }
      } catch (e) {
        debugPrint('[SmsPipeline] Burst protection error: $e');
      }
    }

    // Stage 2: Specialized Link Threat Drivers (Google Safe Browsing, PhishTank, OpenPhish, VirusTotal, LinkResolver)
    final extractedUrls = _extractRawUrls(message.body);
    for (final rawUrl in extractedUrls) {
      for (final threatAdapter in hub.activeLinkThreatAdapters) {
        try {
          final item = await threatAdapter.checkUrl(rawUrl);
          if (item != null && item.riskLevel != SmsRiskLevel.safe) {
            urls.add(item);
            if (item.inPhishTankDatabase) {
              triggeredMechanisms.add(SmsDetectionMechanism.phishTank);
            } else if (item.inOpenPhishFeed) {
              triggeredMechanisms.add(SmsDetectionMechanism.openPhish);
            } else if (item.riskLevel == SmsRiskLevel.critical || item.riskLevel == SmsRiskLevel.high) {
              triggeredMechanisms.add(SmsDetectionMechanism.googleSafeBrowsing);
            }
          }
        } catch (e) {
          debugPrint('[SmsPipeline] Link threat adapter ${threatAdapter.providerId} error: $e');
        }
      }
    }

    // Legacy Content Analyzer fallback if registered
    if (hub.contentAnalyzer != null) {
      try {
        final legacyUrls = await hub.contentAnalyzer!.analyzeUrls(message.body);
        urls.addAll(legacyUrls);
      } catch (e) {
        debugPrint('[SmsPipeline] Content analyzer error: $e');
      }
    }

    // Stage 3: ML Scorer (GBT 20-features + Naive Bayes)
    if (hub.mlScorer != null) {
      try {
        mlScore = await hub.mlScorer!.calculateSpamScore(message);
        if (mlScore >= 0.75) {
          triggeredMechanisms.add(SmsDetectionMechanism.mlClassifier);
        }
      } catch (e) {
        debugPrint('[SmsPipeline] ML scorer error: $e');
      }
    }

    // Stage 4: Custom Filter Adapters (Regex Rules, Blacklists)
    SmsScreeningResult? adapterResult;
    for (final filter in hub.activeFilters) {
      try {
        adapterResult = await filter.screenMessage(message);
        if (adapterResult != null && adapterResult.recommendedAction != SmsFilterAction.allow) {
          triggeredMechanisms.addAll(adapterResult.mechanismsTriggered);
          break;
        }
      } catch (e) {
        debugPrint('[SmsPipeline] Filter ${filter.providerId} error: $e');
      }
    }

    // Determine final risk level & action
    if (triggeredMechanisms.contains(SmsDetectionMechanism.phishTank) ||
        triggeredMechanisms.contains(SmsDetectionMechanism.openPhish) ||
        triggeredMechanisms.contains(SmsDetectionMechanism.googleSafeBrowsing) ||
        triggeredMechanisms.contains(SmsDetectionMechanism.virusTotal) ||
        mlScore >= 0.9) {
      return SmsScreeningResult(
        recommendedAction: SmsFilterAction.cancelNotification,
        riskLevel: SmsRiskLevel.critical,
        category: SmsCategory.phishing,
        spamScore: mlScore > 0.9 ? mlScore : 0.95,
        mechanismsTriggered: triggeredMechanisms,
        detectedUrls: urls,
        reasoning: 'Critical phishing link or threat database match detected.',
      );
    }

    if (isBursting || mlScore >= 0.75 || urls.any((u) => u.riskLevel == SmsRiskLevel.high)) {
      return SmsScreeningResult(
        recommendedAction: SmsFilterAction.cancelNotification,
        riskLevel: SmsRiskLevel.high,
        category: SmsCategory.scam,
        spamScore: mlScore > 0.75 ? mlScore : 0.8,
        mechanismsTriggered: triggeredMechanisms,
        detectedUrls: urls,
        reasoning: 'Suspicious burst behavior, high spam score, or high-risk URL detected.',
      );
    }

    if (adapterResult != null) {
      return adapterResult;
    }

    return SmsScreeningResult.safe;
  }

  List<String> _extractRawUrls(String text) {
    final urlRegex = RegExp(
      r'https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&=]*)',
      caseSensitive: false,
    );
    return urlRegex.allMatches(text).map((m) => m.group(0)!).toList();
  }
}
