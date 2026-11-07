import 'package:pyro_shadow_identity/pyro_shadow_identity.dart';
import 'package:test/test.dart';

void main() {
  group('ShadowIdentity Enum & Token Tests', () {
    test('ShadowGender values and parsing', () {
      expect(ShadowGender.fromValue('male'), equals(ShadowGender.male));
      expect(ShadowGender.fromValue('female'), equals(ShadowGender.female));
      expect(ShadowGender.fromValue('unknown'), equals(ShadowGender.unspecified));
      expect(ShadowGender.fromValue(null), equals(ShadowGender.unspecified));

      expect(ShadowGender.male.value, equals('male'));
      expect(ShadowGender.female.value, equals('female'));
      expect(ShadowGender.unspecified.value, equals('unspecified'));
    });

    test('ShadowConfigKey Tokens', () {
      expect(ShadowConfigKey.gender, equals('gender'));
      expect(ShadowConfigKey.age, equals('age'));
      expect(ShadowConfigKey.interestKeywords, equals('interest_keywords'));
      expect(ShadowConfigKey.persona, equals('persona'));
    });
  });
}
