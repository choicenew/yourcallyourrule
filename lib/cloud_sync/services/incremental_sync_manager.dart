import 'dart:convert';
import 'package:flutter/foundation.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/cloud_sync/services/sync_conflict_resolver.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

/// Class responsible for managing incremental synchronization
class IncrementalSyncManager {
  /// Sync conflict resolver
  final SyncConflictResolver _conflictResolver;
  
  /// Constructor
  IncrementalSyncManager(this._conflictResolver);
  
  /// Get last sync timestamp for a specific service and data type
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
  
  /// Save last sync timestamp for a specific service and data type
  Future<void> saveLastSyncTime(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'last_sync_${serviceType}_$dataType';
    final now = DateTime.now().toIso8601String();
    
    await prefs.setString(key, now);
  }
  
  /// Get last sync hash for a specific service and data type
  Future<String?> getLastSyncHash(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'last_sync_hash_${serviceType}_$dataType';
    
    return prefs.getString(key);
  }
  
  /// Save last sync hash for a specific service and data type
  Future<void> saveLastSyncHash(String serviceType, String dataType, String hash) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'last_sync_hash_${serviceType}_$dataType';
    
    await prefs.setString(key, hash);
  }
  
  /// Determine if incremental sync is needed based on last sync time
  Future<bool> isIncrementalSyncNeeded(
    String serviceType,
    String dataType,
    Duration threshold,
  ) async {
    final lastSync = await getLastSyncTime(serviceType, dataType);
    if (lastSync == null) return true; // First sync
    
    final now = DateTime.now();
    final difference = now.difference(lastSync);
    
    return difference > threshold;
  }
  
  /// Perform incremental sync for rules
  Future<List<RuleBase>> syncRulesIncrementally(
    String serviceType,
    List<RuleBase> localRules,
    List<RuleBase> cloudRules,
  ) async {
    // Get last sync hash
    final lastSyncHash = await getLastSyncHash(serviceType, 'rules');
    
    // Detect conflicts
    final conflictData = await _conflictResolver.resolveConflicts({
      'rules': {
        'local': localRules,
        'cloud': cloudRules,
        'lastSyncHash': lastSyncHash
      }
    });
    
    // Add additional data needed for resolution
    conflictData['localRules'] = localRules;
    conflictData['cloudRules'] = cloudRules;
    
    // Resolve conflicts using the default strategy
    final resolvedRules = conflictData['rules'] as List<RuleBase>;
    
    // Save new hash after successful sync
    final newHash = _conflictResolver.calculateEntitiesHash(resolvedRules.cast<RuleBase>());
    await saveLastSyncHash(serviceType, 'rules', newHash);
    await saveLastSyncTime(serviceType, 'rules');
    
    // Record sync history
    await recordSyncHistory(serviceType, 'rules', {
      'timestamp': DateTime.now().toIso8601String(),
      'itemCount': resolvedRules.length,
      'hadConflicts': conflictData['hasConflict'] as bool,
      'conflictCount': conflictData['hasConflict'] ? 
          (conflictData['conflicts'] as Map<String, dynamic>).length : 0,
    });
    
    return resolvedRules;
  }
  
  /// Perform incremental sync for settings
  Future<Map<String, dynamic>> syncSettingsIncrementally(
    String serviceType,
    Map<String, dynamic> localSettings,
    Map<String, dynamic> cloudSettings,
  ) async {
    // Get last sync hash
    final lastSyncHash = await getLastSyncHash(serviceType, 'settings');
    
    // Detect conflicts
    final conflictData = await _conflictResolver.resolveConflicts({
      'settings': {
        'local': localSettings,
        'cloud': cloudSettings,
        'lastSyncHash': lastSyncHash
      }
    });
    
    // Add additional data needed for resolution
    conflictData['localSettings'] = localSettings;
    conflictData['cloudSettings'] = cloudSettings;
    
    // Resolve conflicts using the default strategy
    final resolvedSettings = conflictData['settings'] as Map<String, dynamic>;
    
    // Save new hash after successful sync
    final newHash = _conflictResolver.calculateSettingsHash(Map<String, dynamic>.from(resolvedSettings));
    await saveLastSyncHash(serviceType, 'settings', newHash);
    await saveLastSyncTime(serviceType, 'settings');
    
    // Record sync history
    await recordSyncHistory(serviceType, 'settings', {
      'timestamp': DateTime.now().toIso8601String(),
      'itemCount': resolvedSettings.length,
      'hadConflicts': conflictData['hasConflict'] as bool,
      'conflictCount': conflictData['hasConflict'] ? 
          (conflictData['conflicts'] as Map<String, dynamic>).length : 0,
    });
    
    return resolvedSettings;
  }
  
  /// Record sync history entry
  Future<void> recordSyncHistory(String serviceType, String dataType, Map<String, dynamic> details) async {
    final prefs = await SharedPreferences.getInstance();
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    // Get existing history
    final historyJson = prefs.getString(historyKey) ?? '[]';
    final List<dynamic> history = jsonDecode(historyJson);
    
    // Add new entry (limit to last 50 entries)
    history.add(details);
    if (history.length > 50) {
      history.removeRange(0, history.length - 50);
    }
    
    // Save updated history
    await prefs.setString(historyKey, jsonEncode(history));
  }
  
  /// Get sync history for a specific service and data type
  Future<List<Map<String, dynamic>>> getSyncHistory(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    final historyJson = prefs.getString(historyKey) ?? '[]';
    final List<dynamic> history = jsonDecode(historyJson);
    
    return history.map((item) => item as Map<String, dynamic>).toList();
  }
  
  /// Clear sync history for a specific service and data type
  Future<void> clearSyncHistory(String serviceType, String dataType) async {
    final prefs = await SharedPreferences.getInstance();
    final historyKey = 'sync_history_${serviceType}_$dataType';
    
    await prefs.remove(historyKey);
  }
  
  /// Get overall sync status for a service
  Future<Map<String, dynamic>> getOverallSyncStatus(String serviceType) async {
    final lastSyncRules = await getLastSyncTime(serviceType, 'rules');
    final lastSyncSettings = await getLastSyncTime(serviceType, 'settings');
    
    // Get most recent sync history entries
    final rulesHistory = await getSyncHistory(serviceType, 'rules');
    final settingsHistory = await getSyncHistory(serviceType, 'settings');
    
    final lastRulesSync = rulesHistory.isNotEmpty ? rulesHistory.last : null;
    final lastSettingsSync = settingsHistory.isNotEmpty ? settingsHistory.last : null;
    
    return {
      'lastSyncTime': {
        'rules': lastSyncRules?.toIso8601String(),
        'settings': lastSyncSettings?.toIso8601String(),
      },
      'lastSyncDetails': {
        'rules': lastRulesSync,
        'settings': lastSettingsSync,
      },
      'syncHistoryCounts': {
        'rules': rulesHistory.length,
        'settings': settingsHistory.length,
      },
    };
  }
}