import 'package:dlibphonenumber/dlibphonenumber.dart';

import 'package:rxdart/rxdart.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/white_black_rule.dart';

import 'package:yourcallyourrule/core/entities/plugin/plugin_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 来电显示服务类，提供来电显示相关功能
/// 包括获取来电显示信息、处理来电显示数据等
class CallerIdService {
  CallerIdService({
    required PluginInvokerService pluginService,
    required ContactService contactService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required LabelService labelService,
    required LocationService locationService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
  })  : _contactService = contactService,
        _blacklistWhitelistService = blacklistWhitelistService,
        _labelService = labelService,
        _locationService = locationService,
        _predefinedLabelService = predefinedLabelService,
        _pluginService = pluginService,
        _remoteNumberService = remoteNumberService;

  final BlacklistWhitelistService _blacklistWhitelistService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  final ContactService _contactService;
  final _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();
  final LabelService _labelService;
  final _legacyPluginDataSubject = BehaviorSubject<Map<String, dynamic>>();
  final LocationService _locationService;
  final _pluginDataSubject = BehaviorSubject<PluginData>();
  final PluginInvokerService _pluginService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;

  /// 插件数据流
  Stream<PluginData> get pluginDataStream => _pluginDataSubject.stream;

  /// 兼容性插件数据流
  Stream<Map<String, dynamic>> get legacyPluginDataStream =>
      _legacyPluginDataSubject.stream;

  /// 来电显示数据流，用于监听来电显示数据的变化
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  /// 标签电话条目数据流，用于监听标签电话条目的变化
  Stream<LabelPhoneEntry> get labelPhoneEntryStream =>
      _labelPhoneEntrySubject.stream;

  static Future<CallerIdService> create({
    required ContactService contactService,
    required BlacklistWhitelistService blacklistWhitelistService,
    required LabelService labelService,
    required LocationService locationService,
    required PluginInvokerService pluginService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
  }) async {
    return CallerIdService(
      contactService: contactService,
      blacklistWhitelistService: blacklistWhitelistService,
      labelService: labelService,
      locationService: locationService,
      pluginService: pluginService,
      predefinedLabelService: predefinedLabelService,
      remoteNumberService: remoteNumberService,
    );
  }

  /// 获取来电显示信息
  /// [phoneNumber] 电话号码字符串
  /// [locale] 区域设置，用于解析国际电话号码
  /// 返回包含来电显示信息的CallerIdData对象
  Future<CallerIdData> getCallerId(String phoneNumber, Locale locale) async {
    // 使用PhoneUtils进行号码解析
    final parsed =
        await PhoneUtils.parsePhoneNumberWithIso(phoneNumber, locale.country);
    return getCallerIdWithParsed(phoneNumber, parsed['e164Number'] ?? '',
        parsed['nationalNumber'] ?? '', locale);
  }

