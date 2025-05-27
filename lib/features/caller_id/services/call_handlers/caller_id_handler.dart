//import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:dlibphonenumber/locale.dart' as dlibphone;

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/caller_id_service.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';




/// 通话处理器
/// 负责处理通话的核心逻辑，包括号码解析和来电显示信息获取
class CallHandler {
  final CallerIdService _callerIdService;
  final OverlayHandler _overlayHandler;
  final LocaleProvider _localeProvider;
  
  // 状态数据
  StirInfo? stirInfo;
  SimInfo? simInfo;

  /// 构造函数
  CallHandler({
    required CallerIdService callerIdService,
    required LocaleProvider localeProvider,
    OverlayHandler? overlayHandler,
  }) : 
    _callerIdService = callerIdService,
    _localeProvider = localeProvider,
    _overlayHandler = overlayHandler ?? OverlayHandler();

  /// 处理通话的公共方法
  Future<CallData> handleCall(String phoneNumber) async {
    // 使用存储的 STIR 信息 (如果 phoneNumber 匹配)
    StirInfo? stirInfoToUse =
        stirInfo != null && stirInfo!.phoneNumber == phoneNumber
            ? stirInfo
            : null;

    // 使用存储的 SIM 信息 (如果 phoneNumber 匹配)
    SimInfo? simInfoToUse =
        simInfo != null && simInfo?.phoneNumber == phoneNumber ? simInfo : null;

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
          id: '',
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
    final languageCode = _localeProvider.locale.languageCode;

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
    
    // 显示来电显示浮窗
    await _overlayHandler.showCallerIdOverlay(callerIdData, stirInfo, simInfo);

    // 创建 CallData 对象
    CallData callData = CallData(
      callerIdData: callerIdData,
      e164Number: e164Number,
      nationalNumber: nationalNumber,
      stirInfo: stirInfoToUse,
      simInfo: simInfoToUse,
    );

    // 将 CallData 插入数据库或缓存或者calllog中
    await saveCallerIdDataToCache(phoneNumber, callData);

    // 返回 CallData 对象
    return callData;
  }

  /// 关闭浮窗
  void closeOverlay() {
    _overlayHandler.closeOverlay();
  }

  /// 保存来电显示数据到缓存
  Future<void> saveCallerIdDataToCache(
      String phoneNumber, CallData callData) async {
    // 实现缓存逻辑
  }

  /// 设置STIR信息
  void setStirInfo(StirInfo info) {
    stirInfo = info;
  }

  /// 设置SIM卡信息
  void setSimInfo(SimInfo info) {
    simInfo = info;
  }
  
  /// 设置像素比例
  void setPixelRatio(double ratio) {
    _overlayHandler.setPixelRatio(ratio);
  }
}