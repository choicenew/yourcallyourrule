/// 用例基类
/// 所有用例都应该继承自这个基类
abstract class UseCase<Type, Params> {
  /// 执行用例
  Future<Type> call(Params params);
}

/// 无参数用例基类
/// 用于不需要参数的用例
abstract class NoParamsUseCase<Type> {
  /// 执行用例
  Future<Type> call();
}

/// 用例参数基类
/// 用于定义用例参数
class NoParams {
  const NoParams();
}