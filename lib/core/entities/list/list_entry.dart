import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

class ListEntry {
  final PhoneNumber phoneNumber;
  final String label;
  final String name;
  final String? avatar;

  const ListEntry({
    required this.phoneNumber,
    required this.label,
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() => {
    'phoneNumber': phoneNumber.value,
    'label': label,
    'name': name,
    'avatar': avatar,
  };
}