import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auto_backup_service.dart';
import '../../services/backup_restore_database_service.dart';
import '../../services/backup_service.dart';
import '../../services/google_drive_service.dart';
import '../../services/onedrive_service.dart';
import '../../services/webdav_service.dart';
import '../../utils/purchase_state.dart';
import '../../utils/secure_storage.dart';
import '../../widgets/purchase_manager.dart';

BackupRestoreController createBackupRestoreController(BuildContext context) {
  final secureStorage = SecureStorage();
  final backupRestoreService = BackupRestoreService();
  
  final webDavService = WebDavService(secureStorage);
  final googleDriveService = GoogleDriveService();
  final oneDriveService = OneDriveService();
  
  final autoBackupService = AutoBackupService();
  
  final onlineBackupService = OnlineBackupService(
    autoBackupService,
    webDavService,
    googleDriveService,
    oneDriveService,
    backupRestoreService,
  );
  
  final purchaseState = Provider.of<PurchaseState>(context, listen: false);
  final inAppPurchaseManager = InAppPurchaseManager(context, purchaseState);

  // 创建 BackupRestoreController
  return BackupRestoreController(
    onlineBackupService: onlineBackupService,
    webDavService: webDavService,
    googleDriveService: googleDriveService,
    oneDriveService: oneDriveService,
    backupRestoreService: backupRestoreService,
    inAppPurchaseManager: inAppPurchaseManager,
    purchaseState: purchaseState, // 添加 purchaseState 参数    
  );
}

class BackupRestoreController extends ChangeNotifier {
  final OnlineBackupService onlineBackupService;
  final WebDavService webDavService;
  final GoogleDriveService googleDriveService;
  final OneDriveService oneDriveService;
  final BackupRestoreService backupRestoreService;
  final InAppPurchaseManager inAppPurchaseManager;
  final PurchaseState purchaseState; // 添加 purchaseState 成员变量  
  late SharedPreferencesAsync _asyncPrefs;

  BackupRestoreController({
    required this.onlineBackupService,
    required this.webDavService,
    required this.googleDriveService,
    required this.oneDriveService,
    required this.backupRestoreService,
    required this.inAppPurchaseManager,
    required this.purchaseState, // 添加 purchaseState 参数    
  }) {
    _initSharedPreferences();
  }



  Future<void> _initSharedPreferences() async {
    _asyncPrefs = SharedPreferencesAsync();
  }



// 自动备份方法
Future<void> toggleAutoBackup(bool enabled) async {
  // 设置自动本地备份是否启用
  await onlineBackupService.setAutoLocalBackupEnabled(enabled);
  // 根据启用状态启动或停止自动本地备份
  if (enabled) {
    await onlineBackupService.startAutoLocalBackup();
  } else {
    await onlineBackupService.stopAutoLocalBackup();
  }
}

  Future<bool> isAutoBackupEnabled() async { 
    return await onlineBackupService.isAutoLocalBackupEnabled();
  }



Future<void> manualBackup({required BuildContext context, String? backupDirName}) async {


  await backupRestoreService.backup();
  if (purchaseState.isPurchasedOrHasTempAccess()) {
    if (await onlineBackupService.isAutoWebDAVBackupEnabled()) {
      await webDavService.backup(backupDirName: backupDirName);
    }
    if (await onlineBackupService.isAutoGoogleDriveBackupEnabled()) {
      await googleDriveService.backup(backupDirName: backupDirName);
    }
    if (await onlineBackupService.isAutoOneDriveBackupEnabled()) {
      await oneDriveService.backup(backupDirName: backupDirName);
    }
  } else {
    _showPurchaseDialog(context);
  }
}


