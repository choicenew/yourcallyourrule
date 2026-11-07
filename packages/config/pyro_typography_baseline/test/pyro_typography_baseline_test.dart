import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_typography_baseline/pyro_typography_baseline.dart';

void main() {
  group('FontBaselineCalibrator Tests', () {
    test('Calibrates CJK and Western text baseline style', () {
      const base = TextStyle(fontSize: 16);
      final calibrated = FontBaselineCalibrator.calibrateTextStyle(base);

      expect(calibrated.textBaseline, equals(TextBaseline.alphabetic));
      expect(calibrated.height, equals(1.4));
    });
  });

  group('CjkWesternTextWidget Tests', () {
    testWidgets('Renders CJK and Western mixed text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CjkWesternTextWidget(
              text: 'Quantum 量子计算 Machine Learning',
            ),
          ),
        ),
      );

      expect(find.text('Quantum 量子计算 Machine Learning'), findsOneWidget);
    });
  });
}
