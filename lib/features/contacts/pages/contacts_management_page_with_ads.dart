import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/contacts/provider/contact_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/dialogs/contact_edit_dialog.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';

/// 通讯录管理页面 - 集成广告功能
/// 使用GenericListWithAdsPage组件减少重复代码并集成广告
class ContactsManagementPageWithAds extends ConsumerStatefulWidget {
  const ContactsManagementPageWithAds({super.key});

  @override
  ConsumerState<ContactsManagementPageWithAds> createState() => _ContactsManagementPageWithAdsState();
}

class _ContactsManagementPageWithAdsState extends ConsumerState<ContactsManagementPageWithAds> {
  bool _isLoading = true;
  List<Contact> _contacts = [];
  String? _selectedLabelId;
  String? _selectedLabelText;
  String _searchKeyword = '';
  bool _showOnlyFavorites = false; // 新增：收藏夹过滤状态
  
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

    // 收藏夹过滤
    if (_showOnlyFavorites) {
      filteredList = filteredList.where((contact) => contact.isFavorite).toList();
    }
    
    // 搜索过滤
    if (_searchKeyword.isNotEmpty) {
      filteredList = filteredList.where((contact) {
        return contact.name.toLowerCase().contains(_searchKeyword.toLowerCase()) ||
            contact.phoneNumbers.any((phone) => phone.contains(_searchKeyword));
      }).toList();
    }
    
    // 标签过滤
    if (_selectedLabelId != null) {
      filteredList = filteredList.where((contact) => contact.labelIds?.contains(_selectedLabelId) ?? false).toList();
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
                subtitle: Text(contact.phoneNumbers.join(', ')),
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

  void _onSearchChanged(String query) {
    setState(() {
      _searchKeyword = query;
    });
  }

  // 切换收藏状态
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
    
    ImageProvider? imageProvider;
    if (contact.avatar != null && contact.avatar!.isNotEmpty) {
      if (contact.avatar!.startsWith('http')) {
        imageProvider = NetworkImage(contact.avatar!);
      } else {
        imageProvider = AssetImage(contact.avatar!);
      }
    }

    if (imageProvider != null) {
      return CircleAvatar(
        backgroundImage: imageProvider,
        backgroundColor: const Color(0xFFF5A623).withValues(alpha: 0.2),
      );
    } else {
      return CircleAvatar(
        backgroundColor: const Color(0xFFF5A623).withValues(alpha: 0.2),
        child: Text(
          contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '#',
          style: const TextStyle(color: Color(0xFFF5A623)),
        ),
      );
    }
  }
  
  // 构建标签显示组件
  Widget _buildLabelChips(List<String>? labelIds) {
    if (labelIds == null || labelIds.isEmpty) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 4.0,
      runSpacing: 0.0,
      children: labelIds.map((id) => _buildSingleLabelChip(id)).toList(),
    );
  }

  Widget _buildSingleLabelChip(String labelId) {
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
              color: const Color(0xFFF5A623).withValues(alpha: 0.1),
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
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: _buildContactAvatar(contact, isCheckbox: _isMultiSelectMode),
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.phoneNumbers.join(', ')),
            _buildLabelChips(contact.labelIds),
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

  // 导入导出联系人对话框
  void _showImportExportDialog() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2, // 联系人页面标签索引
        onTap: (index) => BottomNavigationHandler.handleNavigation(context, index),
      ),
      body: GenericListWithAdsPage<Contact>(
      title: _isMultiSelectMode 
        ? AppLocalizations.of(context)!.selectedItems(_selectedContactIds.length) 
        : AppLocalizations.of(context)!.contactsManagement,
      items: _filteredContacts,
      itemBuilder: (context, contact) => _buildContactCard(contact),
      adBuilder: () => GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
      adInterval: 3,
      emptyText: _contacts.isEmpty 
        ? AppLocalizations.of(context)!.noContactsYet 
        : AppLocalizations.of(context)!.noMatchingContactsFound,
      emptyIcon: Icons.contacts,
      themeColor: const Color(0xFFF5A623),
      isLoading: _isLoading,
      onRefresh: _loadContacts,
      onAdd: _showAddContactDialog,
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedContactIds,
      onToggleMultiSelectMode: _toggleMultiSelectMode,
      onDeleteSelected: _deleteSelectedContacts,
      getItemId: (contact) => contact.id,
      onToggleItemSelection: _toggleContactSelection,
      infoCard: _buildHeaderContent(),
      onSearchChanged: _onSearchChanged,
      searchHintText: AppLocalizations.of(context)!.searchContacts,
      customActions: [
        IconButton(
          icon: Icon(
            _showOnlyFavorites ? Icons.star : Icons.star_border,
            color: _showOnlyFavorites ? const Color(0xFFF5A623) : null,
          ),
          onPressed: () {
            setState(() {
              _showOnlyFavorites = !_showOnlyFavorites;
            });
          },
          tooltip: _showOnlyFavorites 
              ? AppLocalizations.of(context)!.showAllContacts 
              : AppLocalizations.of(context)!.showFavorites,
        ),
        IconButton(
          icon: const Icon(Icons.import_export),
          onPressed: _showImportExportDialog,
          tooltip: AppLocalizations.of(context)!.importExportContactsTooltip,
        ),
      ],
    )
    );
  }

  Widget _buildHeaderContent() {
    return Column(
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
                                  backgroundColor: const Color(0xFFF5A623).withValues(alpha: 0.1),
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

        // 标签筛选
        if (_selectedLabelText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Chip(
                  label: Text(_selectedLabelText!),
                  backgroundColor: const Color(0xFFF5A623).withValues(alpha: 0.1),
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
      ],
    );
    
  }
}