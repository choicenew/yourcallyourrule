import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/contact_edit_dialog.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/provider/providers/contact_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';

/// 通讯录管理页面
class ContactsManagementPage extends ConsumerStatefulWidget {
  const ContactsManagementPage({super.key});

  @override
  ConsumerState<ContactsManagementPage> createState() => _ContactsManagementPageState();
}

class _ContactsManagementPageState extends ConsumerState<ContactsManagementPage> {
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
      final contactService = ref.read(contactServiceProvider);
      final contacts = await contactService.getAll();

      setState(() {
        _contacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.loadContactsFailed}: $e'),
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
    // 使用增强的ContactEditDialog替代内联对话框实现
    ContactEditDialog.show(
      context,
      contact: contact,
      themeColor: const Color(0xFFF5A623),
      onContactUpdated: () {
        _loadContacts(); // 刷新列表
      },
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
        title: Text(AppLocalizations.of(context)!.manageFavoriteContacts),
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
            child: Text(AppLocalizations.of(context)!.done),
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
    String? errorPrefix,
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
          content: Text('${errorPrefix ?? AppLocalizations.of(context)!.operationFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // 切换联系人收藏状态
  Future<void> _toggleFavorite(Contact contact) async {
    final contactService = ref.read(contactServiceProvider);
    final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
    final message = updatedContact.isFavorite ? 
      AppLocalizations.of(context)!.addedToFavorites : 
      AppLocalizations.of(context)!.removedFromFavorites;
    
    await _handleContactOperation(
      contact: contact,
      operation: () => contactService.update(updatedContact),
      successMessage: message,
      errorPrefix: AppLocalizations.of(context)!.updateFavoriteStatus,
    );
  }
  
  // 删除单个联系人
  Future<void> _deleteContact(Contact contact) async {
    final confirmed = await _showConfirmDialog(
      title: AppLocalizations.of(context)!.deleteContact,
      content: AppLocalizations.of(context)!.deleteContactConfirm(contact.name),
      confirmText: AppLocalizations.of(context)!.deleteButton,
    );
    
    if (!confirmed) return;
    
    final contactService = ref.read(contactServiceProvider);
    await _handleContactOperation(
      contact: contact,
      operation: () => contactService.delete(contact),
      successMessage: AppLocalizations.of(context)!.contactDeleted,
      errorPrefix: AppLocalizations.of(context)!.deleteContact,
    );
  }
  
  // 显示标签选择对话框
  Future<void> _showLabelSelectionDialog(Contact contact) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectTags),
        content: PublicSelectLabel(
          initialLabelId: contact.labelId,
          onLabelIdChanged: (labelId) async {
            final contactService = ref.read(contactServiceProvider);
            final updatedContact = contact.copyWith(labelId: labelId);
            
            // 使用通用操作处理方法
            await _handleContactOperation(
              contact: contact,
              operation: () => contactService.update(updatedContact),
              successMessage: AppLocalizations.of(context)!.tagsUpdated,
              errorPrefix: AppLocalizations.of(context)!.updateTags,
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
            child: Text(AppLocalizations.of(context)!.cancelButton),
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
      title: AppLocalizations.of(context)!.bulkDeleteContacts,
      content: AppLocalizations.of(context)!.batchDeleteContactsConfirm(_selectedContactIds.length),
      confirmText: AppLocalizations.of(context)!.deleteButton,
    );
    
    if (!confirmed) return;
    
    final contactService = ref.read(contactServiceProvider);
    
    // 获取选中的联系人
    final selectedContacts = _contacts.where(
      (contact) => _selectedContactIds.contains(contact.id)
    ).toList();
    
    // 使用通用操作处理方法
    await _handleContactOperation(
      contact: selectedContacts.first, // 只是为了满足参数要求，实际上不使用这个联系人
      operation: () => contactService.deleteAll(selectedContacts),
      successMessage: AppLocalizations.of(context)!.contactsDeleted(selectedContacts.length),
      errorPrefix: AppLocalizations.of(context)!.bulkDelete,
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
      future: ref.read(predefinedLabelServiceProvider)
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
          title: Text(contact.isFavorite ? AppLocalizations.of(context)!.removeFromFavorites : AppLocalizations.of(context)!.addToFavorites),
          contentPadding: EdgeInsets.zero,
        ),
      ),
      PopupMenuItem(
        value: 'label',
        child: Row(
          children: [
            const Icon(Icons.label_outline, color: Color(0xFFF5A623)),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.changeLabel),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            const Icon(Icons.edit, color: Color(0xFFF5A623)),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.edit),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            const Icon(Icons.delete, color: Colors.red),
            const SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.deleteButton, style: const TextStyle(color: Colors.red)),
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
        title: Text(_isMultiSelectMode ? AppLocalizations.of(context)!.selectedItems(_selectedContactIds.length) : AppLocalizations.of(context)!.contactsManagement),
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
                  title: Text(AppLocalizations.of(context)!.importExportContacts),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.file_upload),
                        title: Text(AppLocalizations.of(context)!.importContacts),
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
                                  final contactService = ref.read(contactServiceProvider);
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
                                      throw Exception(AppLocalizations.of(context)!.unsupportedFileFormat);
                              }
                              await _loadContacts(); // 刷新列表
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppLocalizations.of(context)!.importSuccess), backgroundColor: Colors.green),
                                );
                              }
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${AppLocalizations.of(context)!.importFailed}: $e'), backgroundColor: Colors.red),
                              );
                            }
                          }
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.file_download),
                        title: Text(AppLocalizations.of(context)!.exportContacts),
                        onTap: () async {
                          Navigator.pop(context);
                          try {
                            final contactService = ref.read(contactServiceProvider);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(AppLocalizations.of(context)!.selectExportFormat),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.description),
                                      title: Text(AppLocalizations.of(context)!.csvFormat),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final csvContent = await contactService.exportContactsToCsv();
                                        final directory = await getExternalStorageDirectory();
                                        final file = File('${directory!.path}/contacts.csv');
                                        await file.writeAsString(csvContent);

                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${AppLocalizations.of(context)!.fileSavedTo}: ${file.path}'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.code),
                                      title: Text(AppLocalizations.of(context)!.jsonFormat),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final jsonContent = await contactService.exportContactsToJson();
                                        final directory = await getExternalStorageDirectory();
                                        final file = File('${directory!.path}/contacts.json');
                                        await file.writeAsString(jsonContent);

                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${AppLocalizations.of(context)!.fileSavedTo}: ${file.path}'),
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
                                SnackBar(content: Text('${AppLocalizations.of(context)!.exportFailed}: $e'), backgroundColor: Colors.red),
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
            tooltip: AppLocalizations.of(context)!.importExportContactsTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadContacts,
            tooltip: AppLocalizations.of(context)!.refresh,
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
                        Text(
                          AppLocalizations.of(context)!.favoriteContacts,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _manageFavoriteContacts();
                          },
                          child: Text(AppLocalizations.of(context)!.manage),
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
                                      backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
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
                  hintText: AppLocalizations.of(context)!.searchContacts,
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
                      backgroundColor: const Color(0xFFF5A623).withOpacity(0.1),
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
                            title: Text(AppLocalizations.of(context)!.selectTags),
                            content: PublicSelectLabel(
                              initialLabelId: _selectedLabelId,
                              onLabelIdChanged: (labelId) async {
                                final labelService = ref.read(predefinedLabelServiceProvider);
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
                      child: Text(AppLocalizations.of(context)!.changeLabel),
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
              _contacts.isEmpty ? AppLocalizations.of(context)!.noContactsYet : AppLocalizations.of(context)!.noMatchingContactsFound,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            if (_contacts.isEmpty)
              ElevatedButton.icon(
                onPressed: _showAddContactDialog,
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.addContactButton),
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
                    color: const Color(0xFFF5A623).withOpacity(0.2),
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
                            final contactService = ref.read(contactServiceProvider);
                            await contactService.update(contact.copyWith(labelId: labelId));
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
                  tooltip: contact.isFavorite ? AppLocalizations.of(context)!.removeFromFavorites : AppLocalizations.of(context)!.addToFavorites,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFF5A623)),
                  onPressed: () => _showEditContactDialog(contact),
                  tooltip: AppLocalizations.of(context)!.edit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.deleteContact),
                        content: Text(AppLocalizations.of(context)!.deleteContactConfirm(contact.name)),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(AppLocalizations.of(context)!.cancelButton),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              try {
                                final contactService = ref.read(contactServiceProvider);
                                await contactService.deleteContact(PhoneNumber(contact.phoneNumbers.first));
                                await _loadContacts(); // 刷新列表
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(AppLocalizations.of(context)!.deleteSuccess), backgroundColor: Colors.green),
                                  );
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${AppLocalizations.of(context)!.deleteFailed}: $e'), backgroundColor: Colors.red),
                                  );
                                }
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.deleteButton),
                          ),
                        ],
                      ),
                    );
                  },
                  tooltip: AppLocalizations.of(context)!.deleteButton,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}