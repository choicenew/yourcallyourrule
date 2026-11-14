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
        return GenericListPage<PhoneContactEntry>(
          title: l10n.contactsManagement,
          items: itemsList,
          isLoading: isLoading,
          onRefresh: _refreshContacts,
          emptyText: l10n.noContactsYet,
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
