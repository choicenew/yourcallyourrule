import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_call_redirection_ui/pyro_call_redirection_ui.dart';

void main() {
  testWidgets('CallRedirectionSettingsPage renders with Riverpod', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CallRedirectionSettingsPage(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(CallRedirectionSettingsPage), findsOneWidget);
  });
}
