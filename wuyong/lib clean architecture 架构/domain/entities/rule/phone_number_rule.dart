import '../../value_objects/phone_number.dart';

/// 电话号码规则接口
/// 用于标识包含电话号码的规则类型
abstract class PhoneNumberRule {
  PhoneNumber get phoneNumber;
  String? get label;
  String? get avatar;
}