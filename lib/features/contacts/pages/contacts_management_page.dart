import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class ContactsManagementPage extends ConsumerWidget {
  const ContactsManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final contacts = ref.watch(phoneContactsControlCenterProvider).contacts;

    return GenericListWithAdsPage<PhoneContactEntry>(
      title: l10n.contactsManagementTitle,
      items: contacts,
      emptyText: l10n.noContactsFound,
      adInterval: 3,
      adBuilder: () => const InlineAdaptiveAd(),
      itemBuilder: (context, contact) => contacts_pkg_ui.PyroPhoneContactCardWidget(
        entry: contact,
        onTap: () => ref.read(phoneContactsControlCenterProvider).showContactDetail(contact),
      ),
      getItemId: (contact) => contact.id,
      onAdd: () => ref.read(phoneContactsControlCenterProvider).openAddContactDialog(context),
      onSearchChanged: (query) => ref.read(phoneContactsControlCenterProvider).searchContacts(query),
      onDeleteSelected: () => ref.read(phoneContactsControlCenterProvider).deleteSelectedContacts(),
    );
  }
}
