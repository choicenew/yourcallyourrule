import 'dart:async';
import 'dart:math' as math;


import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/error/logger.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';

import 'package:flutter_contacts/flutter_contacts.dart' as fluttercontact;
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
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
  })  : _contactService = contactService,
        _blacklistWhitelistService = ruleManagementService,
        _labelService = labelService,
        _locationService = locationService,
        _predefinedLabelService = predefinedLabelService,
        _pluginService = pluginService,
        _remoteNumberService = remoteNumberService;

  final RuleManagementService _blacklistWhitelistService;
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  final ContactService _contactService;
  final _labelPhoneEntrySubject = BehaviorSubject<LabelPhoneEntry>();
  final LabelService _labelService;
  final _legacyPluginDataSubject = BehaviorSubject<Map<String, dynamic>>();
  final LocationService _locationService;
  final _pluginDataSubject = BehaviorSubject<PluginSourceData>();
  final PluginInvokerService _pluginService;
  final PredefinedLabelService _predefinedLabelService;
  final RemoteNumberService _remoteNumberService;
  
  /// 是否已触发插件同步服务
  bool _pluginSyncTriggered = false;

  /// 插件数据流
  Stream<PluginSourceData> get pluginDataStream => _pluginDataSubject.stream;

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
    PhoneRule? phoneRule;

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
        phoneRule = matchingRules.first;
      }
    } catch (_) {
      phoneRule = null;
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

    // 6. 查询插件数据 - 使用callPluginsAll方法获取第一个有效结果并在后台获取所有数据
    debugPrint('[CallerIdService] 插件Calling plugins for number: $phoneNumber');
    final (firstResult, allResultsFuture) = await _pluginService.callPluginsAll(
        phoneNumber, nationalNumber, e164Number);
    
    debugPrint('[CallerIdService] 插件First plugin result: $firstResult');
    
    // 转换为PluginData实体（仅用于构建CallerIdData，不发布到数据流）
    PluginSourceData? pluginSourceData;
    if (firstResult != null) {
      pluginSourceData = PluginSourceData.fromMap(firstResult);
      debugPrint('[CallerIdService] 插件Converted PluginSourceData: ${pluginSourceData.toMap()}'); 
    }
    
    // 异步处理所有插件的完整数据（包括发布到数据流）
    unawaited(_processAllPluginData(allResultsFuture));

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
        phoneRule?.name ??
        remoteNumberEntry?.name ??
        pluginSourceData?.name ??
        'Unknown';

    // 确定标签ID
    final labelId = labelEntry?.labelId ?? phoneRule?.labelId;

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
        ? pluginSourceData?.predefinedLabel
        : null;

    labelText =
        labelFromId?.text ?? labelFromRemote ?? labelFromPlugin ?? 'Unknown';

    // 确定头像
    String? avatar =
        finalContact?.avatar ?? phoneRule?.avatar ?? pluginSourceData?.avatar;

    
    // 如果没有头像但有标签，使用标签构建头像路径
    if (avatar == null && labelText != 'Unknown') {
      avatar = 'assets/avatars/$labelText.png';
    }

    // 确定计数
    final count = phoneRule?.count ??
        remoteNumberEntry?.count ??
        pluginSourceData?.count ??
        0;

    // 9. 创建CallerIdData对象
    final labels = labelText != 'Unknown'
        ? [Label(label: labelText, color: null, icon: null)]
        : null;

    // 确定动作
    final action = phoneRule?.action ?? 
                  remoteNumberEntry?.action ?? 
                  pluginSourceData?.action ?? 
                  labelEntry?.action ?? 
                  RuleAction.none;
    
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
      action: action,
    );

    // 10. 发布初始数据到数据流
    // 注意：插件数据会在 _processAllPluginData 方法中处理和发布
    _callerIdSubject.add(callerIdData);

    // 注意：标签更新逻辑已移至 _processAllPluginData 方法中
    // 在那里会使用完整的插件数据进行处理，避免重复处理
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
  Future<void> _processAllPluginData(Future<List<Map<String, dynamic>>> allResultsFuture) async {
    try {
      // 等待所有结果完成
      final allResults = await allResultsFuture;
      if (allResults.isEmpty) return;
      
      // 合并所有插件结果
      final mergedData = _mergePluginResults(allResults);
      
      // 转换为PluginData实体并发布到数据流
      final completePluginData = PluginSourceData.fromMap(mergedData);
      
      // 检查是否已经发布过相同的数据，避免重复发布
      if (_pluginDataSubject.hasValue && 
          _pluginDataSubject.value.phoneNumber == completePluginData.phoneNumber) {
        // 只有当新数据包含更多信息时才更新
        if (completePluginData.name != null && completePluginData.name!.isNotEmpty && 
            completePluginData.name != 'Unknown') {
          debugPrint('[CallerIdService] 数据流传递Updating plugin data for ${completePluginData.phoneNumber}: ${completePluginData.toMap()}');
          _pluginDataSubject.add(completePluginData);
          _legacyPluginDataSubject.add(mergedData);
        }
      } else {
        // 首次发布数据
        debugPrint('[CallerIdService] 数据流传递Publishing new plugin data for ${completePluginData.phoneNumber}: ${completePluginData.toMap()}');
        _pluginDataSubject.add(completePluginData);
        _legacyPluginDataSubject.add(mergedData);
      }
      
      // 使用完整数据处理标签更新逻辑
      // 检查是否有预定义标签，并且当前没有标签和规则
      if (completePluginData.predefinedLabel != null) {
        // 查询是否已存在标签
        final e164Number = completePluginData.phoneNumber ?? '';
        if (e164Number.isNotEmpty) {
          final existingLabel = await _labelService.getLabelByPhoneNumber(
              vo.PhoneNumber.fromString(e164Number));
          
          // 查询是否存在规则
          final allRules = await _blacklistWhitelistService.getAllRules();
          final matchingRule = allRules.where((rule) =>
              rule.phoneNumber == vo.PhoneNumber.fromString(e164Number)).firstOrNull;
          
          // 如果没有现有标签和规则，则创建新标签
          if (existingLabel == null && matchingRule?.labelId == null) {
            final labels = await _predefinedLabelService
                .getLabelsByText(completePluginData.predefinedLabel!);
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
                  _labelPhoneEntrySubject.value.phoneNumber != entry.phoneNumber) {
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
  
  /// 合并多个插件结果
  Map<String, dynamic> _mergePluginResults(List<Map<String, dynamic>> results) {
    if (results.isEmpty) return {};
    if (results.length == 1) return results.first;
    
    // 创建合并结果
    final merged = <String, dynamic>{};
    
    // 用于统计 action 类型的计数
    int allowCount = 0;
    int blockCount = 0;
    int noneCount = 0;
    String? currentAction;
    
    // 合并所有字段
    for (final result in results) {
      result.forEach((key, value) {
        // 特殊处理 action 字段
        if (key == 'action') {
          // 统计各类型 action 的数量
          if (value is String) {
            final actionStr = value.toLowerCase();
            if (actionStr.contains('block')) {
              blockCount++;
              // 优先级最高，立即设置
              if (currentAction == null || !currentAction!.toLowerCase().contains('block')) {
                currentAction = value;
              }
            } else if (actionStr.contains('allow')) {
              allowCount++;
            } else if (actionStr.contains('none')) {
              noneCount++;
            }
          }
          return; // 跳过常规处理，稍后根据统计结果设置 action
        }
        
        // 如果是数组类型，合并数组
        if (value is List && merged[key] is List) {
          (merged[key] as List).addAll(value);
        }
        // 如果是数字类型，取最大值
        else if (value is int && merged[key] is int) {
          merged[key] = math.max(merged[key] as int, value);
        }
        // 如果是字符串类型，优先使用非 unknown 的值
        else if (value is String) {
          final newValue = value.toLowerCase();
          final isNewValueUnknown = newValue == 'unknown' || newValue.isEmpty;
          
          if (merged[key] is String) {
            final currentValue = (merged[key] as String).toLowerCase();
            final isCurrentValueUnknown = currentValue == 'unknown' || currentValue.isEmpty;
            
            // 如果当前值是 unknown 而新值不是，则使用新值
            if (isCurrentValueUnknown && !isNewValueUnknown) {
              merged[key] = value;
            }
            // 如果两者都不是 unknown，保留较长的值（可能包含更多信息）
            else if (!isCurrentValueUnknown && !isNewValueUnknown && value.length > (merged[key] as String).length) {
              merged[key] = value;
            }
            // 其他情况保留当前值
          } else if (merged[key] == null || merged[key] == '') {
            // 如果当前字段为空或不存在，且新值不是 unknown，则使用新值
            if (!isNewValueUnknown) {
              merged[key] = value;
            }
          }
        }
        // 如果当前字段为空或不存在，直接使用新值
        else if (merged[key] == null || merged[key] == '') {
          merged[key] = value;
        }
        // 其他情况，优先保留已有值
      });
    }
    
    // 根据统计结果和优先级规则设置最终的 action
    // 优先级顺序：block > none > allow
    // 特殊规则：如果 allow 数量大于 block 数量，则取 allow
    if (allowCount > blockCount) {
      merged['action'] = 'allow';
    } else if (blockCount > 0) {
      merged['action'] = 'block';
    } else if (noneCount > 0) {
      merged['action'] = 'none';
    } else if (allowCount > 0) {
      merged['action'] = 'allow';
    } else if (currentAction != null) {
      // 如果有设置过 action 但不属于上述类型，保留最后设置的值
      merged['action'] = currentAction;
    }
    
    return merged;
  }

  /// 释放资源
  void dispose() {
    _callerIdSubject.close();
    _pluginDataSubject.close();
    _legacyPluginDataSubject.close();
    _labelPhoneEntrySubject.close();
  }

}
