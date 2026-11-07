import 'package:test/test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_onedrive/pyro_cloud_drive_onedrive.dart';

void main() {
  setUp(() {
    CloudDriveHub.instance.clear();
  });

  group('OneDriveDriver Tests', () {
    test('OneDriveDriver registration', () {
      CloudDriveHub.instance.registerBuilder(
        OneDriveDriveAdapter,
        () => OneDriveDriveAdapter(),
        uiConfig: OneDriveDriveAdapter.uiConfig,
      );
      expect(CloudDriveHub.instance.availableProviders, contains(OneDriveDriveAdapter));
      final driver = CloudDriveHub.instance.getDriver<OneDriveDriveAdapter>();
      expect(driver, isA<OneDriveDriveAdapter>());
      expect(driver!.driverToken, OneDriveDriveAdapter);
    });
  });
}
