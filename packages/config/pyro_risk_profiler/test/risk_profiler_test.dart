import 'package:test/test.dart';
import 'package:pyro_risk_profiler/pyro_risk_profiler.dart';

void main() {
  group('UserRiskCalculator Tests', () {
    const calculator = UserRiskCalculator();

    test('Non-sensitive interactions score 0', () {
      final interaction = UserRiskInteraction(
        tags: ['landscape', 'nature', 'blue_sky'],
        viewDurationMillis: 8000,
        intent: RiskInteractionIntent.inspect,
      );

      final score = calculator.calculateInteractionScore(
        interaction,
        sensitiveKeywords: {'nsfw', 'sexy', 'bikini'},
      );

      expect(score, 0.0);
    });

    test('Sensitive interactions score accurately based on depth and intent',
        () {
      final interaction = UserRiskInteraction(
        tags: ['anime', 'bikini_girl'],
        viewDurationMillis: 12000, // >5s (+2), >10s (+3)
        intent: RiskInteractionIntent.inspect, // +5
        isDownloaded: true, // +10
      );

      // Base 1 + 2 + 3 + 5 + 10 = 21.0
      final score = calculator.calculateInteractionScore(
        interaction,
        sensitiveKeywords: {'bikini', 'nsfw'},
      );

      expect(score, 21.0);
    });

    test('Level threshold determination', () {
      expect(calculator.determineLevel(0, 0), 0);
      expect(calculator.determineLevel(0, 15), 1);
      expect(calculator.determineLevel(0, 60), 2);
      expect(calculator.determineLevel(0, 250), 3);
      expect(calculator.determineLevel(0, 600), 4);
      expect(calculator.determineLevel(0, 1200), 5);
    });
  });

  group('RiskProfileManager Tests', () {
    late RiskProfileManager manager;

    setUp(() async {
      manager = RiskProfileManager(
        sensitiveKeywords: {'r18', 'bikini'},
      );
      await manager.initialize();
    });

    tearDown(() {
      manager.dispose();
    });

    test('Initial level is pure (0)', () {
      expect(manager.currentLevel, 0);
      expect(manager.currentSensitivity, UserSensitivityLevel.level0_pure);
    });

    test('Process interaction triggers level upgrade and stream events',
        () async {
      final levelEvents = <int>[];
      final sub = manager.onLevelChanged.listen(levelEvents.add);

      // Trigger high score interaction
      final interaction = UserRiskInteraction(
        tags: ['r18', 'art'],
        viewDurationMillis: 15000,
        intent: RiskInteractionIntent.inspect,
        isDownloaded: true,
      );

      // Score: 1 + 2 + 3 + 5 + 10 = 21 (>= 10 => Level 1)
      await manager.processInteraction(interaction);

      expect(manager.currentLevel, 1);
      expect(manager.currentSensitivity, UserSensitivityLevel.level1_light);

      await sub.cancel();
    });
  });

  group('RiskMasterEvaluator Tests', () {
    const evaluator = RiskMasterEvaluator();

    test('Determines RiskProfile and AdTrafficTier correctly', () {
      expect(
        evaluator.determineRiskProfile(
            userLevel: UserSensitivityLevel.level0_pure),
        RiskProfile.safe,
      );
      expect(
        evaluator.determineRiskProfile(
            userLevel: UserSensitivityLevel.level4_high),
        RiskProfile.ban,
      );
      expect(
        evaluator.determineRiskProfile(
          userLevel: UserSensitivityLevel.level1_light,
          sourceLevel: SourceRiskLevel.unsafe,
        ),
        RiskProfile.risky,
      );

      expect(
        evaluator.determineAdTier(userLevel: UserSensitivityLevel.level0_pure),
        AdTrafficTier.tier1,
      );
      expect(
        evaluator.determineAdTier(userLevel: UserSensitivityLevel.level3_medium),
        AdTrafficTier.tier3,
      );
      expect(
        evaluator.determineAdTier(
            userLevel: UserSensitivityLevel.level5_extreme),
        AdTrafficTier.tier5,
      );
    });
  });
}
