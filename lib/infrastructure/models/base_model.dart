/// 模型基类
/// 所有模型都应该继承自这个基类
abstract class BaseModel<T> {
  /// 将模型转换为Map
  Map<String, dynamic> toMap();
  
  /// 将Map转换为模型
  static T fromMap<T>(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }
  
  /// 将模型转换为JSON字符串
  String toJson() {
    return toMap().toString();
  }
}