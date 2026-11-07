import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_ambient_light_ui/pyro_ambient_light_ui.dart';

void main() {
  group('WarmPaperTint Tests', () {
    test('Generates valid low blue light color filter matrix', () {
      final filter = WarmPaperTint.getWarmPaperFilter(intensity: 0.5);
      expect(filter, isA<ColorFilter>());
    });
  });

  group('AmbientLightFilterWidget Tests', () {
    testWidgets('Applies ColorFiltered wrapper to child', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AmbientLightFilterWidget(
              child: Text('Warm Paper Reader'),
            ),
          ),
        ),
      );

      expect(find.byType(ColorFiltered), findsOneWidget);
      expect(find.text('Warm Paper Reader'), findsOneWidget);
    });
  });
}
