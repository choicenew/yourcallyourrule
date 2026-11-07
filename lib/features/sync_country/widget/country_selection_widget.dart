import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_country_sync_protocol/pyro_phone_country_sync_protocol.dart';
import 'package:pyro_phone_country_sync_hub/pyro_phone_country_sync_hub.dart';
import 'package:pyro_phone_country_sync_ui/pyro_phone_country_sync_ui.dart' as sync_pkg_ui;
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CountrySelectionWidget extends ConsumerWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final payloads = ref.watch(phoneCountrySyncControlCenterProvider).payloads;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.countrySyncTitle)),
      body: ListView.builder(
        itemCount: payloads.length,
        itemBuilder: (context, index) {
          final payload = payloads[index];
          return sync_pkg_ui.PyroCountrySyncCardWidget(
            payload: payload,
            onTap: () => ref.read(phoneCountrySyncControlCenterProvider).syncCountry(payload),
          );
        },
      ),
    );
  }
}
