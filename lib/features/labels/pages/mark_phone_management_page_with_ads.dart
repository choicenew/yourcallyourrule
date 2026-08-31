import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/features/labels/providers/label_phone_entry_to_remote_provider.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/labels/providers/label_mark_statistics_sync_service_provider.dart';
import 'package:yourcallyourrule/features/labels/providers/mark_phone_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/services/label_mark_statistics_service.dart';
import 'package:yourcallyourrule/features/labels/widgets/dialogs/mark_phone_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

/// 号码标记管理页面 - 集成广告功能
/// 用于用户添加号码标记，查看标记次数，以及兑换VIP功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class MarkPhoneManagementPageWithAds extends ConsumerStatefulWidget {
  const MarkPhoneManagementPageWithAds({super.key});

  @override
  ConsumerState<MarkPhoneManagementPageWithAds> createState() =>
      _MarkPhoneManagementPageWithAdsState();
}

class _MarkPhoneManagementPageWithAdsState
    extends ConsumerState<MarkPhoneManagementPageWithAds> {
  int _markCount = 0;
  bool _isLoading = false;
  late LabelMarkStatisticsService _statisticsService;
  StreamSubscription? _markCountSubscription;
  String _searchKeyword = '';

  // 标记号码列表
  List<LabelPhoneEntry> _markedPhones = [];
  bool _isLoadingMarkedPhones = true;

  @override
  void initState() {
    super.initState();
    // 初始化时不直接创建服务实例，而是在didChangeDependencies中通过Provider获取
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // 通过Provider获取服务实例
    _statisticsService = ref.read(labelMarkStatisticsServiceProvider);
    
    // 加载标记数量
    _loadMarkCount();
    
    // 加载标记的电话号码列表
    _loadMarkedPhones();

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

      final filteredPhones = markedPhones.where((phone) {
        if (_searchKeyword.isNotEmpty) {
          final searchLower = _searchKeyword.toLowerCase();
          final phoneMatch = phone.phoneNumber.value.toLowerCase().contains(searchLower);
          final nameMatch = phone.name.toLowerCase().contains(searchLower);
          return phoneMatch || nameMatch;
        }
        return true;
      }).toList();

      setState(() {
        _markedPhones = filteredPhones;
      });
    } catch (e) {
      _showSnackBar(
        AppLocalizations.of(context)!.loadMarkedPhonesFailed(e.toString()),
      );
    } finally {
      setState(() {
        _isLoadingMarkedPhones = false;
      });
    }
  }

  void _onSearchChanged(String keyword) {
    setState(() {
      _searchKeyword = keyword;
    });
    _loadMarkedPhones();
  }

  void _showAddMarkDialog(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    String? selectedLabelId;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.addPhoneMark),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              PublicSelectLabel(
                onLabelIdChanged: (labelId) {
                  selectedLabelId = labelId;
                },
                themeColor: const Color(0xFFF5A623),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            TextButton(
              onPressed: () async {
                final phoneText = phoneController.text.trim();
                final name = nameController.text.trim();

                if (phoneText.isEmpty) {
                  _showSnackBar(AppLocalizations.of(context)!.phoneNumber);
                  return;
                }

                if (selectedLabelId == null || selectedLabelId!.isEmpty) {
                  _showSnackBar(AppLocalizations.of(context)!.selectLabel);
                  return;
                }
// 检查标签ID是否有效
                final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
                final label = await predefinedLabelService.getLabelById(selectedLabelId!);
                if (!context.mounted) return;
                if (label == null) {
                  _showSnackBar(AppLocalizations.of(context)!.invalidLabel);
                  return;
                }

                try {
                  final phoneNumber = PhoneNumber.fromString(phoneText);
                  final markPhoneService = ref.read(markPhoneServiceProvider);
// 使用markPhoneService标记电话号码
                  final labelPhoneEntry = await markPhoneService.markPhone(
                    phoneNumber,
                    selectedLabelId!,
                    name: name,
                  );
// 使用标记统计同步服务记录标记
                  final statisticsSyncService = ref.read(
                    labelMarkStatisticsSyncServiceProvider,
                  );
                  await statisticsSyncService.syncSingleLabel(labelPhoneEntry);
// 使用标签到远程号码同步服务同步标记
                  final labelPhoneEntryToRemote = ref.read(
                    labelPhoneEntryToRemoteProvider,
                  );
                  await labelPhoneEntryToRemote.sync(labelPhoneEntry);

                  if (!context.mounted) return;
                  Navigator.pop(context);
                  _loadMarkedPhones();

                  _showSnackBar(AppLocalizations.of(context)!.markPhoneSuccess);
                } catch (e) {
                  _showSnackBar('${AppLocalizations.of(context)!.markPhoneFailed}: $e');
                }
              },
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToVipExchangePage() async {
    // 导航到VIP兑换页面
    context.pushNamed(AppRouter.vipExchange);

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
    _markCountSubscription?.cancel();
    super.dispose();
  }

  Widget _buildMarkCountCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9500).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: Color(0xFFFF9500),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.markCount,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_markCount',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFF9500),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF9500), Color(0xFFFF5E3A)],
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF9500).withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _navigateToVipExchangePage,
              icon: const Icon(Icons.card_membership_rounded, color: Colors.white, size: 18),
              label: Text(
                AppLocalizations.of(context)!.exchangeVip,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建单个标记号码卡片
  Widget _buildMarkedPhoneCard(LabelPhoneEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          FutureBuilder<String>(
             future: _getLabelName(entry.labelId),
             builder: (context, snapshot) {
               final labelName = snapshot.data ?? '';
               return CircleAvatar(
                 backgroundColor: AvatarUtils.getColorFromName(entry.labelId),
                 radius: 22,
                 backgroundImage: AvatarUtils.getAvatarImage(entry.avatar, labelName),
                 child: AvatarUtils.getAvatarImage(entry.avatar, labelName) == null
                     ? Text(
                         AvatarUtils.getAvatarInitial(entry.name.isNotEmpty ? entry.name : labelName),
                         style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                       )
                     : null,
               );
             },
           ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.phoneNumber.value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                FutureBuilder<String>(
                  future: _getLabelName(entry.labelId),
                  builder: (context, snapshot) {
                    final labelText = snapshot.data ?? AppLocalizations.of(context)!.loading;
                    final translatedLabel = LabelTranslationUtils.translateLabelText(context, labelText);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F5F0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        translatedLabel,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700],
                        ),
                      ),
                    );
                  },
                ),
                if (entry.name.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    entry.name,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.blue, size: 20),
            onPressed: () => _editMarkedPhone(entry),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 20),
            onPressed: () => _deleteMarkedPhone(entry),
            tooltip: AppLocalizations.of(context)!.deleteButton,
          ),
        ],
      ),
    );
  }

  /// 获取标签名称
  Future<String> _getLabelName(String labelId) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final label = await predefinedLabelService.getLabelById(labelId);
    return label?.text ?? AppLocalizations.of(context)!.unknown;
  }

  /// 编辑标记的电话号码
  Future<void> _editMarkedPhone(LabelPhoneEntry entry) async {
    try {
      // 使用MarkPhoneEditDialog显示编辑对话框
      MarkPhoneEditDialog.show(
        context, 
        entry,
        onEntryUpdated: () {
          // 重新加载标记号码列表
          _loadMarkedPhones();
        },
        themeColor: const Color(0xFFF5A623),
      );
    } catch (e) {
      _showSnackBar('${AppLocalizations.of(context)!.updateRuleFailed}: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<LabelPhoneEntry>(
      title: AppLocalizations.of(context)!.markPhoneManagementTitle,
      items: _markedPhones,
      itemBuilder: (context, entry) => _buildMarkedPhoneCard(entry),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noMarkedPhones,
      emptyIcon: Icons.label_off,
      themeColor: const Color(0xFFF5A623),
      isLoading: _isLoadingMarkedPhones,
      onRefresh: _loadMarkedPhones,
      onAdd: () => _showAddMarkDialog(context),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchMarkedPhonesHint,
      infoCard: _buildInfoCard(),
      customActions: [
        IconButton(
          icon: const Icon(Icons.card_membership),
          onPressed: _navigateToVipExchangePage,
          tooltip: AppLocalizations.of(context)!.exchangeVip,
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return _buildMarkCountCard();
  }
}
