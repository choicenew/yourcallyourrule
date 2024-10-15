import 'dart:async';



import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:call_log/call_log.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart' as flutter;

import '../services/caller_id_monitor_service.dart';


// 提取公共的电话号码解析逻辑
Future<Map<String, String>> parsePhoneNumber(String phoneNumber) async {
  // 1. 初始化 sim_card_info 插件
  final simCardInfoPlugin = SimCardInfo();

  // 2. 获取 SIM 卡信息
  List<flutter.SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
  List<String> simCountryCodes =
      simInfoList.map((sim) => sim.countryIso).toList();
 print('SIM Country ISO: ${simCountryCodes}');
 print(simCountryCodes.join(', '));

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
  } 
  
  else {
    // 不包含国际区号， 使用 SIM 卡国家代码循环解析
    for (String simCountryCode in simCountryCodes) {
    try {
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
      print('解析后的号码$parsedPhoneNumber');       
      // 验证解析结果
      String? parsedCountryCode =
          phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      // 添加 national_number 的验证
      if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase() &&
          phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber) == 
              phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '')) { 
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
/*
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
      */
    }

  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}

Future<Map<String, String>> parsePhoneNumberWithoutIso(String phoneNumber, String? countryCode) async {
  // 1. 初始化 sim_card_info 插件
  final simCardInfoPlugin = SimCardInfo();

  // 2. 获取 SIM 卡信息
  List<flutter.SimInfo> simInfoList = await simCardInfoPlugin.getSimInfo() ?? [];
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
          phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
      print('解析后的号码$parsedPhoneNumber');       
      // 验证解析结果
      String? parsedCountryCode =
          phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      // 添加 national_number 的验证
      if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase() &&
          phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber) == 
              phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '')) { 
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
/*
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
      */
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}

