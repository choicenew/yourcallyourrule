/// 失败基类
abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  String toString() => 'Failure: $message (code: $code)';
}

/// 服务器失败
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

/// 缓存失败
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

/// 网络失败
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

/// 权限失败
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.code});
}

/// 平台失败
class PlatformFailure extends Failure {
  const PlatformFailure(super.message, {super.code});
}

/// 验证失败
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

/// 未找到失败
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

/// 规则匹配失败
class RuleMatchFailure extends Failure {
  const RuleMatchFailure(super.message, {super.code});
}

/// 文件操作失败
class FileOperationFailure extends Failure {
  const FileOperationFailure(super.message, {super.code});
}

/// 无效文件失败
class InvalidFileFailure extends Failure {
  const InvalidFileFailure(super.message, {super.code});
}

/// 规则优先级失败
class RulePriorityFailure extends Failure {
  const RulePriorityFailure(super.message, {super.code});
}