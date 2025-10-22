// 导入 Dart 核心包
import 'dart:async';
// 导入 Flutter 核心包
import 'package:flutter/material.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入外部库
import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
// 导入项目中的工具、实体类和服务
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/caller_id/providers/caller_id_service_provider.dart';

// 导入依赖的 Provider
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/display_mode_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/sim_call_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/stir_call_handler.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';



// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'caller_id_handler.g.dart';

/// 通话处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
@Riverpod(keepAlive: true)
class CallHandler extends _$CallHandler {

  /// 用于广播每一次通话事件的 BehaviorSubject。
  final _callDataSubject = BehaviorSubject<CallData>();

  /// 其他服务可以监听此流来获取每一次通话的事件。
  Stream<CallData> get callDataStream => _callDataSubject.stream;

  /// build 方法是 Provider 的初始化入口。
  @override
  CallData? build() {
    // 监听 simCallHandlerProvider 的状态变化。
    ref.listen<SimInfo?>(simCallHandlerProvider, (previous, next) {
      if (next != null) {
        setSimInfo(next);
      }
    });

    // 监听 stirCallHandlerProvider 的状态变化。
    ref.listen<StirInfo?>(stirCallHandlerProvider, (previous, next) {
      if (next != null) {
        setStirInfo(next);
      }
    });
    
    // 使用 ref.onDispose 注册一个回调，当这个 Provider 被销毁时执行。
    ref.onDispose(() {
      // 清理 BehaviorSubject
      _callDataSubject.close();
      // 清理所有可能存在的、未完成的 Completer，防止内存泄漏。
      for (var completer in _simInfoCompleters.values) {
        if (!completer.isCompleted) completer.completeError('Handler disposed');
      }
      _simInfoCompleters.clear();
      
      for (var completer in _stirInfoCompleters.values) {
        if (!completer.isCompleted) completer.completeError('Handler disposed');
      }
      _stirInfoCompleters.clear();
    });
    
    // 返回状态的初始值 null
    return null;
  }
  
  // 公共成员变量，以匹配您的原始代码
  StirInfo? stirInfo;
  SimInfo? simInfo;
  
  // 用于解决竞态条件的 Completer Map，保持不变
  final Map<String, Completer<SimInfo>> _simInfoCompleters = {};
  final Map<String, Completer<StirInfo>> _stirInfoCompleters = {};

  /// 处理通话的公共方法
  Future<CallData> handleCall(String phoneNumber) async {
    // 【修正】: 依赖现在通过 ref 在方法内部按需获取。
    final callerIdService = ref.read(callerIdServiceProvider);
    // 【修正】: DisplayModeHandler 的 build 方法是同步的，因此 provider 不是 FutureProvider。
    //  它没有 `.notifier` 属性，`await` 之后得到的就是 `DisplayModeHandler` 的实例本身。
    final displayModeHandler = await ref.read(displayModeHandlerProvider.future);
    final locale = await ref.read(localeProvider.future);

    // --- 1. 异步等待 SimInfo ---
    SimInfo? simInfoToUse;
    if (simInfo != null && simInfo!.phoneNumber == phoneNumber) {
      simInfoToUse = simInfo;
    } else {
      final completer = Completer<SimInfo>();
      _simInfoCompleters[phoneNumber] = completer;
      try {
        simInfoToUse = await completer.future.timeout(const Duration(milliseconds: 500));
      } on TimeoutException {
        debugPrint('Waiting for SimInfo for $phoneNumber timed out.');
      } finally {
        _simInfoCompleters.remove(phoneNumber);
      }
    }

    // --- 2. 异步等待 StirInfo ---
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

    // 恢复您的原始 debugPrint 语句
    debugPrint('Phone Number: $phoneNumber, ${simInfo?.phoneNumber},simInfoToUse.toMap(): ${simInfo?.phoneNumber}, ${simInfoToUse?.toMap()}');
    
    // --- 3. 继续执行原有的电话号码解析和信息获取逻辑 ---
    Map<String, String> parsedData;
    if (simInfoToUse != null && simInfoToUse.countryIso != null) {
      parsedData = await PhoneUtils.parsePhoneNumberWithIso(phoneNumber, simInfoToUse.countryIso!);
    } else {
      parsedData = await PhoneUtils.parsePhoneNumber(phoneNumber);
    }

    String countryCode = parsedData['countryCode']!;
    String e164Number = parsedData['e164Number']!;
    String nationalNumber = parsedData['nationalNumber']!;

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
    
    final languageCode = locale.languageCode;
    final dlibLocale = dlibphone.Locale(
      language: languageCode,
      country: (countryCode).toUpperCase(),
    );
    
    CallerIdData callerIdData = await callerIdService.getCallerIdWithParsed(
        phoneNumber, e164Number, nationalNumber, dlibLocale);
    
    debugPrint('===================================================');
    debugPrint('>>> DEBUGGING in CallHandler.handleCall <<<');
    debugPrint('Phone Number: $phoneNumber');
    debugPrint('--- CallerIdData to be displayed: ---');
    debugPrint('callerIdData: ${callerIdData.toMap()}');
    debugPrint('--- StirInfo to be displayed: ---');
    debugPrint(stirInfoToUse?.toString());
    debugPrint('--- SimInfo to be displayed: ---');
    debugPrint('simInfo: ${simInfoToUse?.toMap()}');
    debugPrint('===================================================');

    await displayModeHandler.showCallerIdInfo(callerIdData, stirInfoToUse, simInfoToUse);

    CallData callData = CallData(
      callerIdData: callerIdData,
      e164Number: e164Number,
      nationalNumber: nationalNumber,
      stirInfo: stirInfoToUse,
      simInfo: simInfoToUse,
    );
    
    // 两者共存，同时更新 state 和广播事件
    state = callData;
    _callDataSubject.add(callData);

    debugPrint('callerid handler 里面的calldata: ${callData.toMap()}, ${simInfoToUse?.toMap()}');
    await saveCallerIdDataToCache(phoneNumber, callData);

    return callData;
  }
  
  /// 关闭浮窗和通知
   Future<void> closeOverlay() async {
      // 【核心修正】: 同样地，await .future 来获取实例，然后调用方法。
    final displayModeHandler = await ref.read(displayModeHandlerProvider.future);
    await displayModeHandler.closeDisplay();
  }
  
  /// 保存来电显示数据到缓存，逻辑不变
  Future<void> saveCallerIdDataToCache(String phoneNumber, CallData callData) async {
    // 实现缓存逻辑
  }

  /// 设置STIR信息
  void setStirInfo(StirInfo info) {
    stirInfo = info;
    if (_stirInfoCompleters.containsKey(info.phoneNumber)) {
      _stirInfoCompleters.remove(info.phoneNumber)!.complete(info);
    }
  }

  /// 设置SIM卡信息
  void setSimInfo(SimInfo info) {
    simInfo = info;
    if (_simInfoCompleters.containsKey(info.phoneNumber)) {
      _simInfoCompleters.remove(info.phoneNumber)!.complete(info);
    }
  }
  
  // 恢复您原始代码中的废弃/转移职责的方法，并保留注释
  /*
  /// [已废弃]
  void dispose() {
    // 逻辑已移至 ref.onDispose
  }
  
  /// [职责转移]
  Future<void> setDisplayMode(String mode) async {
    final displayMode = DisplayMode.values.byName(mode);
  }

  /// [职责转移]
  void setPixelRatio(double ratio) {
  }
  
  /// [职责转移]
  DisplayModeHandler get displayModeHandler {
     return ref.read(displayModeHandlerProvider.notifier);
  }
  */
}