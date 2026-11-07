import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/core/dispatch/provider_state.dart';
import 'package:pyro_api_translate/src/core/dispatch/scheduler.dart';
import 'package:pyro_api_translate/src/providers/translation_provider.dart';

class MockProvider implements TranslationProvider {
  @override
  final String name;
  @override
  final bool supportsAuto = true;
  final bool shouldFail;
  int callCount = 0;

  MockProvider(this.name, {this.shouldFail = false});

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    callCount++;
    if (shouldFail) {
      throw Exception('Mock Provider $name Network Failure');
    }
    await Future.delayed(const Duration(milliseconds: 50));
    return '$text [translated by $name]';
  }
}

void main() {
  group('ProviderState Circuit Breaker Tests', () {
    test('Trips to OPEN after 3 consecutive failures', () {
      final provider = MockProvider('TestMock', shouldFail: true);
      final state = ProviderState(
        name: 'TestMock',
        provider: provider,
        baseCooldown: const Duration(seconds: 1),
      );

      expect(state.circuitState, CircuitState.closed);
      expect(state.isReady, isTrue);

      // 1st Failure
      state.markBusy();
      state.markFinished(success: false);
      expect(state.circuitState, CircuitState.closed);

      // 2nd Failure
      state.markBusy();
      state.markFinished(success: false);
      expect(state.circuitState, CircuitState.closed);

      // 3rd Failure -> Trips Circuit Breaker!
      state.markBusy();
      state.markFinished(success: false);
      expect(state.circuitState, CircuitState.open);
      expect(state.isReady, isFalse);
    });

    test('Resets to CLOSED after success in HALF_OPEN state', () {
      final provider = MockProvider('TestMock', shouldFail: false);
      final state = ProviderState(
        name: 'TestMock',
        provider: provider,
        baseCooldown: const Duration(milliseconds: 10),
      );

      // Force 3 failures
      state.markFinished(success: false);
      state.markFinished(success: false);
      state.markFinished(success: false);
      expect(state.circuitState, CircuitState.open);

      // Mark success
      state.markFinished(success: true);
      expect(state.circuitState, CircuitState.closed);
      expect(state.consecutiveFailures, 0);
    });
  });

  group('TranslationScheduler In-Flight Deduplication Tests', () {
    test('Concurrent requests for same text share 1 single call', () async {
      final provider = MockProvider('MockA');
      final scheduler = TranslationScheduler(
        {'MockA': provider},
        {'MockA': 'google'},
      );

      // Dispatch 5 identical concurrent requests
      final futures = List.generate(
        5,
        (_) => scheduler.schedule('Quantum Computing', targetLanguage: 'zh'),
      );

      final results = await Future.wait(futures);

      // All 5 futures should resolve to exact same string
      for (final r in results) {
        expect(r, 'Quantum Computing [translated by MockA]');
      }

      // Crucial: MockProvider should only have been called ONCE!
      expect(provider.callCount, 1);
    });
  });
}
