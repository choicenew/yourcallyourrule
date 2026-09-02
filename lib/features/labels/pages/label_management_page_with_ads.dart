// yourcallyourrule/lib/features/labels/pages/label_management_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/label_edit_dialog.dart'; 
import 'package:yourcallyourrule/features/common/widgets/vip_access_checker.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 标签条目管理页面
class LabelManagementPageWithAds extends ConsumerStatefulWidget {
  const LabelManagementPageWithAds({super.key});

  @override
  ConsumerState<LabelManagementPageWithAds> createState() => _LabelManagementPageWithAdsState();
}

class _LabelManagementPageWithAdsState extends ConsumerState<LabelManagementPageWithAds> {
  List<LabelPhoneEntry> _labels = [];
  List<String> _uniqueLabelTexts = [];
  bool _isLoading = true;
  String _searchKeyword = '';
  Set<String> _selectedLabelIds = {};

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  // --- Data Handling Methods (No Changes) ---
  // ... _loadLabels, _filterLabels, _onSearchChanged, _deleteLabel, etc. ...
  Future<void> _loadLabels() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final labelService = ref.read(labelServiceProvider);
      final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
      final labels = await labelService.getAllLabels();
      final labelTexts = await predefinedLabelService.getAllLabelTexts();

      final filteredLabels = _searchKeyword.isEmpty
          ? labels
          : await _filterLabels(labels, predefinedLabelService);

      if (mounted) {
        setState(() {
          _labels = filteredLabels;
          _uniqueLabelTexts = labelTexts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackBar(AppLocalizations.of(context)!.loadLabelsFailed(e.toString()));
      }
    }
  }

  Future<List<LabelPhoneEntry>> _filterLabels(List<LabelPhoneEntry> labels, dynamic predefinedLabelService) async {
      final predefinedLabels = await predefinedLabelService.getAllLabels();
      final Map<String, String> labelIdToText = { for (var pLabel in predefinedLabels) pLabel.id: pLabel.text };
      final keyword = _searchKeyword.toLowerCase();

      return labels.where((label) {
        final labelText = labelIdToText[label.labelId] ?? '';
        return label.phoneNumber.toString().contains(keyword) ||
            labelText.toLowerCase().contains(keyword) ||
            label.name.toLowerCase().contains(keyword);
      }).toList();
  }

  void _onSearchChanged(String keyword) {
    if (_searchKeyword != keyword) {
      setState(() => _searchKeyword = keyword);
      _loadLabels();
    }
  }

  Future<void> _deleteLabel(LabelPhoneEntry label) async {
    final displayName = label.name.isNotEmpty ? label.name : label.phoneNumber.value;
    final confirmed = await _showConfirmationDialog(
      title: AppLocalizations.of(context)!.deleteLabel,
      content: AppLocalizations.of(context)!.confirmDeleteLabel(displayName),
    );

    if (confirmed == true) {
      try {
        await ref.read(labelServiceProvider).removeLabel(label.id);
        _showSuccessSnackBar(AppLocalizations.of(context)!.labelDeleted);
        await _loadLabels();
      } catch (e) {
        _showErrorSnackBar(AppLocalizations.of(context)!.deleteLabelFailed(e.toString()));
      }
    }
  }

  Future<void> _deleteSelectedLabels() async {
    if (_selectedLabelIds.isEmpty) return;

    final confirmed = await _showConfirmationDialog(
      title: AppLocalizations.of(context)!.bulkDeleteLabels,
      content: AppLocalizations.of(context)!.batchDeleteLabelsConfirm(_selectedLabelIds.length),
    );
    
    if (confirmed != true) return;

    try {
      final labelService = ref.read(labelServiceProvider);
      final count = _selectedLabelIds.length;
      final idsToDelete = Set<String>.from(_selectedLabelIds);
      for (var labelId in idsToDelete) {
        await labelService.removeLabel(labelId);
      }
      if(mounted){
          setState(() => _selectedLabelIds.clear());
          _showSuccessSnackBar(AppLocalizations.of(context)!.labelsDeleted(count));
          await _loadLabels();
      }
    } catch (e) {
      _showErrorSnackBar('${AppLocalizations.of(context)!.bulkDelete}: $e');
    }
  }

