// 模型基类，所有数据模型都应该继承自这个类

abstract class BaseModel<T> {
  // 模型的唯一标识符
  final String id;

  // 构造函数
  const BaseModel({required this.id});

  // 相等性比较，基于id
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseModel && other.id == id;
  }

  // 哈希码，基于id
  @override
  int get hashCode => id.hashCode;

  // 将模型转换为Map，子类应该覆盖此方法
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  // 将Map转换为模型，子类应该覆盖此方法
  static BaseModel<T> fromMap<T>(Map<String, dynamic> map, BaseModel<T> Function(Map<String, dynamic>) constructor) {
    return constructor(map);
  }

  // 将模型转换为实体，子类应该覆盖此方法
  T toEntity();

  // 将实体转换为模型，子类应该覆盖此静态方法
  static BaseModel<T> fromEntity<T>(dynamic entity, BaseModel<T> Function(dynamic) constructor) {
    return constructor(entity);
  }
}