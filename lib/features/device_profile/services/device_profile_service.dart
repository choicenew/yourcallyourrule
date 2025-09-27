// lib/features/device_profile/services/device_profile_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sim_reader/sim_reader.dart';
import 'package:sim_card_code/sim_card_code.dart' hide NetworkInfo;
import 'package:permission_handler/permission_handler.dart';
import 'package:crypto/crypto.dart';

class IpInfo {
  final String? query, country, countryCode, regionName, city;
  IpInfo({this.query, this.country, this.countryCode, this.regionName, this.city});
  factory IpInfo.fromJson(Map<String, dynamic> json) {
    return IpInfo(
      query: json['query'] as String?, country: json['country'] as String?,
      countryCode: json['countryCode'] as String?, regionName: json['regionName'] as String?,
      city: json['city'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'query': query, 'country': country, 'countryCode': countryCode, 
    'regionName': regionName, 'city': city
  };
}

class RawDeviceProfile {
  final SimInfo? simInfo;
  final NetworkInfo? networkInfo;
  final String? deviceId;
  final String? hashedDeviceId;
  final IpInfo? ipInfo;
  final String? simState;
  RawDeviceProfile({this.simInfo, this.networkInfo, this.deviceId, this.hashedDeviceId, this.ipInfo, this.simState});
}

class DeviceProfileService {
  Future<bool> requestPermissions() async {
    if (await Permission.phone.isGranted) return true;
    var status = await Permission.phone.request();
    return status.isGranted;
  }

  Future<IpInfo?> _getIpInfo() async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json'));
      if (response.statusCode == 200) return IpInfo.fromJson(jsonDecode(response.body));
    } catch (e) { print("Failed to get IP info: $e"); }
    return null;
  }
  
  String _hashDeviceId(String? deviceId) {
    if (deviceId == null || deviceId.isEmpty) return "unknown_device";
    const salt = "your_super_secret_salt_from_a_secure_remote_source"; 
    final bytes = utf8.encode(deviceId + salt);
    return sha256.convert(bytes).toString();
  }

  Future<RawDeviceProfile> getRawProfile() async {
    if (!await requestPermissions()) throw Exception('Phone permission is required.');
    try {
      final results = await Future.wait([
        SimReader.getSimInfo(),
        SimReader.getNetworkInfo(),
        SimCardManager.deviceId,
        _getIpInfo(),
        SimCardManager.simState,
      ]);
      final deviceId = results[2] as String?;
      return RawDeviceProfile(
        simInfo: results[0] as SimInfo?, networkInfo: results[1] as NetworkInfo?,
        deviceId: deviceId, hashedDeviceId: _hashDeviceId(deviceId),
        ipInfo: results[3] as IpInfo?, simState: results[4] as String?,
      );
    } catch (e) {
      print("Error getting raw device profile: $e");
      rethrow;
    }
  }
}