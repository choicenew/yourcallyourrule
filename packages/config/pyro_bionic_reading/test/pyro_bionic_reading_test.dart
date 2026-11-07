import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_bionic_reading/pyro_bionic_reading.dart';

void main() {
  group('BionicReadingAlgorithm Tests', () {
    test('Generates bolded prefixes for words', () {
      final spans = BionicReadingAlgorithm.generateBionicSpans('Bionic Reading');
      expect(spans.length, greaterThanOrEqualTo(2));
      expect(spans.first.text, equals('Bio'));
      expect(spans.first.style?.fontWeight, equals(FontWeight.bold));
    });
  });

  group('BionicTextWidget Tests', () {
    testWidgets('Renders Bionic Reading RichText widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BionicTextWidget(text: 'Fast Reader'),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);
    });
  });
}
