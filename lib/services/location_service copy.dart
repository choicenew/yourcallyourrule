
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:dlibphonenumber/dlibphonenumber.dart';




Database? _database;
Future<Database> get database async {
  if (_database != null) return _database!;

  _database = await _initDatabase();
  return _database!;
}

Future<Database> _initDatabase() async {
  final String path = join(await getDatabasesPath(), 'call_rule_database.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: createDatabase,
  );
}

Future<void> createDatabase(Database database, int version) async {
  if (version == 1) {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS location_data (
        phoneNumber TEXT NOT NULL,        
        region TEXT,
        countryName TEXT,
        carrier TEXT,
        numberType TEXT NOT NULL
      )
    ''');
  }
}

// 来电号码归属地数据模型
class LocationData {
  final String phoneNumber;
  String? region;
  String? countryName;
  String? carrier;
  PhoneNumberType numberType;
  //bool isLocalNumber;

  LocationData({
    required this.phoneNumber,
    this.region,
    this.countryName,
    this.carrier,
    required this.numberType,
   // required this.isLocalNumber,
  });

  // 将数据模型转换为 Map
  Map<String, dynamic> toMap() {
    return {
      //'phoneNumber': phoneNumber, 
      'phoneNumber': phoneNumber.toString(), // 将 phoneNumber 转换为 String 类型     
      'region': region,
      'countryName': countryName,
      'carrier': carrier,
      //'numberType': numberType.toString(),
            'numberType': numberType.index,
     // 'isLocalNumber': isLocalNumber ? 1 : 0,

    };
  }
/*
  // 从 Map 中创建数据模型
  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      phoneNumber: map['phoneNumber'],
      region: map['region'],
      countryName: map['countryName'],
      carrier: map['carrier'],
      numberType: PhoneNumberType.values[map['numberType']],
     //isLocalNumber: map['isLocalNumber'] == 1,

    );
  }

  */

    factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      phoneNumber: map['phoneNumber'] as String, // 使用 String 类型
      region: map['region'] as String?, // 添加类型转换和空值检查
      countryName: map['countryName'] as String?, // 添加类型转换和空值检查
      carrier: map['carrier'] as String?, // 添加类型转换和空值检查
      //numberType: PhoneNumberType.values[map['numberType']],
      numberType: PhoneNumberType.values[int.parse(map['numberType'])],
    );
  }
}
class LocationService {
  final Database database;

  LocationService(this.database);

  // 插入数据
  Future<void> insertLocationData(LocationData locationData) async {
    await database.insert('location_data', locationData.toMap());
  }

  // 更新数据
  Future<void> updateLocationData(LocationData locationData) async {
    await database.update('location_data', locationData.toMap(),
        where: 'phoneNumber = ?', whereArgs: [locationData.phoneNumber]);
  }

  // 查询数据
  Future<List<LocationData>> getLocationData() async {
    List<Map<String, dynamic>> maps = await database.query('location_data');
    return maps.map((map) => LocationData.fromMap(map)).toList();
  }

  // 删除数据
// 删除数据
  Future<void> deleteLocationData(LocationData locationData) async {
    await database.delete(
      'location_data',
      where: 'phoneNumber = ?',
      whereArgs: [locationData.phoneNumber],
    );
  }
/*
Future<LocationData?> getLocationDataByPhoneNumber(String phoneNumber) async {
  List<Map<String, dynamic>> maps = await database
      .query('location_data', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
  if (maps.isEmpty) {
    // 返回一个空的 LocationData 对象
    return LocationData(
      phoneNumber: phoneNumber,
      region: null,
      countryName: null,
      carrier: null,
      numberType: PhoneNumberType.unknown, // 使用默认值
    );
  }
  return LocationData.fromMap(maps.first);
}

*/
  // 根据电话号码查询数据
  Future<LocationData?> getLocationDataByPhoneNumber(String phoneNumber) async {
    List<Map<String, dynamic>> maps = await database
        .query('location_data', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    if (maps.isEmpty) {
      return null;
    }
    return LocationData.fromMap(maps.first);
  }

  // 从phonenumber获取国家
  Future<String?> getCountryCodeFromPhoneNumber(String phoneNumber) async {
    // 使用 PhoneNumberUtil 库获取归属地
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    // 解析电话号码
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

    // 检查电话号码是否有效
    if (phoneNumberUtil.isValidNumber(parsedPhoneNumber)) {
      // 获取国家/地区代码
      String? regionCode =
          phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
      return regionCode;
    } else {
      // 返回 null 表示无效电话号码
      return null;
    }
  }
 // 在这里获取当前的语言环境


/*
void localeLanguageFunction(BuildContext context) {
  // 在这里获取当前的语言环境
 // 调用 localeLanguage 函数来获取当前的语言环境

  LocaleLanguageService localeLanguageService = LocaleLanguageService();
  Locale locale = localeLanguageService.getCurrentLocale(context) as Locale;

  // 直接打印当前的语言环境
    print('Locale: ${locale.toString()}');

}*/

  // 获取来电号码的归属地
String? getCountryNameFromPhoneNumber(String phoneNumber, Locale locale) {
  // Parse phone number using libphonenumber
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

  // Check if number is valid
  if (!phoneNumberUtil.isValidNumber(parsedPhoneNumber)) {
    return null; // Handle invalid phone number
  }

  // Get region code for the number
  //String? regionCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);

  // Get country name using Locale
  String? countryName = locale.getDisplayCountry(Locale(country: locale.country, language: locale.language));

  return countryName;
}





  // 获取来电号码的归属地
  Future<String?> getRegionFromPhoneNumber(
      String phoneNumber, Locale locale) async {
    // 解析电话号码
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

  // Get region code for the number
 String? regionCode = phoneNumberUtil.getRegionCodeForNumber(parsedPhoneNumber);
    // 获取电话号码的归属地描述
    PhoneNumberOfflineGeocoder geocoder = PhoneNumberOfflineGeocoder.instance;
    if (phoneNumberUtil.isValidNumber(parsedPhoneNumber)) {
      return geocoder.getDescriptionForValidNumber(
          parsedPhoneNumber, locale, null); // 将userRegion参数设为null
    } else {
      return null;
    }
  }

// 从号码获取运营商
Future<String?> getCarrierFromPhoneNumber(
    String phoneNumber, Locale locale) async {
  // 解析电话号码
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);

  // 使用 PhoneNumberToCarrierMapper 库获取运营商
  PhoneNumberToCarrierMapper carrierMapper =
      PhoneNumberToCarrierMapper.instance;
  if (phoneNumberUtil.isValidNumber(parsedPhoneNumber)) {
    return carrierMapper.getNameForNumber(parsedPhoneNumber, locale);
  } else {
    return null;
  }
}

// 获取来电号码的类型
  Future<PhoneNumberType> getNumberType(String phoneNumber) async {
    // 使用 PhoneNumberUtil 库获取类型
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
    return phoneNumberUtil.getNumberType(parsedPhoneNumber);
  }

//分割线

Future<LocationData?> getCallerLocationData(String phoneNumber, Locale locale) async {
  // 使用 PhoneNumberUtil 库获取类型
  PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
  PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
print('getCallerLocationData 的locale信息: ${locale.language}, ${locale.country}');
  print('getCallerLocationData的parsedPhoneNumber: $phoneNumber, $parsedPhoneNumber');
  // 检查电话号码是否有效
  if (!phoneNumberUtil.isValidNumber(parsedPhoneNumber)) {
        print('getCallerLocationData的Invalid phone number: $phoneNumber');
    return null;
  }

  // 获取来电号码的类型
  PhoneNumberType numberType =
      await getNumberType(phoneNumber);
  print('numberType: $numberType');
  // 获取来电号码的国家代码
  String? countryName =
      await getCountryNameFromPhoneNumber(phoneNumber, locale);
  print('countryName: $countryName');
  // 获取来电号码归属地
  String? region =
      await getRegionFromPhoneNumber(phoneNumber, locale);
  print('region: $region');
  // 获取来电号码的运营商
  String? carrier =
      await getCarrierFromPhoneNumber(phoneNumber, locale);
  print('carrier: $carrier');
  // 查询数据库，判断该号码是否已存储

  LocationData? locationData =
      await getLocationDataByPhoneNumber(phoneNumber);
  print('locationData from database: $locationData');
  // 如果号码已存储，则更新数据

  if (locationData != null) {
        print('Updating existing location data');
    locationData.region = region ?? '';
    locationData.countryName = countryName ?? '';
    locationData.carrier = carrier ?? '';
    locationData.numberType = numberType;

    await updateLocationData(locationData);
  } else {
    // 如果号码未存储，则插入新数据
        print('Inserting new location data');
    locationData = LocationData(
      phoneNumber: phoneNumber,
      region: region ?? '',
      countryName: countryName ?? '',
      carrier: carrier ?? '',
      numberType: numberType,
      //isLocalNumber: /* true or false based on your logic */,

    );
    await insertLocationData(locationData);
      print('Returning locationData: ${locationData.region}, ${locationData.countryName}, ${locationData.carrier}');
  }
 print(phoneNumber.runtimeType);
  print('final locationData: ${locationData.region}, ${locationData.countryName}, ${locationData.carrier}');
  return locationData;

}
}



