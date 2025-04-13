// webdav_settings_dialog.dart
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/google_drive_service.dart';
import '../../services/onedrive_service.dart';
import '../../services/webdav_service.dart';
import '../../utils/secure_storage.dart';

// 新的函数，用于测试连接
Future<bool> testWebDavConnection(
    BuildContext context,
    TextEditingController urlController,
    TextEditingController usernameController,
    TextEditingController passwordController,
    ) async {

  // 在函数内部初始化 webDavService
  final webDavService = WebDavService(SecureStorage());

  final isConnected = await webDavService.testConnection(
    urlController.text,
    usernameController.text,
    passwordController.text,
  );

  if (isConnected) {
    // 测试连接成功后，调用 saveCredentials 方法保存凭据
    await webDavService.saveCredentials(
      urlController.text,
      usernameController.text,
      passwordController.text,
      
    );
  }

  // 在对话框内显示 Snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(isConnected ? '连接成功' : '连接失败')),
  );

  return isConnected;
}

class WebDAVSettingsDialog extends StatefulWidget {
  final Function(String, String, String) onSave;

  const WebDAVSettingsDialog({super.key, required this.onSave});

  @override
  WebDAVSettingsDialogState createState() => WebDAVSettingsDialogState();
}

class WebDAVSettingsDialogState extends State<WebDAVSettingsDialog> {
  late TextEditingController _urlController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _isTestingConnection = false;

  @override
  void initState() {
    super.initState();

    // 初始化 TextEditingController
    _urlController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    // 从 SecureStorage 中读取之前保存的信息
    _loadCredentials();
  }



  // 从 SecureStorage 中读取用户名、密码和 URL
  Future<void> _loadCredentials() async {
    final webDavService = WebDavService(SecureStorage());
    _urlController.text = await webDavService.secureStorage.read(SecureStorage.urlKey) ?? '';
    _usernameController.text = await webDavService.secureStorage.read(SecureStorage.usernameKey) ?? '';
    _passwordController.text = await webDavService.secureStorage.read(SecureStorage.passwordKey) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).webdav),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(labelText: S.of(context).webdavUrl),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: S.of(context).userName),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: S.of(context).password),
              obscureText: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: _isTestingConnection
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : Text(S.of(context).test),
          onPressed: () async {
            setState(() => _isTestingConnection = true);
            await testWebDavConnection( // 调用新的函数
              context,
              _urlController,
              _usernameController,
              _passwordController,
            );
            setState(() => _isTestingConnection = false);
          },
        ),
        ElevatedButton(
          child: Text(S.of(context).save),
          onPressed: () {
            widget.onSave(
              _urlController.text,
              _usernameController.text,
              _passwordController.text,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


// google_drive_settings_dialog.dart

class GoogleDriveSettingsDialog extends StatelessWidget {
  final GoogleDriveService service;

  const GoogleDriveSettingsDialog({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).googleDriveSetting),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).loginlogoutGoogleDrive),
          const SizedBox(height: 20),
          ElevatedButton(
            child: Text(service.isEnabled ? S.of(context).logoutGoogleDrive : S.of(context).loginGoogleDrive),
            onPressed: () async {
              if (service.isEnabled) {
                await service.signOut();
              } else {
                final success = await service.signIn();
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).googleDriveLoginSuccessfully)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).googleDriveLoginFailed)),
                  );
                }
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

// onedrive_settings_dialog.dart

class OneDriveSettingsDialog extends StatefulWidget {
  final OneDriveService service;

  const OneDriveSettingsDialog({super.key, required this.service});

  @override
  OneDriveSettingsDialogState createState() => OneDriveSettingsDialogState();
}

class OneDriveSettingsDialogState extends State<OneDriveSettingsDialog> {
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _tenantIdController = TextEditingController();
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).onedriveSetting),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSigningIn ? null : _handleSignIn,
              child: _isSigningIn ? const CircularProgressIndicator() : Text(S.of(context).login),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isSigningIn = true;
    });

    String clientId = _clientIdController.text.trim();
    String tenantId = _tenantIdController.text.trim();

    try {
      bool success = await widget.service.signInWithCredentials(clientId, tenantId);
      if (success) {
        Navigator.of(context).pop();
      } else {
        throw Exception('Login失败');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${S.of(context).loginFailed}: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isSigningIn = false;
      });
    }
  }
}