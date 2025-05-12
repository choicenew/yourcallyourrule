import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/common/services/label_service_component.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';

/// 允许/阻止规则管理页面
class AllowedBlockedPage extends StatefulWidget {
  const AllowedBlockedPage({super.key});

  @override
  State<AllowedBlockedPage> createState() => _AllowedBlockedPageState();
}

class _AllowedBlockedPageState extends State<AllowedBlockedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<AllowedBlockedRule> _allowedRules = [];
  List<AllowedBlockedRule> _blockedRules = [];
  String? _selectedLabel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRules();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadRules() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final service = Provider.of<AllowedBlockedService>(context, listen: false);
      final allowedRules = await service.getAllAllowedRules();
      final blockedRules = await service.getAllBlockedRules();

      setState(() {
        _allowedRules = allowedRules;
        _blockedRules = blockedRules;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载规则失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAddRuleDialog(bool isAllowed) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String? selectedLabelId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('添加${isAllowed ? "允许" : "阻止"}规则'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '规则名称',
                hintText: '例如：家人、朋友等',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: '电话号码',
                hintText: '例如：10086、12345等',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            // 标签选择器
            PublicSelectLabel(
              onLabelIdChanged: (labelId) {
                selectedLabelId = labelId;
              },
              themeColor: isAllowed ? Colors.green : Colors.red,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('规则名称和电话号码不能为空'),
                  backgroundColor: Colors.red,
                ));
                return;
              }
              
              try {
                final service = Provider.of<AllowedBlockedService>(context, listen: false);
                
                // 创建列表条目
                final entry = ListEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  phoneNumber: PhoneNumber.fromString(phoneController.text),
                  labelId: selectedLabelId ?? '',
                  avatar: null,
                );
                
                // 添加规则
                await service.addAllowedBlockedRule(
                  entry, 
                  isAllowed ? RuleAction.allow : RuleAction.block
                );
                
                // 刷新规则列表
                if (mounted) {
                  Navigator.pop(context);
                  await _loadRules();
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${isAllowed ? "允许" : "阻止"}规则添加成功'),
                    backgroundColor: Colors.green,
                  ));
                }
              } catch (e) {
                // 显示错误提示
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('添加规则失败: $e'),
                    backgroundColor: Colors.red,
                  ));
                }
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleRule(String ruleId, bool isEnabled, bool isAllowed) async {
    try {
      final service = Provider.of<AllowedBlockedService>(context, listen: false);
      await service.toggleRuleStatus(ruleId, isEnabled);
      await _loadRules();
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('规则${isEnabled ? "启用" : "禁用"}成功'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('操作失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _deleteRule(String ruleId, bool isAllowed) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除规则'),
        content: Text('确定要删除这条${isAllowed ? "允许" : "阻止"}规则吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      try {
        final service = Provider.of<AllowedBlockedService>(context, listen: false);
        await service.removeRule(ruleId);
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('规则删除成功'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('删除失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('按标签筛选'),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            initialLabelId: _selectedLabel,
            onLabelIdChanged: (labelId) {
              setState(() {
                _selectedLabel = labelId;
              });
              Navigator.pop(context);
            },
            themeColor: Colors.blue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          if (_selectedLabel != null)
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedLabel = null;
                });
                Navigator.pop(context);
              },
              child: const Text('清除筛选'),
            ),
        ],
      ),
    );
  }

  Future<void> _exportRules(bool isAllowed) async {
    try {
      final service = Provider.of<AllowedBlockedService>(context, listen: false);
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '导出${isAllowed ? "允许" : "阻止"}规则',
        fileName: '${isAllowed ? "allowed" : "blocked"}_rules.json',
      );
      
      if (result != null) {
        if (isAllowed) {
          await service.exportAllowedRulesToFile(result);
        } else {
          await service.exportBlockedRulesToFile(result);
        }
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${isAllowed ? "允许" : "阻止"}规则导出成功'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导出规则失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _importRules(bool isAllowed) async {
    try {
      final service = Provider.of<AllowedBlockedService>(context, listen: false);
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: '导入${isAllowed ? "允许" : "阻止"}规则',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.single.path != null) {
        if (isAllowed) {
          await service.importAllowedRulesFromFile(result.files.single.path!);
        } else {
          await service.importBlockedRulesFromFile(result.files.single.path!);
        }
        
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${isAllowed ? "允许" : "阻止"}规则导入成功'),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('导入规则失败: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('允许/阻止规则'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showLabelFilterDialog,
            tooltip: '标签筛选',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadRules,
            tooltip: '刷新',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: '允许规则'),
            Tab(text: '阻止规则'),
          ],
        ),
      ),
      body: Column(
        children: [
          // 显示当前筛选的标签
          if (_selectedLabel != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    label: Text('标签: $_selectedLabel'),
                    backgroundColor: Colors.blue.withAlpha(25),
                    labelStyle: const TextStyle(color: Colors.blue),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedLabel = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          // 规则列表
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      // 允许规则列表
                      _buildRulesList(_allowedRules, true),
                      
                      // 阻止规则列表
                      _buildRulesList(_blockedRules, false),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRuleDialog(_tabController.index == 0),
        backgroundColor: const Color(0xFFF5A623),
        child: const Icon(Icons.add),
        tooltip: '添加规则',
      ),
    );
  }

  Widget _buildRulesList(List<AllowedBlockedRule> rules, bool isAllowed) {
    // 根据标签筛选
    var filteredRules = rules;
    if (_selectedLabel != null) {
      filteredRules = rules.where((rule) => rule.labelId == _selectedLabel).toList();
    }
    
    if (filteredRules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAllowed ? Icons.check_circle_outline : Icons.block,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _selectedLabel != null
                  ? '没有匹配的${isAllowed ? "允许" : "阻止"}规则'
                  : '暂无${isAllowed ? "允许" : "阻止"}规则',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddRuleDialog(isAllowed),
              icon: const Icon(Icons.add),
              label: Text('添加${isAllowed ? "允许" : "阻止"}规则'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5A623),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_upload),
                  label: const Text('导入'),
                  onPressed: () => _importRules(isAllowed),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_download),
                  label: const Text('导出'),
                  onPressed: () => _exportRules(isAllowed),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            if (_selectedLabel != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedLabel = null;
                  });
                },
                child: const Text('清除标签筛选'),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRules.length,
      itemBuilder: (context, index) {
        final rule = filteredRules[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (isAllowed ? Colors.green : Colors.red).withAlpha(25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isAllowed ? Icons.check_circle : Icons.block,
                        color: isAllowed ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rule.name,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rule.phoneNumber.toString(),
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: rule.isEnabled,
                      onChanged: (value) => _toggleRule(rule.id, value, isAllowed),
                      activeColor: isAllowed ? Colors.green : Colors.red,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteRule(rule.id, isAllowed),
                      tooltip: '删除',
                    ),
                  ],
                ),
                if (rule.labelId != null && rule.labelId.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 64),
                    child: PublicSelectLabel(
                      initialLabelId: rule.labelId,
                      onLabelIdChanged: (labelId) async {
                        try {
                          final service = Provider.of<AllowedBlockedService>(context, listen: false);
                          // 创建更新后的规则
                          final updatedRule = AllowedBlockedRule(
                            id: rule.id,
                            name: rule.name,
                            action: rule.action,
                            phoneNumber: rule.phoneNumber,
                            labelId: labelId,
                            priority: rule.priority,
                            isEnabled: rule.isEnabled,
                            isSubscribed: rule.isSubscribed,
                            count: rule.count,
                            avatar: rule.avatar,
                          );
                          await service.updateAllowedBlockedRule(updatedRule);
                          await _loadRules();
                          
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('标签更新成功'),
                            backgroundColor: Colors.green,
                          ));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('更新标签失败: $e'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      themeColor: isAllowed ? Colors.green : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }


}