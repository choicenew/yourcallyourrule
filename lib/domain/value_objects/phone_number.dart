/// 电话号码值对象
/// 用于封装和验证电话号码
class PhoneNumber {
  final String value;
  
  /// 创建一个电话号码值对象
  /// 如果电话号码格式无效，将抛出异常
  const PhoneNumber(this.value) {
    if (!isValid()) {
      throw ArgumentError('Invalid phone number format: $value');
    }
  }
  
  /// 验证电话号码格式是否有效
  bool isValid() {
    // 简单验证：电话号码应该只包含数字、+号和可能的空格或连字符
    // 实际应用中可能需要更复杂的验证逻辑
    final validChars = RegExp(r'^[0-9+\-\s]+$');
    return value.isNotEmpty && validChars.hasMatch(value);
  }
  
  /// 获取标准化的电话号码（移除所有非数字字符，保留+号）
  String get normalized {
    return value.replaceAll(RegExp(r'[^0-9+]'), '');
  }
  
  /// 获取格式化的电话号码，适合显示
  String get formatted {
    // 这里可以实现更复杂的格式化逻辑
    return value;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhoneNumber && other.normalized == normalized;
  }
  
  @override
  int get hashCode => normalized.hashCode;
  
  @override
  String toString() => value;
}