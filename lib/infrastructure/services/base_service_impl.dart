/// 服务实现基类
/// 提供基础服务功能，所有服务实现类都应该继承自这个类
abstract class BaseServiceImpl {
  /// 记录服务操作日志
  void logOperation(String operation, {String? details}) {
    // 实际项目中可以实现日志记录逻辑
    print('[$runtimeType] $operation ${details != null ? ': $details' : ''}');
  }
  
  /// 检查服务是否可用
  bool isServiceAvailable() {
    // 实际项目中可以实现服务可用性检查逻辑
    return true;
  }
}