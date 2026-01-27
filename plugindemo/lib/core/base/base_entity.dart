// 实体基类，所有领域实体都应该继承自这个类

abstract class BaseEntity {
  // 实体的唯一标识符
  final String id;

  // 构造函数
  const BaseEntity({required this.id});

  // 相等性比较，基于id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseEntity && other.id == id;
  }

  // 哈希码，基于id
  @override
  int get hashCode => id.hashCode;

  // 将实体转换为Map，子类应该覆盖此方法
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  // 将实体转换为JSON字符串
  String toJson() {
    return toMap().toString();
  }
}