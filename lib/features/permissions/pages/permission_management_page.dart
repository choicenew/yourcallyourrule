import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/services/permission_service.dart';

/// 权限管理页面
class PermissionManagementPage extends StatefulWidget {
  const PermissionManagementPage({super.key});

  @override
  State<PermissionManagementPage> createState() => _PermissionManagementPageState();
}

class _PermissionManagementPageState extends State<PermissionManagementPage> {
  bool _isLoading = true;
  Map<String, bool> _permissionStatus = {};
  final List<PermissionItem> _permissionItems = [
    PermissionItem(
      name: 'call',
      title: '电话权限',
      description: '用于识别和拦截来电',
      icon: Icons.phone,
      color: Colors.green,
    ),
    PermissionItem(
      name: 'sms',
      title: '短信权限',
      description: '用于过滤垃圾短信',
      icon: Icons.sms,
      color: Colors.blue,
    ),
    PermissionItem(
      name: 'contacts',
      title: '通讯录权限',
      description: '用于识别联系人来电',
      icon: Icons.contacts,
      color: Colors.orange,
    ),
    PermissionItem(
      name: 'storage',
      title: '存储权限',
      description: '用于保存设置和规则',
      icon: Icons.storage,
      color: Colors.purple,
    ),
    PermissionItem(
      name: 'overlay',
      title: '悬浮窗权限',
      description: '用于显示来电悬浮窗',
      icon: Icons.picture_in_picture,
      color: Colors.teal,
    ),
    PermissionItem(
      name: 'notification',
      title: '通知权限',
      description: '用于显示来电和短信通知',
      icon: Icons.notifications,
      color: Colors.red,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final permissionService = Provider.of<PermissionService>(context, listen: false);
      final Map<String, bool> status = {};

      for (final item in _permissionItems) {
        status[item.name] = await permissionService.hasPermission(item.name);
      }

      setState(() {
        _permissionStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('检查权限失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermission(String permission) async {
    try {
      final permissionService = Provider.of<PermissionService>(context, listen: false);
      final granted = await permissionService.requestPermission(permission);

      setState(() {
        _permissionStatus[permission] = granted;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(granted ? '权限已授予' : '权限请求被拒绝'),
        backgroundColor: granted ? Colors.green : Colors.orange,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('请求权限失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _requestAllPermissions() async {
    try {
      final permissionService = Provider.of<PermissionService>(context, listen: false);
      final permissions = _permissionItems.map((item) => item.name).toList();
      final results = await permissionService.requestPermissions(permissions);

      setState(() {
        _permissionStatus = results;
      });

      final allGranted = results.values.every((granted) => granted);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(allGranted ? '所有权限已授予' : '部分权限请求被拒绝'),
        backgroundColor: allGranted ? Colors.green : Colors.orange,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('请求权限失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _openAppSettings() async {
    try {
      final permissionService = Provider.of<PermissionService>(context, listen: false);
      await permissionService.openAppSettings();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('打开应用设置失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('权限管理'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _checkPermissions,
            tooltip: '刷新权限状态',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openAppSettings,
            tooltip: '打开应用设置',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildPermissionsList(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _requestAllPermissions,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF5A623),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('请求所有权限', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildPermissionsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        ..._permissionItems.map((item) => _buildPermissionCard(item)),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color(0xFFF5A623),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    '权限说明',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '为了提供完整的来电和短信管理服务，应用需要以下权限。您可以单独授予或拒绝每个权限，但某些功能可能会受到限制。',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard(PermissionItem item) {
    final isGranted = _permissionStatus[item.name] ?? false;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isGranted ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isGranted ? '已授权' : '未授权',
                style: TextStyle(
                  fontSize: 12,
                  color: isGranted ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isGranted ? Icons.check_circle : Icons.add_circle,
                color: isGranted ? Colors.green : const Color(0xFFF5A623),
              ),
              onPressed: () => _requestPermission(item.name),
              tooltip: isGranted ? '已授权' : '请求权限',
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionItem {
  final String name;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  PermissionItem({
    required this.name,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}