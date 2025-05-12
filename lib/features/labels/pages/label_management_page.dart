import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';

class LabelManagementPage extends StatefulWidget {
  const LabelManagementPage({super.key});

  @override
  State<LabelManagementPage> createState() => _LabelManagementPageState();
}

class _LabelManagementPageState extends State<LabelManagementPage> {
  List<LabelPhoneEntry> _labels = [];
  List<String> _uniqueLabelTexts = [];
  bool _isLoading = true;
  late final PredefinedLabelService _predefinedLabelService;

  @override
  void initState() {
    super.initState();
    _predefinedLabelService = Provider.of<PredefinedLabelService>(context, listen: false);
    _loadLabels();
  }

  Future<void> _loadLabels() async {
    setState(() {
      _isLoading = true;
    });

    final labelService = Provider.of<LabelService>(context, listen: false);
    try {
      final labels = await labelService.getAllLabels();
      final labelTexts = await _predefinedLabelService.getAllLabelTexts();
      setState(() {
        _labels = labels;
        _uniqueLabelTexts = labelTexts;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载标签失败: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteLabel(LabelPhoneEntry label) async {
    // 获取标签文本
    final labelText = await _predefinedLabelService.getLabelById(label.labelId);
    final displayText = labelText?.text ?? label.labelId;
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除标签'),
        content: Text('确定要删除标签 "$displayText" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final labelService = Provider.of<LabelService>(context, listen: false);
      try {
        await labelService.removeLabel(label.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('标签已删除')),
        );
        await _loadLabels();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('删除标签失败: $e')),
        );
      }
    }
  }

  void _showAddLabelDialog() {
    String? selectedLabelId;
    final phoneController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加标签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PublicSelectLabel(
              onLabelIdChanged: (labelId) {
                selectedLabelId = labelId;
              },
              selectLabelService: PredefinedLabelServiceAdapter(_predefinedLabelService),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: '电话号码',
                hintText: '输入电话号码',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: iconController,
              decoration: const InputDecoration(
                labelText: '图标代码（可选）',
                hintText: '输入图标代码',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final phoneText = phoneController.text.trim();
              final iconText = iconController.text.trim();
              
              if (selectedLabelId == null || phoneText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请选择标签并输入有效的电话号码')),
                );
                return;
              }

              try {
                final phoneNumber = PhoneNumber.fromString(phoneText);
                final labelService = Provider.of<LabelService>(context, listen: false);
                
                final uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
                final label = LabelPhoneEntry(
                  id: uniqueId,
                  phoneNumber: phoneNumber,
                  labelId: selectedLabelId!,
                  icon: iconText.isNotEmpty ? iconText : null,
                );
                
                await labelService.addLabel(label);
                final labelText = await _predefinedLabelService.getLabelById(selectedLabelId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('标签 "${labelText?.text ?? selectedLabelId}" 添加成功')),
                );
                Navigator.of(context).pop();
                await _loadLabels();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('添加标签失败: $e')),
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
    String? selectedLabelId = label.labelId;
    final phoneController = TextEditingController(text: label.phoneNumber.toString());
    final iconController = TextEditingController(text: label.icon ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑标签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PublicSelectLabel(
              initialLabelId: label.labelId,
              onLabelIdChanged: (labelId) {
                selectedLabelId = labelId;
              },
              selectLabelService: PredefinedLabelServiceAdapter(_predefinedLabelService),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: '电话号码',
                hintText: '输入电话号码',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: iconController,
              decoration: const InputDecoration(
                labelText: '图标代码（可选）',
                hintText: '输入图标代码',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final phoneText = phoneController.text.trim();
              final iconText = iconController.text.trim();
              
              if (selectedLabelId == null || phoneText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请选择标签并输入有效的电话号码')),
                );
                return;
              }

              try {
                final phoneNumber = PhoneNumber.fromString(phoneText);
                final labelService = Provider.of<LabelService>(context, listen: false);
                
                final updatedLabel = LabelPhoneEntry(
                  id: label.id,
                  phoneNumber: phoneNumber,
                  labelId: selectedLabelId!,
                  icon: iconText.isNotEmpty ? iconText : null,
                );
                
                await labelService.updateLabel(updatedLabel);
                final labelText = await _predefinedLabelService.getLabelById(selectedLabelId!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('标签 "${labelText?.text ?? selectedLabelId}" 更新成功')),
                );
                Navigator.of(context).pop();
                await _loadLabels();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('更新标签失败: $e')),
                );
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _importLabels() async {
    try {
      final labelService = Provider.of<LabelService>(context, listen: false);
      final result = await labelService.importLabelsFromFile('labels.json');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('成功导入 ${result.length} 个标签')),
      );
      await _loadLabels();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('导入标签失败: $e')),
      );
    }
  }

  Future<void> _exportLabels() async {
    try {
      final labelService = Provider.of<LabelService>(context, listen: false);
      final success = await labelService.exportLabelsToFile('labels.json');
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('标签导出成功')),
        );
      } else {
        throw Exception('导出失败');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('导出标签失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标签管理'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: _importLabels,
            tooltip: '导入标签',
          ),
          IconButton(
            icon: const Icon(Icons.file_upload),
            onPressed: _exportLabels,
            tooltip: '导出标签',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddLabelDialog,
            tooltip: '添加标签',
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
                      const Text('暂无标签', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('添加标签'),
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
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.blue, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '关于标签',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '标签可以帮助您更好地管理联系人，为电话号码添加自定义标签，方便识别来电和短信。',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
            const Text(
              '标签分类',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    final labelText = await _predefinedLabelService.getLabelById(label.labelId);
    return labelText?.text ?? label.labelId;
  }
  
  Widget _buildLabelChip(String label) {
    // 异步获取所有标签的文本，然后计算每个标签类型的数量
    // 这里需要一个更复杂的实现来正确计数
    // 在实际应用中，应该在加载标签时预先构建映射关系
    
    // 首先尝试找到与此标签文本对应的预定义标签
    Future<int> getCount() async {
      // 获取所有预定义标签
      final predefinedLabels = await _predefinedLabelService.getAllLabels();
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
                      tooltip: '编辑',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteLabel(label),
                      tooltip: '删除',
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