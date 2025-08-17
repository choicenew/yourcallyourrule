import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:world_countries/world_countries.dart';
import 'package:yourcallyourrule/features/sync_country/provider/country_selection_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// A widget that allows users to select countries for data synchronization.
class CountrySelectionWidget extends ConsumerWidget {
  const CountrySelectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountries = ref.watch(selectedCountriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.databaseSyncTitle),
      ),
      body: selectedCountries.when(
        data: (codes) {
          final chosenCountries = WorldCountry.list
              .where((country) => codes.contains(country.idd.phoneCode()))
              .toList();

          return CountryPicker(
            chosen: chosenCountries,
            onSelect: (country) {
              final phoneCode = country.idd.phoneCode();
              if (codes.contains(phoneCode)) {
                ref
                    .read(selectedCountriesProvider.notifier)
                    .removeCountry(phoneCode);
              } else {
                ref
                    .read(selectedCountriesProvider.notifier)
                    .addCountry(phoneCode);
              }
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}