// 基础模型类，作为所有模型类的父类

// 基础实体接口
abstract class BaseEntity {
  // 获取ID
  String get id;
}

// 基础模型类
abstract class BaseModel<T> {
  // ID
  final String id;
  
  // 构造函数
  const BaseModel({required this.id});
  
  // 将模型转换为Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
  
  // 将模型转换为实体
  T toEntity();
}