import 'dart:async';
import 'package:flutter/material.dart';

import '../lib clean architecture 架构/domain/entities/caller/caller_id_data.dart';

/// 来电显示服务接口
abstract class ICallerIdService {
  /// 获取来电显示数据流
  Stream<CallerIdData> get callerIdStream;
  
  /// 根据电话号码获取来电显示数据
  /// 
  /// [phoneNumber] 电话号码
  /// [locale] 区域设置，用于确定国家代码
  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale);
  
  /// 初始化服务
  Future<void> initialize();
  
  /// 关闭服务
  Future<void> dispose();
}