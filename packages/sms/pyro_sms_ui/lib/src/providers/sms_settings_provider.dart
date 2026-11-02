import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmsSettingsState {
  final bool notificationListenerEnabled;
  final bool googleSafeBrowsingEnabled;
  final bool openPhishEnabled;
  final bool virusTotalEnabled;
  final bool otpGuardEnabled;
  final bool bloomFilterEnabled;
  final bool botAutomationEnabled;
  final bool telephonyFallbackEnabled;
  final bool mlScorerEnabled;
  final bool burstProtectionEnabled;

  const SmsSettingsState({
    this.notificationListenerEnabled = true,
    this.googleSafeBrowsingEnabled = true,
    this.openPhishEnabled = true,
    this.virusTotalEnabled = true,
    this.otpGuardEnabled = true,
    this.bloomFilterEnabled = true,
    this.botAutomationEnabled = true,
    this.telephonyFallbackEnabled = false,
    this.mlScorerEnabled = true,
    this.burstProtectionEnabled = true,
  });

  SmsSettingsState copyWith({
    bool? notificationListenerEnabled,
    bool? googleSafeBrowsingEnabled,
    bool? openPhishEnabled,
    bool? virusTotalEnabled,
    bool? otpGuardEnabled,
    bool? bloomFilterEnabled,
    bool? botAutomationEnabled,
    bool? telephonyFallbackEnabled,
    bool? mlScorerEnabled,
    bool? burstProtectionEnabled,
  }) {
    return SmsSettingsState(
      notificationListenerEnabled: notificationListenerEnabled ?? this.notificationListenerEnabled,
      googleSafeBrowsingEnabled: googleSafeBrowsingEnabled ?? this.googleSafeBrowsingEnabled,
      openPhishEnabled: openPhishEnabled ?? this.openPhishEnabled,
      virusTotalEnabled: virusTotalEnabled ?? this.virusTotalEnabled,
      otpGuardEnabled: otpGuardEnabled ?? this.otpGuardEnabled,
      bloomFilterEnabled: bloomFilterEnabled ?? this.bloomFilterEnabled,
      botAutomationEnabled: botAutomationEnabled ?? this.botAutomationEnabled,
      telephonyFallbackEnabled: telephonyFallbackEnabled ?? this.telephonyFallbackEnabled,
      mlScorerEnabled: mlScorerEnabled ?? this.mlScorerEnabled,
      burstProtectionEnabled: burstProtectionEnabled ?? this.burstProtectionEnabled,
    );
  }
}

class SmsSettingsNotifier extends Notifier<SmsSettingsState> {
  @override
  SmsSettingsState build() => const SmsSettingsState();

  void toggleNotificationListener(bool enabled) {
    state = state.copyWith(notificationListenerEnabled: enabled);
  }

  void toggleGoogleSafeBrowsing(bool enabled) {
    state = state.copyWith(googleSafeBrowsingEnabled: enabled);
  }

  void toggleOpenPhish(bool enabled) {
    state = state.copyWith(openPhishEnabled: enabled);
  }

  void toggleVirusTotal(bool enabled) {
    state = state.copyWith(virusTotalEnabled: enabled);
  }

  void toggleOtpGuard(bool enabled) {
    state = state.copyWith(otpGuardEnabled: enabled);
  }

  void toggleBloomFilter(bool enabled) {
    state = state.copyWith(bloomFilterEnabled: enabled);
  }

  void toggleBotAutomation(bool enabled) {
    state = state.copyWith(botAutomationEnabled: enabled);
  }

  void toggleTelephonyFallback(bool enabled) {
    state = state.copyWith(telephonyFallbackEnabled: enabled);
  }

  void toggleMlScorer(bool enabled) {
    state = state.copyWith(mlScorerEnabled: enabled);
  }

  void toggleBurstProtection(bool enabled) {
    state = state.copyWith(burstProtectionEnabled: enabled);
  }
}

final smsSettingsProvider = NotifierProvider<SmsSettingsNotifier, SmsSettingsState>(
  SmsSettingsNotifier.new,
);
