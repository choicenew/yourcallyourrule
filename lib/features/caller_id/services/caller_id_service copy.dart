import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:rxdart/rxdart.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:yourcallyourrule/core/entities/rule/blacklist_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/whitelist_rule.dart';

import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';

/// 来电显示服务类，提供来电显示相关功能
/// 包括获取来电显示信息、处理来电显示数据等
class CallerIdService {
  final ContactService _contactService;
  final BlacklistWhitelistService _blacklistWhitelistService;
  final LabelService _labelService;
  final LocationService _locationService;
  final PluginInvokerService _pluginService;

  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  final _pluginDataSubject = BehaviorSubject<Map<String, dynamic>>();

  /// 插件数据流
  Stream<Map<String, dynamic>> get pluginDataStream => _pluginDataSubject.stream;

  /// 来电显示数据流，用于监听来电显示数据的变化
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  CallerIdService({
    required PluginInvokerService pluginService,
    required ContactService contactService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required LabelService labelService,
    required LocationService locationService,
  }) : _contactService = contactService,
       _blacklistWhitelistService = blacklistWhitelistService,
       _labelService = labelService,
       _locationService = locationService,
       _pluginService = pluginService;

  static Future<CallerIdService> create({
    required ContactService contactService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required LabelService labelService,
    required LocationService locationService,
    required PluginInvokerService pluginService,
  }) async {
    return CallerIdService(
      contactService: contactService,
      blacklistWhitelistService: blacklistWhitelistService,
      labelService: labelService,
      locationService: locationService,
      pluginService: pluginService,
    );
  }

  /// 获取来电显示信息
  /// [phoneNumber] 电话号码字符串
  /// [locale] 区域设置，用于解析国际电话号码
  /// 返回包含来电显示信息的CallerIdData对象
  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    
/*
    final PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.instance;
    
    // 1. 解析号码，判断是否包含国际区号
    final RegExp internationalPrefixRegex = RegExp(r'^\+');//不要修改
    
    // 2. 获取格式化号码
    String e164Number = "";
    String nationalNumber = "";
    
    if (internationalPrefixRegex.hasMatch(phoneNumber)) {
      // 包含国际区号，使用null作为国家代码
      final PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, null);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    } else {
      // 不包含国际区号，使用locale.country作为国家代码
      final PhoneNumber parsedPhoneNumber = phoneNumberUtil.parse(phoneNumber, locale.country);
      e164Number = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.e164);
      nationalNumber = phoneNumberUtil.format(parsedPhoneNumber, PhoneNumberFormat.national);
    }
   */ 
   
       // 使用PhoneUtils进行号码解析
    final parsed = await PhoneUtils.parsePhoneNumberWithIso(phoneNumber, locale.country);
    
    // 获取格式化号码
    String e164Number = parsed['e164Number'] ?? "";
    String nationalNumber = parsed['nationalNumber'] ?? "";

    // 获取手机所有本地联系人
    List<fluttercontact.Contact> allLocalContacts =
        await fluttercontact.FlutterContacts.getContacts();

    // 使用原始号码、E164 和 National 格式分别查询
    fluttercontact.Contact? localContact;

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


