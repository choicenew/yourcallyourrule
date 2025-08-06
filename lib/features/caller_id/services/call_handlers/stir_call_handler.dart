import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';

import 'base_call_handler.dart';


/// STIR验证处理器
/// 负责处理与STIR验证相关的方法调用
class StirCallHandler extends BaseCallHandler {
  StirInfo? stirInfo;
  final Function(StirInfo) _onStirInfoUpdated;

  StirCallHandler(this._onStirInfoUpdated);

  @override
  dynamic handleMethodCall(MethodCall call) {
    switch (call.method) {
      case "onStirInitializationComplete":
        return _handleInitializationComplete();
      case "onStirResult":
        return _handleStirResult(
          call.arguments['isVerified'],
          call.arguments['isNotVerified'],
          call.arguments['isFailed'],
          call.arguments['phoneNumber'],
        );
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  void _handleInitializationComplete() {
    // STIR 初始化完成，可以在这里进行一些初始化操作（可选）
  }

  /// 处理STIR验证结果
  void _handleStirResult(
    dynamic isVerified,
    dynamic isNotVerified,
    dynamic isFailed,
    dynamic phoneNumber,
  ) {
    // 安全地转换类型并提供默认值
    final bool verified = isVerified is bool ? isVerified : false;
    final bool notVerified = isNotVerified is bool ? isNotVerified : false;
    final bool failed = isFailed is bool ? isFailed : false;
    final String? phoneNum = phoneNumber is String ? phoneNumber : null;

    // 存储 STIR 信息
    stirInfo = StirInfo(
      isVerified: verified,
      isNotVerified: notVerified,
      isFailed: failed,
      phoneNumber: phoneNum,
    );

    // 通知监听器
    _onStirInfoUpdated(stirInfo!);

    // 如果 STIR 验证失败，可以在这里执行拦截操作
    if (isFailed) {
      // ... 执行拦截操作 ...
    }
  }

  /// 获取当前STIR信息
  StirInfo? getStirInfo() {
    return stirInfo;
  }

  /// 获取指定号码的STIR信息
  StirInfo? getStirInfoForNumber(String phoneNumber) {
    if (stirInfo != null && stirInfo!.phoneNumber == phoneNumber) {
      return stirInfo;
    }
    return null;
  }
}