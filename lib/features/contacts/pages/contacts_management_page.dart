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
      onRefresh: () async => ref.refresh(contactsStreamProvider),
      onAdd: _showAddContactDialog,
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
      itemBuilder: (context, item) => contacts_pkg_ui.PyroPhoneContactCardWidget(
        entry: item,
        onTap: () {},
      ),
      getItemId: (item) => item.id,
    );
  }
}
