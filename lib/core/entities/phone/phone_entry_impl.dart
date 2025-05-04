import '../../value_objects/phone_number.dart';
import 'phone_entry.dart';

class PhoneEntryImpl extends PhoneEntry {
  const PhoneEntryImpl({
    required super.id,
    required super.phoneNumber,
    super.name,
    super.avatar,
  });

  factory PhoneEntryImpl.fromMap(Map<String, dynamic> map) {
    return PhoneEntryImpl(
      id: map['id'] as String,
      phoneNumber: PhoneNumber(map['phoneNumber'] as String),
      name: map['name'] as String?,
      avatar: map['avatar'] as String?,
    );
  }
}