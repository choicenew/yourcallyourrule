import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as flutterContact;
//import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';

import 'blacklist_whitelist_service.dart';
import 'contact_service.dart';
import 'label_service.dart';
import 'location_service.dart';
import 'plugin_manager_service.dart';

class CallerIdService {
  final ContactService contactService;
  final BlacklistService blacklistService;
  final WhitelistService whitelistService;
  final LabelService labelService;
  final LocationService locationService;
  final PluginService pluginService;

  final _callerIdSubject = BehaviorSubject<CallerIdData>();

  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  CallerIdService({
    required this.contactService,
    required this.blacklistService,
    required this.whitelistService,
    required this.labelService,
    required this.locationService,
    required this.pluginService,
  });

  static Future<CallerIdService> create({required Database database}) async {
    return CallerIdService(
      contactService: ContactService(database),
      blacklistService: BlacklistService(database),
      whitelistService: WhitelistService(database),
      labelService: LabelService(database),
      locationService: LocationService(database),
      pluginService: PluginService(database),
    );
  }

  Future<CallerIdData> getCallerId(
      String phoneNumber, BuildContext context, Locale locale) async {
    PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
// 1. 解析号码
// 判断号码是否包含国际区号
   // RegExp internationalPrefixRegex = RegExp(r'^(?:\+|00)');
RegExp internationalPrefixRegex = RegExp(r'^\+');

// 2. 获取格式化号码
    String e164Number = "";
    String nationalNumber = "";

    if (internationalPrefixRegex.hasMatch(phoneNumber)) {
      // 包含国际区号， 使用 null 作为国家代码
      PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } else {
      // 不包含国际区号， 使用 locale.country 作为国家代码
      PhoneNumber parsedPhoneNumber =
          phoneNumberUtil.parse(phoneNumber, locale.country);
      e164Number =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber =
          phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    }

    // 3. 查询数据
    // 获取所有本地联系人
    List<flutterContact.Contact> allLocalContacts =
        await flutterContact.FlutterContacts.getContacts();
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
      if (localContact != null) {
        break; // 找到匹配的联系人，跳出外层循环
      }
    }


    // 4. Check contact service

    Contact? contact =
        await contactService.findContactByPhoneNumber(phoneNumber);

    if (contact == null && e164Number.isNotEmpty) {
      contact = await contactService.findContactByPhoneNumber(e164Number);
    }
    if (contact == null && nationalNumber.isNotEmpty) {
      contact = await contactService.findContactByPhoneNumber(nationalNumber);
    }

    // 5. Check whitelist
    WhitelistEntry? whitelistEntry =
        await whitelistService.getEntryByPhoneNumber(phoneNumber);
    if (whitelistEntry == null && e164Number.isNotEmpty) {
      whitelistEntry = await whitelistService.getEntryByPhoneNumber(e164Number);
    }
    if (whitelistEntry == null && nationalNumber.isNotEmpty) {
      whitelistEntry =
          await whitelistService.getEntryByPhoneNumber(nationalNumber);
    }

    // 6. Check blacklist
    BlacklistEntry? blacklistEntry =
        await blacklistService.getEntryByPhoneNumber(phoneNumber);
    if (blacklistEntry == null && e164Number.isNotEmpty) {
      blacklistEntry = await blacklistService.getEntryByPhoneNumber(e164Number);
    }
    if (blacklistEntry == null && nationalNumber.isNotEmpty) {
      blacklistEntry =
          await blacklistService.getEntryByPhoneNumber(nationalNumber);
    }

    // 7. Check label service
    LabeledEntry? labeledEntry =
        await labelService.getEntryByPhoneNumber(phoneNumber);
    if (labeledEntry == null && nationalNumber.isNotEmpty) {
      labeledEntry = await labelService.getEntryByPhoneNumber(nationalNumber);
    }
    if (labeledEntry == null && e164Number.isNotEmpty) {
      labeledEntry = await labelService.getEntryByPhoneNumber(e164Number);
    }

    // 8. Check plugin manager
    Map<String, dynamic>? pluginData = await pluginService.callPlugins(
        phoneNumber, nationalNumber, e164Number);



    // Determine name
    String name = localContact?.displayName ??
        contact?.name ??
        whitelistEntry?.name ??
        blacklistEntry?.name ??
        //pluginData?['name'] ??
        'Unknown';

    // Determine label
    String finalLabel = labeledEntry?.label ??
        whitelistEntry?.label ??
        blacklistEntry?.label ??
        pluginData?['predefinedLabel'] ??
        'Unknown';