  Future<CallerIdData> getCallerIdWithParsed(String phoneNumber,
      String e164Number, String nationalNumber, Locale locale) async {
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

    // 使用PhoneUtils进行号码解析，原始的解析方法

    //final parsed = await PhoneUtils.parsePhoneNumberWithIso(phoneNumber, locale.country);

    // 获取格式化号码
    //  String e164Number = parsed['e164Number'] ?? "";
    //  String nationalNumber = parsed['nationalNumber'] ?? "";

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
    var finalContact = await _contactService
            .findContactByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)) ??
        (e164Number.isNotEmpty
            ? await _contactService
                .findContactByPhoneNumber(vo.PhoneNumber.fromString(e164Number))
            : null) ??
        (nationalNumber.isNotEmpty
            ? await _contactService.findContactByPhoneNumber(
                vo.PhoneNumber.fromString(nationalNumber))
            : null);

    // 4. 查询规则数据 (尝试原始号码、E164、National 格式)
    // 获取所有规则
    final allRules = await _blacklistWhitelistService.getAllRules();

    // 查找匹配的规则
    WhiteBlackRule? whiteBlackRule;

    try {
      // 尝试查找匹配的规则（按优先级排序）
      final matchingRules = allRules
          .where((rule) =>
              rule.phoneNumber == vo.PhoneNumber.fromString(phoneNumber) ||
              (e164Number.isNotEmpty &&
                  rule.phoneNumber == vo.PhoneNumber.fromString(e164Number)) ||
              (nationalNumber.isNotEmpty &&
                  rule.phoneNumber ==
                      vo.PhoneNumber.fromString(nationalNumber)))
          .toList();

      // 按优先级排序
      if (matchingRules.isNotEmpty) {
        matchingRules
            .sort((a, b) => b.priority.value.compareTo(a.priority.value));
        whiteBlackRule = matchingRules.first;
      }
    } catch (_) {
      whiteBlackRule = null;
    }

    // 5. 查询标签数据 (尝试原始号码、National、E164 格式)
    var labelEntry = await _labelService
            .getLabelByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)) ??
        (nationalNumber.isNotEmpty
            ? await _labelService.getLabelByPhoneNumber(
                vo.PhoneNumber.fromString(nationalNumber))
            : null) ??
        (e164Number.isNotEmpty
            ? await _labelService
                .getLabelByPhoneNumber(vo.PhoneNumber.fromString(e164Number))
            : null);

    // 6. 查询插件数据
    final rawPluginData = await _pluginService.callPlugins(
        phoneNumber, nationalNumber, e164Number);

    // 转换为PluginData实体
    final pluginData =
        rawPluginData != null ? PluginData.fromMap(rawPluginData) : null;

    // 7. 查询远程号码数据
    final remoteNumberEntry = await _remoteNumberService
        .getRemoteNumberByPhoneNumber(vo.PhoneNumber.fromString(e164Number));

    // 8. 查询位置数据
    final locationData =
        await _locationService.getCallerLocation(e164Number, locale);

    // 9. 整合数据
    // 确定名称
    final name = localContact?.displayName ??
        finalContact?.name ??
        whiteBlackRule?.name ??
        remoteNumberEntry?.name ??
        pluginData?.name ??
        'Unknown';

    // 确定标签ID
    final labelId = labelEntry?.labelId ?? whiteBlackRule?.labelId ?? null;

    // 获取标签文本
    String labelText = 'Unknown';

    // 第一阶段：检查预定义标签ID
    final labelFromId = labelId != null
        ? await _predefinedLabelService.getLabelById(labelId)
        : null;

    // 第二阶段：检查远程号码标签（当ID不存在时）
    final labelFromRemote =
        labelFromId == null ? remoteNumberEntry?.label : null;

    // 第三阶段：使用插件标签（当前面都未找到时）
    final labelFromPlugin = (labelFromId == null && labelFromRemote == null)
        ? pluginData?.predefinedLabel
        : null;

    labelText =
        labelFromId?.text ?? labelFromRemote ?? labelFromPlugin ?? 'Unknown';

    // 确定头像
    String? avatar =
        finalContact?.avatar ?? whiteBlackRule?.avatar ?? pluginData?.avatar;

    // 如果没有头像但有标签，使用标签构建头像路径
    if (avatar == null && labelText != 'Unknown') {
      avatar = 'assets/avatars/$labelText.png';
    }

    // 确定计数
    final count = whiteBlackRule?.count ??
        remoteNumberEntry?.count ??
        pluginData?.count ??
        0;

    // 9. 创建CallerIdData对象
    final labels = labelText != 'Unknown'
        ? [Label(label: labelText, color: null, icon: null)]
        : null;

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
    if (pluginData != null) {
      _pluginDataSubject.add(pluginData);
      _legacyPluginDataSubject.add(pluginData.toMap());
    } else {
      _legacyPluginDataSubject.add({});
    }

    // 11. 如果插件提供了标签且现有标签为空，则更新标签
    if (labelEntry == null && whiteBlackRule?.labelId == null) {
      if (pluginData?.predefinedLabel != null) {
        // 通过标签文本获取labelId
        final labels = await _predefinedLabelService
            .getLabelsByText(pluginData!.predefinedLabel!);
        if (labels.isNotEmpty) {
          final entry = LabelPhoneEntry(
            id: '', // ID会在保存时生成
            phoneNumber: vo.PhoneNumber.fromString(e164Number),
            labelId: labels.first.id,
            name: name,
          );
          await _labelService.addLabel(entry);
          // 发布标签电话条目到数据流
          _labelPhoneEntrySubject.add(entry);
        }
      }
    }

    return callerIdData;
  }

  /// 释放资源
  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
    _legacyPluginDataSubject.close();
    _labelPhoneEntrySubject.close();
  }
}
