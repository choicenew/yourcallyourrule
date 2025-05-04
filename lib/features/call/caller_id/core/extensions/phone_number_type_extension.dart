import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';

import '../../utils/translation_utils.dart';

/// 电话号码类型扩展
/// 提供将PhoneNumberType枚举翻译为本地化字符串的功能
extension PhoneNumberTypeExtension on PhoneNumberType {
  /// 将电话号码类型翻译为当前语言环境的字符串
  String translated(BuildContext context) {
    return translatePhoneNumberType(this, context);
  }
}