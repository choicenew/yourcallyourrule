import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_api_translate/src/core/dispatch/scheduler.dart';
import 'package:pyro_api_translate/src/providers/translation_provider.dart';

// Mock Provider for testing
class MockProvider extends TranslationProvider {
  final bool _supportsAuto;
  final String _name;

  MockProvider(this._name, this._supportsAuto);

  @override
  bool get supportsAuto => _supportsAuto;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    if (sourceLanguage == 'auto' && !_supportsAuto) {
      throw Exception(
          '$_name DOES NOT SUPPORT AUTO! Test Failed if this is called.');
    }
    return 'Translated by $_name';
  }
}

void main() {
  test('Scheduler filters out providers that do not support auto', () async {
    final providers = {
      'no_auto_1': MockProvider('NoAuto1', false),
      'auto_ok_1': MockProvider('AutoOk1', true),
      'no_auto_2': MockProvider('NoAuto2', false),
    };

    final scheduler = TranslationScheduler(providers, {});

    // Schedule an 'auto' task
    // It should skip no_auto_1, pick auto_ok_1, and complete.
    final result = await scheduler.schedule('Hello',
        sourceLanguage: 'auto', targetLanguage: 'en');

    expect(result, equals('Translated by AutoOk1'));

    scheduler.dispose();
  });
}
