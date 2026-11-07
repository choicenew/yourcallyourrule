import 'package:pyro_hetu_script_engine/pyro_hetu_script_engine.dart';
import 'src/cloud_drive_binding.dart';

export 'src/cloud_drive_binding.dart';

class CloudDriveHetuBridge {
  static void registerBinding(PyroHetuEngine engine) {
    engine.hetu.interpreter.bindExternalClass(CloudDriveBinding());
  }
}
