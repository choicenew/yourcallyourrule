import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/common/widgets/bottom_navigation.dart';
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
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.select_all_rounded),
              title: Text(l10n.bulkDelete),
              onTap: () {
                Navigator.pop(ctx);
                setState(() {
                  _isMultiSelectMode = true;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh_rounded),
              title: Text(l10n.refresh),
              onTap: () {
                Navigator.pop(ctx);
                ref.invalidate(contactsStreamProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditContactDialog(PhoneContactEntry item) {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController(text: item.name);
    final phoneController = TextEditingController(text: item.phoneNumber);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.editContact),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.contactNameLabel),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: l10n.phoneNumberLabel),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelButton),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isNotEmpty && phone.isNotEmpty) {
                final driver = PhoneContactsControlCenter.instance.readerDriver;
                try {
                  (driver as dynamic)?.addContact(PhoneContactEntry(
                    id: item.id,
                    name: name,
                    phoneNumber: phone,
                  ));
                } catch (_) {}
                if (mounted) {
                  Navigator.pop(ctx);
                  ref.invalidate(contactsStreamProvider);
                }
              }
            },
            child: Text(l10n.saveButton),
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog() {
    final l10n = AppLocalizations.of(context);
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addContactButton),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.contactNameLabel),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: l10n.phoneNumberLabel),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancelButton),
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
                final driver = PhoneContactsControlCenter.instance.readerDriver;
                try {
                  (driver as dynamic)?.addContact(entry);
                } catch (_) {}
                if (mounted) {
                  Navigator.pop(context);
                  ref.invalidate(contactsStreamProvider);
                }
              }
            },
            child: Text(l10n.add),
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

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigation(
        currentIndex: 2,
        onTap: (index) => AppRouter.navigateToTab(context, index),
      ),
      body: GenericListPage<PhoneContactEntry>(
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
          } else {
            _showEditContactDialog(item);
          }
        },
      ),
      getItemId: (item) => item.id,
    ),
    );
  }
}
