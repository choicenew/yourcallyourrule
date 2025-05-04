import 'package:dlibphonenumber/dlibphonenumber.dart' hide PhoneNumber;
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/models/base_model.dart';


class LocationModel extends BaseModel<LocationEntry> {
  final PhoneNumber phoneNumber;
  final String? region;
  final String? countryName;
  final String? carrier;
  final PhoneNumberType numberType;

  const LocationModel({
    required super.id,
    required this.phoneNumber,
    this.region,
    this.countryName,
    this.carrier,
    required this.numberType,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      phoneNumber: PhoneNumber.fromString(map['phoneNumber'] as String),
      region: map['region'] as String?,
      countryName: map['countryName'] as String?,
      carrier: map['carrier'] as String?,
      numberType: PhoneNumberType.values[map['numberType'] as int],
    );
  }

  factory LocationModel.fromEntity(LocationEntry entity) {
    return LocationModel(
      id: entity.id,
      phoneNumber: entity.phoneNumber,
      region: entity.region,
      countryName: entity.countryName,
      carrier: entity.carrier,
      numberType: entity.numberType,
    );
  }

  @override
  LocationEntry toEntity() {
    return LocationEntry(
      id: id,
      phoneNumber: phoneNumber,
      region: region,
      countryName: countryName,
      carrier: carrier,
      numberType: numberType,
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