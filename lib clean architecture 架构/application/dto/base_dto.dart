/// 数据传输对象基类
/// 所有DTO都应该继承自这个基类
abstract class BaseDto {
  /// 将DTO转换为Map
  Map<String, dynamic> toMap();
  
  /// 将DTO转换为JSON字符串
  String toJson() {
    return toMap().toString();
  }
}