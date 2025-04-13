import 'package:dlibphonenumber/dlibphonenumber.dart';

// 来电号码归属地数据模型
class LocationData {
  final String phoneNumber;
  String region;
  String countryName;
  String carrier;
  PhoneNumberType numberType;
  //bool isLocalNumber;

  LocationData({
    required this.phoneNumber,
    required this.region,
    required this.countryName,
    required this.carrier,
    required this.numberType,
    //required this.isLocalNumber,
  });

  // 将数据模型转换为 Map
  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'countryName': countryName,
      'carrier': carrier,
      'numberType': numberType.toString(),
     // 'isLocalNumber': isLocalNumber ? 1 : 0,
      'phoneNumber': phoneNumber,
    };
  }

  // 从 Map 中创建数据模型
  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      region: map['region'],
      countryName: map['countryName'],
      carrier: map['carrier'],
      numberType: PhoneNumberType.values[map['numberType']],
      //isLocalNumber: map['isLocalNumber'] == 1,
      phoneNumber: map['phoneNumber'],
    );
  }

  // 设置归属地
  void setRegion(String newRegion) {
    region = newRegion;
  }

  // 设置国家代码
  void setCountryCode(String newCountryName) {
    countryName = newCountryName;
  }

  // 设置运营商
  void setCarrier(String newCarrier) {
    carrier = newCarrier;
  }

  // 设置号码类型
  void setNumberType(PhoneNumberType newNumberType) {
    numberType = newNumberType;
  }
}
