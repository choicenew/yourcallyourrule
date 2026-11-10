import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:yourcallyourrule/features/sync/services/cloud_sync/incremental_sync_manager_config.dart';
import 'package:yourcallyourrule/features/sync/services/cloud_sync/sync_conflict_resolver.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

/// Class responsible for managing incremental synchronization
class IncrementalSyncManager {
  /// Sync conflict resolver
  final SyncConflictResolver _conflictResolver;

  /// Config manager for storing sync information
  final IncrementalSyncManagerConfig _configManager;

  /// Constructor
  IncrementalSyncManager(this._conflictResolver, {required ConfigRepository configRepository})
      : _configManager = IncrementalSyncManagerConfig(configRepository: configRepository);

  /// Get last sync timestamp for a specific service and data type
  Future<DateTime?> getLastSyncTime(String serviceType, String dataType) async {
    return await _configManager.getLastSyncTime(serviceType, dataType);
  }

  /// Save last sync timestamp for a specific service and data type
  Future<void> saveLastSyncTime(String serviceType, String dataType) async {
    await _configManager.saveLastSyncTime(serviceType, dataType);
  }

  /// Get last sync hash for a specific service and data type
  Future<String?> getLastSyncHash(String serviceType, String dataType) async {
    return await _configManager.getLastSyncHash(serviceType, dataType);
  }

  /// Save last sync hash for a specific service and data type
  Future<void> saveLastSyncHash(String serviceType, String dataType, String hash) async {
    await _configManager.saveLastSyncHash(serviceType, dataType, hash);
  }

  /// Determine if incremental sync is needed based on last sync time
  Future<bool> isIncrementalSyncNeeded(
    String serviceType,
    String dataType,
    Duration threshold,
  ) async {
    final lastSync = await getLastSyncTime(serviceType, dataType);
    if (lastSync == null) return true;

    final now = DateTime.now();
    final difference = now.difference(lastSync);

    return difference > threshold;
  }

  /// Record sync history entry
  Future<void> recordSyncHistory(String serviceType, String dataType, Map<String, dynamic> details) async {
    await _configManager.recordSyncHistory(serviceType, dataType, details);
  }

  /// Get sync history for a specific service and data type
  Future<List<Map<String, dynamic>>> getSyncHistory(String serviceType, String dataType) async {
    return await _configManager.getSyncHistory(serviceType, dataType);
  }

  /// Clear sync history for a specific service and data type
  Future<void> clearSyncHistory(String serviceType, String dataType) async {
    await _configManager.clearSyncHistory(serviceType, dataType);
  }

  /// Get overall sync status for a service
  Future<Map<String, dynamic>> getOverallSyncStatus(String serviceType) async {
    final lastSyncRules = await getLastSyncTime(serviceType, 'rules');
    final lastSyncSettings = await getLastSyncTime(serviceType, 'settings');

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
