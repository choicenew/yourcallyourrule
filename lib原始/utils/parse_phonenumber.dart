import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart' as flutter;

Future<Map<String, String>> _parsePhoneNumber(
    String phoneNumber, String? simCountryCode) async {
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

  // Function to parse and format the phone number
  void parseAndFormat(PhoneNumber parsedPhoneNumber) {
    countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);

    e164Number =
        phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
    nationalNumber =
        phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
  }

  try {
    if (phoneNumber.startsWith('+')) {
      // Handle international numbers starting with '+'
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      parseAndFormat(parsedPhoneNumber);
    } else if (phoneNumber.startsWith('00')) {
      // Handle international numbers starting with '00'
      String modifiedPhoneNumber = '+${phoneNumber.substring(2)}';
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(modifiedPhoneNumber, null);
      parseAndFormat(parsedPhoneNumber);
    } else {
      // Handle local numbers using SIM country code or available SIM information
      if (simCountryCode != null) {
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
        parseAndFormat(parsedPhoneNumber);
      } else {
        // If no SIM country code provided, try to get it from the device
        final simCardInfoPlugin = SimCardInfo();
        List<flutter.SimInfo> simInfoList =
            await simCardInfoPlugin.getSimInfo() ?? [];
        List<String> simCountryCodes =
            simInfoList.map((sim) => sim.countryIso).toList();

        for (String code in simCountryCodes) {
          try {
            PhoneNumber parsedPhoneNumber =
                phoneNumberUtil.parse(phoneNumber, code.toUpperCase());

            String? parsedCountryCode =
                phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);

            bool isValid = phoneNumberUtil.isValidNumber(parsedPhoneNumber);
            String nationalSignificant =
                phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber);
            String cleanedInput =
                phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '');
            String nationalNumber = phoneNumberUtil.format(
                parsedPhoneNumber, PhoneNumberFormat.national);
            // 去除 national 中的非数字字符
            String cleanedNational =
                nationalNumber.replaceAll(RegExp(r'[^0-9]+'), '');

            // 添加 national_number 的验证 1验证是否有效，2验证code是否match，3验证号码是否一致，三个不可以缺少任何一个
            if (isValid &&
                parsedCountryCode?.toUpperCase() == code.toUpperCase() &&
                cleanedNational == cleanedInput) {
              parseAndFormat(parsedPhoneNumber);
              break;
            }
          } catch (e) {
            //print('Failed to parse with country code $code: $e');
          }
        }
      }
    }
  } catch (e) {
    //print('Failed to parse phone number: $e');
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
