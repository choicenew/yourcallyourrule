import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';


/// 翻译电话号码类型为本地化字符串
String translatePhoneNumberType(PhoneNumberType type, BuildContext context) {
  switch (type) {
    case PhoneNumberType.fixedLine:
      return AppLocalizations.of(context)!.phoneNumberTypeFixedLine;
    case PhoneNumberType.mobile:
      return AppLocalizations.of(context)!.phoneNumberTypeMobile;
    case PhoneNumberType.fixedLineOrMobile:
      return AppLocalizations.of(context)!.phoneNumberTypeFixedLineOrMobile;
    case PhoneNumberType.tollFree:
      return AppLocalizations.of(context)!.phoneNumberTypeTollFree;
    case PhoneNumberType.premiumRate:
      return AppLocalizations.of(context)!.phoneNumberTypePremiumRate;
    case PhoneNumberType.sharedCost:
      return AppLocalizations.of(context)!.phoneNumberTypeSharedCost;
    case PhoneNumberType.voip:
      return AppLocalizations.of(context)!.phoneNumberTypeVoip;
    case PhoneNumberType.personalNumber:
      return AppLocalizations.of(context)!.phoneNumberTypePersonalNumber;
    case PhoneNumberType.pager:
      return AppLocalizations.of(context)!.phoneNumberTypePager;
    case PhoneNumberType.uan:
      return AppLocalizations.of(context)!.phoneNumberTypeUan;
    case PhoneNumberType.voicemail:
      return AppLocalizations.of(context)!.phoneNumberTypeVoicemail;
    default:
      return AppLocalizations.of(context)!.phoneNumberTypeUnknown;
  }
}