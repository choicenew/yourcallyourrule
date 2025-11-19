import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart' as drift;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/database/local/local_database.dart';
import '../../data/database/sync/device_id_service.dart';

/// 同步结果模型
class SyncResult {
  final bool success;
  final int pushedCount; // 修复：与调用处参数名一致
  final int pulledCount; // 修复：与调用处参数名一致
  final String? errorMessage;

  SyncResult({
    this.success = false,
    this.pushedCount = 0,
    this.pulledCount = 0,
    this.errorMessage,
  });
}

class SupabaseSyncManager {
  final LocalDatabase _localDb;
  final SupabaseClient _supabase;
  final DeviceIdService _deviceIdService;
  final bool _syncCallLogs;

  static const String _prefLastSyncKey = 'supabase_sync_last_timestamp';

  SupabaseSyncManager({
    required LocalDatabase localDb,
    required SupabaseClient supabase,
    required DeviceIdService deviceIdService,
    bool syncCallLogs = false,
  })  : _localDb = localDb,
        _supabase = supabase,
        _deviceIdService = deviceIdService,
        _syncCallLogs = syncCallLogs;

  /// 执行同步
  Future<SyncResult> sync() async {
    try {
      final deviceId = await _deviceIdService.getDeviceId();
      final lastSyncTime = await _getLastSyncTime();
      final now = DateTime.now().toUtc();

      debugPrint('🔄 Sync Start. Device: $deviceId, LastSync: $lastSyncTime');

      int totalPushed = 0;
      int totalPulled = 0;

      // 1. Contacts
      final contactsRes = await _syncTable(
        tableName: 'contacts',
        deviceId: deviceId,
        lastSync: lastSyncTime,
        getLocalChanges: () async {
          final query = _localDb.select(_localDb.contacts);
          final all = await query.get();
          if (lastSyncTime == null) return all;
          return all.where((c) {
            final updated = DateTime.tryParse(c.lastUpdated);
            return updated != null && updated.isAfter(lastSyncTime);
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

      // 2. Rules
      final rulesRes = await _syncTable(
        tableName: 'rules',
        deviceId: deviceId,
        lastSync: lastSyncTime,
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

      // 3. SmsRules
      final smsRes = await _syncTable(
        tableName: 'sms_rules',
        deviceId: deviceId,
        lastSync: lastSyncTime,
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

      // 4. Call History
      if (_syncCallLogs) {
        final callRes = await _syncTable(
          tableName: 'call_history',
          deviceId: deviceId,
          lastSync: lastSyncTime,
          getLocalChanges: () async {
            final query = _localDb.select(_localDb.callHistory);
            final all = await query.get();
            if (lastSyncTime == null) return all;
            return all.where((log) {
              final ts = int.tryParse(log.timestamp) ?? 0;
              // 假设 timestamp 是毫秒级
              return DateTime.fromMillisecondsSinceEpoch(ts).isAfter(lastSyncTime);
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

      await _setLastSyncTime(now);

      // 修复：这里不再报错，因为我们定义了对应的命名参数
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

  Future<DateTime?> _getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(_prefLastSyncKey);
    return str != null ? DateTime.parse(str) : null;
  }

  Future<void> _setLastSyncTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefLastSyncKey, time.toIso8601String());
  }
}