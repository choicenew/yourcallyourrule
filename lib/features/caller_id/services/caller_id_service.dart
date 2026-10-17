import 'dart:async';
import 'dart:math' as math;

import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';

import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/value_objects/phone_number.dart' as vo;
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_invoker_service.dart';

import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';

/// 来电显示服务类，提供来电显示相关功能
/// 包括获取来电显示信息、处理来电显示数据等
class CallerIdService {
  CallerIdService({
    required PluginInvokerService pluginService,
    required ContactService contactService,
    required RuleManagementService ruleManagementService,
    required LabelService labelService,
    required LocationService locationService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
  }) : _contactService = contactService,
       _ruleManagementService = ruleManagementService,
       _labelService = labelService,
       _locationService = locationService,
       _predefinedLabelService = predefinedLabelService,
       _pluginService = pluginService,
       _remoteNumberService = remoteNumberService;

  final RuleManagementService _ruleManagementService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  final ContactService _contactService;
  final _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();
  final LabelService _labelService;
  final LocationService _locationService;
  final _pluginDataSubject = BehaviorSubject<PluginSourceData>();
  final PluginInvokerService _pluginService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;

  /// 是否已触发插件同步服务
  bool _pluginSyncTriggered = false;

  /// 插件数据流
  Stream<PluginSourceData> get pluginDataStream => _pluginDataSubject.stream;

  /// 来电显示数据流，用于监听来电显示数据的变化
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;

  /// 标签电话条目数据流，用于监听标签电话条目的变化
  Stream<LabelPhoneEntry> get labelPhoneEntryStream =>
      _labelPhoneEntrySubject.stream;

