import 'dart:async';
import 'dart:isolate';

import 'package:dlibphonenumber/dlibphonenumber.dart';
// import 'package:sim_card_info/sim_card_info.dart';
// import 'package:sim_card_info/sim_info.dart' as flutter;
import 'package:sim_reader/sim_reader.dart';


import 'package:yourcallyourrule/common/error/logger.dart';

/// 电话号码工具类，提供电话号码解析和格式化功能
class PhoneUtils {
  /// 解析电话号码，返回国家代码、E164格式和国内格式
  static Future<Map<String, String>> parsePhoneNumber(
      String phoneNumber) async {
    return _parsePhoneNumber(phoneNumber, null);
  }

  /// 解析电话号码（不使用ISO国家代码）
  static Future<Map<String, String>> parsePhoneNumberWithoutIso(
      String phoneNumber, String? countryCode) async {
    return _parsePhoneNumber(phoneNumber, null); // 不使用 countryCode 参数
  }

  /// 解析电话号码（使用ISO国家代码）
  static Future<Map<String, String>> parsePhoneNumberWithIso(
      String phoneNumber, String simCountryCode) async {
    return _parsePhoneNumber(phoneNumber, simCountryCode);
  }

  /// 内部解析电话号码的方法
  static Future<Map<String, String>> _parsePhoneNumber(
      String phoneNumber, String? simCountryCode) async {
    List<String> simCountryCodes = [];

    // 如果没有提供SIM国家代码，且不是国际号码，在主线程尝试从设备获取
    if (simCountryCode == null && !phoneNumber.startsWith('+') && !phoneNumber.startsWith('00')) {
      try {
        // final simCardInfoPlugin = SimCardInfo(); // 原代码
        // List<flutter.SimInfo> simInfoList =
        //     await simCardInfoPlugin.getSimInfo() ?? []; // 原代码
        List<SimInfo> simInfoList = await SimReader.getAllSimInfo(); // 替换后的代码

        // List<String> simCountryCodes =
        //     simInfoList.map((sim) => sim.countryIso).toList(); // 原代码
        simCountryCodes = 
            simInfoList.map((sim) => sim.countryCode ?? '')
                       .where((code) => code.isNotEmpty)
                       .toList(); // 替换后的代码
      } catch (e) {
        AppLogger.error('获取SIM信息失败', e);
      }
    }

    try {
      return await Isolate.run(() => _parsePhoneNumberSync(phoneNumber, simCountryCode, simCountryCodes));
    } catch (e) {
      AppLogger.error('电话号码解析失败', e);
      return {
        'countryCode': '',
        'e164Number': '',
        'nationalNumber': '',
      };
    }
  }

  /// 内部解析电话号码的同步计算逻辑（在后台 Isolate 中运行）
  static Map<String, String> _parsePhoneNumberSync(
      String phoneNumber, String? simCountryCode, List<String> simCountryCodes) {
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    String? countryCode;
    String e164Number = "";
    String nationalNumber = "";

    // 解析和格式化电话号码的函数
    void parseAndFormat(PhoneNumber parsedPhoneNumber) {
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    }

    try {
      if (phoneNumber.startsWith('+')) {
        // 处理以'+'开头的国际号码
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(phoneNumber, null);
        parseAndFormat(parsedPhoneNumber);
      } else if (phoneNumber.startsWith('00')) {
        // 处理以'00'开头的国际号码
        String modifiedPhoneNumber = '+${phoneNumber.substring(2)}';
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(modifiedPhoneNumber, null);
        parseAndFormat(parsedPhoneNumber);
      } else {
        // 处理本地号码，使用SIM卡国家代码或可用的SIM信息
        if (simCountryCode != null) {
          PhoneNumber parsedPhoneNumber =
              phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
          parseAndFormat(parsedPhoneNumber);
        } else {
          for (String code in simCountryCodes) {
            try {
              PhoneNumber parsedPhoneNumber =
                  phoneNumberUtil.parse(phoneNumber, code.toUpperCase());
              String? parsedCountryCode =
                  phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
              bool isValid = phoneNumberUtil.isValidNumber(parsedPhoneNumber);
              String nationalSignificant = phoneNumberUtil
                  .getNationalSignificantNumber(parsedPhoneNumber);
              String cleanedInput =
                  phoneNumber.replaceAll(RegExp(r'[^0-g-z]+'), '');
              String nationalNumber = phoneNumberUtil.format(
                  parsedPhoneNumber, PhoneNumberFormat.national);
              // 去除 national 中的非数字字符
              String cleanedNational =
                  nationalNumber.replaceAll(RegExp(r'[^0-9]+'), '');

              // 验证号码：1.验证是否有效，2.验证code是否匹配，3.验证号码是否一致
              if (isValid &&
                  parsedCountryCode?.toUpperCase() == code.toUpperCase() &&
                  cleanedNational == cleanedInput) {
                parseAndFormat(parsedPhoneNumber);
                break;
              }
            } catch (e) {
              AppLogger.error('invalid_country_code', e);
            }
          }
        }
      }
    } catch (e) {
      AppLogger.error('电话号码解析失败', e);
     
     
     
     
    }

    return {
      'countryCode': countryCode ?? '',
      'e164Number': e164Number,
      'nationalNumber': nationalNumber,
    };
  }
}