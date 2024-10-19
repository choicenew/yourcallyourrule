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
   
    e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
    nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
  }

  try {
    if (phoneNumber.startsWith('+')) {
      // Handle international numbers starting with '+'
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      parseAndFormat(parsedPhoneNumber);
    } else if (phoneNumber.startsWith('00')) {
      // Handle international numbers starting with '00'
      String modifiedPhoneNumber = '+${phoneNumber.substring(2)}';
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(modifiedPhoneNumber, null);
      parseAndFormat(parsedPhoneNumber);
    } else {
      // Handle local numbers using SIM country code or available SIM information
      if (simCountryCode != null) {
        PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
        parseAndFormat(parsedPhoneNumber);
      } else {
        // If no SIM country code provided, try to get it from the device
        final simCardInfoPlugin = SimCardInfo();
        List<flutter.SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
        List<String> simCountryCodes = simInfoList.map((sim) => sim.countryIso).toList();

        for (String code in simCountryCodes) {
          try {
            PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, code.toUpperCase());
            parseAndFormat(parsedPhoneNumber);
            break;
          } catch (e) {
            print('Failed to parse with country code $code: $e');
          }
        }
      }
    }
  } catch (e) {
    print('Failed to parse phone number: $e');
  }
 print("解析后的号码,de $e164Number de $nationalNumber $countryCode"); 
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
  return _parsePhoneNumber(phoneNumber, null);
}

Future<Map<String, String>> parsePhoneNumberWithIso(
    String phoneNumber, String simCountryCode) async {
  return _parsePhoneNumber(phoneNumber, simCountryCode);
}