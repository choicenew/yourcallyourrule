import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import 'package:pyro_cloud_drive_protocol/pyro_cloud_drive_protocol.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';

class CloudDriveBinding extends HTExternalClass {
  CloudDriveBinding() : super('CloudDrive');

  CloudDriveAdapter? _getDriverFromProvider(dynamic providerArg) {
    if (providerArg == null) return CloudDriveHub.instance.currentDriver;
    final search = providerArg.toString().toLowerCase();
    for (final token in CloudDriveHub.instance.availableProviders) {
      if (token.toString().toLowerCase().contains(search)) {
        return CloudDriveHub.instance.getDriver(token);
      }
    }
    return CloudDriveHub.instance.currentDriver;
  }

  @override
  dynamic memberGet(String id,
      {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'CloudDrive.list':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return [];
          final driver = _getDriverFromProvider(positionalArgs[0]);
          if (driver == null) return [];
          final files = await driver.listFiles(positionalArgs[1].toString());
          return files.map((e) => e.toJson()).toList();
        };

      case 'CloudDrive.read':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return null;
          final driver = _getDriverFromProvider(positionalArgs[0]);
          if (driver == null) return null;
          return await driver.readFile(positionalArgs[1].toString());
        };

      case 'CloudDrive.write':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 3) return false;
          final driver = _getDriverFromProvider(positionalArgs[0]);
          if (driver == null) return false;
          return await driver.writeFile(positionalArgs[1].toString(), positionalArgs[2]);
        };

      case 'CloudDrive.exists':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return false;
          final driver = _getDriverFromProvider(positionalArgs[0]);
          return await driver?.fileExists(positionalArgs[1].toString()) ?? false;
        };

      case 'CloudDrive.delete':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return false;
          final driver = _getDriverFromProvider(positionalArgs[0]);
          return await driver?.deleteFile(positionalArgs[1].toString()) ?? false;
        };

      case 'CloudDrive.getDownloadUrl':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          if (positionalArgs.length < 2) return null;
          final driver = _getDriverFromProvider(positionalArgs[0]);
          return await driver?.getDownloadUrl(positionalArgs[1].toString());
        };

      case 'CloudDrive.getAvailableProviders':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) async {
          return CloudDriveHub.instance.availableProviders;
        };

      default:
        throw HTError.undefined(id);
    }
  }
}
