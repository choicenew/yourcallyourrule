import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 真实包裹 GenericListPage 列表框架、搜索、广告流与多选工具栏的 ContactsManagementPage
class ContactsManagementPage extends ConsumerStatefulWidget {
  const ContactsManagementPage({super.key});

  @override
  ConsumerState<ContactsManagementPage> createState() => _ContactsManagementPageState();
}

class _ContactsManagementPageState extends ConsumerState<ContactsManagementPage> {
  late Future<List<PhoneContactEntry>> _contactsFuture;
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    _contactsFuture = PhoneContactsControlCenter.instance.getAllContacts();
  }

  void _refreshContacts() {
    setState(() {
      _contactsFuture = PhoneContactsControlCenter.instance.getAllContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<PhoneContactEntry>>(
      future: _contactsFuture,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final itemsList = snapshot.data ?? [];
        final filteredList = _searchKeyword.isEmpty
            ? itemsList
            : itemsList.where((item) {
                final name = (item.displayName ?? '').toLowerCase();
                final phone = item.phoneNumber ?? '';
                final keyword = _searchKeyword.toLowerCase();
                return name.contains(keyword) || phone.contains(keyword);
              }).toList();

        return GenericListPage<PhoneContactEntry>(
          title: l10n.contactsManagement,
          items: filteredList,
          isLoading: isLoading,
          onRefresh: _refreshContacts,
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
      },
    );
  }
}
