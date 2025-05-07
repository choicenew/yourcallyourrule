// 通话过滤接口，所有过滤器都实现此接口以保持独立性

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';

/// 通话过滤接口
/// 所有过滤器都实现此接口，以便可以独立开关各个过滤器
abstract class CallFilterInterface {
  /// 判断是否应该接受来电
  /// [phoneNumber] 电话号码
  /// 返回是否应该接受来电
  Future<bool> shouldAcceptCall(String phoneNumber);
  
  /// 初始化过滤器
  Future<void> initialize();
}