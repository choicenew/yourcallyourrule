import 'dart:async';

import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

import 'package:dlibphonenumber/dlibphonenumber.dart';



// 提取公共的电话号码解析逻辑
Future<Map<String, String>> parsePhoneNumber(String phoneNumber) async {
  // 1. 初始化 sim_card_info 插件
  final simCardInfoPlugin = SimCardInfo();

  // 2. 获取 SIM 卡信息
  List<SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
  List<String> simCountryCodes =
      simInfoList.map((sim) => sim.countryIso).toList();

  // 3. 尝试解析号码
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
      nationalNumber = phoneNumberUtil.format(
          parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with null: $e');
      // 可以添加额外的错误处理
    }
  } else {
    // 不包含国际区号， 使用 SIM 卡国家代码循环解析
    for (String simCountryCode in simCountryCodes) {
      try {
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(phoneNumber, simCountryCode);
        // 验证解析结果
        String? parsedCountryCode =
            phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase()) {
          countryCode = simCountryCode; // 解析成功，记录国家代码
          e164Number = phoneNumberUtil.format(
              parsedPhoneNumber, PhoneNumberFormat.e164);
          nationalNumber = phoneNumberUtil.format(
              parsedPhoneNumber, PhoneNumberFormat.national);
          break;
        }
      } catch (e) {
        print('Failed to parse with country code $simCountryCode: $e');
      }

      //3 特殊尝试添加国际区号到手机号码
      try {
        //  如果直接解析失败，尝试添加国家代码
        // 使用 getCountryCodeForRegion 获取数字国家代码
        int? numericCountryCode = phoneNumberUtil
            .getCountryCodeForRegion(simCountryCode.toUpperCase());

        String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(fullPhoneNumber, null);

        // 验证解析结果
        String? parsedCountryCode =
            phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase()) {
          countryCode = simCountryCode; // 解析成功，记录国家代码
          e164Number = phoneNumberUtil.format(
              parsedPhoneNumber, PhoneNumberFormat.e164);
          nationalNumber = phoneNumberUtil.format(
              parsedPhoneNumber, PhoneNumberFormat.national);
          break;
        }
      } catch (e) {
        // 可以添加额外的错误处理
      }
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}