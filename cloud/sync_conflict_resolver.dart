import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:notification_manager/domain/entities/rule_entity.dart';

/// Enum representing different conflict resolution strategies
enum ConflictResolutionStrategy {
  /// Always use local version
  localWins,
  
  /// Always use cloud version
  cloudWins,
  
  /// Merge both versions when possible
  merge,
  
  /// Ask user to decide
  askUser,
  
  /// Keep both versions
  keepBoth
}

/// Class responsible for detecting and resolving sync conflicts
class SyncConflictResolver {
  /// Default conflict resolution strategy
  ConflictResolutionStrategy defaultStrategy;
  
  /// Constructor
  SyncConflictResolver({this.defaultStrategy = ConflictResolutionStrategy.askUser});
  
  /// Calculate hash for a list of rules
  String calculateRulesHash(List<RuleEntity> rules) {
    final sortedRules = List<RuleEntity>.from(rules);
    sortedRules.sort((a, b) => a.id.compareTo(b.id));
    
    final jsonString = jsonEncode(sortedRules.map((rule) => rule.toJson()).toList());
    final bytes = utf8.encode(jsonString);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
  
  /// Calculate hash for settings
  String calculateSettingsHash(Map<String, dynamic> settings) {
    final sortedKeys = settings.keys.toList()..sort();
    final sortedMap = <String, dynamic>{};
    
    for (final key in sortedKeys) {
      sortedMap[key] = settings[key];
    }
    
    final jsonString = jsonEncode(sortedMap);
    final bytes = utf8.encode(jsonString);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
  
  /// Calculate hash for notification history
  String calculateNotificationsHash(List<Map<String, dynamic>> notifications) {
    final sortedNotifications = List<Map<String, dynamic>>.from(notifications);
    sortedNotifications.sort((a, b) {
      final aId = a['id'] as String?;
      final bId = b['id'] as String?;
      if (aId == null || bId == null) return 0;
      return aId.compareTo(bId);
    });
    
    final jsonString = jsonEncode(sortedNotifications);
    final bytes = utf8.encode(jsonString);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
  
  /// Detect conflicts between local and cloud rules
  Map<String, dynamic> detectRuleConflicts(
    List<RuleEntity> localRules,
    List<RuleEntity> cloudRules,
    String? lastSyncHash,
  ) {
    final localHash = calculateRulesHash(localRules);
    final cloudHash = calculateRulesHash(cloudRules);
    
    // If hashes match, no conflict
    if (localHash == cloudHash) {
      return {
        'hasConflict': false,
        'localHash': localHash,
        'cloudHash': cloudHash,
      };
    }
    
    // If last sync hash matches either local or cloud, no conflict (just one side changed)
    if (lastSyncHash != null && (localHash == lastSyncHash || cloudHash == lastSyncHash)) {
      return {
        'hasConflict': false,
        'localHash': localHash,
        'cloudHash': cloudHash,
        'newerVersion': localHash == lastSyncHash ? 'cloud' : 'local',
      };
    }
    
    // Identify specific rule conflicts
    final localRulesMap = {for (var rule in localRules) rule.id: rule};
    final cloudRulesMap = {for (var rule in cloudRules) rule.id: rule};
    
    final conflicts = <String, Map<String, dynamic>>{};
    
    // Check for rules that exist in both but have different content
    for (final localRule in localRules) {
      final cloudRule = cloudRulesMap[localRule.id];
      if (cloudRule != null) {
        final localRuleJson = jsonEncode(localRule.toJson());
        final cloudRuleJson = jsonEncode(cloudRule.toJson());
        
        if (localRuleJson != cloudRuleJson) {
          conflicts[localRule.id] = {
            'local': localRule,
            'cloud': cloudRule,
            'type': 'modified',
          };
        }
      }
    }
    
    // Check for rules that exist only in local
    for (final localRule in localRules) {
      if (!cloudRulesMap.containsKey(localRule.id)) {
        conflicts[localRule.id] = {
          'local': localRule,
          'cloud': null,
          'type': 'localOnly',
        };
      }
    }
    
    // Check for rules that exist only in cloud
    for (final cloudRule in cloudRules) {
      if (!localRulesMap.containsKey(cloudRule.id)) {
        conflicts[cloudRule.id] = {
          'local': null,
          'cloud': cloudRule,
          'type': 'cloudOnly',
        };
      }
    }
    
    return {
      'hasConflict': true,
      'localHash': localHash,
      'cloudHash': cloudHash,
      'conflicts': conflicts,
    };
  }
  
  /// Resolve rule conflicts based on strategy
  List<RuleEntity> resolveRuleConflicts(
    Map<String, dynamic> conflictData,
    ConflictResolutionStrategy strategy,
  ) {
    if (!conflictData['hasConflict']) {
      // No conflict, return newer version
      final newerVersion = conflictData['newerVersion'];
      if (newerVersion == 'cloud') {
        return conflictData['cloudRules'] as List<RuleEntity>;
      } else {
        return conflictData['localRules'] as List<RuleEntity>;
      }
    }
    
    final conflicts = conflictData['conflicts'] as Map<String, Map<String, dynamic>>;
    final localRules = conflictData['localRules'] as List<RuleEntity>;
    final cloudRules = conflictData['cloudRules'] as List<RuleEntity>;
    
    // Create a map of all rules by ID for easy access
    final localRulesMap = {for (var rule in localRules) rule.id: rule};
    final cloudRulesMap = {for (var rule in cloudRules) rule.id: rule};
    
    // Result will contain resolved rules
    final resolvedRules = <RuleEntity>[];
    
    // Apply resolution strategy
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return localRules;
        
      case ConflictResolutionStrategy.cloudWins:
        return cloudRules;
        
      case ConflictResolutionStrategy.merge:
        // Add all non-conflicting rules
        for (final ruleId in {...localRulesMap.keys, ...cloudRulesMap.keys}) {
          if (!conflicts.containsKey(ruleId)) {
            final rule = localRulesMap[ruleId] ?? cloudRulesMap[ruleId];
            if (rule != null) {
              resolvedRules.add(rule);
            }
          }
        }
        
        // Resolve each conflict
        for (final conflict in conflicts.values) {
          final type = conflict['type'] as String;
          
          switch (type) {
            case 'modified':
              // For modified rules, take the most recently updated one
              final localRule = conflict['local'] as RuleEntity;
              final cloudRule = conflict['cloud'] as RuleEntity;
              
              final localUpdated = localRule.updatedAt ?? localRule.createdAt;
              final cloudUpdated = cloudRule.updatedAt ?? cloudRule.createdAt;
              
              if (localUpdated.isAfter(cloudUpdated)) {
                resolvedRules.add(localRule);
              } else {
                resolvedRules.add(cloudRule);
              }
              break;
              
            case 'localOnly':
              // Rule exists only locally, might be new or deleted from cloud
              final localRule = conflict['local'] as RuleEntity;
              resolvedRules.add(localRule);
              break;
              
            case 'cloudOnly':
              // Rule exists only in cloud, might be new or deleted locally
              final cloudRule = conflict['cloud'] as RuleEntity;
              resolvedRules.add(cloudRule);
              break;
          }
        }
        return resolvedRules;
        
      case ConflictResolutionStrategy.keepBoth:
        // Keep all rules from both sources, potentially creating duplicates
        return [...localRules, ...cloudRules.where((rule) => !localRulesMap.containsKey(rule.id))];
        
      case ConflictResolutionStrategy.askUser:
        // This would be handled by the UI, return local rules as default
        debugPrint('User decision required for conflict resolution');
        return localRules;
    }
  }
  
  /// Similar methods for settings and notification history conflicts
  Map<String, dynamic> detectSettingsConflicts(
    Map<String, dynamic> localSettings,
    Map<String, dynamic> cloudSettings,
    String? lastSyncHash,
  ) {
    final localHash = calculateSettingsHash(localSettings);
    final cloudHash = calculateSettingsHash(cloudSettings);
    
    // If hashes match, no conflict
    if (localHash == cloudHash) {
      return {
        'hasConflict': false,
        'localHash': localHash,
        'cloudHash': cloudHash,
      };
    }
    
    // If last sync hash matches either local or cloud, no conflict (just one side changed)
    if (lastSyncHash != null && (localHash == lastSyncHash || cloudHash == lastSyncHash)) {
      return {
        'hasConflict': false,
        'localHash': localHash,
        'cloudHash': cloudHash,
        'newerVersion': localHash == lastSyncHash ? 'cloud' : 'local',
      };
    }
    
    // Identify specific setting conflicts
    final conflicts = <String, Map<String, dynamic>>{};
    
    // Check for settings that exist in both but have different values
    for (final key in localSettings.keys) {
      if (cloudSettings.containsKey(key)) {
        final localValue = localSettings[key];
        final cloudValue = cloudSettings[key];
        
        if (localValue != cloudValue) {
          conflicts[key] = {
            'local': localValue,
            'cloud': cloudValue,
            'type': 'modified',
          };
        }
      } else {
        conflicts[key] = {
          'local': localSettings[key],
          'cloud': null,
          'type': 'localOnly',
        };
      }
    }
    
    // Check for settings that exist only in cloud
    for (final key in cloudSettings.keys) {
      if (!localSettings.containsKey(key)) {
        conflicts[key] = {
          'local': null,
          'cloud': cloudSettings[key],
          'type': 'cloudOnly',
        };
      }
    }
    
    return {
      'hasConflict': true,
      'localHash': localHash,
      'cloudHash': cloudHash,
      'conflicts': conflicts,
    };
  }
  
  /// Resolve settings conflicts based on strategy
  Map<String, dynamic> resolveSettingsConflicts(
    Map<String, dynamic> conflictData,
    ConflictResolutionStrategy strategy,
  ) {
    if (!conflictData['hasConflict']) {
      // No conflict, return newer version
      final newerVersion = conflictData['newerVersion'];
      if (newerVersion == 'cloud') {
        return conflictData['cloudSettings'] as Map<String, dynamic>;
      } else {
        return conflictData['localSettings'] as Map<String, dynamic>;
      }
    }
    
    final conflicts = conflictData['conflicts'] as Map<String, Map<String, dynamic>>;
    final localSettings = conflictData['localSettings'] as Map<String, dynamic>;
    final cloudSettings = conflictData['cloudSettings'] as Map<String, dynamic>;
    
    // Result will contain resolved settings
    final resolvedSettings = <String, dynamic>{};
    
    // Apply resolution strategy
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return localSettings;
        
      case ConflictResolutionStrategy.cloudWins:
        return cloudSettings;
        
      case ConflictResolutionStrategy.merge:
        // Start with all non-conflicting settings
        for (final key in {...localSettings.keys, ...cloudSettings.keys}) {
          if (!conflicts.containsKey(key)) {
            resolvedSettings[key] = localSettings[key] ?? cloudSettings[key];
          }
        }
        
        // Resolve each conflict
        for (final entry in conflicts.entries) {
          final key = entry.key;
          final conflict = entry.value;
          final type = conflict['type'] as String;
          
          switch (type) {
            case 'modified':
              // For modified settings, prefer local
              resolvedSettings[key] = localSettings[key];
              break;
              
            case 'localOnly':
              // Setting exists only locally
              resolvedSettings[key] = localSettings[key];
              break;
              
            case 'cloudOnly':
              // Setting exists only in cloud
              resolvedSettings[key] = cloudSettings[key];
              break;
          }
        }
        return resolvedSettings;
        
      case ConflictResolutionStrategy.keepBoth:
        // For settings, this doesn't make much sense, but we'll merge them
        return {...cloudSettings, ...localSettings};
        
      case ConflictResolutionStrategy.askUser:
        // This would be handled by the UI, return local settings as default
        debugPrint('User decision required for settings conflict resolution');
        return localSettings;
    }
  }
}