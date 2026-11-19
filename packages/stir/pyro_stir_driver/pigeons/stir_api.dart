import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/stir_api.g.dart',
  kotlinOut: 'android/src/main/kotlin/com/pyro/stir/StirApi.g.kt',
  kotlinOptions: KotlinOptions(package: 'com.pyro.stir'),
))

class StirCheckResponse {
  StirCheckResponse({
    required this.phoneNumber,
    required this.status,
    required this.isVerified,
    required this.isFailed,
  });

  String phoneNumber;
  String status;
  bool isVerified;
  bool isFailed;
}

@HostApi()
abstract class StirHostApi {
  StirCheckResponse checkStirStatus(String phoneNumber);
}

