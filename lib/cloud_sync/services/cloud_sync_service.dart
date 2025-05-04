
import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

/// Interface for cloud synchronization services
abstract class CloudSyncService {
  /// Initialize the cloud sync service with necessary configurations
  Future<void> initialize(Map<String, dynamic> config);
  
  /// Check if the service is properly configured and connected
  Future<bool> isConfigured();
  
  /// Connect to the cloud service
  Future<bool> connect(Map<String, dynamic> credentials);
  
  /// Disconnect from the cloud service
  Future<bool> disconnect();
  
  /// Sync rules to the cloud
  Future<bool> syncRules(List<RuleBase> rules);
  
  /// Get rules from the cloud
  Future<List<RuleBase>> getRulesFromCloud();
  
  /// Sync application settings to the cloud
  Future<bool> syncSettings(Map<String, dynamic> settings);
  
  /// Get application settings from the cloud
  Future<Map<String, dynamic>?> getSettingsFromCloud();
  
  /// Sync notification history to the cloud
  //Future<bool> syncNotificationHistory(List<Map<String, dynamic>> notifications);
  
  /// Get notification history from the cloud
 // Future<List<Map<String, dynamic>>> getNotificationHistoryFromCloud();
  
  /// Schedule automatic sync
  Future<bool> scheduleAutomaticSync(Duration interval);
  
  /// Cancel scheduled automatic sync
  Future<bool> cancelAutomaticSync();
  
  /// Resolve sync conflicts
  Future<Map<String, dynamic>> resolveSyncConflicts(Map<String, dynamic> conflicts);
  
  /// Get sync status
  Future<Map<String, dynamic>> getSyncStatus();
  
  /// Register device for multi-device synchronization
  Future<bool> registerDeviceForSync(DeviceEntity device);
  
  /// Get all registered devices from cloud
  Future<List<DeviceEntity>> getRegisteredDevicesFromCloud();
  
  /// Sync device information to cloud
  Future<bool> syncDeviceInfo(DeviceEntity device);
  
  /// Sync devices from cloud to local device registry
  Future<bool> syncDevicesFromCloud();
  
  /// Get the service type identifier (WebDAV, OneDrive, Google Drive, etc.)
  String get serviceType;
  
  /// Get a user-friendly name for this service
  String get serviceName;
}