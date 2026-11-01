import 'package:flutter/foundation.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'sms_screening_pipeline.dart';

/// Central singleton service locator and screening engine for SMS protection
class SmsHub {
  SmsHub._internal();
  static final SmsHub instance = SmsHub._internal();

  final Map<String, SmsFilterAdapter> _filters = {};
  final Map<String, SmsLinkThreatAdapter> _linkThreatAdapters = {};
  SmsNotificationListenerAdapter? _notificationListener;
  SmsContentAnalyzerAdapter? _contentAnalyzer;
  SmsMlScorerAdapter? _mlScorer;
  SmsBurstProtectionAdapter? _burstProtection;

  late final SmsScreeningPipeline pipeline = SmsScreeningPipeline(this);

  // Registration methods
  void registerFilter(SmsFilterAdapter filter) {
    _filters[filter.providerId] = filter;
    debugPrint('[SmsHub] Registered filter adapter: ${filter.providerId}');
  }

  void registerLinkThreatAdapter(SmsLinkThreatAdapter adapter) {
    _linkThreatAdapters[adapter.providerId] = adapter;
    debugPrint('[SmsHub] Registered link threat adapter: ${adapter.providerId}');
  }

  void registerNotificationListener(SmsNotificationListenerAdapter adapter) {
    _notificationListener = adapter;
    debugPrint('[SmsHub] Registered NotificationListener adapter: ${adapter.providerId}');
  }

  void registerContentAnalyzer(SmsContentAnalyzerAdapter adapter) {
    _contentAnalyzer = adapter;
    debugPrint('[SmsHub] Registered ContentAnalyzer adapter: ${adapter.providerId}');
  }

  void registerMlScorer(SmsMlScorerAdapter adapter) {
    _mlScorer = adapter;
    debugPrint('[SmsHub] Registered ML Scorer adapter: ${adapter.providerId}');
  }

  void registerBurstProtection(SmsBurstProtectionAdapter adapter) {
    _burstProtection = adapter;
    debugPrint('[SmsHub] Registered Burst Protection adapter: ${adapter.providerId}');
  }

  // Getters
  List<SmsFilterAdapter> get activeFilters =>
      _filters.values.where((f) => f.isEnabled).toList();

  List<SmsLinkThreatAdapter> get activeLinkThreatAdapters =>
      _linkThreatAdapters.values.where((a) => a.isEnabled).toList();

  SmsNotificationListenerAdapter? get notificationListener => _notificationListener;
  SmsContentAnalyzerAdapter? get contentAnalyzer => _contentAnalyzer;
  SmsMlScorerAdapter? get mlScorer => _mlScorer;
  SmsBurstProtectionAdapter? get burstProtection => _burstProtection;

  /// Clear all registered adapters (for testing/reset)
  void clear() {
    _filters.clear();
    _linkThreatAdapters.clear();
    _notificationListener = null;
    _contentAnalyzer = null;
    _mlScorer = null;
    _burstProtection = null;
  }
}
