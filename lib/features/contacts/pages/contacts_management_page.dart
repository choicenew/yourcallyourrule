import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 通讯录管理页面
class ContactsManagementPage extends StatefulWidget {
  const ContactsManagementPage({super.key});

  @override
  State<ContactsManagementPage> createState() => _ContactsManagementPageState();
}

class _ContactsManagementPageState extends State<ContactsManagementPage> {
  bool _isLoading = true;
  List<Contact> _contacts = [];
  String? _selectedLabelId;
  String? _selectedLabelText;
  String _searchQuery = '';
  
  // 多选模式相关变量
  bool _isMultiSelectMode = false;
  Set<String> _selectedContactIds = {}; // 存储选中的联系人ID

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final contactService = Provider.of<ContactService>(context, listen: false);
      final contacts = await contactService.getAll();

      setState(() {
        _contacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('加载联系人失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Contact> get _filteredContacts {
    var filteredList = _contacts;
    
    // 搜索过滤
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((contact) {
        return contact.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            contact.phoneNumbers.any((phone) => phone.contains(_searchQuery));
      }).toList();
    }
    
    // 标签过滤
    if (_selectedLabelId != null) {
      filteredList = filteredList.where((contact) => contact.labelId == _selectedLabelId).toList();
    }
    
    // 按姓名首字母排序
    filteredList.sort((a, b) {
      String aFirstLetter = a.name.isNotEmpty ? a.name[0].toUpperCase() : '#';
      String bFirstLetter = b.name.isNotEmpty ? b.name[0].toUpperCase() : '#';
      
      if (!RegExp(r'[A-Z]').hasMatch(aFirstLetter)) aFirstLetter = '#';
      if (!RegExp(r'[A-Z]').hasMatch(bFirstLetter)) bFirstLetter = '#';
      
      if (aFirstLetter == '#' && bFirstLetter != '#') return 1;
      if (aFirstLetter != '#' && bFirstLetter == '#') return -1;
      return aFirstLetter.compareTo(bFirstLetter);
    });
    
    return filteredList;
  }

  // 显示联系人表单对话框（添加或编辑）
  void _showContactFormDialog({Contact? contact}) {
    final bool isEditing = contact != null;
    final String title = isEditing ? '编辑联系人' : '添加联系人';
    final String actionText = isEditing ? '保存' : '添加';
    final String successMessage = isEditing ? '联系人更新成功' : '联系人添加成功';
    
    // 初始化控制器
    final TextEditingController nameController = TextEditingController(text: contact?.name ?? '');
    final TextEditingController phoneController = TextEditingController(
      text: contact?.phoneNumbers.join(', ') ?? ''
    );
    final TextEditingController emailController = TextEditingController(text: contact?.email ?? '');
    String? currentSelectedLabelId = contact?.labelId ?? _selectedLabelId;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '姓名',
                    hintText: '请输入联系人姓名',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: '电话号码',
                    hintText: '请输入电话号码',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: '电子邮箱（可选）',
                    hintText: '请输入电子邮箱',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // 标签选择
                PublicSelectLabel(
                  initialLabelId: currentSelectedLabelId,
                  onLabelIdChanged: (labelId) {
                    setStateDialog(() {
                      currentSelectedLabelId = labelId;
                    });
                  },
                  themeColor: const Color(0xFFF5A623),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                // 验证表单
                if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('姓名和电话号码不能为空'),
                    backgroundColor: Colors.orange,
                  ));
                  return;
                }

