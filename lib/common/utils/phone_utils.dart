import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart' as flutter;

/// 电话号码工具类
class PhoneUtils {
  const PhoneUtils._();

  /// 解析电话号码
  static Future<Map<String, String>> parsePhoneNumber(String phoneNumber) async {
    return _parsePhoneNumber(phoneNumber, null);
  }

  /// 使用指定国家代码解析电话号码
  static Future<Map<String, String>> parsePhoneNumberWithIso(
      String phoneNumber, String simCountryCode) async {
    return _parsePhoneNumber(phoneNumber, simCountryCode);
  }

  /// 不使用国家代码解析电话号码
  static Future<Map<String, String>> parsePhoneNumberWithoutIso(
      String phoneNumber, String? countryCode) async {
    return _parsePhoneNumber(phoneNumber, null);
  }

  /// 内部电话号码解析方法
  static Future<Map<String, String>> _parsePhoneNumber(
      String phoneNumber, String? simCountryCode) async {
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    String? countryCode;
    String e164Number = "";
    String nationalNumber = "";

    void parseAndFormat(PhoneNumber parsedPhoneNumber) {
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    }

    try {
      if (phoneNumber.startsWith('+')) {
        PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
        parseAndFormat(parsedPhoneNumber);
      } else if (phoneNumber.startsWith('00')) {
        String modifiedPhoneNumber = '+${phoneNumber.substring(2)}';
        PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(modifiedPhoneNumber, null);
        parseAndFormat(parsedPhoneNumber);
      } else {
        if (simCountryCode != null) {
          PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
          parseAndFormat(parsedPhoneNumber);
        } else {
          final simCardInfoPlugin = SimCardInfo();
          List<flutter.SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
          List<String> simCountryCodes = simInfoList.map((sim) => sim.countryIso).toList();

          for (String code in simCountryCodes) {
            try {
              PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, code.toUpperCase());
              String? parsedCountryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
              bool isValid = phoneNumberUtil.isValidNumber(parsedPhoneNumber);
              String nationalSignificant = phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber);
              String cleanedInput = phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '');
              String nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
              String cleanedNational = nationalNumber.replaceAll(RegExp(r'[^0-9]+'), '');

              if (isValid && 
                  parsedCountryCode?.toUpperCase() == code.toUpperCase() &&
                  cleanedNational == cleanedInput) {
                parseAndFormat(parsedPhoneNumber);
                break;
              } 
            } catch (e) {
              // 解析失败，尝试下一个国家代码
            }
          }
        }
      }
    } catch (e) {
      // 电话号码解析失败
    }

    return {
      'countryCode': countryCode ?? '',
      'e164Number': e164Number,
      'nationalNumber': nationalNumber,
    };
  }
}