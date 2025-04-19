// 电话号码值对象，用于封装和验证电话号码

class PhoneNumber {
  // 电话号码的值
  final String value;
  
  // 国家代码（可选）
  final String? countryCode;
  
  // 运营商信息（可选）
  final String? carrier;
  
  // 号码类型（可选）
  final PhoneNumberType type;
  
  // 构造函数，要求提供有效的电话号码
  const PhoneNumber({
    required this.value,
    this.countryCode,
    this.carrier,
    this.type = PhoneNumberType.unknown,
  });
  
  // 工厂构造函数，从字符串创建电话号码
  factory PhoneNumber.fromString(String phoneNumberStr) {
    // 这里可以添加电话号码格式验证和处理逻辑
    // 简单实现，实际应用中应该有更复杂的验证和格式化
    return PhoneNumber(value: phoneNumberStr.trim());
  }
  
  // 相等性比较
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneNumber && other.value == value;
  }
  
  // 哈希码
  @override
  int get hashCode => value.hashCode;
  
  // 字符串表示
  @override
  String toString() => value;
  
  // 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'countryCode': countryCode,
      'carrier': carrier,
      'type': type.index,
    };
  }
  
  // 从Map创建实例
  factory PhoneNumber.fromMap(Map<String, dynamic> map) {
    return PhoneNumber(
      value: map['value'],
      countryCode: map['countryCode'],
      carrier: map['carrier'],
      type: map['type'] != null 
          ? PhoneNumberType.values[map['type']] 
          : PhoneNumberType.unknown,
    );
  }
}

/// 电话号码类型枚举
enum PhoneNumberType {
  mobile,
  fixedLine,
  tollFree,
  premiumRate,
  sharedCost,
  voip,
  personalNumber,
  pager,
  uan,
  voicemail,
  unknown,
}