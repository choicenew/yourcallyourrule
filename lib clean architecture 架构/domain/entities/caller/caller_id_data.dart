import '../../value_objects/phone_number.dart';

/// 来电显示数据实体
/// 包含来电显示所需的所有信息
class CallerIdData {
  final PhoneNumber phoneNumber;
  final String? name;
  final String? location;
  final String? carrier;
  final String? countryName;
  final String? label;
  final String? avatar;
  final int? callCount;
  final String? numberType;
  final bool isBlocked;
  final bool isSpam;
  final String? matchedRuleId;
  final String? matchedRuleType;

  CallerIdData({
    required this.phoneNumber,
    this.name,
    this.location,
    this.carrier,
    this.countryName,
    this.label,
    this.avatar,
    this.callCount,
    this.numberType,
    this.isBlocked = false,
    this.isSpam = false,
    this.matchedRuleId,
    this.matchedRuleType,
  });

  /// 创建副本并更新部分属性
  CallerIdData copyWith({
    PhoneNumber? phoneNumber,
    String? name,
    String? location,
    String? carrier,
    String? countryName,
    String? label,
    String? avatar,
    int? callCount,
    String? numberType,
    bool? isBlocked,
    bool? isSpam,
    String? matchedRuleId,
    String? matchedRuleType,
  }) {
    return CallerIdData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      location: location ?? this.location,
      carrier: carrier ?? this.carrier,
      countryName: countryName ?? this.countryName,
      label: label ?? this.label,
      avatar: avatar ?? this.avatar,
      callCount: callCount ?? this.callCount,
      numberType: numberType ?? this.numberType,
      isBlocked: isBlocked ?? this.isBlocked,
      isSpam: isSpam ?? this.isSpam,
      matchedRuleId: matchedRuleId ?? this.matchedRuleId,
      matchedRuleType: matchedRuleType ?? this.matchedRuleType,
    );
  }
}