    // Determine avatar
    String? avatar = contact?.avatar ??
        whitelistEntry?.avatar ??
        blacklistEntry?.avatar ??
        pluginData?['avatar'];

    // If no avatar but label exists, use label to construct avatar path
    if (avatar == null && finalLabel != 'Unknown') {
      avatar = 'assets/avatars/$finalLabel.png';
    }

    // Get location data
    LocationData? locationData =
        await locationService.getCallerLocationData(e164Number, locale);



    int? count =
        whitelistEntry?.count ?? blacklistEntry?.count ?? pluginData?['count'];

    CallerIdData callerIdData = CallerIdData(
      phoneNumber: phoneNumber,
      countryName: locationData?.countryName ?? 'Unknown',
      region: locationData?.region,
      carrier: locationData?.carrier,
      numberType: locationData?.numberType,
      //isLocalNumber: locationData?.isLocalNumber,
      labels: [Label(label: finalLabel)],
      name: name,
      avatar: avatar,
      count: count,
    );

    _callerIdSubject.add(callerIdData);

    //  更新label得号码数据添加新函数：如果 pluginData?['predefinedLabel'] 不为空，则添加到 LabeledEntry
    if (pluginData?['predefinedLabel'] != null) {
      final entry = LabeledEntry(
        name: name, // 使用前面确定的 name
        phoneNumber: phoneNumber,
        label: pluginData?['predefinedLabel'],
      );
      try {
        await labelService.addOrUpdate(entry);
      } catch (e) {
        //
      }
    }

    return callerIdData;
  }
}

//单独定义得caller id data 数据
class CallerIdData {
  String phoneNumber;
  String countryName;
  String? region;
  String? carrier;
  PhoneNumberType? numberType;
  //final bool? isLocalNumber;
  List<Label> labels;
  String name;
  String? avatar;
  int? count;

  CallerIdData({
    required this.phoneNumber,
    required this.countryName,
    this.region,
    this.carrier,
    this.numberType,
    // this.isLocalNumber,
    required this.labels,
    required this.name,
    this.avatar,
    this.count,
  });

//为了支持overlay进行的转换
  // 将 CallerIdData 对象转换为 Map
  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'countryName': countryName,
        'region': region,
        'carrier': carrier,
        // 将 PhoneNumberType 枚举转换为字符串
        'numberType': numberType?.toString(),
        'labels': labels.map((label) => label.toJson()).toList(),
        'name': name,
        // 直接存储字符串类型的 avatar
        'avatar': avatar,
        'count': count,
      };

  // 从 Map 创建 CallerIdData 对象
  factory CallerIdData.fromJson(Map<String, dynamic> json) => CallerIdData(
        phoneNumber: json['phoneNumber'],
        countryName: json['countryName'],
        region: json['region'],
        carrier: json['carrier'],
        // 将字符串转换回 PhoneNumberType 枚举
        numberType: json['numberType'] != null
            ? PhoneNumberType.values.firstWhere(
                (e) => e.toString() == json['numberType'],
                orElse: () => PhoneNumberType.unknown, // 处理未知类型
              )
            : null,
        labels: List<Label>.from(
            json['labels'].map((labelJson) => Label.fromJson(labelJson))),
        name: json['name'],
        // 直接读取字符串类型的 avatar
        avatar: json['avatar'],
        count: json['count'],
      );

//为了支持overlay isolate 进行的转换


//显示头像，可展示网络头像
  ImageProvider get avatarImage {
    if (avatar != null && avatar!.isNotEmpty) {
      // 如果 entry.avatar 是 URL 链接，则使用 NetworkImage
      if (avatar!.startsWith('http')) {
        return NetworkImage(avatar!);
      } else {
        // 如果 entry.avatar 是本地资源路径，则使用 AssetImage
        return AssetImage(avatar!);
      }
    } else {
      // 否则使用 label 构建本地资源路径
      return AssetImage('assets/avatars/${labels.first.label}.png');
    }
  }
}


class Label {
  String label;

  Label({required this.label});

  // 将 Label 对象转换为 Map ，这个就是为了展示isolate overlay的转换
  Map<String, dynamic> toJson() => {'label': label};

  // 从 Map 创建 Label 对象，这个就是为了展示isolate overlay的转换
  factory Label.fromJson(Map<String, dynamic> json) =>
      Label(label: json['label']);
}


