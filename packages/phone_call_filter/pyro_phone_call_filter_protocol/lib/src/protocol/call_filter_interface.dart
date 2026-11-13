import 'package:pyro_phone_call_filter_protocol/src/protocol/call_filter_type.dart';

/// 通话过滤接口契约 (CallFilterInterface)
abstract class CallFilterInterface {
  /// 过滤器类型值对象
  CallFilterType get filterType;

  /// 判断是否应该接受来电
  Future<bool> shouldAcceptCall(String phoneNumber);

  /// 初始化过滤器
  Future<void> initialize();
}
