import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/labeled_service_card.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';

/// 可复用的标签服务组件
/// 这个组件可以被各种需要标签功能的服务复用
/// 例如：来电识别、短信过滤、规则设置等
class LabelServiceComponent extends StatefulWidget {
  /// 服务标题
  final String serviceTitle;
  
  /// 服务描述
  final String serviceDescription;
  
  /// 服务图标
  final IconData serviceIcon;
  
  /// 服务渐变色
  final List<Color> serviceGradientColors;
  
  /// 标签选择回调
  final Function(LabelEntry) onLabelSelected;
  
  /// 是否启用
  final bool isEnabled;
  
  /// 构造函数
  const LabelServiceComponent({
    Key? key,
    required this.serviceTitle,
    required this.serviceDescription,
    required this.serviceIcon,
    required this.serviceGradientColors,
    required this.onLabelSelected,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  State<LabelServiceComponent> createState() => _LabelServiceComponentState();
}

class _LabelServiceComponentState extends State<LabelServiceComponent> {
  List<LabelEntry> _labels = [];
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
    
    try {
      // 获取标签服务
      final labelService = LabelService(Provider.of(context, listen: false));
      // 获取所有标签
      final labels = await labelService.getAllLabels();
      
      setState(() {
        _labels = labels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // 显示错误提示
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载标签失败: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(8),
        ));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // 提取所有标签文本
    final labelTexts = _labels.map((label) => label.label).toSet().toList();
    
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : LabeledServiceCard(
            title: widget.serviceTitle,
            description: widget.serviceDescription,
            labels: labelTexts,
            icon: widget.serviceIcon,
            onTap: () => _showLabelSelectionDialog(),
            gradientColors: widget.serviceGradientColors,
            isEnabled: widget.isEnabled,
            trailing: IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: _loadLabels,
              tooltip: '刷新标签',
            ),
          );
  }
  
  // 显示标签选择对话框
  void _showLabelSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('选择${widget.serviceTitle}标签'),
        content: SizedBox(
          width: double.maxFinite,
          child: _labels.isEmpty
              ? const Center(child: Text('暂无标签'))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _labels.length,
                  itemBuilder: (context, index) {
                    final label = _labels[index];
                    return ListTile(
                      title: Text(label.label),
                      subtitle: Text(label.phoneNumber.toString()),
                      leading: CircleAvatar(
                        backgroundColor: widget.serviceGradientColors[0],
                        child: Icon(
                          label.icon != null
                              ? IconData(int.parse(label.icon!), fontFamily: 'MaterialIcons')
                              : Icons.label,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        widget.onLabelSelected(label);
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => _showAddLabelDialog(),
            child: const Text('添加新标签'),
          ),
        ],
      ),
    );
  }
  
  // 显示添加标签对话框
  void _showAddLabelDialog() {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加新标签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(
                labelText: '标签名称',
                hintText: '例如：骚扰电话、快递、外卖等',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              if (labelController.text.isEmpty || phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('标签名称和电话号码不能为空'),
                  backgroundColor: Colors.red,
                ));
                return;
              }
              
              try {
                // 获取标签服务
                final labelService = LabelService(Provider.of(context, listen: false));
                
                // 创建新标签
                final uniqueId = DateTime.now().millisecondsSinceEpoch.toString() + labelController.text.hashCode.toString();
                final phoneNumber = PhoneNumber.fromString(phoneController.text);
                final newLabel = LabelEntry(
                  id: uniqueId,
                  phoneNumber: phoneNumber,
                  label: labelController.text,
                  icon: Icons.label.codePoint.toString(),
                );
                
                // 保存标签
                await labelService.addLabel(newLabel);
                
                // 刷新标签列表
                if (mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  _loadLabels();
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('标签 ${labelController.text} 添加成功'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
                  ));
                }
              } catch (e) {
                // 显示错误提示
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('添加标签失败: $e'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
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
}

/// 标签服务页面
/// 用于展示和管理标签
class LabelServicePage extends StatelessWidget {
  const LabelServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标签管理'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<LabelEntry>>(
          future: LabelService(Provider.of(context, listen: false)).getAllLabels(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(child: Text('加载标签失败: ${snapshot.error}'));
            }
            
            final labels = snapshot.data ?? [];
            
            if (labels.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.label_off, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('暂无标签', style: TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _showAddLabelDialog(context),
                      icon: const Icon(Icons.add),
                      label: const Text('添加标签'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5A623),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            // 按标签名称分组
            final Map<String, List<LabelEntry>> groupedLabels = {};
            for (final label in labels) {
              if (!groupedLabels.containsKey(label.label)) {
                groupedLabels[label.label] = [];
              }
              groupedLabels[label.label]!.add(label);
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedLabels.length,
              itemBuilder: (context, index) {
                final labelName = groupedLabels.keys.elementAt(index);
                final labelEntries = groupedLabels[labelName]!;
                
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ExpansionTile(
                    title: Text(
                      labelName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFF5A623),
                      child: Icon(
                        labelEntries.first.icon != null
                            ? IconData(int.parse(labelEntries.first.icon!), fontFamily: 'MaterialIcons')
                            : Icons.label,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text('${labelEntries.length} 个号码'),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: labelEntries.length,
                        itemBuilder: (context, i) {
                          final entry = labelEntries[i];
                          return ListTile(
                            title: Text(entry.phoneNumber.toString()),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDeleteLabel(context, entry),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLabelDialog(context),
        backgroundColor: const Color(0xFFF5A623),
        child: const Icon(Icons.add),
      ),
    );
  }
  
  // 显示添加标签对话框
  void _showAddLabelDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('添加新标签'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(
                labelText: '标签名称',
                hintText: '例如：骚扰电话、快递、外卖等',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              if (labelController.text.isEmpty || phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('标签名称和电话号码不能为空'),
                  backgroundColor: Colors.red,
                ));
                return;
              }
              
              try {
                // 获取标签服务
                final labelService = LabelService(Provider.of(context, listen: false));
                
                // 创建新标签
                final uniqueId = DateTime.now().millisecondsSinceEpoch.toString() + labelController.text.hashCode.toString();
                final phoneNumber = PhoneNumber.fromString(phoneController.text);
                final newLabel = LabelEntry(
                  id: uniqueId,
                  phoneNumber: phoneNumber,
                  label: labelController.text,
                  icon: Icons.label.codePoint.toString(),
                );
                
                // 保存标签
                await labelService.addLabel(newLabel);
                
                // 刷新页面
                if (context.mounted) {
                  Navigator.pop(context);
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('标签 ${labelController.text} 添加成功'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
                  ));
                  
                  // 刷新页面
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LabelServicePage()),
                  );
                }
              } catch (e) {
                // 显示错误提示
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('添加标签失败: $e'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
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
  
  // 确认删除标签
  void _confirmDeleteLabel(BuildContext context, LabelEntry label) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除标签'),
        content: Text('确定要删除标签 ${label.label} 下的号码 ${label.phoneNumber} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              try {
                // 获取标签服务
                final labelService = LabelService(Provider.of(context, listen: false));
                
                // 删除标签
                await labelService.removeLabel(label.id);
                
                // 刷新页面
                if (context.mounted) {
                  Navigator.pop(context);
                  
                  // 显示成功提示
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('标签删除成功'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
                  ));
                  
                  // 刷新页面
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LabelServicePage()),
                  );
                }
              } catch (e) {
                // 显示错误提示
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('删除标签失败: $e'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.all(8),
                  ));
                }
              }
            },
            child: const Text('删除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// PhoneNumber 类的扩展，用于标签服务
extension PhoneNumberExtension on PhoneNumber {
  /// 获取电话号码的标签
  Future<String?> getLabel(BuildContext context) async {
    final labelService = LabelService(Provider.of(context, listen: false));
    final label = await labelService.getLabelByPhoneNumber(this);
    return label?.label;
  }
}