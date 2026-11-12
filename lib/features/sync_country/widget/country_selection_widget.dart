import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_country_sync_hub/pyro_phone_country_sync_hub.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CountrySelectionWidget extends ConsumerWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final hub = ref.watch(phoneCountrySyncControlCenterProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectCountry)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.countrySyncSettingsTitle),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await hub.downloadCountryData('US');
              },
              child: Text(l10n.selectCountry),
            ),
          ],
        ),
      ),
    );
  }
}
