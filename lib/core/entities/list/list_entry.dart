import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

class ListEntry {
  final String id; // 添加id属性
  final PhoneNumber phoneNumber;
  final String label;
  final String name;
  final String? avatar;

  const ListEntry({
    required this.id,
    required this.phoneNumber,
    required this.label,
    required this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'phoneNumber': phoneNumber.value,
    'label': label,
    'name': name,
    'avatar': avatar,
  };

  factory ListEntry.fromMap(Map<String, dynamic> map) {
    return ListEntry(
      id: map['id'] ?? map['phoneNumber'], // 如果没有id，使用phoneNumber作为id
      phoneNumber: PhoneNumber(map['phoneNumber']),
      label: map['label'],
      name: map['name'],
      avatar: map['avatar'],
    );
  }
}