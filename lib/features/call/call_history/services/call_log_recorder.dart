import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 通话记录记录器
/// 负责将通话数据转换为通话记录并保存
/// 这个类作为 CallHandler 和 CallLogService 之间的桥梁
class CallLogRecorder {
  final CallLogService _callLogService;
  final PredefinedLabelService _predefinedLabelService;
  final Uuid _uuid = const Uuid();
  
  /// 构造函数
  CallLogRecorder(this._callLogService, this._predefinedLabelService);
    /// 记录来电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [accepted] 是否接受来电
  Future<void> recordIncomingCall(String phoneNumber, CallData callData, bool accepted, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
    final callType = accepted ? 'incoming' : 'missed';
    await _recordCall(phoneNumber, callData, callType, startTime: startTime, endTime: endTime, duration: duration, timestamp: timestamp);
  }
    /// 记录去电
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  Future<void> recordOutgoingCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    await _recordCall(phoneNumber, callData, 'outgoing', timestamp: timestamp);
  }
   /// 记录拒接来电
 /// [phoneNumber] 电话号码
 /// [callData] 通话数据
  Future<void> recordRejectedCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    await _recordCall(phoneNumber, callData, 'rejected', timestamp: timestamp);
  }
   /// 记录拦截来电
 /// [phoneNumber] 电话号码
 /// [callData] 通话数据
  Future<void> recordBlockedCall(String phoneNumber, CallData callData, {int? timestamp}) async {
    await _recordCall(phoneNumber, callData, 'blocked', timestamp: timestamp);
  }
    /// 记录通话的通用方法
  /// [phoneNumber] 电话号码
  /// [callData] 通话数据
  /// [callType] 通话类型
   Future<void> _recordCall(String phoneNumber, CallData callData, String callType, {DateTime? startTime, DateTime? endTime, int? duration, int? timestamp}) async {
// 获取SIM卡信息
  final SimInfo? simInfo = callData.simInfo;

    // 从标签中提取标签文本作为标签ID
   
      // 【优化】 准备一个变量来存储最终转换好的ID列表
    List<String>? labelIds;

    // 检查传入的通话数据中是否包含标签信息
    if (callData.callerIdData.labels != null && callData.callerIdData.labels!.isNotEmpty) {
      
      // 1. 从 callData 中提取出标签文本(Text)列表
      final labelTexts = callData.callerIdData.labels!.map((label) => label.label).toList();
      
      // 2. 创建一个新列表，用于存放我们查找到的标签ID
      final List<String> foundLabelIds = [];
      
      // 3. 遍历每一个标签文本，调用我们新增的、高效的服务函数进行转换
      for (final text in labelTexts) {
        
        // 【核心修改】: 直接调用我们新增的、优雅的函数来获取ID
        // 这个函数直接返回 String?，代码非常简洁
        final String? id = await _predefinedLabelService.getLabelIdByText(text);
        
        // 如果找到了对应的ID (id不是null)，就将它添加到列表中
        if (id != null) {
          foundLabelIds.add(id);
        }
      }
      
      // 4. 如果查找到了任何有效的ID，就将这个列表赋值给 callLog 准备使用的变量
      if (foundLabelIds.isNotEmpty) {
        labelIds = foundLabelIds;
      }
    }
   
    final callLog = CallLog(
      id: _uuid.v4(),
      phoneNumber: phoneNumber,
      name: callData.callerIdData.name,
      // 优先使用精确的 startTime，其次是来自 CallScreening 的 timestamp，最后才是备用的 now()
          // 🔥🔥🔥 核心时间戳逻辑解释 🔥🔥🔥
    // CallLog 的 'timestamp' 字段，我们定义它的职责是记录“通话开始时间”。
    timestamp: startTime ?? // 1. 最高优先级：如果 startTime 存在 (意味着这是一个被接听的电话)...
                         //    ...那么就使用这个最精确的“接听时刻”作为通话的开始时间。
               (timestamp != null ? DateTime.fromMillisecondsSinceEpoch(timestamp) : DateTime.now()),
                         // 2. 次高优先级：如果 startTime 不存在 (这是一个未接、拒接或去电)...
                         //    ...那么就检查是否存在来自原生层的初始事件时间戳 (timestamp)。
                         //    如果存在，就用它。这是记录未接来电等事件时间的唯一精确来源。
                         // 3. 最低优先级 (备用方案)：如果 startTime 和 timestamp 都不存在 (理论上不应该发生)...
                         //    ...那么就使用当前的 Dart 代码执行时间 DateTime.now() 作为最后的保障。
      endTime: endTime, // 这个字段只对已接听的电话有值。
      duration: duration,// 这个字段只对已接听的电话有值。
      simDisplayName: simInfo?.displayName ?? '',
      callType: callType,
      simSlotIndex: simInfo?.simSlotIndex ?? 0,
      carrierName: callData.callerIdData.carrier ?? '',
      countryIso: simInfo?.countryIso ?? '',
      subscriptionId: simInfo?.subscriptionId ?? 0,
      labelIds: labelIds,
    );
    debugPrint('Saving CallLog: ${callLog.toMap()}');
    await _callLogService.addLog(callLog);
  }
}