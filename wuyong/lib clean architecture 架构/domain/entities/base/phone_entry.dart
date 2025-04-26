import 'entity.dart';
import '../../value_objects/phone_number.dart';

/// 电话条目基类
/// 所有与电话号码相关的实体都应该继承自这个基类
abstract class PhoneEntry extends Entity {
  final PhoneNumber phoneNumber;
  final String? name;
  final String? label;
  final String? avatar;
  final String source; // 来源(用户添加/订阅)
  
  const PhoneEntry({
    required super.id,
    required this.phoneNumber,
    this.name,
    this.label,
    this.avatar,
    required this.source,
  });
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneEntry &&
        other.id == id &&
        other.phoneNumber == phoneNumber;
  }
  
  @override
  int get hashCode => Object.hash(id, phoneNumber);
}