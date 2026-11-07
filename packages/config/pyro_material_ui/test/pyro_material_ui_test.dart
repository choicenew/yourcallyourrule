import 'package:material_ui/material_ui.dart' hide Card;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('Overridden Card renders with BackdropFilter', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Card(
            child: Text('Glass Card Test'),
          ),
        ),
      ),
    );

    expect(find.text('Glass Card Test'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });
}
