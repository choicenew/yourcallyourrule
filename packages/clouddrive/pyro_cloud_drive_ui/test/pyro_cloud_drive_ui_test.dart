import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_ui/pyro_cloud_drive_ui.dart';

void main() {
  group('PyroCloudDriveUI Widget Tests', () {
    testWidgets('CloudSyncStatusWidget displays provider name and status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CloudSyncStatusWidget(
              providerName: 'WEBDAV',
              icon: Icons.cloud_queue,
              isConnected: true,
              lastSyncTime: DateTime(2026, 8, 15, 12, 0),
            ),
          ),
        ),
      );

      expect(find.text('WEBDAV'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_queue), findsOneWidget);
      expect(find.textContaining('Last synced:'), findsOneWidget);
    });

    testWidgets('CloudSettingsPage renders security and drive sections', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: CloudSettingsPage(),
          ),
        ),
      );

      expect(find.text('Cloud Drive & Sync Settings'), findsOneWidget);
      expect(find.text('End-to-End Encryption (E2EE)'), findsOneWidget);
    });
  });
}
