import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sms_ui/pyro_sms_ui.dart';

void main() {
  testWidgets('SmsScreeningSettingsPage renders with localizations', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          SmsLocalizations.delegate,
        ],
        home: SmsScreeningSettingsPage(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(SmsScreeningSettingsPage), findsOneWidget);
  });
}