  Future<void> _importLabels() async {
    try {
      final result = await ref.read(labelServiceProvider).importLabelsFromFile('labels.json');
      _showSuccessSnackBar(AppLocalizations.of(context)!.labelsImportedSuccessfully(result.length));
      await _loadLabels();
    } catch (e) {
      _showErrorSnackBar(AppLocalizations.of(context)!.importLabelsFailed(e.toString()));
    }
  }

  Future<void> _exportLabels() async {
    try {
      final success = await ref.read(labelServiceProvider).exportLabelsToFile('labels.json');
      if (success) {
        _showSuccessSnackBar(AppLocalizations.of(context)!.labelsExportedSuccessfully);
      } else {
        throw Exception(AppLocalizations.of(context)!.exportFailed);
      }
    } catch (e) {
      _showErrorSnackBar(AppLocalizations.of(context)!.exportLabelsFailed(e.toString()));
    }
  }
  
  // --- Dialogs and UI Helpers ---

  void _showAddLabelDialog() {
    if (!VipAccessChecker.checkVipAccess(ref: ref, context: context, onAccessGranted: () {})) return;
    
    String? selectedLabelId;
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addLabel),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PublicSelectLabel(
                onLabelIdChanged: (labelId) => selectedLabelId = labelId,
                selectLabelService: PredefinedLabelServiceAdapter(ref.read(predefinedLabelServiceProvider)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.phoneNumber,
                  hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.addName,
                  hintText: AppLocalizations.of(context)!.nameCannotBeEmpty,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: iconController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.iconCodeOptional,
                  hintText: AppLocalizations.of(context)!.enterIconCode,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancelButton)),
          TextButton(
            onPressed: () async {
              if (selectedLabelId == null || phoneController.text.trim().isEmpty) {
                _showErrorSnackBar(AppLocalizations.of(context)!.selectLabelAndEnterPhoneNumber);
                return;
              }
              try {
                final label = LabelPhoneEntry(
                  id: const Uuid().v4(),
                  phoneNumber: PhoneNumber.fromString(phoneController.text.trim()),
                  labelId: selectedLabelId!,
                  name: nameController.text.trim(),
                  icon: iconController.text.trim().isNotEmpty ? iconController.text.trim() : null,
                );

                await ref.read(labelServiceProvider).addLabel(label);
                
                final labelText = await ref.read(predefinedLabelServiceProvider).getLabelById(selectedLabelId!);
                _showSuccessSnackBar(AppLocalizations.of(context)!.labelAddedSuccessfully(labelText?.text ?? selectedLabelId!));
                Navigator.of(context).pop();
                await _loadLabels();
              } catch (e) {
                _showErrorSnackBar(AppLocalizations.of(context)!.addLabelFailed(e.toString()));
              }
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
  }

  void _showEditLabelDialog(LabelPhoneEntry label) {
    LabelEditDialog.show(
      context,
      label,
      onLabelUpdated: () => _loadLabels(),
      themeColor: Theme.of(context).primaryColor,
    );
  }

  /// ✅ 关键新增：仿照您的正确示例，创建“更多选项”的弹窗
  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.file_download),
            title: Text(AppLocalizations.of(context)!.importLabels),
            onTap: () {
              Navigator.pop(context);
              _importLabels();
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: Text(AppLocalizations.of(context)!.exportLabels),
            onTap: () {
              Navigator.pop(context);
              _exportLabels();
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> _showConfirmationDialog({required String title, required String content}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(AppLocalizations.of(context)!.cancelButton)),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  void _showErrorSnackBar(String message) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  }
  
  Future<String> _getLabelText(LabelPhoneEntry label) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelObject = await predefinedLabelService.getLabelById(label.labelId);
    return labelObject?.text ?? label.labelId;
  }
  
