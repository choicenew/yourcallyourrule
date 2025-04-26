/// 实体基类
/// 所有领域实体都应该继承自这个基类
abstract class Entity {
  final String id;
  
  const Entity({required this.id});
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Entity && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}