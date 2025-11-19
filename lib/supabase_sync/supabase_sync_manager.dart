import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' as drift;

import '../../data/database/local/local_database.dart';
import '../../data/database/sync/device_id_service.dart';

/// 同步结果模型
class SyncResult {
  final bool success;
  final int pushedCount;
  final int pulledCount;
  final String? errorMessage;
  final bool skipped; // 是否因未到时间而跳过

  SyncResult({
    this.success = false,
    this.pushedCount = 0,
    this.pulledCount = 0,
    this.errorMessage,
    this.skipped = false,
  });
}

class SupabaseSyncManager {
  final LocalDatabase _localDb;
  final SupabaseClient _supabase;
  final DeviceIdService _deviceIdService;
  final bool _syncCallLogs;
  
  // 这些状态由 ConfigRepository 管理，通过构造函数传入
  final DateTime? _lastSyncTime;
  final int _syncIntervalHours;

  SupabaseSyncManager({
    required LocalDatabase localDb,
    required SupabaseClient supabase,
    required DeviceIdService deviceIdService,
    bool syncCallLogs = false,
    DateTime? lastSyncTime,
    int syncIntervalHours = 24,
  })  : _localDb = localDb,
        _supabase = supabase,
        _deviceIdService = deviceIdService,
        _syncCallLogs = syncCallLogs,
        _lastSyncTime = lastSyncTime,
        _syncIntervalHours = syncIntervalHours;

