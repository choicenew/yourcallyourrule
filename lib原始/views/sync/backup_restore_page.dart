import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../new_set_icons.dart';
import '../../utils/ad_manager.dart';
import '../../utils/create_card.dart';
import '../../utils/get_default_external_dir.dart';
import '../../utils/purchase_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/google_ad.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/purchase_manager.dart';
import '../shield_switch_style.dart';
import '../subpage_style.dart';
import 'backup_restore_controller.dart';
import 'dialog.dart';

class BackupRestoreView extends StatefulWidget {
  const BackupRestoreView({super.key});

  @override
  BackupRestoreViewState createState() => BackupRestoreViewState();
}

class BackupRestoreViewState extends State<BackupRestoreView> {
  bool _isCollapsed = true; // 初始为折叠状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).sync),
      body: Column(
        children: [
          // Toggle button for collapsing/expanding content
          IconButton(
            icon: Icon(_isCollapsed ? Icons.expand_more : Icons.expand_less),
            onPressed: () {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
          ),

          // Collapsible content
          Visibility(
            visible: !_isCollapsed,
            child: Column(
              children: [
                // 导航到 SubscriptionListView 的 GestureDetector
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BackupRestoreView()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          final mediaQuery = MediaQuery.of(context);
                          const double cardRatio = 3 / 1.8;

                          final cardWidth = mediaQuery.size.width < 600
                              ? mediaQuery.size.width * 0.4
                              : mediaQuery.size.width < 900
                                  ? mediaQuery.size.width * 0.2
                                  : mediaQuery.size.width * 0.1;
                          final cardHeight = cardWidth / cardRatio;

                          return Container(
                            constraints: BoxConstraints(
                              maxWidth: cardWidth,
                              maxHeight: cardHeight,
                            ),
                            child: AspectRatio(
                              aspectRatio: 3.1 / 1.3,
                              child: createCard(const BackupRestoreView()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                FutureBuilder<Widget>(
                  future: Future.value(
                      const GoogleAdWidget(adInfo: AdManager.bannerAd)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),

          const Expanded(
            child: BackupRestorePage(),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class BackupRestorePage extends StatefulWidget {
  const BackupRestorePage({super.key});

  @override
  BackupRestorePageState createState() => BackupRestorePageState();
}

class BackupRestorePageState extends State<BackupRestorePage> {
  late InAppPurchaseManager inAppPurchaseManager;
  late TextEditingController _backupDirNameController;

  @override
  void initState() {
    super.initState();
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    inAppPurchaseManager = InAppPurchaseManager(context, purchaseState);
    _backupDirNameController =
        TextEditingController(); // 初始化 _backupDirNameController
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initBackupDirNameController(); // Call the asynchronous method after the first frame
    });
  }

  // Asynchronous method to initialize the text editing controller
  Future<void> _initBackupDirNameController() async {
    final controller =
        Provider.of<BackupRestoreController>(context, listen: false);
    final backupDirName = await controller.getBackupDirectoryName();
    _backupDirNameController = TextEditingController(text: backupDirName);
  }

  @override
  void dispose() {
    _backupDirNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BackupRestoreController>(context);

    return Scaffold(
      body: ListView(
        children: [
          _buildBackupDirectoryNameField(controller),
          _buildBackupDirectorySelector(controller), // 添加文件选择器
          _buildAutoBackupSwitch(controller),
          _buildKeepOnlyLatestBackupSwitch(controller),

          _buildCloudServicesSection(controller),
          _buildBackupRestoreButtons(controller),
        ],
      ),
    );
  }

  Widget _buildAutoBackupSwitch(BackupRestoreController controller) {
    return FutureBuilder<bool>(
      future: controller.isAutoBackupEnabled(),
      builder: (context, snapshot) {
        return SwitchListTile(
          title: const Text('Auto Backup'),
          value: snapshot.data ??
              false, // Use false as default if snapshot.data is null
          onChanged: (value) async {
            await controller.toggleAutoBackup(value);
            setState(() {});
          },
        );
      },
    );
  }

// ... 其他代码 ...

  Widget _buildBackupDirectorySelector(BackupRestoreController controller) {
    return ListTile(
      title: Text(S.of(context).localBackupDirectoryOnlyUnderDownloadFolder),
      subtitle: FutureBuilder<String>(
        future: getDefaultExternalStorageDirectory(),
        builder: (context, snapshot) {
          return Text(snapshot.data ?? 'Not set');
        },
      ),
      onTap: () async {
        await setDefaultExternalStorageDirectory();
        setState(() {});
      },
    );
  }

  Widget _buildKeepOnlyLatestBackupSwitch(BackupRestoreController controller) {
    return FutureBuilder<bool>(
      future: controller.isKeepOnlyLatestBackupEnabled(),
      builder: (context, snapshot) {
        return SwitchListTile(
          title: Text(S.of(context).keepOnlyLatestBackup),
          value: snapshot.data ?? false,
          onChanged: (value) async {
            final isAutoBackupEnabled = await controller.isAutoBackupEnabled();
            if (isAutoBackupEnabled) {
              await controller.toggleKeepOnlyLatestBackup(value);
            }
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildBackupDirectoryNameField(BackupRestoreController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _backupDirNameController,
        decoration:
            InputDecoration(labelText: S.of(context).cloudBackupDirectoryName),
        onChanged: (value) async {
          await controller.setBackupDirectoryName(value);
          setState(() {
            // 使用 setState 更新 TextField
          });
        },
      ),
    );
  }

  Widget _buildCloudServicesSection(BackupRestoreController controller) {
    return Column(
      children: [
        ListTile(
            title: Text(S.of(context).cloudServices,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        _buildCloudServiceTile('WebDAV', 'webdav', controller),
        _buildCloudServiceTile('Google Drive', 'googledrive', controller),
        _buildCloudServiceTile('OneDrive', 'onedrive', controller),
      ],
    );
  }

  Widget _buildCloudServiceTile(
      String title, String service, BackupRestoreController controller) {
    final purchaseState = Provider.of<PurchaseState>(context, listen: false);
    return FutureBuilder<bool>(
      future: controller.isAutoBackupEnabled(), // 检查本地备份是否启用
      builder: (context, localBackupSnapshot) {
        return FutureBuilder<bool>(
          future: controller.isCloudServiceEnabled(service),
          builder: (context, cloudBackupSnapshot) {
            final isLocalBackupEnabled = localBackupSnapshot.data ?? false;
            return ListTile(
              title:
                  Text('$title ${S.of(context).backup}', style: whiteTextStyle),
              trailing: Theme(
                data: AppSwitchTheme.apply(context, switchTheme),
                child: Switch(
                  value: cloudBackupSnapshot.data ?? false,
/*
                onChanged: purchaseState.isPurchasedOrHasTempAccess() &&
                        isLocalBackupEnabled // 只有本地备份启用时才允许修改
                    ? (value) async {
                        await controller.toggleCloudService(service, value);
                        setState(() {});
                      }
                    : null, // 否则禁用开关
*/

                  onChanged: purchaseState.isPurchasedOrHasTempAccess() &&
                          isLocalBackupEnabled // 只有本地备份启用时才允许修改
                      ? (value) async {
                          await controller.toggleCloudService(
                              service,
                              value,
                              _backupDirNameController
                                  .text); // 传递 backupDirName
                          setState(() {});
                        }
                      : null, // 否则禁用开关
                ),
              ),
              onTap: () => _showCloudServiceSettings(service, controller),
              leading: Icon(
                _getCloudServiceIcon(service),
                color: Colors.black,
              ),
              subtitle: !isLocalBackupEnabled
                  ? Text(
                      S.of(context).cloudBackupRequiresAutoBackup,
                      style: const TextStyle(color: Colors.red),
                    )
                  : null, // 显示提示信息
            );
          },
        );
      },
    );
  }

// 辅助函数，根据服务类型返回对应的图标
  IconData _getCloudServiceIcon(String service) {
    switch (service) {
      case 'webdav':
        return NewSet.cloud_upload;
      case 'googledrive':
        return Icons.add_to_drive;
      case 'onedrive':
        return NewSet.onedrive;
      default:
        return NewSet.cloud_upload;
    }
  }

  void _showCloudServiceSettings(
      String service, BackupRestoreController controller) {
    switch (service) {
      case 'webdav':
        showDialog(
          context: context,
          builder: (context) => WebDAVSettingsDialog(
            onSave: controller.saveWebDAVSettings,
          ),
        );
        break;
      case 'googledrive':
        showDialog(
          context: context,
          builder: (context) => GoogleDriveSettingsDialog(
            service: controller.googleDriveService,
          ),
        );
        break;
      case 'onedrive':
        showDialog(
          context: context,
          builder: (context) => OneDriveSettingsDialog(
            service: controller.oneDriveService,
          ),
        );
        break;
    }
  }

  Widget _buildBackupRestoreButtons(BackupRestoreController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 文字左对齐
        children: [
          // 添加总标题
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, bottom: 16.0), // 只在左侧留出空白
            child: Text(
              S.of(context).backupAndRestore,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                //color: whiteTextStyle.color, // 使用 whiteTextStyle 的颜色
              ),
            ),
          ),
          // 使用 Card 包裹 ListTile，添加标题和阴影效果
          Card(
            child: ListTile(
              leading: Text(S.of(context).manualBackup, style: whiteTextStyle),
              trailing: const Icon(NewSet.cloud_upload), // 图标居右
              // onTap: () => controller.manualBackup(context: context),
              onTap: () => controller.manualBackup(
                  context: context,
                  backupDirName: _backupDirNameController.text), // 传递目录名
              //    tileColor: showmoreButtonStyle.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading:
                  Text(S.of(context).restoreFromLocal, style: whiteTextStyle),
              trailing: const Icon(Icons.restore),
              onTap: () =>
                  controller.restore(source: 'local', context: context),
              //   tileColor: showmoreButtonStyle.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading:
                  Text(S.of(context).restoreFromWebdav, style: whiteTextStyle),
              trailing: const Icon(NewSet.cloud_download),
              // onTap: () => controller.restore(source: 'webdav', context: context),
              onTap: () => controller.restore(
                  source: 'webdav',
                  context: context,
                  backupDirName: _backupDirNameController.text), // 传递目录名
              // tileColor: showmoreButtonStyle.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Text(S.of(context).restoreFromGoogleDrive,
                  style: whiteTextStyle),
              trailing: const Icon(NewSet.cloud_download),
              //onTap: () => controller.restore(source: 'googledrive', context: context),
              onTap: () => controller.restore(
                  source: 'googledrive',
                  context: context,
                  backupDirName: _backupDirNameController.text), // 传递目录名
              // tileColor: showmoreButtonStyle.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Text(S.of(context).restoreFromOnedrive,
                  style: whiteTextStyle),
              trailing: const Icon(NewSet.cloud_download),
              // onTap: () => controller.restore(source: 'onedrive', context: context),
              onTap: () => controller.restore(
                  source: 'onedrive',
                  context: context,
                  backupDirName: _backupDirNameController.text), // 传递目录名
              //  tileColor: showmoreButtonStyle.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

//到此
}