  // Restore Methods
  Future<void> restore(
      {required String source, required BuildContext context, String? backupDirName}) async {
    switch (source) {
      case 'local':
        await backupRestoreService.restore();
        break;
      case 'webdav':
        if (purchaseState.isPurchasedOrHasTempAccess()) {
          await webDavService.restore(backupDirName: backupDirName, context: context);
        } else {
          _showPurchaseDialog(context);
        }
        break;
      case 'googledrive':
        if (purchaseState.isPurchasedOrHasTempAccess()) {
          await googleDriveService.restore(backupDirName: backupDirName, context: context);
        } else {
          _showPurchaseDialog(context);
        }
        break;
      case 'onedrive':
        if (purchaseState.isPurchasedOrHasTempAccess()) {
          await oneDriveService.restore(backupDirName: backupDirName, context: context);
        } else {
          _showPurchaseDialog(context);
        }
        break;
    }
  }

  // Keep Only Latest Backup
  Future<void> toggleKeepOnlyLatestBackup(bool enabled) async {
    await onlineBackupService.setAutoLocalBackupKeepOnlyLatest(enabled);
  }

  Future<bool> isKeepOnlyLatestBackupEnabled() async { 
    return await onlineBackupService.isAutoLocalBackupKeepOnlyLatest();
  }

  // Backup Directory Name
  Future<void> setBackupDirectoryName(String name) async {
    await _asyncPrefs.setString('backupDirectoryName', name);
  }

  Future<String> getBackupDirectoryName() async {
    return await _asyncPrefs.getString('backupDirectoryName') ?? 'ycyr';
  }



// 云服务方法
Future<void> toggleCloudService(String service, bool enabled, String? backupDirName) async {
  // 检查本地备份是否启用且用户已购买或拥有临时访问权限
  if (await isAutoBackupEnabled() && purchaseState.isPurchasedOrHasTempAccess()) {
    switch (service) {
      case 'webdav':
        await onlineBackupService.setAutoWebDAVBackupEnabled(enabled, backupDirName);
        break;
      case 'googledrive':
        await onlineBackupService.setAutoGoogleDriveBackupEnabled(enabled, backupDirName);
        break;
      case 'onedrive':
        await onlineBackupService.setAutoOneDriveBackupEnabled(enabled, backupDirName);
        break;
    }
  // 如果尝试关闭云服务，并且本地备份未启用或未购买，则确保关闭云服务
  } else if (!enabled) {
    switch (service) {
      case 'webdav':
        await onlineBackupService.setAutoWebDAVBackupEnabled(false, backupDirName);
        break;
      case 'googledrive':
        await onlineBackupService.setAutoGoogleDriveBackupEnabled(false, backupDirName);
        break;
      case 'onedrive':
        await onlineBackupService.setAutoOneDriveBackupEnabled(false, backupDirName);
        break;
    }
  }
}

  Future<bool> isCloudServiceEnabled(String service) async {
    switch (service) {
      case 'webdav':
        return onlineBackupService.isAutoWebDAVBackupEnabled();
      case 'googledrive':
        return onlineBackupService.isAutoGoogleDriveBackupEnabled();
      case 'onedrive':
        return onlineBackupService.isAutoOneDriveBackupEnabled();
      default:
        return false;
    }
  }

  // Cloud service sign-in methods
  Future<bool> signInWebDAV() async {
    return await webDavService.isConnected();
  }

  Future<bool> signInGoogleDrive() async {
    return await googleDriveService.signIn();
  }

  Future<bool> signInOneDrive() async {
    return await oneDriveService.signIn();
  }

  // Cloud service sign-out methods
  Future<void> signOutWebDAV(String? backupDirName) async {
    await toggleCloudService('webdav', false, backupDirName);
  }

  Future<void> signOutGoogleDrive(String? backupDirName) async {
    await googleDriveService.signOut();
    await toggleCloudService('googledrive', false, backupDirName);
  }

  Future<void> signOutOneDrive(String? backupDirName) async {
    await oneDriveService.signOut();
    await toggleCloudService('onedrive', false, backupDirName);
  }

  // WebDAV settings
  Future<void> saveWebDAVSettings(
      String url, String username, String password) async {
    await webDavService.saveCredentials(url, username, password);
  }

  void _showPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Premium Feature'),
          content: const Text('This feature requires a premium subscription.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Purchase'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchasePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
  
}
