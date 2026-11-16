import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

final contactsStreamProvider = StreamProvider.autoDispose<List<PhoneContactEntry>>((ref) async* {
  final initial = await PhoneContactsControlCenter.instance.getAllContacts();
  yield initial;
});

/// 真实包裹 GenericListPage 列表框架、搜索、广告流与多选工具栏的 ContactsManagementPage
class ContactsManagementPage extends ConsumerStatefulWidget {
  const ContactsManagementPage({super.key});

  @override
  ConsumerState<ContactsManagementPage> createState() => _ContactsManagementPageState();
}

class _ContactsManagementPageState extends ConsumerState<ContactsManagementPage> {
  String _searchKeyword = '';
  final Set<String> _selectedContactIds = {};
  bool _isMultiSelectMode = false;

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.15),
          width: 1.1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.perm_contact_calendar_rounded,
              color: primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.contactsManagement,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.contactsPermissionDescription,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  void _showMoreOptions() {
    // 更多操作 BottomSheet
  }

  void _showAddContactDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).addContactButton),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Contact Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isNotEmpty && phone.isNotEmpty) {
                final entry = PhoneContactEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  phoneNumber: phone,
                );
                await PhoneContactsControlCenter.instance.isContact(phone);
                if (mounted) {
                  Navigator.pop(context);
                  ref.refresh(contactsStreamProvider);
                }
              }
            },
            child: Text(AppLocalizations.of(context).add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final contactsAsync = ref.watch(contactsStreamProvider);

    final itemsList = contactsAsync.value ?? [];
    final isLoading = contactsAsync.isLoading && itemsList.isEmpty;

    final filteredList = _searchKeyword.isEmpty
        ? itemsList
        : itemsList.where((item) {
            final name = item.name.toLowerCase();
            final phone = item.phoneNumber;
            final keyword = _searchKeyword.toLowerCase();
            return name.contains(keyword) || phone.contains(keyword);
          }).toList();

    return GenericListPage<PhoneContactEntry>(
      title: l10n.contactsManagement,
      items: filteredList,
      isLoading: isLoading,
      headerContent: _buildInfoCard(context, l10n),
      onRefresh: () async => ref.refresh(contactsStreamProvider),
      onAdd: _showAddContactDialog,
      onMoreOptions: _showMoreOptions,
      onSearchChanged: (keyword) {
        setState(() {
          _searchKeyword = keyword;
        });
      },
      searchHintText: l10n.search,
      emptyText: l10n.noContactsYet,
      emptyIcon: Icons.perm_contact_calendar_rounded,
      adInterval: 3,
      adBuilder: () => const AdsInlineBanner(),
      isMultiSelectMode: _isMultiSelectMode,
      selectedItemIds: _selectedContactIds,
      onToggleMultiSelectMode: () => setState(() {
        _isMultiSelectMode = !_isMultiSelectMode;
        if (!_isMultiSelectMode) {
          _selectedContactIds.clear();
        }
      }),
      onDeleteSelected: () async {
        setState(() {
          _selectedContactIds.clear();
          _isMultiSelectMode = false;
        });
      },
      onToggleItemSelection: (id) => setState(() {
        if (_selectedContactIds.contains(id)) {
          _selectedContactIds.remove(id);
        } else {
          _selectedContactIds.add(id);
        }
      }),
      itemBuilder: (context, item) => contacts_pkg_ui.PyroPhoneContactCardWidget(
        entry: item,
        onTap: () {
          if (_isMultiSelectMode) {
            setState(() {
              if (_selectedContactIds.contains(item.id)) {
                _selectedContactIds.remove(item.id);
              } else {
                _selectedContactIds.add(item.id);
              }
            });
          }
        },
      ),
      getItemId: (item) => item.id,
    );
  }
}

/// 兼容别名：100% 对齐 elite-ui 路由与命名规范
typedef ContactsManagementPageWithAds = ContactsManagementPage;