                try {
                  final contactService = Provider.of<ContactService>(context, listen: false);
                  
                  if (isEditing) {
                    // 更新联系人
                    final updatedContact = contact.copyWith(
                      name: nameController.text,
                      phoneNumbers: phoneController.text.split(',').map((e) => e.trim()).toList(),
                      email: emailController.text.isNotEmpty ? emailController.text : null,
                      labelId: currentSelectedLabelId,
                    );
                    await contactService.update(updatedContact);
                  } else {
                    // 添加新联系人
                    final newContact = Contact(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameController.text,
                      phoneNumbers: [phoneController.text],
                      email: emailController.text.isNotEmpty ? emailController.text : null,
                      labelId: currentSelectedLabelId,
                    );
                    await contactService.addContact(newContact);
                  }
                  
                  _loadContacts(); // 刷新列表
                  Navigator.pop(context); // 关闭对话框
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(successMessage),
                    backgroundColor: Colors.green,
                  ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${isEditing ? "更新" : "添加"}联系人失败: $e'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text(actionText),
            ),
          ],
        ),
      ),
    );
  }
  
  // 添加联系人对话框
  void _showAddContactDialog() {
    _showContactFormDialog();
  }

  // 编辑联系人对话框
  void _showEditContactDialog(Contact contact) {
    _showContactFormDialog(contact: contact);
  }

  // 管理常用联系人
  Future<void> _manageFavoriteContacts() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('管理常用联系人'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              final contact = _contacts[index];
              return ListTile(
                leading: _buildContactAvatar(contact),
                title: Text(contact.name),
                subtitle: Text(contact.phoneNumbers.first),
                trailing: IconButton(
                  icon: Icon(
                    contact.isFavorite ? Icons.star : Icons.star_border,
                    color: contact.isFavorite ? const Color(0xFFF5A623) : Colors.grey,
                  ),
                  onPressed: () => _toggleFavorite(contact),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('完成'),
          ),
        ],
      ),
    );
  }

  List<Contact> get _favoriteContacts {
    return _contacts.where((contact) => contact.isFavorite).toList();
  }

  // 处理联系人操作的通用方法
  Future<void> _handleContactOperation({
    required Contact contact,
    required Future<void> Function() operation,
    required String successMessage,
    String errorPrefix = '操作',
  }) async {
    try {
      await operation();
      _loadContacts(); // 刷新列表
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(successMessage),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$errorPrefix失败: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // 切换联系人收藏状态
  Future<void> _toggleFavorite(Contact contact) async {
    final contactService = Provider.of<ContactService>(context, listen: false);
    final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
    final message = updatedContact.isFavorite ? '已添加到常用联系人' : '已从常用联系人中移除';
    
    await _handleContactOperation(
      contact: contact,
      operation: () => contactService.update(updatedContact),
      successMessage: message,
      errorPrefix: '更新收藏状态',
    );
  }
  
  // 删除单个联系人
  Future<void> _deleteContact(Contact contact) async {
    final confirmed = await _showConfirmDialog(
      title: '删除联系人',
      content: '确定要删除 ${contact.name} 吗？',
      confirmText: '删除',
    );
    
    if (!confirmed) return;
    
    final contactService = Provider.of<ContactService>(context, listen: false);
    await _handleContactOperation(
      contact: contact,
      operation: () => contactService.delete(contact),
      successMessage: '联系人已删除',
      errorPrefix: '删除',
    );
  }
  
  // 显示标签选择对话框
  Future<void> _showLabelSelectionDialog(Contact contact) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择标签'),
        content: PublicSelectLabel(
          initialLabelId: contact.labelId,
          onLabelIdChanged: (labelId) async {
            final contactService = Provider.of<ContactService>(context, listen: false);
            final updatedContact = contact.copyWith(labelId: labelId);
            
            // 使用通用操作处理方法
            await _handleContactOperation(
              contact: contact,
              operation: () => contactService.update(updatedContact),
              successMessage: '标签已更新',
              errorPrefix: '更新标签',
            );
            
            Navigator.pop(context);
          },
          themeColor: const Color(0xFFF5A623),
        ),
      ),
    );
  }

  // 显示确认对话框
  Future<bool> _showConfirmDialog({
    required String title,
    required String content,
    required String confirmText,
    Color confirmColor = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText, style: TextStyle(color: confirmColor)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // 批量删除选中的联系人
  Future<void> _deleteSelectedContacts() async {
    if (_selectedContactIds.isEmpty) return;
    
    // 显示确认对话框
    final confirmed = await _showConfirmDialog(
      title: '批量删除联系人',
      content: '确定要删除选中的 ${_selectedContactIds.length} 个联系人吗？',
      confirmText: '删除',
    );
    
    if (!confirmed) return;
    
    final contactService = Provider.of<ContactService>(context, listen: false);
    
    // 获取选中的联系人
    final selectedContacts = _contacts.where(
      (contact) => _selectedContactIds.contains(contact.id)
    ).toList();
    
    // 使用通用操作处理方法
    await _handleContactOperation(
      contact: selectedContacts.first, // 只是为了满足参数要求，实际上不使用这个联系人
      operation: () => contactService.deleteAll(selectedContacts),
      successMessage: '已删除 ${selectedContacts.length} 个联系人',
      errorPrefix: '批量删除',
    );
    
    // 退出多选模式
    setState(() {
      _isMultiSelectMode = false;
      _selectedContactIds.clear();
    });
  }
  
  // 切换多选模式
  void _toggleMultiSelectMode() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      _selectedContactIds.clear();
    });
  }
  
  // 选择或取消选择联系人
  void _toggleContactSelection(String contactId) {
    setState(() {
      if (_selectedContactIds.contains(contactId)) {
        _selectedContactIds.remove(contactId);
      } else {
        _selectedContactIds.add(contactId);
      }
    });
  }
  
  // 构建联系人头像
  Widget _buildContactAvatar(Contact contact, {bool isCheckbox = false}) {
    if (isCheckbox) {
      return Checkbox(
        value: _selectedContactIds.contains(contact.id),
        onChanged: (_) => _toggleContactSelection(contact.id),
        activeColor: const Color(0xFFF5A623),
      );
    }
    
    return CircleAvatar(
      backgroundColor: const Color(0xFFF5A623).withValues(alpha:0.2),
      child: Text(
        contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '#',
        style: const TextStyle(color: Color(0xFFF5A623)),
      ),
    );
  }
  
  // 构建标签显示组件
  Widget _buildLabelChip(String? labelId) {
    if (labelId == null) return const SizedBox.shrink();
    
    return FutureBuilder<String?>(
      future: Provider.of<PredefinedLabelService>(context, listen: false)
          .getLabelById(labelId)
          .then((label) => label?.text),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF5A623).withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              snapshot.data!,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFF5A623),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
  
  // 构建联系人操作菜单
  List<PopupMenuItem<String>> _buildContactMenuItems(Contact contact) {
    return [
      PopupMenuItem(
        value: 'favorite',
        child: ListTile(
          leading: Icon(
            contact.isFavorite ? Icons.star : Icons.star_border,
            color: contact.isFavorite ? const Color(0xFFF5A623) : null,
          ),
          title: Text(contact.isFavorite ? '取消收藏' : '添加收藏'),
          contentPadding: EdgeInsets.zero,
        ),
      ),
      const PopupMenuItem(
        value: 'label',
        child: Row(
          children: [
            Icon(Icons.label_outline, color: Color(0xFFF5A623)),
            SizedBox(width: 8),
            Text('修改标签'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit, color: Color(0xFFF5A623)),
            SizedBox(width: 8),
            Text('编辑'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 8),
            Text('删除', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    ];
  }
  
  // 处理联系人菜单选择
  Future<void> _handleContactMenuAction(String action, Contact contact) async {
    switch (action) {
      case 'favorite':
        await _toggleFavorite(contact);
        break;
      case 'label':
        _showLabelSelectionDialog(contact);
        break;
      case 'edit':
        _showEditContactDialog(contact);
        break;
      case 'delete':
        _deleteContact(contact);
        break;
    }
  }

  // 构建联系人卡片
  Widget _buildContactCard(Contact contact) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _buildContactAvatar(contact, isCheckbox: _isMultiSelectMode),
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.phoneNumbers.first),
            _buildLabelChip(contact.labelId),
          ],
        ),
        onTap: _isMultiSelectMode 
          ? () => _toggleContactSelection(contact.id)
          : null,
        trailing: _isMultiSelectMode
          ? null
          : PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) => _handleContactMenuAction(value, contact),
              itemBuilder: (context) => _buildContactMenuItems(contact),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 分组逻辑：按姓名首字母分组
    Map<String, List<Contact>> groupedContacts = {};
    for (var contact in _filteredContacts) {
      String firstLetter = contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '#';
      if (!RegExp(r'[A-Z]').hasMatch(firstLetter)) {
        firstLetter = '#';
      }
      groupedContacts.putIfAbsent(firstLetter, () => []).add(contact);
    }
    
    // 获取并排序分组键
    List<String> sortedKeys = groupedContacts.keys.toList();
    sortedKeys.sort((a, b) {
      if (a == '#') return 1;
      if (b == '#') return -1;
      return a.compareTo(b);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(_isMultiSelectMode ? '已选择 ${_selectedContactIds.length} 项' : '通讯录管理'),
        backgroundColor: const Color(0xFFF5A623),
        elevation: 0,
        leading: _isMultiSelectMode
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: _toggleMultiSelectMode,
            )
          : null,
        actions: [
          // 多选模式下显示删除按钮
          if (_isMultiSelectMode)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedContactIds.isNotEmpty ? _deleteSelectedContacts : null,
            )
          else ...[  
            // 切换到多选模式的按钮
            IconButton(
              icon: const Icon(Icons.select_all),
              onPressed: _toggleMultiSelectMode,
            ),
            IconButton(
              icon: const Icon(Icons.import_export),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('导入/导出联系人'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.file_upload),
                        title: const Text('导入联系人'),
                        onTap: () async {
                          Navigator.pop(context);
                          try {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['vcf', 'csv', 'yaml', 'json'],
                            );
                            if (result != null) {
                              final file = File(result.files.single.path!);
                              final content = await file.readAsString();
                              final extension = result.files.single.extension?.toLowerCase();
                              final contactService = Provider.of<ContactService>(context, listen: false);
                              final directory = await getExternalStorageDirectory();
                              switch (extension) {
                                case 'vcf':
                                  await contactService.importContactsFromVcf(content, directory!);
                                  break;
                                case 'csv':
                                  await contactService.importContactsFromCsv(content);
                                  break;
                                case 'yaml':
                                  await contactService.importContactsFromYaml(content);
                                  break;
                                case 'json':
                                  final jsonData = jsonDecode(content) as List<dynamic>;
                                  await contactService.importContactsFromJson(jsonData);
                                  break;
                                default:
                                  throw Exception('不支持的文件格式');
                              }
                              await _loadContacts(); // 刷新列表
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('导入成功'), backgroundColor: Colors.green),
                                );
                              }
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('导入失败: $e'), backgroundColor: Colors.red),
                              );
                            }
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.file_download),
                        title: const Text('导出联系人'),
                        onTap: () async {
                          Navigator.pop(context);
                          try {
                            final contactService = Provider.of<ContactService>(context, listen: false);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('选择导出格式'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.description),
                                      title: const Text('CSV格式'),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final csvContent = await contactService.exportContactsToCsv();
                                        final directory = await getExternalStorageDirectory();
                                        final file = File('${directory!.path}/contacts.csv');
                                        await file.writeAsString(csvContent);

                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('文件已保存到: ${file.path}'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.code),
                                      title: const Text('JSON格式'),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final jsonContent = await contactService.exportContactsToJson();
                                        final directory = await getExternalStorageDirectory();
                                        final file = File('${directory!.path}/contacts.json');
                                        await file.writeAsString(jsonContent);

                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('文件已保存到: ${file.path}'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('导出失败: $e'), backgroundColor: Colors.red),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            tooltip: '导入/导出联系人',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadContacts,
            tooltip: '刷新',
          ),
        ],
    ]  ),
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFF3E0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // 常用联系人区域
            if (_favoriteContacts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '常用联系人',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _manageFavoriteContacts();
                          },
                          child: const Text('管理'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _favoriteContacts.length,
                        itemBuilder: (context, index) {
                          final contact = _favoriteContacts[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: const Color(0xFFF5A623).withValues(alpha:0.1),
                                      child: Text(
                                        contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                                        style: const TextStyle(
                                          color: Color(0xFFF5A623),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -4,
                                      top: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFF5A623),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.star,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  contact.name,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            // 搜索栏
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '搜索联系人',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // 标签筛选
            if (_selectedLabelText != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Chip(
                      label: Text(_selectedLabelText!),
                      backgroundColor: const Color(0xFFF5A623).withValues(alpha:0.1),
                      labelStyle: const TextStyle(color: Color(0xFFF5A623)),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          _selectedLabelId = null;
                          _selectedLabelText = null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('选择标签'),
                            content: PublicSelectLabel(
                              initialLabelId: _selectedLabelId,
                              onLabelIdChanged: (labelId) async {
                                final labelService = Provider.of<PredefinedLabelService>(context, listen: false);
                                final label = await labelService.getLabelById(labelId);
                                setState(() {
                                  _selectedLabelId = labelId;
                                  _selectedLabelText = label?.text;
                                });
                                Navigator.pop(context);
                              },
                              themeColor: const Color(0xFFF5A623),
                            ),
                          ),
                        );
                      },
                      child: const Text('更改标签'),
                    ),
                  ],
                ),
              ),

            // 联系人列表
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildContactsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        backgroundColor: const Color(0xFFF5A623),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContactsList() {
    final filteredContacts = _filteredContacts;

    if (filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.contacts,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _contacts.isEmpty ? '暂无联系人' : '没有匹配的联系人',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            if (_contacts.isEmpty)
              ElevatedButton.icon(
                onPressed: _showAddContactDialog,
                icon: const Icon(Icons.add),
                label: const Text('添加联系人'),
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // 头像或首字母
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623).withValues(alpha:0.2),
                    shape: BoxShape.circle,
                  ),
                  child: contact.avatar != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            contact.avatar!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Text(
                                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF5A623),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF5A623),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact.phoneNumbers.isNotEmpty ? contact.phoneNumbers[0] : '',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      if (contact.email != null && contact.email!.isNotEmpty) ...[  
                        const SizedBox(height: 2),
                        Text(
                          contact.email!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                      if (contact.labelId != null) ...[  
                        const SizedBox(height: 4),
                        PublicSelectLabel(
                          initialLabelId: contact.labelId,
                          onLabelIdChanged: (labelId) async {
                            final contactService = Provider.of<ContactService>(context, listen: false);
                            await contactService.updateContact(contact.copyWith(labelId: labelId));
                            _loadContacts();
                          },
                          themeColor: Colors.blue,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    contact.isFavorite ? Icons.star : Icons.star_border,
                    color: contact.isFavorite ? const Color(0xFFF5A623) : Colors.grey,
                  ),
                  onPressed: () => _toggleFavorite(contact),
                  tooltip: contact.isFavorite ? '取消收藏' : '添加到常用联系人',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFF5A623)),
                  onPressed: () => _showEditContactDialog(contact),
                  tooltip: '编辑',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('删除联系人'),
                        content: Text('确定要删除联系人 ${contact.name} 吗？'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('取消'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                final contactService = Provider.of<ContactService>(context, listen: false);
                                await contactService.deleteContact(PhoneNumber(contact.phoneNumbers.first));
                                await _loadContacts(); // 刷新列表
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('删除成功'), backgroundColor: Colors.green),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('删除失败: $e'), backgroundColor: Colors.red),
                                  );
                                }
                              }
                            },
                            child: const Text('删除'),
                          ),
                        ],
                      ),
                    );
                  },
                  tooltip: '删除',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}