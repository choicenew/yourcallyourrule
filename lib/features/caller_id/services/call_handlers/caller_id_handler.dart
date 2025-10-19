//import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'dart:async'; // 【新增】为使用Completer和TimeoutException而导入

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/caller_id/config/display_mode.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';




/// 通话处理器
/// 负责处理通话的核心逻辑，包括号码解析和来电显示信息获取
class CallHandler {
  final CallerIdService _callerIdService;
  final DisplayModeHandler _displayModeHandler;
  // MODIFICATION 2: 将成员变量的类型从 LocaleProvider 改为 Locale
  final Locale _locale;

  // A subject to broadcast the latest CallData object.
  // Using BehaviorSubject to provide the last emitted value to new listeners.
  final _callDataSubject = BehaviorSubject<CallData>();

  // Public stream for other services to listen to.
  Stream<CallData> get callDataStream => _callDataSubject.stream;
  
  // 状态数据
  StirInfo? stirInfo;
  SimInfo? simInfo;

  // 【新增】: 为解决竞态条件，创建用于同步SimInfo和StirInfo的Completer Map.
  // Key是电话号码, Value是对应的Completer, 用于在数据到达前暂停handleCall的执行.
  final Map<String, Completer<SimInfo>> _simInfoCompleters = {};
  final Map<String, Completer<StirInfo>> _stirInfoCompleters = {};


  /// 构造函数
  CallHandler({
    required CallerIdService callerIdService,
  // MODIFICATION 3: 将构造函数参数的类型从 LocaleProvider 改为 Locale，并更新参数名
    required Locale locale, 
    required DisplayModeHandler displayModeHandler,
  }) : 
    _callerIdService = callerIdService,
    _locale = locale, // 更新初始化
    _displayModeHandler = displayModeHandler;


  /// 处理通话的公共方法
  Future<CallData> handleCall(String phoneNumber) async {
    // 【修改】: 替换原有的直接获取逻辑，改为异步等待机制来聚合SimInfo和StirInfo.
    // 这样做是为了处理onIncomingCall事件与onSimCall/onStirCall事件到达顺序不确定的问题.

    // --- 1. 异步等待 SimInfo ---
    SimInfo? simInfoToUse;
    // 检查SimInfo是否已经提前到达并匹配当前号码
    if (simInfo != null && simInfo!.phoneNumber == phoneNumber) {
      simInfoToUse = simInfo;
    } else {
      // 如果SimInfo未到, 则创建一个Completer并开始等待.
      final completer = Completer<SimInfo>();
      _simInfoCompleters[phoneNumber] = completer;
      try {
        // 设置一个超时（例如500毫秒）, 避免无限期等待.
        simInfoToUse = await completer.future.timeout(const Duration(milliseconds: 500));
      } on TimeoutException {
        // 如果超时, simInfoToUse将保持为null, 程序会继续执行, 保证不会被阻塞.
        debugPrint('Waiting for SimInfo for $phoneNumber timed out.');
      } finally {
        // 无论成功或超时, 都必须从Map中移除Completer以清理资源.
        _simInfoCompleters.remove(phoneNumber);
      }
    }

    // --- 2. 异步等待 StirInfo (逻辑与SimInfo完全一致) ---
    StirInfo? stirInfoToUse;
    if (stirInfo != null && stirInfo!.phoneNumber == phoneNumber) {
      stirInfoToUse = stirInfo;
    } else {
      final completer = Completer<StirInfo>();
      _stirInfoCompleters[phoneNumber] = completer;
      try {
        stirInfoToUse = await completer.future.timeout(const Duration(milliseconds: 500));
      } on TimeoutException {
        debugPrint('Waiting for StirInfo for $phoneNumber timed out.');
      } finally {
        _stirInfoCompleters.remove(phoneNumber);
      }
    }

    debugPrint('Phone Number: $phoneNumber, ${simInfo?.phoneNumber},simInfoToUse.toMap(): ${simInfo?.phoneNumber}, ${simInfoToUse?.toMap()}');
    
    // --- 3. 继续执行原有的电话号码解析和信息获取逻辑 ---

    // 解析号码
    Map<String, String> parsedData;
    if (simInfoToUse != null && simInfoToUse.countryIso != null) {
      // 使用带有国家代码的解析方法
      parsedData = await PhoneUtils.parsePhoneNumberWithIso(
          phoneNumber, simInfoToUse.countryIso!);
    } else {
      // 使用不带国家代码的解析方法
      parsedData = await PhoneUtils.parsePhoneNumber(phoneNumber);
    }

    String countryCode = parsedData['countryCode']!;
    String e164Number = parsedData['e164Number']!;
    String nationalNumber = parsedData['nationalNumber']!;

    // 判断 e164Number 是否有效
    if (e164Number.isEmpty) {
      return CallData(
        callerIdData: CallerIdData(
          id: const Uuid().v4(),
          phoneNumber: PhoneNumber.fromString(phoneNumber),
          countryName: 'Unknown',
          region: 'Unknown',
          carrier: 'Unknown',
          numberType: PhoneNumberType.unknown,
          labels: [const Label(label: 'Unknown')],
          name: 'Unknown',
          avatar: '',
          count: 0,
        ),
        e164Number: '',
        nationalNumber: '',
      );
    }

    // 获取当前 Locale
    // 直接从 _locale 成员变量中获取，不再需要 .locale
    final languageCode = _locale.languageCode;

    // 创建 dlibphonenumber 的 Locale
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: (countryCode).toUpperCase(),
    );

