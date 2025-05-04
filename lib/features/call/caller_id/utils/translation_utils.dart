import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';

import 'package:yourcallyourrule/generated/l10n.dart';

/// 翻译电话号码类型为本地化字符串
/// 
/// [type] 电话号码类型枚举
/// [context] 构建上下文，用于获取本地化资源
/// 返回本地化的电话号码类型字符串
String translatePhoneNumberType(PhoneNumberType type, BuildContext context) {
  switch (type) {
    case PhoneNumberType.fixedLine:
      return S.of(context).phoneNumberTypeFixedLine; 
    case PhoneNumberType.mobile:
      return S.of(context).phoneNumberTypeMobile;
    case PhoneNumberType.fixedLineOrMobile:
      return S.of(context).phoneNumberTypeFixedLineOrMobile;
    case PhoneNumberType.tollFree:
      return S.of(context).phoneNumberTypeTollFree;
    case PhoneNumberType.premiumRate:
      return S.of(context).phoneNumberTypePremiumRate;
    case PhoneNumberType.sharedCost:
      return S.of(context).phoneNumberTypeSharedCost;
    case PhoneNumberType.voip:
      return S.of(context).phoneNumberTypeVoip;
    case PhoneNumberType.personalNumber:
      return S.of(context).phoneNumberTypePpersonalNumber;
    case PhoneNumberType.pager:
      return S.of(context).phoneNumberTypePager;
    case PhoneNumberType.uan:
      return S.of(context).phoneNumberTypeUan;
    case PhoneNumberType.voicemail:
      return S.of(context).phoneNumberTypeVoicemail;
    case PhoneNumberType.unknown:
      return S.of(context).phoneNumberTypeUnknown; 
    default:
      return S.of(context).phoneNumberTypeUnknown; 
  }
}