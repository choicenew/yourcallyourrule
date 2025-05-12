import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yourcallyourrule/core/entities/list/list_entry.dart';


import 'package:yourcallyourrule/core/value_objects/phone_number.dart';


import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/rules/services/blacklist_whitelist_service.dart';
import 'package:file_picker/file_picker.dart';


/// 黑白名单管理页面
class BlacklistWhitelistPage extends StatefulWidget {
  const BlacklistWhitelistPage({super.key});

  @override
  State<BlacklistWhitelistPage> createState() => _BlacklistWhitelistPageState();
}

class _BlacklistWhitelistPageState extends State<BlacklistWhitelistPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<WhitelistRule> _whitelistRules = [];
  List<BlacklistRule> _blacklistRules = [];
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
      final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
      final whitelistRules = await service.getAllWhitelistRules();
      final blacklistRules = await service.getAllBlacklistRules();

      setState(() {
        _whitelistRules = whitelistRules;
        _blacklistRules = blacklistRules;
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

  void _showAddRuleDialog(bool isWhitelist) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    String? selectedLabel;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('添加${isWhitelist ? "白名单" : "黑名单"}规则'),
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
              initialLabel: selectedLabel,
              onLabelChanged: (label) {
                selectedLabel = label;
              },
              themeColor: isWhitelist ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
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
                final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
                
                // 创建列表条目
                final entry = ListEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text,
                  phoneNumber: PhoneNumber.fromString(phoneController.text),
                  label: selectedLabel ?? (isWhitelist ? '白名单' : '黑名单'),
                  avatar: null,
                );
                
                // 添加规则
                if (isWhitelist) {
                  await service.addToWhitelist(entry);
                } else {
                  await service.addToBlacklist(entry);
                }
                
                // 刷新规则列表
                if (mounted) {
                  Navigator.pop(context);
                  await _loadRules();
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${isWhitelist ? "白名单" : "黑名单"}规则添加成功'),
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

  Future<void> _toggleRule(String ruleId, bool isEnabled, bool isWhitelist) async {
    try {
      final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
      
      if (isWhitelist) {
        await service.toggleWhitelistRule(ruleId, isEnabled);
      } else {
        await service.toggleBlacklistRule(ruleId, isEnabled);
      }
      
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

  Future<void> _deleteRule(String ruleId, bool isWhitelist) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除规则'),
        content: Text('确定要删除这条${isWhitelist ? "白名单" : "黑名单"}规则吗？'),
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
        final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
        
        if (isWhitelist) {
          await service.removeFromWhitelist(ruleId);
        } else {
          await service.removeFromBlacklist(ruleId);
        }
        
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('规则删除成功'),
          backgroundColor: Colors.green,
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('删除规则失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> _exportRules(bool isWhitelist) async {
    try {
      final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
      final result = await FilePicker.platform.saveFile(
        dialogTitle: '导出${isWhitelist ? "白名单" : "黑名单"}规则',
        fileName: '${isWhitelist ? "whitelist" : "blacklist"}_rules.json',
      );
      
      if (result != null) {
        if (isWhitelist) {
          await service.exportWhitelistRules(result);
        } else {
          await service.exportBlacklistRules(result);
        }
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${isWhitelist ? "白名单" : "黑名单"}规则导出成功'),
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

  Future<void> _importRules(bool isWhitelist) async {
    try {
      final service = Provider.of<BlacklistWhitelistService>(context, listen: false);
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: '导入${isWhitelist ? "白名单" : "黑名单"}规则',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      
      if (result != null && result.files.single.path != null) {
        if (isWhitelist) {
          await service.importWhitelistRules(result.files.single.path!);
        } else {
          await service.importBlacklistRules(result.files.single.path!);
        }
        
        await _loadRules();
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${isWhitelist ? "白名单" : "黑名单"}规则导入成功'),
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

  void _showLabelFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('按标签筛选'),
        content: SizedBox(
          width: double.maxFinite,
          child: PublicSelectLabel(
            initialLabel: _selectedLabel,
            onLabelChanged: (label) {
              setState(() {
                _selectedLabel = label;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('黑白名单管理'),
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
          tabs: const [
            Tab(text: '白名单'),
            Tab(text: '黑名单'),
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
                    backgroundColor: Colors.blue.withOpacity(0.1),
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
                      // 白名单列表
                      _buildRulesList(true),
                      // 黑名单列表
                      _buildRulesList(false),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRuleDialog(_tabController.index == 0),
        child: const Icon(Icons.add),
        tooltip: '添加规则',
      ),
    );
  }

  Widget _buildRulesList(bool isWhitelist) {
    final rules = isWhitelist ? _whitelistRules : _blacklistRules;
    
    // 根据标签筛选
    var filteredRules = rules;
    if (_selectedLabel != null) {
      filteredRules = rules.where((rule) => rule.label == _selectedLabel).toList();
    }
    
    if (filteredRules.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isWhitelist ? Icons.check_circle_outline : Icons.block,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _selectedLabel != null
                  ? '没有匹配的${isWhitelist ? "白名单" : "黑名单"}规则'
                  : '暂无${isWhitelist ? "白名单" : "黑名单"}规则',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Text('添加${isWhitelist ? "白名单" : "黑名单"}规则'),
              onPressed: () => _showAddRuleDialog(isWhitelist),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_upload),
                  label: const Text('导入'),
                  onPressed: () => _importRules(isWhitelist),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.file_download),
                  label: const Text('导出'),
                  onPressed: () => _exportRules(isWhitelist),
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
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredRules.length,
      itemBuilder: (context, index) {
        final rule = filteredRules[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (isWhitelist ? Colors.green : Colors.red).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWhitelist ? Icons.check_circle_outline : Icons.block,
                        color: isWhitelist ? Colors.green : Colors.red,
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
                            rule.phoneNumber.value,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: rule.isEnabled,
                      onChanged: (value) => _toggleRule(rule.id, value, isWhitelist),
                      activeColor: isWhitelist ? Colors.green : Colors.red,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteRule(rule.id, isWhitelist),
                      tooltip: '删除',
                    ),
                  ],
                ),
                // 显示标签（如果有）
                if (rule.label != null && rule.label!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 64.0),
                    child: Chip(
                      label: Text(rule.label!),
                      backgroundColor: (isWhitelist ? Colors.green : Colors.red).withOpacity(0.1),
                      labelStyle: TextStyle(color: isWhitelist ? Colors.green : Colors.red),
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