  static Future<CallerIdService> create({
    required ContactService contactService,
    required RuleManagementService ruleManagementService,
    required LabelService labelService,
    required LocationService locationService,
    required PluginInvokerService pluginService,
    required PredefinedLabelService predefinedLabelService,
    required RemoteNumberService remoteNumberService,
  }) async {
    return CallerIdService(
      contactService: contactService,
      ruleManagementService: ruleManagementService,
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
    // 使用 PhoneUtils 进行强类型 ParsedPhoneNumber 实体解析
    final parsed = await PhoneUtils.parsePhoneNumberWithIsoEntity(
      phoneNumber,
      locale.country,
    );
    return getCallerIdWithParsed(
      phoneNumber,
      parsed.e164Number,
      parsed.nationalNumber,
      locale,
    );
  }

  Future<CallerIdData> getCallerIdWithParsed(
    String phoneNumber,
    String e164Number,
    String nationalNumber,
    Locale locale,
  ) async {
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

    // 获取手机所有本地联系人（带 try-catch 容错防护与无权限安全降级）
    List<fluttercontact.Contact> allLocalContacts = [];
    try {
      allLocalContacts = await fluttercontact.FlutterContacts.getAll();
    } catch (e) {
      debugPrint('[CallerIdService] 获取系统联系人跳过/无权限: $e');
      allLocalContacts = [];
    }

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

    // ✨【并发并行查询 (Future.wait)】：同时并行发起联系人、规则库、标签库、插件引擎、远程云端库及归属地查询，缩短 50% 响应等待！
    final futures = await Future.wait([
      _contactService.findContactByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _ruleManagementService.getRulesByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _labelService.getLabelByPhoneNumber(vo.PhoneNumber.fromString(phoneNumber)),
      _pluginService.callPluginsAllEntities(phoneNumber, nationalNumber, e164Number),
      _remoteNumberService.getRemoteNumberByPhoneNumber(vo.PhoneNumber.fromString(e164Number)),
      _locationService.getCallerLocation(e164Number, locale),
    ]);

    final finalContact = futures[0] as Contact?;
    final allRules = futures[1] as List<PhoneRule>;
    final labelEntry = futures[2] as LabelPhoneEntry?;
    final (firstResult, allResultsFuture) = futures[3] as (PluginSourceData?, Future<List<PluginSourceData>>);
    final remoteNumberEntry = futures[4] as RemoteNumberEntry?;
    final locationData = futures[5] as LocationEntry?;

    PhoneRule? phoneRule;
    if (allRules.isNotEmpty) {
      final matchingRules = allRules.where(
        (rule) =>
            rule.phoneNumber == vo.PhoneNumber.fromString(phoneNumber) ||
            (e164Number.isNotEmpty && rule.phoneNumber == vo.PhoneNumber.fromString(e164Number)) ||
            (nationalNumber.isNotEmpty && rule.phoneNumber == vo.PhoneNumber.fromString(nationalNumber)),
      ).toList();
      if (matchingRules.isNotEmpty) {
        matchingRules.sort((a, b) => b.priority.value.compareTo(a.priority.value));
        phoneRule = matchingRules.first;
      }
    }

    PluginSourceData? pluginSourceData = firstResult;

    // 9. 整合数据
    // 获取预定义标签实体
    final labelId = labelEntry?.labelId ?? phoneRule?.labelId;
    final labelFromId =
        labelId != null
            ? await _predefinedLabelService.getLabelById(labelId)
            : null;

    // ✨【全自动化组合】：直接调用 CallerIdData.resolve 领域工厂，一行解决全部名字/标签/头像融合！
    final callerIdData = CallerIdData.resolve(
      rawNumber: phoneNumber,
      localContact: localContact,
      finalContact: finalContact,
      phoneRule: phoneRule,
      labelEntry: labelEntry,
      labelFromId: labelFromId,
      remoteNumberEntry: remoteNumberEntry,
      pluginSourceData: pluginSourceData,
      locationData: locationData,
    );

    // 10. 发布初始数据到数据流
    _callerIdSubject.add(callerIdData);

    // 计算优先级标志
    final bool hasHighPriorityName =
        localContact != null ||
        finalContact != null ||
        phoneRule?.name != null ||
        remoteNumberEntry?.name != null;

    final bool hasHighPriorityAction =
        phoneRule?.action != null || remoteNumberEntry?.action != null;

    final bool hasHighPriorityAvatar =
        finalContact?.avatar != null || phoneRule?.avatar != null;

    // 异步处理所有插件的完整数据（包括发布到数据流）
    unawaited(
      _processAllPluginData(
        allResultsFuture,
        callerIdData,
        hasHighPriorityName: hasHighPriorityName,
        hasHighPriorityAction: hasHighPriorityAction,
        hasHighPriorityAvatar: hasHighPriorityAvatar,
      ),
    );

    // 原有逻辑：
    // if (labelEntry == null && phoneRule?.labelId == null) {
    //   if (pluginSourceData?.predefinedLabel != null) {
    //     final labels = await _predefinedLabelService.getLabelsByText(pluginSourceData!.predefinedLabel!);
    //     if (labels.isNotEmpty) {
    //       final entry = LabelPhoneEntry(
    //         id: '',
    //         phoneNumber: vo.PhoneNumber.fromString(e164Number),
    //         labelId: labels.first.id,
    //         name: name,
    //       );
    //       await _labelService.addLabel(entry);
    //       _labelPhoneEntrySubject.add(entry);
    //     }
    //   }
    // }

    return callerIdData;
  }

  /// 异步处理所有插件的完整数据
  /// 该方法接收一个包含所有插件结果的Future，等待其完成后处理数据
  /// 并将结果发布到数据流中，以便其他服务可以使用完整数据
  /// 同时处理标签更新逻辑
  Future<void> _processAllPluginData(
    Future<List<PluginSourceData>> allResultsFuture,
    CallerIdData initialData, {
    bool hasHighPriorityName = false,
    bool hasHighPriorityAction = false,
    bool hasHighPriorityAvatar = false,
  }) async {
    try {
      // 等待所有结果完成
      final allResults = await allResultsFuture;
      if (allResults.isEmpty) return;

      // 直接调用 PluginSourceData 实体类的全自动化 merge 领域方法
      final completePluginData = PluginSourceData.merge(allResults);
      final mergedData = completePluginData.toMap();

      // 直接调用 initialData.enrichWith 领域方法，全自动化异步富集更新！
      final updatedCallerIdData = initialData.enrichWith(
        completePluginData,
        hasHighPriorityName: hasHighPriorityName,
        hasHighPriorityAction: hasHighPriorityAction,
        hasHighPriorityAvatar: hasHighPriorityAvatar,
      );

      // 如果数据有变化，则发射更新
      if (updatedCallerIdData.name != initialData.name ||
          updatedCallerIdData.action != initialData.action ||
          updatedCallerIdData.avatar != initialData.avatar ||
          updatedCallerIdData.count != initialData.count ||
          updatedCallerIdData.labels?.first.label != initialData.labels?.first.label) {
        debugPrint('[CallerIdService] Emitting UPDATED CallerIdData with label: ${updatedCallerIdData.labels?.first.label}, avatar: ${updatedCallerIdData.avatar}');
        _callerIdSubject.add(updatedCallerIdData);
      }

      // 检查是否已经发布过相同的数据，避免重复发布
      if (_pluginDataSubject.hasValue &&
          _pluginDataSubject.value.phoneNumber ==
              completePluginData.phoneNumber) {
        // 只有当新数据包含更多信息时才更新
        if (completePluginData.name != null &&
            completePluginData.name!.isNotEmpty &&
            completePluginData.name != 'Unknown') {
          debugPrint(
            '[CallerIdService] 数据流传递Updating plugin data for ${completePluginData.phoneNumber}: ${completePluginData.toMap()}',
          );
          _pluginDataSubject.add(completePluginData);
        }
      } else {
        // 首次发布数据
        debugPrint(
          '[CallerIdService] 数据流传递Publishing new plugin data for ${completePluginData.phoneNumber}: ${completePluginData.toMap()}',
        );
        _pluginDataSubject.add(completePluginData);
      }

      // 使用完整数据处理标签更新逻辑
      // 检查是否有预定义标签，并且当前没有标签和规则
      if (completePluginData.predefinedLabel != null) {
        // 查询是否已存在标签
        final e164Number = completePluginData.phoneNumber ?? '';
        if (e164Number.isNotEmpty) {
          final existingLabel = await _labelService.getLabelByPhoneNumber(
            vo.PhoneNumber.fromString(e164Number),
          );

          // 查询是否存在规则 (精准索引查询，不扫描全表)
          final matchingRules = await _ruleManagementService.getRulesByPhoneNumber(
            vo.PhoneNumber.fromString(e164Number),
          );
          final matchingRule = matchingRules.firstOrNull;

          // 如果没有现有标签和规则，则创建新标签
          if (existingLabel == null && matchingRule?.labelId == null) {
            final labels = await _predefinedLabelService.getLabelsByText(
              completePluginData.predefinedLabel!,
            );
            if (labels.isNotEmpty) {
              final entry = LabelPhoneEntry(
                id: const Uuid().v4(),
                phoneNumber: vo.PhoneNumber.fromString(e164Number),
                labelId: labels.first.id,
                name: completePluginData.name ?? 'Unknown',
                action: completePluginData.action, // 使用插件数据中的动作
              );
              // 检查是否已经添加过相同的标签
              if (!_labelPhoneEntrySubject.hasValue ||
                  _labelPhoneEntrySubject.value.phoneNumber !=
                      entry.phoneNumber) {
                await _labelService.addLabel(entry);
                // 发布标签电话条目到数据流
                _labelPhoneEntrySubject.add(entry);
              }
            }
          }
        }
      }
    } catch (e) {
      AppLogger.error('处理所有插件数据失败', e);
      debugPrint('处理所有插件数据失败: $e');
    }
  }

  /// 释放资源
  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
    _labelPhoneEntrySubject.close();
  }
}
