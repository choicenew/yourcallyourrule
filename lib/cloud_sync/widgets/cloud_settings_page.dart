import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_config_provider.dart';
import 'package:yourcallyourrule/cloud_sync/provider/cloud_sync_provider.dart';
import 'package:yourcallyourrule/cloud_sync/widgets/all_cloud_sync_status_section.dart';
import 'package:yourcallyourrule/cloud_sync/widgets/cloud_sync_status_section.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/cloud/google_sign_in_test_page.dart';







class CloudSettingsPage extends ConsumerWidget {
  const CloudSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100], // A softer background color
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cloudSyncTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CloudSyncStatusSection(),
            const SizedBox(height: 28),
            const AllCloudSyncStatusSection(),
            const SizedBox(height: 28),
            _buildSectionTitle(
              context,
              AppLocalizations.of(context)!.cloudSyncService,
            ),
            const SizedBox(height: 16),
            _buildWebDAVSection(context, ref.watch(webdavConfigProvider), ref),
            const SizedBox(height: 20),
            _buildOneDriveSection(
              context,
              ref.watch(oneDriveConfigProvider),
              ref,
            ),
            const SizedBox(height: 20),
            _buildGoogleDriveSection(
              context,
              ref.watch(googleDriveConfigProvider),
              ref,
            ),
            const SizedBox(height: 20),
            nativeAdWidgetMedium(adWidth: 400, adHeight: 499),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Developer Options'),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.bug_report, color: Colors.white),
                ),
                title: const Text(
                  'Google Sign-In Test',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GoogleSignInTestPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebDAVSection(
    BuildContext context,
    Map<String, String> config,
    WidgetRef ref,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.cloud_queue, color: Colors.white),
        ),
        title: Text(
          AppLocalizations.of(context)!.webDAVConfigTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.serverAddressLabel,
            hint: AppLocalizations.of(context)!.enterWebDAVServerAddressHint,
            initialValue: config['server_url'],
            icon: Icons.dns,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['server_url'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.usernameLabel,
            hint: AppLocalizations.of(context)!.enterWebDAVUsernameHint,
            initialValue: config['username'],
            icon: Icons.person,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['username'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.passwordLabel,
            hint: AppLocalizations.of(context)!.enterWebDAVPasswordHint,
            initialValue: config['password'],
            icon: Icons.lock,
            obscureText: true,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['password'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.syncFolderNameLabel,
            hint: AppLocalizations.of(context)!.enterSyncFolderNameHint,
            initialValue: config['folder_name'],
            icon: Icons.folder,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(webdavConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _testWebDAVConnection(context, config),
            icon: const Icon(Icons.link),
            label: Text(AppLocalizations.of(context)!.testConnectionButton),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: const Color.fromARGB(172, 250, 77, 25),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOneDriveSection(
    BuildContext context,
    Map<String, String> config,
    WidgetRef ref,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.cloud, color: Colors.white),
        ),
        title: Text(
          AppLocalizations.of(context)!.oneDriveConfigTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          Text(
            AppLocalizations.of(context)!.oneDriveAuthDescription,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.syncFolderNameLabel,
            hint: AppLocalizations.of(context)!.enterSyncFolderNameHint,
            initialValue: config['folder_name'],
            icon: Icons.folder_shared,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(oneDriveConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _authorizeOneDrive(context, config, ref),
            icon: const Icon(Icons.login),
            label: Text(AppLocalizations.of(context)!.authorizeLoginButton),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleDriveSection(
    BuildContext context,
    Map<String, String> config,
    WidgetRef ref,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.add_to_drive_outlined, color: Colors.white),
        ),
        title: Text(
          AppLocalizations.of(context)!.googleDriveConfigTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          Text(
            AppLocalizations.of(context)!.googleDriveAuthDescription,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            label: AppLocalizations.of(context)!.syncFolderNameLabel,
            hint: AppLocalizations.of(context)!.enterSyncFolderNameHint,
            initialValue: config['folder_name'],
            icon: Icons.folder_special,
            onChanged: (value) {
              final newConfig = Map<String, String>.from(config);
              newConfig['folder_name'] = value;
              ref.read(googleDriveConfigProvider.notifier).state = newConfig;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _authorizeGoogleDrive(context, config, ref),
            icon: const Icon(Icons.login),
            label: Text(AppLocalizations.of(context)!.authorizeLoginButton),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testWebDAVConnection(
    BuildContext context,
    Map<String, String> config,
  ) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取WebDAV服务
      final webdavService = ProviderContainer().read(webdavSyncServiceProvider);

      // 初始化服务
      await webdavService.initialize({
        'server_url': config['server_url'],
        'username': config['username'],
        'password': config['password'],
      });

      // 测试连接
      final result = await webdavService.connect({
        'server_url': config['server_url'],
        'username': config['username'],
        'password': config['password'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.connectionSuccessMessage,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.connectionFailedCheckCredentialsMessage,
            ),
          ),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.connectionFailedMessage}: $e',
          ),
        ),
      );
    }
  }

  Future<void> _authorizeOneDrive(
    BuildContext context,
    Map<String, String> config,
    WidgetRef ref,
  ) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取OneDrive服务
      final onedriveService = ProviderContainer().read(
        onedriveSyncServiceProvider,
      );

      // 初始化服务
      await onedriveService.initialize({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 测试连接
      final result = await onedriveService.connect({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        // 设置为活动服务
        ref.read(activeSyncServiceProvider.notifier).state = onedriveService;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.authorizationSuccessMessage,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.authorizationFailedCheckCredentialsMessage,
            ),
          ),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.authorizationFailedMessage}: $e',
          ),
        ),
      );
    }
  }

  Future<void> _authorizeGoogleDrive(
    BuildContext context,
    Map<String, String> config,
    WidgetRef ref,
  ) async {
    try {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // 获取Google Drive服务
      final googleDriveService = ProviderContainer().read(
        googleDriveSyncServiceProvider,
      );

      // 初始化服务
      await googleDriveService.initialize({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 测试连接
      final result = await googleDriveService.connect({
        'client_id': config['client_id'],
        'client_secret': config['client_secret'],
      });

      // 关闭加载指示器
      Navigator.of(context).pop();

      if (result) {
        // 设置为活动服务
        ref.read(activeSyncServiceProvider.notifier).state = googleDriveService;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.authorizationSuccessMessage,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              )!.authorizationFailedCheckCredentialsMessage,
            ),
          ),
        );
      }
    } catch (e) {
      // 关闭加载指示器
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.authorizationFailedMessage}: $e',
          ),
        ),
      );
    }
  }



  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required String? initialValue,
    required IconData icon,
    bool obscureText = false,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
    );
  }

  Widget _buildStatusRow(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String text,
  ) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