Future<Map<String, String>> parsePhoneNumberWithIso(String phoneNumber, String simCountryCode) async {
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

      countryCode = simCountryCode; // 使用 SIM 卡国家代码
  // 判断号码是否包含国际区号
  RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

  if (internationalPrefixRegex.hasMatch(phoneNumber)) {
    // 包含国际区号，使用 null 解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with null: $e');
    }
  } else {
    // 不包含国际区号，使用 SIM 卡国家代码解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
// 验证解析结果
      String? parsedCountryCode =
          phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      // 添加 national_number 的验证
      if (parsedCountryCode?.toUpperCase() == simCountryCode.toUpperCase() &&
          phoneNumberUtil.getNationalSignificantNumber(parsedPhoneNumber) == 
              phoneNumber.replaceAll(RegExp(r'[^0-9]+'), '')) { 
        countryCode = simCountryCode; // 解析成功，记录国家代码
        e164Number = phoneNumberUtil.format(
            parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(
            parsedPhoneNumber, PhoneNumberFormat.national);
    
      }
    } catch (e) {
      print('Failed to parse with country code $simCountryCode: $e');
/*
      // 如果使用 SIM 卡国家代码解析失败，尝试添加国际区号
      try {
        int? numericCountryCode = phoneNumberUtil.getCountryCodeForRegion(simCountryCode.toUpperCase());
        String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
        PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(fullPhoneNumber, null);
        countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      } catch (e) {
        print('Failed to parse with added country code: $e');
      }
      */
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}


/*
Future<Map<String, String>> parseCallLogPhoneNumber(CallLogEntry entry) async {
  // 直接使用 entry.simCountryIso
  String simCountryCode = entry.simCountryIso ?? '';
print('打印calllog插件的Number: ${entry.phoneAccountId}, SIM Display Name: ${entry.simDisplayName}');
 print('SIM Country ISO: ${entry.simCountryIso}');
  print('MCC Country ISO: ${entry.mcc}');
  // 尝试解析号码
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

  String phoneNumber = entry.number ?? ''; // 从 entry 中获取电话号码

  // 判断号码是否包含国际区号
  RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

  if (internationalPrefixRegex.hasMatch(phoneNumber)) {
    // 包含国际区号，使用 null 解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(
          parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with null: $e');
    }
  } else {
    // 不包含国际区号，使用 SIM 卡国家代码解析
    try {
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(phoneNumber, simCountryCode.toUpperCase());
      countryCode = simCountryCode; // 使用 SIM 卡国家代码
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with country code $simCountryCode: $e');

      // 如果使用 SIM 卡国家代码解析失败，尝试添加国际区号
      try {
        int? numericCountryCode =
            phoneNumberUtil.getCountryCodeForRegion(simCountryCode);
        String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(fullPhoneNumber, null);
        countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      } catch (e) {
        print('Failed to parse with added country code: $e');
      }
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}
*/
/*
// 提取公共的电话号码解析逻辑
Future<Map<String, String>> parseCallPhoneNumber(String phoneNumber, SimInfo? simInfo) async {
   // 直接使用 simCountryIso
  String simCountryCode = simInfo?.countryIso ?? '';
  
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

 // 判断号码是否包含国际区号
  RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

  if (internationalPrefixRegex.hasMatch(phoneNumber)) {
    // 包含国际区号，使用 null 解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(
          parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with null: $e');
    }
  } else {
    // 不包含国际区号，使用 SIM 卡国家代码解析
    try {
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(phoneNumber, simCountryCode);
      countryCode = simCountryCode; // 使用 SIM 卡国家代码
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with country code $simCountryCode: $e');

      // 如果使用 SIM 卡国家代码解析失败，尝试添加国际区号
      try {
        int? numericCountryCode =
            phoneNumberUtil.getCountryCodeForRegion(simCountryCode);
        String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
        PhoneNumber parsedPhoneNumber =
            phoneNumberUtil.parse(fullPhoneNumber, null);
        countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        e164Number =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber =
            phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      } catch (e) {
        print('Failed to parse with added country code: $e');
      }
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}
*/
/*
// 私有函数，提取公共的解析逻辑
Future<Map<String, String>> _parsePhoneNumber(String phoneNumber, String simCountryCode) async {
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  String? countryCode;
  String e164Number = "";
  String nationalNumber = "";

  // 判断号码是否包含国际区号
  RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');

  if (internationalPrefixRegex.hasMatch(phoneNumber)) {
    // 包含国际区号，使用 null 解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with null: $e');
    }
  } else {
    // 不包含国际区号，使用 SIM 卡国家代码解析
    try {
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, simCountryCode);
      countryCode = simCountryCode; // 使用 SIM 卡国家代码
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } catch (e) {
      print('Failed to parse with country code $simCountryCode: $e');

      // 如果使用 SIM 卡国家代码解析失败，尝试添加国际区号
      try {
        int? numericCountryCode = phoneNumberUtil.getCountryCodeForRegion(simCountryCode);
        String fullPhoneNumber = '+$numericCountryCode$phoneNumber';
        PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(fullPhoneNumber, null);
        countryCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
        e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
        nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
      } catch (e) {
        print('Failed to parse with added country code: $e');
      }
    }
  }

  return {
    'countryCode': countryCode ?? '',
    'e164Number': e164Number,
    'nationalNumber': nationalNumber,
  };
}

// 公共函数，接受 CallLogEntry 参数
Future<Map<String, String>> parseCallLogPhoneNumber(CallLogEntry entry) async {
  String simCountryCode = entry.simCountryIso ?? '';
   String phoneNumber = entry.number ?? ''; // 从 entry 中获取电话号码
  return _parsePhoneNumber(phoneNumber, simCountryCode);
}

// 公共函数，接受 String 参数
Future<Map<String, String>> parseCallPhoneNumber(String phoneNumber, SimInfo? simInfo) async {
  String simCountryCode = simInfo?.countryIso ?? '';
   print("CallerIdMonitorService: 收到 call: ${simInfo?.countryIso}");

  return _parsePhoneNumber(phoneNumber, simCountryCode);
}
*/