    // 获取来电显示信息
    CallerIdData callerIdData =
        await _callerIdService.getCallerIdWithParsed(
        phoneNumber, e164Number, nationalNumber, dlibLocale);
    // await _callerIdService.getCallerId(phoneNumber, dlibLocale); //原始的解析方法
    
  // 在显示之前，打印所有将要发送到悬浮窗的数据
  debugPrint('===================================================');
  debugPrint('>>> DEBUGGING in CallHandler.handleCall <<<');
  debugPrint('Phone Number: $phoneNumber');
  debugPrint('--- CallerIdData to be displayed: ---');
  debugPrint('callerIdData: ${callerIdData.toMap()}'); // 或者 callerIdData.toMap().toString() 如果你有 toMap 方法
  debugPrint('--- StirInfo to be displayed: ---');
  debugPrint(stirInfoToUse?.toString()); // 使用 ?. 避免 stirInfoToUse 为 null 时崩溃
  debugPrint('--- SimInfo to be displayed: ---');
  debugPrint('simInfo: ${simInfoToUse?.toMap()}'); // 使用 ?. 避免 simInfoToUse 为 null 时崩溃
  debugPrint('===================================================');
  // ---【 调试结束 】---


    // 显示来电信息（浮窗或通知，由DisplayModeHandler决定）
    await _displayModeHandler.showCallerIdInfo(callerIdData, stirInfoToUse, simInfoToUse);

    // 创建 CallData 对象
    CallData callData = CallData(
      callerIdData: callerIdData,
      e164Number: e164Number,
      nationalNumber: nationalNumber,
      stirInfo: stirInfoToUse,
      simInfo: simInfoToUse,
    );

    // Add the new CallData to the stream for listeners
    _callDataSubject.add(callData);

    debugPrint('callerid handler 里面的calldata: ${callData.toMap()}, ${simInfoToUse?.toMap()}');
    // 将 CallData 插入数据库或缓存或者calllog中
    await saveCallerIdDataToCache(phoneNumber, callData);

    // State (stirInfo, simInfo) is intentionally not cleared here to persist
    // for the duration of the call event.

    // 返回 CallData 对象
    return callData;
  }

  /// 关闭浮窗和通知
  void closeOverlay() {
    _displayModeHandler.closeDisplay();
  }
  
  /// Closes the stream controller when the handler is disposed.
  void dispose() {
    _callDataSubject.close();
  }
  
  /// 设置显示模式
  Future<void> setDisplayMode(String mode) async {
    final displayMode = DisplayMode.values.byName(mode);
    await _displayModeHandler.setDisplayMode(displayMode);
  }

  /// 保存来电显示数据到缓存
  Future<void> saveCallerIdDataToCache(
      String phoneNumber, CallData callData) async {
    // 实现缓存逻辑
  }

  /// 设置STIR信息
  void setStirInfo(StirInfo info) {
    stirInfo = info;
    // 【修改】: 在收到StirInfo后, 检查是否有正在等待它的Completer.
    if (_stirInfoCompleters.containsKey(info.phoneNumber)) {
      // 如果有, 则使用收到的info来完成(complete)这个Completer.
      // 这将立即唤醒在handleCall中await这个Completer的执行点.
      _stirInfoCompleters.remove(info.phoneNumber)!.complete(info);
    }
  }

  /// 设置SIM卡信息
  void setSimInfo(SimInfo info) {
    simInfo = info;
    // 【修改】: 逻辑与setStirInfo完全相同, 用于唤醒等待SimInfo的调用.
    if (_simInfoCompleters.containsKey(info.phoneNumber)) {
      _simInfoCompleters.remove(info.phoneNumber)!.complete(info);
    }
  }
  
  /// 设置像素比例
  void setPixelRatio(double ratio) {
    _displayModeHandler.setPixelRatio(ratio);
  }
  
  /// 获取显示模式处理器
  DisplayModeHandler get displayModeHandler => _displayModeHandler;
}