  // --- Widget Builders (No Changes) ---
  // ... _buildLabelCard, _buildLabelCategoriesCard, _buildLabelChip, _buildInfoCard ...
  Widget _buildLabelCard(LabelPhoneEntry label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: EliteDopamineTheme.warmCardDecoration(
        context: context,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FutureBuilder<String>(
                future: _getLabelText(label),
                builder: (context, snapshot) {
                  final labelText = snapshot.data ?? '';
                  return Text(
                    label.icon ?? (labelText.isNotEmpty ? labelText.substring(0, 1) : '?'),
                    style: const TextStyle(fontSize: 18, color: Color(0xFF2D9CDB), fontWeight: FontWeight.w800),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.name.isNotEmpty ? label.name : label.phoneNumber.value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    FutureBuilder<String>(
                      future: _getLabelText(label),
                      builder: (context, snapshot) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D9CDB).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          snapshot.data ?? '...',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF2D9CDB), fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label.phoneNumber.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: Color(0xFF2D9CDB), size: 20),
            onPressed: () => _showEditLabelDialog(label),
            tooltip: AppLocalizations.of(context)!.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
            onPressed: () => _deleteLabel(label),
            tooltip: AppLocalizations.of(context)!.deleteButton,
          ),
        ],
      ),
    );
  }

  Widget _buildLabelCategoriesCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.labelCategories, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black87)),
          const SizedBox(height: 12),
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _uniqueLabelTexts.length,
              itemBuilder: (context, index) {
                final label = _uniqueLabelTexts[index];
                return Padding(padding: const EdgeInsets.only(right: 8.0), child: _buildLabelChip(label));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelChip(String label) {
    Future<int> getCount() async {
      final predefinedLabels = await ref.read(predefinedLabelServiceProvider).getAllLabels();
      final labelIds = predefinedLabels.where((pl) => pl.text == label).map((l) => l.id).toSet();
      if (labelIds.isEmpty) return 0;
      return _labels.where((l) => labelIds.contains(l.labelId)).length;
    }
    
    return FutureBuilder<int>(
      future: getCount(),
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F5F0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEDE8DF)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D9CDB).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  (snapshot.data ?? 0).toString(),
                  style: const TextStyle(fontSize: 11, color: Color(0xFF2D9CDB), fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9CDB).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF2D9CDB).withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color(0xFF2D9CDB).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              color: Color(0xFF2D9CDB),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.aboutLabels,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D9CDB),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.labelDescription,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// ✅ 最终修正：完全遵循GenericListWithAdsPage的设计模式
  Widget _buildGenericListPage() {
    return GenericListWithAdsPage<LabelPhoneEntry>(
      title: AppLocalizations.of(context)!.labelManagement,
      items: _labels,
      itemBuilder: (context, label) => _buildLabelCard(label),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 5,
      emptyText: AppLocalizations.of(context)!.noLabels,
      emptyIcon: Icons.label_off_outlined,
      emptyActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addLabel),
        onPressed: _showAddLabelDialog,
      ),
      themeColor: Colors.blue,
      isLoading: _isLoading,
      
      // ✅ 关键修正：使用组件内置的回调来自动生成按钮
      onRefresh: _loadLabels,
      onAdd: _showAddLabelDialog,
      onMoreOptions: _showMoreOptions, // <-- 菜单按钮
      onToggleMultiSelectMode: () => setState(() {
        // 进入或退出多选模式时清空已选项
        _selectedLabelIds.clear();
      }),
      
      isMultiSelectMode: _selectedLabelIds.isNotEmpty,
      selectedItemIds: _selectedLabelIds,
      onDeleteSelected: _deleteSelectedLabels,
      getItemId: (label) => label.id,
      onToggleItemSelection: (labelId) {
        setState(() {
          _selectedLabelIds.contains(labelId)
              ? _selectedLabelIds.remove(labelId)
              : _selectedLabelIds.add(labelId);
        });
      },
      
      infoCard: _buildInfoCard(),
      headerContent: _buildLabelCategoriesCard(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchLabelsHint,

      // ✅ 关键修正：不再需要 customActions
      customActions: null, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGenericListPage();
  }
}