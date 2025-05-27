import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';

/// 通话记录记录器
/// 负责将通话数据转换为通话记录并保存
/// 这个类作为 CallHandler 和 CallLogService 之间的桥梁
class CallLogRecorder {
  final CallLogService _callLogService;
  final Uuid _uuid = const Uuid();
  
  /// 构造函数
  CallLogRecorder(this._callLogService);
  
  /// 记录来电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [accepted] 是否接受来电
  Future<void> recordIncomingCall(String phoneNumber, CallData callData, bool accepted) async {
    final callType = accepted ? 'incoming' : 'missed';
    await _recordCall(phoneNumber, callData, callType);
  }
  
  /// 记录去电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  Future<void> recordOutgoingCall(String phoneNumber, CallData callData) async {
    await _recordCall(phoneNumber, callData, 'outgoing');
  }
  
  /// 记录拒接来电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  Future<void> recordRejectedCall(String phoneNumber, CallData callData) async {
    await _recordCall(phoneNumber, callData, 'rejected');
  }
  
  /// 记录拦截来电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  Future<void> recordBlockedCall(String phoneNumber, CallData callData) async {
    await _recordCall(phoneNumber, callData, 'blocked');
  }
  
  /// 记录通话的通用方法
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [callType] 通话类型
  Future<void> _recordCall(String phoneNumber, CallData callData, String callType) async {
    // 获取SIM卡信息
    final SimInfo? simInfo = callData.simInfo;
    
    // 从标签中提取标签文本作为标签ID
    List<String>? labelIds;
    if (callData.callerIdData.labels != null && callData.callerIdData.labels!.isNotEmpty) {
      labelIds = callData.callerIdData.labels!.map((label) => label.label).toList();
    }
    
    // 创建通话记录
    final callLog = CallLog(
      id: _uuid.v4(), // 生成唯一ID
      number: phoneNumber,
      name: callData.callerIdData.name, // 添加联系人名称
      timestamp: DateTime.now(),
      simDisplayName: simInfo?.displayName ?? '',
      callType: callType,
      simSlotIndex: simInfo?.simSlotIndex ?? 0,
      carrierName: simInfo?.carrierName ?? '',
      countryIso: simInfo?.countryIso ?? '',
      subscriptionId: simInfo?.subscriptionId ?? 0,
      labelIds: labelIds,
    );
    
    // 保存通话记录
    await _callLogService.addLog(callLog);
  }
}