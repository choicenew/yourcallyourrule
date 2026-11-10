import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_contacts_hub/pyro_phone_contacts_hub.dart';
import 'package:pyro_phone_contacts_ui/pyro_phone_contacts_ui.dart' as contacts_pkg_ui;
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:yourcallyourrule/features/common/widgets/generic_list_with_ads_page.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 联系人管理页面
class ContactsManagementPage extends ConsumerWidget {
  const ContactsManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return FutureBuilder<List<PhoneContactEntry>>(
      future: PhoneContactsControlCenter.instance.getAllContacts(),
      builder: (context, snapshot) {
        final contacts = snapshot.data ?? [];
        return GenericListWithAdsPage<PhoneContactEntry>(
          title: l10n.contact,
          items: contacts,
          emptyText: l10n.noData,
          adInterval: 3,
          adBuilder: () => const AdsInlineBanner(),
          itemBuilder: (context, contact) => contacts_pkg_ui.PyroPhoneContactCardWidget(
            entry: contact,
            onTap: () {},
          ),
          getItemId: (contact) => contact.id,
        );
      },
    );
  }
}