    // 3. 查询app本身数据地联系人数据 (尝试原始号码、E164、National 格式)
    var finalContact = await _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)) ??
                       (e164Number.isNotEmpty ? await _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(e164Number)) : null) ??
                       (nationalNumber.isNotEmpty ? await _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(nationalNumber)) : null);

    // 4. 查询黑白名单数据 (尝试原始号码、E164、National 格式)
    var isInBlacklist = await _blacklistWhitelistService.isInBlacklist(vo.PhoneNumber.fromString(phoneNumber)) ||
                        (e164Number.isNotEmpty && await _blacklistWhitelistService.isInBlacklist(vo.PhoneNumber.fromString(e164Number))) ||
                        (nationalNumber.isNotEmpty && await _blacklistWhitelistService.isInBlacklist(vo.PhoneNumber.fromString(nationalNumber)));

    var isInWhitelist = await _blacklistWhitelistService.isInWhitelist(vo.PhoneNumber.fromString(phoneNumber)) ||
                        (e164Number.isNotEmpty && await _blacklistWhitelistService.isInWhitelist(vo.PhoneNumber.fromString(e164Number))) ||
                        (nationalNumber.isNotEmpty && await _blacklistWhitelistService.isInWhitelist(vo.PhoneNumber.fromString(nationalNumber)));

    // 获取黑白名单规则
    final blacklistRules = await _blacklistWhitelistService.getAllBlacklistRules();
    final whitelistRules = await _blacklistWhitelistService.getAllWhitelistRules();
    
    // 查找匹配的规则
    BlacklistRule? blacklistRule;
    WhitelistRule? whitelistRule;
    
    if (isInBlacklist) {
      try {
        blacklistRule = blacklistRules.firstWhere(
          (rule) => rule.phoneNumber == vo.PhoneNumber.fromString(phoneNumber) || 
                   rule.phoneNumber == vo.PhoneNumber.fromString(e164Number) || 
                   rule.phoneNumber == vo.PhoneNumber.fromString(nationalNumber)
        );
      } catch (_) {
        blacklistRule = null;
      }
    }
    
    if (isInWhitelist) {
      try {
        whitelistRule = whitelistRules.firstWhere(
          (rule) => rule.phoneNumber == vo.PhoneNumber.fromString(phoneNumber) ||
                   rule.phoneNumber == vo.PhoneNumber.fromString(e164Number) || 
                   rule.phoneNumber == vo.PhoneNumber.fromString(nationalNumber)
        );
      } catch (_) {
        whitelistRule = null;
      }
    }
    
    // 5. 查询标签数据 (尝试原始号码、National、E164 格式)
    var labelEntry = await _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)) ??
                     (nationalNumber.isNotEmpty ? await _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(nationalNumber)) : null) ??
                     (e164Number.isNotEmpty ? await _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(e164Number)) : null);

    // 6. 查询插件数据
    final pluginData = await _pluginService.callPlugins(
      phoneNumber, 
      nationalNumber, 
      e164Number
    );
    
    // 7. 查询位置数据
    final locationData = await _locationService.getCallerLocation(e164Number, locale);
    
    // 8. 整合数据
    // 确定名称
    final name = localContact?.displayName ??
    finalContact?.name ?? 
                whitelistRule?.name ?? 
                blacklistRule?.name ?? 
                'Unknown';
    
    // 确定标签
    final labelText = labelEntry?.label ?? 
                     whitelistRule?.label ?? 
                     blacklistRule?.label ?? 
                     pluginData?['predefinedLabel'] ?? 
                     'Unknown';
    
    // 确定头像
    String? avatar = finalContact?.avatar ?? 
                   whitelistRule?.avatar ?? 
                   blacklistRule?.avatar ?? 
                   pluginData?['avatar'];
    
    // 如果没有头像但有标签，使用标签构建头像路径
    if (avatar == null && labelText != 'Unknown') {
      avatar = 'assets/avatars/$labelText.png';
    }
    
    // 确定计数
    final count = whitelistRule?.count ?? 
                 blacklistRule?.count ?? 
                 pluginData?['count'] ?? 
                 0;
    
    // 9. 创建CallerIdData对象
    final labels = labelText != 'Unknown' ? [Label(label: labelText, color: null, icon: null)] : null;
    
    final callerIdData = CallerIdData(
      id: phoneNumber, // 使用电话号码作为ID
      phoneNumber: vo.PhoneNumber.fromString(phoneNumber),
      numberType: locationData?.numberType ?? PhoneNumberType.unknown,
      name: name,
      countryName: locationData?.countryName,
      region: locationData?.region,
      carrier: locationData?.carrier,
      labels: labels,
      avatar: avatar,
      count: count,
    );
    
    // 10. 发布到数据流
    _callerIdSubject.add(callerIdData);
    _pluginDataSubject.add(pluginData ?? {});
    
    // 11. 如果插件提供了标签且现有标签为空，则更新标签
    if (labelEntry == null && whitelistRule?.label == null && blacklistRule?.label == null) {
      if (pluginData?['predefinedLabel'] != null) {
        final entry = LabelEntry(
          id: '', // ID会在保存时生成
          phoneNumber: vo.PhoneNumber.fromString(phoneNumber),
          label: pluginData?['predefinedLabel'],
          name: name,
        );
        await _labelService.addLabel(entry);
      }
    }
    
    return callerIdData;
  }
  
  /// 释放资源
  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
  }
}