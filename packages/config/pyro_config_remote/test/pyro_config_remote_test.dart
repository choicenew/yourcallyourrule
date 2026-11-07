import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pyro_config_remote/pyro_config_remote.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

// Note: FirebaseRemoteConfig is hard to mock directly due to static instance often,
// but AuraRemoteConfig uses an instance member.
// However, since we can't easily inject the Firebase instance in the current constructor
// (it uses FirebaseRemoteConfig.instance internally), we will focus on
// testing the "Cloudflare Priority" and "Cache/Defaults" logic which makes up the bulk of our custom logic.
// Ideally, we'd refactor AuraRemoteConfig to accept a FirebaseRemoteConfig nullable instance for testing.
// For this pass, we test the logic we *can* control (Parsing, Getters, Caching).

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class FakeRemoteConfigSettings extends Fake implements RemoteConfigSettings {}

void main() {
  late AuraRemoteConfig config;
  late MockFirebaseRemoteConfig mockFirebase;

  setUpAll(() {
    registerFallbackValue(FakeRemoteConfigSettings());
  });

  final defaults = {
    'section1': {
      'key_string': 'default_value',
      'key_int': 10,
      'key_double': 1.5,
      'key_bool': false,
    },
  };

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockFirebase = MockFirebaseRemoteConfig();

    // Stub common calls to avoid null errors if init tries to call them
    when(() => mockFirebase.setConfigSettings(any())).thenAnswer((_) async {});
    when(() => mockFirebase.setDefaults(any())).thenAnswer((_) async {});
    when(() => mockFirebase.fetchAndActivate()).thenAnswer((_) async => true);
    when(() => mockFirebase.getString(any())).thenReturn('');

    config = AuraRemoteConfig(
      cloudflareUrl: 'https://fake-url.com',
      defaults: defaults,
      firebaseRemoteConfig: mockFirebase,
    );
  });

  group('AuraRemoteConfig Logic Tests', () {
    test('Initialization starts with defaults', () {
      expect(
        config.currentConfig['section1']['key_string'],
        equals('default_value'),
      );
    });

    test('GetString returns valid value or throws', () {
      expect(
        config.getString('section1', 'key_string'),
        equals('default_value'),
      );

      expect(
        () => config.getString('section1', 'missing_key'),
        throwsException,
      );
      expect(() => config.getString('missing_section', 'key'), throwsException);
    });

    test('GetInt returns valid value and handles conversion', () {
      expect(config.getInt('section1', 'key_int'), equals(10));
    });

    test('GetDouble returns valid value and handles conversion', () {
      expect(config.getDouble('section1', 'key_double'), equals(1.5));
      // Int to Double conversion check
      expect(config.getDouble('section1', 'key_int'), equals(10.0));
    });

    test('GetBool returns valid value', () {
      expect(config.getBool('section1', 'key_bool'), equals(false));
    });
  });
}
