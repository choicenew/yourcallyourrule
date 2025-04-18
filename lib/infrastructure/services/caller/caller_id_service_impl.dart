import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as flutterContact;

import '../../../domain/entities/caller/caller_id_data.dart';
import '../../../domain/services/caller_id_service.dart';

/// 来电显示服务实现
class CallerIdServiceImpl implements ICallerIdService {
  final Database database;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();

  @override
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  CallerIdServiceImpl({
    required this.database,
  });

  /// 创建CallerIdService实例的工厂方法
  static Future<CallerIdServiceImpl> create({required Database database}) async {
    final service = CallerIdServiceImpl(database: database);
    await service.initialize();
    return service;
  }

  @override
  Future<void> initialize() async {
    // 初始化服务
  }

  @override
  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;

    // 1. 解析号码
    // 判断号码是否包含国际区号
    RegExp internationalPrefixRegex = RegExp(r'^\+');

    // 2. 获取格式化号码
    String e164Number = "";
    String nationalNumber = "";

    if (internationalPrefixRegex.hasMatch(phoneNumber)) {
      // 包含国际区号，使用 null 作为国家代码
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } else {
      // 不包含国际区号，使用 locale.country 作为国家代码
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, locale.country);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    }

    // 3. 查询数据
    // 获取所有本地联系人
    List<flutterContact.Contact> allLocalContacts = await flutterContact.FlutterContacts.getContacts();

    // 使用原始号码、E164 和 National 格式分别查询
    flutterContact.Contact? localContact;

    for (var contact in allLocalContacts) {
      for (var phone in contact.phones) {
        String normalizedPhone = phone.number.replaceAll(' ', '');
        if (normalizedPhone == phoneNumber.replaceAll(' ', '') ||
            normalizedPhone == e164Number ||
            normalizedPhone == nationalNumber) {
          localContact = contact;
          break; // 找到匹配的联系人，跳出循环
        }
      }
      if (localContact != null) break;
    }

    // 4. 构建CallerIdData
    CallerIdData callerIdData = CallerIdData(
      phoneNumber: phoneNumber,
      name: localContact?.displayName ?? "Unknown",
      countryName: locale.countryCode,
      region: "Unknown Region", // 这里应该从位置服务获取
      carrier: "Unknown Carrier", // 这里应该从运营商服务获取
      avatar: "assets/avatars/Unknown.png",
      labels: [LabelInfo(label: "Unknown", count: 0)],
      count: 0,
      numberType: NumberType.unknown,
    );

    // 5. 发布数据到流
    _callerIdSubject.add(callerIdData);

    return callerIdData;
  }

  @override
  Future<void> dispose() async {
    await _callerIdSubject.close();
  }
}