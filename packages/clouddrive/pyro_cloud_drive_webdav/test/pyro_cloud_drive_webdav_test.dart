import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:pyro_cloud_drive_webdav/pyro_cloud_drive_webdav.dart';

void main() {
  setUp(() {
    CloudDriveHub.instance.clear();
  });

  group('WebDAVDriver Tests', () {
    test('WebDAVDriver registration', () {
      CloudDriveHub.instance.registerBuilder(
        WebDAVDriveAdapter,
        () => WebDAVDriveAdapter(),
        uiConfig: WebDAVDriveAdapter.uiConfig,
      );
      expect(CloudDriveHub.instance.availableProviders, contains(WebDAVDriveAdapter));
      final driver = CloudDriveHub.instance.getDriver<WebDAVDriveAdapter>();
      expect(driver, isA<WebDAVDriveAdapter>());
      expect(driver!.driverToken, WebDAVDriveAdapter);
    });
  });
}
