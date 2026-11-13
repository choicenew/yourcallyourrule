import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ContactsManagementPage extends ConsumerWidget {
  const ContactsManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return FutureBuilder<List<PhoneContactEntry>>(
      future: PhoneContactsControlCenter.instance.getAllContacts(),
      builder: (context, snapshot) {
        final itemsList = snapshot.data ?? [];
        return GenericListPage<PhoneContactEntry>(
          title: (l10n as dynamic)?.contactsManagement as String? ?? 'Contacts',
          items: itemsList,
          emptyText: (l10n as dynamic)?.noContactsYet as String? ?? 'No contacts yet',
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