  /// 执行同步
  /// [force] 如果为 true，忽略时间间隔限制
  Future<SyncResult> sync({bool force = false}) async {
    try {
      // 1. 检查时间间隔
      if (!force && _lastSyncTime != null) {
        final diff = DateTime.now().difference(_lastSyncTime!);
        if (diff.inHours < _syncIntervalHours) {
          debugPrint('⏳ Sync skipped. Last sync: ${_lastSyncTime}, Interval: ${_syncIntervalHours}h');
          return SyncResult(success: true, skipped: true);
        }
      }

      final deviceId = await _deviceIdService.getDeviceId();
      // 使用 UTC 时间作为基准
      final now = DateTime.now().toUtc(); 

      debugPrint('🔄 Sync Start. Device: $deviceId, LastSync: $_lastSyncTime');

      int totalPushed = 0;
      int totalPulled = 0;

      // 2. Sync Contacts
      final contactsRes = await _syncTable(
        tableName: 'contacts',
        deviceId: deviceId,
        lastSync: _lastSyncTime,
        getLocalChanges: () async {
          final query = _localDb.select(_localDb.contacts);
          final all = await query.get();
          if (_lastSyncTime == null) return all;
          return all.where((c) {
            final updated = DateTime.tryParse(c.lastUpdated);
            return updated != null && updated.isAfter(_lastSyncTime!);
          }).toList();
        },
        localToRemote: (item) {
          final c = item as ContactData;
          return {
            'id': c.id, 'phone_number': c.phoneNumber, 'name': c.name,
            'avatar': c.avatar, 'url': c.url, 'note': c.note,
            'label_ids': c.labelIds, 'is_favorite': c.isFavorite,
            'last_updated': c.lastUpdated,
            'modified_by_device': deviceId,
          };
        },
        applyRemoteChanges: (remoteData) async {
          await _localDb.batch((batch) {
            for (var m in remoteData) {
              batch.insert(_localDb.contacts, ContactsCompanion(
                id: drift.Value(m['id']),
                phoneNumber: drift.Value(m['phone_number']),
                name: drift.Value(m['name']),
                avatar: drift.Value(m['avatar']),
                url: drift.Value(m['url']),
                note: drift.Value(m['note']),
                labelIds: drift.Value(m['label_ids']),
                isFavorite: drift.Value(m['is_favorite'] ?? 0),
                lastUpdated: drift.Value(m['last_updated'] ?? now.toIso8601String()),
              ), mode: drift.InsertMode.insertOrReplace);
            }
          });
        },
      );
      totalPushed += contactsRes.pushedCount;
      totalPulled += contactsRes.pulledCount;

      // 3. Sync Rules
      final rulesRes = await _syncTable(
        tableName: 'rules',
        deviceId: deviceId,
        lastSync: _lastSyncTime,
        getLocalChanges: () async => await _localDb.select(_localDb.rules).get(),
        localToRemote: (item) {
          final r = item as RuleData;
          return {
            'id': r.id, 'name': r.name, 'rule_type': r.ruleType,
            'phone_number': r.phoneNumber, 'label_id': r.labelId,
            'priority': r.priority, 'action': r.action,
            'is_enabled': r.isEnabled, 'pattern': r.pattern,
            'avatar': r.avatar, 'is_subscribed': r.isSubscribed,
            'count': r.count, 'modified_by_device': deviceId,
          };
        },
        applyRemoteChanges: (remoteData) async {
          await _localDb.batch((batch) {
            for (var m in remoteData) {
              batch.insert(_localDb.rules, RulesCompanion(
                id: drift.Value(m['id']),
                name: drift.Value(m['name']),
                ruleType: drift.Value(m['rule_type']),
                phoneNumber: drift.Value(m['phone_number']),
                labelId: drift.Value(m['label_id']),
                priority: drift.Value(m['priority']),
                action: drift.Value(m['action']),
                isEnabled: drift.Value(m['is_enabled']),
                pattern: drift.Value(m['pattern']),
                avatar: drift.Value(m['avatar']),
                isSubscribed: drift.Value(m['is_subscribed']),
                count: drift.Value(m['count']),
              ), mode: drift.InsertMode.insertOrReplace);
            }
          });
        },
      );
      totalPushed += rulesRes.pushedCount;
      totalPulled += rulesRes.pulledCount;

      // 4. Sync SmsRules
      final smsRes = await _syncTable(
        tableName: 'sms_rules',
        deviceId: deviceId,
        lastSync: _lastSyncTime,
        getLocalChanges: () async => await _localDb.select(_localDb.smsRules).get(),
        localToRemote: (item) {
          final r = item as SmsRuleData;
          return {
            'id': r.id, 'name': r.name, 'content_regex': r.contentRegex,
            'sender_regex': r.senderRegex, 'action': r.action,
            'priority': r.priority, 'is_enabled': r.isEnabled,
            'rule_type': r.ruleType, 'modified_by_device': deviceId,
          };
        },
        applyRemoteChanges: (remoteData) async {
          await _localDb.batch((batch) {
            for (var m in remoteData) {
              batch.insert(_localDb.smsRules, SmsRulesCompanion(
                id: drift.Value(m['id']),
                name: drift.Value(m['name']),
                contentRegex: drift.Value(m['content_regex']),
                senderRegex: drift.Value(m['sender_regex']),
                action: drift.Value(m['action']),
                priority: drift.Value(m['priority']),
                isEnabled: drift.Value(m['is_enabled']),
                ruleType: drift.Value(m['rule_type']),
              ), mode: drift.InsertMode.insertOrReplace);
            }
          });
        },
      );
      totalPushed += smsRes.pushedCount;
      totalPulled += smsRes.pulledCount;

      // 5. Sync Call History
      if (_syncCallLogs) {
        final callRes = await _syncTable(
          tableName: 'call_history',
          deviceId: deviceId,
          lastSync: _lastSyncTime,
          getLocalChanges: () async {
            final query = _localDb.select(_localDb.callHistory);
            final all = await query.get();
            if (_lastSyncTime == null) return all;
            return all.where((log) {
              final ts = int.tryParse(log.timestamp) ?? 0;
              return DateTime.fromMillisecondsSinceEpoch(ts).isAfter(_lastSyncTime!);
            }).toList();
          },
          localToRemote: (item) {
            final c = item as CallHistoryData;
            return {
              'id': c.id, 'phone_number': c.phoneNumber, 'name': c.name,
              'timestamp': c.timestamp, 'end_time': c.endTime,
              'duration': c.duration, 'sim_display_name': c.simDisplayName,
              'call_type': c.callType, 'sim_slot_index': c.simSlotIndex,
              'carrier_name': c.carrierName, 'country_iso': c.countryIso,
              'subscription_id': c.subscriptionId, 'label_ids': c.labelIds,
              'modified_by_device': deviceId,
            };
          },
          applyRemoteChanges: (remoteData) async {
            await _localDb.batch((batch) {
              for (var m in remoteData) {
                batch.insert(_localDb.callHistory, CallHistoryCompanion(
                  id: drift.Value(m['id']),
                  phoneNumber: drift.Value(m['phone_number']),
                  name: drift.Value(m['name']),
                  timestamp: drift.Value(m['timestamp']),
                  endTime: drift.Value(m['end_time']),
                  duration: drift.Value(m['duration']),
                  simDisplayName: drift.Value(m['sim_display_name']),
                  callType: drift.Value(m['call_type']),
                  simSlotIndex: drift.Value(m['sim_slot_index']),
                  carrierName: drift.Value(m['carrier_name']),
                  countryIso: drift.Value(m['country_iso']),
                  subscriptionId: drift.Value(m['subscription_id']),
                  labelIds: drift.Value(m['label_ids']),
                ), mode: drift.InsertMode.insertOrReplace);
              }
            });
          },
        );
        totalPushed += callRes.pushedCount;
        totalPulled += callRes.pulledCount;
      }

      // 注意：这里不保存 LastSyncTime，由 Controller/Provider 负责保存
      return SyncResult(
        success: true,
        pushedCount: totalPushed,
        pulledCount: totalPulled,
      );

    } catch (e) {
      debugPrint('Supabase Sync Error: $e');
      return SyncResult(success: false, errorMessage: e.toString());
    }
  }

  Future<SyncResult> _syncTable({
    required String tableName,
    required String deviceId,
    required DateTime? lastSync,
    required Future<List<dynamic>> Function() getLocalChanges,
    required Map<String, dynamic> Function(dynamic) localToRemote,
    required Future<void> Function(List<dynamic>) applyRemoteChanges,
  }) async {
    int pushed = 0;
    int pulled = 0;

    // Push
    final localItems = await getLocalChanges();
    if (localItems.isNotEmpty) {
      final List<Map<String, dynamic>> batch = [];
      for (var item in localItems) {
        batch.add(localToRemote(item));
      }
      for (var i = 0; i < batch.length; i += 50) {
        final end = (i + 50 < batch.length) ? i + 50 : batch.length;
        await _supabase.from(tableName).upsert(batch.sublist(i, end), onConflict: 'id');
      }
      pushed = batch.length;
    }

    // Pull
    var query = _supabase.from(tableName).select();
    if (lastSync != null) {
      query = query.gt('updated_at', lastSync.toIso8601String());
    }
    query = query.neq('modified_by_device', deviceId);

    final List<dynamic> remoteItems = await query;
    if (remoteItems.isNotEmpty) {
      await applyRemoteChanges(remoteItems);
      pulled = remoteItems.length;
    }

    return SyncResult(success: true, pushedCount: pushed, pulledCount: pulled);
  }
}