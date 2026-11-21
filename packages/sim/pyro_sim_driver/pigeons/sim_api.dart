import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/sim_api.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/pyro/sim/SimApi.g.kt',
  kotlinOptions: KotlinOptions(
    package: 'com.pyro.sim',
  ),
))
class SimCardPayload {
  int? subscriptionId;
  int? simSlotIndex;
  String? carrierName;
  String? displayName;
  String? countryIso;
  String? iccId;
  String? mccString;
  String? mncString;
  String? simPhoneNumber;
  bool? isDataRoaming;
  bool? isNetworkRoaming;
  String? state;
}

class NetworkInfoPayload {
  String? networkOperatorName;
  String? networkOperator;
  String? networkType;
  bool? isNetworkAvailable;
  bool? isRoaming;
}

@HostApi()
abstract class SimHostApi {
  List<SimCardPayload> getActiveSimCards();
  bool hasSimCard();
  NetworkInfoPayload? getNetworkInfo();
}
