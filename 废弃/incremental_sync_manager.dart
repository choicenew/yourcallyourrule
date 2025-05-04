import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sync_conflict_resolver.dart';
import '../core/entities/rule/rule_base.dart';
import '../core/entities/cloud_data_converter.dart';

class IncrementalSyncManager {
  final SyncConflictResolver _conflictResolver;

  IncrementalSyncManager(this._conflictResolver);

  Future<DateTime?> getLastSyncTime(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'last_sync_${serviceType}_$dataType';
    final timestamp = prefs.getString(key);
    
    if (timestamp == null) return null;
    
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      debugPrint('Error parsing last sync timestamp: $e');
      return null;
    }
  }

  Future<void> saveLastSyncTime(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'last_sync_${serviceType}_$dataType';
    final now = DateTime.now().toIso8601String();
    
    await prefs.setString(key, now);
  }

  Future<String?> getLastSyncHash(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_sync_hash_${serviceType}_$dataType');
  }

  Future<void> saveLastSyncHash(String serviceType, String dataType, String hash) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_sync_hash_${serviceType}_$dataType', hash);
  }

  Future<Map<String, dynamic>> syncSettingsIncrementally(
    String serviceType,
    Map<String, dynamic> localSettings,
    Map<String, dynamic> cloudSettings,
  ) async {
    final lastSyncHash = await getLastSyncHash(serviceType, 'settings');
    
    final conflictData = _conflictResolver.detectSettingsConflicts(
      localSettings,
      cloudSettings,
      lastSyncHash,
    );
    
    conflictData['localSettings'] = localSettings;
    conflictData['cloudSettings'] = cloudSettings;
    
    final resolvedSettings = _conflictResolver.resolveSettingsConflicts(
      conflictData,
      _conflictResolver.defaultStrategy,
    );
    
    final newHash = _conflictResolver.calculateSettingsHash(resolvedSettings);
    await saveLastSyncHash(serviceType, 'settings', newHash);
    await saveLastSyncTime(serviceType, 'settings');
    
    await _recordSyncHistory(serviceType, 'settings', {
      'timestamp': DateTime.now().toIso8601String(),
      'itemCount': resolvedSettings.length,
      'hadConflicts': conflictData['hasConflict'],
      'conflictCount': conflictData['hasConflict'] ? (conflictData['conflicts'] as Map).length : 0,
    });
    
    return resolvedSettings;
  }

  Future<List<RuleBase>> syncRulesIncrementally(
    String serviceType,
    List<RuleBase> localRules,
    List<RuleBase> cloudRules,
  ) async {
    final lastSyncHash = await getLastSyncHash('rules');
    final conflictData = _conflictResolver.detectRuleConflicts(localRules, cloudRules, lastSyncHash);
    conflictData['localRules'] = localRules;
    conflictData['cloudRules'] = cloudRules;

    final resolvedRules = _conflictResolver.resolveRuleConflicts(
      conflictData,
      _conflictResolver.defaultStrategy,
    );

    final newHash = _conflictResolver.calculateEntitiesHash(resolvedRules);
    await saveLastSyncHash(serviceType, 'rules', newHash);
    await saveLastSyncTime(serviceType, 'rules');

  Future<void> _recordSyncHistory(String serviceType, String dataType, Map<String, dynamic> details) async {
    final prefs = await SharedPreferences.getInstance();
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    final historyJson = prefs.getString(historyKey) ?? '[]';
    final List<dynamic> history = jsonDecode(historyJson);
    
    history.add(details);
    if (history.length > 50) {
      history.removeRange(0, history.length - 50);
    }
    
    await prefs.setString(historyKey, jsonEncode(history));
  }

    await _recordSyncHistory(serviceType, 'rules', {
      'timestamp': DateTime.now().toIso8601String(),
      'itemCount': resolvedRules.length,
      'hadConflicts': conflictData['hasConflict'],
      'conflictCount': conflictData['hasConflict'] ? (conflictData['conflicts'] as Map).length : 0,
    });

    return resolvedRules;
  }

  Future<List<RuleBase>> _detectChanges(
    List<RuleBase> localRules,
    List<RuleBase> cloudRules,
  ) async {
    final lastSync = await getLastSyncTime('rules');
    return localRules.where((rule) {
      final cloudRule = cloudRules.firstWhere(
        (c) => c.id == rule.id,
        orElse: () => RuleBase.empty(),
      );
      return CloudDataConverter.serialize(rule) != 
             CloudDataConverter.serialize(cloudRule);
    }).toList();
  }
}