import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/labels/providers/label_mark_statistics_sync_service_provider.dart';
import 'package:yourcallyourrule/features/labels/providers/mark_phone_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';

/// 号码标记管理页面 - 集成广告功能
/// 用于用户添加号码标记，查看标记次数，以及兑换VIP功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class MarkPhoneManagementPageWithAds extends ConsumerStatefulWidget {
  const MarkPhoneManagementPageWithAds({super.key});

  @override
  ConsumerState<MarkPhoneManagementPageWithAds> createState() => _MarkPhoneManagementPageWithAdsState();
}

class _MarkPhoneManagementPageWithAdsState extends ConsumerState<MarkPhoneManagementPageWithAds> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedLabelId;
  int _markCount = 0;
  bool _isLoading = false;
  late LabelMarkStatisticsService _statisticsService;
  StreamSubscription? _markCountSubscription;
  
  // 标记号码列表
  List<LabelPhoneEntry> _markedPhones = [];
  bool _isLoadingMarkedPhones = true;

  @override
  void initState() {
    super.initState();
    // 初始化时不直接创建服务实例，而是在didChangeDependencies中通过Provider获取
    _loadMarkCount();
    _loadMarkedPhones();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // 通过Provider获取服务实例
    _statisticsService = ref.read(labelMarkStatisticsServiceProvider);
    
    // 监听标记计数变化
    _markCountSubscription?.cancel();
    _markCountSubscription = _statisticsService.markCountStream.listen((count) {
      setState(() {
        _markCount = count;
      });
    });
  }

  Future<void> _loadMarkCount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final count = await _statisticsService.getMarkCount();
      setState(() {
        _markCount = count;
      });
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context)!.loadMarkCountFailed}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
      ),
    );
  }

  /// 加载标记过的号码列表
  Future<void> _loadMarkedPhones() async {
    setState(() {
      _isLoadingMarkedPhones = true;
    });

    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      final markedPhones = await markPhoneService.getAllPhoneMarks();
      
      setState(() {
        _markedPhones = markedPhones;
        _isLoadingMarkedPhones = false;
      });
    } catch (e) {
      _showSnackBar(AppLocalizations.of(context)!.loadMarkedPhonesFailed(e.toString()));
      setState(() {
        _isLoadingMarkedPhones = false;
      });
    }
  }

  Future<void> _markPhone() async {
    final phoneText = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (phoneText.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.phoneNumber);
      return;
    }

    if (_selectedLabelId == null || _selectedLabelId!.isEmpty) {
      _showSnackBar(AppLocalizations.of(context)!.selectLabel);
      return;
    }

    // 检查标签ID是否有效
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(_selectedLabelId!);
    if (label == null) {
      _showSnackBar(AppLocalizations.of(context)!.invalidLabel);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final phoneNumber = PhoneNumber.fromString(phoneText);
      final markPhoneService = ref.read(markPhoneServiceProvider);

      // 使用markPhoneService标记电话号码
      final labelPhoneEntry = await markPhoneService.markPhone(
        phoneNumber,
        _selectedLabelId!,
        name: name,
      );
      
      // 使用标记统计同步服务记录标记
      final statisticsSyncService = ref.read(labelMarkStatisticsSyncServiceProvider);
      await statisticsSyncService.syncSingleLabel(labelPhoneEntry);

      // 清空输入框
      _phoneController.clear();
      _nameController.clear();
      setState(() {
        _selectedLabelId = null;
      });

      // 重新加载标记号码列表
      _loadMarkedPhones();

      _showSnackBar(AppLocalizations.of(context)!.markPhoneSuccess);
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context)!.markPhoneFailed}: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToVipExchangePage() async {
    // 导航到VIP兑换页面
    await Navigator.of(context).pushNamed('/vip-exchange');
    
    // 返回后刷新标记次数
    await _loadMarkCount();
  }

  /// 删除标记号码
  Future<void> _deleteMarkedPhone(LabelPhoneEntry entry) async {
    try {
      final markPhoneService = ref.read(markPhoneServiceProvider);
      await markPhoneService.removePhoneMark(entry.id);
      
      // 重新加载标记号码列表
      _loadMarkedPhones();
      
      _showSnackBar(AppLocalizations.of(context)!.deleteSuccess);
    } catch (e) {
      _showSnackBar(AppLocalizations.of(context)!.deleteFailed(e.toString()));
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _markCountSubscription?.cancel();
    super.dispose();
  }

  Widget _buildMarkCountCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.markCount,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_markCount',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFF5A623)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _navigateToVipExchangePage,
              icon: const Icon(Icons.card_membership),
              label: Text(AppLocalizations.of(context)!.exchangeVip),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkPhoneForm() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.addPhoneMark,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phoneNumber,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            PublicSelectLabel(
              onLabelIdChanged: (labelId) {
                setState(() {
                  _selectedLabelId = labelId;
                });
              },
              themeColor: const Color(0xFFF5A623),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _markPhone,
              icon: const Icon(Icons.label),
              label: Text(AppLocalizations.of(context)!.markPhone),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Column(
      children: [
        _buildMarkCountCard(),
        const SizedBox(height: 16),
        _buildMarkPhoneForm(),
      ],
    );
  }

  /// 构建单个标记号码卡片
  Widget _buildMarkedPhoneCard(LabelPhoneEntry entry) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF5A623),
              radius: 24,
              child: Text(
                entry.name.isNotEmpty ? entry.name[0] : '?',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.phoneNumber.value,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  FutureBuilder<String>(
                    future: _getLabelName(entry.labelId),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? AppLocalizations.of(context)!.loading,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      );
                    },
                  ),
                  if (entry.name.isNotEmpty) ...[  
                    const SizedBox(height: 4),
                    Text(
                      entry.name,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteMarkedPhone(entry),
              tooltip: AppLocalizations.of(context)!.deleteButton,
            ),
          ],
        ),
      ),
    );
  }

  /// 获取标签名称
  Future<String> _getLabelName(String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text ?? AppLocalizations.of(context)!.unknown;
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<LabelPhoneEntry>(
      title: AppLocalizations.of(context)!.markPhoneManagement,
      items: _markedPhones,
      itemBuilder: (context, entry) => _buildMarkedPhoneCard(entry),
      adBuilder: () => const Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('广告位', textAlign: TextAlign.center),
        ),
      ),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noMarkedPhones,
      emptyIcon: Icons.label_off,
      themeColor: const Color(0xFFF5A623),
      isLoading: _isLoadingMarkedPhones,
      onRefresh: _loadMarkedPhones,
      headerContent: _buildHeaderContent(),
      customActions: [
        IconButton(
          icon: const Icon(Icons.card_membership),
          onPressed: _navigateToVipExchangePage,
          tooltip: AppLocalizations.of(context)!.exchangeVip,
        ),
      ],
    );
  }
}