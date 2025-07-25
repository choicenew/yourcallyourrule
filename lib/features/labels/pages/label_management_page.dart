import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/label_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

class LabelManagementPage extends ConsumerStatefulWidget {
  const LabelManagementPage({super.key});

  @override
  ConsumerState<LabelManagementPage> createState() => _LabelManagementPageState();
}

class _LabelManagementPageState extends ConsumerState<LabelManagementPage> {
  List<LabelPhoneEntry> _labels = [];
  List<String> _uniqueLabelTexts = [];
  bool _isLoading = true;

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loadLabelsFailed(e.toString()))),
      );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelDeleted)),
        );
        await _loadLabels();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.deleteLabelFailed(e.toString()))),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.labelAddedSuccessfully(labelText?.text ?? selectedLabelId!))),
                );
                Navigator.of(context).pop();
                await _loadLabels();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.addLabelFailed(e.toString()))),
                );
              }
            },
            child: const Text('添加'),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.labelsImportedSuccessfully(result.length))),
      );
      await _loadLabels();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.importLabelsFailed(e.toString()))),
      );
    }
  }

  Future<void> _exportLabels() async {
    try {
      final labelService = ref.read(labelServiceProvider);
      final success = await labelService.exportLabelsToFile('labels.json');
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.labelsExportedSuccessfully)),
        );
      } else {
        throw Exception(AppLocalizations.of(context)!.exportFailed);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.exportLabelsFailed(e.toString()))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.labelManagement),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddLabelDialog,
            tooltip: AppLocalizations.of(context)!.addLabel,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _labels.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.label_outline, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(AppLocalizations.of(context)!.noLabels, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text(AppLocalizations.of(context)!.addLabel),
                        onPressed: _showAddLabelDialog,
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: 16),
                    _buildLabelCategoriesCard(),
                    const SizedBox(height: 16),
                    ..._labels.map(_buildLabelCard),
                  ],
                ),
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

  // 辅助方法：根据labelId获取标签文本
  Future<String> _getLabelText(LabelPhoneEntry label) async {
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final labelText = await predefinedLabelService.getLabelById(label.labelId);
    return labelText?.text ?? label.labelId;
  }
  
  Widget _buildLabelChip(String label) {
    // 异步获取所有标签的文本，然后计算每个标签类型的数量
    // 这里需要一个更复杂的实现来正确计数
    // 在实际应用中，应该在加载标签时预先构建映射关系
    
    // 首先尝试找到与此标签文本对应的预定义标签
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
}