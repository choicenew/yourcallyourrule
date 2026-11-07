import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_theme_ui/pyro_theme_ui.dart';

void main() {
  testWidgets('PyroThemeSettingsWidget renders properly inside ProviderScope', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: PyroThemeSettingsWidget(),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(PyroThemeSettingsWidget), findsOneWidget);
    expect(find.byType(ExpansionTile), findsOneWidget);
  });
}
