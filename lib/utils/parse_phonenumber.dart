import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart' as flutter;

// 提取公共的电话号码解析逻辑
Future<Map<String, String>> _parsePhoneNumber(
    String phoneNumber, String? simCountryCode) async {
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

  // 判断号码是否包含国际区号
  RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

  if (internationalPrefixRegex.hasMatch(phoneNumber)) {
    // 包含国际区号， 使用 null 解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      //print('Failed to parse with null: $e');
      // 可以添加额外的错误处理
    }
  } else if (simCountryCode != null) {
    // 使用指定的 SIM 卡国家代码解析
    try {
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
      // 验证解析结果
      String? parsedCountryCode =
          phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      // 添加 national_number 的验证
      if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase() &&
          phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber) ==
              phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '')) {
        countryCode = simCountryCode; // 解析成功，记录国家代码
        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(
            parsedPhoneNumber, PhoneNumberFormat.national);
      }
    } catch (e) {
      //print('Failed to parse with country code $simCountryCode: $e');
    }
  } else {
    // 不包含国际区号， 使用 SIM 卡国家代码循环解析
    final simCardInfoPlugin = SimCardInfo();
    List<flutter.SimInfo> simInfoList =
        await simCardInfoPlugin.getSimInfo() ?? [];
    List<String> simCountryCodes =
        simInfoList.map((sim) => sim.countryIso).toList();

    for (String simCountryCode in simCountryCodes) {
      try {
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
        // 验证解析结果
        String? parsedCountryCode =
            phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        // 添加 national_number 的验证
        if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase() &&
            phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber) ==
                phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '')) {
          countryCode = simCountryCode; // 解析成功，记录国家代码
          e164Number =
              phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
          nationalNumber = phoneNumberUtil.format(
              parsedPhoneNumber, PhoneNumberFormat.national);
          break;
        }
      } catch (e) {
        //
      }
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}

Future<Map<String, String>> parsePhoneNumber(String phoneNumber) async {
  return _parsePhoneNumber(phoneNumber, null);
}

Future<Map<String, String>> parsePhoneNumberWithoutIso(
    String phoneNumber, String? countryCode) async {
  return _parsePhoneNumber(phoneNumber, null); // 不使用 countryCode 参数
}

Future<Map<String, String>> parsePhoneNumberWithIso(
    String phoneNumber, String simCountryCode) async {
  return _parsePhoneNumber(phoneNumber, simCountryCode);
}
