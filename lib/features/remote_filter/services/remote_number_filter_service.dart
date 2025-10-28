import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/remote_filter/provider/remote_number_filter_provider.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
// 导入依赖的 Provider



part 'remote_number_filter_service.g.dart';

@riverpod
RemoteNumberFilterService remoteNumberFilterService(Ref ref) {
  return RemoteNumberFilterService(
    remoteNumberService: ref.watch(remoteNumberServiceProvider),
    ref: ref,
  );
}

/// 远程号码过滤服务类 (无状态)
class RemoteNumberFilterService implements CallFilterInterface {
  final RemoteNumberService _remoteNumberService;
  final Ref _ref;

  // 构造函数明确依赖关系
  RemoteNumberFilterService({
    required RemoteNumberService remoteNumberService,
    required Ref ref,
  })  : _remoteNumberService = remoteNumberService,
        _ref = ref;

  // 判断是否应该接受来电
  @override
  Future<bool> shouldAcceptCall(String phoneNumberStr) async {
     // 如果未启用远程号码过滤，则默认接受
    final config = await _ref.read(remoteNumberFilterConfigProvider.future);
    if (!config.enableRemoteNumberFilter) {
      return true;
    }

    final phoneNumber = PhoneNumber(phoneNumberStr);
    
    // 查询远程号码信息
    final remoteInfo = await _remoteNumberService.queryRemoteNumberInfo(phoneNumberStr);
    // 如果启用了日志记录，记录查询
    if (config.logAllRemoteQueries) {
      // 日志记录逻辑
    }
    
    // 如果远程数据库中存在该号码
    if (remoteInfo != null) {
      // 增加计数
      final updatedEntry = await _remoteNumberService.incrementCount(phoneNumber);
         // 如果优先考虑远程动作设置
      if (config.prioritizeRemoteAction && updatedEntry != null) {
         // 根据远程号码的动作和计数判断
        return await _remoteNumberService.shouldAcceptBasedOnCount(phoneNumber);
      }
      
      // 检查计数是否超过阈值
      final isExceeded = await _remoteNumberService.isCountExceeded(phoneNumber);
       // 如果计数超过阈值且配置为拒绝超过阈值的号码
      if (isExceeded && config.rejectExceededNumbers) {
        return false;
      }
       // 如果计数未超过阈值且配置为允许未超过阈值的号码
      if (!isExceeded && config.allowNonExceededNumbers) {
        return true;
      }
    }
     // 默认情况下，不基于远程号码做决定
    return true;
  }

  @override
  Future<void> initialize() async {
    // 无需手动加载配置
    return;
  }
}