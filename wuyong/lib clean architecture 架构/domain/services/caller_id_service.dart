import 'dart:async';
import '../entities/caller/caller_id_data.dart';
import '../value_objects/phone_number.dart';

/// 来电识别服务接口
/// 定义来电识别的核心业务逻辑
abstract class CallerIdService {
  /// 获取来电显示数据
  Future<CallerIdData> getCallerId(PhoneNumber phoneNumber, String locale);
  
  /// 获取来电显示数据流
  Stream<CallerIdData> get callerIdStream;
  
  /// 更新来电显示数据
  void updateCallerIdData(CallerIdData data);
  
  /// 检查号码是否应该被阻止
  Future<bool> shouldBlockNumber(PhoneNumber phoneNumber);
  
  /// 保存来电显示数据到缓存
  Future<void> saveCallerIdDataToCache(PhoneNumber phoneNumber, CallerIdData data);
  
  /// 从缓存获取来电显示数据
  Future<CallerIdData?> getCallerIdDataFromCache(PhoneNumber phoneNumber);
  
  /// 获取号码的格式化版本(E164和国家格式)
  Future<Map<String, String>> getFormattedNumbers(PhoneNumber phoneNumber, String locale);
  
  /// 获取号码的位置信息
  Future<String?> getLocationForNumber(PhoneNumber phoneNumber, String locale);
  
  /// 获取号码的运营商信息
  Future<String?> getCarrierForNumber(PhoneNumber phoneNumber, String locale);
}