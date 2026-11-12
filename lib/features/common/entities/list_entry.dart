import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

class ListEntry {
  final String id;
  final PhoneNumber phoneNumber;
  final String labelId;
  final String name;
  final String? avatar;

  const ListEntry({
    required this.id,
    required this.phoneNumber,
    required this.labelId,
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'phoneNumber': phoneNumber.value,
    'labelId': labelId,
    'name': name,
    'avatar': avatar,
  };

  factory ListEntry.fromMap(Map<String, dynamic> map) {
    return ListEntry(
      id: map['id'] ?? map['phoneNumber'],
      phoneNumber: PhoneNumber(map['phoneNumber']),
      labelId: map['labelId'],
      name: map['name'],
      avatar: map['avatar'],
    );
  }
}
