// 仅保留核心电话号码存储功能
class PhoneNumber {
  final String value;

  const PhoneNumber(this.value);

  factory PhoneNumber.fromString(String input) {
    // 清洗逻辑：去除所有非数字字符（保留+号）
    final cleaned = input.replaceAll(RegExp(r'[^\d+]'), '');
    return PhoneNumber(cleaned);
  }

  /// 检查电话号码是否包含指定的字符串
  bool contains(String other) {
    return value.contains(other);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || 
    (other is PhoneNumber && value == other.value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}