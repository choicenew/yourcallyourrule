import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sync_ui/pyro_sync_ui.dart';

void main() {
  group('SyncSettingsPage Tests', () {
    testWidgets('Renders sync status and button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SyncSettingsPage(
            title: 'Sync Settings',
            statusText: 'All synced',
            isSyncing: false,
            onSyncNow: () {},
          ),
        ),
      );

      expect(find.text('Sync Settings'), findsOneWidget);
      expect(find.text('All synced'), findsOneWidget);
    });
  });
}
