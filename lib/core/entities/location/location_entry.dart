import 'package:dlibphonenumber/dlibphonenumber.dart' hide PhoneNumber;
import 'package:yourcallyourrule/core/base/base_entity.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

class LocationEntry extends BaseEntity {  // 添加继承
  final PhoneNumber phoneNumber;
  final String? region;
  final String? countryName;
  final String? carrier;
  final PhoneNumberType numberType;

  // 保持原有构造函数
  LocationEntry({
    required super.id,  // 继承自BaseEntity的id
    required this.phoneNumber,
    this.region,
    this.countryName,
    this.carrier,
    required this.numberType,
  });  // 调用基类构造函数

  // 新增fromMap工厂构造函数
  factory LocationEntry.fromMap(Map<String, dynamic> map) {
    return LocationEntry(
      id: map['id'] as String,
      phoneNumber: PhoneNumber.fromString(map['phoneNumber'] as String),
      region: map['region'] as String?,
      countryName: map['countryName'] as String?,
      carrier: map['carrier'] as String?,
      numberType: PhoneNumberType.values[map['numberType'] as int],
    );
  }

  // 新增copyWith方法
  LocationEntry copyWith({
    String? id,
    PhoneNumber? phoneNumber,
    String? region,
    String? countryName,
    String? carrier,
    PhoneNumberType? numberType,
  }) {
    return LocationEntry(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      region: region ?? this.region,
      countryName: countryName ?? this.countryName,
      carrier: carrier ?? this.carrier,
      numberType: numberType ?? this.numberType,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber.value,
      'region': region,
      'countryName': countryName,
      'carrier': carrier,
      'numberType': numberType.index,
    };
  }
}