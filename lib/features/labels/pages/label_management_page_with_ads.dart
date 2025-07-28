import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/label_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';

/// 标签管理页面 - 集成广告功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class LabelManagementPageWithAds extends ConsumerStatefulWidget {
  const LabelManagementPageWithAds({super.key});

  @override
  ConsumerState<LabelManagementPageWithAds> createState() => _LabelManagementPageWithAdsState();
}

class _LabelManagementPageWithAdsState extends ConsumerState<LabelManagementPageWithAds> {
  List<LabelPhoneEntry> _labels = [];
  List<String> _uniqueLabelTexts = [];
  bool _isLoading = true;
  
  // 多选模式相关变量
  Set<String> _selectedLabelIds = {}; // 存储选中的标签ID

  @override
  void initState() {
    super.initState();
    _loadLabels();
  }

  Future<void> _loadLabels() async {
    setState(() {
      _isLoading = true;
    });

    final labelService = ref.read(labelServiceProvider);
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    try {
      final labels = await labelService.getAllLabels();
      final labelTexts = await predefinedLabelService.getAllLabelTexts();
      setState(() {
        _labels = labels;
        _uniqueLabelTexts = labelTexts;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.loadLabelsFailed(e.toString()))),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteLabel(LabelPhoneEntry label) async {
    // 获取标签文本
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelById(label.labelId);
    final displayText = labelText?.text ?? label.labelId;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteLabel),
        content: Text(AppLocalizations.of(context)!.confirmDeleteLabel(displayText)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final labelService = ref.read(labelServiceProvider);
      try {
        await labelService.removeLabel(label.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.labelDeleted)),
          );
        }
        await _loadLabels();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.deleteLabelFailed(e.toString()))),
          );
        }
      }
    }
  }

  // 批量删除选中的标签
  Future<void> _deleteSelectedLabels() async {
    if (_selectedLabelIds.isEmpty) return;
    
    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.bulkDeleteLabels),
        content: Text(AppLocalizations.of(context)!.batchDeleteLabelsConfirm(_selectedLabelIds.length)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (!confirmed!) return;
    
    final labelService = ref.read(labelServiceProvider);
    
    // 获取选中的标签
    final selectedLabels = _labels.where(
      (label) => _selectedLabelIds.contains(label.id)
    ).toList();
    
    try {
      // 逐个删除选中的标签
      for (var label in selectedLabels) {
        await labelService.removeLabel(label.id);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelsDeleted(selectedLabels.length))),
        );
      }
      
      // 清空选中的标签ID并刷新列表
      setState(() {
        _selectedLabelIds.clear();
      });
      await _loadLabels();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.bulkDelete}: $e')),
        );
      }
    }
  }

  void _showAddLabelDialog() {
    String? selectedLabelId;
    final phoneController = TextEditingController();
    final iconController = TextEditingController();
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addLabel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PublicSelectLabel(
              onLabelIdChanged: (labelId) {
                selectedLabelId = labelId;
              },
              selectLabelService: PredefinedLabelServiceAdapter(predefinedLabelService),
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
              controller: iconController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.iconCodeOptional,
                hintText: AppLocalizations.of(context)!.enterIconCode,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final phoneText = phoneController.text.trim();
              final iconText = iconController.text.trim();
              
              if (selectedLabelId == null || phoneText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.selectLabelAndEnterPhoneNumber)),
                );
                return;
              }

              try {
                final phoneNumber = PhoneNumber.fromString(phoneText);
                final labelService = ref.read(labelServiceProvider);
                
                final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
                final label = LabelPhoneEntry(
                  id: uniqueId,
                  phoneNumber: phoneNumber,
                  labelId: selectedLabelId!,
                  icon: iconText.isNotEmpty ? iconText : null,
                );
                
                await labelService.addLabel(label);
                final labelText = await predefinedLabelService.getLabelById(selectedLabelId!);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.labelAddedSuccessfully(labelText?.text ?? selectedLabelId!))),
                  );
                }
                Navigator.of(context).pop();
                await _loadLabels();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.addLabelFailed(e.toString()))),
                );
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

  Future<void> _importLabels() async {
    try {
      final labelService = ref.read(labelServiceProvider);
      final result = await labelService.importLabelsFromFile('labels.json');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelsImportedSuccessfully(result.length))),
        );
      }
      await _loadLabels();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.importLabelsFailed(e.toString()))),
        );
      }
    }
  }

  Future<void> _exportLabels() async {
    try {
      final labelService = ref.read(labelServiceProvider);
      final success = await labelService.exportLabelsToFile('labels.json');
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.labelsExportedSuccessfully)),
          );
        }
      } else {
        throw Exception(AppLocalizations.of(context)!.exportFailed);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.exportLabelsFailed(e.toString()))),
        );
      }
    }
  }

  // 辅助方法：根据labelId获取标签文本
  Future<String> _getLabelText(LabelPhoneEntry label) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelById(label.labelId);
    return labelText?.text ?? label.labelId;
  }
  
  Widget _buildLabelChip(String label) {
    // 异步获取所有标签的文本，然后计算每个标签类型的数量
    Future<int> getCount() async {
      final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
      // 获取所有预定义标签
      final predefinedLabels = await predefinedLabelService.getAllLabels();
      // 找到与当前标签文本匹配的预定义标签
      final matchingLabels = predefinedLabels.where((pl) => pl.text == label).toList();
      
      if (matchingLabels.isEmpty) return 0;
      
      // 获取匹配标签的ID
      final labelIds = matchingLabels.map((l) => l.id).toSet();
      
      // 计算使用这些标签ID的标签数量
      return _labels.where((l) => labelIds.contains(l.labelId)).length;
    }
    
    // 使用FutureBuilder显示计数
    return FutureBuilder<int>(
      future: getCount(),
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return Chip(
          label: Text(label),
          avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              count.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ),
          backgroundColor: Colors.blue.shade50,
        );
      },
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.blue, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.aboutLabels,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.labelDescription,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelCategoriesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.labelCategories,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _uniqueLabelTexts.map((label) => _buildLabelChip(label)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelCard(LabelPhoneEntry label) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: FutureBuilder<String>(
                                future: _getLabelText(label),
                                builder: (context, snapshot) {
                                  final labelText = snapshot.data ?? '';
                                  return Text(
                                    label.icon ?? (labelText.isNotEmpty ? labelText.substring(0, 1) : '?'),
                                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder<String>(
                                  future: _getLabelText(label),
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? label.labelId,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  label.phoneNumber.toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditLabelDialog(label),
                      tooltip: AppLocalizations.of(context)!.edit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteLabel(label),
                      tooltip: AppLocalizations.of(context)!.deleteButton,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Column(
      children: [
        _buildInfoCard(),
        const SizedBox(height: 16),
        _buildLabelCategoriesCard(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericListWithAdsPage<LabelPhoneEntry>(
      title: AppLocalizations.of(context)!.labelManagement,
      items: _labels,
      itemBuilder: (context, label) => _buildLabelCard(label),
      adBuilder: () => const Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('广告位', textAlign: TextAlign.center),
        ),
      ),
      adInterval: 3,
      emptyText: AppLocalizations.of(context)!.noLabels,
      emptyIcon: Icons.label_outline,
      emptyActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addLabel),
        onPressed: _showAddLabelDialog,
      ),
      themeColor: Colors.blue,
      isLoading: _isLoading,
      onRefresh: _loadLabels,
      onAdd: _showAddLabelDialog,
      isMultiSelectMode: _selectedLabelIds.isNotEmpty,
      selectedItemIds: _selectedLabelIds,
      onToggleMultiSelectMode: () {
        setState(() {
          _selectedLabelIds.clear();
        });
      },
      onDeleteSelected: _deleteSelectedLabels,
      getItemId: (label) => label.id,
      onToggleItemSelection: (labelId) {
        setState(() {
          if (_selectedLabelIds.contains(labelId)) {
            _selectedLabelIds.remove(labelId);
          } else {
            _selectedLabelIds.add(labelId);
          }
        });
      },
      headerContent: _buildHeaderContent(),
      customActions: [
        IconButton(
          icon: const Icon(Icons.file_download),
          onPressed: _importLabels,
          tooltip: AppLocalizations.of(context)!.importLabels,
        ),
        IconButton(
          icon: const Icon(Icons.file_upload),
          onPressed: _exportLabels,
          tooltip: AppLocalizations.of(context)!.exportLabels,
        ),
      ],
    );
  }
}