import 'package:test/test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_googledrive/pyro_cloud_drive_googledrive.dart';

void main() {
  setUp(() {
    CloudDriveHub.instance.clear();
  });

  group('GoogleDriveDriver Tests', () {
    test('GoogleDriveDriver registration', () {
      CloudDriveHub.instance.registerBuilder(
        GoogleDriveAdapter,
        () => GoogleDriveAdapter(),
        uiConfig: GoogleDriveAdapter.uiConfig,
      );
      expect(CloudDriveHub.instance.availableProviders, contains(GoogleDriveAdapter));
      final driver = CloudDriveHub.instance.getDriver<GoogleDriveAdapter>();
      expect(driver, isA<GoogleDriveAdapter>());
      expect(driver!.driverToken, GoogleDriveAdapter);
    });
  });
}
