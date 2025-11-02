import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 插件数据同步服务类，负责将插件数据和标签电话条目同步到远程号码服务
/// 监听插件数据流和标签电话条目流，并将数据转换为远程号码条目
class PluginToRemoteSyncService {
  final RemoteNumberService _remoteNumberService;
  StreamSubscription<dynamic>? _dataSubscription;

  PluginToRemoteSyncService(this._remoteNumberService);

  /// 开始监听插件数据流并同步到远程号码服务
  void startSync(Stream<PluginSourceData> pluginDataStream, [Stream<LabelPhoneEntry>? labelPhoneEntryStream]) {
    _dataSubscription?.cancel();
    
    // 合并两个数据流，使用merge操作符
    if (labelPhoneEntryStream != null) {
      final mergedStream = pluginDataStream.map((data) => {'type': 'plugin', 'data': data})
        .mergeWith([labelPhoneEntryStream.map((data) => {'type': 'label', 'data': data})]);
      
      _dataSubscription = mergedStream.listen((event) {
        if (event['type'] == 'plugin') {
          _handleData(event['data'] as PluginSourceData, null);
        } else if (event['type'] == 'label') {
          _handleData(null, event['data'] as LabelPhoneEntry);
        }
      });
    } else {
      // 只有插件数据流
      _dataSubscription = pluginDataStream.listen((data) => _handleData(data, null));
    }
  }

  /// 统一处理数据并转换为远程号码条目
  /// 可以处理PluginData或LabelPhoneEntry
  Future<void> _handleData(PluginSourceData? pluginSourceData, LabelPhoneEntry? labelPhoneEntry) async {
    // 确定要处理的电话号码
    PhoneNumber? phoneNumber;
    if (pluginSourceData != null && pluginSourceData.phoneNumber != null) {
      phoneNumber = PhoneNumber.fromString(pluginSourceData.phoneNumber!);
    } else if (labelPhoneEntry != null) {
      phoneNumber = labelPhoneEntry.phoneNumber;
    } else {
      return; // 没有有效的电话号码，直接返回
    }
    
    final existingEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
    
    if (existingEntry != null) {
      // 更新现有条目
      final updatedEntry = RemoteNumberEntry(
        id: existingEntry.id,
        phoneNumber: phoneNumber,
        name: _determineName(pluginSourceData, labelPhoneEntry, existingEntry),
        label: _determineLabel(pluginSourceData, existingEntry),
        priority: existingEntry.priority,
        count: pluginSourceData?.count ?? existingEntry.count,
        action: _determineAction(pluginSourceData, labelPhoneEntry, existingEntry),
        isEnabled: existingEntry.isEnabled,
      );
      await _remoteNumberService.updateRemoteNumber(updatedEntry);
       //增加一个函数保存isocountrycode
       //首先引入phone_utils.dart获得 countryCode
      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(phoneNumber.value, null);
      final countryCode = phoneDetails['countryCode'];
      if (countryCode != null && countryCode.isNotEmpty) {
        await _remoteNumberService.linkNumberToCountry(phoneNumber.value, countryCode);
      }
    } else {
      // 创建新条目
      final newEntry = RemoteNumberEntry(
        id: const Uuid().v4(),
        phoneNumber: phoneNumber,
        name: pluginSourceData?.name ?? labelPhoneEntry?.name ?? '',
        label: pluginSourceData?.predefinedLabel ?? '',
        priority: const RulePriority(0),
        count: pluginSourceData?.count ?? 0,
        action: _determineAction(pluginSourceData, labelPhoneEntry, null),
        isEnabled: true,
      );
      await _remoteNumberService.addRemoteNumber(newEntry);
       //增加一个函数保存isocountrycode
       //首先引入phone_utils.dart获得 countryCode
      final phoneDetails = await PhoneUtils.parsePhoneNumberWithoutIso(phoneNumber.value, null);
      final countryCode = phoneDetails['countryCode'];
      if (countryCode != null && countryCode.isNotEmpty) {
        await _remoteNumberService.linkNumberToCountry(phoneNumber.value, countryCode);
      }
    }
  }
  
  /// 确定名称
  String _determineName(PluginSourceData? pluginSourceData, LabelPhoneEntry? labelPhoneEntry, RemoteNumberEntry existingEntry) {
    if (pluginSourceData?.name != null && pluginSourceData!.name!.isNotEmpty) {
      return pluginSourceData.name!;
    } else if (labelPhoneEntry != null && labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }
  
  /// 确定标签
  String _determineLabel(PluginSourceData? pluginSourceData, RemoteNumberEntry existingEntry) {
    if (pluginSourceData?.predefinedLabel != null && pluginSourceData!.predefinedLabel!.isNotEmpty) {
      return pluginSourceData.predefinedLabel!;
    }
    
    return existingEntry.label;
   }
   
   /// 确定动作
   RuleAction _determineAction(PluginSourceData? pluginSourceData, LabelPhoneEntry? labelPhoneEntry, RemoteNumberEntry? existingEntry) {
     // 优先使用插件数据中的动作
     if (pluginSourceData != null && pluginSourceData.action != RuleAction.none) {
       return pluginSourceData.action;
     }
     
     // 其次使用标签电话条目中的动作
     if (labelPhoneEntry != null && labelPhoneEntry.action != RuleAction.none) {
       return labelPhoneEntry.action;
     }
     
     // 最后使用现有条目中的动作或默认值
     return existingEntry?.action ?? RuleAction.none;
   }

  /// 停止同步服务
  void dispose() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }
}